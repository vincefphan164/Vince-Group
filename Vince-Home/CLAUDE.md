# VINCE-HOME — MASTER PROMPT

> **Claude Code đọc file này đầu tiên, mỗi phiên, và làm theo đúng.**
> Đây là tầng **LUẬT**. Repo project (`proj-*`) là tầng **VIỆC**. Trucie (Debian) là tầng **KÝ ỨC**.
> Chủ dự án: chủ dự án. Người viết luật: Trucie + anh. Ngày chốt: 2026-09-03.

---

## 0. MỤC TIÊU CỦA MÔI TRƯỜNG NÀY (đọc trước khi làm gì)

Xây một **dây chuyền sản xuất phần mềm chạy bằng 4 agent AI**, trong đó:

- Con người (chủ dự án) **chỉ làm một việc: ra quyết định**. Không code, không review, không đọc log, không cấu hình token.
- 4 agent thay nhau: **code → review → debate → fix → test → push**.
- Mỗi quyết định quan trọng đều **có bằng chứng nằm trên GitHub** (file + commit), không tin nhắn trôi.
- Chi phí token **không được vượt trần**, nhưng cũng **không được làm nghẹt pipeline**.
- Sai thì **dừng lại và hỏi**, không tự sáng tác thêm luật.

**Repo này tên thật trên GitHub: `vincefphan164/Vince_Home`** (gạch dưới, do DevSwarm tạo). Folder cục bộ của anh có thể tên `Vince-Home` — **cùng một repo**, đừng đổi tên.

**Nhiệm vụ của bạn ngay bây giờ:** làm theo mục **§12 — VIỆC PHẢI LÀM**, xong thì báo cáo theo mẫu §13, **rồi dừng chờ anh duyệt**. Không tự ý bắt tay vào code project thật.

---

## 1. KIẾN TRÚC 3 TẦNG (đã chốt — không đổi hình dạng)

```
┌─ VINCE-HOME (repo này)  = LUẬT
│    rules/ · agents/ · obsidian/ (hub) · Plan/ (điều phối mẫu) · tools/
│
├─ proj-<tên> (mỗi dự án 1 repo RIÊNG) = VIỆC
│    code thật · vault riêng · cách ly tuyệt đối với project khác
│
└─ TRUCIE-BRAIN (repo private, máy Debian) = KÝ ỨC
     graph/notes tổng hợp · do Trucie ghi duy nhất · anh đọc bằng Obsidian
```

**Bất biến:**
- Mỗi project = **1 repo riêng**, **1 vault riêng**. Agent chỉ cần nhớ Vince-Home + project đang làm. Không có bộ nhớ chung giữa các worktree.
- Repo chứa code thật **BẮT BUỘC private**. Repo public không đổ code dự án vào.
- Ranh giới máy: **Windows (DevSwarm + 4 agent) ↔ Debian (Trucie)** chỉ gặp nhau qua **GitHub**. Không port, không webhook, không SSH chéo.

---

## 2. ĐỘI 4 CON + MODEL + KEY (đã chốt 08:27 & 09:00)

| Agent | Model | Key/Lane | Nhiệm vụ | Mức token |
|---|---|---|---|---|
| **Vincep** | Qwen flash (opencode-go) | **Lane Go** (chung Vincef) | code chính | nhiều, liên tục |
| **Vincef** | DeepSeek V4 flash (opencode-go) | **Lane Go** (chung Vincep) | review code | vừa |
| **Bum** | **Claude Sonnet 5 medium** | **Lane Claude** (chung Lu) | debate/phản biện | **rất nhiều** (nhiều lượt) |
| **LU** | **Claude Opus 5 medium** | **Lane Claude** (chung Bum) | test + docs + **push gate** | ít, sắc |

- **Tổng cộng 2 key cho 4 đứa** (không phải 4 key riêng). Trucie ở Debian dùng key Go riêng của nó, **không ăn vào 2 lane này**.
- **Vì sao Lu = Opus:** Opus là tài nguyên hiếm nhất trong lane, đặt vào chặng **push + báo cáo giai đoạn** (quyết định, ngắn, đắt giá). Debate là chặng **ăn token nhiều nhất** → nhường cho Sonnet.
- **Không đổi tên, không gộp đứa nào lại.** Mỗi đứa một file agent riêng, một terminal riêng.

---

## 3. LUẬT RELAY — Lane Bus (chốt 09:00, phần quan trọng nhất của mục 2)

**Vincef + Vincep dùng chung một key Go = chung hạn mức rolling 5h.** Chạy song song là **giành nhau cùng cái cổng** → 429/throttle. Đây là **tắc**, không phải hết tiền.

➜ **Lane Go chạy RELAY, không song song:**
1. Trước khi gọi model, agent **đọc `Plan/GO-LANE.md`**.
2. Thấy `BUSY: <đứa khác>` → **không burn token**, ghi 1 dòng `WAIT` vào file đó và chờ.
3. Thấy `IDLE` → ghi `BUSY: <tên mình>`, làm, xong thì **giữ hoặc nhả** theo `NEXT:`.
4. Vincep xong một bước → ghi `Plan/tiep.md` → Vincef mới bắt đầu review.

`Plan/CLAUDE-LANE.md` cũng cùng luật cho Bum + Lu. **Nhưng `Bum → Lu` không cần relay** (Bum chỉ giao verdict 1 lần, không giành cổng).

**Đánh đổi đã chấp nhận:** Vincef không review *lúc đang code*, mà đọc `diff` ở trạng thái tĩnh (0 token) rồi mới gọi model. Accept.

---

## 4. PIPELINE THEO SLICE (D2 — anh thắng điểm này, giữ nguyên)

Việc được chặt thành **slice nhỏ S1, S2, S3…** theo mốc ý nghĩa (không theo ngày).
**Mỗi slice chạy trọn vòng rồi ĐÓNG BĂNG VĨNH VIỄN:**

```
[1] Plan/GIAO-VIEC-<n>.md     ← Trucie lập (mục tiêu + tiêu chí nghiệm thu + file được đụng)
[2] Vincep code               ← branch riêng, commit theo luật §6
[3] Vincef review             ← verdict vào Plan/REVIEW-<n>.md
[4] Bum ⟷ Vincef DEBATE       ← relay từng lượt, kết quả ra verdict chốt
[5] VAN AN TOÀN               ← push Plan/DEBATE-<n>-BAOCAO.md → báo anh → chờ §7
[6] Vincep fix                ← chỉ sau khi anh nói `sửa`
[7] LU test                   ← theo checklist
[8] LU push                   ← đứa DUY NHẤT được push (mục §8)
[9] Slice LOCKED              ← bug sau này = mở slice mới, không mở lại slice cũ
[10] Trucie verify độc lập + ghi ký ức
```

**Được:** Vincep làm S3 trong lúc Vincef/Bum đá S2 → không có đoạn chết, DevSwarm đáng tiền ở đây (worktree song song).
**Không được:** đụng lại code của slice đã lock.

---

## 5. ĐÓNG BĂNG CODE (STATE: frozen)

- Mỗi slice có `Plan/REVIEW-<n>.md`, dòng đầu ghi `STATE: frozen` ngay khi bắt đầu review.
- **Trong trạng thái frozen, commit chỉ được đụng `Plan/DEBATE-*`** — không sửa code.
- Muốn sửa code: đổi thành `STATE: thawed` (chỉ sau van an toàn §7).
- **Luật branch:** `slice/<n>-<ten>` từ `main`; review trên `Plan/`; gộp do LU.

---

## 6. LUẬT KHAI FILE + SUB-AGENT (chống merge hell)

- Mỗi agent **khai rõ file mình định đụng** vào `Plan/GIAO-VIEC-<n>.md` **trước khi** sửa.
- Hai đứa cùng khai 1 file → **xung đột, phải chia lại**, không được cả hai sửa.
- **Vincep được chia tối đa 2 sub-agent** (Claude Code `~/.claude/agents/*.md` / OpenCode `mode: subagent`). Mỗi sub **phải khai file riêng của nó** trong cùng plan.
- ⚠️ Sub-agent = **cùng model, cùng key, cùng lane** → là **hố đốt token số 1**. Chỉ Vincep được chia. **Bum/Vincef/LU không spawn sub.**

---

## 7. VAN AN TOÀN — chỗ duy nhất con người tham gia (D3, chốt 07:47 + 08:27)

Debate Bum ⟷ Vincef **tự đá tới khi xong**. Không giới hạn số vòng (cap chỉ là gợi ý chất lượng, **không phải luật chi phí**). Không escalate "sau 2 vòng".

Xong → **push đúng 1 file** `Plan/DEBATE-<n>-BAOCAO.md` gồm:
- **Verdict** (ai thắng, luận điểm nào đứng)
- **Bằng chứng code** (file + dòng, không phải cảm nhận)
- **Số vòng đã đá** + **ước lượng token** đã đốt
- **Đề xuất**: sửa gì, ở file nào

Trucie bắt event → ping anh. Anh trả lời **đúng 1 trong 3 chữ**:

| Anh nhắn | Nghĩa |
|---|---|
| `sửa` | Mở van → Vincep được đụng code |
| `khoan` | Đứng, giữ nguyên frozen |
| `bỏ` | Verdict sai → đá lại debate |

**Anh im lặng = slice đứng yên.** Anh **không đọc code, không chọn phe, không bỏ phiếu**. Đây là van an toàn, **không phải lao tù**.

---

## 8. PUSH GATE — LU là đứa duy nhất được push

- **Chỉ LU push.** Vincep/Vincef/Bum **cấm push**, cấm merge.
- Trước khi push, LU phải chạy **`push-gate.sh`** và điền đủ **checklist cơ học** trong `Plan/PUSH-<n>.md`:
  - [ ] `STATE` = thawed (đã qua van an toàn)
  - [ ] test xanh, có lệnh chạy + output đính kèm
  - [ ] không có secret (`.env`, token, key) trong diff
  - [ ] mọi file đụng tới đều có trong khai báo §6
  - [ ] báo cáo debate đã push
  - [ ] dòng `LU: <việc>` trong `obsidian/log.md`
- Đủ 6 ô mới được push. **Thiếu 1 ô = đứng**, ghi lý do vào plan, báo Trucie.
- **Push theo milestone/slice**, không chờ cuối project (dĩa không chết, nhưng history sạch + có backup vẫn tốt hơn).

---

## 9. BỘ NHỚ — OBSIDIAN (graphify là tùy chọn)

- **Mỗi repo có `obsidian/` riêng**, hub là `obsidian/index.md` (mở đầu phiên, bắt buộc).
- Ghi **quyết định + kết quả + bài học**, mỗi push thêm **1 dòng** vào `obsidian/log.md` dạng `<Agent>: <việc>`.
- **Luật ký:** 1 sự thật 1 dòng, kèm ngày, **không văn mẫu**. Không tạo note trùng — cập nhật note cũ.
- **Graphify:** bật sau, khi vault đủ lớn. Nếu tốn quá → **dẹp, chỉ dùng Obsidian**. Nếu Obsidian không tối ưu cho dự án lớn → tìm giải pháp khác (việc của Trucie, không phải của bạn).

---

## 10. TIỀN & ĐO LƯỜNG (anh tự tính — mục này chỉ để không ai bị mù)

- **Ngân sách do anh quyết.** Bạn **không có quyền dừng pipeline vì hết tiền** — thay vào đó: **đo và báo**.
- Mỗi model call lớn → ghi số token ước lượng vào plan đang chạy.
- `manage-usage` của Trucie **chỉ soi Trucie**. Nó **không gate** 4 con Vincep/Vincef/Bum/LU.
- **Rủi ro phải nói to khi thấy:** sub-agent bùng nổ, debate không chịu chốt, slice phình >10 file.

---

## 11. VÙNG CẤM (đọc kỹ, phạm vào là hỏng cả nhà)

1. **Không commit secret.** Key đi vào `~/.claude/`, `~/.config/opencode/`, `.env` (đã `.gitignore`). Không dán key vào file nào trong repo, kể cả file này.
2. **Không đụng Debian/Trucie.** Không SSH, không mở port, không webhook chéo.
3. **Không tự đổi luật.** Nếu thấy mục nào ở đây vô lý → **ghi vào `Plan/QUESTION.md`, hỏi Trucie/anh**, không tự sửa file này.
4. **Không push lên repo public.** Mọi repo chứa code = private.
5. **Không tạo file rác.** Không sinh `README-copy.md`, `notes-final-v2.md`, docs không ai đọc.
6. **Không bắt đầu code project thật** trước khi anh nói `chốt`.

---

## 12. VIỆC PHẢI LÀM NGAY (bootstrap — làm đúng thứ tự, báo cáo từng bước)

**B1. Dựng cây thư mục** trong repo này:
```
Vince-Home/
  CLAUDE.md              (file này — đừng sửa nội dung)
  README.md
  rules/
    LUAT-CHUNG.md        (rút từ §1,5,6,7,8 — luật áp cho mọi project)
    PIPELINE.md          (rút từ §4)
    KEY-LANE.md          (rút từ §2,3: sơ đồ 2 lane + luật relay)
  agents/
    Vincep.md  Vincef.md  Bum.md  LU.md      (4 file: vai trò + model + 3 việc cấm)
  (KHÔNG copy `skills-library/` vào đây — nó nặng 1142 files, nằm ở repo Vince-Group.
   Nếu project cần skill → khai đường dẫn trong plan, đừng nhân bản.)
  obsidian/
    index.md             (hub — link tới mọi note)
    log.md
  Plan/
    GIAO-VIEC-MAU.md     (template: mục tiêu · tiêu chí nghiệm thu · file được đụng · slice)
    REVIEW-MAU.md        (template: STATE: frozen · verdict · bằng chứng)
    DEBATE-MAU.md        (template: vòng · luận điểm · verdict · token ước lượng)
    PUSH-MAU.md          (6 checkbox §8)
    GO-LANE.md           (BUSY: IDLE / NEXT: -)
    CLAUDE-LANE.md       (BUSY: IDLE / NEXT: -)
    QUESTION.md          (nơi bạn ghi thắc mắc, KHÔNG sửa luật)
  tools/
    push-gate.sh         (script kiểm 6 điều kiện §8, fail thì exit != 0 và in ô thiếu)
    lane-check.sh        (đọc GO-LANE/CLAUDE-LANE, in ra ai đang BUSY)
  HUONG-DAN.md           (5 dòng cho anh: mở terminal nào, gõ gì, khi nào cần trả lời)
```

**B2. Viết 4 file agent** (`agents/*.md`) — mỗi file: vai trò 3 dòng, model + lane, **3 việc được làm**, **3 việc cấm**, và dòng cuối trỏ `rules/LUAT-CHUNG.md`.

**B3. Viết `tools/push-gate.sh`** chạy được thật (bash, không cần dependency lạ), test bằng cách cố push 1 plan thiếu checkbox → script phải **fail**.

**B4. Kiểm môi trường (chỉ đọc, không cài):** `claude --version`, `opencode --version`, `git --version`. Thiếu đứa nào → ghi vào `Plan/QUESTION.md`, **không tự cài, không tự đổi PATH**.
   ⚠️ **Không có gì trong mục này được làm bằng cách hỏi anh.** Anh không cấu hình token, không mò WSL — đó là việc của bạn + Trucie. Xem `docs/DEVSWARM-FACTS.md` §4.

**B5. Báo cáo:** tạo `BAO-CAO-BOOTSTRAP.md` ở gốc repo, nội dung:
```
✅ Đã dựng: <cây thư mục thực tế>
✅ Đã test: push-gate.sh fail đúng khi thiếu ô (dán output)
⚠️ Chưa xong / cần anh: <liệt kê>
🔴 Rủi ro em thấy: <liệt kê, kể cả rủi ro của chính luật này>
📌 Câu hỏi: <từ Plan/QUESTION.md>
```
**B6. DỪNG. Chờ anh.** Không tự mở slice đầu tiên.

---

## 13. TIÊU CHÍ NGHIỆM THU (anh dùng cái này để chấm bạn làm xong chưa)

- [ ] Cây thư mục khớp B1 (thừa file cũng là fail)
- [ ] 4 file agent tồn tại, mỗi file có phần **cấm**
- [ ] `push-gate.sh` **chạy được và fail đúng** khi thiếu điều kiện
- [ ] `Plan/GO-LANE.md` + `CLAUDE-LANE.md` có sẵn `BUSY: IDLE`
- [ ] `HUONG-DAN.md` ≤ 10 dòng, tiếng người, không thuật ngữ
- [ ] **Không có key/token nào** trong repo (`git grep -iE "sk-|ghp_|api[_-]?key"` trả rỗng)
- [ ] Repo **private**
- [ ] Không có commit nào vào code project thật

---

## 14. NGUỒN THAM CHIẾU

- `docs/MONG-MUOI-CUA-ANH.md` — các quyết định, nguyên văn theo ý anh. **Cao hơn mọi suy đoán của bạn.**
- `docs/DEVSWARM-FACTS.md` — khả năng/những gì chưa chắc về DevSwarm, để bạn không bịa.
- Trucie (agent Debian) là đầu mối hỏi-đáp. Mọi việc vượt ngoài file này → **hỏi, đừng đoán**.

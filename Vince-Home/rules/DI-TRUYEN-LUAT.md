# DI TRUYỀN LUẬT — project riêng inherit luật Vince-Home thế nào

> Câu hỏi gốc (anh, 11:20): "tạo project riêng thì làm sao nó ôm luật Vince-Home ra ngoài merge với luật riêng của project?"
> Trả lời bằng **cơ chế có thật trong docs của 2 CLI**, không phải bằng lời hứa.

## 1. THANG ƯU TIÊN (đứa dưới thắng đứa trên khi mâu thuẫn, trừ L0)

```
L0  BẤT BIẾN      : an toàn máy+mạng của anh · không đụng Windows từ Debian ·
                    repo code thật = private · push-gate · không secret
                    → KHÔNG luật project nào được ghi đè. Chấm hết.
L1  LUẬT CHUNG    : Vince-Home/rules/LUAT-CHUNG.md (L1..L8)
L2  LUẬT PROJECT  : <proj>/PLAN-LUAT.md — slice to hơn, nhịp đăng khác, agent ít hơn...
L3  TASK          : Plan/GIAO-VIEC-<n>.md của riêng slice đó
```
Project được phép **làm chặt thêm** hoặc **đổi chi tiết vận hành** (số slice, model, nhịp), **không được** mở khóa L0/L1-cứng (ví dụ: không project nào được cho Vincep push).

## 2. CƠ CHẾ THẬT — Claude Code (Bum + LU)

Docs `code.claude.com/docs/en/memory` xác nhận 2 thứ:
1. **`CLAUDE.md` được nạp từ thư mục hiện tại NGƯỢC lên tận gốc đĩa** ("every directory above it"), tất cả **concatenate** (gộp, không thay thế), file gần cwd đọc SAU → đọc cuối thắng.
2. **Import `@path`**: `CLAUDE.md` có thể nhập file khác bằng `@đường/dẫn`, **relative hoặc absolute đều được**, nạp lúc launch, recursive tối đa 4 tầng.

➜ **Đường nối Vince-Home vào mọi project = 1 dòng import.** Hai cách, chọn 1:

**Cách A (khuyến nghị — tự động cho MỌI project, khai báo 1 lần):** đặt vào `~/.claude/CLAUDE.md` (user-scope, mọi dự án đều nạp):
```
@C:/dev/Vince-Home/Vince-Home/rules/LUAT-CHUNG.md
```
Docs ghi rõ: import từ file **user-scope** KHÔNG bị hỏi duyệt (chỉ project-scope import ra ngoài cwd mới hỏi lần đầu). Đổi 1 file luật → **mọi project ăn ngay**, không phải sửa từng repo.

**Cách B (per-project, khi muốn tách ai đó khỏi luật chung):** trong `CLAUDE.md` gốc project:
```
@../Vince-Home/Vince-Home/rules/LUAT-CHUNG.md      # nếu 2 repo là sibling
```
⚠️ import trỏ RA NGOÀI cwd → lần đầu Claude Code hỏi duyệt 1 câu ("External imports" — có thật, đừng tưởng em bày). Đồng ý 1 lần/worktree.

**Ghép luật riêng project:** cứ thêm nội dung vào `CLAUDE.md` của project SAU dòng import → nó được đọc cuối → thắng phần chi tiết. Đầu file project nhắc lại 1 dòng: `L0 của Vince-Home vẫn nguyên hiệu lực` để chống "im lặng override".

## 3. CƠ CHẾ THẬT — OpenCode (Vincep + Vincef)

Docs `opencode.ai/docs/config` xác nhận: **config các tầng MERGED, không replace**; sau ghi đè TRƯỚC theo đúng key xung đột; `~/.config/opencode/agents/` (global) và `.opencode/agents/` (project) **cùng được nạp**.

```
global  ~/.config/opencode/opencode.json      ← model/permission nền của cả máy
project <proj>/opencode.json                  ← override key riêng của project
global  ~/.config/opencode/agents/*.md        ← Vincep.md/Vincef.md đặt đây = mọi project thấy
project <proj>/.opencode/agents/*.md          ← bản dev riêng nếu cần thử nghiệm
```
➜ **Di chuyển 2 file `Vincep.md`/`Vincef.md` lên global 1 lần** → mọi project OpenCode có sẵn 2 con, không copy. Project nào muốn khác → đặt file trùng tên ở `.opencode/agents/` của nó, tầng project thắng.
➜ `skills.paths` cũng vậy: ghi ở global config → mọi project dùng chung 1 `skills-library/`, khỏi junction từng repo.

## 4. ROUTING MẶC ĐỊNH (DevSwarm chọn agent per workspace)
- Mỗi workspace = 1 worktree = 1 cwd → Claude Code đọc `.claude/settings.json` **của worktree đó** → `{"agent":"Bum"}` hoặc `{"agent":"LU"}` không đá nhau giữa 2 workspace cùng repo. `tools/set-default-agent.ps1` lo phần ghi file này.
- OpenCode: `Tab` cycle primary agent; hoặc mỗi workspace trỏ `opencode.json` riêng.

## 5. SAMPLE — project mới cần gì để "hiểu luật"?

**Nếu đã làm Cách A: KHÔNG CẦN GÌ CẢ.** Mở project bất kỳ, Bum/LU đã mang luật Vince-Home + luật riêng project cộng dồn.

File mẫu cho project mới: xem `Vince-Home/PROJ-MAU/` — 3 file: `CLAUDE.md` (kèm dòng import + chỗ ghi luật riêng), `opencode.json` (kèm comment), `obsidian/index.md`. Copy vào repo project là xong bộ khung.

## 6. RỦI RO CỦA CHÍNH CƠ CHẾ NÀY (ghi, không giấu)
1. Import là **concatenate, không enforce** — Claude "treats them as context". Luật dài → model có thể quên giữa phiên. Vũ khí thật khi cần CỨNG: **PreToolUse hook** chặn tool (docs ghi rõ: "To block an action regardless of what Claude decides, use a PreToolUse hook"). Cần chặn push tuyệt đối cho Vincep? → hook, không phải markdown. Ghi vào TODO khi dựng slice 0.
2. Luật chung phình to = **mọi project đều nạp**. Giữ LUAT-CHUNG ≤ ~150 dòng; thứ gì riêng project thì để project tự viết.
3. Đổi đường dẫn Vince-Home trên Windows (khác folder) = import hỏng im lặng. Test bằng `claude --debug` hoặc mở session thấy luật là còn sống.

# MONG MUOI CUA ANH — nguyen van quyet dinh

> Claude Code: day la **nguoi loi**. Khi CLAUDE.md va file nay khong hop nhau → **tin file nay**, vi no ghi theo loi anh noi.
> Nguoi ghi: Trucie (agent Debian) · ngay 2026-09-03 · tong hop tu hoi thoai chat voi chủ dự án.

---

## A. MONG MUOI TONG THE (y anh, gan nhu nguyen van)

> "Anh chi can ra quyet dinh. Anh doc nhieu no nao, vi anh la con nguoi khong phai nhu em."

- Anh **khong** viet code, **khong** doc log, **khong** cau hinh token.
- Anh **muon mot moi truong hop y** do agent tu dung: "no se lam moi thu de co 1 moi truong hop y".
- Anh thich **chu dong**: agent tu de xuat, tu mo, tu bao ket qua — khong hoi lai tung buoc.
- Anh **co chinh kien va muon duoc debate**: khi thay vô ly, agent phai noi ly do, khong lam theo mon mot.
- Anh **ghet lap lai loi cu**: moi fail phai thanh bai hoc + cai tien workflow.

---

## B. CAC QUET DINH DA CHOT (khong duoc dao nguoc)

| # | Thoi diem | Quyet dinh |
|---|---|---|
| 1 | 07:47 | **D2 — push theo milestone/slice.** Vincep xong S1 → bao → LU push kem "phan <ten> giai doan da xong" → debate chay ngay tren slice do → xong la **dong bang vinh vien** slice do. (Anh thang diem: khong co doan chet, vua sach history vua co backup.) |
| 2 | 07:47 + 08:27 | **D3 — van an toan.** Debate Bum ↔ Vincef **tu da toi khi xong**, khong cap so vong, khong escalate. Anh **chi duyet DUNG 1 diem: cho Vincep bat dau sua**. Do la van an toan, khong phai lao tu. |
| 3 | 07:47 (sua 08:27) | **D4 — 2 lane, moi lane 1 key** (KHONG phai 4 key rieng): `LU + Bum` chung 1 key Claude · `Vincef + Vincep` chung 1 key Go · Trucie 1 key Go rieng o Debian. |
| 4 | 08:27 | **A2A = co, nhung la relay + wake-up**, khong phai SDK hang hieu. Duong C (viet lai 4 agent bang Python/ADK) **loai** — "bat tu bo CLI anh dang dung" la vo nghia. |
| 5 | 08:27 | **Model:** LU = **Opus 5 medium** (push + bao cao giai doan, kem demo) · Bum = **Sonnet 5 medium** (debate). Ly do anh dong y: Opus hiem nhat → dat vao chang quyet dinh ngan; debate an token nhieu nhat → nhuong cho Sonnet. |
| 6 | 09:00 | **Lane Go chon RELAY**, khong tach key. Vincef khong review luc Vincep dang burn token. |
| 7 | 08:27 | **Rui ro — quan diem anh:** graphify ton qua → **dep, dung Obsidian de ghi nho**. Obsidian khong toi uu cho du an lon → **len mang tim cai khac**. **Lua khai file: oke.** **DevSwarm + opencode:** anh dang cam thay doi WSL/SSL, anh nghi den Cursor/Antigravity (xem `DEVSWARM-FACTS.md` de biet tai sao hai cai do khong thay duoc). |
| 8 | 08:50 | **Cac repo cua du an: anh bat private SAU.** Dung doi anh trc khi dung skeleton. |
| 9 | 09:55 | **Giao de:** Vince-Home da co folder + Claude Code. Agent phai **tu dung moi truong** theo CLAUDE.md, **sau do dung cho anh duyet**. |

---

## C. CACH ANH THAM GIA (chi 3 tu)

Tới lúc em/agent báo "S2 chốt, cần anh duyệt", anh trả lời **1 trong 3 chữ**:

- `sửa` → Vincep được đụng code
- `khoan` → đứng yên, giữ frozen
- `bỏ` → verdict sai, đá lại debate

**Anh im lặng = slice đứng yên.** Anh **không** đọc code, **không** chọn phe, **không** biểu quyết.
Anh nói 09:00: "anh sẽ nhắn và tự nhận ra" → **đừng dạy luật cho anh**, tới lúc thì báo 1 dòng kèm 3 lựa chọn là đủ.

---

## D. NGAN SACH (anh tu tinh — agent KHONG duoc tu dung pipeline vi tien)

- Ngan sach de **anh tu tinh**. Agent **do va bao**, khong **chan**.
- `manage-usage` cua Trucie **chi soi Trucie**, khong gate 4 con.
- **Cap 2 vong debate chi la goi y chat luong, KHONG phai luat chi phi.**
- Ngan sach tham chieu (Go pool): `$12/5h` · `$30/tuan` · `$60/thang`. 1 task vua uoc `$0.55`. Task to co Bum/Opus → anh tu cap nhat neus thay khong dung.

---

## E. PHONG CACH LAM VIEC ANH MUON

- **Bao cao sau khi xong viec** la bat buoc — anh da mo **toan quyen van hanh**, khong xin phe duyet tung buoc.
- Bao cao **ngan**, co bang chung (file + lenh + output), neu ro **rui ro**.
- **Push GitHub:** kem bao cao rui ro, khong cho duyet trc neu khong cham he thong/mang/secret.
- **Khong khiem dam tu ngu** trong bao cao ky thuat; ngon ngu hai huoc duoc phep o chot chit voi anh.
- **Chat la kenh, khong phai bo nho** — moi thu ben vung phai nam trong file/repo.

---

## F. NHUNG THU ANH DANG CAN LAM (khong phai cua agent)

1. Bat **private** cho cac repo du an (anh noi "bat sau").
2. Cau hinh key Go / Claude cho tung CLI — anh muon tu xem, agent chi o dung **huong dan**, khong lam thay.
3. Noi `chot` khi anh thay OK → Trucie xuong vault.
4. Tra loi `sửa`/`khoan`/`bỏ` khi bi ping.

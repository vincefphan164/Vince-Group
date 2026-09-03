# LUAT CHUNG — ap cho MOI project

Nguon: `CLAUDE.md` muc 1,5,6,7,8. File nay la ban rut de agent doc nhanh. **Neu mau thuan → `CLAUDE.md` thang.**

## L1 — Cache ly project
- Moi project = 1 repo rieng + 1 vault rieng (`obsidian/`).
- Workspace (worktree) **khong thay nhau**. GAP nhau duy nhat: **commit/push** hoac **file trong `Plan/`**.
- Repo chua code that = **private**. Khong bao gio day code vao repo public.

## L2 — Dong bang code
- Mo review: `Plan/REVIEW-<n>.md` ghi `STATE: frozen`.
- **Trong frozen: commit chi duoc dung `Plan/DEBATE-*`.** Sua code = pham luat.
- Mo khoa: `STATE: thawed` — chi sau khi anh noi `sua`.

## L3 — Khai file (chong merge hell)
- Truoc khi sua, moi agent khai file minh dung vao `Plan/GIAO-VIEC-<n>.md`.
- Hai duoc cung khai 1 file → chia lai, hoac mot dua ngai. Khong lam ca hai.
- Sub-agent (chi Vincep, toi da 2): moi sub khai file rieng.

## L4 — Van an toan
- Debate tu da toi khi xong. Khong cap so vong. Khong escalate som.
- Xong → push `Plan/DEBATE-<n>-BAOCAO.md` (verdict + bang chung code + so vong + uoc token + de xuat).
- Anh tra loi 1 trong 3: `sua` / `khoan` / `bo`. Anh im lang = dungyen.

## L5 — Push gate (LU la dua duynhat duoc push)
- Vincep / Vincef / Bum: **cam push, cam merge**.
- LU push khi va chi khi `tools/push-gate.sh` **xanh** (6 dieu kien trong `Plan/PUSH-<n>.md`).
- Thieu 1 o = dung. Ghi ly do vao plan, bao Trucie.
- Push theo **slice/milestone**, khong cho cuoi project.

## L6 — Ky
- Dau phien: doc `obsidian/index.md`.
- Moi push: 1 dong vao `obsidian/log.md` dang `<Agent>: <viec>`.
- 1 su that 1 dong, kem ngay. Khong note trung — cap nhat note cu.

## L7 — CUNG
- Commit secret (key/token/.env). Khong dan key vao bat ky file nao trong repo.
- Doi luat. Thay vo ly → ghi `Plan/QUESTION.md`, hoi Trucie.
- Hoi anh ve cau hinh token/WSL/install. Do la viec cua agent, khong phai cua anh.
- Bat dau code project that truoc khi anh noi `chot`.

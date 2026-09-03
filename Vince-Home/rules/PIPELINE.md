# PIPELINE THEO SLICE

Chat viec thanh **slice** theo moc y nghia (khong theo ngay). Moi slice chay tron vong roi **LOCK VINH VIEN**.

| B | Buoc | Ai | San pham |
|---|---|---|---|
| 1 | Lap plan | Trucie | `Plan/GIAO-VIEC-<n>.md` |
| 2 | Code | Vincep | branch `slice/<n>-<ten>` + commit |
| 3 | Review | Vincef | `Plan/REVIEW-<n>.md` (`STATE: frozen`) |
| 4 | Debate | Bum ⟷ Vincef | relay tung luot, `Plan/DEBATE-<n>.md` |
| 5 | **VAN AN TOAN** | **Anh** | `sua` / `khoan` / `bo` |
| 6 | Fix | Vincep | sau khi `STATE: thawed` |
| 7 | Test | LU | lenh chay + output |
| 8 | **Push** | **LU** | `push-gate.sh` xanh → `Plan/PUSH-<n>.md` |
| 9 | Lock | — | slice dong vinh vien |
| 10 | Verify doc lap | Trucie | bao cao + ky uc |

**Song song duoc phep:** Vincep lam S3 trong luc Vincef/Bum da S2. Do la ly do co DevSwarm.
**Khong duoc:** mo lai slice da lock. Bug cu = mo slice moi.

**Trang thai file dieu phoi** (`Plan/GIAO-VIEC-<n>.md`):
`S1: code ok · review lock · debate xong · fix - · test - · push ok` — moi dua chi duoc sua dung cot cua minh.

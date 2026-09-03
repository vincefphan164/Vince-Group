# 2 LANE + LUAT RELAY

## So do

```
LANE CLAUDE (1 key)          LANE GO (1 key)
  BUM   Sonnet 5 medium  ←→    VINCEP  Qwen flash   (code)
  LU    Opus   5 medium  ←→    VINCEF  DeepSeek V4 flash (review)
```
Trucie (Debian) = key Go rieng, **ngoai 2 lane nay**.

## Vi sao layout vay (quyet dinh 08:27 + 09:00)
- **Opus hiem nhat trong lane** → dat vao chang **push + bao cao** (quyet dinh, ngan, dat gia).
- **Debate an token nhieu nhat** → nhuong cho **Sonnet**.
- `LU + Bum` chung key Claude; `Vincef + Vincep` chung key Go.

## LUAT RELAY — Lane Go (bat buoc)
Vincef + Vincep **chung han muc rolling 5h**. Chay song song = danh nhau cung cai cong → 429/throttle. **Tac, khong phai het tien.**

1. Truoc khi goi model → doc `Plan/GO-LANE.md`.
2. Thay `BUSY: <dua khac>` → **khong burn token**. Ghi 1 dong `WAIT`, cho.
3. Thay `IDLE` → ghi `BUSY: <ten minh>`, lam, xong giu/tra theo `NEXT:`.
4. Vincep xong buoc → ghi `Plan/tiep.md` → Vincef moi review.

`Plan/CLAUDE-LANE.md`: cung luat cho Bum + Lu. **Rieng `Bum → LU` KHONG can relay** (Bum chi giao verdict 1 lan, khong gianh cong).

## Gia
- Duoc: **0 va cham 429**; moi model call dung sau mot bang chung that.
- Mat: Vincef khong review *live*, doc goc nhin cu hon vai phut. **Chap nhan.**

## Do luong
- Moi model call lon: ghi uoc luong token vao plan dang chay.
- **Khong duoc dung pipeline vi tien.** Ngan sach anh tu tinh. Do va bao, ngan chan.

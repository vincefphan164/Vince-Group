---
name: push-checklist
description: Dùng khi bạn là LU (pipeline hoặc điều phối) chuẩn bị chạy `git push` — bắt buộc đọc trước khi push, không được push tuỳ hứng. Trigger: "sẵn sàng push", "chuẩn bị push", "git push", "đủ điều kiện chưa".
---

# Push checklist — chỉ LU được push

Vincep/Vincef/Bum **cấm push, cấm merge**, cấm sửa code cho test qua (fail thì ghi fail). Chỉ LU push, và chỉ khi đủ checklist dưới đây.

## Phân loại việc trước khi áp checklist

- **Push slice qua pipeline đầy đủ (có debate)** → áp dụng ĐỦ 6 ô.
- **Việc ngoài pipeline, chủ dự án trực tiếp yêu cầu** (VD sửa luật/docs/script/scaffold project) — không có debate để báo cáo → **bỏ qua ô 5**, 5 ô còn lại vẫn bắt buộc.

## 6 ô

- [ ] `STATE` = thawed (đã qua van an toàn) — chỉ áp dụng nếu slice có frozen/thawed
- [ ] test xanh — **dán lệnh chạy + output thật**, không mô tả bằng lời (nếu có test để chạy)
- [ ] không có secret (`.env`, token, key) trong diff — grep trước khi commit
- [ ] mọi file đụng tới đều có trong khai báo (nếu có khai báo — housekeeping ngoài pipeline không bắt buộc khai trước)
- [ ] báo cáo debate đã push (bỏ qua nếu việc này không qua debate)
- [ ] 1 dòng `<Agent>: <việc>` trong `obsidian/log.md` — ghi TRƯỚC khi push, không phải sau

## Thiếu 1 ô

**= đứng.** Ghi lý do vào plan, báo Trucie. Không tự tick hộ ô của đứa khác, không sửa code cho test qua để lách checklist.

## Nhịp push

Theo **slice/milestone**, không dồn cuối dự án. Push xong → verify bằng `git log --oneline -3` + `git status --short` (phải sạch).

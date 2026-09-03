---
name: chia-sub-agent
description: Dùng khi bạn (Vincep/Vincef/Bum/LU, hoặc 1 workspace con đã tạo trước đó) đang cân nhắc chia 1 phần việc ra cho sub-agent làm song song. Đọc TRƯỚC KHI tạo workspace con — bắt buộc có kế hoạch rõ ràng, không tạo tuỳ hứng. Trigger: "chia việc", "sub-agent", "làm song song", "child workspace", "quá nhiều việc 1 mình".
---

# Chia sub-agent — DevSwarm child workspace

Bất kỳ workspace nào cũng được tạo child workspace cho sub-agent (không còn giới hạn chỉ Vincep, từ 2026-09-04). Điều kiện bắt buộc: **lập kế hoạch trước** — biết rõ sub làm gì, đụng file gì — không tạo bừa cho có việc. Sub = cùng model, cùng key, cùng lane với cha → vẫn là hố đốt token, chỉ đỡ hơn khi có kế hoạch rõ thay vì tạo tuỳ hứng.

## Trước khi tạo — tự hỏi

1. Việc này có thật sự tách được độc lập không, hay chia ra chỉ tổ tốn thêm 1 vòng gọi model?
2. Sub sẽ đụng file nào — có trùng với file cha hoặc sub khác đang chạy không? Nếu trùng → không chia, làm tuần tự.
3. Ước lượng việc có đáng 1 workspace riêng (spawn + prompt + theo dõi + gộp) hay làm luôn nhanh hơn?

Chỉ tạo khi cả 3 câu trên đều rõ ràng "có".

## Cách tạo

Từ workspace của mình (VD `agent/vincep`), chạy:
```
hivecontrol workspace create <branch-con> --agent <opencode|claude> --title "<tên>: <việc>" --prompt "<mô tả việc + file được đụng, khai rõ ràng>"
```
Workspace mới tự động là **con** của workspace gọi nó (source = branch hiện tại).

## Theo dõi + gộp việc

- Theo dõi: `hivecontrol workspace monitor`
- Giao thêm việc: `hivecontrol workspace message-child <branch-con> "<tin>"`
- Sub xong việc → từ workspace CON chạy `hivecontrol workspace merge-into-source` để gộp về lại workspace cha
- **Sub cấm push thẳng** — luật Push vẫn áp dụng (skill `push-checklist`), chỉ LU pipeline mới push
- Workspace cha dọn workspace con sau khi gộp xong (không để treo tốn context)

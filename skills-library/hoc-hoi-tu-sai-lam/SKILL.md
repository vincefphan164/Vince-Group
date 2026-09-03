---
name: hoc-hoi-tu-sai-lam
description: BẮT BUỘC dùng ở ĐẦU MỌI phiên (trước khi làm bất cứ việc gì) và NGAY LẬP TỨC mỗi khi 1 việc thất bại, bị chủ dự án sửa lưng, hoặc phát hiện giả định sai — đọc bài học cũ trước khi làm, ghi bài học mới ngay khi sai. Áp dụng cho MỌI agent (Claude Code lẫn OpenCode), không riêng ai. Trigger từ khoá: lỗi, sai, bug, thất bại, sửa lưng, "đồ ngu", rejected, failed, permission denied, không hoạt động.
---

# Học hỏi từ sai lầm

Hệ này đã sai lặp lại nhiều lần trong cùng 1 phiên (bug encoding PowerShell, quyền external_directory, hiểu sai kiến trúc DevSwarm workspace...) vì không có nơi nào tra lại bài học cũ trước khi làm lại việc tương tự. Skill này bắt buộc, không tuỳ chọn.

## Đầu phiên / trước khi làm việc không quen thuộc

1. Đọc `obsidian/BAI-HOC.md` **của repo hiện tại** (project đang đứng) — bài học riêng của project đó.
2. Nếu đang trong project khác Vince-Group, ĐỌC THÊM `C:\Users\Windows\DevSwarmProjects\Vince-Group\obsidian\BAI-HOC.md` — bài học cấp hệ thống (DevSwarm, PowerShell, opencode, git, hivecontrol...) áp dụng cho MỌI project, không riêng Vince-Group.
3. Việc sắp làm có liên quan tới bài học nào đã ghi → áp dụng ngay, đừng lặp lại sai lầm cũ.

## Ngay khi phát hiện mình sai (lệnh fail, chủ dự án sửa lưng, giả định sai)

1. **Dừng lại**, đừng vá qua loa rồi đi tiếp.
2. Xác định: **nguyên nhân gốc** là gì (không phải triệu chứng) — VD không phải "lệnh fail" mà là "gọi nhầm `powershell` thay vì `pwsh`".
3. Ghi NGAY 1 dòng vào `obsidian/BAI-HOC.md` đúng chỗ (repo hiện tại nếu đặc thù project; Vince-Group nếu là bài học hệ thống/tool dùng chung):
   ```
   - YYYY-MM-DD · <agent> · SAI: <đã tưởng gì> → THẬT: <sự thật> → TRÁNH: <làm gì lần sau>
   ```
   Ngắn gọn, 1 sự thật 1 dòng — không viết văn dài, không lặp bài học đã có (grep trước khi ghi).
4. Sửa xong mới báo cáo — không báo "đã xong" khi chưa verify bằng lệnh thật.

## Không phải là gì

- Không thay `obsidian/log.md` (nhật ký việc làm) — `BAI-HOC.md` chỉ chứa bài học tránh-sai-lần-2, không phải log tiến độ.
- Không phải chỗ xin lỗi/giải thích dài dòng — chỉ ghi sự thật kỹ thuật, súc tích, tra lại được bằng grep.

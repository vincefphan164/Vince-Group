# Vince-Group — Memory Hub (BẮT BUỘC)

> Đây là bộ nhớ duy nhất của hệ. **Không nằm trong vault = chưa từng xảy ra.**
> Lịch sử chat, trí nhớ session, context cửa sổ — KHÔNG được tính là bộ nhớ.
> Vault này mở được bằng app Obsidian (chọn folder `obsidian/` làm vault) — chuẩn .md + [[links]].

[[README]]

## Protocol — áp dụng MỌI phiên, MỌI agent (Vincef + LU)
1. **Đầu phiên:** đọc file này TRƯỚC khi làm bất cứ việc gì. Theo `[[links]]` tới note liên quan tới task.
2. **Trong phiên:** mọi quyết định / kế hoạch / kết quả / bài học quan trọng → ghi NGAY vào note:
   - Note đã có chủ đề → CẬP NHẬT, không tạo note trùng.
   - Chủ đề mới → tạo note, thêm link vào file này.
3. **Graphify = engine truy vấn** (nguồn chân lý vẫn là vault .md, graph chỉ là chỉ mục):
   - Corpus đổi: `graphify extract . --out graphify-out`
   - Nhớ lại không tốn token: `graphify query "<câu hỏi>" --budget 500`
   - `graphify-out/` là generated — không commit.
   - graphify cần LLM key cho semantic extraction (deepseek rẻ nhất). Không có key → đọc vault trực tiếp, KHÔNG dừng việc vì thiếu nó.
4. **Cuối phiên:** ghi việc dở dang vào [[log]] để phiên sau (agent nào cũng được) tiếp tục.

## Notes
- [[log]] — nhật ký trạng thái / việc dở dang

## Roster
- **Vincef** (OpenCode) — file: `.opencode/agents/Vincef.md`
- **LU / Long Uyên** (Claude) — file: `.claude/agents/LU.md`
- Hai đứa là 2 LLM khác nhau, chung 1 bộ quy tắc, chung 1 vault này.

## Kỷ luật token
- Ghi 1 sự thật 1 dòng, kèm ngày `YYYY-MM-DD`.
- Đọc theo phần cần (grep/head), không nạp cả vault mỗi lần.
- Việc gì quan trọng mà chỉ nói trong chat, chưa ghi vault → coi như chưa làm.

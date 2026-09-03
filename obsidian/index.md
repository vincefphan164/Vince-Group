# Vince-Group — Memory Hub (BẮT BUỘC)

> Đây là bộ nhớ của hệ. **Không nằm trong vault = chưa từng xảy ra.**
> Lịch sử chat, trí nhớ session, context cửa sổ — KHÔNG được tính là bộ nhớ.
> Vault này mở được bằng app Obsidian (chọn folder `obsidian/` làm vault) — chuẩn .md + [[links]].

[[README]]

## Protocol — áp dụng MỌI phiên, MỌI agent
1. **Đầu phiên:** đọc file này TRƯỚC khi làm bất cứ việc gì. Theo `[[links]]` tới note liên quan tới task.
2. **Trong phiên:** mọi quyết định / kế hoạch / kết quả / bài học quan trọng → ghi NGAY vào note:
   - Note đã có chủ đề → CẬP NHẬT, không tạo note trùng.
   - Chủ đề mới → tạo note, thêm link vào file này.
3. **Graphify = engine truy vấn** (nguồn chân lý vẫn là vault .md, graph chỉ là chỉ mục):
   - Corpus đổi: `graphify extract . --out graphify-out`
   - Nhớ lại không tốn token: `graphify query "<câu hỏi>" --budget 500`
   - `graphify-out/` là generated — không commit.
   - graphify cần LLM key cho semantic extraction. Không có key → đọc vault trực tiếp, KHÔNG dừng việc vì thiếu nó.
4. **Cuối phiên:** ghi việc dở dang vào [[log]] để phiên sau (agent nào cũng được) tiếp tục.

## Luật của hệ (từ 2026-09-03)
- [[../CLAUDE|CLAUDE.md — ĐỊNH DANH CHUNG]] — bất biến + roster + luật chung. **1 file duy nhất**, không còn tầng `Vince-Home/`.
- **Nhiều project (CLAUDE.md §4):** vault NÀY chỉ ghi việc của chính `Vince-Group` (luật/roster/template). Mỗi project khác (Project B, C, ...) có `obsidian/` RIÊNG trong repo của nó — đừng ghi dữ liệu project khác vào đây, và đừng lên đây tìm dữ liệu của project khác.

## Roster — ĐỦ 4 CON
| Con | Lane · Model | File máy đọc (CLI nạp) |
|---|---|---|
| **Vincep** | Go · qwen3.8-flash | `.opencode/agents/Vincep.md` |
| **Vincef** | Go · deepseek-v4-flash | `.opencode/agents/Vincef.md` |
| **Bum** | Claude · sonnet | `.claude/agents/Bum.md` |
| **LU** | Claude · opus | `.claude/agents/LU.md` |

- **2 lane, mỗi lane 1 key**: `Vincep+Vincef` (Go) · `Bum+LU` (Claude) → luật relay ở `CLAUDE.md` §3.
- `Trucie` (Debian) KHÔNG vào project: lập plan, do lường, verify độc lập, giữ ký ức.
- **Sửa hành vi = sửa file máy đọc** (`.claude|.opencode/agents/`), không sửa mô tả trong chat.

## Notes
- [[log]] — nhật ký trạng thái / việc dở dang
- [[BAI-HOC]] — bài học cấp hệ thống, tránh lặp sai lầm (skill `hoc-hoi-tu-sai-lam` bắt buộc đọc trước khi làm việc)

## Kỷ luật token
- Ghi 1 sự thật 1 dòng, kèm ngày `YYYY-MM-DD`.
- Đọc theo phần cần (grep/head), không nạp cả vault mỗi lần.
- Việc gì quan trọng mà chỉ nói trong chat, chưa ghi vault → coi như chưa làm.

# AGENT-DEFAULT — đặt 4 con làm MẶC ĐỊNH thực tế

> Câu hỏi: "làm sao mỗi con bước ra là chính nó, không phải agent generic rồi mới tự nhận vai?"
> Trả lời theo từng CLI. Chỉ ghi cơ chế **đã verify được bằng docs chính thức**; phần chưa verify đánh dấu 🔴.

## 1. OpenCode (Vincep + Vincef) — DONE, không cần thêm gì

- File per-project tại `.opencode/agents/<tên>.md` với `mode: primary` → xuất hiện trong danh sách agent chính, **Tab để cycle** giữa Build/Plan/Vincep/Vincef.
- Nguồn verify: https://opencode.ai/docs/agents/ ("Primary agents ... switch between them using the Tab key") và mục "Place files / Configure" — tên file = tên agent.
- Model + permission nằm trong frontmatter từng file (`Vincep.md`, `Vincef.md`); không cần `--agent` flag.
- Mặc định khi mở terminal: OpenCode start bằng agent default (build). Muốn con nào → Tab tới con đó, hoặc set `"default_agent"` trong opencode.json. 🔴 CHƯA VERIFY: tên khoá `default_agent` chưa được kiểm trong bản docs hiện tại — thử trước khi dùng.

## 2. Claude Code (Bum + LU) — 2 lớp

### Lớp 1 (đang dùng): persona trong CLAUDE.md của workspace
- Mỗi terminal = 1 worktree/workspace riêng. `CLAUDE.md` (và `Vince-Home/CLAUDE.md` mà nó trỏ tới) định nghĩa vai. Cờ `--model` chọn model.
- Đây là cách "mặc định" tự nhiên nhất của Claude Code: phiên luôn bắt đầu với luật + persona từ CLAUDE.md.

### Lớp 2 (mới verify được): biến sub-agent file thành main-thread
- `.claude/agents/*.md` đúng nghĩa là **sub-agent** — nhưng Claude Code có cờ **`claude --agent <tên>`**: "start a session where the main thread itself takes on that subagent's system prompt, tool restrictions, and model", và **set `{"agent": "<tên>"}` trong `.claude/settings.json` để mặc định cho mọi session của project**. Lựa chọn này được giữ khi resume.
- Nguồn verify: https://code.claude.com/docs/en/sub-agents (mục "Run the whole session as a subagent").
- ➜ Vậy `Bum`/`LU` có thể chạy như mặc định THỰC TẾ mà không phải viết lại CLAUDE.md: thêm agent file vào `.claude/agents/` và `--agent LU` (hoặc `"agent"` trong settings.json của worktree đó).
- ⚠️ Trade-off đã biết: `--agent` **thay toàn bộ system prompt mặc định** bằng prompt của agent → các hành vi mặc định của Claude Code mất đi, CLAUDE.md vẫn load bình thường qua message flow. Mỗi lane Claude 1 worktree, setting đặt trong worktree đó, đừng đặt ở gốc repo chung.

### Việc còn treo
- [ ] Viết `.claude/agents/Bum.md` (bản ngắn, prompt = vai trò debate) — khi nào Burn chạy thật mới cần. 🔴 CHƯA VERIFY: `model: claude-opus-5` / `claude-sonnet-5` có phải tên hợp lệ cho frontmatter không (docs ghi `model` nhận alias như `sonnet`/`opus`/`haiku`, tên đầy đủ theo plan của anh).
- [ ] Kiểm `claude --version` trên máy Windows có hỗ trợ `--agent` không (docs hiện tại có; build cũ có thể chưa). 🔴

## 3. Không hứa cuội
Không có cơ chế "4 con cùng lúc 1 cửa sổ" trong cả hai CLI. Muốn song song = DevSwarm/multi-terminal, mỗi terminal 1 lane + 1 agent mặc định theo cách ở trên.

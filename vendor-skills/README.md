# vendor-skills/ — KHÔNG phải skill dir

Thư mục này chứa skill của bên thứ ba **được giữ lại có chủ ý** (không xoá) nhưng **cố ý để ngoài mọi đường scan** của OpenCode/Claude Code:

- `composio-skills/` — 832 skill integration SaaS qua Rube/Composio MCP. Vô dụng cho dự án code, nhưng nặng **~104.000 ký tự index (~26.000 token)** nếu bị nạp vào mọi phiên.
- Không nằm trong `skills.paths` (opencode.json), không nằm trong `.opencode/skills`, `.claude/skills`, `.agents/skills` → không agent nào thấy.

## Muốn bật lại 1 skill?

Copy thư mục skill đó về `skills-library/`:

```powershell
Copy-Item -Recurse vendor-skills\composio-skills\github-automation skills-library\
```

Xong commit. Index sẽ phình trở lại — cân nhắc trước (xem `Vince-Home/rules/LUAT-CHUNG.md` L8: trần index ~3.000 token).

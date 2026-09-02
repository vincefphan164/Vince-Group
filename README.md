# Vince-Group

Dự án multi-agent. Agent: **Vincef** (OpenCode) · **LU** (Claude).

> Trạng thái: **v0** — 2 agent (Vincef, LU). Lịch sử cũ đã được đóng băng, không có legacy.

## Cấu trúc
- `.opencode/agents/Vincef.md` — agent Vincef
- `.claude/agents/LU.md` — agent LU
- `skills-library/` — thư viện skill chung (đăng ký qua `skills.paths` trong `opencode.json`)
- `obsidian/` — **BỘ NHỚ DUY NHẤT** của hệ (vault .md, hub là `index.md`)
- `opencode.json` — config model + skills
- `.graphifyignore` — scoping cho graphify (engine truy vấn bộ nhớ)

## Quy tắc bộ nhớ (bắt buộc với mọi agent)
Không có gì là "nhớ" nếu chưa nằm trong `obsidian/`. Chi tiết: `obsidian/index.md`.

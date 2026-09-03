# Vince-Group

Hệ multi-agent. **Định danh chung + luật: `CLAUDE.md`** (file duy nhất, đọc trước tiên).

## Agent
| Con | Lane | File máy đọc |
|---|---|---|
| **Vincep** | Go · OpenCode | `.opencode/agents/Vincep.md` |
| **Vincef** | Go · OpenCode | `.opencode/agents/Vincef.md` |
| **Bum** | Claude | `.claude/agents/Bum.md` |
| **LU** | Claude | `.claude/agents/LU.md` |

Tầng luật riêng `Vince-Home/` đã gỡ (2026-09-03) — chỉ còn **1 file định danh chung** ở gốc repo.

## Cấu trúc
- `CLAUDE.md` — **bất biến + roster + luật chung** (đọc cái này đầu tiên)
- `.opencode/agents/` · `.claude/agents/` — file máy đọc, mỗi đứa 1 vai
- `skills-library/` — skill chung **1 nguồn** (đăng ký qua `skills.paths` trong `opencode.json`)
- `vendor-skills/` — composio, để đó, **không scan**
- `obsidian/` — **BỘ NHỚ DUY NHẤT** của hệ (vault .md, hub là `index.md`)
- `opencode.json` — config model + skills
- `tools/` — link-skills (junction mỗi máy 1 lần), set-default-agent
- `.graphifyignore` — scoping cho graphify

## Quy tắc bộ nhớ (bắt buộc với mọi agent)
Không có gì là "nhớ" nếu chưa nằm trong `obsidian/`. Chi tiết: `obsidian/index.md`.

Repo **public** — chỉ tài liệu / luật / template, không code project thật.

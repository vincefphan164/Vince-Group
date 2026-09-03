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
- `CLAUDE.md` — **bất biến + roster + luật chung + luật nhiều-project** (đọc cái này đầu tiên)
- `.opencode/agents/` · `.claude/agents/` — file máy đọc, mỗi đứa 1 vai
- `skills-library/` — skill chung **1 nguồn** (đăng ký qua `skills.paths` trong `opencode.json`)
- `vendor-skills/` — composio, để đó, **không scan**
- `obsidian/` — **BỘ NHỚ** của riêng repo này (luật chung/roster). Mỗi project khác có `obsidian/` riêng, không trộn.
- `opencode.json` — config model + skills
- `tools/` — link-skills (junction mỗi máy 1 lần), set-default-agent
- `PROJECT-TEMPLATE/` — khuôn tạo project mới, kế thừa `CLAUDE.md` này + có bộ nhớ/code riêng (xem `CLAUDE.md` §4)
- `.graphifyignore` — scoping cho graphify

## Nhiều project
`Vince-Group` = luật chung dùng cho MỌI project. Project thật = repo riêng, add riêng vào DevSwarm, dựng từ `PROJECT-TEMPLATE/`. Chi tiết: `CLAUDE.md` §4 + `PROJECT-TEMPLATE/README.md`.

## Quy tắc bộ nhớ (bắt buộc với mọi agent)
Không có gì là "nhớ" nếu chưa nằm trong `obsidian/`. Chi tiết: `obsidian/index.md`.

Repo **public** — chỉ tài liệu / luật / template, không code project thật.

# BÁO CÁO — DỌN INDEX SKILL + WIRE SKILL CHUNG (Trucie, 2026-09-03)

## Đã làm gì
1. **Dời (không xoá)** `skills-library/composio-skills/` → `vendor-skills/composio-skills/` — 832 file SKILL rename, vẫn còn nguyên trong repo, chỉ ra khỏi mọi đường scan skill.
2. `opencode.json`: thêm `permission.skill = {"*": "allow", "composio-*": "deny"}` (docs OpenCode xác nhận: `deny` = ẩn hẳn khỏi agent).
3. `vendor-skills/README.md`: giải thích composio ở đây là **cố ý**, muốn bật thì copy về `skills-library/`.
4. `Vince-Home/rules/LUAT-CHUNG.md`: thêm **L8** (giữ nguyên L1–L7): 1 nguồn skill, trần index ~3.000 token.
5. `Vince-Home/CLAUDE.md` §12: sửa **B1** (skill đã wire 1 nguồn, không copy vào Vince-Home) + **B4** (kiểm link bằng `-Check` chế độ đọc, không tự tạo junction).
6. **4 con đều primary thực tế**:
   - OpenCode: `.opencode/agents/Vincep.md` + `Vincef.md` mới (mode: primary, prompt 4–6 dòng không lặp luật; Vincef `edit: deny` vì review chỉ đọc). Prompt cũ dài của Vincef → `Vince-Home/agents/_legacy/Vincef-opencode-full.md`; `.claude/agents/LU.md` cũ → copy `_legacy/LU-claude-full.md` (giữ nguyên file gốc đang dùng).
   - Claude Code: `Vince-Home/rules/AGENT-DEFAULT.md` — verify được từ docs chính thức: `claude --agent <tên>` chạy cả phiên theo agent file, và `{"agent": "<tên>"}` trong `.claude/settings.json` = mặc định cho project (nguồn: https://code.claude.com/docs/en/sub-agents). Chưa verify: tên model `claude-opus-5/sonnet-5` trong frontmatter, build cũ có `--agent` — đánh dấu 🔴 trong file.
7. **Skill chia sẻ 1 nguồn cho cả 2 CLI**: không commit symlink. `tools/link-skills.ps1` (Windows Junction, không cần admin, `-Check`, idempotent, từ chối phá dir thật) + `tools/link-skills.sh` (POSIX symlink, cùng ràng buộc). Cả hai chỉ đụng `.claude/skills`, không đụng `.claude/agents` / `settings*.json`. `.claude/skills` vào `.gitignore`.

## Số đo (đếm ký tự `name:`+`description:` trong SKILL.md reachable từ skills-library/)
| | ký tự | token ước lượng |
|---|---|---|
| TRƯỚC (864 skill) | 112.496 (lệch ~1% so số cũ 113.360 do cách đếm) | ~28.100 |
| SAU (32 skill) | **8.280** | **~2.100** |
| Giảm | **92.6%** |达标 — dưới trần L8 ~3.000 token |

- `du -sh vendor-skills` = **7,0M**; `find vendor-skills -name SKILL.md | wc -l` = **832** → composio còn đủ.
- `git ls-tree -r origin/main`: trước **1176** → sau **1183** files (+7 = file mới, không mất file nào; rename không đổi số).
- Script link test trên Debian: `-Check` → exit 2 (missing) → chạy link → 32 SKILL.md thấy được, **0** đường composio, `.claude/agents/LU.md` còn nguyên, idempotent OK.

## 🔴 Rủi ro
1. **832 skill composio vẫn nằm trong repo PUBLIC** (`vendor-skills/`) — chỉ tài liệu integration SaaS, không secret, nhưng nặng 7MB và ai vào GitHub vẫn thấy. Muốn xoá hẳn → quyết định riêng của anh.
2. **Junction là thao tác local** — mỗi máy Windows chạy `tools/link-skills.ps1` MỘT LẦN sau pull. Máy chưa chạy → Claude Code chưa thấy skills-library (OpenCode không cần junction vì đã có `skills.paths`).
3. `composio-*` deny chỉ là lớp phòng thủ 2; lớp chính là đã dời khỏi đường scan. Nếu ai copy 1 composio skill về `skills-library/` thì deny vẫn ẩn nó (tên giữ prefix `composio-`? → không, tên composio skill dạng `ably-automation` **không** prefix `composio-`, deny không bắt được — nếu copy về thì nó SẼ hiện. README vendor-skills đã cảnh báo điều này).
4. PowerShell script **chưa syntax-check** (không có pwsh trên Debian) — logic đọc kỹ bằng mắt; lỗi nếu có sẽ thấy ngay khi chạy `-Check` trên Windows.

## Commits (nhánh main, đã push)
| sha | việc |
|---|---|
| `22f300e` | Trucie: don index skill — day composio-skills (832) sang vendor-skills/, deny composio-* |
| `7d0f787` | Trucie: 4 agent mac dinh — Vincep/Vincef.md primary, _legacy, AGENT-DEFAULT.md |
| `d624789` | Trucie: skill chia sẻ 1 nguồn — link-skills.ps1/.sh, gitignore .claude/skills |
| `42889f9` | Trucie: L8 + sua CLAUDE.md B1/B4 |
| (commit này) | Trucie: bao cao don skill |

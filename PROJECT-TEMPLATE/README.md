# PROJECT-TEMPLATE

**Để làm gì:** khi cậu add 1 repo mới (Project B, C...) vào DevSwarm, thư mục này là nơi bấm 1 lệnh để dựng sẵn 4 file agent + `CLAUDE.md` + `obsidian/` cho repo đó — thay vì gõ tay lại từ đầu mỗi lần. Không phải luật, không phải bộ nhớ, **chỉ là khuôn (khuôn bánh, không phải bánh)**.

**Không có file/folder nào ở đây trùng tên với file thật của `Vince-Group`** (không có `obsidian/`, không có `CLAUDE.md` nằm trần) — toàn bộ nội dung mẫu nằm trong `templates/*.template`, chỉ `new-project.ps1` mới đọc tới. Đứng ở gốc `Vince-Group` mà nhìn, chỉ có ĐÚNG 1 `obsidian/` (bộ nhớ thật) và ĐÚNG 1 `CLAUDE.md` (luật thật) — không có bản mẫu nào giả dạng để nhầm lẫn.

## Cách dùng (Trucie hoặc anh làm khi thêm project mới vào DevSwarm)

1. Tạo repo mới (private nếu có code thật), `git init` / clone về máy — khuyến nghị `C:\Users\Windows\DevSwarmProjects\<Tên-Project>` để cùng chỗ với `Vince-Group`.
2. Chạy:
   ```
   pwsh -File PROJECT-TEMPLATE\new-project.ps1 -TargetPath "C:\Users\Windows\DevSwarmProjects\<Tên-Project>" -Name "<Tên Project>"
   ```
   Script tự: dựng `CLAUDE.md` + `obsidian/` (`index.md`, `log.md`, `BAI-HOC.md`) + `opencode.json` ở repo mới từ `templates/*.template`, điền tên project, copy TƯƠI 4 file agent (`.claude/agents/Bum.md`, `LU.md`, `.opencode/agents/Vincep.md`, `Vincef.md`) trực tiếp từ `Vince-Group` (không bản tĩnh nào nằm sẵn trong `PROJECT-TEMPLATE/`, tránh lệch nhau theo thời gian), đặt `.claude/settings.json = LU`, và junction `.claude/skills` về `skills-library` của Vince-Group.
3. Điền nốt phần `<điền>` còn lại trong `CLAUDE.md` (mục tiêu, ràng buộc riêng nếu có).
4. Add repo vào DevSwarm (`hivecontrol open <path>` hoặc qua app) — **không cần tạo workspace tay nào cả.** Mở project đó trong app: **session chính (Primary Workspace) tự nhận diện là LU** (`.claude/settings.json` script đã tạo sẵn ở bước 2).
5. **LU điều phối (session chính) đọc `Plan/GIAO-VIEC-<n>.md` xong → TỰ ĐỘNG tạo ngay 4 workspace con** (`agent/vincep`, `agent/vincef`, `agent/bum`, **và `agent/lu`** — đây là LU PIPELINE, khác với LU điều phối, đảm nhận test+push gate cho slice) bằng `hivecontrol workspace create` — **không hỏi lại chủ dự án**, không chờ ai xác nhận. Lý do kỹ thuật phải làm từ bên trong: `hivecontrol` bị khoá cứng vào repo mà session đang chạy (biến `DEVSWARM_REPO_ID`) — 1 session ở Vince-Group KHÔNG THỂ tạo workspace cho repo project khác, chỉ session chạy THẬT SỰ trong repo đó mới làm được. Nếu Vincep/Vincef/Bum/LU-pipeline cần chia sub-agent, tự tạo child workspace tương tự (xem `CLAUDE.md` §3 của Vince-Group — không còn giới hạn chỉ Vincep).
6. Skill (**đã làm + verify, không còn là điểm chưa test**): `opencode.json` mẫu trỏ thẳng `skills.paths` về `skills-library` của Vince-Group bằng đường dẫn tuyệt đối (Vincep/Vincef dùng được). `.claude/skills` được **junction NTFS** thẳng tới `skills-library` của Vince-Group (script bước 2 tự tạo — Bum/LU dùng được). Không copy, không nhân bản, 1 nguồn duy nhất.

## Nếu sửa 1 trong 4 file agent ở `Vince-Group` sau này, project đã tạo có tự cập nhật không?

**Không tự động.** Chạy lại `new-project.ps1` cho project đó để đồng bộ lại (script ghi đè `-Force`). Đây là đánh đổi có chủ đích: agent-file không thể dùng chung qua nhiều repo git độc lập (Claude Code / OpenCode chỉ đọc `.claude|.opencode/agents/` trong CHÍNH repo đang chạy), nên bắt buộc phải có 1 bản trong mỗi project — script chỉ đảm bảo bản đó luôn được copy **tươi từ nguồn duy nhất** tại thời điểm chạy, thay vì có 2 bản tĩnh nằm sẵn không đồng bộ.

## Đường dẫn tuyệt đối `C:\Users\Windows\DevSwarmProjects\Vince-Group` xuất hiện trong `CLAUDE.md`, `obsidian/index.md`, `opencode.json` — vì sao hardcode?

Vì DevSwarm workspace là git worktree, nằm rải rác dưới `.devswarm\repos\...\`, không phải thư mục anh em (sibling) của repo project. Đường dẫn tuyệt đối tới **Primary Workspace** của Vince-Group là điểm neo ổn định duy nhất, bất kể agent đang đứng ở worktree nào. Nếu sau này dọn `Vince-Group` sang máy/đường dẫn khác, phải sửa lại 3 chỗ này ở MỌI project đã tạo — ghi vào `Plan/QUESTION.md` của Vince-Group nếu việc đó xảy ra.

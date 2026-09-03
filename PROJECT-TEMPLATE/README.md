# PROJECT-TEMPLATE

**Để làm gì:** khi cậu add 1 repo mới (Project B, C...) vào DevSwarm, thư mục này là nơi bấm 1 lệnh để dựng sẵn 4 file agent + `CLAUDE.md` + `obsidian/` cho repo đó — thay vì gõ tay lại từ đầu mỗi lần. Không phải luật, không phải bộ nhớ, **chỉ là khuôn (khuôn bánh, không phải bánh)**.

**Không có file/folder nào ở đây trùng tên với file thật của `Vince-Group`** (không có `obsidian/`, không có `CLAUDE.md` nằm trần) — toàn bộ nội dung mẫu nằm trong `templates/*.template`, chỉ `new-project.ps1` mới đọc tới. Đứng ở gốc `Vince-Group` mà nhìn, chỉ có ĐÚNG 1 `obsidian/` (bộ nhớ thật) và ĐÚNG 1 `CLAUDE.md` (luật thật) — không có bản mẫu nào giả dạng để nhầm lẫn.

## Cách dùng (Trucie hoặc anh làm khi thêm project mới vào DevSwarm)

1. Tạo repo mới (private nếu có code thật), `git init` / clone về máy — khuyến nghị `C:\Users\Windows\DevSwarmProjects\<Tên-Project>` để cùng chỗ với `Vince-Group`.
2. Chạy:
   ```
   pwsh -File PROJECT-TEMPLATE\new-project.ps1 -TargetPath "C:\Users\Windows\DevSwarmProjects\<Tên-Project>" -Name "<Tên Project>"
   ```
   Script tự: dựng `CLAUDE.md` + `obsidian/` + `opencode.json` ở repo mới từ `templates/*.template`, điền tên project, **và copy TƯƠI 4 file agent (`.claude/agents/Bum.md`, `LU.md`, `.opencode/agents/Vincep.md`, `Vincef.md`) trực tiếp từ `Vince-Group`** — không có bản tĩnh nào nằm sẵn trong `PROJECT-TEMPLATE/`, tránh 2 bản lệch nhau theo thời gian.
3. Điền nốt phần `<điền>` còn lại trong `CLAUDE.md` (mục tiêu, ràng buộc riêng nếu có).
4. Add repo vào DevSwarm (`hivecontrol open <path>` hoặc qua app). **Tạo workspace theo nhu cầu, không mở cả 4 cùng lúc** — tối ưu token: bước nào cần con nào thì tạo con đó (VD mới bắt đầu code → chỉ cần `agent/vincep`; tới lúc review/debate mới cần `agent/vincef`/`agent/bum`). Lệnh mẫu `hivecontrol workspace create`: xem `obsidian/log.md` của Vince-Group, mục 2026-09-03.
5. **KHÔNG copy `skills-library/`** — `opencode.json` mẫu đã trỏ thẳng về `skills-library` của `Vince-Group` bằng đường dẫn tuyệt đối. Nếu path đó không hoạt động (opencode không đọc skills path ngoài repo), báo lại — đây là điểm chưa test, có thể cần cách khác.
6. Claude Code: chưa có cơ chế tương đương cho `.claude/skills` trỏ chéo repo — nếu project cần skill, tạm thời hỏi Trucie thay vì tự tạo junction (đúng luật "không tự tạo junction" của Vince-Group).

## Nếu sửa 1 trong 4 file agent ở `Vince-Group` sau này, project đã tạo có tự cập nhật không?

**Không tự động.** Chạy lại `new-project.ps1` cho project đó để đồng bộ lại (script ghi đè `-Force`). Đây là đánh đổi có chủ đích: agent-file không thể dùng chung qua nhiều repo git độc lập (Claude Code / OpenCode chỉ đọc `.claude|.opencode/agents/` trong CHÍNH repo đang chạy), nên bắt buộc phải có 1 bản trong mỗi project — script chỉ đảm bảo bản đó luôn được copy **tươi từ nguồn duy nhất** tại thời điểm chạy, thay vì có 2 bản tĩnh nằm sẵn không đồng bộ.

## Đường dẫn tuyệt đối `C:\Users\Windows\DevSwarmProjects\Vince-Group` xuất hiện trong `CLAUDE.md`, `obsidian/index.md`, `opencode.json` — vì sao hardcode?

Vì DevSwarm workspace là git worktree, nằm rải rác dưới `.devswarm\repos\...\`, không phải thư mục anh em (sibling) của repo project. Đường dẫn tuyệt đối tới **Primary Workspace** của Vince-Group là điểm neo ổn định duy nhất, bất kể agent đang đứng ở worktree nào. Nếu sau này dọn `Vince-Group` sang máy/đường dẫn khác, phải sửa lại 3 chỗ này ở MỌI project đã tạo — ghi vào `Plan/QUESTION.md` của Vince-Group nếu việc đó xảy ra.

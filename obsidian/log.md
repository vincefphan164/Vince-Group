# Log — trạng thái & việc dở dang

> Mỗi cuối phiên, agent ghi 1 mục. Mới → cũ đọc từ xuống. Format: `YYYY-MM-DD · agent · nội dung`.

[[index]]

## 2026-09-03 · main
- 2026-09-03 · main · chủ dự án bác bỏ việc gán phiên chính = LU (đã có workspace `agent/lu` riêng rồi, trùng) — đã xoá `.claude/settings.json`, phiên chính quay lại "Main" bình thường
- 2026-09-03 · main · dựng `PROJECT-TEMPLATE/` để project mới (Project B, C...) kế thừa luật Vince-Group + có bộ nhớ riêng: `CLAUDE.md` + `obsidian/` mẫu + `opencode.json` (skills trỏ tuyệt đối về Vince-Group) + `new-project.ps1`
- 2026-09-03 · main · sửa theo góp ý: bỏ 2 bản tĩnh `.claude/agents/*.md` + `.opencode/agents/*.md` nằm sẵn trong `PROJECT-TEMPLATE/` (trùng lặp với bản gốc ở `Vince-Group`, dễ lệch). Thay bằng `new-project.ps1` — copy TƯƠI 4 file agent từ `Vince-Group` (nguồn duy nhất) mỗi lần tạo project mới
- 2026-09-03 · main · thêm CLAUDE.md §4 "NHIỀU PROJECT" + cập nhật README.md + obsidian/index.md cho khớp
- 2026-09-03 · main · sửa tiếp theo góp ý: `PROJECT-TEMPLATE/` từng có `obsidian/` + `CLAUDE.md` trùng TÊN với file thật ở gốc Vince-Group → dễ đọc nhầm là luật/bộ nhớ thật. Dồn hết nội dung mẫu vào `PROJECT-TEMPLATE/templates/*.template` (tên không trùng ai cả); gốc repo giờ chỉ còn ĐÚNG 1 `obsidian/` và ĐÚNG 1 `CLAUDE.md`
- 2026-09-03 · main · `hivecontrol jira auth --start` → vẫn báo `TEAM_SUBSCRIPTION_REQUIRED`, chưa nâng cấp gói. Ghi nhận: kết nối Jira là 1 lần cấp tài khoản (OAuth token DevSwarm lưu sẵn), KHÔNG phải làm riêng cho từng agent — 1 lần `jira auth --start` là cả 4 workspace dùng chung được luôn. Đứng lại chờ anh quyết nâng cấp
- 2026-09-03 · main · dọn `skills-library/`: xoá 21/30 skill lệch mục đích repo (marketing/design/social/kế toán, hoặc trùng composio đã có sẵn 832 skill ở `vendor-skills/composio-skills`). Còn lại 9 skill liên quan trực tiếp việc code/test/docs: artifacts-builder, changelog-generator, document-skills, file-organizer, mcp-builder, skill-creator, skill-share, template-skill, webapp-testing
- 2026-09-03 · main · thêm cách chia sub-agent CỤ THỂ vào CLAUDE.md §3 (trước giờ chỉ nói "được chia", chưa nói bằng lệnh gì): Vincep dùng `hivecontrol workspace create` để tạo child workspace, `message-child`/`monitor` để theo dõi, `merge-into-source` để gộp việc về. Đồng bộ 1 dòng trỏ vào `.opencode/agents/Vincep.md`
- 2026-09-03 · main · sửa bug encoding nghiêm trọng trong `PROJECT-TEMPLATE/new-project.ps1`: literal tiếng Việt `<TÊN PROJECT>` trong chính file .ps1 (không BOM) bị Windows PowerShell 5.1 đọc sai encoding → `-replace` không khớp, để nguyên placeholder trong file sinh ra. Sửa: đổi placeholder sang ASCII `<PROJECT_NAME>` trong templates + script — bền vững hơn thêm BOM vì không phụ thuộc cách tool nào đó lưu file .ps1
- CHƯA push toàn bộ đợt sửa này ở Vince-Group (skill dọn, sub-agent docs, PROJECT-TEMPLATE + fix bug), chờ xác nhận

## 2026-09-03 · quyết định quy trình mới — Main → Plan/ project → LU
- 2026-09-03 · chủ dự án quyết: **từ nay giao nhận kế hoạch qua workspace LU, không dùng session Main để giao việc nữa.** Quy trình chuẩn: Main (phiên chat chính) brainstorm/thiết kế cùng chủ dự án → viết `Plan/GIAO-VIEC-<n>.md` **ở CHÍNH repo project đó** (không phải ở Vince-Group) → giao cho LU → LU kéo cả team (Vincep/Vincef/Bum) làm theo pipeline `CLAUDE.md` §3/§4
- 2026-09-03 · main · dựng project `Team Vince Dashboard` tại `C:\Users\Windows\Desktop\Team_Vince_Dashboard` (git local, CHƯA có remote GitHub) từ `PROJECT-TEMPLATE`. Brainstorm xong thiết kế dashboard hoạt động 4 agent (Next.js + Vercel, đọc GitHub API công khai không token, ISR, chỉ theo dõi repo public). Viết `Plan/GIAO-VIEC-1.md` ở repo đó, commit local, bàn giao cho LU — LU tự quyết lúc nào tạo remote GitHub (báo chủ dự án trước khi tạo)
- 2026-09-03 · main · chốt lại quy trình chuẩn (chủ dự án tinh chỉnh thêm): Main giao việc **cho workspace `agent/lu` của chính Vince-Group**, không viết thẳng vào repo project nữa. LU nhận → tự "quăng" việc + lôi Vincep/Vincef/Bum sang workspace TẠI repo project đó (tối ưu token — chỉ mở workspace cần cho bước hiện tại, không mở cả 4 cùng lúc). Đã ghi vào `CLAUDE.md` §4 (mục "Nhận việc mới") + thêm 1 dòng trong `.claude/agents/LU.md`
- 2026-09-03 · main · tạo `obsidian/PROJECTS.md` — registry duy nhất để biết team đang làm project nào, ở đâu, ai phụ trách. LU chịu trách nhiệm cập nhật khi mở/đóng project. Đã thêm dòng đầu tiên: Team Vince Dashboard, trạng thái "chờ LU nhận việc"
- 2026-09-03 · main · gửi `hivecontrol workspace message-child agent/lu` báo việc Team Vince Dashboard đã sẵn sàng, trỏ tới `Plan/GIAO-VIEC-1.md` — LU đọc khi phiên đó chạy
- 2026-09-03 · main · phát hiện: `pwsh` (PowerShell 7.6.5) **đã có sẵn trên máy**, lỗi encoding + lỗi `Add-Member` trước đó là do gọi nhầm `powershell` (bản 5.1 cũ) thay vì `pwsh`. Test lại pattern `Add-Member` dưới `pwsh` → chạy đúng, không lỗi. Đã sửa mọi chỗ gọi `powershell -File` trong repo (`new-project.ps1`, `PROJECT-TEMPLATE/README.md`, `tools/link-skills.ps1`, `tools/set-default-agent.ps1`) thành `pwsh -File`
- 2026-09-03 · main · chủ dự án bảo bỏ đoạn "Nhận việc mới" + `obsidian/PROJECTS.md` vừa thêm vào CLAUDE.md — thừa, không phải luật 4 con cần đọc mỗi phiên. Đã revert `CLAUDE.md` §4 về 1 dòng ngắn, xoá `obsidian/PROJECTS.md`, dọn link ở `index.md` và `.claude/agents/LU.md`. Từ chối gỡ Windows PowerShell 5.1 (đụng hệ thống lõi, không phải app cài rời — theo Bất biến #1) — thay bằng dùng `pwsh` mọi nơi

## 2026-09-03 · LU (session chính = LU, chốt lại)
- 2026-09-03 · chủ dự án chốt: **phiên chính (trước gọi "Main") = LU luôn, không tách riêng workspace `agent/lu` để relay qua nữa.** LU là đầu mối DUY NHẤT nhận việc mới + báo cáo cuối mỗi giai đoạn, nói chuyện trực tiếp với chủ dự án. Đã set `.claude/settings.json = {"agent":"LU"}` (local, gitignore)
- 2026-09-03 · LU · muốn xoá 4 workspace `agent/vincep|vincef|bum|lu` ở Vince-Group (giờ dư — LU (phiên chính) nói chuyện trực tiếp, không cần workspace `agent/lu` riêng; 3 workspace kia chỉ để test kết nối opencode hồi đầu, Vince-Group không có code thật để làm). `hivecontrol` KHÔNG có lệnh xoá workspace (đã tra `help workspace` — chỉ list/info/create/update-title/merge-*/message-*/monitor). Xoá tay bằng git sẽ để lại rác trong DB nội bộ app → KHÔNG làm, cần chủ dự án tự xoá qua DevSwarm desktop app
- 2026-09-03 · LU · audit CLAUDE.md, tìm ra 2 lỗ hổng logic: (1) checklist push 6 ô bắt "báo cáo debate đã push" — việc ngoài pipeline (sửa luật/docs/script) không bao giờ có debate nên tự khoá LU push vĩnh viễn cho loại việc đó; đã sửa rõ phạm vi: 6 ô áp dụng cho slice có debate, việc ngoài pipeline bỏ qua ô đó. (2) bảng roster §2 mô tả LU chỉ "test+docs+push", thiếu vai trò nhận việc mới mà 4 con khác cần biết; đã thêm 4 chữ vào bảng
- 2026-09-03 · LU · sửa `PROJECT-TEMPLATE/README.md` bước 4: trước nói "tạo 4 workspace" ngay khi dựng project, ngược nguyên tắc tối ưu token (tạo dần theo bước cần) — sửa lại đúng nguyên tắc
- 2026-09-03 · LU · chủ dự án duyệt. Checklist trước push (việc ngoài pipeline, bỏ ô debate theo luật vừa sửa): không secret trong diff (đã grep, chỉ có placeholder ví dụ trong doc BỊ XOÁ) · không file `.env`/key nào stage · log này chính là ô cuối. Push 1 lần gộp: skill dọn (21 skill), PROJECT-TEMPLATE + fix bug encoding/pwsh, 2 lỗ hổng logic CLAUDE.md, revert đoạn thừa, chốt Main=LU

## 2026-09-03 · reset v0
- 2026-09-03 · Trucie · reset repo về v0 (baseline 1 commit), retire telegram-planning
- 2026-09-03 10:35 · Trucie · main · dọn index skill (composio→vendor-skills, -92.6%) + wire skill 1 nguồn + 4 agent primary
- 2026-09-03 10:40 · Trucie · main · them BAO-CAO-DON-SKILL.md truoc push
- 2026-09-03 11:5x · Trucie · go VINCE-HOME — repo chi con 1 file dinh danh chung (CLAUDE.md goc); don link chet o README + obsidian/index + 4 file agent; archive day du o Trucie-BACKUP/backup/archived-notes/Vince-Home-retired-2026-09-03

## 2026-09-04 · toi uu token
- 2026-09-04 · LU · tach 3 doan dai trong CLAUDE.md (cach chia sub-agent, push checklist, bootstrap project moi) thanh 3 skill rieng (bootstrap-project, chia-sub-agent, push-checklist) - load theo yeu cau thay vi moi phien deu tra phi doc du khong dung toi. CLAUDE.md con lai chi giu Bat bien/Roster/con tro + 1 dong tro skill (95 dong, tu 113). Khong rotate log.md (moi 39 dong, chua toi nguong ~150) - ghi quy tac rotate vao index.md de ap dung dung luc

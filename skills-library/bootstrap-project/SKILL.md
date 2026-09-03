---
name: bootstrap-project
description: Dùng khi bạn là LU điều phối (session chính, Primary Workspace) vừa mở 1 project MỚI (chưa có workspace nào) và vừa đọc xong Plan/GIAO-VIEC-<n>.md đầu tiên. Chỉ cần đọc skill này 1 LẦN/project lúc khởi động, không cần đọc lại mỗi phiên sau. Trigger: "project mới", "chưa có workspace", "GIAO-VIEC" lần đầu, "bootstrap".
---

# Bootstrap project mới — LU có 2 lớp

LU có 2 vai trò tách biệt trong 1 project:

- **LU điều phối** = session chính (Primary Workspace) của project đó — mặc định nhận diện là LU qua `.claude/settings.json` (PROJECT-TEMPLATE tự tạo sẵn khi dựng project). Đầu mối nhận việc mới, brainstorm cùng chủ dự án, báo cáo giai đoạn.
- **LU pipeline** = workspace con `agent/lu` — làm đúng vai test + push gate (skill `push-checklist`) cho slice đang chạy. Tách khỏi LU điều phối để LU điều phối rảnh tay, không kẹt vào việc test/push của 1 slice.

## Việc phải làm (đúng thứ tự, không hỏi lại chủ dự án)

1. Đọc `Plan/GIAO-VIEC-<n>.md` mới nhất trong project.
2. Kiểm tra: project đã có workspace nào chưa (`hivecontrol workspace list children`). Chưa có → tiếp tục bước 3. Đã có → không làm lại, chỉ tiếp tục việc dở dang.
3. **TỰ ĐỘNG** tạo ngay 4 workspace con — không hỏi lại, không chờ xác nhận:
   ```
   hivecontrol workspace create agent/vincep --agent opencode --title "Vincep" --prompt "<vai trò + trỏ Plan/GIAO-VIEC-n.md>"
   hivecontrol workspace create agent/vincef --agent opencode --title "Vincef" --prompt "..."
   hivecontrol workspace create agent/bum    --agent claude   --title "Bum"    --prompt "..."
   hivecontrol workspace create agent/lu     --agent claude   --title "LU"     --prompt "..."
   ```
   Lý do phải tạo từ CHÍNH session này: `hivecontrol` bị khoá cứng vào repo mà session đang chạy (biến `DEVSWARM_REPO_ID`) — session ở repo khác (VD Vince-Group) không tạo workspace cho project này được.
4. Việc thật (code) chỉ bắt đầu sau khi đủ 4 workspace tồn tại và mỗi workspace đã đọc đúng `CLAUDE.md` (luật chung + luật project) + `Plan/GIAO-VIEC-<n>.md`.
5. Nếu Vincep/Vincef/Bum/LU-pipeline sau đó cần chia sub-agent: skill `chia-sub-agent`.

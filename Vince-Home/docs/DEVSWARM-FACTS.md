# DEVSWARM — SU THAT DA KIEM CHUNG (khoi doc goc 2026-09-03)

> Claude Code: doc file nay truoc khi noi bat cu dieu gi ve DevSwarm. **Don guoc do = dung.**
> Nguon: `github.com/devswarm-ai/devswarm` — `docs/how-it-works.md`, `docs/faq.md`, `docs/getting-started.md`.

## 1. DevSwarm LA GÌ

**ADE (AI Development Environment)** cho **parallel AI coding**. Khong phai agent framework, khong phai "sếp chia việc".

**Workspace** = don vi core = **1 Git worktree cô lập + 1 branch + 1 AI terminal + 1 editor**, cong voi **port rieng** (`PORT`, `API_PORT`, `DATABASE_PORT`) de chay cung 1 ung dung o nhieu workspace khong dung do.

2 che do: **Build Mode** (`Ctrl+1`) · **Review Mode** (`Ctrl+2` — diff so voi source branch). Mo editor ngoai (Cursor, JetBrains) bang `Ctrl+5`.

## 2. NHUNG THU DEVSWARM **KHONG** Lam (de anh khoi ky vong sai)

- **KHONG tu sinh sub-agent / child.** Folder cha khong tu chia task. Muon 4 con = **tao 4 workspace, bam tay tung cai**.
- **KHONG ke thua folder cha theo kieu "bo nho chung".** Cac workspace **khong thay nhau**, chi gap nhau qua **commit/push** hoac **file `Plan/`**.
- **KHONG phai A2A host.** No quan ly worktree + terminal + diff. A2A that su can **lop bridge rieng**.
- **KHONG phai IDE thay the** — no khong debug, khong có extension nhu VS Code.
- **Tu** duoc ghi ro: *"built for coder-in-the-loop development, not vibe coding"* → van can mot nguoi chi dao. Do la **anh**.

## 3. NHUNG THU NO AUTO (du)

- **Tự detect** CLI assistant da cai may (danh sach ho tro: Claude Code, Gemini, Amazon Q, OpenAI Codex, GitHub Copilot, Cursor CLI, Goose, Aider, Amp, **Open Code**, **Qwen Code**).
- **Nhan dien context** tu **PR GitHub / Jira issue** → don vao assistant tu dong.
- **OAuth** GitHub/Jira · **khong proxy prompt** qua server cua hang · **code nam may ban** · data nhay **encrypt at rest** OS.

## 4. CAU HINH YEU CAU (docs `getting-started.md`)

- **macOS hoac Windows** (Windows **ho tro repo nam trong WSL** — day la **lua chon**, KHONG phai dieu kien bat buoc). **Native Linux chua ho tro** (moi tracking issue cong dong).
- **Git** trong `PATH`.
- **It nhat 1 CLI-based AI assistant** da cai.

➜ **Ket luan cho vụ "opencode go required WSL":** docs **khong yeu cau WSL**. WSL chi la mot kieu duong dan repo duoc ho tro. Neu may anh bao bat buoc, do nhieu kha nang la **duong dan Windows cua `opencode` chua trong `PATH`** (kiem tra: `where opencode` trong cmd).

## 5. VI SAO **KHONG** DOI SANG CURSOR / ANTIGRAVITY (da verify docs goc)

| | Cursor | Antigravity |
|---|---|---|
| **Custom base URL** (de nap `opencode.ai/zen/go/v1`) | ❌ docs `help/models-and-usage/api-keys`: chi **5 provider** — OpenAI, Anthropic, Google, Azure OpenAI, AWS Bedrock. **Khong có ô base URL tu do** | ❌ docs `/docs/models`: model theo **danh sach co dinh**, model khac cua stack ghi ro **"khong tuy chinh duoc"**; model ben 3 can goi **Ultra** |
| **Lane Go** (Vincep qwen-flash + Vincef deepseek) | ❌ **khong có cho ngoi** — doi key OpenAI/Anthropic that, khong phai endpoint Go | ❌ **khong có cho ngoi** |
| **Code di qua dau** | ⚠️ docs: **moi request duoc route qua server Cursor** de dung prompt cuoi, key gui kem tung request, **ZDR khong ap dung khi BYOK** | ⚠️ di qua Google |
| Model trong docs | co `claude-sonnet-5`/`opus-5` **nhung hang cua Cursor**, tinh vao goi Cursor — **khong** tieu sub Anthropic cua anh | chi toi **Claude Sonnet 4.6 / Opus 4.6 (thinking)** — **khong phai 5** |

➜ **Cả 2 rớt gate #1 (nap key Go).** Trong 3 phuong an, **chỉ DevSwarm chua duoc ca 4 con**. Doi host = **doi model cho Vincep/Vincef** = **thay nguoi, khong phai thay nha**.

➜ **Cho anh van dung:** Cursor/VS Code **mo song song** cho **cong viec TAY cua anh** (`Ctrl+5` tu DevSwarm), 4 workspace agent van chay CLI trong DevSwarm. **Hai thu dung canh nhau, khong loai tru nhau.**

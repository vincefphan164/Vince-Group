#!/usr/bin/env bash
# link-skills.sh — nhat skills-library/ vao Claude Code (ban POSIX cho macOS/Linux/Debian)
#
# Doi tac voi tools/link-skills.ps1 (Windows dung Junction). O day dung symlink
# thong thuong (khong can quyen dac biet tren *nix).
#
# Chay 1 lan moi may, o bat ky dau trong repo:  bash tools/link-skills.sh
# Kiem tra trang thai:                          bash tools/link-skills.sh --check
#
# AN TOAN: chi dong tac .claude/skills. KHONG bao gio cham
# .claude/agents, .claude/settings*.json, hay file nao khac.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="$REPO_ROOT/skills-library"   # NGUON duy nhat (khong phai vendor-skills)
LINK="$REPO_ROOT/.claude/skills"     # SYMLINK

state() {
  if [ -L "$LINK" ]; then echo symlink
  elif [ -d "$LINK" ]; then echo real-dir
  elif [ -e "$LINK" ]; then echo file
  else echo missing; fi
}

resolve() { [ -L "$LINK" ] && readlink -f "$LINK" || true; }

if [ "${1:-}" = "--check" ] || [ "${1:-}" = "-Check" ]; then
  echo "repo  : $REPO_ROOT"
  if [ -d "$TARGET" ]; then echo "target: $TARGET  [OK]"; else echo "target: $TARGET  [MISSING]"; fi
  ST="$(state)"
  echo "link  : $LINK -> $ST"
  if [ -n "$(resolve)" ]; then echo "symlink tro toi: $(resolve)"; fi
  if [ "$ST" = "symlink" ]; then
    case "$(resolve)" in
      *vendor-skills*) echo "LOI: symlink dang tro vendor-skills!"; exit 1 ;;
    esac
    exit 0
  fi
  if [ "$ST" = "missing" ]; then exit 2; fi
  exit 3
fi

[ -d "$TARGET" ] || { echo "Lo: khong thay $TARGET — chay tu trong repo." >&2; exit 1; }

mkdir -p "$REPO_ROOT/.claude"
case "$(state)" in
  symlink)
    rm "$LINK"                                  # chỉ xoá symlink, không đụng nội dung nguồn
    echo "Da xoa symlink cu."
    ;;
  missing) : ;;
  *)
    echo "Lo: '.claude/skills' hien la $(state) that (khong phai symlink) — de tay khong pha." >&2
    echo "Tu tay xoa/doi ten roi chay lai." >&2
    exit 1
    ;;
esac

ln -s "$TARGET" "$LINK"
echo "OK: .claude/skills => skills-library (symlink). Chay '--check' de do."

#!/usr/bin/env bash
# push-gate.sh — 6 dieu kien truoc khi push (§8 CLAUDE.md / L5)
# Cach dung: bash tools/push-gate.sh Plan/PUSH-3.md   (khong tham so = quat moi Plan/PUSH-*.md)
set -uo pipefail
fail=0
note() { printf '  %s\n' "$1"; }
bad()  { printf '  [FAIL] %s\n' "$1"; fail=1; }

plans=()
if [ "$#" -ge 1 ]; then plans=("$@"); else mapfile -t plans < <(ls Plan/PUSH-*.md 2>/dev/null); fi
[ "${#plans[@]}" -eq 0 ] && { echo "[FAIL] khong co Plan/PUSH-<n>.md nao — khong co gi de push"; exit 1; }

for f in "${plans[@]}"; do
  [ -f "$f" ] || { bad "$f khong ton tai"; continue; }
  echo "== $f =="
  n=$(basename "$f" | sed -E 's/PUSH-([0-9]+).*/\1/')
  rv="Plan/REVIEW-$n.md"

  # 1 thawed
  if [ -f "$rv" ] && grep -q '^STATE: thawed' "$rv"; then note "[ok] REVIEW-$n = thawed"; else bad "1. $rv thieu 'STATE: thawed' (van an toan chua mo)"; fi

  # 2 test co lenh + output
  if awk '/^## Lệnh test/{f=1;next} /^```/{c++} f&&c==2&&NF&&!/^```/{ok=1} END{exit !ok}' "$f"; then
    note "[ok] co output lenh test"
  else
    bad "2. thieu output lenh test trong '## Lệnh test + output'"
  fi

  # 3 khong secret
  if git diff --cached --name-only 2>/dev/null | grep -qiE '\.env$|secret|\.pem$|\.key$'; then
    bad "3. co file nghi chua secret trong staging"
  else note "[ok] staging khong co file nghi secret"; fi
  if grep -qriE '(sk-[A-Za-z0-9]{16,}|ghp_[A-Za-z0-9]{16,})' "$f" 2>/dev/null; then bad "3b. co chuoingiy la key trong $f"; fi

  # 4 file dung toi phai duoc khai
  gv="Plan/GIAO-VIEC-$n.md"
  if [ -f "$gv" ] && grep -q '^## KHAI FILE' "$gv"; then
    note "[ok] co khai file"
    while read -r p; do
      [ -z "$p" ] && continue
      grep -qF -- "$p" "$gv" || bad "4. `$p` duoc dung nhung khong co trong KHAI FILE"
    done < <(git diff --name-only 2>/dev/null | grep -v '^Plan/' || true)
  else bad "4. $gv thieu muc 'KHAI FILE'"; fi

  # 5 bao cao debate
  ls Plan/DEBATE-$n-BAOCAO.md >/dev/null 2>&1 || bad "5. thieu Plan/DEBATE-$n-BAOCAO.md"

  # 6 log
  if grep -q "^\- \`LU:" obsidian/log.md 2>/dev/null; then note "[ok] log LU co dong"; else bad "6. obsidian/log.md chua co dong 'LU: <viec>'"; fi

  # 7 cot loi: tick du 6 o
  t=$(grep -c '^\- \[x\]' "$f")
  [ "$t" -ge 6 ] && note "[ok] $t/6 o duoc tick" || bad "thieu o: $t/6 duoc tick"
done

echo
if [ "$fail" -eq 0 ]; then echo "GATE XANH — du dieu kien push."; else echo "GATE DO — DUNG. Sua xong chay lai."; fi
exit $fail

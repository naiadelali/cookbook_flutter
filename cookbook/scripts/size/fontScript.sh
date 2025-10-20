#!/usr/bin/env bash
set -euo pipefail

# --- CONFIGURAÇÃO ---
JSON_FILE="large.json"
PROJECT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)

# detecta a pasta onde este script está localizado
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# define path para reference.json em ../color
REF_JSON="$SCRIPT_DIR/../color/reference.json"

if [[ ! -f "$REF_JSON" ]]; then
  echo "❌ Não achei reference.json em $SCRIPT_DIR/../color" >&2
  exit 1
fi

OUTPUT_DIR="$PROJECT_ROOT/cookbook/modules/ds/lib/src/tokens"
mkdir -p "$OUTPUT_DIR"

# rem_to_dp: 1rem → 16.0
rem_to_dp() {
  local rem="${1%rem}"
  awk "BEGIN{ printf \"%.1f\", $rem * 16 }"
}

# ------------------------------------------------------------------------
# 1) Gera app_font_size.dart
# ------------------------------------------------------------------------
OUT="$OUTPUT_DIR/app_font_size.dart"
cat > "$OUT" <<EOF
class AppFontSize {
  AppFontSize._();
EOF

jq -r '.dim.fontSize 
      | to_entries[] 
      | "\(.key)\t\(.value.value)"' "$JSON_FILE" \
| while IFS=$'\t' read -r name raw; do
  dp=$(rem_to_dp "$raw")
  echo "  static final double $name = $dp;" >> "$OUT"
done

echo "}" >> "$OUT"
echo "✅ Gerado $OUT"

# ------------------------------------------------------------------------
# 2) Gera app_letter_spacing.dart
# ------------------------------------------------------------------------
OUT="$OUTPUT_DIR/app_letter_spacing.dart"
cat > "$OUT" <<EOF
class AppLetterSpacing {
  AppLetterSpacing._();
EOF

jq -r '.dim.letterSpacing 
      | to_entries[] 
      | "\(.key)\t\(.value.value)"' "$JSON_FILE" \
| while IFS=$'\t' read -r name raw; do
  dp=$(rem_to_dp "$raw")
  echo "  static double get $name => $dp;" >> "$OUT"
done

echo "}" >> "$OUT"
echo "✅ Gerado $OUT"

# ------------------------------------------------------------------------
# 3) Gera app_line_height.dart (percentual → fator relativo ao x100)
# ------------------------------------------------------------------------
# pega base x100 (ex: "1.00rem"), chave pode ter comentário "(Use 100%)"
base_rem=$(jq -r '.dim.lineHeight
                   | to_entries[]
                   | select(.key | test("^x100"))
                   | .value.value' "$JSON_FILE")
base_rem=${base_rem%rem}

OUT="$OUTPUT_DIR/app_line_height.dart"
cat > "$OUT" <<EOF
class AppLineHeight {
  AppLineHeight._();
EOF

jq -r '.dim.lineHeight
      | to_entries[]
      | "\(.key)\t\(.value.value)"' "$JSON_FILE" \
| while IFS=$'\t' read -r rawName raw; do
  name=${rawName%% *}        # tira comentário "(Use 125%)"
  rem_val=${raw%rem}
  factor=$(awk "BEGIN{ printf \"%.2f\", $rem_val / $base_rem }")
  echo "  static double get $name => $factor;" >> "$OUT"
done

echo "}" >> "$OUT"
echo "✅ Gerado $OUT"

# ------------------------------------------------------------------------
# 4) Gera app_font_family.dart
# ------------------------------------------------------------------------
OUT="$OUTPUT_DIR/app_font_family.dart"
cat > "$OUT" <<EOF
class AppFontFamily {
  AppFontFamily._();
EOF

jq -r '.ref.font.family 
      | to_entries[] 
      | "\(.key)\t\(.value.value)"' "$REF_JSON" \
| while IFS=$'\t' read -r key value; do
  echo "  static const String $key = '$value';" >> "$OUT"
done

echo "}" >> "$OUT"
echo "✅ Gerado $OUT"

# ------------------------------------------------------------------------
# 5) Gera app_font_weight.dart
# ------------------------------------------------------------------------
OUT="$OUTPUT_DIR/app_font_weight.dart"
cat > "$OUT" <<EOF
import 'package:flutter/widgets.dart';

class AppFontWeight {
  AppFontWeight._();
EOF

jq -r '.ref.font.weight 
      | to_entries[] 
      | "\(.key)\t\(.value.value)"' "$REF_JSON" \
| while IFS=$'\t' read -r key display; do
]
  case "$key" in
    thin)         fw="w100";;
    extralight|extralight) fw="w200";;
    light)        fw="w300";;
    regular)      fw="w400";;
    medium)       fw="w500";;
    semibold|semibold) fw="w600";;
    bold)         fw="w700";;
    extrabold|extrabold) fw="w800";;
    black)        fw="w900";;
    *)            fw="$key";;
  esac
  echo "  static const FontWeight $key = FontWeight.$fw;" >> "$OUT"
done

echo "}" >> "$OUT"
echo "✅ Gerado $OUT"

#!/usr/bin/env bash
set -euo pipefail

# Caminhos
JSON_FILE="typography.json"
PROJECT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
OUTPUT_DIR="$PROJECT_ROOT/cookbook/modules/ds/lib/src/tokens"
OUTPUT_DART="$OUTPUT_DIR/app_typography.dart"

# Garante que a pasta de saída exista
mkdir -p "$OUTPUT_DIR"

# --- Funções auxiliares ---

# extrai o identificador após o último ponto em algo como "{ref.font.weight.medium}"
extract_key() {
  echo "$1" | sed -E 's/.*\.([^ \}]+).*/\1/'
}

# snake_case ou kebab-case → lowerCamelCase
lower_camel() {
  echo "$1" \
    | sed -E 's/[-_]+/ /g' \
    | awk '{
        for(i=1;i<=NF;i++){
          if(i==1){
            $i = tolower(substr($i,1,1)) substr($i,2)
          } else {
            $i = toupper(substr($i,1,1)) substr($i,2)
          }
        }
      }1' \
    | tr -d ' '
}

# --- Cabeçalho do Dart ---
cat > "$OUTPUT_DART" <<EOF
import 'package:ds/src/tokens/app_font_weight.dart';
import 'package:flutter/widgets.dart';
import 'app_font_family.dart';
import 'app_font_size.dart';
import 'app_line_height.dart';
import 'app_letter_spacing.dart';

class AppTypography {
  AppTypography._();
EOF

# --- Geração dos getters via jq + bash ---
jq -r '
  to_entries[] as $grp |
  $grp.key as $group |
  $grp.value | to_entries[] as $var |
  $var.key as $variant |
  $var.value | to_entries[] as $sizeEntry |
  $sizeEntry.key as $size |
  $sizeEntry.value.value as $v |
  [
    $group, $variant, $size,
    $v.fontFamily, $v.fontWeight,
    $v.fontSize,   $v.lineHeight, $v.letterSpacing
  ] | @tsv
' "$JSON_FILE" | while IFS=$'\t' read -r group variant size ff fw fs lh ls; do

  getterName=$(lower_camel "${group}_${variant}_${size}")
  ffKey=$(extract_key "$ff")
  fwKey=$(extract_key "$fw")
  fsKey=$(extract_key "$fs")
  lhKey=$(extract_key "$lh")
  lsKey=$(extract_key "$ls")

  cat >> "$OUTPUT_DART" <<EOF

  static TextStyle get $getterName => TextStyle(
    fontFamily: AppFontFamily.$ffKey,
    fontWeight: AppFontWeight.$fwKey,
    fontSize: AppFontSize.$fsKey,
    height: AppLineHeight.$lhKey,
    letterSpacing: AppLetterSpacing.$lsKey,
  );
EOF

done

# --- Rodapé do Dart ---
cat >> "$OUTPUT_DART" <<EOF
}
EOF

echo "✅ Gerado $OUTPUT_DART"

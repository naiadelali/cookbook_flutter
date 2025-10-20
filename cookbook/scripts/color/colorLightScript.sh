#!/bin/bash

# Caminho do arquivo JSON
JSON_FILE="light.json"

# Obtém o diretório raiz do projeto
PROJECT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
OUTPUT_DIR="$PROJECT_ROOT/cookbook/modules/ds/lib/src/tokens/color"

OUTPUT_COLOR_SCHEME_FILE="$OUTPUT_DIR/color_light_scheme.dart"
# Cria o diretório, se não existir
rm -r "$OUTPUT_COLOR_SCHEME_FILE"; mkdir -p "$OUTPUT_DIR"

# Gera o cabeçalho do arquivo dart (com package dinâmico)
echo "import 'dart:ui';" > "$OUTPUT_COLOR_SCHEME_FILE"
echo "import 'color.dart';" >> "$OUTPUT_COLOR_SCHEME_FILE"
echo "import 'app_color.dart';" >> "$OUTPUT_COLOR_SCHEME_FILE"
echo "" >> "$OUTPUT_COLOR_SCHEME_FILE"

# Função para converter nomes para CamelCase
upper_first_char() {
  echo "$1" | awk -F'_' '{for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1)) substr($i,2)}}1 ' OFS=''
}

lower_first_char() {
  echo "$1" | awk -F'_' '{for(i=1;i<=NF;i++){$i=tolower(substr($i,1,1)) substr($i,2)}}1 ' OFS=''
}

# Processa cada grupo de cores (primeiro nível após .color)
for group in $(jq -r '.color | keys[]' "$JSON_FILE"); do

  # Descobre se o grupo é light ou dark pelo filePath
  FILE_PATH=$(jq -r ".color[\"$group\"] | to_entries[0].value.filePath" "$JSON_FILE")
  echo $FILE_PATH

  if [[ "$group" == "surface" ]]; then
    FUNCTION_NAME="surface${SCHEME}LightColorScheme"
    echo "SurfaceColorScheme $FUNCTION_NAME() => SurfaceColorScheme(" >> "$OUTPUT_COLOR_SCHEME_FILE"
  elif [[  "$group" == "neutral" ]]; then
    FUNCTION_NAME="neutral${SCHEME}LightColorScheme"
     echo "NeutralColorScheme $FUNCTION_NAME() => NeutralColorScheme(" >> "$OUTPUT_COLOR_SCHEME_FILE"
  else
    FUNCTION_NAME="${group}${SCHEME}LightColorScheme"
    echo "AppColorScheme $FUNCTION_NAME() => AppColorScheme(" >> "$OUTPUT_COLOR_SCHEME_FILE"
  fi

  # Processa cada chave dentro do grupo atual
  jq -r ".color[\"$group\"] | keys[]" "$JSON_FILE" | while read -r key; do
    original_value=$(jq -r ".color[\"$group\"][\"$key\"].value // empty" "$JSON_FILE")

    if [[ -z "$original_value" ]]; then
      echo "Aviso: original.value não encontrado para $group -> $key. Pulando..."
      continue
    fi

    if [[ "$original_value" =~ ^\{ref\.color\.([a-zA-Z0-9_]+)\.([a-zA-Z0-9_]+)\}$ ]]; then
        ref_group="${BASH_REMATCH[1]}"
            ref_key="${BASH_REMATCH[2]}"
            ref_value="$(lower_first_char $ref_group)$(upper_first_char $ref_key)"

            if [[ $key == "default" ]]; then
              echo "    defaults: $ref_value," >> "$OUTPUT_COLOR_SCHEME_FILE"
            else
              echo "    $key: $ref_value," >> "$OUTPUT_COLOR_SCHEME_FILE"
              fi
    elif [[ "$original_value" =~ ^\{color\.([a-zA-Z0-9_]+)\.([a-zA-Z0-9_]+)\}$ ]]; then
       echo "    $key: $ref_value," >> "$OUTPUT_COLOR_SCHEME_FILE"
    else
        # Se for um valor direto, converte para Color(0xFFFFFF00) removendo o '#'
            hex_value=$(echo "$original_value" | sed 's/#//')
            inverted_hex_value=$(echo "$hex_value" | sed 's/^\(.*\)\(..\)$/\2\1/')
            echo "    $key: Color(0x$inverted_hex_value)," >> "$OUTPUT_COLOR_SCHEME_FILE"
    fi
  done
  echo ");" >> "$OUTPUT_COLOR_SCHEME_FILE"
  echo "" >> "$OUTPUT_COLOR_SCHEME_FILE"
done

echo "Arquivo dart gerado em: $OUTPUT_COLOR_SCHEME_FILE"

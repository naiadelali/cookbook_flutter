#!/bin/bash

JSON_FILE="large.json"
PROJECT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
OUTPUT_DIR="$PROJECT_ROOT/cookbook/modules/ds/lib/src/tokens"

# Função para converter nomes para CamelCase
upper_first_char() {
  echo "$1" | awk -F'_' '{for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1)) substr($i,2)}}1 ' OFS=''
}

# Transforma camelcase em snakecase
to_snake_case() {
  local input="$1"
  echo "$input" | sed -E 's/([A-Z])/_\1/g' | awk '{print tolower($0)}'
}

generate_variables() {
  if [[ $2 == *"{"* ]]; then
    value=$2
    cleaned="${value##*.}"   # remove até o último ponto
    formated_value="${cleaned%\}}"  # remove a chave final, se necessário
    echo "${indent}static double get $key => $formated_value;" >> "$OUTPUT_FILE"
  else
    numeric_value=$(echo "$2" | sed 's/rem//g')
    if [[ $numeric_value == 9999 ]]; then
      dp_value_clean="double.infinity"
    else
      dp_value=$(echo "scale=2; $numeric_value * 16" | bc -l)
      dp_value_clean=$(printf "%.1f" "$dp_value")
    fi

    if [[ $1 == "default" ]]; then
      echo "${indent}static double get defaults => ${dp_value_clean};" >> "$OUTPUT_FILE"
    else
      echo "${indent}static double get $1 => ${dp_value_clean};" >> "$OUTPUT_FILE"
    fi
  fi
}

generate_dart_properties() {
  local json_path=$1
  local indent=$2

  jq -c "$json_path | to_entries[]" "$JSON_FILE" | while read -r entry; do
    local key=$(echo "$entry" | jq -r '.key')
    local type=$(echo "$entry" | jq -r '.value.type // empty')
    local value=$(echo "$entry" | jq -r '.value.value // empty')
    local is_object=$(echo "$entry" | jq -r '.value | type')

    if [[ ($key == "global") || ($key == "custom" && $json_path == ".dim.spacing") ]]; then
      generate_dart_properties "$json_path.$key" "  "
      echo "" >> "$OUTPUT_FILE"
    elif [[ $key == "custom" || $key == "shape" || $key == "icon" ]]; then
      jq -c "$json_path.$key | to_entries[]" "$JSON_FILE" | while read -r entry; do
          local subKey=$(echo "$entry" | jq -r '.key')
          local value=$(echo "$entry" | jq -r '.value.value // empty')

          local cleaned="${value##*.}"   # remove até o último ponto
          local formated_value="${cleaned%\}}"  # remove a chave final, se necessário
          local formated_key=$key$(upper_first_char "$subKey")
          if [[ $key == "custom" ]]; then
            echo "${indent}static double get $subKey => $formated_value;" >> "$OUTPUT_FILE"
          else
            echo "${indent}static double get $formated_key => $formated_value;" >> "$OUTPUT_FILE"
          fi
      done
    else
      generate_variables $key $value
    fi
  done
}

upper_first_char() {
  echo "$1" | awk -F'_' '{for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1)) substr($i,2)}}1 ' OFS=''
}

jq -c ".dim | to_entries[]" "$JSON_FILE" | while read -r entry; do
  key=$(echo "$entry" | jq -r '.key')
  if [[ $key != "fontSize" && $key != "lineHeight" && $key != "letterSpacing" && $key != "opacity" && $key != "grid" ]]; then
    echo "$OUTPUT_DIR/app_$(to_snake_case $key).dart"
    OUTPUT_FILE="$OUTPUT_DIR/app_$(to_snake_case $key).dart"
    # Cria o diretório, se não existir e apaga antigo
    rm -r "$OUTPUT_FILE"; mkdir -p "$OUTPUT_DIR"

    # Cabeçalho do arquivo Kotlin (usando package dinâmico)
    echo "class App$(upper_first_char $key) {" >> "$OUTPUT_FILE"
    echo "  App$(upper_first_char $key)._();" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"

    generate_dart_properties ".dim.$key" "  "

    echo "}" >> "$OUTPUT_FILE"

    echo "✅ $key.dart gerado com sucesso!"
  fi
done
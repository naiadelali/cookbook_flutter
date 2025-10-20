#!/bin/bash

echo "Gerando localizações na raiz do projeto"
flutter gen-l10n || true

cd ..

# Navegando pelos módulos
if [ -d "modules" ]; then
  cd modules || exit
  echo "Entrando em modules"

  for d in *; do
    if [ -d "$d" ]; then
      echo "Entrando em $d"
      cd "$d" || exit

      for m in *; do
        if [ -d "$m" ]; then
          echo "Gerando localizações em $m"
          cd "$m" || exit

          # Verifique se é um projeto Flutter válido antes de executar o comando
          if [ -f "pubspec.yaml" ]; then
            flutter gen-l10n || true
          else
            echo "Aviso: Nenhum pubspec.yaml encontrado em $m. Pulando..."
          fi

          cd .. || exit
        fi
      done

      cd .. || exit
    fi
  done
else
  echo "Diretório 'modules' não encontrado. Pulando a geração de localizações nos módulos."
fi
# Flutter Cookbook App

Flutter application template with Clean Architecture and custom Design System.

## 🚀 Quick Start

```bash
# Install dependencies
flutter pub get

# Run app
flutter run

# Run tests
flutter test
```

## 🔑 Test Login

Use these credentials to test:
- **Email**: `test@example.com`, `eve.holt@reqres.in` or `admin@admin.com`
- **Password**: Any password

## 📚 Full Documentation

See the [main README](../README.md) for complete documentation.

## 🏗️ Structure

```
lib/                    # Main application code
├── app_widget.dart    # Root widget
├── main.dart          # Entry point
├── navigation/        # Routes and navigation
└── l10n/             # Localization

modules/               # Project modules
├── core/             # Core modules
│   ├── common/       # Shared utilities
│   ├── data/         # Repositories and use cases
│   ├── database/     # Local storage
│   └── network/      # HTTP client
├── ds/               # Design System
└── feature/          # App features
    ├── auth/         # Authentication
    └── home/         # Home

assets/               # Static resources
├── images/          # Images and logos
└── fonts/           # Custom fonts
```

## 🛠️ Useful Commands

```bash
# Clean build
flutter clean

# Code analysis
flutter analyze

# Format code
flutter format .

# Generate code (models, etc)
flutter pub run build_runner build --delete-conflicting-outputs

# Generate localization
flutter gen-l10n

# Production build
flutter build apk --release          # Android
flutter build ios --release          # iOS
flutter build web --release          # Web
```

## 📦 Modules

### Core
- **common**: Models, helpers, failures, navigation
- **data**: Repositories, use cases
- **database**: Session manager, storage adapter
- **network**: HTTP adapter, data sources, interceptors

### Features
- **auth**: Login, sign in page, authentication logic
- **home**: Home page, examples

### Design System
- **ds**: UI components, themes, colors, typography

## 🔧 Configuration

### Environment Variables
Create `.env` at root:
```
BASE_URL=https://your-api.com
```

### Firebase (Optional)
Replace placeholders in:
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- Uncomment initialization in `lib/main.dart`

## 📝 Best Practices

- ✅ Always run `flutter analyze` before committing
- ✅ Keep test coverage high
- ✅ Use const widgets when possible
- ✅ Follow project naming conventions
- ✅ Document complex code

## 🐛 Troubleshooting

**App won't compile?**
```bash
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter run
```

**Hot reload not working?**
- Press `R` in terminal for hot restart

**Dependency errors?**
```bash
flutter pub upgrade
```

---

For more information, see the [complete documentation](../README.md).

---

# Flutter Cookbook App

Template de aplicação Flutter com Clean Architecture e Design System customizado.

## 🚀 Início Rápido

```bash
# Instalar dependências
flutter pub get

# Executar app
flutter run

# Executar testes
flutter test
```

## 🔑 Login de Teste

Use estas credenciais para testar:
- **Email**: `test@example.com`, `eve.holt@reqres.in` ou `admin@admin.com`
- **Senha**: Qualquer senha

## 📚 Documentação Completa

Veja o [README principal](../README.md) para documentação detalhada.

## 🏗️ Estrutura

```
lib/                    # Código da aplicação principal
├── app_widget.dart    # Widget raiz
├── main.dart          # Ponto de entrada
├── navigation/        # Rotas e navegação
└── l10n/             # Localização

modules/               # Módulos do projeto
├── core/             # Módulos core
│   ├── common/       # Utilitários compartilhados
│   ├── data/         # Repositories e use cases
│   ├── database/     # Storage local
│   └── network/      # Cliente HTTP
├── ds/               # Design System
└── feature/          # Features do app
    ├── auth/         # Autenticação
    └── home/         # Home

assets/               # Recursos estáticos
├── images/          # Imagens e logos
└── fonts/           # Fontes customizadas
```

## 🛠️ Comandos Úteis

```bash
# Limpar build
flutter clean

# Análise de código
flutter analyze

# Formatar código
flutter format .

# Gerar código (models, etc)
flutter pub run build_runner build --delete-conflicting-outputs

# Gerar localização
flutter gen-l10n

# Build de produção
flutter build apk --release          # Android
flutter build ios --release          # iOS
flutter build web --release          # Web
```

## 📦 Módulos

### Core
- **common**: Models, helpers, failures, navigation
- **data**: Repositories, use cases
- **database**: Session manager, storage adapter
- **network**: HTTP adapter, data sources, interceptors

### Features
- **auth**: Login, página de sign in, lógica de autenticação
- **home**: Página inicial, exemplos

### Design System
- **ds**: Componentes UI, temas, cores, tipografia

## 🔧 Configuração

### Variáveis de Ambiente
Crie `.env` na raiz:
```
BASE_URL=https://sua-api.com
```

### Firebase (Opcional)
Substitua placeholders em:
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- Descomente inicialização em `lib/main.dart`

## 📝 Boas Práticas

- ✅ Sempre execute `flutter analyze` antes de commitar
- ✅ Mantenha cobertura de testes alta
- ✅ Use widgets const quando possível
- ✅ Siga convenções de nomenclatura do projeto
- ✅ Documente código complexo

## 🐛 Resolução de Problemas

**App não compila?**
```bash
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter run
```

**Hot reload não funciona?**
- Pressione `R` no terminal para hot restart

**Erros de dependência?**
```bash
flutter pub upgrade
```

---

Para mais informações, consulte a [documentação completa](../README.md).

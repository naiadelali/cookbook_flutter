# Flutter Cookbook Template 📱

A modern Flutter application template with clean architecture, modular design, and production-ready features.

---

## 🚀 Features

- ✅ **Clean Architecture** - Separation of concerns with layers (Data, Domain, Presentation)
- ✅ **Modular Design** - Feature-based modules for scalability
- ✅ **Custom Design System** - Beautiful, customizable UI components
- ✅ **Authentication** - Login flow with session management
- ✅ **State Management** - Using BLoC/Cubit pattern
- ✅ **Internationalization** - Multi-language support (PT/EN ready)
- ✅ **Testing** - Unit tests with 24+ passing tests
- ✅ **Type-safe Navigation** - Using go_router
- ✅ **Secure Storage** - Encrypted local storage for sensitive data
- ✅ **Network Layer** - HTTP client with interceptors

## 📁 Project Structure

```
flutter-cookbook/
├── cookbook/                      # Main application
│   ├── lib/                      # App-level code
│   ├── assets/                   # Images, fonts, etc
│   └── modules/                  # Feature modules
│       ├── core/                 # Core modules
│       │   ├── common/          # Shared utilities
│       │   ├── data/            # Data layer
│       │   ├── database/        # Local storage
│       │   └── network/         # Network layer
│       ├── ds/                   # Design System
│       ├── feature/              # Feature modules
│       │   ├── auth/            # Authentication
│       │   └── home/            # Home screen
│       └── shared_dependencies/ # Shared packages
└── README.md                     # This file
```

## 🛠 Getting Started

### Prerequisites

- Flutter SDK >= 3.6.2
- Dart >= 3.6.2
- iOS development: Xcode (for iOS/macOS)
- Android development: Android Studio

### Installation

1. **Clone the repository**

   ```bash
   git clone [your-repo-url]
   cd flutter-cookbook
   ```

2. **Install dependencies**

   ```bash
   cd cookbook
   flutter pub get
   ```

3. **Run the app**

   ```bash
   # List available devices
   flutter devices
   
   # Run on specific device
   flutter run -d [device-id]
   
   # Or simply
   flutter run
   ```

## 🔐 Authentication Setup

The template includes a development bypass for testing. Use these credentials:

- **Email**: `eve.holt@reqres.in` or `test@example.com` or `admin@admin.com`
- **Password**: Any password (e.g., `123456`)

### Connecting to Your API

1. Update the base URL in `modules/core/common/lib/utils/env.dart`
2. Modify endpoints in `modules/core/network/lib/utils/api_constants.dart`
3. Remove or update the development bypass in `modules/core/network/lib/datasources/auth_data_source.dart`

## 🔥 Firebase Setup (Optional)

Firebase is currently disabled. To enable it:

1. **Create a Firebase project** at [console.firebase.google.com](https://console.firebase.google.com)

2. **Add your apps** (iOS/Android/Web) and download config files

3. **Replace placeholders** in:
   - `lib/firebase_options.dart`
   - `android/app/google-services.json`
   - `firebase.json`

4. **Uncomment Firebase initialization** in `lib/main.dart`:

   ```dart
   await _initializeFirebase(),
   ```

## 🧪 Running Tests

```bash
# Run all tests
cd cookbook
flutter test

# Run tests for specific module
cd modules/core/network
flutter test

# Run with coverage
flutter test --coverage
```

## 🎨 Design System

The app includes a custom design system with pre-built components:

- Buttons
- Text Fields
- Checkboxes
- Radio Buttons
- Switches
- Links
- Dividers
- And more...

Access examples by logging in and clicking "Design System Examples".

## 🌍 Localization

Add new translations in:

- `lib/l10n/app_en.arb` (English)
- `lib/l10n/app_pt.arb` (Portuguese)

Generate localization files:

```bash
flutter gen-l10n
```

## 📦 Adding New Features

1. Create a new module in `modules/feature/`
2. Follow the existing structure (lib, test, pubspec.yaml)
3. Register dependencies in the respective module
4. Add routes in `lib/navigation/app_routes.dart`

## 🏗 Building for Production

### Android

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

## 🔧 Configuration Files

Important configuration files to customize:

| File | Purpose |
|------|---------|
| `pubspec.yaml` | Dependencies and app metadata |
| `.env` | Environment variables (create if needed) |
| `lib/navigation/app_routes.dart` | Route configuration |
| `lib/main.dart` | App entry point |
| `modules/*/pubspec.yaml` | Module dependencies |

## 🐛 Troubleshooting

### Common Issues

**"Missing API key" error**

- The development bypass allows login without a real API
- Use the test credentials mentioned above

**Build fails on iOS**

- Make sure Xcode is installed and updated
- Run: `cd ios && pod install && pod update`
- Clean build: `flutter clean && flutter pub get`

**Hot reload not working**

- Press `R` in terminal for hot restart
- Or restart the app completely

## 📚 Learning Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Library](https://bloclibrary.dev/)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

## 📄 License

This project is a template and can be used freely for your projects.

---

# Flutter Cookbook Template 📱

Um template moderno de aplicação Flutter com arquitetura limpa, design modular e recursos prontos para produção.

---

## 🚀 Funcionalidades

- ✅ **Clean Architecture** - Separação de responsabilidades em camadas (Data, Domain, Presentation)
- ✅ **Design Modular** - Módulos baseados em features para escalabilidade
- ✅ **Design System Customizado** - Componentes UI bonitos e personalizáveis
- ✅ **Autenticação** - Fluxo de login com gerenciamento de sessão
- ✅ **Gerenciamento de Estado** - Usando padrão BLoC/Cubit
- ✅ **Internacionalização** - Suporte multi-idioma (PT/EN pronto)
- ✅ **Testes** - Testes unitários com 24+ testes passando
- ✅ **Navegação Type-safe** - Usando go_router
- ✅ **Armazenamento Seguro** - Storage local criptografado para dados sensíveis
- ✅ **Camada de Rede** - Cliente HTTP com interceptors

## 📁 Estrutura do Projeto

```
flutter-cookbook/
├── cookbook/                      # Aplicação principal
│   ├── lib/                      # Código da aplicação
│   ├── assets/                   # Imagens, fontes, etc
│   └── modules/                  # Módulos de features
│       ├── core/                 # Módulos core
│       │   ├── common/          # Utilitários compartilhados
│       │   ├── data/            # Camada de dados
│       │   ├── database/        # Armazenamento local
│       │   └── network/         # Camada de rede
│       ├── ds/                   # Design System
│       ├── feature/              # Módulos de features
│       │   ├── auth/            # Autenticação
│       │   └── home/            # Tela inicial
│       └── shared_dependencies/ # Pacotes compartilhados
└── README.md                     # Este arquivo
```

## 🛠 Começando

### Pré-requisitos

- Flutter SDK >= 3.6.2
- Dart >= 3.6.2
- Desenvolvimento iOS: Xcode
- Desenvolvimento Android: Android Studio

### Instalação

1. **Clone o repositório**

   ```bash
   git clone [url-do-seu-repo]
   cd flutter-cookbook
   ```

2. **Instale as dependências**

   ```bash
   cd cookbook
   flutter pub get
   ```

3. **Execute o app**

   ```bash
   # Listar dispositivos disponíveis
   flutter devices
   
   # Executar em dispositivo específico
   flutter run -d [device-id]
   
   # Ou simplesmente
   flutter run
   ```

## 🔐 Configuração de Autenticação

O template inclui um bypass de desenvolvimento para testes. Use estas credenciais:

- **Email**: `eve.holt@reqres.in` ou `test@example.com` ou `admin@admin.com`
- **Senha**: Qualquer senha (ex: `123456`)

### Conectando à Sua API

1. Atualize a base URL em `modules/core/common/lib/utils/env.dart`
2. Modifique os endpoints em `modules/core/network/lib/utils/api_constants.dart`
3. Remova ou atualize o bypass de desenvolvimento em `modules/core/network/lib/datasources/auth_data_source.dart`

## 🔥 Configuração do Firebase (Opcional)

O Firebase está atualmente desabilitado. Para habilitar:

1. **Crie um projeto Firebase** em [console.firebase.google.com](https://console.firebase.google.com)

2. **Adicione seus apps** (iOS/Android/Web) e baixe os arquivos de configuração

3. **Substitua os placeholders** em:
   - `lib/firebase_options.dart`
   - `android/app/google-services.json`
   - `firebase.json`

4. **Descomente a inicialização do Firebase** em `lib/main.dart`:

   ```dart
   await _initializeFirebase(),
   ```

## 🧪 Executando Testes

```bash
# Executar todos os testes
cd cookbook
flutter test

# Executar testes de módulo específico
cd modules/core/network
flutter test

# Executar com cobertura
flutter test --coverage
```

## 🎨 Design System

O app inclui um design system customizado com componentes pré-construídos:

- Botões
- Campos de Texto
- Checkboxes
- Radio Buttons
- Switches
- Links
- Dividers
- E mais...

Acesse os exemplos fazendo login e clicando em "Design System Examples".

## 🌍 Localização

Adicione novas traduções em:

- `lib/l10n/app_en.arb` (Inglês)
- `lib/l10n/app_pt.arb` (Português)

Gere os arquivos de localização:

```bash
flutter gen-l10n
```

## 📦 Adicionando Novas Features

1. Crie um novo módulo em `modules/feature/`
2. Siga a estrutura existente (lib, test, pubspec.yaml)
3. Registre as dependências no módulo respectivo
4. Adicione rotas em `lib/navigation/app_routes.dart`

## 🏗 Build para Produção

### Android

```bash
flutter build apk --release
# ou
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

## 🔧 Arquivos de Configuração

Arquivos importantes para customizar:

| Arquivo | Propósito |
|---------|-----------|
| `pubspec.yaml` | Dependências e metadados do app |
| `.env` | Variáveis de ambiente (criar se necessário) |
| `lib/navigation/app_routes.dart` | Configuração de rotas |
| `lib/main.dart` | Ponto de entrada do app |
| `modules/*/pubspec.yaml` | Dependências dos módulos |

## 🐛 Resolução de Problemas

### Problemas Comuns

**Erro "Missing API key"**

- O bypass de desenvolvimento permite login sem API real
- Use as credenciais de teste mencionadas acima

**Build falha no iOS**

- Certifique-se de que o Xcode está instalado e atualizado
- Execute: `cd ios && pod install && pod update`
- Limpe o build: `flutter clean && flutter pub get`

**Hot reload não funciona**

- Pressione `R` no terminal para hot restart
- Ou reinicie o app completamente

## 📚 Recursos de Aprendizado

- [Documentação Flutter](https://docs.flutter.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Library](https://bloclibrary.dev/)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

## 📄 Licença

Este projeto é um template e pode ser usado livremente para seus projetos.

## 🤝 Contribuindo

Sinta-se livre para customizar este template para suas necessidades!

---

**Happy Coding! 🎉**

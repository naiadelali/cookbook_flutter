# CLAUDE.md — Flutter Cookbook

## Índice

| # | Seção |
|---|-------|
| 1 | Visão geral, packages, convenções |
| 2 | Arquitetura |
| 3 | Imports |
| 4 | Gerenciamento de estado (Bloc/Cubit) |
| 5 | Responsabilidades Page vs Cubit |
| 6 | Métodos do Cubit |
| 7 | Componentização |
| 8 | Design System (componentes + tokens) |
| 9 | Navegação |
| 10 | Injeção de dependências |
| 11 | Criando módulos novos |
| 12 | UseCase pattern |
| 13 | Tratamento de erros (Failure) |
| 14 | Testes |
| — | Checklist code review |

---

## Visão geral do projeto

Monorepo Flutter com **Clean Architecture modular**. Cada camada tem responsabilidade clara e dependências unidirecionais.

```
cookbook/
├── lib/                        # App principal (entry point, GoRouter, DI)
├── modules/
│   ├── core/
│   │   ├── common/             # Models, navigation, failures, helpers, base cubit
│   │   ├── data/               # Repositories concretos, UseCases
│   │   ├── database/           # SharedPreferences, SecureStorage
│   │   └── network/            # Dio, interceptors, datasources HTTP
│   ├── feature/
│   │   ├── auth/               # Feature de autenticação
│   │   └── home/               # Feature home (bottom nav)
│   ├── ds/                     # Design System (tokens + componentes)
│   └── shared_dependencies/    # Barrel de dependências compartilhadas
```

### Nomes dos packages

| Package | Caminho |
|---|---|
| `core_common` | `modules/core/common` |
| `core_data` | `modules/core/data` |
| `core_network` | `modules/core/network` |
| `core_database` | `modules/core/database` |
| `ds` | `modules/ds` |
| `shared_dependencies` | `modules/shared_dependencies` |
| `auth` | `modules/feature/auth` |
| `home` | `modules/feature/home` |

### Convenções de nomenclatura

| Elemento | Padrão | Exemplo |
|---|---|---|
| **Arquivos** | `snake_case` | `sign_in_page.dart`, `profile_cubit.dart` |
| **Classes** | Sufixo por tipo | `SignInCubit`, `SignInState`, `ProfilePage`, `LoginUsecase`, `AuthRepository` |
| **Rotas** | Classe com constantes estáticas | `AuthRoutes.login`, `HomeRoutes.profile` |
| **Rotas (path)** | kebab-case com `/` | `/auth`, `/auth/simple-completion`, `/home/profile` |
| **Mocks** | Prefixo `Mock` ou `Fake` | `MockAuthRepository`, `FakeLoginModel` |

---

## Arquitetura — Clean Architecture (analogia do carro)

| Camada | Responsabilidade | Analogia |
|---|---|---|
| **DataSource** | Chamadas HTTP / storage local | Motor (onde a combustão acontece) |
| **Repository** | Usa DataSource, adapta dados | Câmbio (liga motor às rodas) |
| **UseCase** | Regra de negócio, um caso de uso | Pedal do acelerador (comando único) |
| **Cubit** | Chama UseCase, emite estado | Piloto (pisa no pedal, lê o painel) |
| **Page** | Mostra UI, reage ao estado, chama métodos do Cubit | Cockpit + passageiro (dá ordens) |

O Cubit **nunca** chama API/DataSource diretamente — sempre via UseCase.
A Page **nunca** chama `emit` — só chama métodos públicos do Cubit.

---

## 1. Imports — ordem e organização

Agrupar imports nesta ordem, separados por linha em branco:

```dart
// 1. dart:
import 'dart:async';

// 2. package:
import 'package:shared_dependencies/shared_dependencies.dart';
import 'package:core_common/core_common.dart';

// 3. imports relativos
import '../widgets/my_widget.dart';
```

### Regras

- **Usar barrel files** quando existirem: `package:auth/auth.dart` em vez de `package:auth/src/...`
- **Sem imports circulares** entre módulos.
- **Page/Widget importa apenas o necessário**: nunca `core_data` na UI — isso fica nos cubits.
- **`shared_dependencies`** para DS e bloc; **`core_common`** para utils, models e validações.

---

## 2. Gerenciamento de estado (Bloc/Cubit)

### Quando usar o quê na Page

| Widget | Quando usar |
|---|---|
| `BlocConsumer` | Precisa de listener (navegação, toast, side-effect) **e** builder |
| `BlocBuilder` | Só precisa de rebuild na UI |
| `BlocListener` | Só precisa de side-effect, sem rebuild |

### Otimizações obrigatórias

- Usar `listenWhen` / `buildWhen` para evitar rebuilds desnecessários.
- Cubit correto para o fluxo (ex.: `RegisterCubit` em PreRegister/CreatePassword, `ValidationCodeCubit` em ValidationCode).
- Provider do cubit no nível adequado: app, rota ou página.

### State pattern

States usam `Equatable` e `copyWith`:

```dart
class ExampleState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final DataModel? data;

  const ExampleState({this.isLoading = false, this.errorMessage, this.data});

  @override
  List<Object?> get props => [isLoading, errorMessage, data];

  ExampleState copyWith({bool? isLoading, String? errorMessage, DataModel? data}) {
    return ExampleState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
```

**Limpar campo nullable**: o padrão `param ?? this.param` não distingue "não passou" de "passou null para limpar". Para zerar um campo (ex.: `errorMessage` após sucesso), use um método dedicado no Cubit (`clearError()`) ou um wrapper `Optional<T>`.

---

## 3. Responsabilidades — Page vs Cubit

### Page (cockpit + passageiro)

- **Só UI**: layout, widgets, formulários.
- **Chama métodos do Cubit** para ações do usuário.
- **Não contém lógica de negócio.**
- Validações de formulário (formato de e-mail, campo vazio) ficam na Page.

```dart
// ✅ Correto — Page chama método do Cubit
onPressed: () {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    cubit.login(_email!, _password!);
  }
}

// ❌ Errado — Page emitindo estado
context.read<SignInCubit>().emit(state.copyWith(isLoading: true));
```

### Cubit (piloto)

- **Orquestra UseCases** e navegação.
- **Emite estado** via `emit` (só internamente).
- **Não conhece widgets** nem `BuildContext`.
- Regras de negócio ficam no UseCase; Cubit só coordena.

```dart
// ✅ Padrão correto de Cubit
Future<void> login(String email, String password) async {
  emit(state.copyWith(isLoading: true));

  final result = await _loginUseCase.call(LoginModel(email: email, password: password));

  if (result.$1 != null) {
    emit(state.copyWith(session: result.$1, isLoading: false));
    _appNavigation.goToHome();
  } else {
    emit(state.copyWith(errorMessage: result.$2!.message, isLoading: false));
  }
}
```

### Quando usar setState vs Cubit + emit

| Situação | Usar | Por quê |
|---|---|---|
| Dados de UseCase (login, API, loading, erro) | `Cubit + emit` | Estado compartilhável e testável |
| Dropdown aberto/fechado | `setState` | Estado visual local |
| Animação de botão, foco de campo | `setState` | Só importa naquela tela |
| TextEditingController, FocusNode | `setState` / `StatefulWidget` | Controle local da UI |

**Regra de ouro**: se vem de UseCase ou precisa ser testado/compartilhado → Cubit. Se é visual/local e some ao sair da tela → setState.

---

## 4. Métodos do Cubit

- **Responsabilidade única**: cada método faz uma coisa só.
- **Nome honesto**: `sendValidationCode` só envia código, não valida nem navega.
- **Navegação concentrada**: usar `_navigation.goToX()` via abstração.
- **Sem lógica de UI** no cubit (formatação de data para exibição fica na Page ou em helper).

---

## 5. Componentização e reutilização

- Widgets genéricos ficam em `ui/shared/widgets/` ou equivalente no DS.
- **Usar componentes existentes** antes de criar novos (ex.: `VerificationChannelOption` em vez de duplicar `AppRadioButton`).
- Extrair padrões repetidos (ex.: card com ícone + título + subtítulo).
- Pensar em reuso cross-fluxo (ex.: tela de validação serve para cadastro e esqueci senha).
- **Acessibilidade**: usar `Semantics` e `SemanticsLabel` em componentes customizados; garantir ordem de foco lógica em formulários.

---

## 6. Design System (DS) — Componentes

Sempre usar os componentes do DS em vez de widgets genéricos do Flutter.

| Necessidade | Usar (DS) | NÃO usar |
|---|---|---|
| Botão | `AppButton` | `ElevatedButton`, `TextButton` |
| Botão com ícone | `AppButton` com parâmetro de ícone | `IconButton` genérico |
| Campo de texto | `AppTextField` | `TextField`, `TextFormField` |
| Campo de senha | `AppTextField.password` | `TextField` com obscureText manual |
| Alerta/feedback | `AppAlert`, `AppToast` | `SnackBar` genérico |
| Radio button | `AppRadioButton` | `Radio` genérico |
| Checkbox | `AppCheckbox` | `Checkbox` genérico |
| Divider | `AppDivider` | `Divider` genérico |
| Link | `AppLink` | `GestureDetector` com Text |
| Switch | `AppSwitch` | `Switch` genérico |
| Badge | `AppBadge` | Container customizado |
| Progress indicator | `AppProgressIndicator` | `CircularProgressIndicator` genérico |

### AppButton — variantes disponíveis

- **Aparências**: solid, soft, outline, ghost, surface
- **Cores**: principal, neutral, success, danger
- **Tamanhos**: medium, small
- Suporta: ícones, badges, loading state

---

## 7. Design System (DS) — Tokens

**Nunca usar valores mágicos.** Sempre usar tokens do DS.

### Tipografia — `AppTypography`

Padrão: `{categoria}{peso}{tamanho}`

```dart
// ✅ Correto
style: AppTypography.titleNormalMedium

// ❌ Errado
style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
```

Categorias: `display`, `title`, `subtitle`, `body`, `label`
Pesos: `Normal`, `Thin`
Tamanhos: `Large`, `Medium`, `Small`, `Nano` (label)

### Espaçamento — `AppSpacing`

```dart
// ✅ Correto
SizedBox(height: AppSpacing.x16)
padding: EdgeInsets.all(AppSpacing.x24)

// ❌ Errado
SizedBox(height: 16)
padding: EdgeInsets.all(24)
```

Valores disponíveis: `none`, `x4`, `x8`, `x12`, `x16`, `x20`, `x24`, `x28`, `x32`, `x36`, `x40`, `x44`, `x48`, `x56`, `x64`, `x80`, `x96`, `x112`, `x128` e mais.

Semânticos: `xsmall3`(2), `xsmall2`(4), `xsmall`(8), `small`(12), `medium`(16), `large`(20), `xlarge` e variantes.

### Cores — `AppColor`

```dart
// ✅ Correto
color: AppColor.primary.main
color: AppColor.neutral.strong
color: AppColor.danger.main
color: AppColor.surface.lowest

// ❌ Errado
color: Colors.blue
color: Color(0xFF1A1A1A)
```

Grupos: `primary`, `secondary`, `success`, `warning`, `danger`, `info`, `neutral`, `surface`
Cada grupo tem: `softest`, `softer`, `soft`, `main`, `strong` + variantes `on*` para texto sobre fundo.

### Raio — `AppRadius`

```dart
// ✅ Correto
borderRadius: BorderRadius.circular(AppRadius.x12)
borderRadius: BorderRadius.circular(AppRadius.fields)

// ❌ Errado
borderRadius: BorderRadius.circular(12)
```

Valores: `x2`, `x4`, `x6`, `x8`, `x12`, `x16`, `x24`, `full`(9999), `none`
Semânticos: `buttons`(x6), `fields`(x6), `tags`(full), `drops`(x8), `containers`(x8), `dialogs`(x8)

### Sizing — `AppSizing`

```dart
// ✅ Correto
width: AppSizing.x64
height: AppSizing.iconXlarge

// ❌ Errado
width: 64
```

Valores numéricos: `x1` a `x128`
Semânticos: `shapeXsmall5` a `shapeXlarge`, `iconXsmall3` a `iconXlarge`

---

## 8. Navegação

Navegação é feita via **abstrações** injetadas no Cubit.

```dart
// Definição da abstração (core_common)
abstract class AppNavigation {
  void goToAuth();
  void goToHome();
}

// Cada feature tem sua própria abstração
abstract class AuthNavigation {
  void goToRegister();
  void goToValidationCode();
}
```

- Cubits recebem a abstração via construtor (DI com GetIt).
- Implementações usam `RouterNavigation.push(...)` com `GoRouter`.
- **Nunca usar `Navigator.push` diretamente** — sempre via abstração.

### Rotas

Cada feature define uma classe de rotas com constantes estáticas:

```dart
class AuthRoutes {
  AuthRoutes._();
  static const login = '/auth';
  static const register = '$login/simple-completion';
}

// Para rotas aninhadas, use extension removeBase
extension _Navigation on String {
  String get removeBase => replaceFirst('${AuthRoutes.login}/', '');
}
```

---

## 9. Injeção de dependências (GetIt)

Ordem de inicialização em `main.dart`:

1. `coreDatabaseInjection()` — storage local (async)
2. `coreNetworkInjection()` — HTTP client
3. `coreDataInjection()` — repositories e use cases
4. Feature injections (`authInjection()`, `homeInjection()`)

Padrões:
- `registerSingleton<T>` — instância única (navegação, Dio)
- `registerLazySingleton<T>` — singleton lazy (repositories, use cases)

---

## 10. Criando módulos novos — package, não pasta

Módulo novo **é um Flutter package completo**, não uma pasta solta com arquivos Dart.

### ❌ Errado — criar só uma pasta

```
modules/feature/profile/
├── lib/
│   └── profile_page.dart    ← sem pubspec.yaml, sem barrel, sem module
```

Isso não é um módulo: não pode ser importado como `package:`, não aparece no workspace, não tem dependências isoladas.

### ✅ Correto — criar um Flutter package

Todo módulo novo precisa de:

1. **`pubspec.yaml`** com `resolution: workspace` e as dependências corretas
2. **Barrel file** (`lib/<nome>.dart`) reexportando a API pública
3. **Arquivo de injeção** (`lib/src/<nome>_module.dart`) registrando no GetIt
4. **Registro no workspace** do `pubspec.yaml` raiz
5. **Estrutura interna** seguindo o padrão da arquitetura

```
modules/feature/profile/
├── pubspec.yaml                          ← obrigatório
├── lib/
│   ├── profile.dart                      ← barrel file
│   └── src/
│       ├── profile_module.dart           ← injeção GetIt
│       ├── navigation/
│       │   ├── navigation.dart           ← abstração de navegação
│       │   ├── navigation_impl.dart      ← implementação
│       │   └── routes.dart               ← constantes de rota
│       └── ui/
│           ├── pages/
│           │   └── profile_page.dart
│           ├── state/
│           │   ├── profile_state.dart
│           │   └── cubit/
│           │       └── profile_cubit.dart
│           └── widgets/
│               └── ...
```

### pubspec.yaml do módulo

```yaml
name: profile
description: "Feature de perfil do usuário."
publish_to: none
version: 1.0.0+1

environment:
  sdk: ">=3.6.2"

resolution: workspace

dependencies:
  flutter:
    sdk: flutter

  shared_dependencies:
  core_common:
  core_data:

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  mocktail: ^1.0.4

flutter:
  uses-material-design: true

  module:
    androidX: true
    androidPackage: com.app.feature.profile
    iosBundleIdentifier: com.app.feature.profile
```

### Registrar no workspace raiz (`cookbook/pubspec.yaml`)

Adicionar o novo módulo em **dois lugares**:

```yaml
workspace:
  - modules/feature/profile    # ← adicionar aqui

dependencies:
  profile:                     # ← e aqui
```

### Barrel file (`lib/profile.dart`)

```dart
export 'src/profile_module.dart';
export 'src/navigation/routes.dart';
```

### Módulo de injeção (`lib/src/profile_module.dart`)

```dart
import 'package:shared_dependencies/shared_dependencies.dart';
import 'package:core_common/core_common.dart';
import 'package:core_data/core_data.dart';

void profileInjection() {
  // Navigation
  GetIt.I.registerSingleton<ProfileNavigation>(ProfileNavigationImpl());

  // Cubits
  GetIt.I.registerFactory<ProfileCubit>(
    () => ProfileCubit(GetIt.I(), GetIt.I()),
  );
}
```

Depois, chamar `profileInjection()` no `main.dart` junto com as outras feature injections.

---

## 11. UseCase pattern

Cada UseCase tem responsabilidade única e retorna uma tupla `(Success?, Failure?)`:

```dart
abstract class LoginUsecase {
  Future<(SessionModel?, AuthFailure?)> call(LoginModel model);
}

class LoginUsecaseImpl implements LoginUsecase {
  final AuthRepository _repository;
  LoginUsecaseImpl(this._repository);

  @override
  Future<(SessionModel?, AuthFailure?)> call(LoginModel model) async =>
      await _repository.login(model);
}
```

---

## 12. Tratamento de erros (Failure)

Erros fluem como **Failure** tipado, nunca como exceção genérica.

### Padrão

```dart
// core_common — base
abstract class BaseFailure {
  final String message;
  BaseFailure(this.message);
}

// Por domínio
class AuthFailure extends BaseFailure {
  AuthFailure(super.message);
}
```

### Fluxo

1. **DataSource** → captura exceção HTTP/storage, retorna `(null, Failure)`
2. **Repository** → repassa ou adapta o Failure
3. **UseCase** → retorna tupla `(Success?, Failure?)`
4. **Cubit** → emite `state.copyWith(errorMessage: result.$2!.message)`
5. **Page** → exibe via `AppAlert`, `AppToast` ou texto no formulário

### Regras

- **Nunca** fazer `throw` de erros de negócio — sempre retornar Failure na tupla.
- Mensagem do Failure deve ser **legível para o usuário** (evitar stack traces).
- Cada feature pode ter seu Failure específico (`AuthFailure`, `ProfileFailure`, etc.).

---

## 13. Testes

### Estrutura

- **Unit**: UseCases, Repositories, DataSources
- **Widget**: páginas e componentes críticos
- Mocks em `test/mocks/mocks.dart` com `mocktail`

### Padrão de teste (Arrange / Act / Assert)

```dart
group('LoginUseCaseImpl', () {
  test('should return SessionModel', () async {
    // Arrange
    when(() => mockRepository.login(any<LoginModel>()))
        .thenAnswer((_) async => (mockSessionModel, null));

    // Act
    final result = await usecase.call(loginModel);

    // Assert
    expect(result, equals((mockSessionModel, null)));
    verify(() => mockRepository.login(any<LoginModel>())).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
});
```

### Dicas

- **Fake** para classes sem construtor default: `class FakeLoginModel extends Fake implements LoginModel {}`
- **setUpAll** para `registerFallbackValue(FakeX())` quando usar `any<X>()`
- **setUp** para criar mocks e instância do objeto sob teste
- Nomenclatura: `test('should return X when Y')` ou `test('retorna X quando Y')`

---

## Checklist rápido para code review

Antes de abrir PR, verificar:

- [ ] Imports agrupados (dart → package → relativo) e usando barrels
- [ ] Page não importa `core_data`; usa `shared_dependencies` e `core_common`
- [ ] `BlocConsumer` / `BlocBuilder` / `BlocListener` usado corretamente
- [ ] `listenWhen` / `buildWhen` aplicados onde faz sentido
- [ ] Page não chama `emit` — só métodos públicos do Cubit
- [ ] Page não tem lógica de negócio
- [ ] Cubit não conhece BuildContext nem widgets
- [ ] Métodos do Cubit com responsabilidade única e nome honesto
- [ ] Componentes do DS usados (AppButton, AppTextField, etc.) em vez de genéricos
- [ ] Tokens do DS usados (AppTypography, AppSpacing, AppColor, AppRadius) em vez de valores mágicos
- [ ] Widgets reutilizáveis extraídos quando há padrão repetido
- [ ] Navegação via abstração injetada, não Navigator direto
- [ ] Módulo novo é um package completo (pubspec.yaml, barrel, module de injeção) — não apenas uma pasta
- [ ] Módulo novo registrado no workspace e dependencies do `pubspec.yaml` raiz
- [ ] Módulo novo com `profileInjection()` chamado no `main.dart`
- [ ] Erros retornados como Failure na tupla, não como throw
- [ ] Testes de UseCase/Repository com mocktail (Arrange/Act/Assert)

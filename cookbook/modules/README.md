# Modules

A Flutter project with SonarQube.

## Getting Started with SonarQube for Flutter Cookbook

### 1. Flutter Modular
Quando estiver usando Flutter Modular, e quiser verificar todos os modulos com apenas um SonarQube, faça o seguinte:

Dentro do diretório `modules` crie o seguinte arquivo de configuração `sonar-project.properties` com os seguintes campos:

Nesse exemplo, estamos considerando a existencia de dois modulos, o `core` e o `auth`

```
# Project identification, either hardcode it or use Environment variables
sonar.projectKey=projectKey
sonar.projectName=projectName
sonar.login=login

sonar.host.url=http://localhost:9000
# Source code location.
# Path is relative to the sonar-project.properties file. Defaults to .
# Use commas to specify more than one folder.

sonar.modules=auth, core

core.sources=core/lib
core.tests=core/test

auth.sources=auth/lib
auth.tests=auth/test

# Encoding of the source code. Default is default system encoding.
sonar.sourceEncoding=UTF-8

# exclude generated files
sonar.exclusions=test/**/*_test.mocks.dart,lib/**/*.g.dart
```

#### 2. Flutter Project

 Crie um arquivo de configuração `sonar-project.properties` na raiz do projeto, com os seguintes campos:

```
# Project identification, either hardcode it or use Environment variables
sonar.projectKey=projectKey
sonar.projectName=projectName
sonar.login=login

sonar.host.url=http://localhost:9000
# Source code location.
# Path is relative to the sonar-project.properties file. Defaults to .
# Use commas to specify more than one folder.

sonar.sources=lib
sonar.tests=test

# Encoding of the source code. Default is default system encoding.
sonar.sourceEncoding=UTF-8

# exclude generated files
sonar.exclusions=test/**/*_test.mocks.dart,lib/**/*.g.dart
```


### 3. Baixando o SonarScanner
O SonarScanner nos permite realizar o upload dos resultados para o SonarQube que criamos no docker, então, primeiro, vamos baixa-ló através deste link https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/.

Certifique-se que o Scanner foi adicionado ao PATH para poder utiliza-lo via terminal.

### 4. Executando o Sonar

> Configure seu SonarQube server e adicione as credenciais no arquivo sonar-project.properties.

#### Flutter Modular
Dentro de cada modulo, ex.: `modules/auth` e `modules/core`. Execute o seguinte comando:

```
flutter test --machine --coverage > tests.output
```

Esse comando irá gerar as informações de coverage dos testes e irá armazenar no arquivo `tests.output`.

Em seguida, na pasta `modules/`, execute o comando:

```
sonar-scanner
```


#### Flutter Project

Na raiz do projeto, execute o seguinte comando:

```
flutter test --machine --coverage > tests.output
```

Esse comando irá gerar as informações de coverage dos testes e irá armazenar no arquivo `tests.output`.

Em seguida, na pasta `modules/`, execute o comando:

```
sonar-scanner
```

![alt text](assets/docs/image.png)


# flutter_identityserver

Projeto mobile com autenticação em Identity Server 4
* Clonar projeto: `git clone https://github.com/jonathandsantiago/flutter_firebase.git`
* `cd flutter_firebase`
* `flutter pub get` 

![](https://github.com/jonathandsantiago/flutter_firebase/tree/main/assets/images/app.gif')

# Bibliotecas
* firebase_auth `flutter pub add firebase_auth`
* cloud_firestore `flutter pub add cloud_firestore`
* google_sign_in `flutter pub add google_sign_in`
* currency_text_input_formatter `flutter pub add currency_text_input_formatter`

### Arquitetura projeto
A arquitetura do projeto esta organizada no seguinte formato:
```
    lib
        src
            models
            repositories
            services
            ui
            utils
            widgets
        app.dart
        root_page.dart
    main.dart
```
* `services` Camada de serviços, onde ficará toda regra de negócio da aplicação e a comunicação direta com o repositório;
* `repositories` Camada de repositórios, onde ficará toda consulta e com comunicação com banco de dados firebase;
* `models` Camada de modelo das entidades;
* `ui` Camada de apresentação;
* `utils` Camada de utilitário, esta camada irá conter funções e constantes que será reutilizado e compartilhada com as demais camada da aplicação;
* `widgets` Camada utilizada para armazenar widgets personalizados que será reutilizado na aplicação;
    
### Configuração Android
* Em `android -> build.gradle`
    * Adicione em <dependencies>
    ```
        classpath 'com.google.gms:google-services:4.3.10'
    ```
* Em `android -> app -> build.gradle`: 
    * Abaixo de `apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"` adicione `apply plugin: 'com.google.gms.google-services'`
    * Em `defaultConfig` insira o `applicationId` neste caso cadastrei `br.com.flutter_firebase` o mesmo será utilizado para gerar o arquivo `google-services.json`
    * Neste exemplo teste uma versão antiga do android, neste caso alterei a `minSdkVersion` para 19
    * Em `dependencies` adicione:
    ```
          implementation platform('com.google.firebase:firebase-bom:29.3.1')
          implementation 'com.google.firebase:firebase-analytics'
    ```
    * Para connectar corretamente com o firebase, acesse https://console.firebase.google.com/ navegue até `Configurações do projeto`, na aba `geral`
    clique em `Adicionar aplicativo`, selecione a plataforma desejada, e insira o `Nome do pacote do Android` que é o mesmo cadastrado no `applicationId` apresentado acima.
    Registre o app e realize o download do arquivo `google-services.json` e o adicione na pasta `android -> app`
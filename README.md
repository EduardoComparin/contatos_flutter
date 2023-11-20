```markdown
# Contatos Flutter

![Flutter](https://img.shields.io/badge/Flutter-1.0.0%2B1-blue)
![Dart](https://img.shields.io/badge/Dart-%3E%3D3.1.5%20%3C4.0.0-blue)

Um projeto Flutter para gerenciar contatos.

## Descrição

Este projeto Flutter foi desenvolvido para gerenciar contatos de forma eficiente.

## Configuração

Certifique-se de definir suas dependências no arquivo `pubspec.yaml` antes de executar o projeto. Você pode fazer isso com o seguinte comando:

```bash
flutter pub get
```

- Criação do banco em : https://www.back4app.com com os seguintes campos:

- Tabela "contato"
 String "objectId" 
 String "nome"
 String "telefone"
 String "endereco"
 String "cidade"
 String "aniversario"
 String "imagem"


 - Após a criação do banco você deve fornecer um arquivo `.env` na pasta `assets/` para configurar as chaves de API necessárias.
 * X-Parse-Application-Id -> .env/BACK4APPID
 * X-Parse-REST-API-Key   -> .env/BACK4APPAPIKEY

## Dependências Principais

- **Google Fonts**: Facilita o uso e personalização de fontes no seu aplicativo.
- **Internacionalização**: Suporte para vários idiomas com o pacote `intl`.
- **Requisições HTTP**: Utiliza o pacote Dio para fazer requisições HTTP.
- **Variáveis de Ambiente**: Gerencia configurações específicas do ambiente com `flutter_dotenv`.
- **Criptografia**: Protege dados sensíveis com o pacote `crypto`.
- **Campos Brasileiros**: Formata campos específicos do Brasil com o pacote `brasil_fields`.
- **Manipulação de Imagens**: Seleciona e salva imagens com os pacotes `image_picker` e `gallery_saver`.
- **Acesso ao Sistema de Arquivos**: Utiliza o pacote `path_provider` para acessar o sistema de arquivos.
- **Animação**: Adiciona texto animado com o pacote `animated_text_kit`.
- **Suporte a Ícones**: Integra ícones Font Awesome com o pacote `font_awesome_flutter`.
- **Localização**: Implementa localização fácil com o pacote `easy_localization`.

## Executando o Projeto

Para executar o projeto, use o seguinte comando:

```bash
flutter run
```

Certifique-se de que um emulador ou dispositivo físico esteja conectado.

## Testes

Você pode executar testes no projeto usando o seguinte comando:

```bash
flutter test
```

Isso garantirá que a aplicação funcione conforme o esperado.

## Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir problemas ou enviar solicitações de pull para melhorar este projeto.

## Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

```




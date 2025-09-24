# DogAPI-iOS

Este é um projeto iOS simples que exibe cães aleatórios usando a API [Dog CEO](https://dog.ceo/dog-api/). Mesmo sendo pequeno, tentei seguir os princípios da **Clean Architecture**, separando responsabilidades entre View, ViewModel, UseCase e DataSource. Nenhuma biblioteca externa foi utilizada para manter o código didático e fácil de entender.

## Funcionalidades

- Tela principal (`DogListViewController`) mostrando um cachorro aleatório.
- Pull to refresh para buscar um novo cachorro.
- Mensagem de erro quando não é possível carregar o cachorro.
- Tela de detalhes (`DogDetailViewController`) mostrando a imagem do cachorro em detalhe e a raça extraída da URL.

## Arquitetura

O projeto segue o padrão **Clean Architecture**:

- **ViewModels:** Gerenciam estado e interagem com os UseCases (`DogListViewModel` e `DogDetailViewModel`).
- **UseCases:** `FetchRandomDogUseCase` implementa `FetchDogUseCaseProtocol` e encapsula a lógica de fetch.
- **DataSource:** `DogRemoteDataSource` e `APIService` isolam a comunicação com a API.
- **Views:** `DogImageView` é uma view customizada reutilizada tanto na lista quanto no detalhe.
- **Controllers:** `DogListViewController` e `DogDetailViewController` gerenciam a interface e ligam Views e ViewModels.

## Testes

- **Unitários (`DogAPI-Tests`):**
  - Verifica que a URL retornada não é vazia.
  - `lastDog` é atualizado após fetch.
  - Mudança de estado de `loading` para `success`.
- **UI (`DogListUITests`):**
  - Um fluxo chave: tocar na imagem leva à tela de detalhes e confirma se a `breedLabel` aparece.

## Observações

- O projeto utiliza `Equatable` no `ViewState` do ViewModel para facilitar testes unitários de comparação de estados.
- Testes de UI usam `accessibilityIdentifier` para localizar elementos na interface.
- Não foram utilizadas bibliotecas externas. Todo o código é nativo Swift e UIKit.

## Melhorias Futuras

- Implementar **caching de imagens** para reduzir o uso de rede e melhorar a performance da lista.
- Adicionar **tratação de erros mais detalhada** e mensagens amigáveis ao usuário.
- Incluir **animações sutis** na transição entre lista e detalhes para uma experiência mais fluida.

## Como rodar os testes

1. Abra o projeto no Xcode.
2. Selecione o scheme `DogAPI-iOS`.
3. Para rodar os testes unitários e de UI: `Cmd + U` no simulador.

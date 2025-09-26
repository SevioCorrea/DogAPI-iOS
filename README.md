# English 🇬🇧🇺🇸

# DogAPI-iOS

This is a simple iOS project that displays random dogs using the [Dog CEO API](https://dog.ceo/dog-api/). Even though it’s small, I tried to follow **Clean Architecture** principles, separating responsibilities between View, ViewModel, UseCase, and DataSource. No external libraries were used to keep the code didactic and easy to understand.

## Features

- Main screen (`DogListViewController`) showing a random dog.
- Pull to refresh to fetch a new dog.
- Error message when the dog cannot be loaded.
- Detail screen (`DogDetailViewController`) showing the dog image in detail and the breed extracted from the URL.

## Architecture

The project follows the **Clean Architecture** pattern:

- **ViewModels:** Manage state and interact with UseCases (`DogListViewModel` and `DogDetailViewModel`).
- **UseCases:** `FetchRandomDogUseCase` implements `FetchDogUseCaseProtocol` and encapsulates fetch logic.
- **DataSource:** `DogRemoteDataSource` and `APIService` isolate API communication.
- **Views:** `DogImageView` is a custom view reused both in the list and in the detail screen.
- **Controllers:** `DogListViewController` and `DogDetailViewController` manage the interface and connect Views and ViewModels.

## Tests

- **Unit (`DogAPI-Tests`):**
  - Verifies that the returned URL is not empty.
  - `lastDog` is updated after fetch.
  - State changes from `loading` to `success`.
- **UI (`DogListUITests`):**
  - A key flow: tapping on the image navigates to the detail screen and confirms that the `breedLabel` appears.

## Notes

- The project uses `Equatable` in the ViewModel’s `ViewState` to simplify unit tests for state comparison.
- UI tests use `accessibilityIdentifier` to locate elements in the interface.
- No external libraries were used. All code is native Swift and UIKit.

## Future Improvements

- Implement **image caching** to reduce network usage and improve list performance.
- Add **more detailed error handling** and user-friendly messages.
- Include **subtle animations** in the transition between list and detail screens for a smoother experience.

## How to run the tests

1. Open the project in Xcode.
2. Select the `DogAPI-iOS` scheme.
3. To run unit and UI tests: press `Cmd + U` in the simulator.

---

# Português 🇧🇷🇵🇹

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

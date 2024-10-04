# Torre de Hanói

Projeto para resolução da Torre de Hanói para a matéria de Matemática Discreta. App Multiplataforma, podendo rodar em Android, iOS, Desktop, Web...

## Resolução por Recursão
Para a solução da Torre de Hanói utilizamos um algoritmo de recursão. O processo segue a ideia de ir reduzindo o problema até o caso base, e a partir dele voltar resolvendo os casos mais complexos. Podemos então definir uma função

```
void towerOfHanoi(n, source, destination, auxiliary)
```

que move `n` discos da haste `source` para `destination` utilizando a haste `auxiliary`. Se `n=4`, podemos primeiramente simplificar o problema e fazer a tarefa de mover 3 discos para a haste `auxiliary`, utilizando a mesma função, depois movendo o maior disco para `destination` e então movendo os 3 discos de `auxiliary` para `destination`.
Para resolver a tarefa de mover 3 discos, utilizamos a mesma ideia, movendo n-1=2 por vez, até o caso base n=1.

A ideia no caso geral para `n` arbitrário é então

```dart
// Mover n-1 discos para a haste auxiliar
towerOfHanoi(n-1, source, auxiliary, destination)
// Mover o disco n para o haste desejado
move(source, destination)
// Mover os n-1 discos para o haste desejado
towerOfHanoi(n-1, auxiliary, destination, source)
```

Onde para o caso base n=1, devemos apenas mover o haste.

Em dart, temos a função implementada em questão, onde o controller contém a função para movimento de disco, que é uma animação, por isso é um Future que precisa esperar a execução antes da próxima ação.

```dart
Future<void> towerOfHanoi(int n, int source, int destination, int auxiliary, Controller controller) async {
    if (n == 1) {
      await controller.move(source, destination);
      return;
    }

    await towerOfHanoi(n - 1, source, auxiliary, destination, controller);
    await controller.move(source, destination);
    await towerOfHanoi(n - 1, auxiliary, destination, source, controller);
}
```

## Processo de Desenvolvimento e Animação

O primeiro objetivo foi implementar a lógica de resolução do problema, para isso utilizei simples listas como representantes dos hastes, através da implementação da função recursiva testei se movia os elementos entre as listas como o esperado. Assim que estava funcional pude partir pra desenvolver o layout, utilizando cores e tamanhos relacionados aos inteiros, pude representar cada disco como sendo um valor inteiro de 1 a n, assim uma torre nada mais é que uma lista de discos. Como já tinha a lógica das listas, restou apenas implementar o layout dos hastes e discos, onde cada haste teria os discos daquela lista, para isso calculo pelo tamanho da tela a posição onde cada haste, e o disco relacionado, deveria estar.

Nesse ponto o projeto já estava funcional, mas o movimento dos discos era instantâneo de um haste para outro, o que não era o desejado. A ideia de fazer uma animação levantando cada disco e movendo mudaria boa parte da lógica seria um pouco chato, além de ficar algo meio "forçado". Então, por sugestão de um colega, utilizei a ideia de uma animação através de 4 posições simples: posição inicial -> acima do haste inicial -> acima do haste desejado -> encaixado no haste. Para essa ideia utilizo uma variável temporária contendo o disco e o haste que ele está "flutuando", além de tirar o disco das listas, enquanto em modo "flutuante".

## Possíveis melhorias

Quando tiver mais um tempo pretendo implementar algumas melhorias, como mostrar o número de jogadas atuais e final, alguns textos auxiliares enquanto a animação ocorre e a opção de reiniciar.

Além disso, posso implementar uma versão "manual", onde o app servirá como um jogo mesmo, que o usuário pode jogar ou pedir para que o algoritmo resolva o problema para ele.

## Código e Diretórios

Toda a implementação do projeto está dentro da pasta `lib`, em `lib/main.dart` contém a lógica principal do projeto, como a função recursiva da Torre de Hanói. Em `lib/app` temos as classes auxiliares, `lib/app/game_screen.dart` contém a página inicial, com a lógica das animações e os dados, `lib/app/tower_ui.dart` contém o layout das torres e discos. Por último `lib/app/widgets.dart` e `lib/app/colors.dart` contém os componentes utilizados, como botões e selectors, além das cores dos discos.

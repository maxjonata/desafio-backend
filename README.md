O código foi escrito em inglês na maior parte pois vejo que é um padrão na programação, até pelos acentos que em português tem alguns e não funcionariam em nome de variável. É a minha primeira vez criando um projeto completo e formulado em Ruby e durante minhas pesquisas eu vi que o RSpec era o método de testes com melhor clareza escrevendo mais código para ser mais incisivo nos testes. Já a aplicação em si está sendo construída com o mínimo preciso para o produto como um MVP, já que não tem muitos requisitos além da escalabilidade, buscando evitar assim também o overengineering

## Gems

- RSpec
- json

## Questions ClassDoc

- **fillMatrix**() _-> void_<br />
  Utiliza do modulo complementar FileUser para requisitar os 2 json e uni-los em uma única hash. É utilizada como inicialização da lista de questões.

- **filterQuestionsBySeconds**(_integer_ seconds) _-> Array[Question]_<br />
    Retorna a lista de questoes filtrada por segundos do tempo atual para o passado. Removendo tanto os acessos que não se encaixam na filtragem quanto questões inteiras que não tiveram acesso.

- **mostAccessedQuestions**(_string_ timeRange) _-> Array[Question]_<br />
    ENUM: ['week', 'month', 'year']<br />
    DEFAULT: 'week'<br />
    Retorna questões ordenadas descendentemente a partir de seus acessos e filtrada por tempo de acordo com a categoria passada utilizando _filterQuestionsBySeconds_.

- **mostAccessedDisciplines**(_integer_ lastHours) _-> Array[Question]_<br />
    DEFAULT: 24<br />
    Retorna questões ordenadas descendentemente a partir de seus acessos e filtrada pelas horas passadas utilizando _filterQuestionsBySeconds_.

## Como utilizar

~~No Framework~~

Requisitos:
- Ter o Ruby instalado [[Site Oficial](https://www.ruby-lang.org/)]

Passo a passo para o programa de teste:
- Abra o CMD
- Vá até a pasta do programa
- execute `ruby main.rb`
- siga as instruções digitando apenas o que é pedido no texto.

## Classe
Seguinto arquitetura monolitica de escala horizontal, mantendo a complexidade menos dinamica com foco nas questões pois dessa forma tem um projeto consiso focado em features, já que os requisitos foram features.
Ao escalar o sistema para CICD tenho compreenção que as classes devem se estender em Questão, Disciplina, Acesso, Questoes[Questao] < Array. Comecei arquitetando desta forma mas logo percebi que com poucos requisitos e um tempo limitado ficaria incompleto tentar se estender tanto, por isso a demora para entrega, arquitetar tudo é mais tranquilo mas juntar tudo e fazer a filtragem referencial pode ficar com um indice de complexidade alto dependendo da query usada, prejudicando a performance na escala.
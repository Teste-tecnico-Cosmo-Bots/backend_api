### README

Bem-vindo ao [Nome da sua Aplicação]! Abaixo estão os passos necessários para executar a aplicação em sua máquina local.

#### Versão do Ruby

Esta aplicação requer a versão 3.1.6p260 do Ruby. Certifique-se de tê-la instalada. Você pode verificar sua versão do Ruby executando:

```bash
ruby --version
```

#### Dependências do Sistema

Certifique-se de ter as seguintes dependências instaladas:

- [Liste quaisquer dependências do sistema aqui, por exemplo, Node.js, Yarn]

#### Configuração

1. Clone o repositório:

   ```bash
   git clone git@github.com:Teste-tecnico-Cosmo-Bots/backend_api.git
   cd <pasta-do-repositório>
   ```

2. Instale as dependências:

   ```bash
   bundle install
   ```
3. Inicie o server:

   ```
   rails server
   ```

#### Serviços

Liste quaisquer serviços de que o aplicativo depende, como filas de tarefas (job queues), servidores de cache ou mecanismos de busca.

#### Instruções de Implantação

Forneça instruções sobre como implantar a aplicação, especialmente se houver etapas específicas de implantação ou configurações.

#### Notas Adicionais

- [Quaisquer notas adicionais ou considerações especiais]

### Documentação da API

#### Usuários

**Endpoints:**

- `POST /signup`

  - Descrição: Cria uma nova conta de usuário.
  - Parâmetros:
    - `nome` (string, obrigatório): Nome do usuário.
    - `email` (string, obrigatório): Endereço de e-mail do usuário.
    - `isAdmin` (booleano, obrigatório): Define se o usuário tem privilégios de administrador.
    - `password` (string, obrigatório): Senha do usuário.
    - `password_confirmation` (string, obrigatório): Confirmação da senha do usuário.
  - Exemplo de Requisição:

    ```json
    {
      "nome": "João Silva",
      "email": "joao.silva@example.com",
      "isAdmin": false,
      "password": "senha123",
      "password_confirmation": "senha123"
    }
    ```

  - Retorna: Objeto JSON com detalhes do usuário e token de autenticação.

- `POST /login`

  - Descrição: Loga um usuário existente.
  - Parâmetros:
    - `email` (string, obrigatório): Endereço de e-mail do usuário.
    - `password` (string, obrigatório): Senha do usuário.
  - Retorna: Objeto JSON com token de autenticação após o login bem-sucedido.

- `GET /users`

  - Descrição: Recupera uma lista de todos os usuários.
  - Retorna: Array JSON contendo objetos de usuário.

- `GET /users/:id`

  - Descrição: Recupera detalhes de um usuário específico.
  - Retorna: Objeto JSON com detalhes do usuário.

- `PATCH /users/:id`

  - Descrição: Atualiza informações do usuário.
  - Parâmetros:
    - `email` (string): Endereço de e-mail atualizado.
    - `password` (string): Senha atualizada.
  - Retorna: Objeto JSON com detalhes do usuário atualizados.

- `DELETE /users/:id`
  - Descrição: Exclui uma conta de usuário.
  - Retorna: Sem conteúdo após a exclusão bem-sucedida.

#### Posts

**Endpoints:**

- `GET /posts`

  - Descrição: Recupera uma lista de todos os posts.
  - Retorna: Array JSON contendo objetos de post com detalhes de usuário e comentários associados.

- `GET /posts/:id`

  - Descrição: Recupera detalhes de um post específico.
  - Retorna: Objeto JSON com detalhes do post, incluindo usuário e comentários associados.

- `POST /posts`

  - Descrição: Cria um novo post.
  - Parâmetros:
    - `title` (string, obrigatório): Título do post.
    - `description` (string, obrigatório): Descrição do post.
    - `content` (texto, obrigatório): Conteúdo do post.
  - Exemplo de Requisição:

    ```json
    {
      "title": "Swift: Desenvolvimento para iOS",
      "description": "Explorando a linguagem Swift, criada pela Apple para desenvolvimento de aplicações iOS e macOS.",
      "content": "Swift é uma linguagem de programação poderosa e intuitiva para desenvolvimento de aplicativos iOS e macOS. Introduzida pela Apple, ela combina a performance e eficiência de linguagens compiladas com a simplicidade e modernidade de linguagens de script. É projetada para ser segura e fácil de usar."
    }
    ```

  - Retorna: Objeto JSON com detalhes do post criado.

- `PATCH /posts/:id`

  - Descrição: Atualiza um post existente.
  - Parâmetros:
    - `title` (string): Título atualizado do post.
    - `content` (texto): Conteúdo atualizado do post.
  - Retorna: Objeto JSON com detalhes do post atualizado.

- `DELETE /posts/:id`
  - Descrição: Exclui um post.
  - Retorna: Sem conteúdo após a exclusão bem-sucedida.

#### Comentários

**Endpoints:**

- `GET /comments`

  - Descrição: Recupera uma lista de todos os comentários.
  - Retorna: Array JSON contendo objetos de comentário com detalhes de usuário e post associados.

- `GET /comments/:id`

  - Descrição: Recupera detalhes de um comentário específico.
  - Retorna: Objeto JSON com detalhes do comentário, incluindo usuário e post associados.

- `POST /comments`

  - Descrição: Cria um novo comentário.
  - Parâmetros:
    - `content` (texto, obrigatório): Conteúdo do comentário.
    - `post_id` (integer, obrigatório): ID do post ao qual o comentário pertence.
  - Retorna: Objeto JSON com detalhes do comentário criado.

- `PATCH /comments/:id`

  - Descrição: Atualiza um comentário existente.
  - Parâmetros:
    - `content` (texto): Conteúdo atualizado do comentário.
  - Retorna: Objeto JSON com detalhes do comentário atualizado.

- `DELETE /comments/:id`
  - Descrição: Exclui um comentário.
  - Retorna: Sem conteúdo após a exclusão bem-sucedida.

#### Tratamento de Erros

- A API retorna códigos de status HTTP apropriados e mensagens de erro para solicitações inválidas, acesso não autorizado ou cenários de recurso não encontrado.

#### Autenticação e Autorização

- A autenticação é tratada usando tokens JWT. Os usuários devem autenticar via `/login` para obter um token, que é então usado para acessar endpoints protegidos.

#### Endpoints Personalizados

- `/posts/all`
  - Descrição: Recupera todos os posts com detalhes de comentários e usuários associados.
  - Retorna: Array JSON contendo objetos de post com comentários aninhados e detalhes de usuário.

PARTE 1
O multi-stage build reduz drasticamente o tamanho e aumenta a segurança da imagem final porque descarta ferramentas de compilação e dependências de desenvolvimento, transferindo apenas os artefatos estritamente necessários para rodar a aplicação em produção, o que diminui a superfície de ataque a vulnerabilidades.

<img width="3072" height="1664" alt="PARTE 1 - 2 Imagem rodando" src="https://github.com/user-attachments/assets/6d4d978a-67d6-4736-b930-a941003f8109" />
<img width="1057" height="558" alt="PARTE 1 - 1 Imagem criada" src="https://github.com/user-attachments/assets/c4294cac-da14-4608-ba77-752f30dd7ad4" />


PARTE 2

<img width="2112" height="1082" alt="PARTE 3 - 2 Registros no Mysql" src="https://github.com/user-attachments/assets/7b0cba91-e0ba-46e7-956d-8401481d8615" />
<img width="3072" height="1664" alt="PARTE 3 - 1 Docker Inspect" src="https://github.com/user-attachments/assets/638b7b11-1285-49dc-85a8-e4cdaef5320c" />
<img width="2112" height="1082" alt="PARTE 2 - 3 Volume do App Criado" src="https://github.com/user-attachments/assets/1ab46e2c-dc29-448f-93a0-afb1fa9a14ba" />


PARTE 3

O app consegue se conectar ao banco de dados sem saber o IP dele porque o Docker Compose cria uma rede interna com um serviço de DNS embutido, que resolve automaticamente o nome do serviço (como mysql ou db) para o endereço IP correspondente do container.

<img width="3072" height="1664" alt="PARTE 2 - 2 App com persistencia" src="https://github.com/user-attachments/assets/8a79e001-f753-4d4d-841c-98057b306d57" />
<img width="3072" height="1664" alt="PARTE 2 - 1 Sem persistencia" src="https://github.com/user-attachments/assets/ab94ba35-1932-4e5a-b8e6-ca5fdb1dd95f" />


PARTE 4

A diferença é que o comando docker compose down apenas para e remove os containers e redes, preservando os dados salvos nos volumes nomeados. Já o docker compose down -v remove também os volumes, destruindo permanentemente os dados persistidos.

<img width="3072" height="1664" alt="PARTE 4 - 1 Volume docker compose" src="https://github.com/user-attachments/assets/14302628-c217-4ea3-892e-fa6d16b6df1d" />
<img width="2112" height="1082" alt="PARTE 4  - 1 Docker compose ps" src="https://github.com/user-attachments/assets/ec3dc755-0208-40c4-9819-8ca30b969d70" />

PARTE 5

<img width="3072" height="1664" alt="PARTE 5 - CI com GitHub Actions" src="https://github.com/user-attachments/assets/03385ec9-e729-4525-8f72-b51e10c14990" />


PARTE 6

Para testar a proteção da esteira de CI/CD, introduzi um erro intencional alterando a imagem base no Dockerfile para uma versão inexistente (node:18-alpine-erro-proposital). O pipeline do GitHub Actions reagiu imediatamente, interrompendo o processo na etapa de build e barrando o avanço do código quebrado. Ao inspecionar os logs da execução reprovada na aba Actions, pude identificar facilmente o momento exato em que o Docker falhou ao tentar baixar a imagem falsa, comprovando a eficácia da automação na prevenção de falhas.

  <img width="3072" height="1664" alt="PARTE 6 - Erro proposital no CI" src="https://github.com/user-attachments/assets/be239932-a399-4dc1-869f-8e47a466ab2d" />


### CD — Publicação no Docker Hub

**Aluno(a):** Paulo Mesquita Juniorf **Turma:** Fullstack Noturno

*   **Usuário do Docker Hub:** paulomesquitas
*   **Imagem publicada:** `paulomesquitas/meu-projeto-docker-fullstack:latest`
*   **Link da imagem no Docker Hub:** https://hub.docker.com/repository/docker/paulomesquitas/meu-projeto-docker-fullstack/general
*   **Dispara quando:** push na branch `main`
*   **Arquivo do workflow:** `.github/workflows/cd.yml`

**Print 1 — token criado no Docker Hub**
<img width="1918" height="891" alt="1 Docker Token" src="https://github.com/user-attachments/assets/095f3cf6-1ac1-4afb-bfaf-5c4650935494" />


**Print 2 — Secrets cadastrados no GitHub (DOCKERHUB_USERNAME e DOCKERHUB_TOKEN)**
<img width="1918" height="891" alt="2 Secrets" src="https://github.com/user-attachments/assets/24491bc9-580f-43b7-ad27-3aeb2aabbbce" />


**Print 3 — workflow de CD verde na aba Actions**
<img width="1918" height="891" alt="3 CD no Actions Verde" src="https://github.com/user-attachments/assets/3995f1a7-71ce-4d99-a064-8b8531e475d5" />


**Print 4 — imagem publicada no Docker Hub**
<img width="1918" height="891" alt="4 Docker Hub" src="https://github.com/user-attachments/assets/2ae08d0c-7d2d-44b1-9ca9-1e9c8cdd3f99" />


**Print 5 — docker pull baixando a imagem publicada**
<img width="2452" height="1434" alt="5 Imagem Docker Baixada" src="https://github.com/user-attachments/assets/7396a557-0e70-4cad-b991-e5ced3f53a94" />


### Respostas

1. **O que é o Docker Hub?** 
O Docker Hub é um serviço de registro em nuvem do Docker que funciona como uma espécie de "GitHub para imagens Docker". É a plataforma onde os desenvolvedores podem hospedar suas imagens de contêineres, permitindo que elas sejam baixadas e executadas em qualquer lugar.

2. **Diferença entre CI e CD:** 
A Integração Contínua (CI) é o processo que automatiza a construção e o teste do código a cada nova alteração enviada ao repositório, garantindo que nada foi quebrado. A Entrega/Implantação Contínua (CD) é a etapa seguinte, responsável por pegar esse código validado pelo CI e automatizar a sua publicação, distribuição (como enviar a imagem para o Docker Hub) ou implantação direta no ambiente de produção.

3. **Por que usar token e Secrets em vez de escrever usuário e senha no `cd.yml`?** 
Fazemos isso por segurança. O arquivo `cd.yml` fica salvo no histórico do código e pode ser visto por qualquer pessoa com acesso ao repositório. Escrever credenciais expoe a conta a vazamentos. Os Secrets do GitHub armazenam essas informações de forma criptografada, injetando-as apenas no momento da execução. Além disso, usar um token de acesso em vez da senha pessoal é mais seguro, pois o token possui permissões limitadas e pode ser facilmente revogado se for comprometido.

4. **O que significa a tag `latest`?** 
A tag `latest` é uma tag para apontar para a versão mais atualizada de uma imagem. Se fizer o build ou tentar baixar uma imagem sem especificar o número de uma versão exata, o Docker automaticamente aplicará e buscará a tag `latest`.


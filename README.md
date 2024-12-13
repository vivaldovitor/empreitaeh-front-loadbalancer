# EmpreitAeh Front-End Load Balancer

Este projeto configura e executa o front-end da aplicação **EmpreitAeh**, utilizando um balanceador de carga baseado em **Nginx**. Abaixo, está documentado todo o processo de construção e configuração.

## Índice
1. [Pré-requisitos](#pré-requisitos)
2. [Build da Aplicação Front-End](#build-da-aplicação-front-end)
3. [Configuração do Docker](#configuração-do-docker)
4. [Setup do Nginx](#setup-do-nginx)
5. [Como Rodar a Aplicação](#como-rodar-a-aplicação)
6. [Problemas Conhecidos](#problemas-conhecidos)

---

## Pré-requisitos

Antes de começar, certifique-se de ter instalado:
- [Node.js](https://nodejs.org/) (para build do front-end)
- [Docker](https://www.docker.com/) e [Docker Compose](https://docs.docker.com/compose/)
- Editor de texto para manipular os arquivos (ex.: VS Code)

---

## Build da Aplicação Front-End

1. Clone o repositório do front-end:
    ```bash
    git clone https://github.com/vivaldovitor/empreitaeh-front-loadbalancer.git
    cd empreitaeh-front-loadbalancer
    ```

2. Instale as dependências e faça o build do front-end (utilizando Vite):
    ```
    npm install
    npm run build
    ```

3. O build será gerado no diretório /build


## Configuração do Docker

1. Criação de uma Rede Docker
- Para que o front-end e o load balancer possam se comunicar, crie uma rede Docker:
    ```
    docker network create empreitaeh-front
    ```

2. Subindo o Container do Front-End
- Execute o container Nginx para servir o front-end:
    ```
    docker run --network empreitaeh-front --name frontend -v $(pwd)/build:/usr/share/nginx/html -d nginx
    ```

## Setup do Nginx 

### Arquivo nginx.conf
- O `nginx.conf` é usado para configurações globais do Nginx, como número de processos e configurações gerais de rede.


    ```nginx
    server {
        listen       80;
        listen  [::]:80;
        server_name  localhost;

        location / {
            root   /usr/share/nginx/html;
            index  index.html index.htm;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }
    }
    

### Arquivo default.conf
    
    upstream nodes {
    server node1;
    server node2;
    server node3;
    server node4;
    server node5;
    }

    server {
        listen 80;
        server_name localhost;

        location / {
            root /usr/share/nginx/html;
            try_files $uri $uri/ /index.html;
        }
    }
    

3. Suba o container do Nginx com o arquivo default.conf:
    ```
    docker run --network empreitaeh-front -p 80:80 -v $(pwd)/default.conf:/etc/nginx/conf.d/default.conf -d nginx
    ```

## Como Rodar a Aplicação

1. Certifique-se de que os containers do front-end, back-end e do Nginx estão rodando.
2. Acesse a aplicação em:
- http://localhost


## Problemas Conhecidos

1. Erro 404 ao recarregar a página:

- Certifique-se de que o arquivo default.conf está configurado corretamente para redirecionar todas as requisições para /index.html.
    
2. Erro 500 ao acessar /auth:

- Verifique se o upstream nodes está apontando para servidores válidos.

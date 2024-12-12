# Subir o LB
docker run -it -p 80:80 -v ./default.conf:/etc/nginx/conf.d/default.conf --name loadbalancer --hostname loadbalancer nginx:alpine

# Subir o LB na rede empreitaeh-front
docker run -it -p 80:80 --network empreitaeh-front -v ./default.conf:/etc/nginx/conf.d/default.conf --name loadbalancer --hostname loadbalancer nginx:alpine

# Criar a rede docker empreitaeh-front
docker network create empreitaeh-front

# Subir os nós para teste 
docker run -d -p 80 --name node1 --hostname node1 nginx:alpine
docker run -d -p 80 --name node2 --hostname node2 nginx:alpine
docker run -d -p 80 --name node3 --hostname node3 nginx:alpine
docker run -d -p 80 --name node4 --hostname node4 nginx:alpine
docker run -d -p 80 --name node5 --hostname node5 nginx:alpine

# Subir os nós na rede empreitaeh-front
docker run -d --network empreitaeh-front --name node1 --hostname node1 -v /home/vivaldo/Documentos/estudos/gcsi/empreitAeh-front-loadbalancer/build:/usr/share/nginx/html nginx:alpine

docker run -d --network empreitaeh-front --name node2 --hostname node2 -v /home/vivaldo/Documentos/estudos/gcsi/empreitAeh-front-loadbalancer/build:/usr/share/nginx/html nginx:alpine

docker run -d --network empreitaeh-front --name node3 --hostname node3 -v /home/vivaldo/Documentos/estudos/gcsi/empreitAeh-front-loadbalancer/build:/usr/share/nginx/html nginx:alpine

docker run -d --network empreitaeh-front --name node4 --hostname node4 -v /home/vivaldo/Documentos/estudos/gcsi/empreitAeh-front-loadbalancer/build:/usr/share/nginx/html nginx:alpine

docker run -d --network empreitaeh-front --name node5 --hostname node5 -v /home/vivaldo/Documentos/estudos/gcsi/empreitAeh-front-loadbalancer/build:/usr/share/nginx/html nginx:alpine

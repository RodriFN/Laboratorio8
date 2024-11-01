Creando imagen y contenedor Docker basada en bitnami/minideb.

docker build -f Dockerfile.txt -t iminideb5 .


docker run -d -p 8091:80 -p 2222:22 --name mi_contenedor_calculadora iminideb5



1.-   http://localhost:8091





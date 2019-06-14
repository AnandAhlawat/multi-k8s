docker build -t anandahlawat90/multi-client:latest -t anandahlawat90/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anandahlawat90/mulit-server:latest -t anandahlawat90/mulit-server:$SHA -f ./server/Dockerfile ./server
docker build -t anandahlawat90/multi-worker:latest -t anandahlawat90/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push anandahlawat90/multi-client:latest
docker push anandahlawat90/multi-server:latest
docker push anandahlawat90/multi-worker:latest

docker push anandahlawat90/multi-client:latest:$SHA
docker push anandahlawat90/multi-server:latest:$SHA
docker push anandahlawat90/multi-worker:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anandahlawat90/multi-server:$SHA
kubectl set image deployments/client-deployment client=anandahlawat90/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anandahlawat90/multi-worker:$SHA

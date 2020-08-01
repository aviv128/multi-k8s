docker build -t aviv128/multi-client:latest -t aviv128/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aviv128/multi-server:latest -t aviv128/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aviv128/multi-worker:latest -t aviv128/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push aviv128/multi-client:latest
docker push aviv128/multi-server:latest
docker push aviv128/multi-worker:latest

docker push aviv128/multi-client:$SHA
docker push aviv128/multi-server:$SHA
docker push aviv128/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aviv128/multi-server:$SHA
kubectl set image deployments/client-deployment client=aviv128/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aviv128/multi-worker:$SHA
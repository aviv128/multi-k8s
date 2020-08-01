docker build -t aviv128/multi-client:latest -t aviv128/multi-clinet:$SHA -f ./client/Dokerfile ./client
docker build -t aviv128/multi-server:latest -t aviv128/multi-server:$SHA -f ./server/Dokerfile ./server
docker build -t aviv128/multi-worker:latest -t aviv128/multi-worker:$SHA -f ./worker/Dokerfile ./worker
docker push aviv128/multi-clinet:latest
docker push aviv128/multi-server:latest
docker push aviv128/multi-worker:latest

docker push aviv128/multi-clinet:$SHA
docker push aviv128/multi-server:$SHA
docker push aviv128/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=aviv128/multi-server:$SHA
kubectl set image deployments/client-deployments client=aviv128/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=aviv128/multi-worker:$SHA
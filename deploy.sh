docker build -t npotta/multi-client:latest -t npotta/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t npotta/multi-server:latest -t npotta/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t npotta/multi-worker:latest -t npotta/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push npotta/multi-client:latest
docker push npotta/multi-server:latest
docker push npotta/multi-worker:latest

docker push npotta/multi-client:$SHA
docker push npotta/multi-server:$SHA
docker push npotta/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=npotta/multi-server:$SHA
kubectl set image deployments/client-deployment client=npotta/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=npotta/multi-worker:$SHA
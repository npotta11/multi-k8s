docker build -t npotta11/multi-client:latest -t npotta11/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t npotta11/multi-server:latest -t npotta11/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t npotta11/multi-worker:latest -t npotta11/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push npotta11/multi-client:latest
docker push npotta11/multi-server:latest
docker push npotta11/multi-worker:latest

docker push npotta11/multi-client:$SHA
docker push npotta11/multi-server:$SHA
docker push npotta11/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=npotta11/multi-server:$SHA
kubectl set image deployments/client-deployment client=npotta11/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=npotta11/multi-worker:$SHA
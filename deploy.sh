docker build -t brucezw/multi-client:latest -t brucezw/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brucezw/multi-server:latest -t brucezw/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brucezw/multi-worker:latest -t brucezw/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push brucezw/multi-client:latest
docker push brucezw/multi-server:latest
docker push brucezw/multi-worker:latest
docker push brucezw/multi-client:$SHA
docker push brucezw/multi-server:$SHA
docker push brucezw/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment  server=brucezw/multi-server:$SHA
kubectl set image deployments/client-deployment  server=brucezw/multi-client:$SHA
kubectl set image deployments/worker-deployment  server=brucezw/multi-worker:$SHA

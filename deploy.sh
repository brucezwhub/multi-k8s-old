docker build -t brucezwhub/multi-client:latest -t brucezwhub/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brucezwhub/multi-server:latest -t brucezwhub/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brucezwhub/multi-worker:latest -t brucezwhub/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push brucezwhub/multi-client:latest
docker push brucezwhub/multi-server:latest
docker push brucezwhub/multi-worker:latest
docker push brucezwhub/multi-client:$SHA
docker push brucezwhub/multi-server:$SHA
docker push brucezwhub/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment  server=brucezwhub/multi-server:$SHA
kubectl set image deployments/client-deployment  server=brucezwhub/multi-client:$SHA
kubectl set image deployments/worker-deployment  server=brucezwhub/multi-worker:$SHA

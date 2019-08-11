docker build -t trickytrix/multi-client:latest -t trickytrix/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t trickytrix/multi-server:latest -t trickytrix/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t trickytrix/multi-worker:latest -t trickytrix/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push trickytrix/multi-client:latest
docker push trickytrix/multi-server:latest
docker push trickytrix/multi-worker:latest

docker push trickytrix/multi-client:$SHA
docker push trickytrix/multi-server:$SHA
docker push trickytrix/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=trickytrix/multi-server:$SHA
kubectl set image deployments/client-deployment client=trickytrix/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=trickytrix/multi-worker:$SHA
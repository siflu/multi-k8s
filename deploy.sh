docker build -t simonflueeliti8m/multi-client:latest -t simonflueeliti8m/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t simonflueeliti8m/multi-server:latest -t simonflueeliti8m/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t simonflueeliti8m/multi-worker:latest -t simonflueeliti8m/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push simonflueeliti8m/multi-client:latest
docker push simonflueeliti8m/multi-client:$SHA
docker push simonflueeliti8m/multi-server:latest
docker push simonflueeliti8m/multi-server:$SHA
docker push simonflueeliti8m/multi-worker:latest
docker push simonflueeliti8m/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=simonflueeliti8m/multi-server:$SHA
kubectl set image deployments/client-deployment client=simonflueeliti8m/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=simonflueeliti8m/multi-worker:$SHA
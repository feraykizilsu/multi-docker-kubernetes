docker build -t feraykizilsu/multi-client:latest -t feraykizilsu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t feraykizilsu/multi-server:latest -t feraykizilsu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t feraykizilsu/multi-worker:latest -t feraykizilsu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push feraykizilsu/multi-client:latest
docker push feraykizilsu/multi-server:latest
docker push feraykizilsu/multi-worker:latest

docker push feraykizilsu/multi-client:$SHA
docker push feraykizilsu/multi-server:$SHA
docker push feraykizilsu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set images deployments/server-deployment server=feraykizilsu/multi-server:$SHA
kubectl set images deployments/client-deployment client=feraykizilsu/multi-client:$SHA
kubectl set images deployments/worker-deployment worker=feraykizilsu/multi-worker:$SHA

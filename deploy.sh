docker build -t sobolevsv/multi-client:latest -t sobolevsv/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sobolevsv/multi-server:latest -t sobolevsv/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sobolevsv/multi-worker:latest -t sobolevsv/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sobolevsv/multi-client:latest
docker push sobolevsv/multi-server:latest
docker push sobolevsv/multi-worker:latest

docker push sobolevsv/multi-client:$SHA
docker push sobolevsv/multi-server:$SHA
docker push sobolevsv/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sobolevsv/multi-server:$SHA
kubectl set image deployments/client-deployment client=sobolevsv/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sobolevsv/multi-worker:$SHA

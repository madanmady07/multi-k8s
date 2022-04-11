docker build -t madanmady/multi-client-k8s:latest -t madanmady/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t madanmady/multi-server-k8s-pgfix:latest -t madanmady/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t madanmady/multi-worker-k8s:latest -t madanmady/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push madanmady/multi-client-k8s:latest
docker push madanmady/multi-server-k8s-pgfix:latest
docker push madanmady/multi-worker-k8s:latest

docker push madanmady/multi-client-k8s:$SHA
docker push madanmady/multi-server-k8s-pgfix:$SHA
docker push madanmady/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=madanmady/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=madanmady/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=madanmady/multi-worker-k8s:$SHA
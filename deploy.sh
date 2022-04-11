docker build -t madanmady07/multi-client-k8s:latest -t madanmady07/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t madanmady07/multi-server-k8s-pgfix:latest -t madanmady07/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t madanmady07/multi-worker-k8s:latest -t madanmady07/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push madanmady07/multi-client-k8s:latest
docker push madanmady07/multi-server-k8s-pgfix:latest
docker push madanmady07/multi-worker-k8s:latest

docker push madanmady07/multi-client-k8s:$SHA
docker push madanmady07/multi-server-k8s-pgfix:$SHA
docker push madanmady07/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=madanmady07/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=madanmady07/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=madanmady07/multi-worker-k8s:$SHA
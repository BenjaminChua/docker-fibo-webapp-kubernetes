docker build -t benjaminchua/multi-client:latest -t benjaminchua/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t benjaminchua/multi-server:latest -t benjaminchua/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t benjaminchua/multi-worker:latest -t benjaminchua/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push benjaminchua/multi-client:latest
docker push benjaminchua/multi-server:latest
docker push benjaminchua/multi-worker:latest

docker push benjaminchua/multi-client:$SHA
docker push benjaminchua/multi-server:$SHA
docker push benjaminchua/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=benjaminchua/multi-server:$SHA
kubectl set image deployments/client-deployment client=benjaminchua/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=benjaminchua/multi-worker:$SHA
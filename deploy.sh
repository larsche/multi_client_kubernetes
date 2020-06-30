docker build -t schemcodes/multi-client:latest -t schemcodes/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t schemcodes/multi-server:latest -t schemcodes/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t schemcodes/multi-worker:latest -t schemcodes/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push schemcodes/multi-client:latest
docker push schemcodes/multi-server:latest 
docker push schemcodes/multi-worker:latest

docker push schemcodes/multi-client:$SHA
docker push schemcodes/multi-server:$SHA 
docker push schemcodes/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=schemcodes/multi-server:$SHA
kubectl set image deployments/client-deployment client=schemcodes/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=schemcodes/multi-worker:$SHA

# since we installed kubectl we can now apply with 
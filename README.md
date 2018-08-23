1. Create an image and upload it to where you can download it, change the image path in cockroach-cronjob.yaml

2. Change in Dockerfile cockroachdb version

3. In S3-secret.yaml create base64 access and secret keys and change "Access Key base64" and "Secret Key base64"

4. In coockroach-configmap.yaml change db name, service name and bucket name in s3

5. run in terminal 

   kubectl apply -f k8s/s3-secret.yaml
   
   kubectl apply -f k8s/cockroach-configmap.yaml
   
   kubectl apply -f k8s/cockroach-cronjob.yaml
   

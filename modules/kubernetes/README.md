# AWS EKS Load Balancer Controller (ALB Ingress Controller) Deployment

## Things to note:

- Follow AWS document below for deployment:

        https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html

- The first 4 steps of the configuration of the deployment have been made with the declarative way, so they do exist in Terraform bits.

  - Remaining steps of the deployment has been made with the imperative way, so they don't exist in Terraform bits. You can find them below:

      - Install cert-manager to inject certificate configuration into the webhooks.

              kubectl apply \
                  --validate=false \
                  -f https://github.com/jetstack/cert-manager/releases/download/v1.5.4/cert-manager.yaml
                
      - Install the controller.
    
          - Download the controller specification.

                  curl -Lo v2_4_4_full.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.4.4/v2_4_4_full.yaml

          - Remove the following lines. Removing this section prevents the annotation with the IAM role that was added to the aws-load-balancer-controller Kubernetes service account that you created in a previous step from being overwritten when the controller is deployed. It also preserves the service account that you created in a previous step if you delete the controller.   
    
                  sed -i.bak -e '480,488d' ./v2_4_4_full.yaml
    
          - Replace your-cluster-name in the Deployment spec section of the file with the name of your cluster by replacing my-cluster with the name of your cluster.

                  sed -i.bak -e 's|your-cluster-name|my-cluster|' ./v2_4_4_full.yaml

        - Apply the file. 

                kubectl apply -f v2_4_4_full.yaml
                
        - To fix "IngressClassParams" error:

                curl -Lo v2_4_4_ingclass.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.4.4/v2_4_4_ingclass.yaml
                kubectl apply -f v2_4_4_ingclass.yaml
                
        - Verify that the controller is installed.
        
                kubectl get deployment -n kube-system aws-load-balancer-controller

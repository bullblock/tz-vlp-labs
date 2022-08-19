#!/usr/bin/bash
printf "%s" "Please wait, the system will be get ready in 10 mins ..."
sleep 60
while ! (nc -z -v -w5 vc.vlp.tanzulab.io 443 &> /dev/null && nc -z -v -w5 avi.vlp.tanzulab.io 443 &> /dev/null && nc -z -v -w5 wcp.vlp.tanzulab.io 6443 &> /dev/null)
do
  printf "%c" "."
  sleep 5
done
echo ""
printf "%s" "few more mins, you may go to grab a cup of coffee now and come back later ..."
export KUBECTL_VSPHERE_PASSWORD='Admin!23Admin'
kubectl vsphere login --server=https://wcp.vlp.tanzulab.io -u administrator@vsphere.local &> /dev/null
kubectl config use-context wcp.vlp.tanzulab.io &> /dev/null
while (kubectl get pod -A | grep -i csi | grep -v Running | grep -v Pending &> /dev/null)
do
  sleep 10
  while (kubectl get pod -A | grep -i csi | grep -v Running | grep -v Pending &> /dev/null)
  do
    printf "%c" "."
    sleep 5
  done
done
kubectl vsphere login --server=https://wcp.vlp.tanzulab.io -u administrator@vsphere.local --tanzu-kubernetes-cluster-namesapce=tanzulab --tanzu-kubernetes-cluster-name=vlp-cls-1 &> /dev/null
kubectl config use-context vlp-cls-1 &> /dev/null
kubectl delete -f /home/devops/workspaces/tz-vlp-labs/microservices-demo/deploy/kubernetes/complete-demo.yaml &> /dev/null
kubectl apply -f /home/devops/workspaces/tz-vlp-labs/wcp/psp.yaml &> /dev/null
# kubectl apply -f /home/devops/workspaces/tz-vlp-labs/microservices-demo/deploy/kubernetes/complete-demo.yaml &> /dev/null
# echo ""
# printf "%s" "ok, ok, ok almost there ..."
# while ! (nc -z -v -w5 172.16.0.230 80 &> /dev/null)
# do
#   printf "%c" "."
#   sleep 5
# done
printf "\n%s\n" "Okey, here you go !!! details please click the README on desktop"
sleep 30
exit


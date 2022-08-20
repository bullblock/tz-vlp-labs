#!/usr/bin/bash
echo "You may click the README on the desktop for details."
printf "%s" "Please wait, the system will be get ready in 10 mins ..."
sleep 60

while ! (nc -z -v -w5 vc.vlp.tanzulab.io 443 &> /dev/null && nc -z -v -w5 avi.vlp.tanzulab.io 443 &> /dev/null && nc -z -v -w5 172.16.0.20 6443 &> /dev/null)
do
  printf "%c" "."
  sleep 5
done

echo ""
printf "%s" "few more mins, you may go to grab a cup of coffee now and come back later ..."
kubectl config use-context vlp-cls-1 &> /dev/null

while ! (nc -z -v -w5 172.16.0.131 6443 &> /dev/null && nc -z -v -w5 172.16.0.225 80 &> /dev/null)
do
  printf "%c" "."
  sleep 5
done

printf "\n%s\n" "Okey, here you go !!! details please click the README on desktop"
sleep 30
exit


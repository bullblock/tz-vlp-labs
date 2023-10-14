#!/usr/bin/bash
echo "You may click the README on the desktop for details."
printf "%s" "Please wait, the system will be get ready in 10 mins ..."
sleep 60

while ! (nc -z -v -w5 vc.vlp.tanzulab.biz 443 &> /dev/null && nc -z -v -w5 avi.vlp.tanzulab.biz 443 &> /dev/null && nc -z -v -w5 mgmt.vlp.tanzulab.biz 6443 &> /dev/null)
do
  printf "%c" "."
  sleep 5
done

echo ""
printf "\n%s\n" "Okey, here you go !!! details please click the README on desktop"
sleep 30
exit


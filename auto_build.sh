#!/bin/bash

# fetching  latest updates from GitHub

git pull

# getting  latest  commit  tag

get_commit=`git log   |   head -5   |  tail -1   |  cut -d" "  -f5`

echo  $get_commit

#  now creating  docker image by using  upper  tag 
docker  build  -t   192.168.10.160:5000/$get_commit  .

#  now pushing  image to private docker HUB
docker  push    192.168.10.160:5000/$get_commit  

#  setting some timeout 
echo  "Please wait your images is being  pushed to Docker Registry..>>>"
sleep  5

#  now updating  kubernetes deployment  images 
echo   "updating your  deployment image ----@@@@@@@@@@ "
echo   "please wait we are about to list your all deployments:-->> "
sleep 2
# command to get deployments
kubectl get deployments  |  cut -d" " -f1
echo  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo  "@@@@                                 @@@@"
echo  "@@@@                                 @@@@"
echo  "@@@@                                 @@@@"
echo  "please enter your deployement name from above list :  "
read  get_dep;

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@---->>> "
echo "@@@@----------------------------------@@@@@@---->>> "
echo "thanks for choosing deployment :---  $get_dep"

#  finally  updating deployment

kubectl  set image deployment/$get_dep  nginx=192.168.10.160:5000/$get_commit


#!/usr/bin/env bash
name_tag=$1
output=$(aws ec2 describe-instances --filter "Name=tag-key,Values=Name" "Name=tag-value,Values=*$name_tag*" "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*][Tags[?Key=='Name'].Value[],NetworkInterfaces[0].PrivateIpAddresses[0].PrivateIpAddress]" --output text)
out=($output)
declare -A instances
for ((i=0; i<${#out[*]}; i=i+2))
do
    instances[${out[$i+1]}]=${out[$i]}
done
select instance in "${!instances[@]}"
do
   echo "you have chosen $instance"
done 

    

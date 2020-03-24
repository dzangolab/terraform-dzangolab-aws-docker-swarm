#!/bin/bash

is_elastic="${eip_allocation_id}"

if ! [ $is_elastic = "null" ]; then
    aws ec2 associate-address --instance-id ${instance_id} --allocation-id ${eip_allocation_id} --private-ip-address ${private_ip_address} --profile ${aws_profile} --region ${aws_region}

    echo "Getting details of the elastic ip:\n"

    aws ec2 describe-addresses --allocation-ids ${eip_allocation_id} --profile ${aws_profile} --region ${aws_region}
fi

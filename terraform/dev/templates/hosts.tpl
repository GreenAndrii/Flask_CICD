[flask_dev]
%{ for ip in flask_dev ~}
${ip}
%{ endfor ~}

[flask_dev:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file="/home/ubuntu/.aws/devops-eu-central-1.pem"
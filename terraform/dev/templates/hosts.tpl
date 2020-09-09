[flask_dev]
%{ for ip in flask_dev ~}
${ip}
%{ endfor ~}

[flask_dev:vars]
ansible_user=ubuntu
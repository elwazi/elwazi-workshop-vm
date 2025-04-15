127.0.0.1 localhost

%{ for index, node in workshop_servers ~}
${ node.network[0].fixed_ip_v4 } ${ node.name }
%{ endfor ~}

${ login.network[0].fixed_ip_v4 } login

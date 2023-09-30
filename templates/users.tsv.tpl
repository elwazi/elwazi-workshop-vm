username	password	server	login_command
%{ for index, node in workshop_servers ~}
%{ for user_count in range(1, users_per_server + 1) ~}
${ format("user%02s", index * users_per_server + user_count ) }	${ passwords[index * users_per_server + user_count - 1] }	${ floating_ips[index].address }	${ format("user%02s", index * users_per_server + user_count ) }@${ floating_ips[index].address }
%{ endfor ~}
%{ endfor ~}

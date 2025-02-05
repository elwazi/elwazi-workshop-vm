username	password	server	login_command
%{ for index, node in workshop_servers ~}
%{ for user_count in range(1, users_per_server + 1) ~}
${ format("user%02s", index * users_per_server + user_count ) }	${ passwords[index * users_per_server + user_count - 1] }   ${ ips[index] }
%{ endfor ~}
%{ endfor ~}

%{ for index, user in admin_users ~}
${ user.username }	${ admin_passwords[index] }	all	${ user.username }
%{ endfor ~}

workshop_servers:
  hosts:
%{ for index, node in workshop_servers ~}
    ${ node.name }:
      ansible_host: ${ floating_ips[index].address }
      private_ip: ${ node.network[0].fixed_ip_v4 }
      workshop_users:
%{ for user_count in range(1, users_per_server + 1) ~}
        - username: ${ format("user%02s", index * users_per_server + user_count ) }
          password: ${ passwords[index * users_per_server + user_count - 1] }
          uid: ${ index * users_per_server + user_count + 10000 }
%{ endfor ~}
%{ endfor ~}
  vars:
    ansible_connection: ssh
    ansible_ssh_common_args: '-o StrictHostKeyChecking=no -o ControlPersist=15m -i ${ ssh_public_key }'
    ansible_user: ubuntu
    admin_users:
%{ for index, user in admin_users ~}
      - username: ${ user.username }
        ssh_key: ${ user.public_key }
        uid: ${ index + 20000 }
%{ endfor ~}
    cromwell_install: ${ install.cromwell }
    docker_install: ${ install.docker }
    jupyter_install: ${ install.jupyter }
    singularity_install: ${ install.singularity }
    nextflow_install: ${ install.nextflow }
    biotools_install: ${ install.biotools }

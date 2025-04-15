login_servers:
  hosts:
    login_node:
      ansible_host: ${ floating_ip }
      workshop_users: "{{ workshop_users_all }}"
  vars:
    ansible_connection: ssh
    ansible_ssh_common_args: '-o StrictHostKeyChecking=no -o ControlPersist=15m -i ${ ssh_public_key }'
    ansible_user: ubuntu
    domain_name: ${ domain_name }
    jupyter_install: ${ install.jupyter }
    rstudio_install: ${ install.rstudio }


workshop_servers:
  hosts:
%{ for index, node in workshop_servers ~}
    ${ node.name }:
      private_ip: ${ node.network[0].fixed_ip_v4 }
      ansible_host: ${ node.network[0].fixed_ip_v4 }
      workshop_users:
%{ for user_count in range(1, users_per_server + 1) ~}
        - username: ${ format("user%02s", index * users_per_server + user_count ) }
          password: ${ passwords[index * users_per_server + user_count - 1] }
          uid: ${ index * users_per_server + user_count + 10000 }
%{ endfor ~}
%{ endfor ~}
  vars:
    ansible_connection: ssh
    ansible_ssh_common_args: '-o StrictHostKeyChecking=no -o ControlPersist=15m -i ${ ssh_public_key } -o ProxyJump=ubuntu@${ floating_ip }'
    ansible_user: ubuntu
    cromwell_install: ${ install.cromwell }
    docker_install: ${ install.docker }
    jupyter_install: ${ install.jupyter }
    singularity_install: ${ install.singularity }
    nextflow_install: ${ install.nextflow }
    biotools_install: ${ install.biotools }
    rstudio_install: ${ install.rstudio }


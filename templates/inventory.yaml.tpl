workshop_servers:
  hosts:
%{ for index, node in workshop_servers ~}
    ${ node.name }:
      ansible_host: ${ floating_ips[index].address }
      private_ip: ${ node.network[0].fixed_ip_v4 }
      workshop_users:
%{ for password_index, password in passwords ~}
        - username: user${ password_index }
          password: ${ password }
%{ endfor ~}
%{ endfor ~}
  vars:
    ansible_connection: ssh
    ansible_ssh_common_args: '-o StrictHostKeyChecking=no -o ControlPersist=15m -i ${ ssh_public_key }'
    ansible_user: ubuntu
    admin_users:
      - username: dane
        ssh_key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSU6y4lUazLnlyf/Ug+xYm2wI+zO3rd8L/7sAvChfaP dane@pop-os
      - username: gerrit
        ssh_key: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDX2guNUCFhfBytdsF98bw5hWbaD6usSqe34q3WCS92img+hJB10cxWHGvtwigxJcNV7QDWR8I4iGblMVCBa99VltL94ibel6rYzzP081NAfyYjpQ1WKFG6jdiRE03hRZvFcz/iARC26nwSPDjJcDdHzy+wFQsKlvyo780hIN5lmWMHkLyn1p+LvnsUQwGWbtepQdSVISE1Ii7n80VjnZc1nUXXh8vjUq9KUN/HMABVReE7iSPDOJ+JG5KScNqg8eiOFhwXCVg9G++gHpbMHVjWxKgrly40WcD39JMP06St3VQF+4UI+dzLhzxLiIfzCYXFvo73GxNUM8a04I8xy8EUnOwZFoUpTQNm/Bw7BNSLgcsom56z/ND40x1yupcP4CZ4zxL3D/uWOk+8jUld4PqWEDxt1Q7FlUFqjD/Yd8ADk8NFM83OQNGcjRE4O2PTOPrYZpnSTNkRD6sPvP9+teU9HsD0nsi/PZd0GDyEITNL1ibD4Xb3ubGhUjdBEArDh5bgNpSLToDeWTMzmrg9KoIum9zbkeCnaUhKCGCLqjCn5xQH13ryoYtiKwt4Ndi2+iseMyuRY/7RVQG8SEaKjFDo+lqqNzzwHbb5Z6SiFcLiRWiJMQ2UllC6j6dXBZWwAYMlPwnI+FYBgWhGoOnsau5Ur5xO5p2HxTb1AfvtQK3b3w== gerrit.botha@uct.ac.za
    cromwell_install: true
    docker_install: true
    jupyter_install: false
    singularity_install: true
    nextflow_install: true
    biotools_install: true

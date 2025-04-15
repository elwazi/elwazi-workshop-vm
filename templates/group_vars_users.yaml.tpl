---
workshop_users_all:
%{ for index, password in passwords ~}
    - username: ${ format("user%02s", index + 1) }
      password: ${ password }
      uid: ${ index + 10000 + 1}
%{ endfor ~}

admin_users:
%{ for index, user in admin_users ~}
    - username: ${ user.username }
      ssh_key: ${ user.public_key }
      uid: ${ index + 20000 }
      password: ${ admin_passwords[index] }
%{ endfor ~}

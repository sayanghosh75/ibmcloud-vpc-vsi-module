####################################################
##  Data source containing Cloudinit definitions  ##
####################################################

data "template_cloudinit_config" "vsi_userdata" {
  base64_encode = false
  gzip          = false

  part {
    content = <<EOF
#cloud-config
packages:
  - mc
  - htop
# Add users to the system. Users are added after groups are added.
groups:
  - wheel
  - docker
users:
  - default
  - name: ansible
    gecos: Ansible Automation
    groups: docker
    sudo: ALL=(ALL) NOPASSWD:ALL
    lock_passwd: true
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD537pXch5ugGJFqcIacHh+pk3z+A6vWWBnQMnJvrLn9DVPQwFEtqNkDPaei3WbR9hj3Afwkm49seQlflLR0CaHQYyXQfllRjFlXL0M6xOK0V1qULz+OZxeotAgiYxl+AANexGO5yylKpv5NEm1qRXtwabkLVY/wQUNVo4ucuDM2qhUJqpQmQZHQFczipFN+yvhQ6hRQbxM9aw4aSEacA+UKOOdd4IER+chtdqB4s1J5bXP8zx99Fo80s9UZ+LyTY64nPZSV/vjE79dESMuCneEpIh/GBtHkkMk9w++EmIUbdBEY7LYk1WGkyyFqaXJ2G+eS9W5pyVM9m2Ur9Cov+tmqds+zR7AR/aCfigCf1gQnZ/fZpTV9paaNAvscRfm2hK1BVF+ny6yhtcmISodIIiEWAFB1EwNP1Tgpsz1HESipk5lIHdUMgGLNeNH67U9QkZqTBzEu+NOh0xpy2bnuH04tSBUiwqIuZGI938KZrLPAM/dqoyh5/qqzAeXUicMyPfCHQ3GTeg835T3KcRvVtTlKVsf1F6Mqwo8h+vpy7teGlXS4R60J8gzLd2/AH9ddNWxtMpNUWB0qg9pnDXyzPDpHpaHCflYvzN3itfOqUgJeZ5rXD7em0vgNynnACmK2FowDvKVRTvDA+C2/tBiFqocyqWahXNFeQz4XD+EwubTiw== shallcrm@au1.ibm.com
# Update command prompt for selected users
runcmd:
  - sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' /root/.bashrc
  - sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' /home/ansible/.bashrc
# Send final message that all steps are complete
final_message: "The system is finally up, after $UPTIME seconds" 
EOF

  }
}


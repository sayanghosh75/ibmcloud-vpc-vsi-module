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
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDlRL+oidf4TgYRYobJwq5xLLkDr14dX+sXHJ3EcCTp/QjZx4sZTATvhTscSi4e/5+1bE6elpxVup7pD8d4VjNjykuacdYFWoWYY/2ytawfj5vgRVBtXuNgFJTwy2DGEq6J23vJsBxTtap9ke4dq4f0fliKAiKI292gj2z0HmX0l1hfarQPsWciZ2p9Dn8iIjer3aitWajSOcnfD+ZDoOmPDSX4Ed70eMYQBvOsYC+KQsCQU2pryPlotgk9w9qc2wO6y3xN8uTQ4DwwBPz+x1OStXgRWPS/4d7QdPJ4HdNRAGNiWVnX3/MOFyUrG9GNEgPxTchv84sG1VBx6bLGxREgIAS+4SNilDB4RYD3ZCviqNw9rUfEnfHI5apUtd2aOSCZJ7b11Zj4mvPJEZVwiS8S5cZB3HinwNRVSGRhU2tBK0O+nXZdI0o/3w8zozscV4nq9GREDWKPjrD4dqcL5BDhWIcD4WxergXXI9jIttlR9AtKfHT/lQiR2muO3QGGN/xXilc7QD5h07w2KIuQa3YBZwDmXetI5iJt5P8hjOPwQFuQpx36Md0diD0oh4PQEKpfjqJgJcOKriFg7Vhp60hoQRQSENce3yPCZWTnWleG2YDGe5Cw1Q32tl8dOTB0K2u0twMcEaN3224jL+/24Kk7M8+hjuBS3Qohtip1iLy8LQ== m.a.shallcross@gmail.com
# Update command prompt for selected users
runcmd:
  - sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' /root/.bashrc
  - sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' /home/ansible/.bashrc
# Send final message that all steps are complete
final_message: "The system is finally up, after $UPTIME seconds" 
EOF

  }
}


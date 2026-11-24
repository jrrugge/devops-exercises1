# Command cheatsheet

Commands I want to remember, from the labs and the AWS project. Back to the [journey log](progress.md).

## Directories and archives

```bash
mkdir -p release/v2/{bin,config,logs} && touch release/v2/VERSION   # folder build
zip -r ~/sandbox/release-v2.zip release/                            # archive
```

## Users and groups

```bash
sudo useradd -m [name]               # create a user with a home directory
sudo passwd [name]                   # set a password
sudo userdel -r [name]               # delete a user and their home directory
sudo adduser [name] sudo             # give sudo rights
sudo usermod -aG ops [name]          # add to a group (or: sudo adduser [name] ops)
sudo gpasswd -d [name] ops           # remove from a group
sudo groupadd [group-name]           # create a group
sudo groupdel legacy                 # delete a group
groups                               # list my groups
less -X /etc/group                   # read the group file
id ; id [name]                       # user and group IDs
su - [name]                          # switch user with their login environment
```

## A custom command on the PATH

```bash
mkdir -p ~/bin
echo -e '#!/bin/bash\necho "ready to deploy"' > ~/bin/greet
chmod +x ~/bin/greet
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
greet
```

## SSH config

```bash
chmod 700 ~/.ssh                     # secure the folder

cat << 'EOF' > ~/.ssh/config
Host myserver
    HostName 1.2.3.4
    User student
    IdentityFile ~/.ssh/id_rsa

Host prod
    HostName 5.6.7.8
    User ubuntu
    Port 22
    IdentityFile ~/.ssh/prod_key.pem
EOF

chmod 600 ~/.ssh/config              # owner read/write only
```

## Docker and Compose

```bash
docker compose up --build -d         # build and start in the background
docker compose ps                    # status and health
docker compose logs -f               # follow logs
docker compose down                  # stop and remove containers (named volumes survive)
docker build --platform linux/amd64 -t smartlead-app .   # image for AWS instances
```

## Terraform

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
terraform apply -target=aws_ecr_repository.app   # one resource first
terraform state list
terraform destroy
```

## AWS CLI

```bash
aws sts get-caller-identity                                  # who am I?
aws elbv2 describe-target-health --target-group-arn <arn>    # are targets registered and healthy?
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names <name>
```

## Git

```bash
git status
git update-index --chmod=+x mvnw     # record the execute bit for a script committed from Windows
git ls-files -s mvnw                 # check the stored mode (100755 = executable)
```

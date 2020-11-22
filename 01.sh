ssh -i .ssh/robk-dev.pem ec2-user@34.220.254.54

curl http://169.254.169.254/latest/meta-data
# ami-id
# ami-launch-index
# ami-manifest-path
# block-device-mapping/
# events/
# hibernation/
# hostname
# identity-credentials/
# instance-action
# instance-id
# instance-life-cycle
# instance-type
# local-hostname
# local-ipv4
# mac
# managed-ssh-keys/
# metrics/
# network/
# placement/
# profile
# public-hostname
# public-ipv4
# public-keys/
# reservation-id
# security-groups

curl http://169.254.169.254/latest/meta-data/hostname; echo $line;
ip-172-31-2-52.us-west-2.compute.internal

sudo yum install mysql

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install node
node -e "console.log('Running Node.js ' + process.version)"


mysql -h db-1.c7fndrsi0u6m.us-west-2.rds.amazonaws.com -u admin -p
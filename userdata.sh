#!/bin/bash
# Update the package list
sudo yum update -y

# Install MongoDB
sudo tee /etc/yum.repos.d/mongodb-org-4.4.repo <<EOF
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
EOF

sudo yum install -y mongodb-org

# Start MongoDB
sudo systemctl start mongod
sudo systemctl enable mongod

# Wait for MongoDB to start
sleep 10

# Create MongoDB users and databases based on the instance index
case ${count.index} in
  0)
    mongo <<EOD
    use admin
    db.createUser({
      user: "${admin_user}",
      pwd: "${admin_pass}",
      roles: [{ role: "userAdminAnyDatabase", db: "admin" }]
    })
    EOD
    ;;
  1)
    mongo <<EOD
    use ${database2}
    db.createUser({
      user: "${readwrite_user}",
      pwd: "${readwrite_pass}",
      roles: [{ role: "readWrite", db: "${database2}" }]
    })
    EOD
    ;;
  2)
    mongo <<EOD
    use ${database3}
    db.createUser({
      user: "${readonly_user}",
      pwd: "${readonly_pass}",
      roles: [{ role: "read", db: "${database3}" }]
    })
    EOD
    ;;
esac

#!/bin/bash


echo "generating bart's ssh for testing..."
rm john john.pub ./keys/*.pub
ssh-keygen -f john -N "" && mv john.pub ./keys

echo "test run..."
ansible-playbook -i inventory test.yml -C
if [ $? -ne 0 ]
then
  echo "test run failed"
  exit 1
fi 

echo "real run..."
ansible-playbook -i inventory test.yml
if [ $? -ne 0 ]
then
  echo "real run failed"
  exit 1
fi

echo "trying ssh, should fail..."
timeout 3 ssh -i john john@192.168.122.2 hostname
#timeout 3 ssh root@192.168.122.2 hostname
if [ $? -eq 0 ]
then
  echo "sftp only user shouldn't be able to ssh"
  exit 1
fi

echo "trying sftp..."
rm -f /tmp/john.batch
sftp -b john.batch -i john john@192.168.122.2
diff john.batch /tmp/john.batch
if [ $? -ne 0 ]
then
  echo "sftp file transfer fail"
  exit 1
fi

ansible-playbook -i inventory test-cleanup.yml

echo "remove john's keys..."
rm -f john john.pub
rm -f ./keys/*.pub

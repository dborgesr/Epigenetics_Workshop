#!/bin/bash

USERS="user1:password1 user2:password2"

for USER_PASS in $USERS; do
  USERNAME=$(echo $USER_PASS | cut -d':' -f1)
  PASSWORD=$(echo $USER_PASS | cut -d':' -f2)

  useradd -m $USERNAME
  echo "$USERNAME:$PASSWORD" | chpasswd

done

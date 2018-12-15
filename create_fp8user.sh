#!/bin/sh

# Create user or group if not already exists

userId=$1
groupId=$2

userName="fp8user"

# Check if groupId already exists
groupName=$(getent group $groupId | cut -d: -f 1)
if [ -z "$groupName" ]; then
    groupName="fp8group"
    addgroup -g $groupId $groupName
fi

# Check if userId already exists
userName=$(getent passwd $userId | cut -d: -f 1)
if [ -z "$userName" ]; then
    userName=fp8user
    adduser -u $userId -G $groupName -D $userName
fi

# output the username
echo "$userName"

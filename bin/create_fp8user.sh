#!/bin/sh

# ===========================================================
# Author:   Marcos Lin
# Created:  18 Dec 2018
#
# Script used to create user with given userId and groupId.
#
# If id provided already exists, use it or default to:
# - user:  fp8user
# - group: fp8group
#
# Returns the name of the username create or existing.
#
# ===========================================================

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
    adduser -u $userId -G $groupName -s /bin/sh -D $userName 
fi

# output the username
echo "$userName"

#!/bin/sh
# Copyright (c) 2018 Project. All rights reserved.
# ---------------------------------------------------------------------------------------
# NOTICE:  All information contained herein is, and remains
# the property of Vietnam and its suppliers,
# if any.  The intellectual and technical concepts contained
# herein are proprietary to Vietnam
# and its suppliers and may be covered by Vietnamese Law,
# patents in process, and are protected by trade secret or copyright law.
# Dissemination of this information or reproduction of this material
# is strictly forbidden unless prior written permission is obtained
# from Vietnam.
# ---------------------------------------------------------------------------------------
# Author:
#       Tai Tran <tai.tran@gmail.com>

# Force migration - Must be changed for production
# Force operation can make data lost
cd ..

git pull
git status
git branch

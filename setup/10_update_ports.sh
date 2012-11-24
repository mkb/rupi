#!/bin/bash

emit 'Updating your ports...'
set -x
apt-get update -y
apt-get upgrade -y

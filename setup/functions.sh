#!/bin/bash

emit () {
  set +x
  echo -en '\e[41;37m'"RuPi:\033[0m"
  echo -e "\033[1m $1\033[0m"
  set -x
}

#!/bin/bash
output=$(fpm run --example false_assertion --compiler flang-new --flag '-mmlir -allow-assumed-rank -O3' > /dev/null 2>&1)
echo $?

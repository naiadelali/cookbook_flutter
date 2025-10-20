#!/bin/bash

modules=("auth" "core")

root=$PWD
for module in ${modules[@]}
do      
    folder=$"$root/modules/$module"
    
    if [ -d $folder ]; then
        cd $folder
        echo "Running flutter test..."
        flutter test --machine --coverage > tests.output
        echo "$module ✅"
    fi

    cd $root
done

cd $root/modules

sonar-scanner

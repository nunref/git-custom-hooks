#!/usr/bin/bash

# A script for deploying the current hooks to the git templates directory 
# The path to the git templates directory is received as an argument and must contain a hooks directory

GIT_TEMPLATE_DIR=$1

echo "The chosen git templates dir is $GIT_TEMPLATE_DIR"
if [ -d "$GIT_TEMPLATE_DIR" ]; then
    if [ -d "$GIT_TEMPLATE_DIR/hooks" ]; then
        for hook in $(ls hooks/);
        do
            extensionless_hook=${hook%.py}
            echo Deploying $hook as $extensionless_hook ...
            cp hooks/$hook $GIT_TEMPLATE_DIR/hooks/$extensionless_hook
            echo Updating execute permission for $extensionless_hook ...
            chmod +x $GIT_TEMPLATE_DIR/hooks/$extensionless_hook
            echo $hook deployed correctly
        done
    else
        echo "There is not a 'hooks' folder in the templates dir."
        exit 1
    fi
else
    echo "The templates directory $GIT_TEMPLATE_DIR is not found."
    exit 1
fi


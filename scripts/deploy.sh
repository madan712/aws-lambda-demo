#!/usr/bin/bash

set -euo pipefail

echo "Creating build"
mvn clean package

build=$(mvn -q -Dexec.executable=echo -Dexec.args='target/${project.artifactId}-${project.version}.${project.packaging}' --non-recursive exec:exec)
echo "build: ${build}"

echo "Calling terraform"
terraform init && terraform apply -auto-approve -var "build=${build}"
# openjdk-gradle-terraform

[![CircleCI](https://circleci.com/gh/blairnangle/openjdk-gradle-terraform.svg?style=shield)](https://app.circleci.com/pipelines/github/blairnangle/openjdk-gradle-terraform)

OpenJDK Docker image with Python 3, pip, Gradle, Terraform, Checkov and the AWS CLI tool. See [`Dockerfile`](./Dockerfile)
for exact versions.

Written with the intention of creating a single, consistent CircleCI container image for Java applications that 
deploy their infrastructure with Terraform in the same pipeline (but are not necessarily deployed as containerized
applications).

Published via CircleCI to [Docker Hub](https://hub.docker.com/repository/docker/blairnangle/openjdk-gradle-terraform).

## Usage

Simple example of a CircleCI pipeline for a Gradle project `dummy` with a `terraform` subdirectory containing its 
infrastructure code that makes use of the [aws-cli orb](https://circleci.com/orbs/registry/orb/circleci/aws-cli) to set 
up credentials (using default environment variables configured in CircleCI):

```yaml
version: 2.1

executors:
  openjdk-gradle-terraform:
    docker:
      - image: blairnangle/openjdk-gradle-terraform:latest

orbs:
  aws-cli: circleci/aws-cli@1.0.0

workflows:
  version: 2
  build_and_later_some_other_stuff:
    jobs:
      - build
      - infra

jobs:
  build:
    executor: openjdk-gradle-terraform
    steps:
      - checkout
      - run:
          name: Build
          command: gradle build
  infra:
    executor: openjdk-gradle-terraform
    working_directory: ~/dummy/terraform
    steps:
      - checkout:
          path: ~/dummy
      - aws-cli/setup
      - run:
         name: Initialize
         command: terraform init
      - run:
          name: Validate
          command: terraform validate
      - run:
          name: Check
          command: checkov -d .
      - run:
          name: Plan
          command: terraform plan --out plan.tf
      - run:
          name: Apply
          command: terraform apply plan.tf
```

The pipeline is basic (does not actually deploy an artifact, for example) and the planning and application of the 
Terraform infrastructure should probably be split into separate jobs, but it illustrates the tools that are made 
available to CircleCI by using the `blairnangle/openjdk-gradle-terraform` image.

## License

Distributed under [MIT License](./LICENSE).

# openjdk-gradle-terraform

[![CircleCI](https://circleci.com/gh/blairnangle/openjdk-gradle-terraform.svg?style=shield)](https://app.circleci.com/pipelines/github/blairnangle/openjdk-gradle-terraform)

OpenJDK Docker image with Python 3, pip, Gradle, Terraform and Checkov. See [`Dockerfile`](./Dockerfile) for exact 
versions.

Written with the intention of creating a single, consistent CircleCI container image for Java applications that 
deploy their infrastructure with Terraform in the same pipeline (but are not necessarily deployed as containerized
applications).

Published via CircleCI to [Docker Hub](https://hub.docker.com/repository/docker/blairnangle/openjdk-gradle-terraform).

## License

Distributed under [MIT License](./LICENSE).

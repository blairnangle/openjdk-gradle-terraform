# Get base OpenJDK (Ubuntu) image
FROM openjdk:11

# Add maintainer details
MAINTAINER "Blair Nangle" "hi@blairnangle.com"

# Set working directory
WORKDIR /opt

# Get information on latest packages
RUN apt-get update

# Fetch and install specific version of Gradle
ENV GRADLE_VERSION=6.4.1
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P tmp
RUN unzip -d gradle tmp/gradle-${GRADLE_VERSION}-bin.zip
RUN rm -rf tmp
ENV GRADLE_HOME=/opt/gradle/gradle-${GRADLE_VERSION}
ENV PATH=${GRADLE_HOME}/bin:${PATH}

# Install specific version of python3-pip
RUN apt-get install -y python3-pip=18.1-5

# Install specific version of Checkov
RUN pip3 install -Iv checkov==1.0.302

# Install specific version of Terraform
ENV TERRAFORM_VERSION=0.12.25
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/
RUN rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install specific version of awscli
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
RUN unzip awscliv2.zip
RUN ./aws/install
RUN rm awscliv2.zip

FROM quay.io/debezium/connect:2.7

# Install wget
USER root
RUN microdnf install -y wget && microdnf clean all

# Download and set up JDBC connector
USER kafka
RUN mkdir -p /kafka/connect/debezium-connector-jdbc && \
    wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-jdbc/3.0.0.Final/debezium-connector-jdbc-3.0.0.Final-plugin.tar.gz -O /tmp/jdbc-connector.tar.gz && \
    tar -xzf /tmp/jdbc-connector.tar.gz -C /kafka/connect/debezium-connector-jdbc && \
    rm /tmp/jdbc-connector.tar.gz

# Set the working directory
WORKDIR /kafka/connect

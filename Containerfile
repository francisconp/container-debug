FROM registry.fedoraproject.org/fedora
LABEL MAINTAINER="Franciscon Santos - francisconp@gmail.com"

# Set directory app home
ENV HOME_DIR /app

# Add python3 command to PATH
ENV PATH $PATH,/usr/bin/

# Install pip, dig, nc, openssl, ss, traceroute ......
RUN dnf install -y python3-pip bind-utils nc iperf3 httpie openssl python3-flask \
    traceroute iproute \
    && dnf clean all

# Copy simple page to home directory
COPY src $HOME_DIR

# Set compatibility mode to Kubernetes and Openshift
# Reference: https://developers.redhat.com/articles/2021/11/11/best-practices-building-images-pass-red-hat-container-certification#best_practice__3__set_group_ownership_and_file_permissions
RUN chown -R 1001:0 $HOME_DIR && \
    chmod -R g=u $HOME_DIR
USER 1001

# Simple App Running
ENTRYPOINT python3 /app/main.py

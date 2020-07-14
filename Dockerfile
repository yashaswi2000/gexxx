#Stage 1 - Install dependencies and build the app
FROM debian:latest AS build-env

# Install flutter dependencies
RUN apt-get update 
RUN apt-get install -y curl git wget zip unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Run flutter doctor and set path
RUN /usr/local/flutter/bin/flutter doctor -v
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter channel beta
RUN flutter upgrade
RUN flutter config --enable-web

WORKDIR /home/dev/
RUN git clone -b docker --single-branch https://github.com/yashaswi2000/gexxx.git
WORKDIR /home/dev/gexxx
CMD ["flutter","run","-d", "web-server","--verbose"]

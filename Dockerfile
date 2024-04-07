FROM ubuntu:20.04



# Install requirements

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    # OpenCV dependencies
    build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
    python3-dev python3-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev \
    libcanberra-gtk-module libcanberra-gtk3-module

# Clone, build and install OpenCV
RUN git clone https://github.com/opencv/opencv.git && \
    cd /opencv && mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j"$(nproc)" && \
    make install && \
    rm -rf /opencv

COPY . .

RUN g++ waldo.cpp -o waldo

ENV PORT=8080

EXPOSE 8080

CMD [ "./waldo" ]


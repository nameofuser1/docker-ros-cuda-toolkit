FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

RUN apt-get update && apt-get install -y apt-utils wget 

# Build gcc 5.5.0 for building DLIB
RUN wget https://ftp.gnu.org/gnu/gcc/gcc-5.5.0/gcc-5.5.0.tar.gz && \
	tar -xvzf /gcc-5.5.0.tar.gz && \
	cd /gcc-5.5.0 && ./contrib/download_prerequisites && \
	cd / && mkdir -p gcc-build && mkdir -p gcc-5.5.0-build && cd gcc-build && \
	../gcc-5.5.0/configure --enable-languages=c,c++ --prefix=/gcc-5.5.0-build --exec-prefix=/gcc-5.5.0-build --disable-multilib && \
	make -j$(nproc) && make install && rm -rf /gcc-5.5.0

# Install opencv
RUN apt-get install -y \
		build-essential checkinstall cmake pkg-config yasm \
		git gfortran \
		libjpeg8-dev libjasper-dev libpng12-dev \
		libtiff5-dev \
		libxine2-dev libv4l-dev \
		libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev \
		libqt4-dev libgtk2.0-dev libtbb-dev \
		libatlas-base-dev \
		libfaac-dev libmp3lame-dev libtheora-dev \
 		libvorbis-dev libxvidcore-dev \
		libopencore-amrnb-dev libopencore-amrwb-dev \
		x264 v4l-utils 

RUN apt-get install -y \
		python3 \
		python3-dev \
		python3-pip \
		python3-setuptools \
		python-pip \
		python3-setuptools

# Install DLIB. 
#RUN git clone https://github.com/davisking/dlib && mkdir /dlib/build && cd /dlib/build && \
#	export CC=/gcc-5.5.0-build/bin/gcc && \
#	export CXX=/gcc-5.5.0-build/bin/g++ && \
#	cmake .. -DDLIB_USE_CUDA=1 -DUSE_AVX_INSTRUCTIONS=1 && make -j$(nproc) && make install && \
#	cd /dlib && python3 setup.py install && \
#	cd / && rm -rf dlib 

RUN git clone https://github.com/opencv/opencv_contrib && \
	git clone https://github.com/opencv/opencv && \
	mkdir /opencv/opencv-build && cd /opencv/opencv-build && \
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
 		-D CMAKE_INSTALL_PREFIX=/usr/local \
 		-D WITH_CUDA=ON \
 		-D ENABLE_FAST_MATH=1 \
 		-D CUDA_FAST_MATH=1 \
 		-D WITH_CUBLAS=1 \
 		-D INSTALL_PYTHON_EXAMPLES=ON \
 		-D INSTALL_C_EXAMPLES=ON \
 		-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
 		-D WITH_GTK=ON \
 		-D ENABLE_PRECOMPILED_HEADERS=OFF \
 		-D BUILD_EXAMPLES=ON .. && \
 	make -j$(nproc) && make install && ldconfig && \
 	cd / && \
 	rm -rf /opencv_contrib && \
 	rm -rf /opencv

RUN pip3 install --upgrade pip
RUN pip3 install numpy pandas scipy sympy sklearn matplotlib face_recognition imutils tensorflow-gpu keras
RUN pip3 install jupyter && rm -rf gcc-5.5.0.tar.gz
FROM arnoudbuzing/wolframengine:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && \
		DEBIAN_FRONTEND=noninteractive apt-get install -y -qq texlive-full \
            autoconf \
            automake \
            autotools-dev \
            build-essential \
            curl \
            dpkg-dev \
            git \
            gnupg \
            imagemagick \
            ispell \
            libacl1-dev \
            libasound2-dev \
            libcanberra-gtk3-module \
            liblcms2-dev \
            libdbus-1-dev \
            libgif-dev \
            libgnutls28-dev \
            libgpm-dev \
            libgtk-3-dev \
            libjansson-dev \
            libjpeg-dev \
            liblockfile-dev \
            libm17n-dev \
            libmagick++-6.q16-dev \
            libncurses5-dev \
            libotf-dev \
            libpng-dev \
            librsvg2-dev \
            libselinux1-dev \
            libtiff-dev \
            libxaw7-dev \
            libxml2-dev \
            openssh-client \
            python \
						python-pygments \
            texinfo \
            xaw3dg-dev \
            zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L https://ftp.gnu.org/gnu/emacs/emacs-26.2.tar.xz | tar xJ && \
		 cd *emacs* && \
    ./autogen.sh && \
    ./configure --with-modules --with-x-toolkit=no && \
    make -j $(nproc) && \
    make install && \
		cd .. && rm -rf *emacs*

CMD emacs
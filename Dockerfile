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

RUN emacs --batch \
          --eval "(require 'package)" \
          --eval '(setq package-archives (quote (("melpa" . "http://melpa.org/packages/") ("org-mode" . "http://orgmode.org/elpa/"))))' \
          --eval "(package-initialize)" \
          --eval "(unless package-archive-contents (package-refresh-contents))" \
          --eval "(package-install 'use-package)" \
          --eval "(setq use-package-always-ensure t)" \
          --eval "(use-package ox-latex)" \
          --eval "(use-package ob-mathematica :ensure org-plus-contrib)" \
          --eval "(use-package htmlize)" \
          --eval "(use-package dash)" \
          --eval "(use-package request)" \
          --eval "(use-package json)"


CMD emacs

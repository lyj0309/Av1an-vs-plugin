FROM masterofzen/av1an:master
# RUN python vsrepo.py install kagefunc fvsfunc havsfunc vsTAAmbk mvsfunc muvsfunc nnedi3_resample vsutil lsmas
USER root

RUN sudo pacman -Syu --noconfirm && pacman -S python-pip git cmake --noconfirm && pip install meson ninja setuptools cython  wheel --break-system-package
RUN sudo pacman -Syu --noconfirm && pacman -S boost opencl-headers nasm fftw --noconfirm   

RUN pacman -Rsc  --noconfirm vapoursynth
RUN pacman  -Syu --noconfirm --needed aom ffmpeg ffms2 libvpx mkvtoolnix-cli svt-av1 vmaf

RUN git clone https://bitbucket.org/the-sekrit-twc/zimg.git --depth 1 --recurse-submodules --shallow-submodules &&\
    pushd zimg &&\
    ./autogen.sh &&\
    ./configure --prefix=/usr &&\
    make -j$(nproc) &&\
    sudo make install -j$(nproc) &&\
    popd &&\
    rm -rf zimg

WORKDIR /workspace

RUN git clone https://github.com/vapoursynth/vapoursynth.git && cd vapoursynth && ./autogen.sh && ./configure --prefix=/usr && \
    make -j$(nproc) && make install -j$(nproc) 
RUN  cd vapoursynth  && python setup.py sdist -d sdist && mkdir empty && pushd empty && pip install vapoursynth --no-index --find-links ../sdist --break-system-packages && popd

RUN pacman -S libass --noconfirm   


# 复制构建脚本到工作目录
COPY build.sh /workspace/
RUN chmod +x build.sh && ./build.sh 

RUN pip install git+https://github.com/OpusGang/awsmfunc.git --break-system-packages && \
    pip install git+https://github.com/Jaded-Encoding-Thaumaturgy/vs-tools.git --break-system-packages && \
    pip3 install git+https://github.com/HomeOfVapourSynthEvolution/mvsfunc --break-system-packages  &&\
    pip3 install git+https://github.com/HomeOfVapourSynthEvolution/havsfunc --break-system-packages
WORKDIR /workspace
# USER app_user
ENTRYPOINT ["/bin/bash"]
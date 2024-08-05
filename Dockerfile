FROM masterofzen/av1an:master
# RUN python vsrepo.py install kagefunc fvsfunc havsfunc vsTAAmbk mvsfunc muvsfunc nnedi3_resample vsutil lsmas
USER root
RUN pacman -Rsc vapoursynth
RUN sudo pacman -Syu --noconfirm && pacman -S python-pip git cmake --noconfirm && pip install meson ninja setuptools cpython wheel --break-system-package

RUN git clone https://github.com/vapoursynth/vapoursynth.git && cd vapoursynth && make -j$(nproc) && make install -j$(nproc) && python setup.py sdist -d sdist && mkdir empty && pushd empty && pip install vapoursynth --no-index --find-links ../sdist && popd

RUN pip install git+https://github.com/OpusGang/awsmfunc.git --break-system-packages && \
    pip3 install git+https://github.com/HomeOfVapourSynthEvolution/mvsfunc --break-system-packages  &&\
    pip3 install git+https://github.com/HomeOfVapourSynthEvolution/havsfunc --break-system-packages
RUN sudo pacman -Syu --noconfirm && pacman -S boost opencl-headers nasm fftw --noconfirm    
WORKDIR /workspace

# 复制构建脚本到工作目录
COPY build.sh /workspace/

# 赋予构建脚本执行权限
RUN chmod +x build.sh && ./build.sh 
# RUN pip install -U vsdpir --break-system-package
RUN rm  /usr/lib/python3.12/site-packages/vapoursynth.cpython-312-x86_64-linux-gnu.so
RUN pip install git+https://github.com/Jaded-Encoding-Thaumaturgy/vs-tools.git  --break-system-packages
# RUN rm /usr/lib/python3.12/site-packages/vapoursynth.so
# RUN mv /usr/lib/python3.12/site-packages/vapoursynth.cpython-312-x86_64-linux-gnu.so /usr/lib/python3.12/site-packages/vapoursynth.so
# RUN chmod 777  /usr/lib/python3.12/site-packages/vapoursynth.so
USER app_user
ENTRYPOINT ["/bin/bash"]
# Dockerfile
#
# MIT License
#
# Copyright (c) 2025 Fabricio Batista Narcizo, Elizabete Munzlinger, Sai Narsi
# Reddy Donthi Reddy, and Shan Ahmed Shaffi.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

# Sets the base image for the Docker build to Ubuntu 22.04.
FROM ubuntu:22.04

# Adds metadata to the Docker image.
LABEL maintainer="https://www.fabricionarcizo.com"
LABEL version="1.0"
LABEL description="Ubuntu 22.04 Docker image to be the base for QNN SDK"

# Updates package lists, installs essential packages, and adds the Deadsnakes
# PPA for additional Python versions.
RUN \
    apt update \
    && apt install -y \
    	software-properties-common \
    	gcc \
    && add-apt-repository -y ppa:deadsnakes/ppa

# Updates package lists and installs common development and debugging tools.
RUN \
    apt update \
    && apt install -y \
        adb \
        build-essential \
        clang \
        cmake \
        file \
        g++ \
        git \
        iputils-ping \
        libc++1 \
        libfreetype6-dev \
        libgl1 \
        nano \
        pkg-config \
        unzip \
        vim \
        wget \
        zsh

# Install oh-my-zsh.
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
SHELL ["/bin/zsh", "-c"]

# Install oh-my-zsh packages.
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Setup the oh-my-zsh environment.
RUN echo 'include "/usr/share/nano/*.nanorc"' >> ~/.nanorc \
    && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Setup the autoenv environment.
RUN wget --show-progress -o /dev/null -O- 'https://raw.githubusercontent.com/hyperupcall/autoenv/main/scripts/install.sh' | sh

# Install Miniconda.
RUN mkdir -p ~/.miniconda3 \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/.miniconda3/miniconda.sh \
    && bash ~/.miniconda3/miniconda.sh -b -u -p ~/.miniconda3 \
    && rm ~/.miniconda3/miniconda.sh \
    && ~/.miniconda3/bin/conda init

# Create the Conda environment.
ENV PYTHON_VERSION=3.10.16

RUN echo "y" | /root/.miniconda3/bin/conda create --name snpe python=$PYTHON_VERSION

RUN echo "y" | /root/.miniconda3/bin/conda create --name model-zoo python=$PYTHON_VERSION

# Install the Python packages used for development, environment management,
# and interactive computing.
RUN source ~/.miniconda3/etc/profile.d/conda.sh \
    && conda activate snpe \
    && pip --no-cache-dir install \
        jupyter \
        pip-tools \
        rich \
        wheel

RUN source ~/.miniconda3/etc/profile.d/conda.sh \
    && conda activate model-zoo \
    && pip --no-cache-dir install \
        jupyter \
        pip-tools \
        rich \
        wheel

# Install TensorFlow packages.
RUN source ~/.miniconda3/etc/profile.d/conda.sh \
    && conda activate snpe \
    && pip --no-cache-dir install \
        tensorflow==2.10.1 \
        tflite==2.3.0

# Install PyTorch packages.
RUN source ~/.miniconda3/etc/profile.d/conda.sh \
    && conda activate snpe \
    && pip --no-cache-dir install \
        --extra-index-url https://download.pytorch.org/whl/cpu \
        torch==1.13.1 \
        torchvision==0.14.1 \
        torchaudio==0.13.1

# Install ONNX packages.
RUN source ~/.miniconda3/etc/profile.d/conda.sh \
    && conda activate snpe \
    && pip --no-cache-dir install --no-deps \
        protobuf==3.19.6 \
        onnx==1.12.0 \
        onnx-graphsurgeon \
        onnx-simplifier \
        onnxruntime==1.16.1

# Install the Caffe to ONNX converter.
RUN source ~/.miniconda3/etc/profile.d/conda.sh \
    && conda activate snpe \
    && pip --no-cache-dir install --no-deps \
        git+https://github.com/asiryan/caffe2onnx.git

# Install ML packages.
RUN source ~/.miniconda3/etc/profile.d/conda.sh \
    && conda activate snpe \
    && pip --no-cache-dir install \
        pycocotools==2.0.6 \
        sacrebleu==2.3.1 \
        sentencepiece \
        scikit-learn \
        transformers

# Install required Python packages.
RUN source ~/.miniconda3/etc/profile.d/conda.sh \
    && conda activate snpe \
    && pip --no-cache-dir install -U \
        absl-py==2.1.0 \
        aenum==3.1.15 \
    	attrs==23.2.0 \
        dash==2.12.1 \
    	decorator==4.4.2 \
        invoke==1.7.3 \
        joblib==1.4.0 \
    	jsonschema==4.19.0 \
        lxml==5.2.1 \
        mako==1.1.0 \
        matplotlib==3.3.4 \
        mock==3.0.5 \
        numpy==1.26.4 \
        opencv-python==4.5.4.58 \
        optuna==3.3.0 \
    	packaging==24.0 \
        pandas==2.0.1 \
        paramiko==3.4.0 \
        pathlib2==2.3.6 \
        pillow==10.2.0 \
        plotly==5.20.0 \
    	psutil==5.6.4 \
        pydantic==2.7.4 \
        pytest==8.1.1 \
    	pyyaml==5.3 \
    	rich==13.9.4 \
        safetensors==0.4.3 \
        scikit-optimize==0.9.0 \
        scipy==1.10.1 \
    	six==1.16.0 \
        tabulate==0.9.0 \
    	typing-extensions==4.10.0 \
        xlsxwriter==1.2.2

# Install AI model packages.
RUN source ~/.miniconda3/etc/profile.d/conda.sh \
    && conda activate model-zoo \
    && pip --no-cache-dir install \
        super-gradients==3.7.1 \
        pycocotools==2.0.8 \
        ultralytics==8.3.146

RUN source ~/.miniconda3/etc/profile.d/conda.sh \
    && conda activate model-zoo \
    && pip --no-cache-dir install \
        onnx2tf==1.27.10 \
        tensorflow==2.19.0 \
        tf-keras==2.19.0 \
        onnx-graphsurgeon==0.5.8 \
        ai_edge_litert==1.2.0 \
        sng4onnx==1.0.4

RUN source ~/.miniconda3/etc/profile.d/conda.sh \
    && conda activate model-zoo \
    && pip --no-cache-dir install -U \
        numpy==1.23.0

# Install additional packages for oh-my-zsh environment.
RUN \
    apt update \
    && apt install -y \
        autojump

# Declare that the container will listen on ports 8888 (commonly used for
# Jupiter Notebooks) and 5037 (used by ADB for Android debugging).
EXPOSE 8888
EXPOSE 8889
EXPOSE 5037

# Copy the oh-my-zsh config file.
COPY ./.zshrc /root/.zshrc

# Copy setup script.
COPY ./setup_env.sh /setup_env.sh

# Copy the URL patch file.
COPY ./fix_url.patch /fix_url.patch

# Make the setup script executable.
RUN chmod +x /setup_env.sh

# Run the setup script to configure the environment.
RUN /bin/zsh /setup_env.sh

# Run the patch to fix the URL in the super-gradients package.
RUN patch -p1 /root/.miniconda3/envs/model-zoo/lib/python3.10/site-packages/super_gradients/training/utils/checkpoint_utils.py < /fix_url.patch

# Default env variables.
ENV QNN_SDK_ROOT=/qairt/2.34.0.250424

# Set the default shell to zsh.
#CMD ["/bin/zsh"]
CMD ["tail", "-f", "/dev/null"]

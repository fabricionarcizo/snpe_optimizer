#!/bin/zsh
#
# MIT License
#
# Copyright (c) 2025 Fabricio Batista Narcizo, Elizabete Munzlinger, Anuj Dutt,
# Shan Ahmed Shaffi, and Sai Narsi Reddy Donthi Reddy.
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

# Version modified from Qualcomm Innovation Center to adapt the script to use
# miniconda and /bin/zsh


download_ndk() {
    local ndk_url="https://dl.google.com/android/repository/android-ndk-r26c-linux.zip"
    local ndk_zip_path="$HOME/android-ndk-r26c-linux.zip"
    local ndk_extract_dir="$HOME/android-ndk-r26c"

    echo "📥 Downloading Android NDK to $ndk_zip_path..."
    wget "$ndk_url" -O "$ndk_zip_path"
    unzip -q "$ndk_zip_path" -d "$HOME"
    export ANDROID_NDK_ROOT="$ndk_extract_dir"
    export PATH="${ANDROID_NDK_ROOT}:${PATH}"

    echo "✅ Android NDK installed at $ANDROID_NDK_ROOT"

    if [[ -x "${QNN_SDK_ROOT}/bin/envcheck" ]]; then
        "${QNN_SDK_ROOT}/bin/envcheck" -n
    else
        echo "⚠️  Warning: envcheck not found or not executable"
    fi
}


setup_env() {
    source ~/.miniconda3/etc/profile.d/conda.sh
    conda activate snpe

    [[ -x "${QNN_SDK_ROOT}/bin/check-python-dependency" ]] && "${QNN_SDK_ROOT}/bin/check-python-dependency"
    pip install --no-cache-dir onnxruntime==1.16.1

    [[ -f "${QNN_SDK_ROOT}/bin/check-linux-dependency.sh" ]] && source "${QNN_SDK_ROOT}/bin/check-linux-dependency.sh"
    [[ -f "${QNN_SDK_ROOT}/bin/envsetup.sh" ]] && source "${QNN_SDK_ROOT}/bin/envsetup.sh"

    [[ -x "${QNN_SDK_ROOT}/bin/envcheck" ]] && "${QNN_SDK_ROOT}/bin/envcheck" -c

    export PATH="/root/.miniconda3/envs/snpe/lib/python3.10/site-packages/tensorflow:$PATH"
    export PATH="/root/.miniconda3/envs/snpe/lib/python3.10/site-packages/onnx:$PATH"
    export TENSORFLOW_HOME="/root/.miniconda3/envs/snpe/lib/python3.10/site-packages/tensorflow"

    download_ndk

    echo "✅ Environment setup completed"
}


if [[ -z "${QNN_SDK_ROOT}" ]]; then
    export QNN_SDK_ROOT="/qairt/2.34.0.250424"
    echo "ℹ️  Using default QNN SDK path: $QNN_SDK_ROOT"
fi

setup_env

# Persist env to zshrc.
sed -i '/setup_env.sh/d' ~/.zshrc

# Define the environment variables.
echo "# Environmental variables." >> ~/.zshrc
echo "export QNN_SDK_ROOT=\"$QNN_SDK_ROOT\"" >> ~/.zshrc
echo "export ANDROID_NDK_ROOT=\"$ANDROID_NDK_ROOT\"" >> ~/.zshrc
echo "export SNPE_ROOT=\"$QNN_SDK_ROOT\"" >> ~/.zshrc
echo "export PYTHONPATH=\"\$PYTHONPATH:$QNN_SDK_ROOT/lib/python\"" >> ~/.zshrc
echo "export LD_LIBRARY_PATH=\"\$LD_LIBRARY_PATH:$QNN_SDK_ROOT/lib/x86_64-linux-clang\"" >> ~/.zshrc
echo "export PATH=\"\$SNPE_ROOT/bin/x86_64-linux-clang:$PATH\"" >> ~/.zshrc

# Add the conda environment to zshrc.
echo "\n# Conda environment setup." >> ~/.zshrc
echo "source ~/.miniconda3/etc/profile.d/conda.sh" >> ~/.zshrc
echo "export PATH=\"/root/.miniconda3/envs/snpe/bin:\$PATH\"" >> ~/.zshrc
echo "conda activate snpe" >> ~/.zshrc

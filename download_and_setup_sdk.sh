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

# Script to download and set up the Qualcomm Neural Processing SDK for AI.
# Version: 2.34.0.250424.
SDK_URL="https://softwarecenter.qualcomm.com/api/download/software/sdks/Qualcomm_AI_Runtime_Community/All/2.34.0.250424/v2.34.0.250424.zip"
SDK_DIR="./qairt"
SDK_VERSION="2.34.0.250424"
ZIP_FILE="${SDK_VERSION}.zip"

# Check if the SDK version directory already exists
if [ -d "${SDK_DIR}/${SDK_VERSION}" ]; then
    echo "SDK version ${SDK_VERSION} already exists in ${SDK_DIR}."
    exit 0
fi

# Download the SDK zip file if it doesn't exist
if [ ! -f "${SDK_DIR}/${ZIP_FILE}" ]; then
    echo "Downloading Qualcomm Neural Processing SDK for AI..."
    curl -L -o "${SDK_DIR}/${ZIP_FILE}" "$SDK_URL"
else
    echo "SDK zip file already downloaded."
fi

# Unzip the SDK
echo "Unzipping SDK..."
unzip -q "${SDK_DIR}/${ZIP_FILE}" -d "$SDK_DIR"

# Move contents if extracted to nested directory
if [ -d "${SDK_DIR}/qairt/${SDK_VERSION}" ]; then
    mv "${SDK_DIR}/qairt/${SDK_VERSION}" "${SDK_DIR}/"
    rmdir "${SDK_DIR}/qairt"
fi

echo "SDK setup completed."

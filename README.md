# SNPE Optimizer

This repository contains tools and scripts for optimizing deep learning models, with a focus on YOLO-NAS S and YOLO-hagRID models, for deployment on edge devices. It includes model conversion, quantization, and benchmarking utilities, as well as example notebooks for model optimization and evaluation. This toolkit is designed for the tutorial `Edge AI in Action: Technologies and Applications` at IEEE/CVF CVPR 2025.

## Table of Contents

- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
- [Model Zoo](#model-zoo)
- [Output Models](#output-models)
- [Notebooks](#notebooks)
- [License](#license)

---

## Project Structure

```
.
├── docker-compose.yml
├── Dockerfile
├── download_and_setup_sdk.sh
├── fix_url.patch
├── LICENSE
├── README.md
├── setup_env.sh
├── models/
│   ├── README.md
├── notebooks/
│   ├── model_optimization.ipynb
│   ├── model_zoo.ipynb
│   ├── qai_hub.ipynb
├── qairt/
│   ├── README.md
```

- **models/**: Pretrained and optimized model files (YOLO-NAS S and YOLO-hagRID variants, ONNX, DLC, TFLite, and TensorFlow SavedModel formats).
- **notebooks/**: Jupyter notebooks for model optimization, export, and evaluation. Contains validation and raw data folders.
- **qairt/**: SDK and tools for quantization and inference.
- **setup_env.sh**: Script to set up the Python environment.
- **download_and_setup_sdk.sh**: Script to download and set up the required SDK.
- **Dockerfile** and **docker-compose.yml**: For containerized setup.

---

## Requirements

- Linux (recommended)
- Python 3.8+
- Docker (optional, for containerized setup)
- Jupyter Notebook (for running notebooks)
- Bash or Zsh shell

---

## Setup

### 1. Clone the Repository

```zsh
git clone https://github.com/fabricionarcizo/snpe_optimizer.git
cd snpe_optimizer
```

### 2. Download and Set Up the SDK

Run the script to download and set up the required SDK (e.g., Qualcomm AI Runtime):

```zsh
bash download_and_setup_sdk.sh
```

### 3. Use Docker

To build and run the project with docker-compose:

```zsh
docker-compose build
docker-compose up -d
```

---

## Usage

### 1. Model Export and Optimization

- Use the Jupyter notebook `notebooks/model_zoo.ipynb` to:
  - Download and export a COCO-pretrained YOLO-NAS S model to ONNX, TFLite, and TensorFlow formats.
  - Download and export a hagRID-pretrained YOLO 11 model to ONNX, TFLite, and TensorFlow formats.
  - Save all exported models in the `models/` directory.
- Use the Jupyter notebook `notebooks/model_optimization.ipynb` to:
  - Perform model quantization, conversion, and benchmarking (DLC, TFLite, etc).
  - Create validation samples in `notebooks/val2017/` and `notebooks/raw/`.
  - Save optimized models in the `models/` directory.
- Use the Jupyter notebook `notebooks/qai_hub.ipynb` to:
  - Explore and interact with Qualcomm AI Hub resources and tools for model deployment and optimization.

### 2. Running Notebooks

The docker-compose setup will automatically start Jupyter Notebooks:

- Access the model zoo notebook at:  
  [http://127.0.0.1:8889/notebooks/model_zoo.ipynb](http://127.0.0.1:8889/notebooks/model_zoo.ipynb)
- Access the model optimization notebook at:  
  [http://127.0.0.1:8888/notebooks/model_optimization.ipynb](http://127.0.0.1:8888/notebooks/model_optimization.ipynb)

---

## Model Zoo

- The `models/` directory will contain both YOLO-NAS S and YOLO-hagRID models in ONNX, DLC, TFLite, and TensorFlow formats.
- Refer to `notebooks/model_zoo.ipynb` for examples on how to use and export these models.

---

## Output Models

- `yolo_nas_s.onnx`, `yolo_hagRID.onnx`: Original ONNX models (COCO and hagRID-pretrained).
- `yolo_nas_s_fp32.dlc`, `yolo_hagRID_fp32.dlc`: Floating-point DLC models.
- `yolo_nas_s_int8.dlc`, `yolo_hagRID_int8.dlc`: INT8 quantized DLC models.
- `yolo_nas_s_int8_htp_sm7325.dlc`, `yolo_hagRID_int8_htp_sm7325.dlc`: INT8 quantized models for HTP (SM7325).
- `yolo_nas_s_float16.tflite`, `yolo_nas_s_float32.tflite`, `yolo_nas_s_int8.tflite`: YOLO-NAS S TFLite models (various quantizations).
- `yolo_hagRID_float16.tflite`, `yolo_hagRID_float32.tflite`, `yolo_hagRID_int8.tflite`: YOLO-hagRID TFLite models (various quantizations).
- `yolo_nas_s/`, `yolo_hagRID/`: TensorFlow SavedModel directories for each model.

---

## Notebooks

- `model_optimization.ipynb`: Step-by-step guide for optimizing and benchmarking models.
- `model_zoo.ipynb`: Examples of exporting and using both YOLO-NAS S and YOLO-hagRID models.
- `qai_hub.ipynb`: Interface and utilities for Qualcomm AI Hub integration, providing access to additional model deployment and optimization workflows.

---

## License

This project is licensed under the terms of the [LICENSE](LICENSE) file.

---

**Authors:** Fabricio Batista Narcizo, Elizabete Munzlinger, Sai Narsi Reddy Donthi Reddy, and Shan Ahmed Shaffi.

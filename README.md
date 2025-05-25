# hagRID Optimizer

This repository contains tools and scripts for optimizing deep learning models, with a focus on YOLO NAS models, for deployment on edge devices. It includes model conversion, quantization, and benchmarking utilities, as well as example notebooks for model optimization and evaluation. This is a research-oriented optimization toolkit designed for experiments and development for the tutorial `Edge AI in Action: Technologies and Applications` presented during the IEEE/CVF Conference on Computer Vision and Pattern Recognition 2025 (CVPR 2025).

## Table of Contents

- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
- [Model Zoo](#model-zoo)
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
│   └── README.md
├── notebooks/
│   ├── model_optimization.ipynb
│   ├── model_zoo.ipynb
├── qairt/
│   ├── README.md
```

- **models/**: Pretrained and optimized model files.
- **notebooks/**: Jupyter notebooks for model optimization and evaluation.
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
- Bash shell

---

## Setup

### 1. Clone the Repository

```bash
git clone https://github.com/fabricionarcizo/hagRID_optimizer.git
cd hagRID_optimizer
```

## 2. Download and Set Up the SDK

Run the script to download and set up the required SDK (e.g., Qualcomm AI Runtime):

```bash
bash download_and_setup_sdk.sh
```

### 3. Use Docker

To build and run the project in a docker-compose:

```bash
docker-compose build
docker-compose up -d
```

---

## Usage

### 1. Model Optimization

- Use the Jupyter notebook `notebooks/model_zoo.ipynb` to to load a COCO-pretrained YOLO-NAS S model and export it to ONNX format using PyTorch and SuperGradients.
- The `notebooks/model_zoo.ipynb` will save models in the `models/` directory.
- Use the Jupyter notebook `notebooks/model_optimization.ipynb` to perform model quantization, conversion, and benchmarking.
- The `notebooks/model_optimization.ipynb` will create a sample of coco dataset in `notebooks/val2017/` and `notebooks/raw/` directories, and save optimized models in the `models/` directory.

### 2. Running Notebooks

The docker-compose will automatically start the Jupyter Notebooks:

1. **Access the model zoo notebook** in your browser at:  
    [http://127.0.0.1:8889/notebooks/model_zoo.ipynb](http://127.0.0.1:8889/notebooks/model_zoo.ipynb)
2. **Access the model optimization notebook** in your browser at:  
    [http://127.0.0.1:8888/notebooks/model_optimization.ipynb](http://127.0.0.1:8888/notebooks/model_optimization.ipynb)

### 3. Model Zoo

- The `models/` directory will contain various versions of YOLO NAS models in ONNX and DLC formats.
- Refer to `notebooks/model_zoo.ipynb` for examples on how to use these models.

---

## Output Models

- `yolo_nas_s.onnx`: Original ONNX model.
- `yolo_nas_s_fp32.dlc`: Floating-point DLC model.
- `yolo_nas_s_int8.dlc`: INT8 quantized DLC model.
- `yolo_nas_s_int8_htp_sm7325.dlc`: INT8 quantized model for HTP (SM7325).

---

## Notebooks

- `model_optimization.ipynb`: Step-by-step guide for optimizing and benchmarking models.
- `model_zoo.ipynb`: Examples of using different models from the zoo.

---

## License

This project is licensed under the terms of the [LICENSE](LICENSE) file.

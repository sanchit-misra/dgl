#!/bin/bash

set -e
mkdir -p sub407_baseline && cd sub407_baseline || exit 1
# update following line to setup gcc 8.3.0 compiler
#source /swtools/gcc/8.3.0/gcc_vars.sh
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash ./Miniconda3-latest-Linux-x86_64.sh -b -p ./miniconda3
miniconda3/bin/conda create -y -n sub407_baseline python=3.7.10

echo "Activating conda env..."
source miniconda3/bin/activate sub407_baseline

echo "Installing packages...."
conda install -y numpy ninja pyyaml mkl mkl-include setuptools cmake cffi jemalloc tqdm future pydot scikit-learn
conda install -y -c intel numpy
conda install -y -c eumetsat expect
conda install -y -c conda-forge gperftools onnx tensorboardx libunwind

echo "Install pytorch..."
#conda install -y pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 cpuonly -c pytorch
conda install -y pytorch==1.7.1  cpuonly -c pytorch
echo $?

#echo "Install torch-ccl..."
#export Torch_DIR=$(python -c "import torch; import os; print(os.path.dirname(torch.__file__) + '/share/cmake/Torch');")
#( git clone https://github.com/ddkalamk/torch-ccl.git && cd torch-ccl && git checkout working_1.7 && git submodule sync && git submodule update --init --recursive && CMAKE_C_COMPILER=gcc CMAKE_CXX_COMPILER=g++ python setup.py install )

#echo "Install DGL..."
#( git clone --recursive https://github.com/sanchit-misra/dgl.git -b xeon-optimizations && cd dgl && git checkout c4d98dd && rm -rf build && mkdir build && cd build && cmake ../ &&  make -j && cd ../python && python setup.py clean && CMAKE_C_COMPILER=gcc CMAKE_CXX_COMPILER=g++ python setup.py install ) 

#( git clone --recursive https://github.com/sanchit-misra/dgl.git -b xeon-optimizations && cd dgl && git checkout c4d98dd )
#( git clone --recursive https://github.com/dmlc/dgl.git && cd dgl && git checkout d4a1be3 )
#cd dgl
#sed -i 's/dgl_option(USE_AVX "Build with AVX optimization" ON)/dgl_option(USE_AVX "Build with AVX optimization" OFF)/' CMakeLists.txt
#( rm -rf build && mkdir build && cd build && cmake ../ &&  make -j && cd ../python && python setup.py clean && CMAKE_C_COMPILER=gcc CMAKE_CXX_COMPILER=g++ python setup.py install )
#cd ../

( git clone --recursive https://github.com/yuk12/dgl.git -b scbase && cd dgl && git checkout bcdbad2 && rm -rf build && mkdir build && cd build && cmake ../ &&  make -j && cd ../python && python setup.py clean && CMAKE_C_COMPILER=gcc CMAKE_CXX_COMPILER=g++ python setup.py install )


#echo "Installing few more packages.."
#pip install psutil
#pip install ogb
#pip install rdflib

echo "All installations done !!!"

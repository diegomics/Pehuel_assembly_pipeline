#!/bin/bash
cd ~/Software
conda create -n REAPR_env
conda activate REAPR_env
conda install -c anaconda networkx
git clone --recursive https://github.com/mdriller/masterTool.git
cd masterTool/scripts/minimap2/
make

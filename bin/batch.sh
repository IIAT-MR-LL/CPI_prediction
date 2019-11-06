#!/bin/bash
cd "$(dirname "$0")"
cd ../code

. /opt/conda/etc/profile.d/conda.sh
conda activate my-rdkit-env

bash preprocess_data.sh
bash run_training.sh
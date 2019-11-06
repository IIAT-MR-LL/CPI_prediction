#!/bin/bash
cd "$(dirname "$0")"
cd ..
cur_path="$(pwd)"

. /opt/conda/etc/profile.d/conda.sh
conda activate my-rdkit-env
python -m ipykernel install --name rdkit --display-name "rdkit-env"
#

cd ./code
#bash preprocess_data.sh
bash run_training.sh &

#Set up jupyter
cd $cur_path
jupyter notebook --allow-root

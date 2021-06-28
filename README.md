# microbial-community-analysis

### add conda channels
conda config --add channels bioconda
conda config --add channels conda-forge

### create environment and install tools
conda create -f environment.yaml


#### activate environment 
conda activate MCA

### edit the config.txt file and put in all necessary information
### run the htstream script with config.txt as argument

./htstream config.txt

check the directory 'outdir' for the results

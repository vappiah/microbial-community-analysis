# microbial-community-analysis

### add conda channels
```conda config --add channels bioconda```
```conda config --add channels conda-forge```

### clone github repository
```
git clone https://github.com/vappiah/microbial-community-analysis
cd microbial-community-analysis
```

### create environment and install tools
```
conda create -n MCA htstream multiqc
```


#### activate environment 
```conda activate MCA``` 
         or
 ``` source activate MCA```
### edit the config.txt file and put in all necessary information
### run the htstream script with config.txt as argument
```
chmod +x htstream.sh
./htstream.sh config.txt
```
### check the directory 'outdir' for the results
```
ls outdir
```

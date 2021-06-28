#!/usr/bin/bash

config=$1

inpath=$(grep -i fastqdir $config|cut -d'=' -f2)
threads=$(grep -i threads $config|cut -d'=' -f2)
samplelist=$(grep -i samplelist $config|cut -d'=' -f2)
primers_5p=$(grep -i primers_5p $config|cut -d'=' -f2)
primers_3p=$(grep -i primers_5p $config|cut -d'=' -f2)

echo $samplelist
echo $inpath
mkdir outdir

outpath=outdir
mkdir $outpath

allfiles=($(cat $samplelist))

for sample in ${allfiles[@]}
do

echo $sampl
hts_Stats \
        --stats-file ${outpath}/${sample}.json \
        -1 ${inpath}/${sample}*_R1.fastq.gz \
        -2 ${inpath}/${sample}*_R2.fastq.gz \
        --notes 'Initial Stats' | \
    hts_Overlapper \
        --append-stats-file ${outpath}/${sample}.json \
        --number-of-threads $threads \
        --notes 'Overlap reads' | \
    hts_Primers \
        --append-stats-file ${outpath}/${sample}.json \
        --primers_5p GTGYCAGCMGCCGCGGTAA \
        --primers_3p GGACTACNVGGGTWTCTAAT \
        --min_primer_matches 2 \
        --flip \
        --float 5 \
        --notes 'Single set V3V4 primers' | \
    hts_NTrimmer \
        --append-stats-file ${outpath}/${sample}.json \
        --exclude \
        --notes 'Remove any reads with Ns' | \
    hts_LengthFilter \
        --append-stats-file ${outpath}/${sample}.json \
        --min-length 100 \
        --max-length 400 \
        --notes 'Filter sequences 100 - 400' | \
    hts_Stats \
        --append-stats-file ${outpath}/${sample}.json \
        --force \
        --fastq-output ${outpath}/${sample} \
        --notes 'Final Stats'

done


echo "done"

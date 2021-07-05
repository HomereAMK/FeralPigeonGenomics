# **FPG — _University of Copenhagen_**


### Re-Sequencing + GBS Data Pipeline — by **Filipe G. VIEIRA** [![Foo](../FPG--GitHubAuxiliaryFiles/ORCIDGreenRoundIcon.png)](https://orcid.org/0000-0002-8464-7770)  &  **George PACHECO** [![Foo](../FPG--GitHubAuxiliaryFiles/ORCIDGreenRoundIcon.png)](https://orcid.org/0000-0002-9367-6813)

**Feral Pigeon Genomics**: Documention outlining the entire reasoning behind this pipeline. \\
Please, contact **George Pacheco** (ganpa@aqua.dtu.dk) should any questions arise.
***
***

### 1) Acess to Raw Data & Local Storage 

> The GBS raw data was directly downloaded from the server of the _Institute of Biotechnology_ — _University of Cornell_ using an ordinary `-wget` command. This data is now stored on [ERDA](https://www.erda.dk/) under Pacheco's account (DQM353), and can be downloaded through the links below.
#

- [FPG_1](https://sid.erda.dk/share_redirect/DUyRcvLTbq)
- [FPG_2](https://sid.erda.dk/share_redirect/BTbP4yIran)
- [FPG_3](https://sid.erda.dk/share_redirect/bWkpOKZxmV)
- [FPG_4](https://sid.erda.dk/share_redirect/F1K0CZNDq5)
- [FPG_5](https://sid.erda.dk/share_redirect/DFNvZ6qk2I)
- [FPG_Extra](https://sid.erda.dk/share_redirect/Bsj30FqosH)
***

### 2) Sequencing Quality Check

> A general sequencing quality check of each plate was performed using [FASTQc--v0.11.5](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) under default options. The results of each run is stored inside the respectives folders of each plate. We considered that all the plates passed this general sequencing quality check.
#

##### _Example_:
```
~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_1/FPGP_1-C2YYMACXX_3_Fastqced--v0.11.5/
```
***

### 3) Demultiplexing

> All the plates were demultiplexed in the very same way using the software [GBSX--v1.3](https://github.com/GenomicsCoreLeuven/GBSX) based on the barcode info provided by the key file of each plate. The idea was to minimally filter the reads here leaving this job to be performed by the PaleoMix run that will follow:
#

##### **FPG_1**:
```
xsbatch -c XXX --time XXX -J XXX -- java -jar /groups/hologenomics/software/GBSX/releases/latest/GBSX_v1.3.jar --Demultiplexer -t XXX -f1 ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_1/FPGP_1-C2YYMACXX_3_fastq.gz -i ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_1/FPGP_1-C2YYMACXX_3_Barcodes.info -mb 1 -me 1 -ca false -gzip true -o ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_1/FPGP_1-C2YYMACXX_3_Demultiplexed_GBSX--v1.3/
```

##### **FPG_2**:
```
xsbatch -c XXX --time XXX -J XXX -- java -jar /groups/hologenomics/software/GBSX/releases/latest/GBSX_v1.3.jar --Demultiplexer -t XXX -f1 ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_2/FPGP_2-C3KBHACXX_7_fastq.gz -i ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_2/FPGP_2-C3KBHACXX_7_Barcodes.info -mb 1 -me 1 -ca false -gzip true -o ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_2/FPGP_2-C3KBHACXX_7_Demultiplexed_GBSX--v1.3/
```

##### **FPG_3**:
```
xsbatch -c XXX --time XXX -J XXX -- java -jar /groups/hologenomics/software/GBSX/releases/latest/GBSX_v1.3.jar --Demultiplexer -t XXX -f1 ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_3/FPGP_3-C5706ACXX_8_fastq.gz -i ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_3/FPGP_3-C5706ACXX_8_Barcodes.info -mb 1 -me 1 -ca false -gzip true -o ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_3/FPGP_3-C5706ACXX_8_Demultiplexed_GBSX--v1.3/
```

##### **FPG_4**:
```
xsbatch -c XXX --time XXX -J XXX -- java -jar /groups/hologenomics/software/GBSX/releases/latest/GBSX_v1.3.jar --Demultiplexer -t XXX -f1 ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_4/FPGP_4-CA7YJANXX_7_fastq.gz -i ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_4/FPGP_4-CA7YJANXX_7_Barcodes.info -mb 1 -me 1 -ca false -gzip true -o ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_4/FPGP_4-CA7YJANXX_7_Demultiplexed_GBSX--v1.3/
```

##### **FPG_5**:
```
xsbatch -c XXX --time XXX -J XXX -- java -jar /groups/hologenomics/software/GBSX/releases/latest/GBSX_v1.3.jar --Demultiplexer -t XXX -f1 ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_5/FPGP_5-CA7YJANXX_8_fastq.gz -i ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_5/FPGP_5-CA7YJANXX_8_Barcodes.info -mb 1 -me 1 -ca false -gzip true -o ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_5/FPGP_5-CA7YJANXX_8_Demultiplexed_GBSX--v1.3/
```

##### **FPG_Extra**:
```
xsbatch -c XXX --time XXX -J XXX -- java -jar /groups/hologenomics/software/GBSX/releases/latest/GBSX_v1.3.jar --Demultiplexer -t XXX -f1 ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_Extra/FPGP_Extra-CADYEANXX_1_fastq.gz -i ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_Extra/FPGP_Extra-CADYEANXX_1_Barcodes.info -mb 1 -me 1 -ca false -gzip true -o ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_Extra/FPGP_Extra-CADYEANXX_1_Demultiplexed_GBSX--v1.3/
```

##### Eliminates the `.R1` suffix of each demultiplexed file with an ordinary `-mv` command:

##### _Example_:

```
mv ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_5/FPGP_5-CA7YJANXX_8_Demultiplexed_GBSX--v1.3/Wattala_01.R1.fastq.gz ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_5/FPGP_5-CA7YJANXX_8_Demultiplexed_GBSX--v1.3/Wattala_01.fastq.gz
```
***

### 4) Filtering For Chimeric Reads

> We filtered our GBS reads for chimeric reads in the same way presented by [Pacheco et al. 2020](https://academic.oup.com/gbe/article/12/3/136/5735467). We used the same `.bed` file presented in this publication to restrict our analyses to the _GBS_ loci.
#

##### Executes an inicial _PaleoMix_ run with the original _GBSed_ demultiplexed files in order to be able to indetify the chemeric reads. We used the `.yaml` file below and respective command:

```
xsbatch -c XXX --mem-per-cpu XXX -J XXX --time XXX -- bam_pipeline run --jre-option "-XmxXXXg" --max-threads XXX --bwa-max-threads XXX --adapterremoval-max-threads XXX --destination ~/data/Pigeons/Analysis/PaleoMix_GBS_BEFORE-FILTEREDCHIMERAS/ ~/data/Pigeons/Analysis/FPGP--Final_PaleoMix_GBS_BEFORE-FILTEREDCHIMERAS_S.risoria.yaml
```

##### Generates an ID file for each sample contained the reads that should be excluded. Those are reads having a second or more cut-site and that were mapped to two or more different regions:

```
parallel --plus --keep-order --dryrun "samtools view {} | grep -v '^#' | awk '\$6~/[HS]/ && \$10~/ATGCAT/{print \$1}' | sort -u > $TMP_DIR/{/...}.Chimeras.id" ::: ~/data/Pigeons/Analysis/PaleoMix_GBS_BEFORE-FILTEREDCHIMERAS/*.bam | xsbatch -R --max-array-jobs XXX -c 1 --time XXX --
```

##### Excludes these identified reads using the software package [QIIME--v1.9.1](http://qiime.org/). A filtered `.fastq` file is created inside the respectives folders of each original demultiplexed files.

```
module load blast/v2.2.26
module load qiime/v1.9.1
```

```
ls ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_*/*_Demultiplexed_GBSX--v1.3/*_!(*Undetermined).fastq.gz | parallel --plus --keep-order --dryrun "zcat {} > {.} && filter_fasta.py -f {.} -o {..}.FilteredChimeras.fastq -s $TMP_DIR/{/...}-GBS.Chimeras.id -n && gzip --best {..}.FilteredChimeras.fastq && rm {.}" | xsbatch --mem-per-cpu XXX -R --max-array-jobs XXX -c 1 --time XXX --
```

```
parallel --plus --keep-order --dryrun "zcat {} > {.} && filter_fasta.py -f {.} -o {..}.FilteredChimeras.fastq -s $TMP_DIR/{/...}-GBS.Chimeras.id -n && gzip --best {..}.FilteredChimeras.fastq && rm {.}" | xsbatch --mem-per-cpu XXX -R --max-array-jobs XXX -c 1 --time XXX --
```
***

### 5) Read Trimming & Mapping

> We trim and map all samples using [PaleoMix--v1.2.5](https://github.com/MikkelSchubert/paleomix) on the same `.yaml` file used above, the only different being that now we used the filtered `.fastq` files.
#

```
xsbatch -c XXX --mem-per-cpu XXX -J XXX --time XXX -- bam_pipeline dryrun --jre-option "-XmxXXXg" --max-threads XXX --bwa-max-threads XXX --adapterremoval-max-threads XXX --destination ~/data/Pigeons/Analysis/PaleoMix_GBS/ ~/data/Pigeons/Analysis/FPGP--Final_PaleoMix_GBS.yaml
```
***

### 6) Running Stats & Filtering of Bad Samples

> We used the outputs from [PaleoMix--v1.2.5](https://github.com/MikkelSchubert/paleomix) to create a summary file cointaing information on the mapping statistics of each sample. In addition, we used some scripts to perform several create some heatmap plots to help in the identification of bad SAMPLES.
#

##### Runs [`paleomix_summary2tsv.sh`](./FPG--Scripts/paleomix_summary2tsv.sh) to create a summary file with mapping information, and absence/presence `.tsv` files:

```
xsbatch -c 1 --mem-per-cpu 12000 -J FPG_CovHeatMap --time 10:00:00 -- "/groups/hologenomics/fgvieira/scripts/paleomix_summary2tsv.sh -t 1 --samples ~/data/Pigeons/FPGP/FPGP--Analyses/FPG--Lists/FPGP--AllSamples--Article--Ultra.list --heatmap Loci_Merged ~/data/Pigeons/Analysis/PaleoMix_GBS/ > ~/data/Pigeons/FPGP/FPG--Analyses/FPG--CoverageHeatMap/FPG--MappingStats.txt"
```

##### Runs [`kmeans.py`](./FPG--Scripts/kmeans.py) on the `.tsv` files created above to calculate clusters of LOCI.

```
xsbatch -c 10 --mem-per-cpu 20000 -J FPG_CovHeatMap --time 15:00:00 -- "python /lustre/hpc/hologenomics/fgvieira/scripts/kmeans.py -i ~/data/Pigeons/FPGP/FPG--Analyses/FPG--CoverageHeatMap/Loci_Merged.coverage.tsv -c 10 -k 300 -n 10 -t -d float16 -o FPG--Loci_Merged.coverage"
```

##### Gets the weights of each cluster:

```
tail -n +2 ~/data/Pigeons/FPGP/FPG--Analyses/FPG--CoverageHeatMap/FPG--Loci_Merged.coverage.km_clusters.tsv | cut -f 2 | sort -g | uniq -c | awk '{print sqrt($1)}' | tr "\n" "," | sed 's/,$/\n/' > ~/data/Pigeons/FPGP/FPG--Analyses/FPG--CoverageHeatMap/FPG--Loci_Merged.coverage.km_weights.txt
```

##### These results were plotted using the Rscript below:

[`FPG--CoverageHeatmap.R`](../FPG--Plots/FPG--Stats/FPG--CoverageHeatMap/FPG--CoverageHeatMap.R)

##### List containing SAMPLES to be excluded. Please notice that the 10 BAD GBS SAMPLES and 6 BLANKS are highlighted in the Coverage HeatMap:

```
~/data/Pigeons/FPGP/FPG--Analyses/FPG--Lists/FPGP--BadSamples--Article--Ultra.list (10 GBS SAMPLES / 6 BLANKS)
```

##### Gets the number of potential _GBS_ SITES that were not covered:

```
grep -v "WGS" ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--CoverageHeatMap/Loci_Merged.coverage.tsv | grep -v "Blank" | tail -n +2 | cut -f 2- | awk '{for(i=1; i<=NF; i++)x[i]+=$i} END{for(i in x)print x[i]}' > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--CoverageHeatMap/Loci_Merged.coverage.cutsitesmath

awk '$1==0{cnt++} END{print cnt}' ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--CoverageHeatMap/Loci_Merged.coverage.cutsitesmath
```

##### _Number of LOCI with No data for ALL_: **245,537**
***

### 7) Global Coverage Distribution

We used [ANGSD--v0.921](http://www.popgen.dk/angsd/index.php/ANGSD) to create specific datasets to be used by different downstream analyses.
#

> ALL GOOD SAMPLES with the ReSeq Ferals (475 SAMPLES / 472 GBS & 3 WGS):

##### Gets list of samples:

```
find ~/data/Pigeons/Analysis/PaleoMix_GBS/*.bam ~/data/Pigeons/Analysis/PaleoMix_Re-Sequencing/*.bam | grep -f ~/data/Pigeons/FPGP/FPG--Analyses/FPG--Lists/FPG--AllSamples_ReSeq_Ferals-Crupestris.list | grep -v -f ~/data/Pigeons/FPGP/FPG--Analyses/FPG--Lists/FPG--BadSamples.list > ~/data/Pigeons/FPGP/FPG--Analyses/FPG--Lists/FPG--GoodSamples.list
```

##### Runs ANGSD:

```
xsbatch -c 13 --mem-per-cpu 25000 -J FPGCov --time 1-00 --force -- /groups/hologenomics/fgvieira/scripts/wrapper_angsd.sh -debug 2 -nThreads 13 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -bam ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -minInd $((475*95/100)) -doCounts 1 -dumpCounts 2 -maxDepth $((475*1000)) -out ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples.depth
```

##### Creates a `.mean` file containing the average GLOBAL DEPTH of each outputted LOCI:

```
zcat ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples.depth.pos.gz | awk 'NR>1 {print $1"\t"$2-1"\t"$2"\t"$3}' | bedtools intersect -a - -b ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged.bed -wb | bedtools groupby -g 8 -c 4 -o mean > ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples_IntersectedWithMerged.mean
```

##### This `.mean` file was plotted using the RScript below, and based on this distribution we deliberated on a maximum GLOBAL DEPTH cutoff:

[`FPG--CoverageDistribution.R`](../FPG--Plots/FPG--Stats/FPG--CoverageDistribution/FPG--CoverageDistribution.R)
***

### 8) Creation of Specific Datasets

> We used [ANGSD--v0.935](http://www.popgen.dk/angsd/index.php/ANGSD) to create specific datasets to be used by different downstream analyses.
#

#### 8.1) ALL GOOD SAMPLES with the ReSeq Ferals (475 SAMPLES / 472 GBS & 3 WGS)

> [`Dataset I`](./FPG--Datasets/FPG--Dataset_I/)

##### Runs ANGSD (List of samples as in 7):

```
xsbatch -c 10 --mem-per-cpu 12000 -J FPG_AllSites --time 1-00 --force -- /groups/hologenomics/fgvieira/scripts/wrapper_angsd.sh -debug 2 -nThreads 10 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -bam ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -minInd $((475*95/100)) -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 1 -doMaf 1 -doPost 2 -doGeno 3 -doPlink 2 -geno_minDepth 3 -setMaxDepth $((475*150)) -dumpCounts 2 -postCutoff 0.95 -doHaploCall 1 -out ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples
```

##### _Number of SITES_: 1,225,206

##### Gets Real Coverage (_Genotype Likelihoods_):

```
zcat ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples.counts.gz | tail -n +2 | gawk ' {for (i=1;i<=NF;i++){a[i]+=$i;++count[i]}} END{ for(i=1;i<=NF;i++){print a[i]/count[i]}}' | paste ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples.labels - > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/RealCoverage/FPG--GoodSamples.GL-RealCoverage.txt
```

##### Gets Missing Data (_Genotype Likelihoods_):

```
zcat ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples.beagle.gz | tail -n +2 | perl /groups/hologenomics/fgvieira/scripts/call_geno.pl --skip 3 | cut -f 4- | awk '{ for(i=1;i<=NF; i++){ if($i==-1)x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples.labels - | awk '{print $1"\t"$3"\t"$3*100/1225206}' > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/MissingDataCalc/FPG--GoodSamples.GL-MissingData.txt
```
#

#### 8.2) ALL GOOD SAMPLES with the ReSeq Ferals-Crupestris & without Srisoria-Cpalumbus (469 SAMPLES / 466 GBS & 3 WGS)

> [`Dataset II`](./FPG--Datasets/FPG--Dataset_II/)

##### Gets list of samples:

```
find ~/data/Pigeons/Analysis/PaleoMix_GBS/*.bam ~/data/Pigeons/Analysis/PaleoMix_Re-Sequencing/*.bam | grep -f ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--AllSamples_ReSeq_Ferals-Crupestris.list | grep -v -f ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--BadSamples_NoSrisoriaNoCpalumbus.list > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples_NoSrisoriaNoCpalumbus.list
```

##### Creates the auxiliary `.annot` file:

```
cat ~/data/Pigeons/FPGP/FPG--Analyses/FPG--Lists/FPG--GoodSamples_NoSrisoriaNoCpalumbus.labels | awk '{split($0,a,"_"); print $1"\t"a[1]}' > ~/data/Pigeons/FPGP/FPG--Analyses/FPG--Phylogenies/FPG--GoodSamples_FPG--GoodSamples_NoSrisoriaNoCpalumbus.annot
```

##### Runs ANGSD:

```
xsbatch -c 10 --mem-per-cpu 12000 -J FPG_SitesII --time 18:00:00 --force -- /groups/hologenomics/fgvieira/scripts/wrapper_angsd.sh -debug 2 -nThreads 10 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -bam ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples_NoSrisoriaNoCpalumbus.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -minInd $((469*95/100)) -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 1 -doMaf 1 -doPost 2 -doGeno 3 -doPlink 2 -geno_minDepth 3 -setMaxDepth $((469*150)) -dumpCounts 2 -postCutoff 0.95 -doHaploCall 1 -out ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples_NoSrisoriaNoCpalumbus
```

##### _Number of SITES_: **1,261,878**

##### Gets Real Coverage (_Genotype Likelihoods_):

```
zcat ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples_NoSrisoriaNoCpalumbus.counts.gz | tail -n +2 | gawk ' {for (i=1;i<=NF;i++){a[i]+=$i;++count[i]}} END{ for(i=1;i<=NF;i++){print a[i]/count[i]}}' | paste ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples_NoSrisoriaNoCpalumbus.list - > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/RealCoverage/FPG--GoodSamples_NoSrisoriaNoCpalumbus.GL-RealCoverage.txt
```

##### Gets Missing Data (_Genotype Likelihoods_):

```
zcat ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples_NoSrisoriaNoCpalumbus.beagle.gz | tail -n +2 | perl /groups/hologenomics/fgvieira/scripts/call_geno.pl --skip 3 | cut -f 4- | awk '{ for(i=1;i<=NF; i++){ if($i==-1)x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples_NoSrisoriaNoCpalumbus.list - | awk '{print $1"\t"$3"\t"$3*100/1261878}' > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/RealCoverage/FPG--GoodSamples_NoSrisoriaNoCpalumbus.GL-MissingData.txt
```

##### Gets Missing Data (_Random Haplotype Calling_):

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.haplo.gz | cut -f 4- | tail -n +2 | awk '{ for(i=1;i<=NF; i++){ if($i=="N")x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.labels - | awk '{print $1"\t"$3"\t"$3*100/1261881}' > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/MissingDataCalc/FPG--GoodSamples_NoSrisoriaNoCpalumbus.RHC-MissingData.txt
```
#

#### 8.3) ALL GOOD SAMPLES with the ReSeq Ferals & without Crupestris-Cpalumbus-Srisoria-Duplicates (465 SAMPLES / 463 GBS & 2 WGS)

> [`Dataset III`](./FPG--Datasets/FPG--Dataset_III/)

##### Gets list of samples:

```
find ~/data/Pigeons/Analysis/PaleoMix_GBS/*.bam ~/data/Pigeons/Analysis/PaleoMix_Re-Sequencing/*.bam | grep -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--AllSamples_ReSeq_Ferals-Crupestris--Article--Ultra.list | grep -v -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--BadSamples_NoSrisoriaNoCpalumbus--Article--Ultra.list | grep -v -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--BadSamples_NoCrupestrisNoDuplicates--Article--Ultra.list > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.list
```

##### Runs ANGSD:

```
xsbatch -c 10 --mem-per-cpu 20000 -J FPG_SNPs --time 3-00:00:00 --force -- /groups/hologenomics/fgvieira/scripts/wrapper_angsd.sh -debug 2 -nThreads 10 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -bam ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -minInd $((465*95/100)) -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 1 -doMaf 1 -MinMaf 0.004 -SNP_pval 1e-6 -doPost 2 -doGeno 3 -doPlink 2 -geno_minDepth 3 -setMaxDepth $((465*150)) -dumpCounts 2 -postCutoff 0.95 -doHaploCall 1 -out ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates
```

##### _Number of SNPs_: **22,434**

##### Gets Real Coverage (_Genotype Likelihoods_):

```
zcat ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.counts.gz | tail -n +2 | gawk ' {for (i=1;i<=NF;i++){a[i]+=$i;++count[i]}} END{ for(i=1;i<=NF;i++){print a[i]/count[i]}}' | paste ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.labels - > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/RealCoverage/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.GL-RealCoverage.txt
```

##### Gets Missing Data (_Genotype Likelihoods_):

```
zcat ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.beagle.gz | tail -n +2 | perl /groups/hologenomics/fgvieira/scripts/call_geno.pl --skip 3 | cut -f 4- | awk '{ for(i=1;i<=NF; i++){ if($i==-1)x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.labels - | awk '{print $1"\t"$3"\t"$3*100/22434}' > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/RealCoverage/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.GL-MissingData.txt
```
#

#### 8.4) ALL GOOD SAMPLES with the ReSeq Ferals-Crupestris & without Cpalumbus-Srisoria-Duplicates-Captives (458 SAMPLES / 463 GBS & 3 WGS)

> [`Dataset IV`](./FPG--Datasets/FPG--Dataset_IV/)

##### Gets list of samples:

```
find ~/data/Pigeons/Analysis/PaleoMix_GBS/*.bam ~/data/Pigeons/Analysis/PaleoMix_Re-Sequencing/*.bam | grep -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--AllSamples_ReSeq_Ferals-Crupestris-WGS--Article--Ultra.list | grep -v -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--BadSamples_NoSrisoriaNoCpalumbus--Article--Ultra.list | grep -v -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--BadSamples_NoDuplicatesNoCaptives--Article--Ultra.list > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.list
```

##### Runs ANGSD:

```
xsbatch -c 64 --mem-per-cpu 7800 -J FPGP_SNPs --time 12:00:00 --force -- /groups/hologenomics/fgvieira/scripts/wrapper_angsd.sh -debug 2 -nThreads 64 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -bam ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800--Article--Ultra.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -minInd $((458*95/100)) -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 1 -doMaf 1 -MinMaf 0.005 -SNP_pval 1e-6 -doPost 2 -doGeno 3 -doPlink 2 -geno_minDepth 3 -setMaxDepth $((458*150)) -dumpCounts 2 -postCutoff 0.95 -doHaploCall 1 -doVcf 1 -out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra
```

##### _Number of SNPs_: **20,705**

##### Gets Real Coverage:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.counts.gz | tail -n +2 | gawk ' {for (i=1;i<=NF;i++){a[i]+=$i;++count[i]}} END{ for(i=1;i<=NF;i++){print a[i]/count[i]}}' | paste ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.labels - > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/RealCoverage/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.GL-RealCoverage.txt
```

##### Gets Missing Data:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.beagle.gz | tail -n +2 | perl /groups/hologenomics/fgvieira/scripts/call_geno.pl --skip 3 | cut -f 4- | awk '{ for(i=1;i<=NF; i++){ if($i==-1)x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.labels - | awk '{print $1"\t"$3"\t"$3*100/20659}' > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/MissingDataCalc/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.GL-Missing.txt
```
***

### 10) Sites Info

> Based on [`Dataset I`](./FPG--Datasets/FPG--Dataset_I/), we calculate some overall statistics.

##### Here we calculate the number of scaffolds with at least one SITE reported:

```
zcat ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples.mafs.gz | tail -n +2 | sort -u -k 1,1 | wc -l
```

> _FPG--GoodSamples_: **302 scaffolds**

##### Calculates the SITES density using ordinary scripts based on the `.mafs` generated above:

```
zcat ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples.mafs.gz | tail -n +2 | cut -f1 | sort | uniq -c | awk '{print $2"\t"$1}' | sort -n -k 2,2 > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/SitesInfo/FPG--GoodSamples.SitesDensity.txt
```

##### Expands the result above:

```
awk 'BEGIN{OFS="\t"} NR==FNR{x[$1]=$2} NR!=FNR && $2>1000{if(!x[$1])x[$1]=0; print $1,$2,x[$1]}' ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/SitesInfo/FPG--GoodSamples.SitesDensity.txt ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta.fai | sort -n -k 2,2 > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/SitesInfo/FPG--GoodSamples.ScaffoldInfo.txt
```

##### Restricts to only those LOCI with SITES:

```
awk '{if ($3!=0) print;}' ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/SitesInfo/FPG--GoodSamples.ScaffoldInfo.txt > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/SitesInfo/FPG--GoodSamples.ScaffoldInfo_OnlyWithSites.txt
```

##### These results were plotted using the Rscript below:

[`FPG--ScaffoldLengthVsNumberOfSites.R`](../FPG--Plots/FPG--Stats/FPG--SitesInfo/FPG--ScaffoldLengthVsNumberOfSites.R.R)
***

### 11) Heterozygosity Calculation

> Based on [`Dataset II`](./FPG--Datasets/FPG--Dataset_II/) and using [ANGSD--v0.931](http://www.popgen.dk/angsd/index.php/ANGSD), we calculate the percentage of heterozygous genotypes of each sample.

##### Generates a `.bed` file based on the `.mafs` file:

```
zcat ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples_NoSrisoriaNoCpalumbus.mafs.gz | cut -f1,2 | tail -n +2 | awk '{print $1"\t"$2-1"\t"$2}' | bedtools merge -i - > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/HeterozygosityCalc/FPG--GoodSamples_NoSrisoriaNoCpalumbus.bed
```

##### Creates a position file based on this new `.bed` and index it accordingly:

```
awk '{print $1"\t"($2+1)"\t"$3}' ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/HeterozygosityCalc/FPG--GoodSamples_NoSrisoriaNoCpalumbus.bed > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/HeterozygosityCalc/FPG--GoodSamples_NoSrisoriaNoCpalumbus.pos
angsd sites index ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/HeterozygosityCalc/FPG--GoodSamples_NoSrisoriaNoCpalumbus.pos
```

##### Gets files:

```
parallel --plus --dryrun angsd -i {} -anc ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -sites ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/HeterozygosityCalc/FPG--GoodSamples.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -GL 1 -doSaf 1 -fold 1 -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -out ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/HeterozygosityCalc/Article2021/{/...} :::: ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples.list | xsbatch -R --max-array-jobs 120 -c 1 --time 1-12 --mem-per-cpu 10000 -J HetCalc --
```

##### Gets fractions:

```
parallel --plus "realSFS {} > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/HeterozygosityCalc/Article2021/{/..}.het" ::: ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/HeterozygosityCalc/Article2021/*.saf.idx
```

##### Calculates the percentage of heterozygous SITES:

```
fgrep '.' *.het | tr ":" " " | awk '{print $1"\t"$3/($2+$3)*100}' | gawk '{match($1,/(GBS|WGS|WGS\-GBS)/,lol);print $1"\t"$2"\t"lol[1]}' | sort -k 1,1gr | awk '{split($0,a,"_"); print $1"\t"a[1]"\t"$2"\t"$3'} > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Miscellaneous/HeterozygosityCalc/Article2021/FPG--GoodSamples.Heterozygosity.txt
```

##### These results were plotted using the Rscript below:

[`FPG--PopGenEstimates.R`](../FPG--Plots/FPG--PopGenEstimates/FPG--PopGenEstimates.R)
***

### 12) Initial Phylogenetic Recinstruction

> Based on [`Dataset I`](./FPG--Datasets/FPG--Dataset_I/) and through the use of [ngsDist--v1.0.6](https://github.com/fgvieira/ngsDist) + [FASTme--v2.1.5](http://www.atgc-montpellier.fr/fastme/), we reconstruct the initial phylogenetic relationships to confirm the outgroups' placements.

##### Generates matrix of genetic distances:

```
xsbatch -c 15 --mem-per-cpu 2000 -J DistDataI --time 23:00:00 -- "ngsDist --n_threads 15 --geno ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples.beagle.gz --pairwise_del --seed 33 --probs --n_ind 475 --n_sites 1225206 --labels ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples.labels --out ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/NJ/FPG--GoodSamples.dist"
```

##### Twicks a bit the matrix of distances created above:

```
perl -p -e 's/\t/ /g' ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/NJ/FPG--GoodSamples.dist > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/NJ/FPG--GoodSamples_Twicked.dist
```

##### Generates the NJ phylogeny:

```
fastme -T 15 -i ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/NJ/FPG--GoodSamples_Twicked.dist -o ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/NJ/FPG--GoodSamples.nwk
```

##### These results were plotted using the Rscript below:

[`FPG--PhyloDataset_I.R`](../FPG--Plots/FPG--Phylogenies/FPG--PhyloDataset_I.R)
***

### 13) Exhaustive Phylogenetic Reconstruction

> Based on [`Dataset II`](./FPG--Datasets/FPG--Dataset_II/) and through the use of [ngsDist--v1.0.6](https://github.com/fgvieira/ngsDist), [FASTme--v2.1.5](http://www.atgc-montpellier.fr/fastme/) + [RAxML-NG--v0.5.1b](https://github.com/amkozlov/raxml-ng), we reconstruct the phylogenetic relationships.

##### Generates matrix of genetic distances:

```
xsbatch -c 12 --mem-per-cpu 3000 -J Dist_Corr --time 18:00:00 -- "ngsDist --n_threads 12 --geno ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples_NoSrisoriaNoCpalumbus.beagle.gz --pairwise_del --seed 44 --probs --n_ind 469 --n_sites 1261878 --labels ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples_NoSrisoriaNoCpalumbus.labels --out ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/NJ/FPG--GoodSamples_NoSrisoriaNoCpalumbus.dist"
```

##### Twicks a bit the matrix of distances created above:

```
perl -p -e 's/\t/ /g' ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/NJ/FPG--GoodSamples_NoSrisoriaNoCpalumbus.dist > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/NJ/FPG--GoodSamples_NoSrisoriaNoCpalumbus_Twicked.dist
```

##### Generates a NJ phylogeny:

```
fastme -T 15 -i ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/NJ/FPG--GoodSamples_NoSrisoriaNoCpalumbus_Twicked.dist -o ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/NJ/FPG--GoodSamples_NoSrisoriaNoCpalumbus.nwk
```

##### Converts the `.haplo` file into a `.fasta` file:

```
xsbatch -c 1 --mem-per-cpu 38000 -J FASTA --time 23:30:00 -- "zcat ~/data/Pigeons/FPG/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples_NoSrisoriaNoCpalumbus.haplo.gz | cut -f 4- | tail -n +2 | perl /groups/hologenomics/fgvieira/scripts/tsv_merge.pl --transp --ofs '' - | awk 'NR==FNR{id=$1; sub(".*\\/","",id); sub("\\..*","",id); x[FNR]=id} NR!=FNR{ print ">"x[FNR]"\n"$1}' ~/data/Pigeons/FPG/FPG--Analyses/FPG--Lists/FPG--GoodSamples_NoSrisoriaNoCpalumbus.labels - > ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/ML/FPG--GoodSamples_NoSrisoriaNoCpalumbus.fasta"
```

##### Generates a ML phylogeny based on the `.fasta` file created above having the NJ phylogeny as a backbone:

```
raxml-ng --threads 15 --search --model GTR+G --site-repeats on --msa ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/ML/FPG--GoodSamples_NoSrisoriaNoCpalumbus.fasta --tree ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/NJ/FPG--GoodSamples_NoSrisoriaNoCpalumbus.nwk --prefix ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/ML/FPG--GoodSamples_NoSrisoriaNoCpalumbus.ngsDist
```

##### Bootstraps this generated ML phylogeny:

```
raxml-ng --threads 20 --bootstrap --model GTR+G --bs-trees 100 --site-repeats on --msa ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/ML/FPG--GoodSamples_NoSrisoriaNoCpalumbus.fasta --tree ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/ML/FPG--GoodSamples_NoSrisoriaNoCpalumbus.ngsDist.raxml.bestTree --prefix ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/ML/FPG--GoodSamples_NoSrisoriaNoCpalumbus.ngsDist.BSs
```

##### Adds the bootstrap values to the generated ML phylogeny:

```
raxml-ng --threads 15 --support --tree ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/ML/FPG--GoodSamples_NoSrisoriaNoCpalumbus.ngsDist.raxml.bestTree --bs-trees ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/ML/FPG--GoodSamples_NoSrisoriaNoCpalumbus.ngsDist.BSs.tree --prefix ~/data/Pigeons/FPG/FPG--Analyses/FPG--Phylogenies/ML/FPG--GoodSamples_NoSrisoriaNoCpalumbus.ngsDist.FINAL
```
***

### 14) Population Genetics Statistics

> We used [ANGSD--v0.935](http://www.popgen.dk/angsd/index.php/ANGSD) to calculate several population genetics statistics.

##### Creates ancestral sequence:

```
xsbatch -c 12 --mem-per-cpu 2048 -J PBGP_AllSites --time 5-00 --force -- angsd -nThreads 12 -i ~/data/Pigeons/Analysis/PaleoMix_Re-Sequencing/Crupestris_01-WGS.RockDove_DoveTail_ReRun.realigned.bam -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -doFasta 1 -doCounts 1 -explode 1 -rmTrans 0 -seed 433 -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -out ~/data/Pigeons/PBGP/PBGP--Analyses/PBGP--PopGenStats/Crupestris_01-WGS.RockDove_DoveTail_ReRun.realigned.Ancestral
```

##### Gets lists of samples:

```
POP=("Abadeh" "Barcelona" "Berlin" "Colombo" "Copenhagen" "Crete" "Denver" "Guimaraes" "Isfahan" "Johannesburg" "Lahijan" "Lisbon" "London" "MexicoCity" "Monterrey" "Nairobi" "Nowshahr" "Perth" "PigeonIsland" "Prague" "SaltLakeCity" "Salvador" "SanCristobalDeLasCasas" "Santiago" "Sardinia" "Tatui" "Tehran" "TelAviv" "TelAvivColony" "TlaxcalaDeXicohtencatl" "Torshavn" "Trincomalee" "Vernelle" "WadiHidan")

for query in ${POP[*]}
do 
    grep ${query} ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoria--Article--Ultra.list > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoria_${query}-DoSaf--Article--Ultra.list
    
done
```

##### Runs ANGSD under `-doSaf`:

```
for query in Torshavn

do
        N_IND=`cat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf--Article--Ultra.list | wc -l`

        echo /groups/hologenomics/fgvieira/scripts/wrapper_angsd.sh -debug 2 -nThreads 19 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -anc ~/data/Pigeons/PBGP/PBGP--Analyses/PBGP--PopGenStats/Crupestris_01-WGS.RockDove_DoveTail_ReRun.realigned.Ancestral.fa.gz -bam ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf--Article--Ultra.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800--Article--Ultra.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 1 -doMaf 1 -doPost 2 -doSaf 1 -postCutoff 0.95 -doGeno 3 -doPlink 2 -geno_minDepth 3 -dumpCounts 2 -doHaploCall 1 -doVcf 1 -minInd $((N_IND*95/100)) -setMaxDepth $((N_IND*150)) -out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper--Article--Ultra
done | xsbatch -c 19 --mem-per-cpu 1024 -J AllSafs -R --max-array-jobs 60 --time 1-00 --
```

##### To run realSFS:

```
for query in Torshavn

do
    realSFS -P 10 ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper--Article--Ultra.saf.idx > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper--Article--Ultra.sfs
    
done
```

##### Runs ANGSD under `-doThetas`:

```
for query in Torshavn

do
        N_IND=`cat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf--Article--Ultra.list | wc -l`

echo angsd -nThreads 2 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -bam ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf--Article--Ultra.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800--Article--Ultra.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -pest ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper--Article--Ultra.sfs -anc ~/data/Pigeons/PBGP/PBGP--Analyses/PBGP--PopGenStats/Crupestris_01-WGS.RockDove_DoveTail_ReRun.realigned.Ancestral.fa.gz -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -postCutoff 0.95 -doGlf 2 -doGeno 3 -geno_minDepth 3 -doPost 2 -doThetas 1 -doSaf 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -GL 1 -minInd $((N_IND*95/100)) -setMaxDepth $((N_IND*150)) -out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper-DoThetas-NoWrapper--Article--Ultra
done | xsbatch -c 2 --mem-per-cpu 1024 -J AllThetas -R --max-array-jobs 60 --time 5-00 --
```

##### Gets summary of Thetas:

```
for query in Abadeh Barcelona Berlin Colombo Copenhagen Crete Denver Guimaraes Isfahan Johannesburg Lahijan Lisbon London MexicoCity Monterrey Nairobi Nowshahr Perth PigeonIsland Prague SaltLakeCity Salvador SanCristobalDeLasCasas Santiago Sardinia Tatui Tehran TelAviv TelAvivColony TlaxcalaDeXicohtencatl Torshavn Trincomalee Vernelle WadiHidan

do
    N_IND=`cat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf--Article--Ultra.list | wc -l`

    thetaStat print ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper-DoThetas-NoWrapper--Article--Ultra.thetas.idx > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper-DoThetas-NoWrapper--Article--Ultra.thetas.Print
done
```

##### Performs final calculations:

```
for query in Abadeh Barcelona Berlin Colombo Copenhagen Crete Denver Guimaraes Isfahan Johannesburg Lahijan Lisbon London MexicoCity Monterrey Nairobi Nowshahr Perth PigeonIsland Prague SaltLakeCity Salvador SanCristobalDeLasCasas Santiago Sardinia Tatui Tehran TelAviv TelAvivColony TlaxcalaDeXicohtencatl Torshavn Trincomalee Vernelle WadiHidan
do

    Rscript --vanilla --slave ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--ToGetThetaSummaryFile.R ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper-DoThetas-NoWrapper--Article--Ultra.thetas.Print $N_IND $query
done > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus-DoSaf-WithWrapper-DoThetas-NoWrapper--Article--Ultra.PopGenSummary.txt
```

##### These results were plotted using the Rscript below:

[`FPG--PopGenEstimates.R`](../FPG--Plots/FPG--PopGenEstimates/FPG--PopGenEstimates.R)

### Fst

```
for i1 in `seq 0 $((${#POP[@]}-2))`
do
    for i2 in `seq $((i1+1)) $((${#POP[@]}-1))`
    do
        pop1="FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${POP[i1]}-DoSaf-WithWrapper--Article--Ultra"
        pop2="FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${POP[i2]}-DoSaf-WithWrapper--Article--Ultra"
        N_SITES=`realSFS print $pop1.saf.idx $pop2.saf.idx | wc -l`
        echo -ne "${POP[i1]}\t${POP[i2]}\t$N_SITES\t"
        if [[ $N_SITES == 0 ]]; then
            echo "NA"
        else
            realSFS $pop1.saf.idx $pop2.saf.idx > /tmp/${POP[i1]}.${POP[i2]}.ml
            realSFS fst index $pop1.saf.idx $pop2.saf.idx -sfs /tmp/${POP[i1]}.${POP[i2]}.ml -fstout /tmp/${POP[i1]}.${POP[i2]}
            realSFS fst stats /tmp/${POP[i1]}.${POP[i2]}.fst.idx
        fi
    done
done > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--Fst.tsv
```
[`FPG--Fst.R`](../FPG--Plots/FPG--Fst/FPG--Fst.R)
***

### 15) Multidimensional Scaling

> Based on [`Dataset III`](./FPG--Datasets/FPG--Dataset_III/), we perform a _Multidimensional Scaling Anlysis_.

##### Creates a distance matrix using the `.beagle` file using [`ngsDist`](https://github.com/fgvieira/ngsDist):

```
xsbatch -c 10 --mem-per-cpu 2000 -J Dist_Corr --time 1-00 -- "ngsDist --n_threads 10 --geno ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.beagle.gz --pairwise_del --seed 44 --probs --n_ind 465 --n_sites 22434 --labels ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.labels --out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--MDS/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.dist"
```

##### Performs MDS using [`get_PCA.R`](./FPG--Scripts/get_PCA.R):

```
tail -n +3 ~/data/Pigeons/FPGP/FPGP--Analyses/FPG--MDS/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.dist | Rscript --vanilla --slave /groups/hologenomics/fgvieira/scripts/get_PCA.R --no_header --data_symm -n 10 -m "mds" -o ~/data/Pigeons/FPGP/FPGP--Analyses/FPG--MDS/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.mds
```

##### Creates the auxiliary `.annot` file:

```
cat ~/data/Pigeons/FPGP/FPGP--Analyses/FPG--Lists/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.labels | awk '{split($0,a,"_"); print $1"\t"a[1]}' > ~/data/Pigeons/FPGP/FPGP--Analyses/FPG--MDS/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.annot
```

##### These MDS results were plotted using the Rscript below:

[`FPG--MDS.R`](../FPG--Plots/FPG--MDS/FPG--MDS.R)
***

### 16) Estimation of Individual Ancestries

> Based on [`Dataset III`](./FPG--Datasets/FPG--Dataset_III/), we perform an _Analysis of Estimation of Individual Ancestries_.

##### Runs [ngsAdmix--v32](http://www.popgen.dk/software/index.php/NgsAdmix) on the `.beagle` file using the [`wrapper_ngsAdmix`](./FPG--Scripts/wrapper_ngsAdmix.sh):

```
export N_REP=100

for K in `seq -w 2 20`
do 
    echo /groups/hologenomics/fgvieira/scripts/wrapper_ngsAdmix.sh -P 34 -debug 1 -likes ~/data/Pigeons/FPGP/FPG--Analyses/FPG--ANGSDRuns/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.beagle.gz -K $K -minMaf 0 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o ~/data/Pigeons/FPGP/FPG--Analyses/FPG--ngsAdmix/FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.${K}

done | xsbatch -c 34 --mem-per-cpu 1024 --max-array-jobs 20 -J ngsAdmix -R --time 3-00 --
```

##### These ngsAdmix results were plotted using the Rscript below (`.annot` file as in 14):

[`FPG--ngsAdmix.R`](../FPG--Plots/FPG--ngsAdmix/FPG--ngsAdmix.R)
***
***
***











### Estimating Spacial Population Structure | [TESS3--v1.1.0]()

We locally plot these ngsAdmix results using the Rscript below:

_FPGP--ToPlotAncestryMap.R_

### Estimation of Supervised Individual Ancestries | ngsAdmix--Filipe

### Variant Calling | ANGSD--v0.921

### To get specific BAM list -- ALL GOOD SAMPLES with the ReSeq Ferals without Crupestris-Cpalumbus-Srisoria & Duplicated SAMPLES /// (465 SAMPLES / 463 GBS & 2 WGS):

```
find ~/data/Pigeons/Analysis/PaleoMix_GBS/*.bam ~/data/Pigeons/Analysis/PaleoMix_Re-Sequencing/*.bam | grep -w -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--AllSamples_ReSeq_Ferals-Crupestris_WithHomers--Article--Ultra.list | grep -v -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--BadSamples_NoSrisoriaNoCpalumbus--Article--Ultra.list | grep -v -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--BadSamples_NoCrupestrisNoDuplicates--Article--Ultra.list > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates_WithHomers--Article--Ultra.list
```

### SNP Calling | ALL GOOD SAMPLES with the ReSeq Ferals without Crupestris-Cpalumbus-Srisoria & Duplicated SAMPLES /// (465 SAMPLES / 463 GBS & 2 WGS):

```
xsbatch -c 15 --mem-per-cpu 7800 -J FPGP_SNPs --time 2-00 --force -- /groups/hologenomics/fgvieira/scripts/wrapper_angsd.sh -debug 2 -nThreads 15 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -bam ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates_WithHomers--Article--Ultra.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800--Article--Ultra.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -minInd $((476*95/100)) -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 1 -doMaf 1 -MinMaf 0.005 -SNP_pval 1e-6 -doPost 2 -doGeno 3 -doPlink 2 -geno_minDepth 3 -setMaxDepth $((476*150)) -dumpCounts 2 -postCutoff 0.95 -doHaploCall 1 -doVcf 1 -out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates_WithHomers--Article--Ultra
```

_Number of SNPs_: **20,966**

Here we perform an analyse of supervised estimation of individual ancestries based on chosen populations of breeds:

#### With the GBS-WGS pairs:

```
export N_REP=100

for K in `seq -w 2 6`
do

   echo NGSADMIX_BIN=~/data/Programs/ngsAdmix_Filipe/ngsAdmix /groups/hologenomics/fgvieira/scripts/wrapper_ngsAdmix.sh -P 45 -debug 1 -likes ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates_WithHomers--Article--Ultra.beagle.gz -pname ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Supervised_ngsAdmix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates_WithHomers--Article--Ultra.pname -K $K -minMaf 0.005 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Supervised_ngsAdmix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates_WithHomers--Article--Ultra.${K}

done | xsbatch -c 45 --mem-per-cpu 1024 --max-array-jobs 20 -J ngsAdmix -R --time 1-00 --
```

We locally plot these Supervised_ngsAdmix results using the Rscript below:

_FPGP--ToPlot_Supervised_ngsAdmixResults.R_

```
cat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates_WithFixedBreeds--Article--Ultra.labels | awk '{split($0,a,"_"); print $1"\t"a[1]}' > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Supervised_ngsAdmix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates_WithFixedBreeds--Article--Ultra.annot
```

## Inference of Poulation Splits | [TreeMix--v1.13](https://bitbucket.org/nygcresearch/treemix/wiki/Home)

### Firstly, we create an TreeMiX `.annot` file:

```
cat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.labels | awk '{split($0,a,"_"); print $1"\t"a[1]}' > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--TreeMix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.annot
```

### Then, we create convert the _.GENO_ file into a .TREEMIX format:

```
perl /groups/hologenomics/fgvieira/scripts/geno2treemix.pl --geno ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.geno.gz --format angsd --skip_cols 4 --pop ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--TreeMix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.annot | gzip --best > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--TreeMix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.treemix.gz
```

### Here we run TreeMix:

```
for M in `seq 0 15`
do 
    echo /groups/hologenomics/fgvieira/scripts/wrapper_treemix.sh -i ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--TreeMix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.treemix.gz -k 100 -t 10 -noss -m $M -root Crupestris -global -o ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--TreeMix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.treemix.${M}

done | xsbatch -c 10 --mem-per-cpu 1024 -J TreeMix -R --max-array-jobs 13 --time 10-00 --
```

#### Here we generate a `.poporder` file:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--TreeMix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.treemix.gz | head -n 1 | perl -p -e 's/ /\n/g' > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--TreeMix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.treemix.poporder
```

#### Here we finally plot the results:

```
ls -Sv ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--TreeMix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.treemix.12.llik | perl -p -e 's/\.llik//g' | Rscript --vanilla --slave -e "source('/groups/hologenomics/software/treemix/v1.13/src/plotting_funcs.R'); h=18; w=h*2; x<-read.table('stdin')[,1]; pdf(height=h,width=w); layout(matrix(c(1,2),ncol=2),c(w/2,w/2),c(h)); for(i in x){plot_tree(i);plot_resid(i,'~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--TreeMix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.treemix.poporder')}; dev.off()"; mv Rplots.pdf  ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--TreeMix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.treemix.12.pdf
```

### Estimating E1fective Migration Surfaces | EEMS--v20180406

### To run the analyses:

```
cut -f 2- ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--MDS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.dist > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--EEMS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.diffs
```

```
runeems_snps --params ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--EEMS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra_Europe.ini --seed 321
```

### We locally plot these ngsAdmix results using the Rscript below:

FPGP--ToPlotEEMSResutls.R

### GWAS | GEMMA-v0.96

#### To create a DOSAGE file:

```
python ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/FPGP.dosage.py
```

#### To compute the relatedness matrix:

```
chmod a+x gemma-0.98.1-linux-static
./gemma-0.98.1-linux-static -debug -g ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.dosage -gk 1 -p ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral.pheno -o FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral -maf 0.01
```

#### Create SNPAnnotation File:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.beagle.gz | tail -n +2 | awk '{split($1,a,"_"); print $1 "\t" a[3] "\t" a[1] "_" a[2]}' > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.SNPAnnotation
```

#### Run Association Tests with Univariate Linear Mixed Models:

```
./gemma-0.98.1-linux-static -debug -lmm 4 -g ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.dosage -p ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral.pheno -a ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.SNPAnnotation -k ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/output/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral.cXX.txt -n 1 -o FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral
```

#### To slightly modify the output:

```
cut -f 1,2,3,14 ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/output/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral.assoc.txt | awk '{print $2"\t"$1"\t"$3"\t"$4}' | tail -n +2 | sort -k 4,4 > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/output/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral.Edited.assoc.txt
```

#### Permutation with original GEMMA (permutation using one gemma run including all chrs and scaffolds)

```
for B in `seq -w 1 100`
do

./gemma-0.98.1-linux-static -debug -g ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.dosage -k ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/output/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral.cXX.txt -a ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.SNPAnnotation -o FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral-BS_${B} -p ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral.Permuted.pheno -n ${B} -lmm 4 -maf 0.01

done
```

#### To concatenate all the p-values:

```
for i in FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral-BS_???.assoc.txt
do
    cut -f 1,2,3,14 $i > cut${i%-.assoc.}
done
```

#### To concatenate (make sure to remove the header)

```
cp cutFPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral-BS_001.assoc.txt cutFPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral-BS_ALL.assoc.txt
cat cutFPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral-BS_0{02..09}.assoc.txt | grep -v rs >> cutFPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral-BS_ALL.assoc.txt
cat cutFPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral-BS_0{10..99}.assoc.txt | grep -v rs >> cutFPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral-BS_ALL.assoc.txt
cat cutFPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral-BS_100.assoc.txt | grep -v rs >> cutFPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral-BS_ALL.assoc.txt
```

#### To get Scaffold Names:

```
cut -f 2 ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/output/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral.Edited.assoc.txt | uniq -c | awk '{print "\"" $2 "\""}' | echo $(cat -) > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--GWAS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra_Feral.ChrLabels.txt
```

#### We locally plot these GWAS results using the Rscript below:

_PBGP--ToPlot_GWAS--Ultra.R_

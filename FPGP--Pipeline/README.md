# **FPGP — _University of Copenhagen_**
### Re-Sequencing + GBS Data Pipeline — by **Filipe G. Vieira** [![Foo](./FPGP--GitHubAuxiliaryFiles/ORCIDGreenRoundIcon.png)](https://orcid.org/0000-0002-8464-7770)  &  **George Pacheco** [![Foo](./FPGP--GitHubAuxiliaryFiles/ORCIDGreenRoundIcon.png)](https://orcid.org/0000-0002-9367-6813)

**Feral Pigeon Genomics Project**: Documention outlining the entire reasoning behind this pipeline.  Please, contact **George Pacheco** (ganpa@aqua.dtu.dk) should any question arise.

### 1) Acess to Raw Data & Local Storage | [ERDA](https://www.erda.dk/)

The GBS raw data was directly downloaded from the server of the _Institute of Biotechnology_ — _University of Cornell_ using an ordinary `-wget` command, and it is now stored on ERDA KU under George's account (DQM353). The MD5SUM numbers were confirmed for all downloaded files.

### 2) Sequencing Quality Check | [FASTQc--v0.11.5](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)

A general sequencing quality check of each plate was performed using the software FastQC--v0.11.5 using default options. The results of each run is stored inside the respectives folders of each plate. We considered that all the plates passed this general sequencing quality check.

Example:
```
~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_1/FPGP_1-C2YYMACXX_3_Fastqced--v0.11.5/
```

### 3) Demultiplexing | [GBSX--v1.3](https://github.com/GenomicsCoreLeuven/GBSX)

All the plates were demultiplexed in the very same way using the software GBSX--v1.3 based on the barcode info provided by the key file of each plate. The idea was to minimally filter the reads here leaving this job to be performed by the PaleoMix run that will follow:

**FPGP_1**:
```
xsbatch -c XXX --time XXX -J XXX -- java -jar /groups/hologenomics/software/GBSX/releases/latest/GBSX_v1.3.jar --Demultiplexer -t XXX -f1 ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_1/FPGP_1-C2YYMACXX_3_fastq.gz -i ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_1/FPGP_1-C2YYMACXX_3_Barcodes.info -mb 1 -me 1 -ca false -gzip true -o ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_1/FPGP_1-C2YYMACXX_3_Demultiplexed_GBSX--v1.3/
```

**FPGP_2**:
```
xsbatch -c XXX --time XXX -J XXX -- java -jar /groups/hologenomics/software/GBSX/releases/latest/GBSX_v1.3.jar --Demultiplexer -t XXX -f1 ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_2/FPGP_2-C3KBHACXX_7_fastq.gz -i ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_2/FPGP_2-C3KBHACXX_7_Barcodes.info -mb 1 -me 1 -ca false -gzip true -o ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_2/FPGP_2-C3KBHACXX_7_Demultiplexed_GBSX--v1.3/
```

**FPGP_3**:
```
xsbatch -c XXX --time XXX -J XXX -- java -jar /groups/hologenomics/software/GBSX/releases/latest/GBSX_v1.3.jar --Demultiplexer -t XXX -f1 ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_3/FPGP_3-C5706ACXX_8_fastq.gz -i ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_3/FPGP_3-C5706ACXX_8_Barcodes.info -mb 1 -me 1 -ca false -gzip true -o ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_3/FPGP_3-C5706ACXX_8_Demultiplexed_GBSX--v1.3/
```

**FPGP_4**:
```
xsbatch -c XXX --time XXX -J XXX -- java -jar /groups/hologenomics/software/GBSX/releases/latest/GBSX_v1.3.jar --Demultiplexer -t XXX -f1 ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_4/FPGP_4-CA7YJANXX_7_fastq.gz -i ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_4/FPGP_4-CA7YJANXX_7_Barcodes.info -mb 1 -me 1 -ca false -gzip true -o ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_4/FPGP_4-CA7YJANXX_7_Demultiplexed_GBSX--v1.3/
```

**FPGP_5**:
```
xsbatch -c XXX --time XXX -J XXX -- java -jar /groups/hologenomics/software/GBSX/releases/latest/GBSX_v1.3.jar --Demultiplexer -t XXX -f1 ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_5/FPGP_5-CA7YJANXX_8_fastq.gz -i ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_5/FPGP_5-CA7YJANXX_8_Barcodes.info -mb 1 -me 1 -ca false -gzip true -o ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_5/FPGP_5-CA7YJANXX_8_Demultiplexed_GBSX--v1.3/
```

**FPGP_Extra**:
```
xsbatch -c XXX --time XXX -J XXX -- java -jar /groups/hologenomics/software/GBSX/releases/latest/GBSX_v1.3.jar --Demultiplexer -t XXX -f1 ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_Extra/FPGP_Extra-CADYEANXX_1_fastq.gz -i ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_Extra/FPGP_Extra-CADYEANXX_1_Barcodes.info -mb 1 -me 1 -ca false -gzip true -o ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_Extra/FPGP_Extra-CADYEANXX_1_Demultiplexed_GBSX--v1.3/
```

An ordinary "-mv" command was used to eliminate the ".R1" determination of each demultiplexed file.

Example:
```
mv ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_5/FPGP_5-CA7YJANXX_8_Demultiplexed_GBSX--v1.3/Wattala_01.R1.fastq.gz ~/data/Pigeons/FPGP/FPGP--GBS_Data/FPGP_5/FPGP_5-CA7YJANXX_8_Demultiplexed_GBSX--v1.3/Wattala_01.fastq.gz
```

### 4) Filtering For Chimeric Reads

We filtered our GBS reads for chimeric reads in the same way presented by [Pacheco et al. 2020](https://academic.oup.com/gbe/article/12/3/136/5735467). We used the same `.bed` file presented in this publication to restrict our analyses to the _GBS_ loci.

#### We first executed an inicial PaleoMix run with the original _GBSed_ demultiplexed files in order to be able to indetify the chemeric reads. We used the `.yaml` file below and respective command:

```
xsbatch -c XXX --mem-per-cpu XXX -J XXX --time XXX -- bam_pipeline run --jre-option "-XmxXXXg" --max-threads XXX --bwa-max-threads XXX --adapterremoval-max-threads XXX --destination ~/data/Pigeons/Analysis/PaleoMix_GBS_BEFORE-FILTEREDCHIMERAS/ ~/data/Pigeons/Analysis/FPGP--Final_PaleoMix_GBS_BEFORE-FILTEREDCHIMERAS_S.risoria.yaml
```

#### Then we generate an ID file for each sample contained the reads that should be excluded. Those are reads having a second or more cut-site and that were mapped to two or more different regions:

```
parallel --plus --keep-order --dryrun "samtools view {} | grep -v '^#' | awk '\$6~/[HS]/ && \$10~/ATGCAT/{print \$1}' | sort -u > $TMP_DIR/{/...}.Chimeras.id" ::: ~/data/Pigeons/Analysis/PaleoMix_GBS_BEFORE-FILTEREDCHIMERAS/*.bam | xsbatch -R --max-array-jobs XXX -c 1 --time XXX --
```

#### Finally, we excluded these identified reads using the software package QIIME. A filtered "fastq.gz" file is created inside the respectives folders of each original demultiplexed files.

```
module load blast/v2.2.26
module load qiime/v1.9.1

ls ~/data/Pigeons/FPBG/FPGP--GBS_Data/FPGP_*/*_Demultiplexed_GBSX--v1.3/*_!(*Undetermined).fastq.gz | parallel --plus --keep-order --dryrun "zcat {} > {.} && filter_fasta.py -f {.} -o {..}.FilteredChimeras.fastq -s $TMP_DIR/{/...}-GBS.Chimeras.id -n && gzip --best {..}.FilteredChimeras.fastq && rm {.}" | xsbatch --mem-per-cpu XXX -R --max-array-jobs XXX -c 1 --time XXX --

parallel --plus --keep-order --dryrun "zcat {} > {.} && filter_fasta.py -f {.} -o {..}.FilteredChimeras.fastq -s $TMP_DIR/{/...}-GBS.Chimeras.id -n && gzip --best {..}.FilteredChimeras.fastq && rm {.}" | xsbatch --mem-per-cpu XXX -R --max-array-jobs XXX -c 1 --time XXX --
```

### 5) Read Trimming & Mapping | [PaleoMix--v1.2.5](https://github.com/MikkelSchubert/paleomix)

#### GBSed Samples:

Basically, we run the very same _.YAML_ file used in the inicial GBSed run here, the only different was of course that now we used the filtered _.FASTQ.GZ_ files. Please notice that PCR duplicates are NOT removed here!

```
xsbatch -c XXX --mem-per-cpu XXX -J XXX --time XXX -- bam_pipeline dryrun --jre-option "-XmxXXXg" --max-threads XXX --bwa-max-threads XXX --adapterremoval-max-threads XXX --destination ~/data/Pigeons/Analysis/PaleoMix_GBS/ ~/data/Pigeons/Analysis/FPGP--Final_PaleoMix_GBS.yaml
```

### 6) Running Stats & Plots

Here we perform several statistical calculations and create HeatMap plots based on the presence/absence of data.

#### Here only considering the GBSed samples:

xsbatch -c XXX --mem-per-cpu XXX -J XXX --time XXX -- "/groups/hologenomics/fgvieira/scripts/paleomix_summary2tsv.sh -t XXX -n 10 -k 300 --samples ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--AllSamples--Article--Ultra.list --heatmap Loci_Merged ~/data/Pigeons/Analysis/PaleoMix_GBS/ > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--CoverageHeatMap/Stats_FPGP--Article--Ultra.txt"

#### Cut-sites Information

```
grep -v "WGS" ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--CoverageHeatMap/Loci_Merged.coverage.tsv | grep -v "Blank" | tail -n +2 | cut -f 2- | awk '{for(i=1; i<=NF; i++)x[i]+=$i} END{for(i in x)print x[i]}' > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--CoverageHeatMap/Loci_Merged.coverage.cutsitesmath

awk '$1==0{cnt++} END{print cnt}' ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--CoverageHeatMap/Loci_Merged.coverage.cutsitesmath
```

_Number of LOCI with No data for ALL_: **245,537**

### 7) Filtering of Bad Samples

Here we create some auxiliary files.

#### We manually create a list containing SAMPLES to be excluded. Please notice that the 10 BAD GBS SAMPLES and 6 BLANKS are highlighted in the Coverage HeatMap:

```
~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--BadSamples--Article--Ultra.list (10 GBS SAMPLES / 6 BLANKS)
```

### 8) Creation of Specific Datasets | [ANGSD--v0.921](http://www.popgen.dk/angsd/index.php/ANGSD)

#### 8.1) **Dataset I** | ALL GOOD SAMPLES with the ReSeq Ferals (475 SAMPLES / 472 GBS & 3 WGS):

##### Get List of Samples:

```
find ~/data/Pigeons/Analysis/PaleoMix_GBS/*.bam ~/data/Pigeons/Analysis/PaleoMix_Re-Sequencing/*.bam | grep -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--AllSamples_ReSeq_Ferals-Crupestris--Article--Ultra.list | grep -v -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--BadSamples--Article--Ultra.list > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples--Article--Ultra.list
```

##### ANGSD Run:

```
xsbatch -c 40 --mem-per-cpu 7000 -J FPGP_AllSites --time 10-00 --force -- /groups/hologenomics/fgvieira/scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -bam ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples--Article--Ultra.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800--Article--Ultra.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -minInd $((475*95/100)) -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 1 -doMaf 1 -doPost 2 -doGeno 3 -doPlink 2 -geno_minDepth 3 -setMaxDepth $((475*150)) -dumpCounts 2 -postCutoff 0.95 -doHaploCall 1 -doVcf 1 -out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples--Article--Ultra
```

_Number of SITES_: **1,225,204**

##### Real Coverage Calculation:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples--Article--Ultra.counts.gz | tail -n +2 | gawk ' {for (i=1;i<=NF;i++){a[i]+=$i;++count[i]}} END{ for(i=1;i<=NF;i++){print a[i]/count[i]}}' | paste ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples--Article--Ultra.labels - > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/RealCoverage/FPGP--GoodSamples--Article--Ultra.GL-RealCoverage.txt
```

#### Missing Data Calculation:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples--Article--Ultra.beagle.gz | tail -n +2 | perl /groups/hologenomics/fgvieira/scripts/call_geno.pl --skip 3 | cut -f 4- | awk '{ for(i=1;i<=NF; i++){ if($i==-1)x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples--Article--Ultra.labels - | awk '{print $1"\t"$3"\t"$3*100/1225204}' > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/MissingDataCalc/FPGP--GoodSamples--Article--Ultra.GL-Missing.txt
```

#### 8.2) **Dataset II** | ALL GOOD SAMPLES with the ReSeq Ferals-Crupestris & without Srisoria-Cpalumbus (469 SAMPLES / 466 GBS & 3 WGS):

##### Get List of Samples:

```
find ~/data/Pigeons/Analysis/PaleoMix_GBS/*.bam ~/data/Pigeons/Analysis/PaleoMix_Re-Sequencing/*.bam | grep -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--AllSamples_ReSeq_Ferals-Crupestris--Article--Ultra.list | grep -v -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--BadSamples_NoSrisoriaNoCpalumbus--Article--Ultra.list >  ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.list
```

##### ANGSD Run:

```
xsbatch -c 46 --mem-per-cpu 7000 -J FPGP_AllSites --time 12:00:00 --force -- /groups/hologenomics/fgvieira/scripts/wrapper_angsd.sh -debug 2 -nThreads 46 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -bam ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800--Article--Ultra.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -minInd $((469*95/100)) -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 1 -doMaf 1 -doPost 2 -doGeno 3 -doPlink 2 -geno_minDepth 3 -setMaxDepth $((469*150)) -dumpCounts 2 -postCutoff 0.95 -doHaploCall 1 -doVcf 1 -out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra
```

_Number of SITES_: **1,261,881**

##### Real Coverage Calculation:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.counts.gz | tail -n +2 | gawk ' {for (i=1;i<=NF;i++){a[i]+=$i;++count[i]}} END{ for(i=1;i<=NF;i++){print a[i]/count[i]}}' | paste ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.labels - > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/RealCoverage/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.GL-RealCoverage.txt
```

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.counts.gz | tail -n +2 | gawk ' {for (i=1;i<=NF;i++){a[i]+=$i;++count[i]}} END{ for(i=1;i<=NF;i++){print a[i]/count[i]}}' | paste ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.labels - > ~/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.GL-RealCoverage.txt
```

##### Missing Data Calculation:

###### ALL SITES Genotype Likelihoods:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.beagle.gz | tail -n +2 | perl /groups/hologenomics/fgvieira/scripts/call_geno.pl --skip 3 | cut -f 4- | awk '{ for(i=1;i<=NF; i++){ if($i==-1)x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.labels - | awk '{print $1"\t"$3"\t"$3*100/1261881}' > ~/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.GL-Missing.txt
```

###### ALL SITES Random Haplotype Calling:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.haplo.gz | cut -f 4- | tail -n +2 | awk '{ for(i=1;i<=NF; i++){ if($i=="N")x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.labels - | awk '{print $1"\t"$3"\t"$3*100/1261881}' > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/MissingDataCalc/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.RHC-Missing.txt
```

#### 8.3) **Dataset III** | ALL GOOD SAMPLES with the ReSeq Ferals & without Crupestris-Cpalumbus-Srisoria-Duplicates-Captives (457 SAMPLES / 455 GBS & 2 WGS):

##### Get List of Samples:

```
find ~/data/Pigeons/Analysis/PaleoMix_GBS/*.bam ~/data/Pigeons/Analysis/PaleoMix_Re-Sequencing/*.bam | grep -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--AllSamples_ReSeq_Ferals-Crupestris--Article--Ultra.list | grep -v -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--BadSamples_NoSrisoriaNoCpalumbus--Article--Ultra.list | grep -v -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--BadSamples_NoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.list > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.list
```

##### ANGSD Run:

```
xsbatch -c 64 --mem-per-cpu 7800 -J FPGP_SNPs --time 12:00:00 --force -- /groups/hologenomics/fgvieira/scripts/wrapper_angsd.sh -debug 2 -nThreads 64 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -bam ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800--Article--Ultra.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -minInd $((457*95/100)) -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 1 -doMaf 1 -MinMaf 0.005 -SNP_pval 1e-6 -doPost 2 -doGeno 3 -doPlink 2 -geno_minDepth 3 -setMaxDepth $((457*150)) -dumpCounts 2 -postCutoff 0.95 -doHaploCall 1 -doVcf 1 -out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra
```

_Number of SNPs_: **20,659**

##### Real Coverage Calculation:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.counts.gz | tail -n +2 | gawk ' {for (i=1;i<=NF;i++){a[i]+=$i;++count[i]}} END{ for(i=1;i<=NF;i++){print a[i]/count[i]}}' | paste ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.labels - > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/RealCoverage/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.GL-RealCoverage.txt
```

##### Missing Data Calculation:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.beagle.gz | tail -n +2 | perl /groups/hologenomics/fgvieira/scripts/call_geno.pl --skip 3 | cut -f 4- | awk '{ for(i=1;i<=NF; i++){ if($i==-1)x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.labels - | awk '{print $1"\t"$3"\t"$3*100/20659}' > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/MissingDataCalc/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.GL-Missing.txt
```

#### 8.4) **Dataset IV** | ALL GOOD SAMPLES with the ReSeq Ferals-Crupestris & without Cpalumbus-Srisoria-Duplicates-Captives (458 SAMPLES / 463 GBS & 3 WGS):

##### Get List of Samples:

```
find ~/data/Pigeons/Analysis/PaleoMix_GBS/*.bam ~/data/Pigeons/Analysis/PaleoMix_Re-Sequencing/*.bam | grep -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--AllSamples_ReSeq_Ferals-Crupestris-WGS--Article--Ultra.list | grep -v -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--BadSamples_NoSrisoriaNoCpalumbus--Article--Ultra.list | grep -v -f ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--BadSamples_NoDuplicatesNoCaptives--Article--Ultra.list > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.list
```

##### ANGSD Run:

```
xsbatch -c 64 --mem-per-cpu 7800 -J FPGP_SNPs --time 12:00:00 --force -- /groups/hologenomics/fgvieira/scripts/wrapper_angsd.sh -debug 2 -nThreads 64 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -bam ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800--Article--Ultra.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -minInd $((458*95/100)) -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 1 -doMaf 1 -MinMaf 0.005 -SNP_pval 1e-6 -doPost 2 -doGeno 3 -doPlink 2 -geno_minDepth 3 -setMaxDepth $((458*150)) -dumpCounts 2 -postCutoff 0.95 -doHaploCall 1 -doVcf 1 -out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra
```

_Number of SNPs_: **20,705**

##### Real Coverage Calculation:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.counts.gz | tail -n +2 | gawk ' {for (i=1;i<=NF;i++){a[i]+=$i;++count[i]}} END{ for(i=1;i<=NF;i++){print a[i]/count[i]}}' | paste ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.labels - > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/RealCoverage/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.GL-RealCoverage.txt
```

##### Missing Data Calculation:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.beagle.gz | tail -n +2 | perl /groups/hologenomics/fgvieira/scripts/call_geno.pl --skip 3 | cut -f 4- | awk '{ for(i=1;i<=NF; i++){ if($i==-1)x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.labels - | awk '{print $1"\t"$3"\t"$3*100/20659}' > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/MissingDataCalc/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoDuplicatesNoCaptives--Article--Ultra.GL-Missing.txt
```

### 9) Global Coverage Distribution | **Dataset I**

#### Having ALL GOOD SAMPLES (475) and ALL MERGED LOCI (356.551):

```
xsbatch -c 20 --mem-per-cpu 6400 -J pptFPGP --time 10-00 --force -- /groups/hologenomics/fgvieira/scripts/wrapper_angsd.sh -debug 2 -nThreads 20 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -bam ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples--Article--Ultra.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800--Article--Ultra.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -minInd $((475*95/100)) -doCounts 1 -dumpCounts 2 -maxDepth $((475*1000)) -out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples--Article--Ultra.depth
```

#### First, we create a `.mean` file containing the average GLOBAL DEPTH of each outputted LOCI:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples--Article--Ultra.depth.pos.gz | awk 'NR>1 {print $1"\t"$2-1"\t"$2"\t"$3}' | bedtools intersect -a - -b ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged.bed -wb | bedtools groupby -g 8 -c 4 -o mean > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_IntersectedWithMerged--Article--Ultra.mean
```

#### We locally plot this `.mean` file using the R Script below and we deliberate on a maximum GLOBAL DEPTH cutoff:

_ToPlotGlobalCov_ReSeq.R_

### 10) Sites Info | **Dataset I**

##### Here we calculate the number of scaffolds with at least one SNP:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples--Article--Ultra.mafs.gz | tail -n +2 | sort -u -k 1,1 | wc -l
```

_FPGP--GoodSamples--Article--Ultra_: **302 scaffolds**

##### We here calculate the SITES density using ordinary scripts based on the relevant files below:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples--Article--Ultra.mafs.gz | tail -n +2 | cut -f1 | sort | uniq -c | awk '{print $2"\t"$1}' | sort -n -k 2,2 > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/SitesInfo/FPGP--GoodSamples--Article--Ultra.SitesDensity.txt
```

```
awk 'BEGIN{OFS="\t"} NR==FNR{x[$1]=$2} NR!=FNR && $2>1000{if(!x[$1])x[$1]=0; print $1,$2,x[$1]}' ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/SitesInfo/FPGP--GoodSamples--Article--Ultra.SitesDensity.txt ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta.fai | sort -n -k 2,2 > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/SitesInfo/FPGP--GoodSamples--Article--Ultra.ScaffoldInfo.txt
```

```
awk '{if ($3!=0) print;}' ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/SitesInfo/FPGP--GoodSamples--Article--Ultra.ScaffoldInfo.txt > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/SitesInfo/FPGP--GoodSamples--Article--Ultra.ScaffoldInfo_OnlyWithSites.txt
```

##### We locally plot these results using the Rscript below:

_FPGP--ToPlot_ScaffoldLength-NumberOfSites.R_

### 11) Heterozygosity Calculation | **Dataset I**

Here we calculate the percentage of heterozygous genotypes in our _NoSNPCalling_ sites.

##### First we generate a `.bed` file based on the `.mafs` of this specific run:

```
zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples--Article--Ultra.mafs.gz | cut -f1,2 | tail -n +2 | awk '{print $1"\t"$2-1"\t"$2}' | bedtools merge -i - > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/HeterozygosityCalc/FPGP--GoodSamples--Article--Ultra.bed
```

##### After we create a position file based on this new  `.bed` and index it accordingly usings ANGSD:

```
awk '{print $1"\t"($2+1)"\t"$3}' ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/HeterozygosityCalc/FPGP--GoodSamples--Article--Ultra.bed > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/HeterozygosityCalc/FPGP--GoodSamples--Article--Ultra.pos
angsd sites index ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/HeterozygosityCalc/FPGP--GoodSamples--Article--Ultra.pos
```

##### Getting files:

```
parallel --plus --dryrun angsd -i {} -anc ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -sites ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/HeterozygosityCalc/FPGP--GoodSamples--Article--Ultra.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -GL 1 -doSaf 1 -fold 1 -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/HeterozygosityCalc/AllGoodSamples/{/...} :::: ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples--Article--Ultra.list | xsbatch -x node923 -R --max-array-jobs 120 -c 1 --time 1-00 --mem-per-cpu 10000 -J HetCalc --
```

##### Getting fractions:

```
parallel --plus "realSFS {} > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/HeterozygosityCalc/AllGoodSamples/{/..}.het" ::: ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/HeterozygosityCalc/AllGoodSamples/*.saf.idx
```

Finally, we calculate the percentage of heterozygous sites:

```
fgrep '.' *.het | tr ":" " " | awk '{print $1"\t"$3/($2+$3)*100}' | gawk '{match($1,/(GBS|WGS|WGS\-GBS)/,lol);print $1"\t"$2"\t"lol[1]}' | sort -k 1,1gr | awk '{split($0,a,"_"); print $1"\t"a[1]"\t"$2"\t"$3'} > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Miscellaneous/HeterozygosityCalc/AllGoodSamples/FPGP--GoodSamples--Article--Ultra.Heterozygosity.txt
```

##### We locally plot these results using the Rscript below:

_FPGP--ToPlotProportionOfHeterozygousSites.R_

### 12) Initial Phylogenetic Recinstruction | **Dataset I**

#### We frist generated a simple NJ phylogeny just to confirm the positions of the out-groups.

### NJ Phylogeny | [ngsDist--v](https://github.com/fgvieira/ngsDist), [FASTme--v2.1.5](http://www.atgc-montpellier.fr/fastme/) + [RAxML-NG--v0.5.1b](https://github.com/amkozlov/raxml-ng)

We generate here a NJ phylogeny reconstrution using a combination of several programs. This approach is better described here: 'https://github.com/fgvieira/ngsDist'

#### First, we generate a 100 matrixes of genetic distances:

```
xsbatch -c 58 --mem-per-cpu 2000 -J Dist_Corr --time 3-00 -- "ngsDist --n_threads 58 --geno ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples--Article--Ultra.beagle.gz --pairwise_del --seed 21 --probs --n_ind 475 --n_sites 1225204 --labels ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples--Article--Ultra.labels --out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/NJ/FPGP--GoodSamples--Article--Ultra.dist"
```

##### Here we twick a bit the matrix of distances created above:

```
perl -p -e 's/\t/ /g' ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/NJ/FPGP--GoodSamples--Article--Ultra.dist > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/NJ/FPGP--GoodSamples--Article--Ultra_Changed.dist
```

##### Finally, we generate NJ phylogenies runnning 100 boot-strap replicates.

```
fastme -T 15 -i ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/NJ/FPGP--GoodSamples--Article--Ultra_Changed.dist -s -o ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/NJ/FPGP--GoodSamples--Article--Ultra.nwk
```

### Exhaustive Phylogenetic Reconstruction | [ngsDist--v](https://github.com/fgvieira/ngsDist), [FASTme--v2.1.5](http://www.atgc-montpellier.fr/fastme/) + [RAxML-NG--v0.5.1b](https://github.com/amkozlov/raxml-ng) | **Dataset II**

We generate here a NJ phylogeny reconstrution using a combination of several programs. This approach is better described here: 'https://github.com/fgvieira/ngsDist'

##### First, we generate a 100 matrixes of genetic distances:

```
xsbatch -c 18 --mem-per-cpu 3000 -J Dist_Corr --time 12:00:00 -- "ngsDist --n_threads 18 --geno ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.beagle.gz --pairwise_del --seed 21 --probs --n_ind 469 --n_sites 1261881 --labels ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.labels --out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/NJ/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.dist"
```

##### Here we twick a bit the matrix of distances created above:

```
perl -p -e 's/\t/ /g' ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/NJ/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.dist > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/NJ/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra_Changed.dist
```

##### Finally, we generate NJ phylogenies runnning 100 boot-strap replicates.

```
fastme -T 15 -i ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/NJ/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra_Changed.dist -s -o ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/NJ/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.nwk
```

We generate here a ML phylogeny reconstrution using the software RaxML-NG.

##### First we convert the HAPLO file into a FASTA:

```
xsbatch -c XXX --mem-per-cpu 95000 -J FASTA --time 2-00 -- "zcat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.haplo.gz | cut -f 4- | tail -n +2 | perl /groups/hologenomics/fgvieira/scripts/tsv_merge.pl --transp --ofs '' - | awk 'NR==FNR{id=$1; sub(".*\\/","",id); sub("\\..*","",id); x[FNR]=id} NR!=FNR{ print ">"x[FNR]"\n"$1}' ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.labels - > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/ML/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.fasta"
```

##### Second, we use RAxML-ng to generate a ML phylogeny based on this FASTA alingment having the NJ phylogeny generated above as a backbone:

```
raxml-ng --threads 15 --all --model GTR+G --site-repeats on --msa ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/ML/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.fasta --prefix ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/ML/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.ngsDist
```

##### Then, we use RAxML-ng to bootstrap this generated ML phylogeny:

```
raxml-ng-mpi --threads XXX --bootstrap --model GTR+G --bs-trees 100 --site-repeats on --msa ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/ML/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.fasta --tree ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/ML/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.ngsDist.raxml.bestTree --prefix ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/ML/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.ngsDist.BOOT
```

##### Finally, we add the bootstrap values supports to the generated ML phylogeny:

```
raxml-ng --threads XXX --support --tree ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/ML/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.ngsDist.raxml.bestTree --bs-trees ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/ML/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.ngsDist.BOOT.tree --prefix ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Phylogenies/ML/FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.ngsDist.FINAL
```

### 13) Population Genetics Statistics | ANGSD--v0.925

##### To create ancestral sequence:

```
xsbatch -c 12 --mem-per-cpu 2048 -J PBGP_AllSites --time 5-00 --force -- angsd -nThreads 12 -i ~/data/Pigeons/Analysis/PaleoMix_Re-Sequencing/Crupestris_01-WGS.RockDove_DoveTail_ReRun.realigned.bam -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -doFasta 1 -doCounts 1 -explode 1 -rmTrans 0 -seed 433 -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -out ~/data/Pigeons/PBGP/PBGP--Analyses/PBGP--PopGenStats/Crupestris_01-WGS.RockDove_DoveTail_ReRun.realigned.Ancestral
```

##### To get list of specific BAMs:

```
POP=("Abadeh" "Barcelona" "Berlin" "Colombo" "Copenhagen" "Crete" "Denver" "Guimaraes" "Isfahan" "Johannesburg" "Lahijan" "Lisbon" "London" "MexicoCity" "Monterrey" "Nairobi" "Nowshahr" "Perth" "PigeonIsland" "Prague" "SaltLakeCity" "Salvador" "SanCristobalDeLasCasas" "Santiago" "Sardinia" "Tatui" "Tehran" "TelAviv" "TelAvivColony" "TlaxcalaDeXicohtencatl" "Torshavn" "Trincomalee" "Vernelle" "WadiHidan")

for query in ${POP[*]}
do 
    grep ${query} ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoria--Article--Ultra.list > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoria_${query}-DoSaf--Article--Ultra.list
    
done
```

##### To run ANGSD with `-doSaf`:

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

##### To run ANGSD with `-doThetas`:

```
for query in Torshavn

do
        N_IND=`cat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf--Article--Ultra.list | wc -l`

echo angsd -nThreads 2 -ref ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun.fasta -bam ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf--Article--Ultra.list -sites ~/data/Pigeons/Reference/PBGP_FinalRun.EcoT22I_Extended_Merged_RemovedPossibleParalogs-g800--Article--Ultra.pos -rf ~/data/Pigeons/Reference/DanishTumbler_Dovetail_ReRun_ChrGreater1kb.id -pest ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper--Article--Ultra.sfs -anc ~/data/Pigeons/PBGP/PBGP--Analyses/PBGP--PopGenStats/Crupestris_01-WGS.RockDove_DoveTail_ReRun.realigned.Ancestral.fa.gz -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -postCutoff 0.95 -doGlf 2 -doGeno 3 -geno_minDepth 3 -doPost 2 -doThetas 1 -doSaf 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -GL 1 -minInd $((N_IND*95/100)) -setMaxDepth $((N_IND*150)) -out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper-DoThetas-NoWrapper--Article--Ultra
done | xsbatch -c 2 --mem-per-cpu 1024 -J AllThetas -R --max-array-jobs 60 --time 5-00 --
```

##### To get summary of Thetas:

```
for query in Abadeh Barcelona Berlin Colombo Copenhagen Crete Denver Guimaraes Isfahan Johannesburg Lahijan Lisbon London MexicoCity Monterrey Nairobi Nowshahr Perth PigeonIsland Prague SaltLakeCity Salvador SanCristobalDeLasCasas Santiago Sardinia Tatui Tehran TelAviv TelAvivColony TlaxcalaDeXicohtencatl Torshavn Trincomalee Vernelle WadiHidan

do
    N_IND=`cat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf--Article--Ultra.list | wc -l`

    thetaStat print ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper-DoThetas-NoWrapper--Article--Ultra.thetas.idx > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper-DoThetas-NoWrapper--Article--Ultra.thetas.Print
done
```

##### To perform final calculations:

```
for query in Abadeh Barcelona Berlin Colombo Copenhagen Crete Denver Guimaraes Isfahan Johannesburg Lahijan Lisbon London MexicoCity Monterrey Nairobi Nowshahr Perth PigeonIsland Prague SaltLakeCity Salvador SanCristobalDeLasCasas Santiago Sardinia Tatui Tehran TelAviv TelAvivColony TlaxcalaDeXicohtencatl Torshavn Trincomalee Vernelle WadiHidan
do

    Rscript --vanilla --slave ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--ToGetThetaSummaryFile.R ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper-DoThetas-NoWrapper--Article--Ultra.thetas.Print $N_IND $query
done > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus-DoSaf-WithWrapper-DoThetas-NoWrapper--Article--Ultra.PopGenSummary.txt
```

##### To print thetas:

```
for query in Torshavn

do
    thetaStat print ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper-DoThetas-NoWrapper--Article--Ultra.thetas.idx > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbus_${query}-DoSaf-WithWrapper-DoThetas-NoWrapper--Article--Ultra_Print

done
```

## Fst

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

### 14) Multidimensional Scaling | [ngsDist](https://github.com/fgvieira/ngsDist) + [get_PCA.R] | **Dataset III**

Here are perform a multidimensional scaling anlysis on the genetic distance matrix created above:

##### To get distance matrix:

```
xsbatch -c 14 --mem-per-cpu 2000 -J Dist_Corr --time 3-00 -- "ngsDist --n_threads 14 --geno ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.beagle.gz --pairwise_del --seed 32 --probs --n_ind 457 --n_sites 20659 --labels ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.labels --out ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--MDS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.dist"
```

##### To perform MDS:

```
tail -n +3 ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--MDS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.dist | Rscript --vanilla --slave /groups/hologenomics/fgvieira/scripts/get_PCA.R --no_header --data_symm -n 10 -m "mds" -o ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--MDS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.mds
```

##### Create `.annot` file:

```
cat ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--Lists/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.labels | awk '{split($0,a,"_"); print $1"\t"a[1]}' > ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--MDS/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.annot
```

##### We locally plot these MDS results using the Rscript below:

_FPGP--ToPlot_MDSResults.R_

### 14) Estimation of Individual Andestries [ngsAdmix](http://www.popgen.dk/software/index.php/NgsAdmix)

Here we perform an analyse of estimation of individual ancestries:

#### With the GBS-WGS pairs:

```
export N_REP=100

for K in `seq -w 2 20`
do 
    echo /groups/hologenomics/fgvieira/scripts/wrapper_ngsAdmix.sh -P 11 -debug 1 -likes ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ANGSDRuns/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.beagle.gz -K $K -minMaf 0 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o ~/data/Pigeons/FPGP/FPGP--Analyses/FPGP--ngsAdmix/FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.${K}

done | xsbatch -c 11 --mem-per-cpu 1024 --max-array-jobs 20 -J ngsAdmix -R --time 10-00 --
```

We locally plot these ngsAdmix results using the Rscript below:

_FPGP--ToPlot_ngsAdmixResults.R_

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

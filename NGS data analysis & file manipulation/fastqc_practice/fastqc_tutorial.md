This sample pipline will introduce you to performing quality control with FASTQC and more.  

First, let's create directories to store your files  

### 1. Create directories to store inputs and outputs
```bash
mkdir fastq_samples
mkdir fastqc_reports
```

Now, copy the sample files from ```/mnt/proj/omicss25/ngs_data_analysis/fastqc_practice/data``` to ```fastq_samples``` folder on server  

```bash
cp /mnt/proj/omicss25/ngs_data_analysis/fastqc_practice/data/* fastq_samples
```
First input specified _where from_ to copy and the second input specifies _where to_   
```*``` - specifies to copy all the files in the given directory

 
### 2. Run FastQC on all files  

Moving forward to running the ```fastqc``` with the command below which will process all the files inside given directory and output to the one mentioned after ```-o```  
```fastqc fastq_samples/*.fastq.gz -o fastqc_reports```  
```-o fastqc_reports```: specifies output directory. FastQC will generate .html and .zip for each input and will place them in fastqc_reports folder.  

### 3. Inspect reports  

Open ```fastqc_reports/some_sample_fastqc.html``` in a browser to see the report and let's start analyzing our outputs.   

### 4. Aggregate with MultiQC  

To inspect the bigger picture of the dataset's quality, aggregate the results using ```multiqc```. Create appropriate output folder and execute the program.  
```mkdir multiqc_report```  
```multiqc fastqc_reports -o multiqc_report```  

You may view MULTIQC report at multiqc_report/multiqc_report.html.  

### 5. Trimming with cutadapt

Finally, based on quality inspection of ```multiqc_report.html```, we will decide on parameters for trimming with cutadapt.  
```mkdir fastq_trimmed_samples```  
```cutadapt ...``` [in progress]   

### 6. Repeat QC steps 

As for the last step, after the trimming we need to inspect the quality once again to make sure that we are satisfied with the data quality  
run '''fastqc''' and ```multiqc''' again to ensure that trimming was successful  

### Additional materials
For more advanced pipelines and trimming steps, see:  
Adapter & quality trimming scripts: https://wiki.abi.am/scripts:adapter_and_quality_trimming  

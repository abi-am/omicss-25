This sample pipline will introduce you to performing quality control with FASTQC.More actions

### 1. Create directoriesto store inputs and outputs
```bash
mkdir fastq_samples
mkdir fastqc_reports
```

```fastq_samples/```: place your raw FASTQ files here (e.g., via upload or cp).
Copy your ```*.fastq.gz``` files into fastq_samples
``` cp *.fastq.gz /path/fastq_samples ```

### 2. Run FastQC on all files

```fastqc fastq_samples/*.fastq.gz -o fastqc_reports```

```-o fastqc_reports```: specifies output directory. FastQC will generate .html and .zip for each input and will place them in fastqc_reports folder.

### 3. Inspect reports

Open ```fastqc_reports/sample1_fastqc.html``` in a browser to see the report.

### 4. Aggregate with MultiQC 

```mkdir multiqc_report```
```multiqc fastqc_reports -o multiqc_report```

View MULTIQC report at multiqc_report/multiqc_report.html.

### 5. Trimming with cutadapt

```mkdir fastq_trimmed_samples```
```cutadapt ...```
### 6. Repeat QC steps 

run '''fastqc''' and ```multiqc''' again to ensure that trimming was successful

### Additional materials
For more advanced pipelines and trimming steps, see:
Adapter & quality trimming scripts: https://wiki.abi.am/scripts:adapter_and_quality_trimming

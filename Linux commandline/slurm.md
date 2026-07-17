## Big programs on Big computers

Bioinformatics is not a baby thing. We are talking about terrabytes of data being processed by big, powerful computers for days if not for weeks.
And to support such an overwhelming workload of research, the technical team has architeced the computers (from now on - servers) in a specific way to balance the 'weight'.

The Armenian Bioinformatics Intitute has six servers (of hell), one of which is governed by a Slurm cluster. Slurm is a workload manager designed to allocate computational resources for compputational nodes :) A group of such Slurm nodes is called a Slurm clustera. Our Slurm cluster consists of 7 nodes, some of which are serving the same purpose. Our seven nodes are:

Login nodes:
	ssh-01, ssh-02 (4G RAM each)
Download nodes:
	dl-01, dl-02 (8G RAM each)
Computational nodes:
	thin-01 (384G RAM), thin-02 (384G RAM), thick-02 (768G RAM)
TODO: add CPUs as well

(And additionally, project-specific R-shiny nodes: 
	rshiny0, rshiny1)
 
All of the above are basically virtual machines managed by the Infra team and accessible via Slurm. 
A person logs into one of the ssh nodes and submits a job to the dl's or thin/thicks.

## HPC Cluster User Guide

The HCP cluster uses [Slurm](https://en.wikipedia.org/wiki/Slurm_Workload_Manager) as the job scheduler. <br>
The cluster has three partitions

- thin (default): nodes with 64 CPUs and 384 GB RAM each for general computing.
- thick: node with 64 CPUs and 987 GB RAM for memory-intensive jobs. Usually used when more than 384 GB RAM is needed.
- download: nodes for downloading data with oversubscription enabled. 

### Overview
- [How to submit a batch job](https://gist.github.com/hisusqristos/cef49eefebc6a2fcefd82b6d81f54fcb#batch-job-submission)
- [How to specify a partition](https://gist.github.com/hisusqristos/cef49eefebc6a2fcefd82b6d81f54fcb#submitting-to-specific-partition)
- [Ineractive sessions and download jobs](https://gist.github.com/hisusqristos/cef49eefebc6a2fcefd82b6d81f54fcb#interactive-sessions-and-download-jobs)
- [Interaactive jobs on thick and thin](https://gist.github.com/hisusqristos/cef49eefebc6a2fcefd82b6d81f54fcb#interactive-session-on-compute-nodes)
- [Monitoring](https://gist.github.com/hisusqristos/cef49eefebc6a2fcefd82b6d81f54fcb#jobs-monitoring)

### Batch Job Submission 

First you want to create a similar submission script with specified job requirements: cpu,

```bash
#!/bin/bash
#SBATCH --job-name=data_download
#SBATCH --partition=download
#SBATCH --cpus-per-task=2
#SBATCH --mem=2G
#SBATCH --time=12:00:00
#SBATCH --output=download_%j.log

# Download datasets
wget -i url_list.txt
```
And submit the job, Comme Ça:

```bash
sbatch the_job.sh
```

__Checking status__

```bash
squeue -u $USER          # view your jobs
scontrol show job JOBID  # detailed job information
```

### Submitting to Specific Partition

As mentioned earlier, the default partition is the thin, which means that your jobs run on thin when you do not specify a partition. 
However, you can specify a partition in respect to the job you plan to run. There are two ways to do that.

__Method 1: in your job submission script__

See line 3

```bash
#!/bin/bash
#SBATCH --job-name=highmem_job_superHIVs
#SBATCH --partition=thick
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=48:00:00

# Your memory-intensive commands
python large_dataset_analysis.py
```

__Method 2: By specifying in your command__

```bash
sbatch --partition=thick myjob.sh
sbatch --partition=download myjob.sh
```

> Pro tip: <br>
> __Use download__ for interactive data transfers and downloading <br>
> __Use thin__ for standard compute jobs <br>
> __Use thick__ for nonstandard compute jobs /when you need more than 384 GB RAM/ <br>


## Interactive Sessions and Download Jobs

The download partition is designed for downloads /bingo/. It allows significant oversubscription (20:1 ratio) which means that you can run up to 20x more jobs than there are pysical CPU cores available. How to do that.

Start an interactive session

```bash
srun --partition=download --cpus-per-task=2 --mem=4G --pty bash
```

This gives you an interactive shell on a download node where you can:

```
# download datasets
wget https://mitochondria.com/largest_mitochondria_ever.tar.gz

# transfer files
rsync -avz remote_server:/data/ ./local_data/

# Light processing
gunzip data.gz
tar -xzf archive.tar.gz
```

__Interactive session with specific resources__

```bash
srun --partition=download \
     --cpus-per-task=2 \
     --mem=4G \
     --time=4:00:00 \
     --pty bash
```

## Interactive Session on compute nodes

For interactive code testing, debugging or other.

Thin:

```bash
srun --partition=thin \
     --cpus-per-task=2 \
     --mem=4G \
     --time=2:00:00 \
     --pty bash
```

Thick: 

```bash
srun --partition=thick \
     --cpus-per-task=2 \
     --mem=4G \
     --time=4:00:00 \
     --pty bash
```

## Jobs monitoring

`squeue` to check job status. Check output files for errors <br> 
`sacct` to review completed jobs <br>

## Common Commands Reference 

```bash
sbatch script.sh              # submit batch job
srun --pty bash               # interactive session
squeue                        # view job queue
squeue -u $USER               # view your jobs
scancel JOBID                 # cancel job
sinfo                         # view partition info
scontrol show partition thin  # partition details
```

__Final notes__

One shall not over request memory or CPUs it blocks resources for others. <br>
And make sure to type exit when done with interactive sessions to free resources.

<br>
<br>
<br>
By: The administration team. 

# Nextflow-Based Variant Analysis Pipeline

This project demonstrates the implementation of a bioinformatics analysis workflow using Nextflow. The pipeline automates a complete analysis path starting from raw sequencing reads and ending with a set of detected genomic variants. It has been created primarily as a learning and academic project to understand how real-world bioinformatics pipelines are structured, executed, and shared using modern workflow managers.
All pipeline scripts were written and edited using Visual Studio Code (VS Code) as the development environment.
The pipeline is written using Nextflow DSL2, which allows the workflow logic to be separated from individual computational tasks. This makes the pipeline easier to understand, debug, modify, and extend in the future.


---

## Aim of the Pipeline

The main aim of this pipeline is to:

* Automate multiple bioinformatics steps into a single workflow
* Reduce manual intervention during analysis
* Ensure consistent and reproducible results
* Demonstrate modular pipeline design using Nextflow

---

## Workflow Overview

Instead of running tools one by one manually, this pipeline connects all analysis steps internally using Nextflow channels. Each step receives its input from the previous step and passes its output forward automatically.

At a high level, the workflow:

* Accepts raw sequencing data and a reference genome
* Performs quality assessment and data cleaning
* Aligns reads to the reference genome
* Processes alignment files for downstream analysis
* Identifies genomic variants
* Summarizes quality control reports

Nextflow handles task execution, intermediate file management, and error recovery internally.

---

## Project Directory Structure

```
Nextflow_pipeline/
├── main.nf
├── workflow.nf
├── nextflow.config
├── environment.yml
├── modules/
│   ├── fastqc_raw.nf
│   ├── trim_reads.nf
│   ├── fastqc_trimmed.nf
│   ├── align_reads.nf
│   ├── sam_to_bam.nf
│   ├── sort_index_bam.nf
│   ├── variant_calling.nf
│   └── multiqc.nf
├── workflows/
│   └── workflow.nf
├── data/
│   └── exom.fastq
├── reference/
│   └── reference.fa
├── results/
├── work/
├── .gitignore
└── README.md
```

---

## Purpose of Key Components

* **main.nf** – Starts the workflow execution
* **workflow.nf** – Describes how processes are connected
* **modules/** – Contains reusable process definitions
* **environment.yml** – Ensures all tools are available in fixed versions
* **results/** – Stores final outputs in an organised manner

---

## Software and Tools Used

* Nextflow – Workflow orchestration
* FastQC – Assessment of read quality
* Cutadapt – Removal of adapter contamination
* BWA – Mapping reads to a reference genome
* Samtools – Handling alignment files
* BCFtools – Detection of sequence variants
* MultiQC – Summarization of quality reports

All tools are managed through Conda.

---

## Requirements

* Java (required for Nextflow)
* Nextflow
* Conda or Miniconda
* Git
* Linux / macOS or Windows with WSL

---

## Getting Started

### Clone the Repository

```
git clone https://github.com/yashikavaswani/Nextflow_pipeline.git
cd Nextflow_pipeline
```

### Prepare the Software Environment

```
conda env create -f environment.yml
conda activate bnf
```

---

## Running the Pipeline

```
nextflow run main.nf
```

To resume a previous run:

```
nextflow run main.nf -resume
```

---

## Input Data

The workflow requires:

* A single-end FASTQ file containing sequencing reads
* A FASTA-format reference genome

Example input files:

```
data/exom.fastq
reference/reference.fa
```

---

## Output Description

After successful execution, results are written to the `results/` directory and include:

* Read quality reports (before and after trimming)
* Cleaned sequencing reads
* Alignment files in BAM format
* Variant call file containing detected variants
* Combined quality summary report

The output directory structure is created automatically.

---

## Customisation and Configuration

Key parameters:

```
params.fastq  = 'data/exom.fastq'
params.ref    = 'reference/reference.fa'
params.outdir = 'results'
```

Resource usage can be modified in `nextflow.config`.

---

## Version Control and Sharing

```
git status
git add .
git commit -m "Update pipeline"
git push origin main
```

Generated and temporary files are excluded using `.gitignore`.

---

## Reproducibility Notes

* Software dependencies are fixed using Conda
* Each step runs independently
* Intermediate results are cached by Nextflow
* The workflow is reproducible across systems

---

## Limitations

* Supports single-end sequencing data only
* Intended for educational and demonstration purposes

---









process RAW_FASTQC {
   
   publishDir "${params.outdir}/fastqc/raw",mode:'symlink'

   input:
   path fastq

   output:
   path "*_fastqc.*"

   script:
   """
   ${params.fastqc} ${fastq}
   """
} 
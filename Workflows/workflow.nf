include { RAW_FASTQC }      from '../Modules/raw_fastqc'
include { TRIMMED_READS }      from '../Modules/trimmed_reads'
include { TRIMMED_FASTQC }  from '../Modules/trimmed_fastqc'
include { ALIGNED_READS }     from '../Modules/aligned_reads'
include { SAM_TO_BAM }      from '../Modules/sam_to_bam'
include { SORT_INDEX_BAM }  from '../Modules/sort_index_bam'
include { VARIANT_CALLING } from '../Modules/variant_calling'
include { MULTIQC }         from '../Modules/multiqc'


workflow NEXTFLOW_PIPELINE {
    take:
        fastq_input
        ref_input

    main:
        raw_qc = RAW_FASTQC(fastq_input)
        trimmed_fq = TRIMMED_READS(fastq_input)
        trimmed_qc = TRIMMED_FASTQC(trimmed_fq)
        aligned = ALIGNED_READS(trimmed_fq, ref_input)
        bam = SAM_TO_BAM(aligned)
        sorted_outputs = SORT_INDEX_BAM(bam)
        VARIANT_CALLING(sorted_outputs.sorted_bam,sorted_outputs.bai, ref_input)

        all_qc_logs = raw_qc.mix(trimmed_qc).collect()
        MULTIQC(all_qc_logs)
}

rule nanodisco_chunk:
    """nanodisco_chunk."""
    input:
        os.path.join(RefFastaDir, "{sample}.fasta"),
        os.path.join(NANODISCO_PREPROCESS, "{sample}", "{sample}.sorted.bam"),
        os.path.join(NANODISCO_PREPROCESS, "{sample}", "C308_WGA.sorted.bam")
    output:
        os.path.join(RefFastaDir, "{sample}.fasta.ann")
    threads:
        1
    params:
        os.path.join(NanoDiscoSingularityDir, "nanodisco")
    resources:
        mem_mb=BigJobMem
    shell:
        """
        module load Singularity
        singularity exec {params[0]} nanodisco chunk_info  -r {input[0]}
        """

rule aggr_nanodisco_chunk:
    """Aggregate."""
    input:
        expand(os.path.join(RefFastaDir, "{sample}.fasta.ann"), sample = SAMPLES)
    output:
        os.path.join(LOGS, "aggr_nano_chunk.txt")
    threads:
        1
    resources:
        mem_mb=SmallJobMem,
        time=3
    shell:
        """
        touch {output[0]}
        """


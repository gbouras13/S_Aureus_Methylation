rule nanodisco_preprocess_sample:
    """nanodisco_preprocess."""
    input:
        os.path.join(REBASECALLED_FAST5_GZIP, "{sample}"),
        os.path.join(RefFastaDir, "{sample}.fasta"),
        os.path.join(RefFastaDir, "{sample}.fasta.fai")
    output:
        os.path.join(NANODISCO_PREPROCESS, "{sample}", "{sample}.sorted.bam"),
        os.path.join(NANODISCO_PREPROCESS, "{sample}")
    threads:
        BigJobCpu
    params:
        os.path.join(NanoDiscoSingularityDir, "nanodisco")
    resources:
        mem_mb=BigJobMem
    shell:
        """
        module load Singularity
        singularity exec {params[0]} nanodisco preprocess -p {threads} -f {input[0]} -s {wildcards.sample} -o {output[1]} -r {input[1]}
        """

rule nanodisco_preprocess_reference:
    """nanodisco_preprocess reference."""
    input:
        os.path.join(REBASECALLED_FAST5_GZIP, "{sample}"),
        os.path.join(RefFastaDir, "{sample}.fasta"),
        os.path.join(RefFastaDir, "{sample}.fasta.fai")
    output:
        os.path.join(NANODISCO_PREPROCESS, "{sample}", "C308_WGA.sorted.bam"),
        directory(os.path.join(NANODISCO_PREPROCESS, "{sample}"))
    threads:
        BigJobCpu
    params:
        os.path.join(NanoDiscoSingularityDir, "nanodisco"), 
        C308Fast5Dir,
        'C308_WGA'
    resources:
        mem_mb=BigJobMem
    shell:
        """
        module load Singularity
        singularity exec {params[0]} nanodisco preprocess -p {threads} -f {params[1]} -s {params[2]} -o {output[1]} -r {input[1]}
        """

rule aggr_nanodisco_preprocess:
    """Aggregate."""
    input:
        expand(os.path.join(NANODISCO_PREPROCESS, "{sample}", "{sample}.sorted.bam"), sample = SAMPLES),
        expand(os.path.join(NANODISCO_PREPROCESS, "{sample}", "C308_WGA.sorted.bam"), sample = SAMPLES)
    output:
        os.path.join(LOGS, "aggr_nano_preprocess.txt")
    threads:
        1
    resources:
        mem_mb=SmallJobMem,
        time=3
    shell:
        """
        touch {output[0]}
        """


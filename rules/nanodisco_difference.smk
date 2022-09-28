rule nanodisco_difference:
    """nanodisco_difference."""
    input:
        os.path.join(NANODISCO_PREPROCESS, "{sample}"),
        os.path.join(RefFastaDir, "{sample}.fasta"),
        os.path.join(NANODISCO_PREPROCESS, "{sample}", "{sample}.sorted.bam"),
        os.path.join(NANODISCO_PREPROCESS, "{sample}", "C308_WGA.sorted.bam"),
        os.path.join(RefFastaDir, "{sample}.fasta.amb")
    output:
        directory(os.path.join(NANODISCO_DIFFERENCE, "{sample}"))
    threads:
        1
    params:
        os.path.join(NanoDiscoSingularityDir, "nanodisco"),
        'C308_WGA'
    resources:
        mem_mb=200000, 
        time=1400,
        th=40
    shell:
        """
        module load Singularity
        singularity exec {params[0]} nanodisco difference  -nj 10 -nc 1 -p 4 -i {input[0]} -o {output[0]} -w {params[1]} -n {wildcards.sample} -r {input[1]}
        """

rule aggr_nanodisco_difference:
    """Aggregate."""
    input:
        expand(os.path.join(NANODISCO_DIFFERENCE, "{sample}"), sample = SAMPLES),
    output:
        os.path.join(LOGS, "aggr_nano_difference.txt")
    threads:
        1
    resources:
        mem_mb=SmallJobMem,
        time=3
    shell:
        """
        touch {output[0]}
        """


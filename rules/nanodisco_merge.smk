rule nanodisco_merge:
    """nanodisco_merge."""
    input:
        os.path.join(NANODISCO_DIFFERENCE, "{sample}")
    output:
        os.path.join(NANODISCO_MERGE, "{sample}", "{sample}.RDS")
    threads:
        1
    params:
        os.path.join(NanoDiscoSingularityDir, "nanodisco"),
        os.path.join(NANODISCO_MERGE, "{sample}")
    resources:
        mem_mb=16000, 
        time=100
    shell:
        """
        module load Singularity
        singularity exec {params[0]} nanodisco merge  -d {input[0]} -o {params[1]} -b {wildcards.sample}
        """

rule aggr_nanodisco_difference:
    """Aggregate."""
    input:
        expand(os.path.join(NANODISCO_MERGE, "{sample}", "{sample}.RDS"), sample = SAMPLES),
    output:
        os.path.join(LOGS, "aggr_nano_merge.txt")
    threads:
        1
    resources:
        mem_mb=SmallJobMem,
        time=3
    shell:
        """
        touch {output[0]}
        """


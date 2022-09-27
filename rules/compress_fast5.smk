
rule compress_fast5:
    """gzip Re-basecalled fast5 files."""
    input:
        os.path.join(REBASECALLED_FAST5, "{sample}", "workspace")
    output:
        directory(os.path.join(REBASECALLED_FAST5_GZIP, "{sample}"))
    threads:
        MedJobCpu
    conda:
        os.path.join('..', 'envs','compress_fast5.yaml')
    resources:
        mem_mb=16000,
        time=60
    shell:
        """
        compress_fast5 -t {threads} -i {input[0]}  -s {output[0]} -c gzip
        """

rule aggr_compress_fast5:
    """Aggregate."""
    input:
        expand(os.path.join(REBASECALLED_FAST5_GZIP, "{sample}"), sample = SAMPLES)
    output:
        os.path.join(LOGS, "aggr_compress_fast5.txt")
    threads:
        1
    resources:
        mem_mb=SmallJobMem,
        time=3
    shell:
        """
        touch {output[0]}
        """


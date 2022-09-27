rule index_ref:
    """index reference fasta."""
    input:
        os.path.join(RefFastaDir, "{sample}.fasta")
    output:
        os.path.join(RefFastaDir, "{sample}.fasta.fai")
    threads:
        1
    conda:
        os.path.join('..', 'envs','samtools.yaml')
    resources:
        mem_mb=SmallJobMem,
        time=5
    shell:
        """
        samtools faidx {input[0]} 
        """



rule aggr_index_ref:
    """Aggregate."""
    input:
        expand(os.path.join(RefFastaDir, "{sample}.fasta.fai"), sample = SAMPLES)
    output:
        os.path.join(LOGS, "aggr_index_ref.txt")
    threads:
        1
    resources:
        mem_mb=SmallJobMem,
        time=3
    shell:
        """
        touch {output[0]}
        """


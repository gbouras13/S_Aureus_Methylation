rule nanodisco_motif:
    """nanodisco_motif."""
    input:
        os.path.join(NANODISCO_MERGE, "{sample}", "{sample}_difference.RDS"),
        os.path.join(RefFastaDir, "{sample}.fasta")
    output:
        os.path.join(NANODISCO_MOTIF, "{sample}", "motif_detection", "meme_results", "meme_1", "meme.txt")
    threads:
        1
    params:
        os.path.join(NanoDiscoSingularityDir, "nanodisco"),
        os.path.join(NANODISCO_MOTIF, "{sample}")
    resources:
        mem_mb=16000, 
        time=200
    shell:
        """
        module load Singularity
        singularity exec {params[0]} nanodisco motif  -d {input[0]} -o {params[1]} -r {input[1]}
        """

rule aggr_nanodisco_motif:
    """Aggregate."""
    input:
        expand(os.path.join(NANODISCO_MOTIF, "{sample}", "motif_detection", "meme_results", "meme_1", "meme.txt"), sample = SAMPLES),
    output:
        os.path.join(LOGS, "aggr_nano_motif.txt")
    threads:
        1
    resources:
        mem_mb=SmallJobMem,
        time=3
    shell:
        """
        touch {output[0]}
        """


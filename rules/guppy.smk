def get_fast5_dir(wildcards):
    return dictReads[wildcards.sample]["DIR"]

rule guppy:
    """
    Re-basecall fast5 files.
    https://fame.flinders.edu.au/blog/2021/08/02/snakemake-profiles-updated
    https://github.com/Snakemake-Profiles/slurm
    specify gpu through slurm not gpu and don't include gpu in the snakemake profile, or else the other rules won't run
    """
    input:
        get_fast5_dir
    output:
        os.path.join(REBASECALLED_FAST5, "{sample}", "sequencing_summary.txt"),
        directory(os.path.join(REBASECALLED_FAST5, "{sample}", "workspace"))
    params:
        os.path.join(GuppyDir, "guppy_basecaller"),
        os.path.join(REBASECALLED_FAST5, "{sample}")
    threads:
        4
    resources:
        mem_mb=8000,
        partition='v100',
        slurm="gres=gpu:1",
        time=120
    shell:
        """
        module load  CUDA/11.2.0
        {params[0]} --compress_fastq -i {input[0]} -s {params[1]} -c dna_r9.4.1_450bps_sup.cfg  -x auto  --fast5_out  --num_callers 4 --cpu_threads_per_caller 1 --disable_pings
        """

rule aggr_guppy:
    """Aggregate."""
    input:
        expand(os.path.join(REBASECALLED_FAST5, "{sample}", "sequencing_summary.txt") , sample = SAMPLES)
    output:
        os.path.join(LOGS, "aggr_guppy.txt")
    threads:
        1
    resources:
        mem_mb=SmallJobMem,
        time=3
    shell:
        """
        touch {output[0]}
        """


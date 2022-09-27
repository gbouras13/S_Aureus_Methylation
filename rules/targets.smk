"""
All target output files are declared here
"""


# Preprocessing files
GPUFiles = [
     expand(os.path.join(REBASECALLED_FAST5, "{sample}", "sequencing_summary.txt") , sample = SAMPLES)
]

NanoDiscoFiles = [
    os.path.join(LOGS, "aggr_compress_fast5.txt"),
    os.path.join(LOGS, "aggr_index_ref.txt"),
    os.path.join(LOGS, "aggr_nano_preprocess.txt"),
    os.path.join(LOGS, "aggr_nano_chunk.txt"),
    os.path.join(LOGS, "aggr_nano_difference.txt"),
    os.path.join(LOGS, "aggr_nano_merge.txt"),
    os.path.join(LOGS, "aggr_nano_motif.txt")
]
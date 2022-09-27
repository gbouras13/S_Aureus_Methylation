"""
All target output files are declared here
"""


# Preprocessing files
GPUFiles = [
     expand(os.path.join(REBASECALLED_FAST5, "{sample}", "sequencing_summary.txt") , sample = SAMPLES)
]

NanoDiscoFiles = [
    os.path.join(LOGS, "aggr_compress_fast5.txt")
]
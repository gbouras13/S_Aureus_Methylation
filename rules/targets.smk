"""
All target output files are declared here
"""


# Preprocessing files
GPUFiles = [
     expand(os.path.join(REBASECALLED_FAST5, "{sample}", "sequencing_summary.txt") , sample = SAMPLES)
]

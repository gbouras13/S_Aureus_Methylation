"""
The snakefile that runs the pipeline.
Manual launch example:

"""

import os

### DEFAULT CONFIG FILE

configfile: os.path.join(  'config', 'config.yaml')


### DIRECTORIES

include: "rules/directories.smk"

# get if needed
CSV = config['csv']
OUTPUT = config['Output']
GuppyDir = config['GuppyDir']


BigJobMem = config["BigJobMem"]
BigJobCpu = config["BigJobCpu"]
SmallJobMem = config["SmallJobMem"]


# Parse the samples and read files
include: "rules/samples.smk"
dictReads = parseSamples(CSV)
SAMPLES = list(dictReads.keys())
#print(SAMPLES)


# Import rules and functions
include: "rules/targets.smk"
include: "rules/guppy.smk"


# include: "rules/qc.smk"
# include: "rules/assemble.smk"
# include: "rules/assembly_statistics.smk"
# if MEDAKA_FLAG == True:
#     include: "rules/polish.smk"
# elif MEDAKA_FLAG == False:
#     include: "rules/polish_no_medaka.smk"
# include: "rules/extract_fastas.smk"
# include: "rules/extract_assembly_info.smk"
# include: "rules/plassembler.smk"
# # run if STAPH is true
# if STAPH == True:
#     include: "rules/mlst.smk"
#     include: "rules/combine_mlst.smk"
#     include: "rules/srst2.smk"

rule all:
    input:
        TargetFiles

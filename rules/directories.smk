"""
Database and output locations for Hecatomb
Ensures consistent variable names and file locations for the pipeline.
"""


### OUTPUT DIRECTORY
if config['Output'] is None:
    OUTPUT = 'Meth_Output'
else:
    OUTPUT = config['Output']


### OUTPUT DIRs
LOGS = os.path.join(OUTPUT, 'LOGS')
TMP = os.path.join(OUTPUT, 'TMP')

# basecalled outdirs
REBASECALLED_FAST5 = os.path.join(OUTPUT, 'REBASECALLED_FAST5')
REBASECALLED_FAST5_GZIP = os.path.join(OUTPUT, 'REBASECALLED_FAST5_GZIP')

# nanodisco outdirs 
NANODISCO_ANALYSIS = os.path.join(OUTPUT, 'NANODISCO_ANALYSIS')
NANODISCO_PREPROCESS = os.path.join(NANODISCO_ANALYSIS, 'NANODISCO_PREPROCESS')
NANODISCO_DIFFERENCE = os.path.join(NANODISCO_ANALYSIS, 'NANODISCO_DIFFERENCE')
NANODISCO_MERGE = os.path.join(NANODISCO_ANALYSIS, 'NANODISCO_MERGE')
NANODISCO_MOTIF = os.path.join(NANODISCO_ANALYSIS, 'NANODISCO_MOTIF')
NANODISCO_MOTIF_OUTPUT = os.path.join(NANODISCO_ANALYSIS, 'NANODISCO_MOTIF_OUTPUT')








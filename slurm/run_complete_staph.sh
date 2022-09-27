#!/bin/bash -l

#SBATCH --job-name=bact_assembly
#SBATCH --mail-user=george.bouras@adelaide.edu.au
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --err="complete_staph.err"
#SBATCH --output="complete_staph.out"

# Resources allocation request parameters
#SBATCH -p batch
#SBATCH -N 1                                                    # number of tasks (sequential job starts 1 task) (check this if your job unexpectedly uses 2 nodes)
#SBATCH -c 1                                                    # number of cores (sequential job calls a multi-thread program that uses 8 cores)
#SBATCH --time=2-23:00:00                                         # time allocation, which has the format (D-HH:MM), here set to 1 hou                                           # generic resource required (here requires 1 GPUs)
#SBATCH --mem=1GB                                              # specify memory required per node


# run from Bacteria_Multiplex

SNK_DIR="/hpcfs/users/a1667917/S_Aureus_Methylation"
PROF_DIR="$SNK_DIR/snakemake_profile"

cd $SNK_DIR

module load Anaconda3/2020.07
conda activate snakemake_clean_env



# rebasecall 
# snakemake -c 1 -s rebasecall_runner.smk --use-conda  --conda-frontend conda --profile $PROF_DIR/methylation_gpu  \
# --config csv=complete_metadata.csv Output=/hpcfs/users/a1667917/S_Aureus_Methylation/Output 

# run from there

# snakemake -c 1 -s nanodisco_runner.smk --use-conda  --conda-frontend conda --profile $PROF_DIR/methylation  --conda-create-envs-only  \
# --config csv=complete_metadata.csv Output=/hpcfs/users/a1667917/S_Aureus_Methylation/Output 

snakemake -c 1 -s nanodisco_runner.smk --use-conda  --conda-frontend conda --profile $PROF_DIR/methylation  \
--config csv=complete_metadata.csv Output=/hpcfs/users/a1667917/S_Aureus_Methylation/Output 

conda deactivate

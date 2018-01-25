#!/bin/env bash
#SBATCH -J local_scratch_example
#SBATCH -o local_scratch_example.o_%j
#SBATCH -e local_scratch_example.e_%j
#SBATCH --mem 10G
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 1
#SBATCH --nodes 1
#SBATCH --time 00:10:00

# Load module commands go here
# module load XXXX/XXXXXXX 
# module load YYYY/YYYYYY 

# list all loaded modules
module list

# Here we are making dummy "input" files testing1two3four5six_1 through testing1two3four5six_9,
# but you wouldn't have to do this for your real script
seq 1 9 | xargs -I {} touch testing1two3four5six_{}

MY_STARTING_DIR=$PWD

# Make unique directory
LOCAL_DIR=/local/scratch/$USER/$SLURM_JOB_ID/testingDIR

# Create the starting directory 
mkdir -p $LOCAL_DIR

# You probably don't need to copy files to /local/scratch, but assuming you do ....
cp testing123456* $LOCAL_DIR

# Change to local directory
cd $LOCAL_DIR

# Here is where your pipeline code would go

# You may have many result files, but we're just creating one for the demo
RESULT_FILE=local_scratch_info_${SLURM_JOB_ID}.txt

# replace the following with your analysis steps
hostname  > $RESULT_FILE
pwd      >> $RESULT_FILE
ls -l    >> $RESULT_FILE
df -h .  >> $RESULT_FILE


# Copy results to a "permanent" non-local directory 
cp $RESULT_FILE $MY_STARTING_DIR

# Go back to starting directory
cd $MY_STARTING_DIR 

# Clean up (Remove all of the files we just created)
rm -rf $LOCAL_DIR

# Removing our dummy input files, but you probably wouldn't need this for a real script
rm testing1two3four5six_*

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

MY_LOG_FILE=$MY_STARTING_DIR/local_dir_job_${SLURM_JOB_ID}.log

# Make unique directory
LOCAL_DIR=/local/scratch/$USER/$SLURM_JOB_ID/testingDIR

# Create the starting directory 
echo "---------------------------------------------------------------" >> $MY_LOG_FILE
echo "creating $LOCAL_DIR on $HOSTNAME"                                >> $MY_LOG_FILE
mkdir -p $LOCAL_DIR

# Log how much space is on /local/scratch (then you can blame someone else if it is already full)
echo "---------------------------------------------------------------" >> $MY_LOG_FILE
echo "Space on $HOSTNAME's /local/scratch before this job:"            >> $MY_LOG_FILE
df -h $LOCAL_DIR                                                       >> $MY_LOG_FILE

# You probably don't need to copy files to /local/scratch, but assuming you do ....
echo "---------------------------------------------------------------" >> $MY_LOG_FILE
echo "Copying input files to $LOCAL_DIR on $HOSTNAME"                  >> $MY_LOG_FILE

cp testing123456* $LOCAL_DIR

echo "---------------------------------------------------------------" >> $MY_LOG_FILE
echo "Space on $HOSTNAME's /local/scratch after copying files:"        >> $MY_LOG_FILE
df -h $LOCAL_DIR                                                       >> $MY_LOG_FILE

# Change to local directory
cd $LOCAL_DIR

echo "---- START OF ANALYSIS PIPELINE -------------------------------" >> $MY_LOG_FILE
# Here is where your pipeline code would go

# You may have many result files, but we're just creating one for the demo
RESULT_FILE=local_scratch_info_${SLURM_JOB_ID}.txt

# replace the following with your analysis steps
hostname  > $RESULT_FILE
pwd      >> $RESULT_FILE
ls -l    >> $RESULT_FILE
df -h .  >> $RESULT_FILE

echo "---- END OF ANALYSIS PIPELINE -------------------------------" >> $MY_LOG_FILE

echo "---------------------------------------------------------------" >> $MY_LOG_FILE
echo "Space on $HOSTNAME's /local/scratch after running the pipeline:" >> $MY_LOG_FILE
df -h /local/scratch                                                   >> $MY_LOG_FILE

# Copy results to a "permanent" non-local directory 
echo "---------------------------------------------------------------" >> $MY_LOG_FILE
echo "Directory listing of $LOCAL_DIR: "                               >> $MY_LOG_FILE
ls                                                                     >> $MY_LOG_FILE
echo "Copying $RESULT_FILE to $MY_STARTING_DIR "                       >> $MY_LOG_FILE

cp $RESULT_FILE $MY_STARTING_DIR

# Go back to starting directory
cd $MY_STARTING_DIR 

# Clean up (Remove all of the files we just created)
echo "---------------------------------------------------------------"     >> $MY_LOG_FILE
echo "Removing $LOCAL_DIR, to leave space on /local/scratch for next time" >> $MY_LOG_FILE
rm -rf $LOCAL_DIR

echo "---------------------------------------------------------------" >> $MY_LOG_FILE
echo "Space on $HOSTNAME's /local/scratch after deleting $LOCAL_DIR:"  >> $MY_LOG_FILE
df -h /local/scratch                                                   >> $MY_LOG_FILE

echo "---------------------------------------------------------------" >> $MY_LOG_FILE
echo "Finished deleting $LOCAL_DIR" >> $RESULT_FILE

echo "** FINISHED ***************************************************" >> $MY_LOG_FILE

# Removing our dummy input files, but you probably wouldn't need this for a real script
rm testing1two3four5six_*

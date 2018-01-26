# local-scratch-example
The `.sbatch` files in this repository are a couple of examples of how to properly use `/local/scratch` with SLURM. Feel free to copy them and use them in your workflows.

Do you really need to use `/local/scratch`? If whatever you are currently doing is working fine for you and everyone else, then don't waste your time worryng about it. You can quit reading now.

Here are some valid cases in which using `/local/scratch` may help:

* A program you use in an analysis does not interact with a network file system properly.
* Many and/or large temporary files are generated during your analysis and causes problems because:
   * You are close to a quota limit on a cluster storage system, or
   * your analysis is I/O bound.

When you think of `/local/scratch`, think of “scratch paper”. This is great place for temporary files. Space used in `/local/scratch` does not count against quotas on any file system (except `/local/scratch` itself, of course). However, if you write anything to `/local/scratch` that you want to keep, please be sure to copy it off before the end of the job (i.e. include this step in your SLURM script). And you need to throw away the files you created inside `/loca/scratch` when you are finished (i.e. also include this step in your script).

Key points when using `/local/scratch`:

1. You need to know what your software is doing.  
    a. What files does it read?  
    b. What files does it write?  
    c. Which input and/or output files need to be on `/local/scratch`?  
2. At the end of your analysis, you must delete everything on `/local/scratch` that was created for this particular job. Otherwise, `/local/scratch` will fill up and you and others won't be able to use it in the future. And you may receive an email asking why you didn't clean up after yourself. 
3. Most often, your initial input files probably do not need to be on `/local/scratch`, but if your program somehow requires it, you can copy them to `/local/scratch` early during your job.

If you reserve an entire node (i.e. using the exclusive flag or requesting all the cores on a node), then you shouldn't have to worry about anyone else writing to `/local/scratch` at the same time. 

If you are going to be writing a lot of files to /local/scratch, you might want to include a check in your script that bails out if there isn't sufficient storage space available before you start. 

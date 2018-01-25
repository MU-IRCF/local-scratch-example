# local-scratch-example
The `.sbatch` files in this repository are a couple of examples of how to properly use `/local/scratch` with SLURM.


Do you really need to use `/local/scratch`? If so, why? Can you demonstrate it? The only case that I've come across was a program that apparently does not interact with a network file system properly.

When you think of `/local/scratch`, think of “scratch paper”. This is a temporary location. Anything you want to keep from it needs to be copied off at the end. And you need to throw away the files you created inside `/loca/scratch` when you are finished. 

Key points when using `/local/scratch`:

1. You need to know what your software is doing.  
    a. What files does it read?  
    b. What files does it write?  
    c. Which input and/or output files need to be on `/local/scratch`?  
2. At the end of your analysis, you must delete everything on `/local/scratch` that was created for this particular job. Otherwise, `/local/scratch` will fill up and you and others won't be able to use it in the future.  

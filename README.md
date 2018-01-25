# local-scratch-example
Demonstrate how to use `/local/scratch` with SLURM

Key points when using `/local/scratch`:

1. You need to know what your software is doing.  
    a. What files does it read?  
    b. What files does it write?  
    c. Which input and/or output files need to be on `/local/scratch`?  
2. When you think of `/local/scratch`, think of “scratch paper”. This is a temporary location. Anything you want to keep from it needs to be copied off at the end.  
3. At the end of your analysis, you must delete everything one `/local/scratch` that was created for this particular job. Otherwise, `/local/scratch` will fill up and you and others won't be able to use it in the future.  


# rna_project

Work in progress

Practicing my computational skillz



## Steps

1. Fastqc

2. Trimmomatic
 
3. Salmon Index
I found that I had to increase min mem to 8000.
Where did the `kfish2rae5g.mrna.combined` come from 

4. Salmon Quant
What is a library type? ISF vs ISR? Talk about how jane does naming on her files. 

5. Download quant directories to local computer for R analysis
```
scp prvasque@farm.cse.ucdavis.edu:/home/prvasque/projects/niehs/Data/counts/*/quant.sf .
```
Cant use this because all the files share the same name `quant.sf` so they just get overwritten on my local computer.

6. Use Rstudio script that jane gave me

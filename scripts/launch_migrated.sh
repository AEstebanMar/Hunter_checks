#! /usr/bin/env bash


#source ~soft_bio_267/initializes/init_degenes_hunter
#module load libxml2/2.7.8
module load latex/3.14
. ~soft_bio_267/initializes/init_R

export DEGHUNTER_MODE=DEVELOPMENT
export OMP_NUM_THREADS=1 # This limits how many cores can use BLAS/Lapack within R to linear alg calculations and avoid that the execution of several hunter in the same node clash between then
export PATH=~aestebanm/dev_R/ExpHunterSuite/inst/scripts:$PATH

degenes_Hunter.R -i ./reduced_counts.txt -o $FSCRATCH/NGS_projects/DEG_workflow/hepatocytes/results -t ./my_target.txt -m D ### El library_sizes lo he sacado de /mnt/scratch/users/bio_267_uma/elenarojano/NGS_projects/HepG2_PMM2/results/mapping_reports/metric_table, son datos de este experimento pero que yo no tengo aquí disponibles. Es correcto este número, en resumidas cuentas.

#! /usr/bin/env bash


source ~soft_bio_267/initializes/init_degenes_hunter

degenes_Hunter.R -i ./reduced_counts.txt --library_sizes /mnt/scratch/users/bio_267_uma/elenarojano/NGS_projects/HepG2_PMM2/results/mapping_reports/metric_table -o $FSCRATCH/NGS_projects/DEG_workflow/hepatocytes/results_original -t ./my_target.txt -m D ### El library_sizes lo he sacado de /mnt/scratch/users/bio_267_uma/elenarojano/NGS_projects/HepG2_PMM2/results/mapping_reports/all_metrics, son datos de este experimento pero que yo no tengo aquí disponibles. Es correcto este número, en resumidas cuentas.

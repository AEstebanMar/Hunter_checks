#! /usr/bin/env bash


source ~soft_bio_267/initializes/init_autoflow
current_dir=`pwd`
template=$current_dir/templates/template.af
script_dir=$current_dir/scripts
input=$current_dir/reduced_counts.txt
target=$current_dir/my_target.txt
library_sizes=/mnt/scratch/users/bio_267_uma/elenarojano/NGS_projects/HepG2_PMM2/results/mapping_reports/metric_table
mode=$1
aux_opt=$2

variables=`echo -e "
	\\$script_dir=$script_dir,
	\\$input=$input,	
	\\$target=$target,
	\\$output_dir=$output_dir,
	\\$library_sizes=$library_sizes
	" | tr -d [:space:]`

if [ "$mode" == "exec" ] ; then
	AutoFlow -w $template -b -V $variables $aux_opt -o exec_DEG_wf

elif [ "$mode" == "check" ]; then
	flow_logger -w -e exec_DEG_wf -r all

elif [ "$mode" == "rescue" ]; then
	echo Regenerating code
	AutoFlow -w $template -V $variables -L $aux_opt -o exec_DEG_wf -v
	echo Launching pending and failed jobs
	flow_logger -w -e exec_DEG_wf -l -p -b
fi

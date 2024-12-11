#! /usr/bin/env bash


source ~soft_bio_267/initializes/init_autoflow
export CODE_PATH=`pwd`
source $CODE_PATH/config_daemon
template=$CODE_PATH/templates/template.af
script_dir=$CODE_PATH/scripts
input=$CODE_PATH/reduced_counts.txt
target=$CODE_PATH/my_target.txt
library_sizes=/mnt/scratch/users/bio_267_uma/elenarojano/NGS_projects/HepG2_PMM2/results/mapping_reports/metric_table
rnaseq_input_path=$CODE_PATH/ctrl_vs_dox_cell
mirnaseq_input_path=$CODE_PATH/CTL_vs_DOX_cell
Multimir_path=~josecordoba/proyectos/multimir_db/p_hsa
add_opt_corr='--save_temp:--tag_filter:prevalent;prevalent:-u:2:--output_pairs:validated'
strats=\"\"
mode=$1
aux_opt=$2

variables=`echo -e "
	\\$root_dir=$CODE_PATH,
	\\$script_dir=$script_dir,
	\\$input=$input,	
	\\$target=$target,
	\\$output_dir=$output_dir,
	\\$library_sizes=$library_sizes,
	\\$rnaseq_input_path=$rnaseq_input_path,
	\\$strats=$strats,
	\\$mirnaseq_input_path=$mirnaseq_input_path,
	\\$Multimir_path=$Multimir_path,
	\\$CORR_THRS='-0.55:-0.6:-0.65:-0.7:-0.75:-0.8:-0.85:-0.9:-0.95',
	\\$add_opt_corr=$add_opt_corr,
	\\$cormit_data_path=$CODE_PATH/cormit_data,
	\\$organism='hsa',
	\\$aux_parsers_path=$CODE_PATH/aux_parsers,
	\\$fun_pvalue=0.1,
	\\$fun_an_type='KgRdD',
	\\$fun_an_performance='o',
	\\$GO_modules='MBC',
	\\$fun_remote_mode='',
	\\$universe='',
	\\$CODE_PATH=$CODE_PATH,
	\\$fun_organism='Human',
	\\$annotation_list=''

	" | tr -d [:space:]`

if [ "$mode" == "exec" ] ; then
	AutoFlow -w $template -b -V $variables $aux_opt -o exec_DEG_wf

elif [ "$mode" == "check" ]; then
	flow_logger -w -e exec_DEG_wf -r all

elif [ "$mode" == "rescue" ]; then
	echo Regenerating code
	AutoFlow -w $template -V $variables $aux_opt -o exec_DEG_wf -v
	echo Launching pending and failed jobs
	flow_logger -w -e exec_DEG_wf -l -p -b
fi

#! /usr/bin/env bash


source ~soft_bio_267/initializes/init_autoflow
export CODE_PATH=`pwd`
data_dir=$CODE_PATH/Data
source $CODE_PATH/config_daemon
template=$CODE_PATH/templates/template.af
script_dir=$CODE_PATH/scripts
target=$CODE_PATH/my_target.txt
rnaseq_input_path=$CODE_PATH/ctrl_vs_mut_bicor
mirnaseq_input_path=$CODE_PATH/CTRL_VS_MUT_BICOR
add_opt_corr='--save_temp:--tag_filter:prevalent;prevalent:-u:2:--output_pairs:validated'
strats=\"EE:Eh:Ed:hd:hE:hh\"
multivar_data=$data_dir/multivar_data
mode=$1
aux_opt=$2

variables=`echo -e "
	\\$root_dir=$CODE_PATH,
	\\$data_dir=$data_dir,
	\\$script_dir=$script_dir,
	\\$input=$data_dir/reduced_counts.txt,	
	\\$target=$data_dir/my_target.txt,
	\\$output_dir=$output_dir,
	\\$library_sizes=$data_dir/metric_table,
	\\$rnaseq_input_path=$data_dir/CTL_vs_DOX_cell,
	\\$strats=$strats,
	\\$mirnaseq_input_path=$data_dir/CTL_vs_DOX_cell,
	\\$Multimir_path=$data_dir/p_hsa,
	\\$CORR_THRS='-0.5:-0.55:-0.6:-0.65:-0.7:-0.75:-0.8:-0.85:-0.9:-0.95',
	\\$add_opt_corr=$add_opt_corr,
	\\$organism='mmu',
	\\$aux_parsers_path=$CODE_PATH/aux_parsers,
	\\$fun_pvalue=0.5,
	\\$fun_an_type='KgRd',
	\\$fun_an_performance='o',
	\\$GO_modules='MBC',
	\\$fun_remote_mode='',
	\\$universe='',
	\\$CODE_PATH=$CODE_PATH,
	\\$fun_organism='Human',
	\\$annotation_list='',
	\\$multivar_files=$multivar_data/"metabolomics.txt",
	\\$multivar_active_files=$multivar_data/"phenotypes.txt",
	\\$multivar_supp_files=$multivar_data/"severity_scales.txt"

	" | tr -d [:space:]`

if [ "$mode" == "exec" ] ; then
	AutoFlow -w $template -V $variables $aux_opt -o exec_DEG_wf -b

elif [ "$mode" == "check" ]; then
	flow_logger -w -e exec_DEG_wf -r all

elif [ "$mode" == "rescue" ]; then
	echo Regenerating code
	AutoFlow -w $template -V $variables $aux_opt -o exec_DEG_wf -v
	echo Launching pending and failed jobs
	flow_logger -w -e exec_DEG_wf -l -p -b
fi

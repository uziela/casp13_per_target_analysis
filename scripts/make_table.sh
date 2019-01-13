#!/bin/bash

# Written by Karolis Uziela in 2019

script_name=`basename $0`

if [ $# != 3 ] ; then
    echo "
Usage: 

$script_name [Parameters]

Parameters:
<input-dir> - input directory
<cor_type> - 'pearson' or 'spearman'
<output_dir>

"
    exit 1
fi

input_dir=$1
cor_type=$2
output_dir=$3

echo "$script_name started with parameters: $*"

mkdir -p $output_dir


for q in GDT_TS GDT_HA lDDT CAD ; do
    rm -f $output_dir/${q}_${cor_type}.tsv
    for i in $input_dir/*$q.tsv.$cor_type ; do
        base=`basename $i`
        method=`echo $base | sed 's/-.*//'`
        score=`cat $i`
        echo -e "$method\t$score"
    done >> $output_dir/${q}_${cor_type}.tsv
done

echo "$script_name done."

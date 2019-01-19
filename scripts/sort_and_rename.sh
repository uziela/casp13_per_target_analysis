#!/bin/bash

# Written by Karolis Uziela in 2019

script_name=`basename $0`

if [ $# != 2 ] ; then
    echo "
Usage: 

$script_name [Parameters]

Parameters:
<input-dir> 
<output_dir>

"
    exit 1
fi

input_dir=$1
output_dir=$2

echo "$script_name started with parameters: $*"

mkdir -p $output_dir

for i in $input_dir/*tsv ; do
    base=`basename $i`
    cat $i | grep -v QQ | sort -rnk 2 | sed s/QA457_2/Wallner/ | sed s/QA139_2/ProQ3D/ | sed s/QA044_2/ProQ2/ | sed s/QA022_2/Pcons/ | sed s/QA187_2/ProQ3/  | sed s/QA360_2/ProQ3D_lDDT/ | sed s/QA198_2/ProQ3D_CAD/  | sed s/QA440_2/ProQ4/ |  sed s/QA359_2/3DCNN/g |     sed s/QA014_2/Bhattacharya-ClustQ/g |      sed s/QA102_2/Bhattacharya-Server/g |      sed s/QA170_2/Bhattacharya-SingQ/g |      sed s/QA471_2/CPClab/g |      sed s/QA349_2/Davis-EMAconsensus/g |      sed s/QA413_2/FALCON-QA/g | sed s/QA027_2/FaeNNz/g |      sed s/QA196_2/Grudinin/g |      sed s/QA065_2/Jagodzinski-Cao-QA/g | sed s/QA344_2/Kiharalab/g |      sed s/QA067_2/LamoureuxLab/g |      sed s/QA146_2/MASS1/g |      sed s/QA415_2/MASS2/g |      sed s/QA197_2/MESHI/g |      sed s/QA289_2/MESHI-enrich-server/g |      sed s/QA347_2/MESHI-server/g |      sed s/QA113_2/MUFold-QA/g | sed s/QA312_2/MUFold_server/g |      sed s/QA243_2/MULTICOM-CONSTRUCT/g |      sed s/QA023_2/MULTICOM-NOVEL/g |      sed s/QA058_2/MULTICOM_CLUSTER/g |      sed s/QA107_2/MUfold-QA2/g | sed s/QA211_2/MUfold-QA-T/g | sed s/QA275_2/ModFOLD7/g |      sed s/QA213_2/ModFOLD7_cor/g |      sed s/QA272_2/ModFOLD7_rank/g |      sed s/QA373_2/ModFOLDclust2/g |      sed s/QA209_2/PLU-Angular-QA/g | sed s/QA134_2/PLU-Top-QA/g | sed s/QA083_2/Pcomb/g |      sed s/QA022_2/Pcons/g |      sed s/QA044_2/ProQ2/g |      sed s/QA187_2/ProQ3/g |      sed s/QA139_2/ProQ3D/g |      sed s/QA198_2/ProQ3D-CAD/g |      sed s/QA267_2/ProQ3D-TM/g |      sed s/QA360_2/ProQ3D-lDDT/g |      sed s/QA440_2/ProQ4/g |      sed s/QA334_2/RaptorX-Deep-QA/g | sed s/QA220_2/SASHAN/g |      sed s/QA135_2/SBROD/g |      sed s/QA207_2/SBROD-plus/g |      sed s/QA364_2/SBROD-server/g |      sed s/QA194_2/UOSHAN/g |      sed s/QA339_2/VoroMQA-A/g | sed s/QA030_2/VoroMQA-B/g | sed s/QA267_2/ProQ3D_TM/ | sed s/QA164_2/Yang-Server/  | sed s/QA171_2/Davis-EMAconsensusAL/  | sed s/QA237_2/MESHI-corr-server/  | sed s/QA463_2/Eagle/ | sed "s/\s+/ /g" > $output_dir/$base
done

echo "$script_name done."

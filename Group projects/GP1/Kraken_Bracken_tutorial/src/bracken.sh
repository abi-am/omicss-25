#!/bin/sh
#SBATCH --job-name="bracken"
#SBATCH --output=log/%x.log
#SBATCH --mem=50GB
#SBATCH --cpus-per-task=16
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=gayane.aydinyan2@gmail.com

echo ""
echo "################################"
echo "###         BRACKEN          ###"
echo "################################"
echo ""

k2_report="kraken/reports"
db="/mnt/kraken_db/k2_standard_20231009/"

if [ ! -d bracken ]; then
    echo "Creating bracken output directory bracken"
    mkdir -p bracken/bracken
    mkdir -p bracken/mpa
    mkdir -p bracken/combined
    wait
else
    echo "WARNING: The output directory bracken already exists. Its content will be overwritten."
fi

echo ""

for f in $k2_report/*_report.txt; do
    filename=$(basename "$f")
    fname="${filename%_report.txt}"
    echo ""
    echo "$f: estimating abundance"
    bracken \
        -d $db \
        -i $f \
        -r 100 \
        -t 10 \
        -o bracken/bracken/${fname}_report.txt
    wait
    success=$?
    if [ $success -eq 0 ]; then
        echo "$fname: successfully classified"
        echo ""
    else
        echo "Bracken finished with non-zero exit status $success for file $fname"
        exit $success
    fi
done

echo "Successfully finished abundance estimation in species level for all files"

echo ""
echo "################################"
echo "###        MPA FORMAT        ###"
echo "################################"
echo ""

kreport2mpa="src/kreport2mpa.py"
combine_mpa="src/combine_mpa.py"

if [ ! -d bracken/mpa ]; then
    echo "Creating mpa output directory mpa_dir"
    mkdir -p bracken/mpa
    wait
else
    echo "WARNING: The output directory mpa already exists. Its content will be overwritten."
fi

echo ""

for f in $k2_report/*_bracken_species.txt; do
    filename=$(basename "$f")
    fname="${filename%_report_bracken_species.txt}"
    python $kreport2mpa \
        -r $f \
        --display-header \
        -o bracken/mpa/${fname}_mpa.txt
done

if [ ! -d bracken/combined ]; then
    echo "Creating bracken species directory combined"
    mkdir -p bracken/combined
    wait
else
    echo "WARNING: The species output directory combined already exists. Its content will be overwritten."
fi

echo ""

python $combine_mpa \
    -i bracken/mpa/*_mpa.txt \
    -o bracken/combined/abundance_species_mpa.txt

sed -i -e 's/_report_bracken_species.txt//g' bracken/combined/abundance_species_mpa.txt

mv kraken/reports/*_report_bracken_species.txt bracken/bracken/
for f in bracken/mpa/*_report_bracken_species.txt_mpa.txt; do
    mv "$f" "${f/_report_bracken_species.txt_mpa.txt/_mpa.txt}"
done

# nanopore
Pipeline for nanopore-based SV detection

Setting up the environment
```bash
module load bioinfo/samtools-1.9
module load system/Python-3.6.3
python3 -m venv nanoporeenv
source nanoporeenv/bin/activate
for line in $(cat requirements.txt)
do
  pip install $line
done
```

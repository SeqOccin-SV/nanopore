# nanopore
Pipeline for nanopore-based SV detection

Setting up the environment
```bash 
module load bioinfo/minimap2-2.11
module load bioinfo/samtools-1.9
module load bioinfo/tabix-0.2.5
module load system/Python-3.6.3
python3 -m venv nanoporeenv
source nanoporeenv/bin/activate
for line in $(cat requirements.txt)
do
  pip install $line
done
```

Running the pipeline
```bash
snakemake --jobs 30 --cluster-config cluster.yaml --drmaa " --mem-per-cpu={cluster.mem}000 --mincpus={threads} --time={cluster.time} -J {cluster.name} -N 1=1" -p -n
```

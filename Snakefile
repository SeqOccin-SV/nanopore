from snakemake.utils import validate

include: "rules/common.smk"

# Traget rule
rule all:
    input:
         expand("variants/{sample}/variants.vcf.gz",
                sample=samples.index)

# Modules
include: "rules/stats.smk"
include: "rules/mapping.smk"
include: "rules/svdetection.smk"



rule minimap:
    input:
        reads=get_reads
    output:
        bam="mapping/{sample}.bam",
        bai="mapping/{sample}.bam.bai",
        flag="mapping/{sample}.bam.flagstat"
    threads:
        20
    resources:
        mem_mb=30
    params:
        genome=config["genome"]
    log:
        "logs/minimap/{sample}.log"
    shell:
        "minimap2 --MD -t {threads} -ax map-ont {params.genome} {input} | "
        "samtools view -bS | "
        "samtools sort -@{threads} -o {output.bam} 2> {log}; "
        "samtools flagstat -@{threads} {output.bam} > {output.flag}; "
        "samtools index {output.bam}"

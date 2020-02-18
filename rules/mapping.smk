

if "reads" in samples.columns:
    rule minimap:
        input:
            reads=get_reads,
            genome=get_genome
        output:
            bam="mapping/{sample}.bam",
            bai="mapping/{sample}.bam.bai",
            flag="mapping/{sample}.bam.flagstat"
        threads:
            get_threads("minimap", 12)
        log:
            "logs/minimap/{sample}.log"
        shell:
            "minimap2 --MD -t {threads} -ax map-ont {input.genome} {input.reads} | "
            "samtools view -bS | "
            "samtools sort -@{threads} -o {output.bam} 2> {log}; "
            "samtools flagstat -@{threads} {output.bam} > {output.flag}; "
            "samtools index {output.bam}"

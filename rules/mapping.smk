

if "reads" in samples.columns:
    rule genomeindex:
        input:
            genome=get_genome
        output:
            minimapindex="minimapindex/genome.mmi"
        shell:
            "minimap2 -x map-ont -d {output.minimapindex} {input.genome}"

    rule minimap:
        input:
            reads=get_reads,
            minimapindex="minimapindex/genome.mmi"
        output:
            bam="mapping/{sample}.bam",
            bai="mapping/{sample}.bam.bai",
            flag="mapping/{sample}.bam.flagstat"
        threads:
            get_threads("minimap", 12)
        log:
            "logs/minimap/{sample}.log"
        shell:
            "minimap2 --MD -t {threads} -a {input.minimapindex} {input.reads} | "
            "samtools view -bS | "
            "samtools sort -@{threads} -o {output.bam} 2> {log}; "
            "samtools flagstat -@{threads} {output.bam} > {output.flag}; "
            "samtools index {output.bam}"

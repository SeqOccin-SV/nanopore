
rule read_stats:
    input:
        reads=get_reads
    output:
        directory("stats/reads/{sample}")
    params:
        readtype=get_read_type
    threads:
        4
    log:
        "logs/stats/reads/{sample}.log"
    shell:
        "NanoPlot --N50 -t {threads} --{params.readtype} {input.reads} "
        " --plots kde dot -o {output} 2> {log}"

rule align_stats:
    input:
        bam="mapping/{sample}.{tool}.bam"
    output:
        directory("stats/align/nanoplot/{sample}.{tool}")
    threads:
        4
    log:
        "logs/stats/align/nanoplot/{sample}.{tool}.log"
    shell:
        "NanoPlot --N50 -t {threads} --bam  {input.bam} "
        " --plots kde dot -o {output} 2> {log}"

rule flagstat:
    input:
        bam="mapping/{sample}.{tool}.bam"
    output:
        "stats/align/{sample}.{tool}.bam.flagstat"
    threads:
        4
    log:
        "logs/stats/align/{sample}.{tool}.flagstat.log"
    shell:
        "samtools flagstat -@{threads} {input} > {output} 2> {log}"

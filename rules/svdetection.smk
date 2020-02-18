
rule svim:
    input:
        get_bam
    output:
        "detectedsv/{sample}/variants.vcf.gz"
    params:
        genome = get_genome,
        outdir = "detectedsv/{sample}"
    shell:
        """
        svim alignment {params.outdir} {input} {params.genome}
        bgzip {params.outdir}/variants.vcf
        """

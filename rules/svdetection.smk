
rule svim:
    input:
        get_bam
    output:
        "variants/{sample}/variants.vcf.gz"
    params:
        genome = get_genome,
        outdir = "variants/{sample}"
    shell:
        """
        svim alignment {params.outdir} {input} {params.genome}
        bgzip {params.outdir}/variants.vcf
        """

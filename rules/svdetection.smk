
svim:
    input:
        "mapping/{sample}.bam"
    output:
        "detectedsv/{sample}/final_results.vcf.gz"
    params:
        genome = config["genome"],
        outdir = "detectedsv/{sample}"
    shell:
        """
        svim {params.outdir} {input} {params.genome}
        bgzip {params.outdir}/final_results.vcf
        """

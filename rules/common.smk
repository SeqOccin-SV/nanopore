

import shutil
import sys
import os
import os.path
import re
import pandas as pd
import numpy as np
import subprocess
from termcolor import colored, cprint
from collections import defaultdict


# Config file and samples sheet
configfile: "config.yaml"
validate(config, schema="../schemas/config.schema.yaml")

print(config["samples"])
samples = pd.read_table(config["samples"], comment='#',
                        dtype={"sample": str}).set_index("sample", drop=False)
validate(samples, schema="../schemas/samples.schema.yaml")

# Wildcard constraints
wildcard_constraints:
    sample="|".join(samples.index)


def print_error_exit(message):
    cprint("WARNING: " + message + ", exiting softly!", 'magenta',
           attrs=['bold'], file=sys.stderr)
    os._exit(1)


def get_genome(wildcards):
    """ the genome file """
    return config["ref"]["genome"]


def get_reads(wildcards):
    """Get fastq files of given sample-unit."""
    return samples.loc[wildcards.sample, "reads"]


def get_bam(wildcards):
    """Get bam file"""
    if 'bam' in samples.columns:
        return samples.loc[wildcards.sample, "bam"]
    return "mapping/%s.bam" % wildcards.sample


def get_read_type(wildcards):
    readfile = samples.loc[wildcards.sample].reads
    readtype = "fasta"
    if re.search('(fastq|fq)(\.gz)?$', readfile):
        readtype = "fastq"
    return readtype


def get_threads(rule, default):
    cluster_config = snakemake.workflow.cluster_config
    if rule in cluster_config and "threads" in cluster_config[rule]:
        return cluster_config[rule]["threads"]
    if "default" in cluster_config and "threads" in cluster_config["default"]:
        return cluster_config["default"]["threads"]
    return default

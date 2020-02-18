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

samples = pd.read_table(config["samples"],
                        dtype={"sample": str}).set_index("sample", drop=False)
validate(samples, schema="../schemas/samples.schema.yaml")


# Wildcard constraints
wildcard_constraints:
    sample="|".join(samples.index)


def print_error_exit(message):
    cprint("WARNING: " + message + ", exiting softly!", 'magenta',
           attrs=['bold'], file=sys.stderr)
    os._exit(1)
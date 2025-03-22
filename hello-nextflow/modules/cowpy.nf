#!/usr/bin/env nextflow



process cowpy {
    container 'community.wave.seqera.io/library/pip_cowpy:8b70095d527cd773'

    publishDir 'results', mode: 'copy'

    input:
    path input_file
    val character


    output:
    path "cowpy-${input_file}"


    script:
    """
    cat $input_file | cowpy -c "$character" > cowpy-${input_file}
    """
}
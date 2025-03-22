#!/usr/bin/env nextflow

/*
 * Use echo to print 'Hello World!' to a file
 */
process sayHello {

    publishDir 'results', mode: 'copy'

    input:
        val greeting

    output:
        path "$greeting-output.txt"

    script:
    """
    echo '$greeting' > '$greeting-output.txt'
    """
}



/*
 * Pipeline parameters
 */
params.greeting = "$launchDir/greetings.csv"

workflow {
    greeting_ch = Channel.fromPath(params.greeting)
                        .view { greeting -> "Before splitCsv: $greeting" }
                        .splitCsv(sep: '\t')
                        .view { greeting -> "After splitCsv: $greeting" }
                        .map { val -> val[0]}
                        .view { greeting -> "After map: $greeting" }

    // emit a greeting
    sayHello(greeting_ch)
}

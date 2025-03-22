#!/usr/bin/env nextflow

process sayHelloToNextflow {

    publishDir "results", mode: "copy", overwrite: true

    input:
        val greeting

    output:
        path 'hello.txt'
    
    script:
    """
    echo "$greeting" > hello.txt
    """

}

params.greeting = "Hej Nextflow!"

workflow {


    greeting_ch = Channel.of("Hello Channels!")

    sayHelloToNextflow(params.greeting)
}
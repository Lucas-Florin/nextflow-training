params.reads = "$projectDir/data/ggal/gut_{1,2}.fq"
params.transcriptome_file = "$projectDir/data/ggal/transcriptome.fa"
params.multiqc = "$projectDir/multiqc"
params.outdir = "results"

// println "reads: $params.reads"
log.info """\
    RNA-Seq Pipeline
    reads:              ${params.reads}
    transcriptome_file: ${params.transcriptome_file}
    multiqc:            ${params.multiqc}
    outdir:             ${params.outdir}

""".stripIndent()

/*
 * define the `index` process that creates a binary index
 * given the transcriptome file
 */
process INDEX {
    cpus 2
    
    input:
    path transcriptome

    output:
    path 'salmon_index'

    script:
    """
    salmon index --threads $task.cpus -t $transcriptome -i salmon_index
    """
}
workflow {
    index_ch = INDEX(params.transcriptome_file)
    index_ch.view()
}
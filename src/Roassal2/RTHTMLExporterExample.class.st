"
A RTHTMLExporterExample is the example class for RTHTMLExporter
"
Class {
	#name : #RTHTMLExporterExample,
	#superclass : #RTObject,
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #example }
RTHTMLExporterExample >> exampleDependencyAnalyzerBuilder [
	
	"self new exampleDependencyAnalyzerBuilder"

	| b |	
	b := RTDependencyAnalyzerBuilder new. 
	b shape circle
				size: [ :cls | cls numberOfMethods max: 5 ];
				fillColor: (Color red alpha: 0.3);
				if: [ :cls | ('TR*' match: cls name)  ] fillColor: (Color purple alpha: 0.3).
	b addClasses: RTObject withAllSubclasses.
	b addClasses: TRObject withAllSubclasses.
	b 
		dependencyFromAllClassesMatching: [ :cls | ('RT*' match: cls name) ] 
		toAllClassesMatching: [ :cls | ('TR*' match: cls name) ].

	b open.
	"This line does the export"
	RTHTMLExporter exportBuilderAsHTML: b title: 'Roassal and Trachel'
]

{ #category : #example }
RTHTMLExporterExample >> exampleMapBuilder [

	"self new exampleMapBuilder"
	| b countries cn |	
	b := RTMapBuilder new.	
		
	countries := RTMapBuilder countriesPopulation select: [ :c | RTSVGPath countries includes: (c at: 1) ].
	
	cn := RTNColorLinearNormalizer
		inContext: (countries collect: [:c | c at: 2])
		lowColor: (Color r:0.8 g:0.8 b:1)
		highColor: (Color r:0 g:0 b:0.3).
	
	b countries: countries named: [ :c | c at: 1 ].
	b color: [ :dic | cn rtValue: (dic at: 2) ].
	b withPopup: [ :c | (c at: 1) asString, ': ',(((c at: 2) / 1000000 asFloat roundTo: 0.001) asString, ' Million') ].
	b open.
	"This line does the export"
	RTHTMLExporter exportBuilderAsHTML: b title: 'World Population'
]

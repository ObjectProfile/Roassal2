"
A RTSVGExporterExample is the example class for RTSVGExporter.
"
Class {
	#name : #RTSVGExporterExample,
	#superclass : #RTObject,
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #example }
RTSVGExporterExample >> exampleDependencyAnalyzerBuilder [
	
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
	RTSVGExporter exportBuilderAsSVG: b filename:'hola'.
]

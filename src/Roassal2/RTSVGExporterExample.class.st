"
A RTSVGExporterExample is the example class for RTSVGExporter.
"
Class {
	#name : #RTSVGExporterExample,
	#superclass : #RTObject,
	#category : 'Roassal2-Exporter-SVG'
}

{ #category : #simple }
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
	RTSVGExporter exportBuilderAsSVG: b filename:'exampleDependencyAnalyzerBuilder'.
]

{ #category : #interactions }
RTSVGExporterExample >> exampleWithDragAndDropHightlightPopup [
	
	"self new exampleWithDragAndDropHightlightPopup"

	| b exporter |	
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
	exporter := RTInteractiveSVGExporter new 
							backgroundColor: Color white;
							builder: b filename: 'Dependencies'; yourself.
	RTSVGHightlight on: exporter color: Color blue targets: TREllipseShape.
	RTSVGDragAndDrop on: exporter targets: TREllipseShape.
	RTSVGTextPopup on: exporter text:#name color: Color black size: 15 targets: TREllipseShape.
	exporter exportToFile.  
]

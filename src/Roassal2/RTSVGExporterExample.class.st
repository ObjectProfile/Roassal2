"
A RTSVGExporterExample is the example class for RTSVGExporter.
"
Class {
	#name : #RTSVGExporterExample,
	#superclass : #RTObject,
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #example }
RTSVGExporterExample >> exampleGraphET [
	
	| diagram |	
	diagram := GETDiagramBuilder new.
	diagram 	horizontalBarDiagram
				models: #(0.2 0.5 2 0.3 0.51 1);
				color: [ :x | x <= 0.5 ifTrue: [ Color blue alpha: 0.2 ] ifFalse: [Color blue alpha: 0.5]];
				valueAxisLine;
				baseAxisLine;
				addValueDecorator: (GETRegularTickDecorator new numberOfTicks: 5);
				addValueDecorator: (GETRotatedLabelDecorator new diagonal numberOfLabels: 5).

	diagram open.
	"This line does the export"
	RTSVGExporter exportBuilderAsSVG: diagram.
]

"
RTLegendBuilderExample new installTitle: 'OnDemand' 
		code:
		'
| l lb |
b := RTMondrian new.
b shape rectangle
	width: [ :c | c numberOfVariables * 5 ];
	height: #numberOfMethods.
b nodes: RTShape withAllSubclasses.
b edges connectFrom: #superclass.
b layout tree.
b normalizer
	normalizeColor: #numberOfLinesOfCode using: { Color black. Color red }.
b build.

lb := RTLegendBuilder new.
lb onDemand.
lb view: b view.

lb addText: ''System complexity view''.
lb addRectanglePolymetricWidth: ''number of methods'' height: ''Line of code'' box: ''a Pharo class''.
lb build.

^ b view'
	
"
Class {
	#name : #RTLegendBuilderExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Legend'
}

{ #category : #sources }
RTLegendBuilderExample >> exampleOnDemand [

| l lb |
b := RTMondrian new.
b shape rectangle
	width: [ :c | c numberOfVariables * 5 ];
	height: #numberOfMethods.
b nodes: RTShape withAllSubclasses.
b edges connectFrom: #superclass.
b layout tree.
b normalizer
	normalizeColor: #numberOfLinesOfCode using: { Color black. Color red }.
b build.

lb := RTLegendBuilder new.
lb onDemand.
lb view: b view.

lb addText: 'System complexity view'.
lb addRectanglePolymetricWidth: 'number of methods' height: 'Line of code' box: 'a Pharo class'.
lb build.

^ b view
]

{ #category : #icons }
RTLegendBuilderExample >> exampleOnDemandIcon [
	^ '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'
]

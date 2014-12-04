"
Examples of HTML exporter
"
Class {
	#name : #RTHTML5ExporterExample,
	#superclass : #RTObject,
	#category : #'Roassal2-Exporter-HTML5'
}

{ #category : #examples }
RTHTML5ExporterExample >> example01 [
	"
	self new example01
	"
	| e view|
	e := RTHTML5Exporter new.
	view := RTView new.
	view canvas color: Color gray.
	RTShape withAllSubclasses do: [ :cls | 
		view add: ((RTBox elementOn: cls)@RTPopup @ RTDraggable)].
	view @ RTDraggableView.
	RTEdge buildEdgesFromObjects: RTShape withAllSubclasses from: #superclass to: #yourself inView: view.
	RTTreeLayout on: view elements.
	
	e export: view.
	view open.
]

{ #category : #examples }
RTHTML5ExporterExample >> exportAll [
	"
	self new exportAll
	"
	"This example is incomplete"
	| e view exporter |
	(self confirm: 'Are you sure to run this example? Warning: Several files are created') ifFalse: [ ^ self ].
 	e := RTRoassalExample new. 
	exporter := RTHTML5Exporter new.
	
	RTRoassalExample methods do: [ :met | (met selector endsWith: 'Icon') ifFalse: [  
		view := e perform: met selector.
		(view isKindOf: RTView) ifTrue: [ 
			exporter fileName: met selector, '.html'.
			exporter title: met selector.
			exporter export: view.
			 ].
	] ] displayingProgress: 'Exporting...'

]

{ #category : #examples }
RTHTML5ExporterExample >> exportExampleCircleLayoutAndEdges [
	| e view|
	e := RTHTML5Exporter new.
	view := RTRoassalExample new perform: #exampleCircleLayoutAndEdges.
	
	e export: view.
]

{ #category : #examples }
RTHTML5ExporterExample >> exportExampleClusterLayout [
	| e view|
	e := RTHTML5Exporter new.
	view := RTRoassalExample new perform: #exampleClusterLayout.
	
	e export: view.
]

{ #category : #examples }
RTHTML5ExporterExample >> exportExampleColoredAndInteractionLabel [
	| e view|
	e := RTHTML5Exporter new.
	view := RTCharterExample new perform: #exampleColoredAndInteractionLabel.
	
	e export: view.
]

{ #category : #examples }
RTHTML5ExporterExample >> exportExampleHappyNewYear [
	| e view|
	e := RTHTML5Exporter new.
	view := RTRoassalExample new perform: #exampleHappyNewYear.
	
	e export: view.
]

{ #category : #examples }
RTHTML5ExporterExample >> exportExampleLabels [
	| e view|
	e := RTHTML5Exporter new.
	view := RTRoassalExample new perform: #exampleLabels.
	
	e export: view.
]

{ #category : #examples }
RTHTML5ExporterExample >> exportExampleLazyFormLoading [
	| e view|
	e := RTHTML5Exporter new.
	view := RTRoassalExample new perform: #exampleLazyFormLoading.
	
	e export: view.
]

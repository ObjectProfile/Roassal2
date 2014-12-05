"
Examples of HTML exporter
"
Class {
	#name : #RTHTML5ExporterExample,
	#superclass : #RTObject,
	#category : #'Roassal2-Exporter-HTML5'
}

{ #category : #private }
RTHTML5ExporterExample >> createIndexFor: aCollection [
	| index stream text |
	index := FileSystem disk workingDirectory / 'index.html'.
	index exists ifTrue: [ index delete ].
	stream := index writeStream.
	[ stream nextPutAll: 
'<!DOCTYPE html>
<html>
	<head>
		<title>Roassal Examples</title>
		<style type="text/css">
			body{
				margin: 0 auto
			}
			h1{
				text-align: center
			}
			iframe{
				left: 50%;
				position: relative;
				margin-left: -400px;
			}
		</style>
	</head>
	<body>
	'.
	
	(aCollection sorted: [ :a :b| a selector <= b selector ]) do: [ :met |
		text := met methodClass name,'-', met selector asString.
		stream nextPutAll: '
	<h1>',text,'</h1>'.
		stream nextPutAll: '
	<iframe width="800" height="800" src="',met methodClass name, '-',met selector,'.html"></iframe>'.
		].
	stream nextPutAll: 
'	</body>
</html>'. ] ensure: [ stream close ].
	^ index.


]

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
	| e view exporter list error |
	(self confirm: 'Are you sure to run this example? Warning: Several files are created') ifFalse: [ ^ self ].
	exporter := RTHTML5Exporter new.
	list := OrderedCollection new.
	(RTAbstractExample subclasses flatCollect: [ :cls | cls methods ])
	do: [ :met | (met selector endsWith: 'Icon') ifFalse: [  
		e := met methodClass new.
		error := false.
		[view := e perform: met selector.] 
		on: Error do: [ :er | error := true ].
		
		((view isKindOf: RTView) and: [ error not ]) ifTrue: [ 
			list add: met.
			exporter fileName: met methodClass name,'-',met selector, '.html'.
			exporter title: met selector.
			exporter export: view.
			 ].
		
	] ] displayingProgress: 'Exporting...'.

	(self createIndexFor: list) asUrl open
	

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

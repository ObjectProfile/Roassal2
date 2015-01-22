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
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript" src="http://objectprofile.com/bjqs.js"></script>
		<link type="text/css" rel="Stylesheet" href="https://raw.githubusercontent.com/jcobb/basic-jquery-slider/master/bjqs.css" />
		<link type="text/css" rel="Stylesheet" href="http://basic-slider.com/css/main.css" />
		
		<style type="text/css">
			body{
				margin: 0 auto
			}
			h1{
				text-align: center
			}
			iframe{
				border: 1px solid lightblue
			}
			img{
				position: absolute;
				top: 50%;
				left: 50%;
				margin-left: -100px;
				width: 200px;
				margin-top: -100px;
				display: none
			}
		</style>
	</head>
	<body><center>
		<div id="my-slideshow">
			<ul class="bjqs">'.
	
	(aCollection sorted: [ :a :b| a selector <= b selector ]) do: [ :met |
		text := met methodClass name,'-', met selector asString.
		stream nextPutAll: '
	<li>
	<h1>',text,'</h1>'.
		stream nextPutAll: '
	<iframe width="800" height="800" ref="',met methodClass name, '-',met selector,'.html"></iframe>
	</li>'.
		].
	stream nextPutAll: 
'			</ul>
		</div>
		<img src="http://bradsknutson.com/wp-content/uploads/2013/04/page-loader.gif" style="display: none;">
	<script type="text/javascript">
		$(document).ready( function(){
			$("#my-slideshow").bjqs({
				height: 900,
				width: 1000,
				responsive: true,
				visiblemarkers: 15,
				animspeed: 8000
			});
		});
	</script>
	</center></body>
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

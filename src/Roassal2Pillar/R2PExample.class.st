Class {
	#name : #R2PExample,
	#superclass : #TestCase,
	#category : #Roassal2Pillar
}

{ #category : #'as yet unclassified' }
R2PExample >> exampleWithRoassal [
	"
	self new exampleWithRoassal
	"

PRHTMLWriter defaultConfigurations anyOne
    inputString: '
!!Example of a factorial
50 factorial =
[[[eval=true
stream nextPutAll: ''""'', 100 factorial asString, ''""''.
]]]


!!Some Roassal visualizations
Here is a small Mondrian example
[[[eval=true

b := RTMondrian new.
b nodes: (1 to: 100).
b layout grid.
b build.

aView := b view.
RTHTML5Exporter new insert: aView named: ''Roassal test'' inPillarStream: stream			
]]]

Another example with Grapher this time:
[[[eval=true
b := RTGrapher new.
b extent: 300 @ 200.

ds := RTStackedDataSet new.
ds interaction popupText.
ds barShape width: 10.
ds points: #(4 5 1 -2 5 6).
b add: ds.
"b axisX noLabel; noTick.
"

b build.

RTHTML5Exporter new insert: b view named: ''A Graph'' inPillarStream: stream
]]]

';
    outputFile: 'myFirstPillarExport.html' asFileReference;
    export
]

{ #category : #'as yet unclassified' }
R2PExample >> exampleWithoutRoassal [

PRHTMLWriter defaultConfigurations anyOne
    inputString: '
!Hello
Some text with *a link to Pharo>http://www.pharo.org*.

fdsd
!!World';
    outputFile: 'myFirstPillarExport.html' asFileReference;
    export
]

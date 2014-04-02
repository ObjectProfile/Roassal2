"
RTInteractiveSVGExporter exists for the sole porpouse of adding interactions, coming from the RTHTMLExporter, smoothly
"
Class {
	#name : #RTInteractiveSVGExporter,
	#superclass : #RTSVGExporter,
	#instVars : [
		'interactions',
		'marginX',
		'marginY'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #svg }
RTInteractiveSVGExporter >> addStart: bounds [
	self interactions do: [ :l | 
		l do: [ :i | 
			i type = 'popup'
				ifTrue:  [ 
					i bounds: bounds.
					marginX := marginX max: i xBound.
					marginY := marginY max: i yBound.
			 	]
		 ]].
	stream
		nextPutAll: '<svg  xmlns="http://www.w3.org/2000/svg" ';
		nextPutAll:  ('width="<1p>px" height="<2p>px" ' expandMacrosWith: ((bounds width + 1 + marginX) rounded) with: ((bounds height + 1 + marginY) rounded));
		nextPutAll: ('style="background-color: rgb(<1p>,<2p>,<3p>);" ' expandMacrosWith: (backgroundColor red * 256) rounded with: (backgroundColor green * 256) rounded with: (backgroundColor blue * 256) rounded );
		nextPutAll: String cr;
		nextPut: Character tab;
		nextPutAll: 'xmlns:xlink="http://www.w3.org/1999/xlink">';
		nextPutAll: String cr
]

{ #category : #exporting }
RTInteractiveSVGExporter >> exportOnStream: fileStream [
	|bounds|
	bounds := self fixedEncompassingRectangle.
	self stream: fileStream.
	self addStart: bounds.
	RTSVGVisitor visit: view on: stream with: self interactions canvas: bounds center: marginX@marginY.
	self addEnd.
]

{ #category : #initialization }
RTInteractiveSVGExporter >> initialize [
	super initialize.
	marginX := 0.
	marginY := 0.
]

{ #category : #accessing }
RTInteractiveSVGExporter >> interactions [
	^ interactions
]

{ #category : #accessing }
RTInteractiveSVGExporter >> interactions: anObject [
	interactions := anObject
]

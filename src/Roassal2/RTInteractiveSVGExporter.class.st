"
RTInteractiveSVGExporter exists for the sole porpouse of adding interactions, coming from the RTHTMLExporter, smoothly
"
Class {
	#name : #RTInteractiveSVGExporter,
	#superclass : #RTSVGExporter,
	#instVars : [
		'interactions',
		'marginX',
		'marginY',
		'paddingX',
		'paddingY',
		'functions',
		'globals',
		'buttons',
		'buttonStart'
	],
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #svg }
RTInteractiveSVGExporter >> addStart: bounds [
	| notChecked |
	notChecked := true.
	stream
		nextPutAll: '<svg  xmlns="http://www.w3.org/2000/svg" '.
	self interactions do: [ :l | 
		l do: [ :i | 
			i type = 'popup'
				ifTrue:  [ 
					i bounds: bounds.
					marginX := marginX max: i xBound.
					marginY := marginY max: i yBound.
			 	].
			((i type beginsWith: 'button') and: [notChecked])
				ifTrue: [ |val|
						val := (TRLabelShape new text: i getName; encompassingRectangle) height.
						paddingY := paddingY max: val. 
						notChecked := false.
					].
			(globals includes:  i class)
					ifFalse: [ 
						i addGlobalHandlers: stream.
						globals add: i class
						]]].		
	stream
		nextPutAll:  ('width="<1p>px" height="<2p>px" ' expandMacrosWith: ((bounds width + 1 + marginX + paddingX) rounded) with: ((bounds height + 1 + marginY + paddingY) rounded));
		nextPutAll: ('style="background-color: rgb(<1p>,<2p>,<3p>);float:left" ' expandMacrosWith: (backgroundColor red * 256) rounded with: (backgroundColor green * 256) rounded with: (backgroundColor blue * 256) rounded );
		nextPutAll: String cr;
		nextPut: Character tab;
		nextPutAll: 'xmlns:xlink="http://www.w3.org/1999/xlink">';
		nextPutAll: String cr;
		nextPutAll: '    <script><![CDATA[';
		nextPutAll: String cr.
		interactions keysAndValuesDo: [ :k :l | l do: [ :i | 
				(functions includes:  i type)
					ifTrue: [ 
						(i type beginsWith: 'button')
							ifTrue: [  
							i addContribution: stream.
						 ]]
					ifFalse: [ 
						i addFunctions: stream.
						functions add: i type
						]]].
	stream				
		nextPutAll: '    ]]></script>';
		nextPutAll: String cr;
		nextPutAll: '<rect id="BackDrop" x="-10%" y="-10%" width="110%" height="110%" fill="none" pointer-events="all" />',String cr;
		nextPutAll: '<svg id="Wrapper"/>',String cr.
	self interactions do: [ :l | 
		l do: [ :i | 
			(i type beginsWith: 'button')
				ifTrue:  [ 
					(buttons includes: i fixedName)
						ifFalse: [ 
							buttonStart := i addSelf: stream startingPoint: buttonStart.
							buttons add: i fixedName.
			 	]]]].	
	stream		
		nextPutAll: String cr
]

{ #category : #exporting }
RTInteractiveSVGExporter >> exportOnStream: fileStream [
	|bounds|
	bounds := self fixedEncompassingRectangle.
	self stream: fileStream.
	self addStart: bounds.
	RTSVGVisitor visit: view on: stream with: self interactions canvas: bounds center: (marginX+paddingX)@(marginY + paddingY).
	self addEnd.
]

{ #category : #initialization }
RTInteractiveSVGExporter >> initialize [
	super initialize.
	interactions := Dictionary new.
	marginX := 0.
	marginY := 0.
	paddingX := 0.
	paddingY := 0.
	functions := OrderedCollection new.
	globals := OrderedCollection new.
	buttons := OrderedCollection new.
	buttonStart  := 0@0.
]

{ #category : #accessing }
RTInteractiveSVGExporter >> interactions [
	^ interactions
]

{ #category : #accessing }
RTInteractiveSVGExporter >> interactions: anObject [
	interactions := anObject
]

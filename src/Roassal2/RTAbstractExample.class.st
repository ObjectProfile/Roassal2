Class {
	#name : #RTAbstractExample,
	#superclass : #RTObject,
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #'as yet unclassified' }
RTAbstractExample >> installOn: aView [
	| el |
	el := (RTLabel new text: (self label)) element.
	el @ RTHighlightable.
	aView add: el
]

{ #category : #'as yet unclassified' }
RTAbstractExample >> installTitle: aTitle code: sourceCode [
	"SourceCode should be a complete example, executable within a workspace"
	
	"
	
	RTRoassalExample new installTitle: 'Bezier' 
		code:
		'| v shape  edge els |
v := RTView new.
shape := RTEllipse new size: 10; color: (Color purple alpha: 0.3).
els := (shape elementsOn: (1 to: 6)) @ RTDraggable.
v addAll: els .
RTHorizontalLineLayout on: v elements.

v elements first translateBy: -50 @ 50.
v elements third translateBy: -10 @ 20.
v elements fifth translateBy: 0 @ -60.
v elements last translateBy: 150 @ 100.

edge := (RTBezierLine new controllingElements: v elements) edgeFrom: els first to: els last.
v add: edge.

v open.
v canvas'
	"
	| canvas icon64Mime stream |
	canvas := (Compiler evaluate: sourceCode).
	
	self class compile: 'example', aTitle, String cr, sourceCode.
	
	stream := WriteStream on: ByteArray new.
	PNGReadWriter 
				putForm: (canvas morph imageForm scaledToSize: 100 @ 100)
				onStream: stream .
	icon64Mime := (Base64MimeConverter mimeEncode: stream contents readStream) contents.
	self class compile: 'example', aTitle, 'Icon', String cr, '	^ ''', icon64Mime, ''''.
	
]

{ #category : #'as yet unclassified' }
RTAbstractExample >> justToTry [


	
	RTRoassalExample new installTitle: 'AnimatedCircle' 
		code:
		'	| nbOfCircles  v shape mousePos |
	nbOfCircles := 25.
	
	mousePos := 50 @ 50.
	v := RTView new.
	shape := RTEllipse new sizeElement: [ :el | ((el position - mousePos) r abs / 3) min: 50 ]; color: (Color blue alpha: 0.4).
	v addAll: (shape elementsOn: (1 to: nbOfCircles)).
	RTGridLayout on: v elements.
	
	v on: TRMouseMove do: [ :evt |  Transcript show: evt positionFromCamera printString; cr . mousePos := evt positionFromCamera. v elements do: #updateShape. v canvas signalUpdate ].
	
	v open.
	v canvas'
	
]

{ #category : #'as yet unclassified' }
RTAbstractExample >> label [
	^ 'fill please'
]

{ #category : #'as yet unclassified' }
RTAbstractExample >> open [

	| v exampleSymbols icon64Mime form element |
	v := RTView new.
	
	exampleSymbols := self class selectors select: [ :symbol | (symbol beginsWith: 'example') and: [ (symbol endsWith: 'Icon') not ] ].
	exampleSymbols do: [ :k |
		icon64Mime := self perform: (k, #Icon) asSymbol.
		form := Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: icon64Mime readStream).
		element := (RTBitmap new form: form) element.
		element @ (RTPopup new text: 'Example ', k).
		element when: TRMouseClick do: [ :evt | (self class >> k) browse ].
		v add: element.
	].

	RTGridLayout new on: v elements.
	
	v open.
	
]

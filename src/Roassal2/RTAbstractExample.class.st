Class {
	#name : #RTAbstractExample,
	#superclass : #RTObject,
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #accessing }
RTAbstractExample >> gtExamples [
	"Return a list of RTEXampleSelection. This is necessary for "
	^ (self class selectors 
			select: [ :symbol | (symbol beginsWith: 'example') and: [ (symbol endsWith: 'Icon') not ] ])	
				collect: [ :symbol | RTExampleSelection new exampleObject: self; selector: symbol ]
]

{ #category : #'instance creation' }
RTAbstractExample >> gtOpenOn: v [
	|  icon64Mime form element  |

	self gtExamples do: [ :anExample |
		icon64Mime := self perform: (anExample selector, #Icon) asSymbol.
		form := Form fromBinaryStream: 
							(Base64MimeConverter mimeDecodeToBytes: icon64Mime readStream).
		element := (RTBitmap new form: form) elementOn: anExample.
		element @ (RTPopup new text: anExample selector asString).
		element @ (RTEventForwarder new eventClass: TRMouseDragging). 
		v add: element ].

	RTGridLayout new on: v elements.
	
]

{ #category : #installing }
RTAbstractExample >> installOn: aView [
	| el |
	el := (RTLabel new text: (self label)) element.
	el @ RTHighlightable.
	aView add: el.
	
	el when: TRMouseClick do: [ :evt |
		aView clean.
		self openOn: aView.
		aView canvas camera focusOnCenter.
	].

]

{ #category : #installing }
RTAbstractExample >> installTitle: aTitle code: sourceCode [
	"SourceCode should be a complete example, executable within a workspace"
	
	| viewOrBuilder canvas icon64Mime stream window | 
	viewOrBuilder := (Compiler evaluate: sourceCode).
	window := viewOrBuilder open.
	viewOrBuilder class == RTView 
		ifTrue: [ canvas := viewOrBuilder canvas ]
		ifFalse: [ canvas := viewOrBuilder view canvas ].
	
	canvas morph ifNil: [ self error: 'You have forgotten to open the view!' ].
	
	(self class methodDict includesKey: ('example', aTitle) asSymbol)
		ifTrue: [ self error: 'Title already used. Proceed to override' ].
	
	self class compile: 'example', aTitle, String cr, sourceCode classified: 'sources'.
	
	stream := WriteStream on: ByteArray new.
	PNGReadWriter 
				putForm: (canvas morph imageForm scaledToSize: 100 @ 100)
				onStream: stream .
	icon64Mime := (Base64MimeConverter mimeEncode: stream contents readStream) contents.
	self class compile: 'example', aTitle, 'Icon', String cr, '	^ ''', icon64Mime, '''' classified: 'icons'.
	window delete.
]

{ #category : #installing }
RTAbstractExample >> justToTry [


	
	RTGraphBuilderExample new installTitle: 'ForceLayoutWithGreatCharge' 
		code:
		'


	| b |
	b := RTGraphBuilder new.
	b nodes
		shape: (RTEllipse new size: #numberOfMethods);
		whenOverShowEdges: [ :cls | cls dependentClasses ].

	b edges
		connectTo: [ :c | c subclasses ];
		shape: (RTLine new color: Color gray).

	b layout 
		use: (RTForceBasedLayout new charge: -180).

	b global
		minSize: 10;
		normalizeColor: [ :cls | cls methods size ] using: (Array with: Color green with: Color red).

	b addAll: (RTObject withAllSubclasses).
	b open.
	b view canvas'
	
]

{ #category : #accessing }
RTAbstractExample >> label [
	^ 'fill please'
]

{ #category : #'instance creation' }
RTAbstractExample >> open [

	| v |
	v := RTView new.
	v @ RTDraggableView.
	self openOn: v.
	v open.
	
]

{ #category : #'instance creation' }
RTAbstractExample >> openOn: v [

	| exampleSymbols icon64Mime form element  helpBar |

	exampleSymbols := self class selectors 
								select: [ :symbol | (symbol beginsWith: 'example') 
															and: [ (symbol endsWith: 'Icon') not ] ].
	exampleSymbols do: [ :k |
		icon64Mime := self perform: (k, #Icon) asSymbol.
		form := Form fromBinaryStream: 
							(Base64MimeConverter mimeDecodeToBytes: icon64Mime readStream).
		element := (RTBitmap new form: form) element.
		element @ (RTPopup new text: k asString).
		element when: TRMouseLeftClick do: [ :evt | self class new perform: k ].
		element when: TRMouseRightClick do: [ :evt | (self class >> k) browse ].
		element @ (RTEventForwarder new eventClass: TRMouseDragging). 
		v add: element.
	].

	RTGridLayout new on: v elements.
	
	v canvas addMenu: 'back' callback: [ self pressedBackButtonOn: v ].
	helpBar := TRLabelShape new text: ' Left to run / Right for code'.
	v canvas addFixedShape: helpBar.
	TRConstraint stickAtTheBottomOfTheWindow: helpBar.
	
]

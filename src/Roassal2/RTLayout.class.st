"
A ROLayout is the superclass of all.

Instance Variables
	affectedNodes:		<Object>
	currentIteraction:		<Object>
	eventHandler:		<Object>
	maxInterations:		<Object>
	translator:		<Object>

affectedNodes
	- xxxxx

currentIteraction
	- xxxxx

eventHandler
	- xxxxx

maxInterations
	- xxxxx

translator
	- xxxxx

"
Class {
	#name : #RTLayout,
	#superclass : #RTObject,
	#instVars : [
		'affectedNodes',
		'translator',
		'eventHandler',
		'currentIteraction',
		'maxInterations',
		'iterationsToSendEvent',
		'paddingLeft',
		'paddingRight',
		'paddingTop'
	],
	#category : #'Roassal2-Layouts'
}

{ #category : #public }
RTLayout class >> isAbstract [
	^ self name =  #ROLayout
]

{ #category : #public }
RTLayout class >> isNotAbstract [
	^ self isAbstract not
]

{ #category : #public }
RTLayout class >> on: aCollection [
	"main entry point of the class"
	
	"If aCollection is empty, then there is not much to do"
	aCollection isEmpty ifTrue: [ ^ aCollection ].
	self new applyOn: aCollection.
	^ aCollection
]

{ #category : #public }
RTLayout class >> on: elements edges: edges [
	"To make all the layout polymorphic"
	
	^ self on: elements 
]

{ #category : #public }
RTLayout class >> onElement: aRoassalViewOrRoassalElement [

	^ self on: aRoassalViewOrRoassalElement elements
]

{ #category : #public }
RTLayout class >> onView: aRoassalView [

	^ self on: aRoassalView elements
]

{ #category : #events }
RTLayout >> announce: anEvent [
	"trigger an event. Objects who registered to me will get notified"

	| eventToBeSent |
	eventToBeSent := anEvent isBehavior 
						ifTrue: [ anEvent new ]
						ifFalse: [ anEvent ]. 
	
	eventToBeSent layout: self.
	eventHandler announce: eventToBeSent
]

{ #category : #hook }
RTLayout >> applyOn: elements [
	"Return quickly if there is nothing to do"
	elements isEmpty ifTrue: [ ^ self ].
	self executeOnElements: elements
]

{ #category : #configuration }
RTLayout >> defaultIterationsToSendEvent [
	"Every 100 steps an event ROLayoutStep is sent"

	^ 100
]

{ #category : #hook }
RTLayout >> doExecute: elements [
	"Performs the layout"

	self subclassResponsibility
]

{ #category : #hook }
RTLayout >> doInitialize: elements [
	"Method executed before beginning the layout. Useful when the graph to be ordered need to be prepared"
	"self announce: (ROLayoutBegin new elements: elements)."
]

{ #category : #hook }
RTLayout >> doPost: elements [
	"Method executed after performing the layout"
	"self announce: (ROLayoutEnd new elements: elements)."
]

{ #category : #accessing }
RTLayout >> executeOnElements: elements [ 
	"Execute the layout, myself, on the elements"
		
	maxInterations := elements size.
	self doInitialize: elements.
	self doExecute: elements asOrderedCollection.
	self doPost: elements.

]

{ #category : #utils }
RTLayout >> fatherOf: aNode [
	^ aNode attributes at: #father
]

{ #category : #utils }
RTLayout >> fatherOf: aNode put: aValue [
	aNode attributes at: #father put: aValue
]

{ #category : #'initialize-release' }
RTLayout >> initialize [
	translator := RTLayoutTranslator default.
	eventHandler := Announcer new.
	currentIteraction := 0.
	maxInterations := 0.
	iterationsToSendEvent := self defaultIterationsToSendEvent.
	
	paddingLeft := 5.
	paddingRight := 5.
	paddingTop := 5
]

{ #category : #accessing }
RTLayout >> iterationsToSendEvent [
	"This method return the amount of iterations before sending ROLayoutStep"
	^ iterationsToSendEvent
]

{ #category : #accessing }
RTLayout >> iterationsToSendEvent: anInteger [
	iterationsToSendEvent := anInteger
]

{ #category : #utils }
RTLayout >> layerOf: aNode [
	^ aNode attributes at: #layout
]

{ #category : #utils }
RTLayout >> layerOf: aNode put: aValue [
	aNode attributes at: #layout put: aValue
]

{ #category : #utils }
RTLayout >> leftContourOf: aNode [
	^ aNode attributes at: #leftContour ifAbsent: [ ^ nil ]
]

{ #category : #utils }
RTLayout >> leftContourOf: aNode put: aValue [
	aNode attributes at: #leftContour put: aValue
]

{ #category : #utils }
RTLayout >> modOf: aNode [
	^ aNode attributes at: #mod ifAbsent: [ ^ 0 ]

]

{ #category : #utils }
RTLayout >> modOf: aNode put: aFloat [
	aNode attributes at: #mod put: aFloat

]

{ #category : #hook }
RTLayout >> on: elements [
	self applyOn: elements
]

{ #category : #events }
RTLayout >> on: eventClass do: aBlock [
	"Register a block as an handler for eventClass"
	
	eventHandler when: eventClass do: aBlock.
]

{ #category : #hook }
RTLayout >> on: elements edges: edges [
	self applyOn: elements
]

{ #category : #accessing }
RTLayout >> paddingLeft [
	^ paddingLeft
]

{ #category : #accessing }
RTLayout >> paddingLeft: anInteger [
	paddingLeft := anInteger
]

{ #category : #padding }
RTLayout >> paddingLeftFor: elements [
	^ paddingLeft
]

{ #category : #accessing }
RTLayout >> paddingRight [
	^ paddingRight
]

{ #category : #accessing }
RTLayout >> paddingRight: anInteger [
	paddingRight := anInteger
]

{ #category : #accessing }
RTLayout >> paddingTop [
	^ paddingTop
]

{ #category : #accessing }
RTLayout >> paddingTop: anInteger [
	paddingTop := anInteger
]

{ #category : #padding }
RTLayout >> paddingTopFor: elements [
	^ paddingTop
]

{ #category : #utils }
RTLayout >> pointerOf: aNode [

	^ aNode attributes at: #pointer ifAbsent: [ ^ nil ]
]

{ #category : #utils }
RTLayout >> pointerOf: aNode put: aValue [

	^ aNode attributes at: #pointer put: aValue
]

{ #category : #utils }
RTLayout >> rOf: aNode [ 
	^ aNode attributes at: #r ifAbsent: [ 0 ]
	
]

{ #category : #utils }
RTLayout >> rOf: aNode put: aValue [
	^ aNode attributes at: #r put: aValue
]

{ #category : #utils }
RTLayout >> rightContourOf: aNode [
	^ aNode attributes at: #rightContour ifAbsent: [ ^ nil ]
]

{ #category : #utils }
RTLayout >> rightContourOf: aNode put: aValue [
	aNode attributes at: #rightContour put: aValue
]

{ #category : #events }
RTLayout >> step [
"	currentIteraction := currentIteraction + 1.
	(currentIteraction \\ self iterationsToSendEvent) = 0 
		ifTrue: [ self announce: (ROLayoutStep new 
											currentIteration: currentIteraction;
											maxInterations: maxInterations) ].
	"
]

{ #category : #utils }
RTLayout >> thetaOf: aNode [
	^ aNode attributes at: #theta ifAbsent: [ ^ 0 ]
]

{ #category : #utils }
RTLayout >> thetaOf: aNode put: aValue [
	^ aNode attributes at: #theta put: aValue
]

{ #category : #accessing }
RTLayout >> translator [
	^ translator
]

{ #category : #accessing }
RTLayout >> translator: t [
	translator := t
]

{ #category : #utils }
RTLayout >> xOf: aNode [ 
	^ aNode attributes at: #x ifAbsent: [ 0 ]
]

{ #category : #utils }
RTLayout >> xOf: aNode put: aValue [
	aNode attributes at: #x put: aValue
]

Class {
	#name : #PCPPFunction,
	#superclass : #PCPPObject,
	#instVars : [
		'fileId',
		'id',
		'incomingCalls',
		'outgoingCalls',
		'signature',
		'startLineNo',
		'type'
	],
	#category : #ProfilerCPP
}

{ #category : #'as yet unclassified' }
PCPPFunction class >> annotation [
	<MSEClass: #PCPPFunction super: #PCPPObject>
	<package: #ProfilerCPP>
	^ self

]

{ #category : #adding }
PCPPFunction >> addIncomingCall: aCall [
	"Add an incoming call to the function"
	incomingCalls add: aCall
]

{ #category : #adding }
PCPPFunction >> addOutgoingCall: aCall [
	"Add an outgoing call to the function"
	outgoingCalls add: aCall
]

{ #category : #accessing }
PCPPFunction >> fileId [
	<MSEProperty: #fileId type: #String>
	<derived>
	<MSEComment: 'File path where I am defined'>

	^ fileId
]

{ #category : #accessing }
PCPPFunction >> fileId: anObject [
	fileId := anObject
]

{ #category : #testing }
PCPPFunction >> hasBeenExecuted [
	<MSEProperty: #hasBeenExecuted type: #Boolean>
	<derived>
	<MSEComment: 'Whether I have been executed'>

	"Return true if the function has been executed"
	^ (self numberOfIncomingCalls + self numberOfOutgoingCalls) > 0
]

{ #category : #accessing }
PCPPFunction >> id [
	<MSEProperty: #id type: #Number>
	<derived>
	<MSEComment: 'My SQL Id'>
	^ id
]

{ #category : #accessing }
PCPPFunction >> id: anInteger [
	self assert: [ anInteger class == 0 class ].
	id := anInteger
]

{ #category : #accessing }
PCPPFunction >> incomingCalls [
	<MSEProperty: #incomingCalls type: #PCPPCall opposite: #calledFunction>
	<derived> 
	<multivalued>
	<MSEComment: 'Incoming calls'>
	
	"Return the list of outoing calls"
	^ incomingCalls
]

{ #category : #'as yet unclassified' }
PCPPFunction >> incomingFunctions [
	<MSEProperty: #incomingFunctions type: #PCPPFunction>
	<derived> 
	<multivalued>
	<MSEComment: 'Incoming functions'>
	
	"Return the list of outoing calls"
	^ self 
		lookUpPropertyNamed: #outgoingFunctions 
		computedAs: [ PCPPFunctionGroup new addAll:(self incomingCalls collect: #callingFunction) asSet ]
]

{ #category : #'as yet unclassified' }
PCPPFunction >> incomingOtherFunctions [
	"Return the list of outoing calls. Exclude self call."
	^ ((self incomingCalls collect: #callingFunction) asSet asArray copyWithout: self)
]

{ #category : #initialization }
PCPPFunction >> initialize [
	"Constructor"
	super initialize.
	incomingCalls := OrderedCollection new.
	outgoingCalls := OrderedCollection new.

]

{ #category : #'as yet unclassified' }
PCPPFunction >> isFunction [
	^ true
]

{ #category : #'as yet unclassified' }
PCPPFunction >> mooseNameOn: aStream [ 

	self signature isNil
		ifTrue: [ aStream nextPutAll: 'unkown' ]
		ifFalse: [ aStream nextPutAll: self signature ]
]

{ #category : #'as yet unclassified' }
PCPPFunction >> numberOfIncomingCalls [
	<MSEProperty: #numberOfIncomingCalls type: #Number>
	<derived>
	<MSEComment: 'Number of Incoming calls'>
	^ self incomingCalls size
]

{ #category : #'as yet unclassified' }
PCPPFunction >> numberOfOutgoingCalls [
	<MSEProperty: #numberOfOutgoingCalls type: #Number>
	<derived>
	<MSEComment: 'Number of Outgoing calls'>
	^ self outgoingCalls size
]

{ #category : #accessing }
PCPPFunction >> outgoingCalls [
	<MSEProperty: #outgoingCalls type: #PCPPCall opposite: #callingFunction>
	<derived> 
	<multivalued>
	<MSEComment: 'Outgoing calls'>
	
	"Return the list of outoing calls"
	^ outgoingCalls
]

{ #category : #'as yet unclassified' }
PCPPFunction >> outgoingFunctions [
	<MSEProperty: #outgoingFunctions type: #PCPPFunction>
	<derived> 
	<multivalued>
	<MSEComment: 'Outgoing functions'>
	
	"Return the list of outoing calls"
	^ self 
		lookUpPropertyNamed: #outgoingFunctions 
		computedAs: [ PCPPFunctionGroup new addAll: (self outgoingCalls collect: #calledFunction) asSet ]
]

{ #category : #'as yet unclassified' }
PCPPFunction >> outgoingOtherFunctions [
	"Return the list of outoing calls. Exclude self call."
	^ (self outgoingCalls collect: #calledFunction) asSet asArray copyWithout: self

]

{ #category : #accessing }
PCPPFunction >> signature [
	<MSEProperty: #signature type: #String>
	<derived>
	<MSEComment: 'Function signature'>
	^ signature
]

{ #category : #accessing }
PCPPFunction >> signature: aString [
	self assert: [ aString class == 'hello world' class ].
	signature := aString
]

{ #category : #accessing }
PCPPFunction >> startLineNo [
	^ startLineNo
]

{ #category : #accessing }
PCPPFunction >> startLineNo: anInteger [
	self assert: [ anInteger class == 0 class ].
	startLineNo := anInteger
]

{ #category : #accessing }
PCPPFunction >> totalExecutionTime [
	<MSEProperty: #totalExecutionTime type: #Number>
	<derived> 
	<MSEComment: 'Total execution time (sum of all the direct outgoing calls)'>
	
	"Return the list of outoing calls"
	outgoingCalls ifEmpty: [ ^ 0 ].
	^ (outgoingCalls collect: #timeToExecute) sum
]

{ #category : #accessing }
PCPPFunction >> type [
	^ type
]

{ #category : #accessing }
PCPPFunction >> type: anObject [
	type := anObject
]

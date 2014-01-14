Class {
	#name : #RTShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'shape'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #shapes }
RTShapeBuilder >> circle [
	^ self shape: RTEllipse new
]

{ #category : #'reflective operations' }
RTShapeBuilder >> doesNotUnderstand: aMessage [
	"we simply forward the messages we do not understand
	to the actual shape implementation"
	^ self shape 
		perform: aMessage selector 
		withArguments: aMessage arguments
]

{ #category : #building }
RTShapeBuilder >> elementOn: object [
	self hasSetShape ifFalse: [ self rectangle ].
	^ shape elementOn: object
]

{ #category : #building }
RTShapeBuilder >> elementsOn: objects [
	self hasSetShape ifFalse: [ self rectangle ].
	^ shape elementsOn: objects
]

{ #category : #testing }
RTShapeBuilder >> hasSetShape [
	^ shape class ~~ RTNoShape
]

{ #category : #shapes }
RTShapeBuilder >> if: conditionBlock fillColor: colorBlock [
	"If conditionBlock is evaluated at true, then colorBlock is used to set the color of the node. Both conditionBlock and colorBlock are evaluated with the model value of the node."

	| oldBlockOrValue |
	oldBlockOrValue := self fillColor.
	^self fillColor: [ :aModel | (conditionBlock roValue: aModel)
									ifTrue: [ colorBlock roValue: aModel ] 
									ifFalse: [ 
										"Having to create a new element is rather ugly. 
										Ideally, the oldBlockOrValue has to be 'unwrapped' for the translation"
										oldBlockOrValue roValue: (ROElement on: aModel) ]].
							
						

]

{ #category : #initialization }
RTShapeBuilder >> initialize [
	self reset
]

{ #category : #shapes }
RTShapeBuilder >> line [
	^ self shape: RTLine new
]

{ #category : #shapes }
RTShapeBuilder >> rectangle [
	^ self shape: RTBox new
]

{ #category : #accessing }
RTShapeBuilder >> reset [
	shape := RTNoShape instance
]

{ #category : #accessing }
RTShapeBuilder >> shape [
	"Return the shape currently built"
	^ shape
]

{ #category : #accessing }
RTShapeBuilder >> shape: aRoassalShape [
	shape := aRoassalShape.
	
]

{ #category : #shapes }
RTShapeBuilder >> withText [
	shape := RTLabel new + shape
]

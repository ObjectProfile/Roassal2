Class {
	#name : #RTShapeBuilder,
	#superclass : #RTObject,
	#instVars : [
		'shape'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #shapes }
RTShapeBuilder >> arc [
	^ self shape: RTArc new
]

{ #category : #shapes }
RTShapeBuilder >> circle [
	^ self shape: RTEllipse new
]

{ #category : #accessing }
RTShapeBuilder >> current [
	"Return the shape currently built"
	^ shape
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
RTShapeBuilder >> edgeFrom: element1 to: element2 [
	self hasSetShape ifFalse: [ self line ].
	^ shape edgeFrom: element1 to: element2
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

{ #category : #shapes }
RTShapeBuilder >> ellipse [
	shape := RTEllipse new
]

{ #category : #testing }
RTShapeBuilder >> hasSetShape [
	^ shape class ~~ RTNoShape
]

{ #category : #shapes }
RTShapeBuilder >> if: conditionBlock borderColor: colorBlock [
	"If conditionBlock is evaluated at true, then colorBlock is used to set the color of the node. Both conditionBlock and colorBlock are evaluated with the model value of the node."
	| oldBlockOrValue |
	oldBlockOrValue := self borderColor.
	^self borderColor: [ :aModel | (conditionBlock rtValue: aModel)
									ifTrue: [ colorBlock rtValue: aModel ] 
									ifFalse: [ 
										"Having to create a new element is rather ugly. 
										Ideally, the oldBlockOrValue has to be 'unwrapped' for the translation"
										oldBlockOrValue rtValue: (RTElement on: aModel) ]].
							
						

]

{ #category : #shapes }
RTShapeBuilder >> if: conditionBlock fillColor: colorBlock [
	"If conditionBlock is evaluated at true, then colorBlock is used to set the color of the node. Both conditionBlock and colorBlock are evaluated with the model value of the node."
	| oldBlockOrValue |
	oldBlockOrValue := self fillColor.
	^self fillColor: [ :aModel | (conditionBlock rtValue: aModel)
									ifTrue: [ colorBlock rtValue: aModel ] 
									ifFalse: [ 
										"Having to create a new element is rather ugly. 
										Ideally, the oldBlockOrValue has to be 'unwrapped' for the translation"
										oldBlockOrValue rtValue: (RTElement on: aModel) ]].
							
						

]

{ #category : #shapes }
RTShapeBuilder >> ifElement: conditionBlock borderColor: colorBlock [
	"If conditionBlock is evaluated at true, then colorBlock is used to set the color of the node. Both conditionBlock and colorBlock are evaluated with the model value of the node."
	| oldBlockOrValue |
	oldBlockOrValue := self borderColor.
	^self borderColorElement: [ :anElement | (conditionBlock rtValue: anElement)
									ifTrue: [ colorBlock rtValue: anElement ] 
									ifFalse: [ 
										"Having to create a new element is rather ugly. 
										Ideally, the oldBlockOrValue has to be 'unwrapped' for the translation"
										oldBlockOrValue rtValue: anElement ]].
							
						

]

{ #category : #shapes }
RTShapeBuilder >> ifElement: conditionBlock fillColor: colorBlock [
	"If conditionBlock is evaluated at true, then colorBlock is used to set the color of the node. Both conditionBlock and colorBlock are evaluated with the model value of the node."
	| oldBlockOrValue |
	oldBlockOrValue := self fillColor.
	^self fillColorElement: [ :anElement | (conditionBlock rtValue: anElement)
									ifTrue: [ colorBlock rtValue: anElement ] 
									ifFalse: [ 
										"Having to create a new element is rather ugly. 
										Ideally, the oldBlockOrValue has to be 'unwrapped' for the translation"
										oldBlockOrValue rtValue: anElement ]].
							
						

]

{ #category : #initialization }
RTShapeBuilder >> initialize [
	self reset
]

{ #category : #shapes }
RTShapeBuilder >> label [
	shape := RTLabel new
]

{ #category : #shapes }
RTShapeBuilder >> line [
	^ self shape: RTLine new
]

{ #category : #copying }
RTShapeBuilder >> postCopy [
	super postCopy.
	shape := shape copy.
]

{ #category : #shapes }
RTShapeBuilder >> rectangle [
	^ self shape: RTBox new
]

{ #category : #accessing }
RTShapeBuilder >> reset [
	shape := RTNoShape instance
]

{ #category : #building }
RTShapeBuilder >> setUpElements: elements [
	self hasSetShape ifFalse: [ self rectangle ].
	^ elements + shape
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
RTShapeBuilder >> text [
	shape := RTLabel new
]

{ #category : #shapes }
RTShapeBuilder >> withBorder [
	self borderColor: Color black
]

{ #category : #shapes }
RTShapeBuilder >> withText [
	shape := shape + RTLabel new
]

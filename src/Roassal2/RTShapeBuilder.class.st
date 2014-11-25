Class {
	#name : #RTShapeBuilder,
	#superclass : #RTScopedBuilder,
	#instVars : [
		'shape',
		'createdElements'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #shapes }
RTShapeBuilder >> arc [
	^ self shape: RTArc new
]

{ #category : #'shape - edges' }
RTShapeBuilder >> arrowedLine [
	^ self shape: RTArrowedLine new
]

{ #category : #shapes }
RTShapeBuilder >> circle [
	^ self shape: RTEllipse new
]

{ #category : #accessing }
RTShapeBuilder >> createdElements [
	^ createdElements
]

{ #category : #shapes }
RTShapeBuilder >> cross [
	| s |
	s := RTMultiCompositeShape new.
	s add: (RTBox new height: 10; width: 3). 
	s add: (RTBox new height: 3; width: 10).

	^ self shape: s
]

{ #category : #accessing }
RTShapeBuilder >> current [
	"Return the shape currently built"
	^ shape
]

{ #category : #'shape - edges' }
RTShapeBuilder >> directedLine [
	^ self shape: RTDirectedLine new
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
	^ (self elementsOn: (RTGroup with: object)) first
]

{ #category : #building }
RTShapeBuilder >> elementsOn: objects [
	| answer |
	self hasSetShape ifFalse: [ self rectangle ].
	answer := shape elementsOn: objects.
	createdElements addAll: answer.
	^ answer
]

{ #category : #shapes }
RTShapeBuilder >> ellipse [
	shape := RTEllipse new
]

{ #category : #shapes }
RTShapeBuilder >> ensure: aClassShape [
	"Make sure the current shape is instance of aClassShapeName. If no, then set it"
	(shape isKindOf: aClassShape)
		ifFalse: [ shape := aClassShape new ]
]

{ #category : #shapes }
RTShapeBuilder >> extensibleLabel [
	^ self shape: RTExtensibleLabel new
]

{ #category : #'text shape' }
RTShapeBuilder >> fontSize: aValueOrASymbolOrABlock [
	"Make sure we have something that this message is meaningful"
	self assert: [ #(RTLabel RTMultiCompositeShape) includes: shape class name ].
	
	shape class == RTLabel ifTrue: [ shape height: aValueOrASymbolOrABlock. ^ self ].
	shape class == RTMultiCompositeShape ifTrue: [ (shape allShapes select: [ :s | s class == RTLabel ]) do: [ :s | s height: aValueOrASymbolOrABlock ] ]
]

{ #category : #'shape - edges' }
RTShapeBuilder >> gradientLineFrom: fromColor to: toColor [
	^ self shape: (RTGradientColoredLine new colors: (Array with: fromColor with: toColor); precision: 100; gradientColorShape)
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
RTShapeBuilder >> if: conditionBlock color: colorBlock [
	| oldBlockOrValue |
	oldBlockOrValue := self color.
	^self color: [ :aModel | (conditionBlock rtValue: aModel)
									ifTrue: [ colorBlock rtValue: aModel ] 
									ifFalse: [ 
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
	super initialize.
	self reset.
 
]

{ #category : #shapes }
RTShapeBuilder >> label [
	shape := RTLabel new
]

{ #category : #shapes }
RTShapeBuilder >> labelledAs: aBlock [
	| label oldShape |
	label := RTLabel new text: aBlock.
	oldShape := shape.
	shape := RTMultiCompositeShape new.
	shape add: oldShape.
	shape add: label.
	
	shape vertical.
	^ label
]

{ #category : #'shape - edges' }
RTShapeBuilder >> line [
	^ self shape: RTLine new
]

{ #category : #shapes }
RTShapeBuilder >> linearFillColor: block within: groupOfObjects [
	"Set the linear fill color for the nodes. The gradient goes from white to black. anObject could be a symbol, a block or a value. anObject is evaluated against the model of the node to be paint. aGroup is a collection of the model values. This is where the maximum is looked into."
	
	| max |
	"If the collection is empty, then we return an arbitrary color. 
	 If the script is properly done, the color should not be used"
	groupOfObjects isEmpty ifTrue: [ ^ Color red ].
	
	max := groupOfObjects maxValue: block.
	self current color: [ :v | Color grayScale256: 256 - ((block rtValue: v) max: max in: (1 to: 256)) ]
]

{ #category : #shapes }
RTShapeBuilder >> noBorder [
	self borderColor: Color transparent
]

{ #category : #shapes }
RTShapeBuilder >> orthoHorizontalLine [
	^ self shape: RTMultiLine new orthoHorizontal 
]

{ #category : #shapes }
RTShapeBuilder >> orthoVerticalLine [
	^ self shape: RTMultiLine new orthoVertical
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
	self resetShape.
	self resetCreatedElements
]

{ #category : #accessing }
RTShapeBuilder >> resetCreatedElements [
	createdElements := OrderedCollection new
]

{ #category : #accessing }
RTShapeBuilder >> resetShape [
	shape := RTNoShape instance
]

{ #category : #building }
RTShapeBuilder >> setUpElement: anElement [
	self hasSetShape ifFalse: [ self rectangle ].
	^ anElement + shape
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
	^ self withText: #yourself
]

{ #category : #shapes }
RTShapeBuilder >> withText: aSymbolOrABlock [
	shape := shape + (RTLabel new text: aSymbolOrABlock).
	^ shape
]

{ #category : #shapes }
RTShapeBuilder >> withTextAbove [
	^ self withTextAbove: #yourself
]

{ #category : #shapes }
RTShapeBuilder >> withTextAbove: aSymbolOrABlock [
	| newShape |
	newShape := RTMultiCompositeShape new.
	newShape add: (RTLabel new text: aSymbolOrABlock).
	newShape add: shape.
	newShape vertical.
	newShape setAutomaticRelayout.
	shape := newShape.
]

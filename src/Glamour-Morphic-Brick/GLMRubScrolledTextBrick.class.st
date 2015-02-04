"
A GLMRubScrolledTextBrick is a wrapper for rubric scrolled text morph, to allow simple integration of rubric text field in brick

Instance Variables
	rubricMorph:		<Object>

rubricMorph
	- xxxxx

"
Class {
	#name : #GLMRubScrolledTextBrick,
	#superclass : #GLMMorphBrick,
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #'reflective operations' }
GLMRubScrolledTextBrick >> doesNotUnderstand: aMessage [
	^ self rubric
		perform: aMessage selector 
		withArguments: aMessage arguments
]

{ #category : #initialization }
GLMRubScrolledTextBrick >> initialize [
	super initialize.
	
	self rubric: self newRubricMorph
]

{ #category : #'instance creation' }
GLMRubScrolledTextBrick >> newRubricMorph [

	^ RubScrolledTextMorph new
]

{ #category : #'brick-properties-events' }
GLMRubScrolledTextBrick >> onThemerChanged [

	self updateStyle
]

{ #category : #accessing }
GLMRubScrolledTextBrick >> rubric [

	^ self morph
]

{ #category : #accessing }
GLMRubScrolledTextBrick >> rubric: aMorph [

	self morph ifNotNil: [ self removeMorph: self morph ].
	self on: aMorph
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricBackgroundColor [

	^ self valueOfProperty: #brickRubricBackgroundColor ifAbsent: [ self themer rubricBackgroundColor ]
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricBackgroundColor: aColor [

	self setProperty: #brickRubricBackgroundColor toValue: aColor.
	self updateStyle
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricBorderColor [

	^ self valueOfProperty: #brickRubricBorderColor ifAbsent: [ self themer rubricBorderColor ]
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricBorderColor: aColor [

	self setProperty: #brickRubricBorderColor toValue: aColor.
	self updateStyle
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricBorderWidth [

	^ self valueOfProperty: #brickRubricBorderWidth ifAbsent: [ self themer rubricBorderWidth ]
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricBorderWidth: aColor [

	self setProperty: #brickRubricBorderWidth toValue: aColor.
	self updateStyle
]

{ #category : #'rubric-updating' }
GLMRubScrolledTextBrick >> updateStyle [

	self rubric color: self rubricBackgroundColor.
	self rubric borderColor: self rubricBorderColor.
	self rubric borderWidth: self rubricBorderWidth
]

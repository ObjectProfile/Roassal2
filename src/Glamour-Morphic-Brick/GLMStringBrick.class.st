"
A GLMStringBrick is low level String Brick. Text can't be drawn outside of Brick's bounds, which makes it very usefull for smart text shrinking.

Instance Variables
	familyName:		<Object>
	font:		<Object>
	fontSize:		<Object>
	text:		<Object>
	textColor:		<Object>
	textPosition:		<Object>
	textSize:		<Object>

familyName
	- xxxxx

font
	- xxxxx

fontSize
	- xxxxx

text
	- xxxxx

textColor
	- xxxxx

textPosition
	- xxxxx

textSize
	- xxxxx

"
Class {
	#name : #GLMStringBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'#font',
		'#familyName',
		'#fontSize',
		'#textSize',
		'#text => GLMPhlowSlot',
		'#textColor',
		'#textPosition',
		'#highlightedString'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #geometry }
GLMStringBrick >> approximateWidth [

	^ self textSize x + self layoutProperties horizontalMargin + self layoutProperties horizontalPadding
]

{ #category : #accessing }
GLMStringBrick >> calculateHighlightingBounds [
	|textBounds highlightBounds last|
	
	highlightBounds := OrderedCollection new.
	
	textBounds := (self calculateTextPosition extent: self textSize) translateBy: (0@0)negated.
	
	last := self text asLowercase findString: self highlightedText asLowercase startingAt: 1.
	last = 0 ifTrue: [^ highlightBounds].
	[last > 0] whileTrue: [ |beforeHighlightTextSize highlightSize matchingString|		
		matchingString := self text copyFrom: last to: last + self highlightedText size - 1.
		highlightSize := self sizeOf: matchingString.
		beforeHighlightTextSize := self sizeOf: (self text first: (last - 1)).
		highlightBounds add: ((textBounds translateBy: ((beforeHighlightTextSize x)@0)) withWidth: highlightSize x).
		last := self text asLowercase findString: self highlightedText asLowercase startingAt: last + 1 ].
	
	^ highlightBounds
]

{ #category : #accessing }
GLMStringBrick >> calculateTextPosition [

	self textPosition = #leftCenter ifTrue: [ 
		^ (self brickBounds origin + self textPositionVerticalCenter) floor
	].

	self textPosition = #center ifTrue: [ 
		^ (self brickBounds origin + self textPositionVerticalCenter + self textPositionHorizontalCenter)floor
	].

	self textPosition = #leftTop ifTrue: [
		^ self brickBounds origin
	].

	self textPosition = #rightCenter ifTrue: [
		^ ((self brickBounds topRight + self textPositionVerticalCenter - (self textSize x@0)) max: self brickBounds origin) floor
	].

	^ self brickBounds origin
]

{ #category : #defaults }
GLMStringBrick >> defaultFamilyName [

	^ self theme labelFont familyName
]

{ #category : #defaults }
GLMStringBrick >> defaultSize [
	^ self theme labelFont pointSize
]

{ #category : #accessing }
GLMStringBrick >> familyName [
	^ familyName
]

{ #category : #accessing }
GLMStringBrick >> familyName: aString [
	familyName := aString.
	self updateFont.
]

{ #category : #accessing }
GLMStringBrick >> font [

	^ font
]

{ #category : #accessing }
GLMStringBrick >> font: aFont [

	font := aFont.
	
	aFont ifNil: [ self updateFont ].
	
	familyName := font familyName.
	fontSize := font pointSize.
]

{ #category : #accessing }
GLMStringBrick >> fontSize [
	^ fontSize
]

{ #category : #accessing }
GLMStringBrick >> fontSize: aNumber [
	fontSize := aNumber.
	self updateFont.
]

{ #category : #public }
GLMStringBrick >> highlight: aString [

	highlightedString := aString
]

{ #category : #accessing }
GLMStringBrick >> highlightedText [
	
	^ highlightedString ifNil: [ highlightedString := '' ]
]

{ #category : #accessing }
GLMStringBrick >> highlightingLogic [
	"[ :aCanvas :aRectangle ]"
	
	^ self valueOfProperty: #brickHighlightingLogic ifAbsentPut: [ nil ] 
]

{ #category : #accessing }
GLMStringBrick >> highlightingLogic: aBlockWithTwoParameters [
	"[ :aCanvas :aRectangle ]"
	
	self setProperty: #brickHighlightingLogic toValue: aBlockWithTwoParameters
]

{ #category : #initialization }
GLMStringBrick >> initialize [
	super initialize.
	
	fontSize := self defaultSize.
	familyName := self defaultFamilyName.
	text := ''.
	
	textPosition := #leftCenter.
	
	self updateFont.
	
]

{ #category : #testing }
GLMStringBrick >> isFitsInParent [

	^ self owner
		ifNil: [ self bounds containsRect: (self outerBounds origin extent: self textSize) ]
		ifNotNil: [
			self owner bounds extent >= self textSize ]
				
]

{ #category : #drawing }
GLMStringBrick >> onDraw: aCanvas [

	super onDraw: aCanvas.
	
	self calculateHighlightingBounds do: [ :each |
		self highlightingLogic
			ifNil: [ aCanvas line: each bottomLeft to: each bottomRight width: 1 color: self textColor ]
			ifNotNil: [ self highlightingLogic cull: aCanvas cull: each ] ].
	
	aCanvas
		drawString: self text
		at: self calculateTextPosition
		font: self font
		color: self textColor
]

{ #category : #'brick-properties-events' }
GLMStringBrick >> onThemerChanged [
	super onThemerChanged.
	
	
]

{ #category : #private }
GLMStringBrick >> privateSetText: aString [

	text := aString asString.
	textSize := nil.
]

{ #category : #public }
GLMStringBrick >> sizeOf: aString [

	^ (self font widthOfString: aString) @ self font height
]

{ #category : #accessing }
GLMStringBrick >> text [

	^ text
]

{ #category : #accessing }
GLMStringBrick >> text: aString [

	self privateSetText: aString
]

{ #category : #'brick-properties' }
GLMStringBrick >> textColor [

	^ self valueOfProperty: #brickTextColor ifAbsent: [ self themer textColor ]
]

{ #category : #'brick-properties' }
GLMStringBrick >> textColor: aColor [

	self setProperty: #brickTextColor toValue: aColor.
	self updateFont.
]

{ #category : #accessing }
GLMStringBrick >> textPosition [

	^ textPosition
]

{ #category : #accessing }
GLMStringBrick >> textPosition: aSymbol [
	"supported:
	#leftCenter
	#center
	#leftTop
	"
	textPosition := aSymbol.
]

{ #category : #geometry }
GLMStringBrick >> textPositionHorizontalCenter [

	^ (((self brickBounds width - self textSize x) max: 0) /2)@0
]

{ #category : #geometry }
GLMStringBrick >> textPositionVerticalCenter [

		^ (0@(self brickBounds height / 2)) - (0@(self fontSize/2)) - (0@3)
	
]

{ #category : #accessing }
GLMStringBrick >> textSize [

	^ textSize ifNil: [ textSize := self sizeOf: self text ]
]

{ #category : #private }
GLMStringBrick >> updateFont [
	font := LogicalFont familyName: self familyName pointSize: self fontSize.
]

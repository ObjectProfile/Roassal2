"
A GLMLabelBrick is standard label Brick, that can shrink text if it's size becomes smaller then actual text size.

Text shrinking works out of box, you don't need to do anything

Instance Variables
	dotsBrick		<GLMStringBrick>
	isDotsAdded:		<boolean>
	stringBrick rick		<GLMStringBrick>

dotsBrick
	- represents a Brick that is added at the end of the text when Brick's size becomes smaller than actual text size

isDotsAdded
	- true if dotsBrick is currently added visible, false otherwise

stringBrick
	- represents actual label text Brick

"
Class {
	#name : #GLMLabelBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'isDotsAdded',
		'dotsBrick',
		'stringBrick'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #examples }
GLMLabelBrick class >> example [
	"this example must be called on my subclasses"
	| rootBrick brick1 brick2 brick3 |
	
	rootBrick := GLMInteractableBrick new
		layoutPolicy: GLMBrickVerticalFillLinearLayout new;
		extent: 400@400;
		disable;
		selectedColor: Color blue darker;
		color: Color blue.
	
	rootBrick layoutProperties
		paddingLeft: 10;
		paddingTop: 15;
		paddingRight: 20;
		paddingBottom: 5.
	
	" ---- Creating first brick ---- "
	brick1 := GLMStringBrick new
		extent: 200@70;
		text: 'Welcome to Brick!';
		textColor: Color white;
		textPosition: #center;
		color: Color green;
		selectedColor: Color darkGray;
		normalColor: Color red;
		pressedColor: Color gray;
		enable.
		
	brick1 layoutProperties
		marginLeft: 10;	
		marginTop: 15;
		marginRight: 20;	
		marginBottom: 5;
		horizontalPercent: 30;
		verticalPercent: 30.
		
	" ---- Creating second brick ---- "
	brick2 := GLMInteractableBrick new
		color: Color green;
		selectedColor: Color pink;
		normalColor: Color green;
		pressedColor: Color lightGray;
		enable;
		extent: 70@60.
	
	brick2 layoutProperties
		marginLeft: 10;
		marginTop: 15;	
		marginRight: 20;
		marginBottom: 5;
		horizontalPercent: 50;
		verticalPercent: 50.
		
	" ---- Creating third brick ---- "
	brick3 := GLMStringBrick new
		extent: 300@200;
		text: 'Welcome to Brick!';
		textColor: Color black;
		color: Color yellow.
		
	brick3 layoutProperties
		marginLeft: 10;
		marginTop: 15;
		marginRight: 20;	
		marginBottom: 5;
		horizontalPercent: 20;
		verticalPercent: 20.
		
	" ---- Add them to the root brick ---- "
	rootBrick
		addBrickBack: brick1;
		addBrickBack: brick2;
		addBrickBack: brick3.
	
	rootBrick asBrickedMorph extent: 400@400; openInWorld
]

{ #category : #geometry }
GLMLabelBrick >> approximateWidth [

		^ self label approximateWidth + self layoutProperties horizontalMargin + self layoutProperties horizontalPadding
]

{ #category : #accessing }
GLMLabelBrick >> contents: aStringOrText [

	self text: aStringOrText asString
]

{ #category : #'default values' }
GLMLabelBrick >> defaultDotsText [
	^ '...'
]

{ #category : #'default values' }
GLMLabelBrick >> defaultInsetBeforeDots [
	^ 1
]

{ #category : #layouting }
GLMLabelBrick >> doLayout [
	"contolls logic of text schrinking"
	|isFit|
	
	super doLayout.
	
	"checking if label text fits in me"
	isFit := self label isFitsInParent.
	
	(isFit & (self isDotsAdded not)) ifTrue: [ ^ self ].
	(isFit not & self isDotsAdded) ifTrue: [ ^ self ].
	
	(isFit & self isDotsAdded) ifTrue: [
		self removeBrick: self dotsBrick.
		isDotsAdded := false.
		super doLayout.
	] ifFalse: [ 
		self addBrickBack: self dotsBrick.
		isDotsAdded := true.
		super doLayout.
	]
	
]

{ #category : #accessing }
GLMLabelBrick >> dotsBrick [

	^ dotsBrick
]

{ #category : #accessing }
GLMLabelBrick >> familyName: aString [

	self label familyName: aString.
	self dotsBrick familyName: aString
]

{ #category : #accessing }
GLMLabelBrick >> fontSize: aNumber [

	self label fontSize: aNumber.
	self dotsBrick fontSize: aNumber
]

{ #category : #initialization }
GLMLabelBrick >> initialize [
	super initialize.
	
	stringBrick := self newStringBrick.
	stringBrick layoutProperties horizontalPercent: 100.
	stringBrick layoutProperties marginRight: self defaultInsetBeforeDots.
	self addBrickBack: stringBrick.
	
	"creating dots morph, that will be displayed when text is being clipped"
	dotsBrick := GLMStringBrick new.
	dotsBrick layoutProperties horizontalPercent: 0.
	dotsBrick text: self defaultDotsText.
	dotsBrick layoutProperties minWidth: (dotsBrick textSize x).
	dotsBrick fontSize: 9.
	
	isDotsAdded := false.
	
]

{ #category : #accessing }
GLMLabelBrick >> isDotsAdded [
	^ isDotsAdded
]

{ #category : #accessing }
GLMLabelBrick >> label [
	^ stringBrick
]

{ #category : #'instance creation' }
GLMLabelBrick >> newStringBrick [
	^ GLMStringBrick new
]

{ #category : #accessing }
GLMLabelBrick >> text [
	^ self label text
]

{ #category : #accessing }
GLMLabelBrick >> text: aString [

	self label text: aString
]

{ #category : #accessing }
GLMLabelBrick >> textColor: aColor [

	self label textColor: aColor.
	self dotsBrick textColor: aColor
]

{ #category : #accessing }
GLMLabelBrick >> textPosition: aSymbol [

	self label textPosition: aSymbol.
	self dotsBrick textPosition: aSymbol.
]

{ #category : #accessing }
GLMLabelBrick >> weightValue: anInteger [

	self label weightValue: anInteger.
	self dotsBrick weightValue: anInteger.
]

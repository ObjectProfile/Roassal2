"
A GLMBrickHorizontalProportionalLinearLayout is an improvement of standard LinearLayout such that element are positioned proportionaly in the parent based on Brick>>layoutProperties horizontalPercent.

"
Class {
	#name : #GLMBrickHorizontalProportionalLinearLayout,
	#superclass : #GLMBrickHorizontalLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #examples }
GLMBrickHorizontalProportionalLinearLayout class >> example [
	"self example"
	super example
]

{ #category : #examples }
GLMBrickHorizontalProportionalLinearLayout class >> example2 [
	"self example2"
	| rootBrick brick1 brick2|
	
	rootBrick := GLMBrick new
		layoutPolicy: self new;
		color: Color blue.
	
	rootBrick layoutProperties
		paddingLeft: 10;
		paddingTop: 10;
		paddingRight: 10;	
		paddingBottom: 10.
	
	brick1 := GLMBrick new
		extent: 50@70;
		color: Color red.
	brick1 layoutProperties horizontalPercent: 100.
	
	brick2 := GLMBrick new
		color: Color green;
		extent: 70@60.
		
	brick2 layoutProperties
		horizontalPercent: 0;
		minWidthBlock: [ 50"px"].
	
	rootBrick
		addBrickBack: brick1;
		addBrickBack: brick2.
		
	rootBrick asBrickedMorph
		extent: 600@400;
		openInWindow
		
	

]

{ #category : #layouting }
GLMBrickHorizontalProportionalLinearLayout >> extentOf: aBrick in: owner withArguments: aHashTable [
	| width requestedWidth allowedWidth minWidth maxWidth distributableWidth distributablePercents|
	
	minWidth := self minWidthOf: aBrick.
	maxWidth := self maxWidthOf: aBrick.
	distributableWidth := aHashTable at: #distributableWidth ifAbsent: [ owner innerBounds width ].
	distributablePercents := aHashTable at: #distributablePercents ifAbsent: [ 100 ].
	
	allowedWidth := self widthOf: aBrick allowed: distributableWidth percents: distributablePercents.
	requestedWidth := self widthOf: aBrick allowed: owner innerBounds width percents: 100.
	
	width := (requestedWidth < minWidth ifTrue: [ minWidth ] ifFalse: [ allowedWidth min: maxWidth ]) - aBrick layoutProperties horizontalMargin.
	
	^ width@(self originalHeightOf: aBrick)
]

{ #category : #'set up' }
GLMBrickHorizontalProportionalLinearLayout >> prepareArgumentsFor: aBrick [
	|allowedWidth maxPercent ownerWidth|
	
	ownerWidth := aBrick innerBounds width.
	allowedWidth := ownerWidth.
	maxPercent := 100.
	
	aBrick subbricks do: [ :each |	|minWidth requestedWidth|
		minWidth := self minWidthOf: each.
		requestedWidth := self widthOf: each allowed: allowedWidth percents: maxPercent.
			
		requestedWidth < minWidth ifTrue: [ 
			allowedWidth := allowedWidth - minWidth.
			maxPercent := maxPercent - each layoutProperties horizontalPercent ] ].

	^ Dictionary new
		add: (#distributableWidth -> allowedWidth);
		add: (#distributablePercents -> maxPercent);
		yourself
]

{ #category : #'as yet unclassified' }
GLMBrickHorizontalProportionalLinearLayout >> setHShrinking: aBrick [
	aBrick width: nil
]

{ #category : #'extent functions' }
GLMBrickHorizontalProportionalLinearLayout >> widthOf: aBrick allowed: width percents: percents [

	percents <= 0 ifTrue: [ ^ 0 ].
	^ (width * aBrick layoutProperties horizontalPercent / percents) ceiling
]

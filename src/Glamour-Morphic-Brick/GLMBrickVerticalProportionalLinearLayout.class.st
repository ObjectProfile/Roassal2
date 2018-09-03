"
A GLMBrickVerticalProportionalLinearLayout is an improvement of standard VerticalLinearLayout such that element are positioned proportionaly in the parent based on Brick>>layoutProperties verticalPercent.

"
Class {
	#name : #GLMBrickVerticalProportionalLinearLayout,
	#superclass : #GLMBrickVerticalLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #examples }
GLMBrickVerticalProportionalLinearLayout class >> example [
	"self example"
	super example
]

{ #category : #layouting }
GLMBrickVerticalProportionalLinearLayout >> extentOf: aBrick in: owner withArguments: aHashTable [
	| height requestedHeight allowedHeight minHeight maxHeight distributableHeight distributablePercents|
	
	minHeight := self minHeightOf: aBrick.
	maxHeight := self maxHeightOf: aBrick.
	distributableHeight := aHashTable at: #distributableHeight ifAbsent: [ owner innerBounds height ].
	distributablePercents := aHashTable at: #distributablePercents ifAbsent: [ 100 ].
	
	allowedHeight := self heightOf: aBrick allowed: distributableHeight percents: distributablePercents.
	requestedHeight := self heightOf: aBrick allowed: owner innerBounds width percents: 100.
	
	height := (requestedHeight < minHeight ifTrue: [ minHeight ] ifFalse: [ allowedHeight min: maxHeight ]) - aBrick layoutProperties verticalMargin.
	
	^ (self originalWidthOf: aBrick)@height
]

{ #category : #'extent functions' }
GLMBrickVerticalProportionalLinearLayout >> heightOf: aBrick allowed: height percents: percents [

	percents <= 0 ifTrue: [ ^ 0 ].
	^ (height * aBrick layoutProperties verticalPercent / percents) ceiling
]

{ #category : #'set up' }
GLMBrickVerticalProportionalLinearLayout >> prepareArgumentsFor: aBrick [
	|allowedHeight maxPercent ownerHeight|
	
	ownerHeight := aBrick globalInnerBounds height.
	allowedHeight := ownerHeight.
	maxPercent := 100.
	
	aBrick subbricks do: [ :each |	|minHeight requestedHeight|
		minHeight := self minHeightOf: each.
		requestedHeight := self heightOf: each allowed: ownerHeight percents: 100.
			
		requestedHeight < minHeight ifTrue: [ 
			allowedHeight := allowedHeight - minHeight.
			maxPercent := maxPercent - each layoutProperties verticalPercent ] ].

	^ Dictionary new
		add: (#distributableHeight -> allowedHeight);
		add: (#distributablePercents -> maxPercent);
		yourself
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalProportionalLinearLayout >> setVShrinking: aBrick [

	aBrick height: nil
]

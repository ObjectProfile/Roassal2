"
A GLMBrickLayoutProperties is  a holder class of layout properties used by layout policy

Instance Variables
	horizontalPercent:		<Object>
	marginBottom:		<Object>
	marginLeft:		<Object>
	marginRight:		<Object>
	marginTop:		<Object>
	maxHeightBlock:		<Object>
	maxWidthBlock:		<Object>
	minHeight:		<Object>
	minWidth:		<Object>
	paddingBottom:		<Object>
	paddingLeft:		<Object>
	paddingRight:		<Object>
	paddingTop:		<Object>
	verticalPercent:		<Object>

horizontalPercent
	- xxxxx

marginBottom
	- xxxxx

marginLeft
	- xxxxx

marginRight
	- xxxxx

marginTop
	- xxxxx

maxHeightBlock
	- xxxxx

maxWidthBlock
	- xxxxx

minHeight
	- xxxxx

minWidth
	- xxxxx

paddingBottom
	- xxxxx

paddingLeft
	- xxxxx

paddingRight
	- xxxxx

paddingTop
	- xxxxx

verticalPercent
	- xxxxx

"
Class {
	#name : #GLMBrickLayoutProperties,
	#superclass : #TableLayoutProperties,
	#instVars : [
		'marginTop',
		'marginRight',
		'marginBottom',
		'marginLeft',
		'paddingTop',
		'paddingRight',
		'paddingBottom',
		'paddingLeft',
		'horizontalPercent',
		'verticalPercent',
		'maxWidthBlock',
		'maxHeightBlock',
		'minHeightBlock',
		'minWidthBlock',
		'floating',
		'zIndex',
		'brick'
	],
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #private }
GLMBrickLayoutProperties >> brick [

	^ brick
]

{ #category : #private }
GLMBrickLayoutProperties >> brick: aBrick [
	
	brick := aBrick
]

{ #category : #accessing }
GLMBrickLayoutProperties >> floating [
	^ floating
]

{ #category : #accessing }
GLMBrickLayoutProperties >> floating: aSymbol [
	floating := aSymbol
]

{ #category : #scripting }
GLMBrickLayoutProperties >> hPercent: anInteger [

	self horizontalPercent: anInteger
]

{ #category : #scripting }
GLMBrickLayoutProperties >> hShrinkWrap [

	self brick layoutPolicy setHShrinking: self brick
]

{ #category : #scripting }
GLMBrickLayoutProperties >> hSpaceFill [

	self horizontalPercent: 100
]

{ #category : #accessing }
GLMBrickLayoutProperties >> horizontalMargin [

	^ self marginLeft + self marginRight
]

{ #category : #accessing }
GLMBrickLayoutProperties >> horizontalPadding [

	^ self paddingLeft + self paddingRight
]

{ #category : #accessing }
GLMBrickLayoutProperties >> horizontalPercent [
	^ horizontalPercent
]

{ #category : #accessing }
GLMBrickLayoutProperties >> horizontalPercent: anObject [
	horizontalPercent := anObject
]

{ #category : #initialization }
GLMBrickLayoutProperties >> initialize [
	super initialize.
	
	marginBottom := 0.
	marginLeft := 0.
	marginRight := 0.
	marginTop := 0.
	paddingBottom := 0.
	paddingLeft := 0.
	paddingRight := 0.
	paddingTop := 0.
	horizontalPercent := 25.
	verticalPercent := 25.
	zIndex := 1. "the lowest one"
	maxWidthBlock := [ :aTrick | -1 ]. "negative value means undefined"
	maxHeightBlock := [ :aTrick | -1 ]. "negative value means undefined"
	minWidthBlock := [ :aTrick | -1 ]. "negative value means undefined"
	minHeightBlock := [ :aTrick | -1 ]. "negative value means undefined"
	floating := #none
]

{ #category : #scripting }
GLMBrickLayoutProperties >> margin: margins [
	"The margins property can have from one to four values:
	
	margin: #(25 50 75 100)
		top margin is 25px
		right margin is 50px
		bottom margin is 75px
		left margin is 100px
		
	margin: #(25 50 75)
		top margin is 25px
		right and left margins are 50px
		bottom margin is 75px
		
	margin: #(25 50)
		top and bottom margins are 25px
		right and left margins are 50px
		
	margin: #(25)
		all four margins are 25px
		
	margin: 25
		all four margins are 25px"
	
	margins ifNil: [ ^ self margin: #(0) ].
	
	margins isCollection ifTrue: [
		margins isEmpty ifTrue: [ ^ self margin: #(0) ].
		self
			marginTop: (margins at: 1);
			marginRight: (margins at: 1);
			marginBottom: (margins at: 1);
			marginLeft: (margins at: 1).
		margins size > 1 ifTrue: [
			self
				marginRight: (margins at: 2);
				marginLeft: (margins at: 2) ].
		margins size > 2 ifTrue: [
			self marginBottom: (margins at: 3) ].
		margins size > 3 ifTrue: [
			self marginLeft: (margins at: 4) ] ]
	ifFalse: [ ^ self margin: {margins} ]
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginBottom [
	^ marginBottom
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginBottom: anObject [
	marginBottom := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginLeft [
	^ marginLeft
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginLeft: anObject [
	marginLeft := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginRight [
	^ marginRight
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginRight: anObject [
	marginRight := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginTop [
	^ marginTop
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginTop: anObject [
	marginTop := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxHeight: anObject [
	maxHeightBlock := [ anObject ]
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxHeightBlock [
	^ maxHeightBlock
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxHeightBlock: anObject [
	maxHeightBlock := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxWidth: anObject [
	maxWidthBlock := [ anObject ]
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxWidthBlock [
	^ maxWidthBlock
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxWidthBlock: anObject [
	maxWidthBlock := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minHeight: anObject [
	minHeightBlock := [ anObject ]
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minHeightBlock [
	^ minHeightBlock
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minHeightBlock: anObject [
	minHeightBlock := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minWidth: anObject [
	minWidthBlock := [ anObject ]
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minWidthBlock [
	^ minWidthBlock
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minWidthBlock: anObject [
	minWidthBlock := anObject
]

{ #category : #scripting }
GLMBrickLayoutProperties >> padding: paddings [
	"The paddings property can have from one to four values:
	
	padding: #(25 50 75 100)
		top padding is 25px
		right padding is 50px
		bottom padding is 75px
		left padding is 100px
		
	padding: #(25 50 75)
		top padding is 25px
		right and left paddings are 50px
		bottom padding is 75px
		
	padding: #(25 50)
		top and bottom paddings are 25px
		right and left paddings are 50px
		
	padding: #(25)
		all four paddings are 25px
		
	padding: 25
		all four paddings are 25px"
	
	paddings ifNil: [ ^ self padding: #(0) ].
	
	paddings isCollection ifTrue: [
		paddings isEmpty ifTrue: [ ^ self padding: #(0) ].
		self
			paddingTop: (paddings at: 1);
			paddingRight: (paddings at: 1);
			paddingBottom: (paddings at: 1);
			paddingLeft: (paddings at: 1).
		paddings size > 1 ifTrue: [
			self
				paddingRight: (paddings at: 2);
				paddingLeft: (paddings at: 2) ].
		paddings size > 2 ifTrue: [
			self paddingBottom: (paddings at: 3) ].
		paddings size > 3 ifTrue: [
			self paddingLeft: (paddings at: 4) ] ]
	ifFalse: [ ^ self padding: {paddings} ]
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingBottom [
	^ paddingBottom
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingBottom: anObject [
	paddingBottom := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingLeft [
	^ paddingLeft
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingLeft: anObject [
	paddingLeft := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingRight [
	^ paddingRight
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingRight: anObject [
	paddingRight := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingTop [
	^ paddingTop
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingTop: anObject [
	paddingTop := anObject
]

{ #category : #scripting }
GLMBrickLayoutProperties >> staticHeight: aNumberOrBlockOrSymbol [

	self verticalPercent: 0.
	(aNumberOrBlockOrSymbol isBlock | aNumberOrBlockOrSymbol isSymbol)
		ifTrue: [ self minHeightBlock: aNumberOrBlockOrSymbol ]
		ifFalse: [ self minHeight: aNumberOrBlockOrSymbol ]
]

{ #category : #scripting }
GLMBrickLayoutProperties >> staticWidth: aNumberOrBlockOrSymbol [

	self horizontalPercent: 0.
	(aNumberOrBlockOrSymbol isBlock | aNumberOrBlockOrSymbol isSymbol)
		ifTrue: [ self minWidthBlock: aNumberOrBlockOrSymbol ]
		ifFalse: [ self minWidth: aNumberOrBlockOrSymbol ]
]

{ #category : #scripting }
GLMBrickLayoutProperties >> vPercent: anInteger [

	self verticalPercent: anInteger
]

{ #category : #scripting }
GLMBrickLayoutProperties >> vShrinkWrap [

	self brick layoutPolicy setVShrinking: self brick
]

{ #category : #scripting }
GLMBrickLayoutProperties >> vSpaceFill [

	self verticalPercent: 100
]

{ #category : #accessing }
GLMBrickLayoutProperties >> verticalMargin [

	^ self marginTop + self marginBottom
]

{ #category : #accessing }
GLMBrickLayoutProperties >> verticalPadding [

	^ self paddingTop + self paddingBottom
]

{ #category : #accessing }
GLMBrickLayoutProperties >> verticalPercent [
	^ verticalPercent
]

{ #category : #accessing }
GLMBrickLayoutProperties >> verticalPercent: anObject [
	verticalPercent := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> zIndex [
	^ zIndex
]

{ #category : #accessing }
GLMBrickLayoutProperties >> zIndex: anObject [
	zIndex := anObject
]

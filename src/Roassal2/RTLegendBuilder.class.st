"
I am an handy class to build legend in a visualization

-=-=-=-=-=-=-=-=
b := RTMondrian new.
b shape rectangle
	width: [ :c | c numberOfVariables * 5 ];
	height: #numberOfMethods.
b nodes: RTShape withAllSubclasses.
b edges connectFrom: #superclass.
b layout tree.
b build.

lb := RTLegendBuilder new.
lb view: b view.
lb addRectanglePolymetricWidth: 'number of methods' height: 'Line of code'.
lb build.

b
-=-=-=-=-=-=-=-=

"
Class {
	#name : #RTLegendBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'items',
		'group',
		'legendElement',
		'offset',
		'position',
		'isOnDemand'
	],
	#category : #'Roassal2-Builder-Legend'
}

{ #category : #'instance creation' }
RTLegendBuilder class >> on: aView [
	| i |
	i := self new.
	i view: aView.
	^ i.
]

{ #category : #'public - convenient' }
RTLegendBuilder >> addColor: aColor object: anObject text: aBlockOrSelector [
	"Associate a color with a text"
	items add: (RTColorLegendItem new color: aColor; model: anObject; text: aBlockOrSelector)
]

{ #category : #'public - convenient' }
RTLegendBuilder >> addColor: aColor text: aText [
	"Associate a color with a text"
	^ self addColor: aColor object: aText text: #yourself
]

{ #category : #'public - convenient' }
RTLegendBuilder >> addColorFadingFrom: startColor to: endColor text: description [

	items add: (RTColorFadingLegendItem new startColor: startColor; endColor: endColor; description: description)
]

{ #category : #'public - convenient' }
RTLegendBuilder >> addColoredObject: anObject text: aTextOrSymbolOrBlock color: aColor [
	items add: (RTLabelLegendItem new model: anObject; text: aTextOrSymbolOrBlock; color: aColor)
]

{ #category : #'public - convenient' }
RTLegendBuilder >> addColoredText: aText color: aColor [
	^ self addColoredObject: nil text: aText color: aColor

]

{ #category : #'public - convenient' }
RTLegendBuilder >> addLineColor: aColor text: aText [
	"Associate a color with a text"
	items add: (RTLineLegendItem new color: aColor; text: aText)
]

{ #category : #'public - convenient' }
RTLegendBuilder >> addObject: anObject text: aTextOrASymbolOrBlock [
	^ self addColoredObject: anObject text: aTextOrASymbolOrBlock color: Color lightGray
]

{ #category : #'public - convenient' }
RTLegendBuilder >> addRectanglePolymetricWidth: widthDescription height: heightDescription box: boxDescription [
	"Associate a color with a text"

	items add: (RTPolymorphicBoxLegendItem new 
						widthDescription: widthDescription;
						heightDescription: heightDescription;
						boxDescription: boxDescription)
]

{ #category : #'public - convenient' }
RTLegendBuilder >> addRectanglePolymetricWidth: widthDescription height: heightDescription boxIllustrate: boxDescription [
	"Associate a color with a text"

	| g ext1 ext2   lineExtremityShape lineShape topLine |
	g := RTGroup new.
	
	"Defining extremities and line shape"
	lineExtremityShape := RTBox new size: 10.
	lineShape := RTLine new color: Color red.
	
	"The top line"
	ext1 := lineExtremityShape element.
	ext2 := lineExtremityShape element.
	topLine := lineShape edgeFrom: ext1 to: ext2.
	
	ext2 translateBy: (10 @ 10).
	g add: ext1; add: ext2.
	g add: topLine.
	
	group add: g.
	^ g
]

{ #category : #'public - convenient' }
RTLegendBuilder >> addRectanglePolymetricWidth: widthDescription height: heightDescription boxVEYGOOD: boxDescription [
	"Associate a color with a text"

	| g ext1 ext2 box e lineExtremityShape lineShape topLine leftLine widthDescriptionElement heightDescriptionElement boxDescriptionLabel |
	g := RTGroup new.
	
	"Defining extremities and line shape"
	lineExtremityShape := RTBox new size: 10.
	lineShape := RTLine new color: Color red.
	
	"Label for the descriptions"
	widthDescriptionElement := (self newLabelShape: widthDescription) element.
	heightDescriptionElement := (self newLabelShape: heightDescription) element.
	g add: widthDescriptionElement.
	g add: heightDescriptionElement.
	
	"The box"
	box := (RTBox new extent: 30 @ 50) element.
	g add: box.
	e := box encompassingRectangle.
	
	"The top line"
	ext1 := lineExtremityShape element.
	ext2 := lineExtremityShape element.
	topLine := lineShape edgeFrom: ext1 to: ext2.
	ext1 translateBy: e topLeft - (0 @ 10).
	ext2 translateBy: e topRight - (0 @ 10).
	g
		add: ext1;
		add: ext2.
	g add: topLine.
	
	"The width label"
	boxDescriptionLabel := (self newLabelShape: boxDescription) element.
	g add: boxDescriptionLabel.
	TRConstraint move: boxDescriptionLabel onTheRightOf: box.
	
	

	TRConstraint move: widthDescriptionElement between: ext1 and: ext2.
	widthDescriptionElement translateBy: 0 @ (widthDescriptionElement extent y / -2 - 3).
	ext1 := lineExtremityShape element.
	ext2 := lineExtremityShape element.
	leftLine := lineShape edgeFrom: ext1 to: ext2.
	ext1 translateBy: e topLeft - (10 @ 0).
	ext2 translateBy: e bottomLeft - (10 @ 0).
	g
		add: ext1;
		add: ext2.
	g add: leftLine.
	TRConstraint move: heightDescriptionElement between: ext1 and: ext2.
	heightDescriptionElement translateBy: (heightDescriptionElement extent x / -2) @ 0.
	group add: g.
	^ g
]

{ #category : #'public - convenient' }
RTLegendBuilder >> addText: aText [
	self addColoredText: aText color: self textColor
]

{ #category : #'public - positioning' }
RTLegendBuilder >> below [
	position := #below
]

{ #category : #initialization }
RTLegendBuilder >> defaultOffset [
	^ 20
]

{ #category : #accessing }
RTLegendBuilder >> group [
	"Return all the elements"
	| myGroup |
	myGroup := RTGroup new.
	items do: [ :item | myGroup add: item execute ].
	RTVerticalLineLayout on: myGroup.
	^ myGroup
]

{ #category : #initialization }
RTLegendBuilder >> initialize [
	super initialize.
	"Thisi group variable should be removed"
	group := RTGroup new.
	
	offset := self defaultOffset.
	position := #below.
	isOnDemand := false.
	items := OrderedCollection new.
]

{ #category : #'public - positioning' }
RTLegendBuilder >> isBelow [
	^ position = #below
]

{ #category : #'public - positioning' }
RTLegendBuilder >> isLeft [
	^ position = #left
]

{ #category : #'public - positioning' }
RTLegendBuilder >> isRight [
	^ position = #right
]

{ #category : #'public - positioning' }
RTLegendBuilder >> left [
	position := #left
]

{ #category : #accessing }
RTLegendBuilder >> legendElement [
	^ legendElement
]

{ #category : #'private - utility' }
RTLegendBuilder >> newLabelShape: widthDescription [
	"Return a new label with the argument as the content of the label"
	^ RTLabel new color: self textColor; text: widthDescription; yourself
]

{ #category : #initialization }
RTLegendBuilder >> offset [
	^ offset
]

{ #category : #initialization }
RTLegendBuilder >> offset: aDistanceInPixel [
	offset := aDistanceInPixel 
]

{ #category : #'public - ondemand' }
RTLegendBuilder >> onDemand [
	isOnDemand := true
]

{ #category : #hooks }
RTLegendBuilder >> renderIn: aView [
	| myGroup elementsInTheViewWithoutTheLegend |
	super renderIn: aView.

	isOnDemand ifTrue: [ ^ self renderOnDemandIn: aView ].

	elementsInTheViewWithoutTheLegend := aView elements.
	myGroup := self group.
	legendElement := (RTBox new
		borderColor: Color lightGray;
		fillColor: Color white) element.
	aView add: legendElement.
	myGroup do: [ :g | aView addAll: g ].
	RTNest new on: legendElement nest: myGroup.
	
	self isBelow ifTrue: [ 
		TRConstraint move: legendElement below: (RTGroup withAll: elementsInTheViewWithoutTheLegend).
		legendElement translateBy: 0 @ offset. ].

	self isRight ifTrue: [ 
		TRConstraint move: legendElement onTheRightOf: (RTGroup withAll: elementsInTheViewWithoutTheLegend).
		legendElement translateBy: offset @ 0. ].

	self isLeft ifTrue: [ 
		TRConstraint move: legendElement onTheLeftOf: (RTGroup withAll: elementsInTheViewWithoutTheLegend).
		legendElement translateBy: offset @ 0. ].
	
	legendElement @ RTDraggable
]

{ #category : #hooks }
RTLegendBuilder >> renderOnDemandIn: aView [
	| label myGroup |
	super renderIn: aView.
	RTVerticalLineLayout on: group.

	label := (RTLabel new color: Color red) elementOn: '?'.
	label setAsFixed.
	label @ RTHighlightable.
	aView add: label.
	label translateTo: label extent / 2.
	label @ (RTPopup new
					alphaPopupBackground: 0.8;
					background: Color white
					group: [ :gg :el | 
					 	 	myGroup := self group.
							
							gg addAll: (myGroup flatCollect: #yourself).
					]).
	
]

{ #category : #'public - positioning' }
RTLegendBuilder >> right [
	position := #right
]

{ #category : #configuration }
RTLegendBuilder >> textColor [
	^ Color lightGray
]

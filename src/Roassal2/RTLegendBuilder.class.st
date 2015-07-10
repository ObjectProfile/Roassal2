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
		'group',
		'legendElement',
		'offset',
		'position'
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

{ #category : #adding }
RTLegendBuilder >> addColor: aColor object: anObject text: aBlockOrSelector [
	"Associate a color with a text"
	| g |
	g := RTGroup new.
	g add: (RTBox new size: 10; color: aColor) element.
	g add: ((RTLabel text: aBlockOrSelector) elementOn: anObject).
	RTHorizontalLineLayout new alignCenter; on: g.
	group add: g.
	^ g
]

{ #category : #adding }
RTLegendBuilder >> addColor: aColor text: aText [
	"Associate a color with a text"
	^ self addColor: aColor object: aText text: #yourself
]

{ #category : #adding }
RTLegendBuilder >> addColorFadingFrom: startColor to: endColor text: description [

	| g shape es n label |
	g := RTGroup new.
	
	shape := RTBox new width: 3; height: 20.
	es := shape elementsOn: (1 to: 50).
	g addAll: es.
	RTHorizontalLineLayout new gapSize: -1; on: es.
	
	n := RTMetricNormalizer new.
	n elements: es.
	n normalizeColor: #yourself using: (Array with: startColor with: endColor).
	
	label := (self newLabelShape: description) element.
	g add: label.
	TRConstraint move: label onTheRightOf: es.
	label translateBy: 20 @ 0.
	
	group add: g.
	^ g
]

{ #category : #adding }
RTLegendBuilder >> addColoredObject: anObject text: aTextOrSymbolOrBlock color: aColor [
	group add: (RTGroup new add: 
					((self newLabelShape: aTextOrSymbolOrBlock) elementOn: anObject); yourself)
]

{ #category : #adding }
RTLegendBuilder >> addColoredText: aText color: aColor [
	^ self addColoredObject: nil text: aText color: aColor

]

{ #category : #adding }
RTLegendBuilder >> addLineColor: aColor text: aText [
	"Associate a color with a text"
	| g |
	g := RTGroup new.
	g add: (RTBox new height: 3; width: 10; color: aColor) element.
	g add: (RTLabel elementOn: aText).
	RTHorizontalLineLayout new alignCenter; on: g.
	group add: g.
]

{ #category : #adding }
RTLegendBuilder >> addObject: anObject text: aTextOrASymbolOrBlock [
	^ self addColoredObject: anObject text: aTextOrASymbolOrBlock color: Color lightGray
]

{ #category : #adding }
RTLegendBuilder >> addRectanglePolymetricWidth: widthDescription height: heightDescription [
	"Associate a color with a text"

	| g ext1 ext2 box e lineExtremityShape lineShape topLine leftLine widthDescriptionElement heightDescriptionElement |
	g := RTGroup new.
	lineExtremityShape := RTBox new size: 1.
	lineShape := RTDoubleArrowedLine new color: Color red.
	widthDescriptionElement := (self newLabelShape: widthDescription) element.
	heightDescriptionElement := (self newLabelShape: heightDescription) element.
	g add: widthDescriptionElement.
	g add: heightDescriptionElement.
	box := (RTBox new extent: 30 @ 50) element.
	g add: box.
	e := box encompassingRectangle.
	ext1 := lineExtremityShape element.
	ext2 := lineExtremityShape element.
	topLine := lineShape edgeFrom: ext1 to: ext2.
	ext1 translateBy: e topLeft - (0 @ 10).
	ext2 translateBy: e topRight - (0 @ 10).
	g
		add: ext1;
		add: ext2.
	g add: topLine.	"	TRConstraint move: widthDescriptionElement onTheRightOf: ext2."
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

{ #category : #adding }
RTLegendBuilder >> addRectanglePolymetricWidth: widthDescription height: heightDescription box: boxDescription [
	"Associate a color with a text"

	| g ext1 ext2 box e lineExtremityShape lineShape topLine leftLine widthDescriptionElement heightDescriptionElement boxDescriptionLabel |
	g := RTGroup new.
	lineExtremityShape := RTBox new size: 1.
	lineShape := RTDoubleArrowedLine new color: Color red.
	widthDescriptionElement := (self newLabelShape: widthDescription) element.
	heightDescriptionElement := (self newLabelShape: heightDescription) element.
	g add: widthDescriptionElement.
	g add: heightDescriptionElement.
	box := (RTBox new extent: 30 @ 50) element.
	g add: box.
	e := box encompassingRectangle.
	ext1 := lineExtremityShape element.
	ext2 := lineExtremityShape element.
	topLine := lineShape edgeFrom: ext1 to: ext2.
	ext1 translateBy: e topLeft - (0 @ 10).
	ext2 translateBy: e topRight - (0 @ 10).
	
	boxDescriptionLabel := (self newLabelShape: boxDescription) element.
	g add: boxDescriptionLabel.
	TRConstraint move: boxDescriptionLabel onTheRightOf: box.
	
	
	g
		add: ext1;
		add: ext2.
	g add: topLine.
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

{ #category : #adding }
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

{ #category : #initialization }
RTLegendBuilder >> initialize [
	super initialize.
	group := RTGroup new.
	offset := self defaultOffset.
	position := #below
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

{ #category : #hooks }
RTLegendBuilder >> renderIn: aView [
	super renderIn: aView.
	RTVerticalLineLayout on: group.
	legendElement := (RTBox new
		borderColor: Color lightGray;
		fillColor: Color white) element.
	RTNest new on: legendElement nest: group.
	
	self isBelow ifTrue: [ 
		TRConstraint move: legendElement below: (RTGroup withAll: aView elements).
		legendElement translateBy: 0 @ offset. ].

	self isRight ifTrue: [ 
		TRConstraint move: legendElement onTheRightOf: (RTGroup withAll: aView elements).
		legendElement translateBy: offset @ 0. ].

	self isLeft ifTrue: [ 
		TRConstraint move: legendElement onTheLeftOf: (RTGroup withAll: aView elements).
		legendElement translateBy: offset @ 0. ].
	
	aView add: legendElement.
	group do: [ :g | aView addAll: g ].
	legendElement @ RTDraggable
]

{ #category : #'public - positioning' }
RTLegendBuilder >> right [
	position := #right
]

{ #category : #configuration }
RTLegendBuilder >> textColor [
	^ Color lightGray
]

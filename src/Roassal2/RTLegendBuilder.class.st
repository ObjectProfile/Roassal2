"
I am an handy class to build legend in a visualization
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

{ #category : #adding }
RTLegendBuilder >> addColor: aColor text: aText [
	"Associate a color with a text"
	| g |
	g := RTGroup new.
	g add: (RTBox new size: 10; color: aColor) element.
	g add: (RTLabel elementOn: aText).
	RTHorizontalLineLayout new alignCenter; on: g.
	group add: g.
]

{ #category : #adding }
RTLegendBuilder >> addColoredText: aText color: aColor [
	group add: (RTGroup new add: ((RTLabel new color: aColor) elementOn: aText); yourself)
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
RTLegendBuilder >> addText: aText [
	self addColoredText: aText color: Color lightGray
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
	"Return all the elements added by the legend builder"
	^ group
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
RTLegendBuilder >> isRight [
	^ position = #right
]

{ #category : #accessing }
RTLegendBuilder >> legendElement [
	^ legendElement
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
	
	aView add: legendElement.
	group do: [ :g | aView addAll: g ].
	legendElement @ RTDraggable
]

{ #category : #'public - positioning' }
RTLegendBuilder >> right [
	position := #right
]

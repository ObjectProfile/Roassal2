"
I am an handy class to build legend in a visualization
"
Class {
	#name : #RTLegendBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'group',
		'legendElement'
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
RTLegendBuilder >> addText: aText [
	self addColoredText: aText color: Color lightGray
]

{ #category : #initialization }
RTLegendBuilder >> initialize [
	super initialize.
	group := RTGroup new.
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
	TRConstraint move: legendElement below: (RTGroup withAll: aView elements).
	aView add: legendElement.
	group do: [ :g | aView addAll: g ].
	legendElement @ RTDraggable
]

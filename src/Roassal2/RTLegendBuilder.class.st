"
I am an handy class to build legend in a visualization
"
Class {
	#name : #RTLegendBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'group'
	],
	#category : #'Roassal2-Builder-Legend'
}

{ #category : #adding }
RTLegendBuilder >> addColor: aColor text: aText [
	| g |
	g := RTGroup new.
	g add: (RTBox new size: 10; color: aColor) element.
	g add: (RTLabel elementOn: aText).
	RTHorizontalLineLayout new alignCenter; on: g.
	group add: g.
]

{ #category : #adding }
RTLegendBuilder >> addText: aText [
	group add: (RTGroup new add: (RTLabel elementOn: aText); yourself)
]

{ #category : #initialization }
RTLegendBuilder >> initialize [
	super initialize.
	group := RTGroup new.
]

{ #category : #hooks }
RTLegendBuilder >> renderIn: aView [
	| background |
	super renderIn: aView.
	
	RTVerticalLineLayout on: group.
	
	background := (RTBox new borderColor: Color lightGray; fillColor: Color white) element.

	RTNest new on: background nest: group.
	TRConstraint move: background below: (RTGroup withAll: aView elements).

	aView add: background.
	group do: [ :g | aView addAll: g ].
	background @ RTDraggable.
]

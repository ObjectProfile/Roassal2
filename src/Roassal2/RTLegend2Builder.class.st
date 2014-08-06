Class {
	#name : #RTLegend2Builder,
	#superclass : #RTBuilder,
	#instVars : [
		'group'
	],
	#category : #'Roassal2-Builder-Legend'
}

{ #category : #adding }
RTLegend2Builder >> addColor: aColor text: aText [
	| g |
	g := RTGroup new.
	g add: (RTBox new size: 10; color: aColor) element.
	g add: (RTLabel elementOn: aText).
	RTHorizontalLineLayout new alignCenter; on: g.
	group add: g.
]

{ #category : #adding }
RTLegend2Builder >> addText: aText [
	group add: (RTGroup new add: (RTLabel elementOn: aText); yourself)
]

{ #category : #initialization }
RTLegend2Builder >> initialize [
	super initialize.
	group := RTGroup new.
]

{ #category : #hooks }
RTLegend2Builder >> renderIn: aView [
	| background |
	super renderIn: aView.
	
	RTVerticalLineLayout on: group.
	
	background := (RTBox new borderColor: Color lightGray; fillColor: Color white) element.

	RTNest new on: background nest: group.
	RTConstraint move: background below: (RTGroup withAll: aView elements).

	aView add: background.
	group do: [ :g | aView addAll: g ].
	background @ RTDraggable.
]

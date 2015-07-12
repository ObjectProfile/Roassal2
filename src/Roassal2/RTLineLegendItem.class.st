Class {
	#name : #RTLineLegendItem,
	#superclass : #RTLegendItem,
	#instVars : [
		'color',
		'text'
	],
	#category : #'Roassal2-Builder-Legend'
}

{ #category : #accessing }
RTLineLegendItem >> color [
	^ color
]

{ #category : #accessing }
RTLineLegendItem >> color: anObject [
	color := anObject
]

{ #category : #hooks }
RTLineLegendItem >> execute [
	"Associate a color with a text"
	| g |
	g := RTGroup new.
	g add: (RTBox new height: 3; width: 10; color: color) element.
	g add: (RTLabel elementOn: text).
	RTHorizontalLineLayout new alignCenter; on: g.
	^ g
]

{ #category : #accessing }
RTLineLegendItem >> text [
	^ text
]

{ #category : #accessing }
RTLineLegendItem >> text: anObject [
	text := anObject
]

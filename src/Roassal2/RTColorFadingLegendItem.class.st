Class {
	#name : #RTColorFadingLegendItem,
	#superclass : #RTLegendItem,
	#instVars : [
		'startColor',
		'endColor',
		'description'
	],
	#category : #'Roassal2-Builder-Legend'
}

{ #category : #accessing }
RTColorFadingLegendItem >> description [
	^ description
]

{ #category : #accessing }
RTColorFadingLegendItem >> description: anObject [
	description := anObject
]

{ #category : #accessing }
RTColorFadingLegendItem >> endColor [
	^ endColor
]

{ #category : #accessing }
RTColorFadingLegendItem >> endColor: anObject [
	endColor := anObject
]

{ #category : #hooks }
RTColorFadingLegendItem >> execute [
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
	
	^ g
]

{ #category : #accessing }
RTColorFadingLegendItem >> startColor [
	^ startColor
]

{ #category : #accessing }
RTColorFadingLegendItem >> startColor: anObject [
	startColor := anObject
]

"
A RTDoubleBarBuilder render a double bar chart
"
Class {
	#name : #RTDoubleBarBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'elements',
		'topExtremity',
		'bottomExtremity'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #'as yet unclassified' }
RTDoubleBarBuilder >> createView [
	^ super createView @ RTDraggableView
]

{ #category : #'as yet unclassified' }
RTDoubleBarBuilder >> example01 [
	"
	self new example01
	"
	| b |
	b := RTDoubleBarBuilder new.
	b points: RTShape withAllSubclasses.
	b value1: #numberOfMethods.
	b value2: #numberOfVariables.
	b open
]

{ #category : #'as yet unclassified' }
RTDoubleBarBuilder >> metric: aBlock color: aColor height: anHeight [
	| boxes |
	boxes := elements collect: [ :el | 
		| b |
		b := (RTBox new height: anHeight; color: aColor) elementOn: el model.
		b @ (RTPopup text: [ :model | aBlock rtValue: model ]).
		b ].
	RTMetricNormalizer new 
		elements: boxes;
		normalizeWidth: aBlock min: 2 max: 200.
 		
	elements with: boxes do: [ :e :b | 		 
		TRConstraint move: b onTheRightOf: e.
		b translateBy: 2 @ 0. ].
	view addAll: boxes.
]

{ #category : #'as yet unclassified' }
RTDoubleBarBuilder >> points [
	^ elements collect: #model
]

{ #category : #'as yet unclassified' }
RTDoubleBarBuilder >> points: someObjects [
	elements := RTLabel elementsOn: someObjects.
	elements @ RTHighlightable.
	view addAll: elements.
	RTVerticalLineLayout new alignRight; on: elements.
	
	topExtremity := RTBox element.
	bottomExtremity := RTBox element.
	TRConstraint move: topExtremity onTheRightOf: elements first.
	TRConstraint move: bottomExtremity onTheRightOf: elements last.
	topExtremity translateBy: 0 @ -15.
	bottomExtremity translateBy: 0 @ 15.	
	view add: ((RTLine new color: Color red) edgeFrom: topExtremity to: bottomExtremity).
]

{ #category : #'as yet unclassified' }
RTDoubleBarBuilder >> value1: aBlock [
	"The gray bar"
	self value1: aBlock titled: aBlock asString
]

{ #category : #'as yet unclassified' }
RTDoubleBarBuilder >> value1: aBlock titled: aTitle [
	"The gray bar"
	 | configuration |
	self metric: aBlock color: Color gray height: 20.
	
	configuration := RTAxisConfiguration new.
	configuration builder: self.
	configuration title: aTitle.
	configuration titlePosition: (0 @ 30).
	configuration color: Color gray.
	configuration minValue: 0.
	configuration positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position - (0 @ 15) ].
	configuration maxValue: (self points collect: aBlock) max.
	configuration numberOfTicks: 4.
	configuration axisFrom: topExtremity position to: topExtremity position + (200 @ 0).
	
]

{ #category : #'as yet unclassified' }
RTDoubleBarBuilder >> value2: aBlock [
	"The red bar"
	self value2: aBlock titled: aBlock asString
]

{ #category : #'as yet unclassified' }
RTDoubleBarBuilder >> value2: aBlock titled: aTitle [
	"The red bar"
	 | configuration |
	self metric: aBlock color: Color red height: 10.
	
	configuration := RTAxisConfiguration new.
	configuration builder: self.
	configuration title: aTitle.
	configuration titlePosition: (0 @ -30).
	configuration color: Color red.
	configuration minValue: 0.
	configuration positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + (0 @ 15) ].
	configuration maxValue: (self points collect: aBlock) max.
	configuration numberOfTicks: 4.
	configuration axisFrom: bottomExtremity position to: bottomExtremity position + (200 @ 0).
	
]

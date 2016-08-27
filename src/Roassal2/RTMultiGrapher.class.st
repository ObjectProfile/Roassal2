Class {
	#name : #RTMultiGrapher,
	#superclass : #RTBuilder,
	#instVars : [
		'graphers',
		'legendBuilder',
		'yOffset',
		'extent'
	],
	#category : #'Roassal2-Builder-Grapher-Core'
}

{ #category : #adding }
RTMultiGrapher >> add: aGrapher [
	graphers add: aGrapher
]

{ #category : #accessing }
RTMultiGrapher >> extent [
	^ extent
]

{ #category : #accessing }
RTMultiGrapher >> extent: anObject [
	extent := anObject
]

{ #category : #initialization }
RTMultiGrapher >> initialize [
	super initialize.
	graphers := OrderedCollection new.
	yOffset := 70.
	extent := 300 @ 200
]

{ #category : #accessing }
RTMultiGrapher >> legend [
	^ legendBuilder ifNil: [ legendBuilder := RTLegendBuilder new ]
]

{ #category : #hooks }
RTMultiGrapher >> renderIn: aView [
	graphers
		withIndexDo: [ :each :i | 
			each yOffset: (i - 1) * yOffset.
			each build.
			aView addFromView: each view ].
	legendBuilder
		ifNotNil: [ graphers
				do: [ :each | 
					each legend: legendBuilder.
					each renderLegend ].
			aView addFromView: legendBuilder view.
			graphers do: #inferLegendInteractions ]
]

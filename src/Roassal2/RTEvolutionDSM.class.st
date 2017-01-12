"
I am a simple draw of evolution group
"
Class {
	#name : #RTEvolutionDSM,
	#superclass : #RTGradualDSM,
	#instVars : [
		'timelineBlock',
		'labelShape'
	],
	#category : #'Roassal2-Builder-DSM'
}

{ #category : #UI }
RTEvolutionDSM >> defaultCellShape [
	^ (RTCompositeShape new 
		add: (RTPolygon rectangle);
		add: ( RTSparkline new
			size: self cellSize);
			color: Color transparent;
		yourself)
]

{ #category : #initialization }
RTEvolutionDSM >> initialize [
	super initialize.
	self timeline: [ :evoline |
		nil ].
	self createObjectBlock: [ :assoc | | inst |
		inst := RTEvolutionLine new 
			xvalue: assoc key;
			yvalue: assoc value.
		inst timeline: (self timeline value: inst).
		inst ].
]

{ #category : #accessing }
RTEvolutionDSM >> labelShape [
	^ labelShape
		ifNil: [ 
			labelShape := RTLabel new
				height: self cellSize;
				text: text]
]

{ #category : #accessing }
RTEvolutionDSM >> labelShape: shape [
	labelShape := shape.
	
]

{ #category : #accessing }
RTEvolutionDSM >> timeline [
	^ timelineBlock
]

{ #category : #accessing }
RTEvolutionDSM >> timeline: aBlock [
	timelineBlock := aBlock
]

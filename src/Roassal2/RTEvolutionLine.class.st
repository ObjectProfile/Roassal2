"
I am a simple object that has values in a timeline
"
Class {
	#name : #RTEvolutionLine,
	#superclass : #RTObject,
	#instVars : [
		'xvalue',
		'timeline',
		'yvalue'
	],
	#category : #'Roassal2-Builder-DSM'
}

{ #category : #ui }
RTEvolutionLine >> gtEvolutionGraphIn: composite [
	<gtInspectorPresentationOrder: -10>
	| b ds |
	^ composite roassal2 
		title: 'Plot';
		initializeView: [ 
			b := RTGrapher new.
			b extent: 300@ 200.
			
			ds := RTData new.
			ds points: self timeline.
			ds x: [ :assoc | self timeline indexOf: assoc ].
			ds y: [ :assoc | assoc value ].
			ds connectUsing: (RTLine new color: Color blue).
			b add: ds.
			
			b axisX 
				labelRotation: -30;
				labelConversion: [ :n | n isZero
					ifTrue: ['']
					ifFalse: [ (self timeline at: n) key ] ];
				numberOfLabels: self timeline size.
			b axisY
				title: self value.
			b build.
			b view ]
]

{ #category : #ui }
RTEvolutionLine >> gtRelativeEvolutionGraphIn: composite [
	<gtInspectorPresentationOrder: -20>
	^ composite roassal2 
		title: 'Relative Plot';
		initializeView: [ self roassalView ]
]

{ #category : #accessing }
RTEvolutionLine >> key [
	^ xvalue
]

{ #category : #printing }
RTEvolutionLine >> printOn: stream [
	stream print: xvalue; nextPutAll: '->'; print: yvalue 
]

{ #category : #accessing }
RTEvolutionLine >> score [
	| score |
	timeline ifNil: [ ^ nil ].
	score := (timeline last value - timeline first value)/timeline first value.
	^ score
]

{ #category : #accessing }
RTEvolutionLine >> timeline [
	^ timeline
]

{ #category : #accessing }
RTEvolutionLine >> timeline: anArray [
	anArray ifNil: [ ^ self ].
	timeline := anArray sort: [ :a :b | a key < b key ]
]

{ #category : #accessing }
RTEvolutionLine >> value [
	^ yvalue
]

{ #category : #accessing }
RTEvolutionLine >> xvalue [
	^ xvalue
]

{ #category : #accessing }
RTEvolutionLine >> xvalue: anObject [
	xvalue := anObject
]

{ #category : #accessing }
RTEvolutionLine >> yvalue [
	^ yvalue
]

{ #category : #accessing }
RTEvolutionLine >> yvalue: anObject [
	yvalue := anObject
]

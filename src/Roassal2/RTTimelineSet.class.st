Class {
	#name : #RTTimelineSet,
	#superclass : #RTObject,
	#instVars : [
		'shapeBuilder',
		'interactionBuilder',
		'start',
		'end',
		'lineIdentifier',
		'objects',
		'globalMin',
		'globalMax'
	],
	#category : #'Roassal2-Builder-Timeline'
}

{ #category : #configuration }
RTTimelineSet >> defaultBarColor [
	^ Color blue alpha: 0.4
]

{ #category : #accessing }
RTTimelineSet >> end [
	^ end
]

{ #category : #accessing }
RTTimelineSet >> end: symbolOrBlockOrValue [
	"The argument will be evaluated on each element of objects."
	end := symbolOrBlockOrValue
]

{ #category : #configuration }
RTTimelineSet >> gapBetweenTimeLines [
	^ 3
]

{ #category : #accessing }
RTTimelineSet >> globalMax [
	^ globalMax
]

{ #category : #accessing }
RTTimelineSet >> globalMax: anObject [
	globalMax := anObject
]

{ #category : #accessing }
RTTimelineSet >> globalMin [
	^ globalMin
]

{ #category : #accessing }
RTTimelineSet >> globalMin: anObject [
	globalMin := anObject
]

{ #category : #initialization }
RTTimelineSet >> initialize [
	super initialize.
	self initializeShapeBuilder.
	self initializeInteractionBuilder.
	lineIdentifier := #yourself.
	start := #yourself.
	end := #yourself.
	objects := #()
]

{ #category : #initialization }
RTTimelineSet >> initializeInteractionBuilder [
	interactionBuilder := RTInteractionBuilder new popup; yourself
]

{ #category : #initialization }
RTTimelineSet >> initializeShapeBuilder [
	shapeBuilder := RTShapeBuilder new.
	shapeBuilder rectangle color: self defaultBarColor
]

{ #category : #accessing }
RTTimelineSet >> lineIdentifier [
	^ lineIdentifier
]

{ #category : #accessing }
RTTimelineSet >> lineIdentifier: symbolOrBlockOrValue [
	"The argument will be evaluated on each element of objects."
	lineIdentifier := symbolOrBlockOrValue
]

{ #category : #'accessing - computed' }
RTTimelineSet >> lineIdentifiers [
	^ objects collect: [ :o | lineIdentifier rtValue: o ]
]

{ #category : #'accessing - computed' }
RTTimelineSet >> localMax [
	^ (objects collect: [ :o | end rtValue: o ]) max
]

{ #category : #'accessing - computed' }
RTTimelineSet >> localMin [
	^ (objects collect: [ :o | start rtValue: o ]) min
]

{ #category : #configuration }
RTTimelineSet >> minimumEventWidth [
	"An event cannot be less than 2 pixels-wide"
	^ 2
]

{ #category : #'accessing - computed' }
RTTimelineSet >> numberOfIdentifier [
	^ self identifiers size
]

{ #category : #'accessing - computed' }
RTTimelineSet >> numberOfLines [
	^ self lineIdentifiers size
]

{ #category : #'accessing - computed' }
RTTimelineSet >> numberOfObjects [
	^ objects size
]

{ #category : #accessing }
RTTimelineSet >> objects [
	^ objects
]

{ #category : #accessing }
RTTimelineSet >> objects: anObject [
	objects := anObject
]

{ #category : #rendering }
RTTimelineSet >> renderIn: view using: timelineBuilder [

	| elements t |
	shapeBuilder 
		height: [ :obj | timelineBuilder extent y / timelineBuilder numberOfLines - self gapBetweenTimeLines ].
		
	elements := shapeBuilder elementsOn: objects.
	interactionBuilder setUpElements: elements.
	view addAll: elements.
	
	"We set the width of the elements"
	RTMetricNormalizer new
		elements: elements;
		normalizeWidth: [ :anObject | (end rtValue: anObject) - (start rtValue: anObject) ]
			min: self minimumEventWidth
			max: timelineBuilder extent x
			minValue: 0
			maxValue: globalMax.

	"For the location"
	t := RTDirectLayoutTranslator new.
	elements do: [ :e | 
		| nx ny indexY |
		nx := ((start rtValue: e model) / globalMax * timelineBuilder extent x).
		indexY := timelineBuilder indexOfLineIdentifier: (lineIdentifier rtValue: e model).
		ny := (timelineBuilder getPixelPositionOf: 0 @ indexY) y.
		t translateTopLeftOf: e to: nx @ ny ].

]

{ #category : #accessing }
RTTimelineSet >> shape [
	^ shapeBuilder
]

{ #category : #accessing }
RTTimelineSet >> start [
	^ start
]

{ #category : #accessing }
RTTimelineSet >> start: symbolOrBlockOrValue [
	"The argument will be evaluated on each element of objects."
	start := symbolOrBlockOrValue
]

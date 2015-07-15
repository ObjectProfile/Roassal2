Class {
	#name : #TRCircleHeadShape,
	#superclass : #TRAbstractLineDecoratorShape,
	#category : #'Trachel-Shapes'
}

{ #category : #hooks }
TRCircleHeadShape >> computePath [
	| vector r unit radius center |
	vector := self to - self from.
	r := vector r.
	r = 0
		ifTrue: [ ^ false ].
	unit := vector / r.
	radius := unit / 2 * size.
	center := self to - radius.
	path := self athensCanvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: center + radius;
				ccwArcTo: center + radius leftRotated angle: 90 degreesToRadians;
				ccwArcTo: center - radius angle: 90 degreesToRadians;
				ccwArcTo: center - radius leftRotated angle: 90 degreesToRadians;
				ccwArcTo: center + radius angle: 90 degreesToRadians ]
]

{ #category : #initialization }
TRCircleHeadShape >> initialize [
	super initialize.
	open := false.
]
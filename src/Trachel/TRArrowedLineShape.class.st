Class {
	#name : #TRArrowedLineShape,
	#superclass : #TRLineShape,
	#instVars : [
		'arrowPath',
		'arrowSize',
		'arrowLeft',
		'arrowRight'
	],
	#category : #'Trachel-Core'
}

{ #category : #accessing }
TRArrowedLineShape >> arrowPath [
	arrowPath ifNil: [ self computeArrowPath].
	^ arrowPath
]

{ #category : #hooks }
TRArrowedLineShape >> computeArrowPath [
	| vector r u unit arrowMiddle |
	vector := self to - self from.
	r := vector r.
	r = 0 ifTrue: [ ^ false ].
	
	u := vector normal.
	unit := vector / r.
	"toPointWithOffset := self to - (offset * (vector r - size) * unit)." "add offset"
	arrowMiddle := self to - (unit * arrowSize). 
	arrowLeft :=  arrowMiddle- (u * arrowSize).
	arrowRight := arrowMiddle + (u * arrowSize).
	arrowPath := self athensCanvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: self to;
				lineTo: arrowLeft;
				lineTo: arrowRight;
				lineTo: self to. ]
]

{ #category : #hooks }
TRArrowedLineShape >> computePath [
	path := self athensCanvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: from;
				lineTo: to ]
]

{ #category : #defaults }
TRArrowedLineShape >> defaultSize [
	^ 10
]

{ #category : #drawing }
TRArrowedLineShape >> drawOn: athensCanvas [

	athensCanvas pathTransform restoreAfter: [
		athensCanvas setShape: self path.
		(athensCanvas setStrokePaint: color) width: width.
		athensCanvas draw ].
	athensCanvas pathTransform restoreAfter: [ 
		athensCanvas setShape: self arrowPath.
		(athensCanvas setStrokePaint: color) width: width.
		athensCanvas draw ]
]

{ #category : #accessing }
TRArrowedLineShape >> encompassingRectangle [
	arrowPath ifNil: [self computeArrowPath].
	^ Rectangle encompassing: (Array with: from with: to with: arrowLeft with: arrowRight)
]

{ #category : #initialization }
TRArrowedLineShape >> initialize [
	super initialize.
	arrowSize := self defaultSize.
]

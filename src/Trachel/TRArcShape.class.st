"
A TRArc is an class that makes all the drawing of arcs
"
Class {
	#name : #TRArcShape,
	#superclass : #TRShape,
	#instVars : [
		'alphaAngle',
		'betaAngle',
		'innerRadius',
		'externalRadius',
		'center',
		'origin',
		'height',
		'width',
		'topLeft',
		'bottomRight'
	],
	#category : #'Trachel-Core'
}

{ #category : #initialization }
TRArcShape >> alphaAngle: stAngle betaAngle: ndAngle innerRadius: iR externalRadius: eR [
	alphaAngle := stAngle.
	betaAngle := ndAngle.
	innerRadius := iR.
	externalRadius := eR 
	
]

{ #category : #accessing }
TRArcShape >> bottomRight [
	self computeBottomRight.
	^ bottomRight 
]

{ #category : #accessing }
TRArcShape >> center [
	^center
]

{ #category : #accessing }
TRArcShape >> center: aPoint [
	center:=aPoint
]

{ #category : #computing }
TRArcShape >> computeBottomRight [
	|aA bA iR eR p1 p2 p3 p4 pR pQ1 pB pQ2 pL pQ3 pT pQ4 pCollection|
	pCollection:= OrderedCollection new.
	aA:=(alphaAngle \\ 360) degreesToRadians .
	bA:=(betaAngle \\ 360) degreesToRadians .
	iR:= innerRadius.
	eR:= externalRadius.
	p1:= (iR*aA cos)@(iR*aA sin) .
	p2:= (iR*bA cos)@(iR*bA sin) .
	p3:= (eR*aA cos)@(eR*aA sin).
	p4:=(eR*bA cos)@(eR*bA sin) .
	pR:=(eR*0 cos) @ (eR*0 sin).
	pQ1:=(eR*(Float pi /4) cos)@(eR*(Float pi /4) sin).
	pB:=(eR*(Float pi /2) cos)@(eR*(Float pi /2) sin).
	pQ2:=(eR*(Float pi * (3/4)) cos)@(eR*(Float pi * (3/4)) sin).
	pL:=(eR*Float pi cos)@(eR*Float pi sin).
	pQ3:=(eR*(Float pi * (5/4)) cos)@(eR*(Float pi * (5/4)) sin).
	pT:=(eR*(Float pi * (3/2)) cos)@(eR*(Float pi * (3/2)) sin).
	pQ4:=(eR*(Float pi * (7/4)) cos)@(eR*(Float pi * (7/4)) sin).
	pCollection add:p1; add: p2; add: p3; add: p4.
	(self includesPoint: pQ1)ifTrue:[pCollection add: pQ1].
	(self includesPoint: pQ2)ifTrue:[pCollection add: pQ2].
	(self includesPoint: pQ3)ifTrue:[pCollection add: pQ3].
	(self includesPoint: pQ4)ifTrue:[pCollection add: pQ4].
	(self includesPoint: pL)ifTrue:[pCollection add: pL].
	(self includesPoint: pR)ifTrue:[pCollection add: pR].
	(self includesPoint: pB)ifTrue:[pCollection add: pB].
	(self includesPoint: pT)ifTrue:[pCollection add: pT].
	bottomRight:=pCollection max x @ pCollection min y
]

{ #category : #computing }
TRArcShape >> computeHeight [
	height:=(self topLeft y - self bottomRight y) abs
]

{ #category : #hooks }
TRArcShape >> computePath [
	|aAngle bAngle|
	aAngle:=alphaAngle degreesToRadians .
	bAngle:=betaAngle  degreesToRadians .
	canvas ifNil: [ ^ self ].
	path := self athensCanvas
				createPath: [ :builder | 
					builder
						absolute;
						moveTo: ((innerRadius * (aAngle cos)) @ (innerRadius * (aAngle sin)));
						arcTo: ((innerRadius * (bAngle cos)) @ (innerRadius * (bAngle sin))) angle: bAngle - aAngle cw: true;
						ccwArcTo: ((externalRadius * (bAngle cos)) @ (externalRadius * (bAngle sin))) angle: 0 degreesToRadians;
						ccwArcTo: ((externalRadius * (aAngle cos)) @ (externalRadius * (aAngle sin)))angle: bAngle - aAngle;
						ccwArcTo: ((innerRadius * (aAngle cos)) @ (innerRadius * (aAngle sin)))angle: 0 degreesToRadians ]
]

{ #category : #computing }
TRArcShape >> computeTopLeft [
	|aA bA iR eR p1 p2 p3 p4 pR pQ1 pB pQ2 pL pQ3 pT pQ4 pCollection|
	pCollection:= OrderedCollection new.
	aA:=(alphaAngle \\ 360) degreesToRadians .
	bA:=(betaAngle \\ 360) degreesToRadians .
	iR:= innerRadius.
	eR:= externalRadius.
	p1:= (iR*aA cos)@(iR*aA sin) .
	p2:= (iR*bA cos)@(iR*bA sin) .
	p3:= (eR*aA cos)@(eR*aA sin).
	p4:=(eR*bA cos)@(eR*bA sin) .
	pR:=(eR*0 cos) @ (eR*0 sin).
	pQ1:=(eR*(Float pi /4) cos)@(eR*(Float pi /4) sin).
	pB:=(eR*(Float pi /2) cos)@(eR*(Float pi /2) sin).
	pQ2:=(eR*(Float pi * (3/4)) cos)@(eR*(Float pi * (3/4)) sin).
	pL:=(eR*Float pi cos)@(eR*Float pi sin).
	pQ3:=(eR*(Float pi * (5/4)) cos)@(eR*(Float pi * (5/4)) sin).
	pT:=(eR*(Float pi * (3/2)) cos)@(eR*(Float pi * (3/2)) sin).
	pQ4:=(eR*(Float pi * (7/4)) cos)@(eR*(Float pi * (7/4)) sin).
	pCollection add:p1; add: p2; add: p3; add: p4.
	(self includesPoint: pQ1)ifTrue:[pCollection add: pQ1].
	(self includesPoint: pQ2)ifTrue:[pCollection add: pQ2].
	(self includesPoint: pQ3)ifTrue:[pCollection add: pQ3].
	(self includesPoint: pQ4)ifTrue:[pCollection add: pQ4].
	(self includesPoint: pL)ifTrue:[pCollection add: pL].
	(self includesPoint: pR)ifTrue:[pCollection add: pR].
	(self includesPoint: pB)ifTrue:[pCollection add: pB].
	(self includesPoint: pT)ifTrue:[pCollection add: pT].
	topLeft:=pCollection min x @ pCollection max y
	
]

{ #category : #computing }
TRArcShape >> computeWidth [
	width:=(self topLeft x - self bottomRight x) abs
]

{ #category : #drawing }
TRArcShape >> drawOn: athensCanvas [
	self shouldBeDrawn ifFalse: [ ^ self ].
	athensCanvas pathTransform restoreAfter: [
		athensCanvas
			setPaint: color;
			drawShape: self path.

		self drawStrokeIfNecessaryOn: athensCanvas
		]
]

{ #category : #drawing }
TRArcShape >> drawStrokeIfNecessaryOn: athensCanvas [
]

{ #category : #accessing }
TRArcShape >> encompassingRectangle [
	^self topLeft corner: self bottomRight
]

{ #category : #accessing }
TRArcShape >> height [
	self computeHeight.
	^ height
]

{ #category : #testing }
TRArcShape >> includesPoint: aPoint [
	| pDistanceOrigin pointAngle inside aAngle bAngle |
	((alphaAngle) = (betaAngle)) ifTrue:[ ^ false ].
	inside:=true.
	(alphaAngle % 360 = 0 ) 
		ifFalse:[aAngle:=alphaAngle \\  360]
		ifTrue:[aAngle:=alphaAngle].
	(betaAngle % 360 = 0 )
		ifFalse:[bAngle:=betaAngle \\  360]
		ifTrue:[bAngle:= betaAngle].
	pointAngle:= ((aPoint x @ aPoint y negated) angleWith: self center) radiansToDegrees \\  360.
	pDistanceOrigin:=(aPoint squaredDistanceTo: self center) sqrt.
	((pDistanceOrigin < innerRadius) or: (pDistanceOrigin > externalRadius))
	ifTrue:[^false].
	(pointAngle % 360 = 0 )
		ifTrue:[
			(aAngle % 360 = 0) ifTrue:[^true].
			(bAngle % 360 = 0) ifTrue:[^true]].
	(aAngle < bAngle)
	ifTrue:[
		(pointAngle >= aAngle) ifTrue:[ inside:=inside not ].
		(pointAngle <= bAngle) ifTrue:[ inside:=inside not ] ]
	ifFalse:[
		(bAngle = 0) ifTrue:[bAngle:=360].
		(pointAngle <= aAngle) ifTrue:[ inside:=inside not ].
		(pointAngle <= bAngle) ifTrue:[ inside:=inside not ] ].
	^ inside
]

{ #category : #initialization }
TRArcShape >> initialize [
	super initialize.
	center := 0 @ 0.
	height := 0.
	width := 0.
	externalRadius := 0.
	innerRadius := 0.
	alphaAngle := 0.
	betaAngle := 0
]

{ #category : #accessing }
TRArcShape >> position [
	^ 0 @ 0
	
]

{ #category : #accessing }
TRArcShape >> topLeft [
	self computeTopLeft.
	^ topLeft
]

{ #category : #accessing }
TRArcShape >> width [
	self computeWidth.
	^ width
]

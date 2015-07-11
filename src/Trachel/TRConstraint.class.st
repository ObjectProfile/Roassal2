"
A ROConstraint is a utility class that contains methods to position elements against others.

"
Class {
	#name : #TRConstraint,
	#superclass : #TRObject,
	#category : #'Trachel-Core'
}

{ #category : #'public - aligning' }
TRConstraint class >> alignFromBottom: shapes [
	| bottomMostElement |
	shapes ifEmpty: [ ^ self ].
	bottomMostElement := shapes inject: shapes anyOne into: [ :maxS :s | 
								maxS encompassingRectangle bottomLeft y >= s encompassingRectangle bottomLeft y
										ifTrue: [ s ] ifFalse: [ maxS ] ].
	self use: bottomMostElement alignFromBottom: shapes
]

{ #category : #'public - aligning' }
TRConstraint class >> alignFromLeft: shapes [
	| leftMostElement |
	shapes ifEmpty: [ ^ self ].
	leftMostElement := shapes inject: shapes anyOne into: [ :maxS :s | 
								maxS encompassingRectangle topLeft x <= s encompassingRectangle topLeft x
										ifTrue: [ s ] ifFalse: [ maxS ] ].
	self use: leftMostElement alignFromLeft: shapes
]

{ #category : #'public - aligning' }
TRConstraint class >> alignFromRight: shapes [
	| rightMostElement |
	shapes ifEmpty: [ ^ self ].
	rightMostElement := shapes inject: shapes anyOne into: [ :maxS :s | 
								maxS encompassingRectangle topLeft x >= s encompassingRectangle topLeft x
										ifTrue: [ s ] ifFalse: [ maxS ] ].
	self use: rightMostElement alignFromRight: shapes
]

{ #category : #'public - aligning' }
TRConstraint class >> alignFromTop: shapes [
	| topMostElement |
	shapes ifEmpty: [ ^ self ].
	topMostElement := shapes inject: shapes anyOne into: [ :maxS :s | 
								maxS encompassingRectangle topLeft y <= s encompassingRectangle topLeft y
										ifTrue: [ s ] ifFalse: [ maxS ] ].
	self use: topMostElement alignFromTop: shapes
]

{ #category : #'public - sticking' }
TRConstraint class >> fix: aShape for: anotherShape [
	"When anotherShape is moved, then move aShape"
	| b |

	b := [ :shape :step | aShape translateBy: step ].
	anotherShape addCallback: (TRTranslationCallback block: b).

	
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape above: anotherShape [
	^ aShape translateTo: anotherShape center - (0 @ ((anotherShape height + aShape height) / 2)) 
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape below: anotherShape [
	^ aShape translateTo: anotherShape center + (0 @ ((anotherShape height + aShape height) / 2)) 
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape below: anotherShape using: translator [
	^ translator translate: aShape to: anotherShape center + (0 @ ((anotherShape height + aShape height) / 2)) 
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape belowAlignFromLeft: anotherShape [
	^ self move: aShape belowAlignFromLeft: anotherShape gap: 0
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape belowAlignFromLeft: anotherShape gap: anInteger [
	^ aShape translateTo: anotherShape center 
		+ (0 @ ((anotherShape height + aShape height) / 2))
		- (((anotherShape width - aShape width) / 2) @ 0)
		+ (0 @ anInteger)
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape between: s1 and: s2 [
	^ aShape translateTo: (s1 position + s2 position) /2 
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape between: s1 and: s2 offset: aFloat [
	^ aShape translateTo: ((s1 position * aFloat) + (s2 position * (1.0 - aFloat)))
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape onTheBottomLeftOf: anotherShape [
	^ aShape translateTo: anotherShape center - ((((anotherShape width/2) rounded) + (aShape width/2 rounded)) @ ((anotherShape height/ -2) rounded))
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape onTheCenterOf: anotherShape [
	^ aShape translateTo: anotherShape center

]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape onTheLeftOf: anotherShape [
	^ aShape translateTo: anotherShape center - ((((anotherShape width/2) rounded) + (aShape width/2 rounded)) @ 0)
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape onTheRightBelowOf: anotherShape [
	^ aShape translateTo: anotherShape center + (((anotherShape extent/2) rounded) + (aShape extent/2 rounded))
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape onTheRightOf: anotherShape [
	^ aShape translateTo: anotherShape center + ((((anotherShape width/2) rounded) + (aShape width/2 rounded)) @ 0)
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape onTheRightOf: anotherShape using: translator [
	^ translator translate: aShape to: anotherShape center + ((((anotherShape width / 2) rounded) + (aShape width/2 rounded)) @ 0)
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape onTheTopLeftOf: anotherShape [
	^ aShape translateTo: anotherShape center - ((((anotherShape width/2) rounded) + (aShape width/2 rounded)) @ ((anotherShape height/ 2) rounded))
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape onTheTopLeftOf: anotherShape withPadding: padding [
	^ self move: aShape onTheTopLeftOf: anotherShape withWidthPadding: padding withHeightPadding: padding
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape onTheTopLeftOf: anotherShape withWidthPadding: widthPadding withHeightPadding: heightPadding [
	| rectangle |
	rectangle := anotherShape encompassingRectangle topLeft.
	^ aShape translateTo: ((rectangle x + (aShape width/2) + widthPadding)@(rectangle y + (aShape height/2) + heightPadding))
]

{ #category : #'public - moving' }
TRConstraint class >> moveAtTheBottomOfTheWindow: trachelShape [

	| windowSize |
	trachelShape canvas ifNil: [ ^ self ].
	windowSize := trachelShape canvas extent.
	trachelShape translateTo: ((trachelShape width / 2) @ (windowSize y - (trachelShape height / 2)))
]

{ #category : #'public - moving' }
TRConstraint class >> moveAtTheBottomRightOfTheWindow: trachelShape [

	| windowSize |
	trachelShape canvas ifNil: [ ^ self ].
	windowSize := trachelShape canvas extent.
	trachelShape translateTo: ((windowSize x - (trachelShape width / 2)) @ (windowSize y negated - (trachelShape height / 2)))
]

{ #category : #'public - camera' }
TRConstraint class >> moveCameraToTheRightIn: trachelCanvas [
	^ trachelCanvas camera translateTo: (trachelCanvas extent x / -2) @ trachelCanvas camera position y
]

{ #category : #'public - resizing' }
TRConstraint class >> setAllToMaxHeight: shapes [
	| maxHeightShape |
	maxHeightShape := shapes inject: shapes anyOne into: [ :maxS :s | 
								maxS height <= s height
										ifTrue: [ s ] ifFalse: [ maxS ] ].
	self useHeightOf: maxHeightShape for: shapes
]

{ #category : #'public - resizing' }
TRConstraint class >> setAllToMaxWidth: shapes [
	| maxWidthShape |
	maxWidthShape := shapes inject: shapes anyOne into: [ :maxS :s | 
								maxS width <= s width
										ifTrue: [ s ] ifFalse: [ maxS ] ].
	self useWidthOf: maxWidthShape for: shapes
]

{ #category : #'public - sticking' }
TRConstraint class >> stick: aShape above: anotherShape [
	| b |
	self move: aShape above: anotherShape. 

	b := [ :shape :step | self move: aShape above: anotherShape ].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b)
	
]

{ #category : #'public - sticking' }
TRConstraint class >> stick: aShape below: anotherShape [
	| b |
	self move: aShape below: anotherShape. 
	b := [ :shape :step | self move: aShape below: anotherShape ].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b) 
	
	
	
]

{ #category : #'public - sticking' }
TRConstraint class >> stick: aShape between: s1 and: s2 [
	^ self stick: aShape between: s1 and: s2 offset: 0.5
]

{ #category : #'public - sticking' }
TRConstraint class >> stick: aShape between: s1 and: s2 offset: aFloat [
	"locate aShape between s1 and s2. aFloat is used to weight the extremities. 
		aFloat = 1.0 the label is on s1.
		aFloat = 0.0 the label is on s2"
	| callback b |
	self move: aShape between: s1 and: s2 offset: aFloat.
	
	b := [ :shape :step | self move: aShape between: s1 and: s2 offset: aFloat ].

	callback := TRTranslationCallback block: b.
	s1 addCallback: callback.
	s2 addCallback: callback.

	callback := TRExtentCallback block: b.
	s1 addCallback: callback.
	s2 addCallback: callback

]

{ #category : #'public - sticking' }
TRConstraint class >> stick: aShape onTheBottomLeftOf: anotherShape [
	| b |
	self move: aShape onTheBottomLeftOf: anotherShape. 
	
	b := [ :shape :step | self move: aShape onTheBottomLeftOf: anotherShape ].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b) 
]

{ #category : #'public - sticking' }
TRConstraint class >> stick: aShape onTheCenterOf: anotherShape [
	| b |
	self move: aShape onTheCenterOf: anotherShape. 
	
	b := [ :shape :step | self move: aShape onTheCenterOf: anotherShape ].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b) 
	
]

{ #category : #'public - sticking' }
TRConstraint class >> stick: aShape onTheLeftOf: anotherShape [
	| b |
	self move: aShape onTheLeftOf: anotherShape. 
	
	b := [ :shape :step | self move: aShape onTheLeftOf: anotherShape ].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b) 
]

{ #category : #'public - sticking' }
TRConstraint class >> stick: aShape onTheRightOf: anotherShape [
	| b |
	self move: aShape onTheRightOf: anotherShape. 
	
	b := [ :shape :step | self move: aShape onTheRightOf: anotherShape ].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b) 
	
]

{ #category : #'public - sticking' }
TRConstraint class >> stick: aShape onTheTopLeftOf: anotherShape [
	| b |
	self move: aShape onTheTopLeftOf: anotherShape. 
	
	b := [ :shape :step | self move: aShape onTheTopLeftOf: anotherShape ].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b) 
	
]

{ #category : #'public - sticking' }
TRConstraint class >> stick: aShape onTheTopLeftOf: anotherShape withPadding: padding [
	| b |
	self move: aShape onTheTopLeftOf: anotherShape withPadding: padding. 
	
	b := [ :shape :step | self move: aShape onTheTopLeftOf: anotherShape withPadding: padding ].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b) 
	
]

{ #category : #'public - sticking' }
TRConstraint class >> stick: aShape onTheTopLeftOf: anotherShape withWidthPadding: widthPadding withHeightPadding: heightPadding [
	| b |
	self move: aShape onTheTopLeftOf: anotherShape withWidthPadding: widthPadding withHeightPadding: heightPadding. 

	b := [ :shape :step | self move: aShape onTheTopLeftOf: anotherShape withWidthPadding: widthPadding withHeightPadding: heightPadding].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b).
]

{ #category : #'public - sticking' }
TRConstraint class >> stickAtTheBottomLeftOfTheWindow: trachelShape [
	self moveAtTheBottomLeftOfTheWindow: trachelShape.
	trachelShape canvas
		when: TRResizeCanvasEvent
		do: [ :event | self moveAtTheBottomLeftOfTheWindow: trachelShape ]
]

{ #category : #'public - sticking' }
TRConstraint class >> stickAtTheBottomOfTheWindow: trachelShape [
	self moveAtTheBottomOfTheWindow: trachelShape.
	trachelShape canvas
		when: TRResizeCanvasEvent
		do: [ :event | self moveAtTheBottomOfTheWindow: trachelShape ]
]

{ #category : #'public - sticking' }
TRConstraint class >> stickAtTheBottomRightOfTheWindow: trachelShape [
	self moveAtTheBottomRightOfTheWindow: trachelShape.
	trachelShape canvas
		when: TRResizeCanvasEvent
		do: [ :event | self moveAtTheBottomRightOfTheWindow: trachelShape ]
]

{ #category : #'public - camera' }
TRConstraint class >> stickCameraToTheRightIn: trachelCanvas [
	trachelCanvas
		when: TRResizeCanvasEvent
		do: [ :event | self moveCameraToTheRightIn: trachelCanvas ]
]

{ #category : #'public - aligning' }
TRConstraint class >> use: aShape alignFromBottom: shapes [
	| topY newY |
	topY := aShape encompassingRectangle bottomCenter y.
	shapes do: [ :s |
		newY := topY - (s encompassingRectangle height / 2).
		s translateTo: s position x @ newY
	]
]

{ #category : #'public - aligning' }
TRConstraint class >> use: aShape alignFromLeft: shapes [
	| topX newX |
	topX := aShape encompassingRectangle topLeft x.
	shapes do: [ :s |
		newX := topX + (s encompassingRectangle width / 2).
		s translateTo: newX @ s position y
	]
]

{ #category : #'public - aligning' }
TRConstraint class >> use: aShape alignFromRight: shapes [
	| topX newX |
	topX := aShape encompassingRectangle topRight x.
	shapes do: [ :s |
		newX := topX - (s encompassingRectangle width / 2).
		s translateTo: newX @ s position y
	]
]

{ #category : #'public - aligning' }
TRConstraint class >> use: aShape alignFromTop: shapes [
	| topY newY |
	topY := aShape encompassingRectangle topCenter y.
	shapes do: [ :s |
		newY := topY + (s encompassingRectangle height / 2).
		s translateTo: s position x @ newY
	]
]

{ #category : #'public - resizing' }
TRConstraint class >> useHeightOf: aShape for: shapes [
	shapes do: [ :s | s height: aShape height ]
]

{ #category : #'public - resizing' }
TRConstraint class >> useWidthOf: aShape for: shapes [
	shapes do: [ :s | s width: aShape width ]
]

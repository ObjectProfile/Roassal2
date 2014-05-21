"
A ROConstraint is a utility class that contains methods to position elements against others.

"
Class {
	#name : #TRConstraint,
	#superclass : #TRObject,
	#category : #'Trachel-Core'
}

{ #category : #util }
TRConstraint class >> move: aShape above: anotherShape [
	^ aShape translateTo: anotherShape center - (0 @ ((anotherShape height + aShape height) / 2)) 
]

{ #category : #util }
TRConstraint class >> move: aShape below: anotherShape [
	^ aShape translateTo: anotherShape center + (0 @ ((anotherShape height + aShape height) / 2)) 
]

{ #category : #util }
TRConstraint class >> move: aShape below: anotherShape using: translator [
	^ translator translate: aShape to: anotherShape center + (0 @ ((anotherShape height + aShape height) / 2)) 
]

{ #category : #util }
TRConstraint class >> move: aShape between: s1 and: s2 [
	^ aShape translateTo: (s1 position + s2 position) /2 
]

{ #category : #util }
TRConstraint class >> move: aShape between: s1 and: s2 offset: aFloat [
	^ aShape translateTo: ((s1 position * aFloat) + (s2 position * (1.0 - aFloat)))
]

{ #category : #util }
TRConstraint class >> move: aShape onTheCenterOf: anotherShape [
	^ aShape translateTo: anotherShape center

]

{ #category : #util }
TRConstraint class >> move: aShape onTheLeftOf: anotherShape [
	^ aShape translateTo: anotherShape center - ((((anotherShape width/2) rounded) + (aShape width/2 rounded)) @ 0)
]

{ #category : #util }
TRConstraint class >> move: aShape onTheRightOf: anotherShape [
	^ aShape translateTo: anotherShape center + ((((anotherShape width/2) rounded) + (aShape width/2 rounded)) @ 0)
]

{ #category : #util }
TRConstraint class >> move: aShape onTheRightOf: anotherShape using: translator [
	^ translator translate: aShape to: anotherShape center + ((((anotherShape width / 2) rounded) + (aShape width/2 rounded)) @ 0)
]

{ #category : #util }
TRConstraint class >> moveAtTheBottomOfTheWindow: trachelShape [

	| windowSize |
	windowSize := trachelShape canvas extent.
	trachelShape translateTo: ((trachelShape width / 2) @ (windowSize y - (trachelShape height / 2)))
]

{ #category : #camera }
TRConstraint class >> moveCameraToTheRightIn: trachelCanvas [
	^ trachelCanvas camera translateTo: (trachelCanvas extent x / -2) @ trachelCanvas camera position y
]

{ #category : #public }
TRConstraint class >> stick: aShape above: anotherShape [
	| b |
	self move: aShape above: anotherShape. 

	b := [ :shape :step | self move: aShape above: anotherShape ].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b)
	
]

{ #category : #public }
TRConstraint class >> stick: aShape below: anotherShape [
	| b |
	self move: aShape below: anotherShape. 
	b := [ :shape :step | self move: aShape below: anotherShape ].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b) 
	
	
	
]

{ #category : #public }
TRConstraint class >> stick: aShape between: s1 and: s2 [
	^ self stick: aShape between: s1 and: s2 offset: 0.5
]

{ #category : #public }
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

{ #category : #public }
TRConstraint class >> stick: aShape onTheCenterOf: anotherShape [
	| b |
	self move: aShape onTheCenterOf: anotherShape. 
	
	b := [ :shape :step | self move: aShape onTheCenterOf: anotherShape ].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b) 
	
]

{ #category : #public }
TRConstraint class >> stick: aShape onTheLeftOf: anotherShape [
	| b |
	self move: aShape onTheLeftOf: anotherShape. 
	
	b := [ :shape :step | self move: aShape onTheLeftOf: anotherShape ].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b) 
]

{ #category : #public }
TRConstraint class >> stick: aShape onTheRightOf: anotherShape [
	| b |
	self move: aShape onTheRightOf: anotherShape. 
	
	b := [ :shape :step | self move: aShape onTheRightOf: anotherShape ].
	anotherShape addCallback: (TRTranslationCallback block: b).
	anotherShape addCallback: (TRExtentCallback block: b) 
	
]

{ #category : #public }
TRConstraint class >> stickAtTheBottomOfTheWindow: trachelShape [
	self moveAtTheBottomOfTheWindow: trachelShape.
	trachelShape canvas
		when: TRResizeCanvasEvent
		do: [ :event | self moveAtTheBottomOfTheWindow: trachelShape ]
]

{ #category : #camera }
TRConstraint class >> stickCameraToTheRightIn: trachelCanvas [
	trachelCanvas
		when: TRResizeCanvasEvent
		do: [ :event | self moveCameraToTheRightIn: trachelCanvas ]
]

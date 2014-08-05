"
A ROConstraint is a utility class that contains methods to position elements against others.

"
Class {
	#name : #TRConstraint,
	#superclass : #TRObject,
	#category : #'Trachel-Core'
}

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
TRConstraint class >> move: aShape between: s1 and: s2 [
	^ aShape translateTo: (s1 position + s2 position) /2 
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape between: s1 and: s2 offset: aFloat [
	^ aShape translateTo: ((s1 position * aFloat) + (s2 position * (1.0 - aFloat)))
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
TRConstraint class >> move: aShape onTheRightOf: anotherShape [
	^ aShape translateTo: anotherShape center + ((((anotherShape width/2) rounded) + (aShape width/2 rounded)) @ 0)
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape onTheRightOf: anotherShape using: translator [
	^ translator translate: aShape to: anotherShape center + ((((anotherShape width / 2) rounded) + (aShape width/2 rounded)) @ 0)
]

{ #category : #'public - moving' }
TRConstraint class >> move: aShape onTheTopLeftOf: anotherShape [
	^ self move: aShape onTheTopLeftOf: anotherShape withPadding: 5
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

{ #category : #'public - camera' }
TRConstraint class >> moveCameraToTheRightIn: trachelCanvas [
	^ trachelCanvas camera translateTo: (trachelCanvas extent x / -2) @ trachelCanvas camera position y
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
TRConstraint class >> stickAtTheBottomOfTheWindow: trachelShape [
	self moveAtTheBottomOfTheWindow: trachelShape.
	trachelShape canvas
		when: TRResizeCanvasEvent
		do: [ :event | self moveAtTheBottomOfTheWindow: trachelShape ]
]

{ #category : #'public - camera' }
TRConstraint class >> stickCameraToTheRightIn: trachelCanvas [
	trachelCanvas
		when: TRResizeCanvasEvent
		do: [ :event | self moveCameraToTheRightIn: trachelCanvas ]
]

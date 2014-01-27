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
TRConstraint class >> move: aShape between: s1 and: s2 [

	^ aShape translateTo: ((s1 position + s2 position) / 2)
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
	self move: aShape above: anotherShape. 
	anotherShape addCallback: 
		(TRTranslationCallback block: [ :shape :step | self move: aShape above: anotherShape ]) 
	
	
]

{ #category : #public }
TRConstraint class >> stick: aShape below: anotherShape [
	self move: aShape below: anotherShape. 
	anotherShape addCallback: 
		(TRTranslationCallback block: [ :shape :step | self move: aShape below: anotherShape ]) 
	
	
]

{ #category : #public }
TRConstraint class >> stick: aShape onTheCenterOf: anotherShape [
	self move: aShape onTheCenterOf: anotherShape. 
	anotherShape addCallback: 
		(TRTranslationCallback block: [ :shape :step | self move: aShape onTheCenterOf: anotherShape ]) 
	
]

{ #category : #public }
TRConstraint class >> stick: aShape onTheLeftOf: anotherShape [
	self move: aShape onTheLeftOf: anotherShape. 
	anotherShape addCallback: 
		(TRTranslationCallback block: [ :shape :step | self move: aShape onTheLeftOf: anotherShape ]) 
	
]

{ #category : #public }
TRConstraint class >> stick: aShape onTheRightOf: anotherShape [
	self move: aShape onTheRightOf: anotherShape. 
	anotherShape addCallback: 
		(TRTranslationCallback block: [ :shape :step | self move: aShape onTheRightOf: anotherShape ]) 
	
]

{ #category : #public }
TRConstraint class >> stickAtTheBottomOfTheWindow: trachelShape [
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

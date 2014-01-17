"
A ROConstraint is a utility class that contains methods to position elements against others.

"
Class {
	#name : #TRConstraint,
	#superclass : #TRObject,
	#category : #Trachel
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
TRConstraint class >> move: element between: el1 and: el2 [

	^ element translateTo: ((el1 position + el2 position) / 2)
]

{ #category : #util }
TRConstraint class >> move: aShape onTheCenterOf: anotherShape [
	aShape translateTo: anotherShape center

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
TRConstraint class >> stickAtTheBottomOfTheWindow: trachelShape [
	trachelShape canvas
		on: TRResizeCanvasEvent
		do: [ :event | self moveAtTheBottomOfTheWindow: trachelShape ]
]

{ #category : #camera }
TRConstraint class >> stickCameraToTheRightIn: trachelCanvas [
	trachelCanvas
		on: TRResizeCanvasEvent
		do: [ :event | self moveCameraToTheRightIn: trachelCanvas ]
]

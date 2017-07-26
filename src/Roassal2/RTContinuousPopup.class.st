"
shows a continous popup in one element
"
Class {
	#name : #RTContinuousPopup,
	#superclass : #RTPopup,
	#instVars : [
		'pointers'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #utility }
RTContinuousPopup >> closestPositionOf: popup from: position inView: aView [
	"Return the closest position for el to realPosition to be entierely visible in the view"
	"position is the location in the space"

	| idealVirtualPosition virtualPositionX virtualPositionY winSize |
	idealVirtualPosition := position.
	winSize := aView canvas extent.
	"Happens if we are in a test"
	winSize ifNil: [ winSize := 500 @ 500 ].
	"Check if the element is within the width of the view"
	virtualPositionX := 
		((idealVirtualPosition x + popup width + self popupOffset x) < winSize x) 
			ifTrue: [ idealVirtualPosition x + self popupOffset x ]
			ifFalse: [ winSize x - popup width - self popupOffset x ].
	virtualPositionX < 0
		ifTrue: [ virtualPositionX := self popupOffset x ].

	virtualPositionY := 
		((idealVirtualPosition y + popup height + self popupOffset y) < winSize y) 
			ifTrue: [ idealVirtualPosition y + self popupOffset y ]
			ifFalse: [ idealVirtualPosition y - popup height - self popupOffset y ].
	virtualPositionY  < 0
		ifTrue: [ virtualPositionY := self popupOffset y ].

	
	^ virtualPositionX @ virtualPositionY
]

{ #category : #initialization }
RTContinuousPopup >> createAndShowPopupFor: element event: event [
	| popupPosition popup idealPosition g |
	self removeLastPopup.
	
	popup := self getNewPopupFor: event.
	
	
	"The following is useful when testing"
	event position isNil
		ifTrue: [ idealPosition := element position ]
		ifFalse: [ idealPosition := element view canvas camera fromSpaceToPixel: event position ].
	popupPosition := self closestPositionOf: popup from: idealPosition inView: element view.

	popup translateTopLeftTo: popupPosition.	
	pointers ifNotNil: [ 
		g := RTGroup new.
		pointers value: g value: event.
		g do: [:x | 
			element view add: x.
			popup add: x ]. ].
	
	self lastPopup: popup.

]

{ #category : #initialization }
RTContinuousPopup >> getNewPopupFor: evt [
	| popupGroup |
	popupGroup := self createPopupFor: evt.
	popupGroup do: [ :e | 
		evt element view add: e. 
		e trachelShape setAsFixed ].
	evt signalUpdate.
	^ popupGroup
]

{ #category : #initialization }
RTContinuousPopup >> initializeElement: element [
	element
		when: TRMouseClick
		do: [ :event | 
			self removeLastPopup.
			element trachelShape signalUpdate ].
	element
		when: TRMouseMove
		do: [ :event |
			self createAndShowPopupFor: element event: event ].
	element
		when: TRMouseLeave
		do: [ :event | 
			self removeLastPopup.
			element trachelShape signalUpdate ].
	element
		when: TRMouseDragging
		do: [ :event | 
			self removeLastPopup.
			element trachelShape signalUpdate ].
]

{ #category : #accessing }
RTContinuousPopup >> pointers [
	^ pointers
]

{ #category : #accessing }
RTContinuousPopup >> pointers: aBlockOfTwoArgs [
	"example
	self pointers: [:anEmptyRTGroup :aMouseMoveEvent | elementsThatShowsThatPointOrPoints]"
	pointers := aBlockOfTwoArgs 
]

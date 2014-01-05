Class {
	#name : #RTAbstractPopup,
	#superclass : #RTInteraction,
	#classInstVars : [
		'lastPopup'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTAbstractPopup class >> lastPopup [
	^ lastPopup
]

{ #category : #'as yet unclassified' }
RTAbstractPopup class >> lastPopup: anElement [
	lastPopup := anElement
]

{ #category : #'as yet unclassified' }
RTAbstractPopup class >> removeLastPopup [
	lastPopup ifNil: [ ^ self ].
	lastPopup view ifNil: [ lastPopup := nil. ^ self ].
	lastPopup remove.
	lastPopup := nil
]

{ #category : #utility }
RTAbstractPopup >> closestPositionOf: popup from: position inView: aView [
	"Return the closest position for el to realPosition to be entierely visible in the view"
	"position is the location in the space"

	| idealVirtualPosition virtualPositionX virtualPositionY winSize |
	idealVirtualPosition := position.
	
	winSize := aView canvas extent.
	"Happens if we are in a test"
	winSize ifNil: [ winSize := 500 @ 500 ].
	
	"If the popup is larger than the window, then there is not much we can do"
	(popup width > winSize x or: [ popup height > winSize y ]) 
		ifTrue: [ ^ idealVirtualPosition + self popupOffset ].
	
	"Check if the element is within the width of the view"
	virtualPositionX := 
		((idealVirtualPosition x + popup width + self popupOffset x) < winSize x) 
			ifTrue: [ idealVirtualPosition x + self popupOffset x ]
			ifFalse: [ idealVirtualPosition x - popup width - self popupOffset x ].
	(aView canvas camera fromSpaceToPixel: virtualPositionX @ 0) x < 0
		ifTrue: [ virtualPositionX := idealVirtualPosition x + self popupOffset x   ].

	virtualPositionY := 
		((idealVirtualPosition y + popup height + self popupOffset y) < winSize y) 
			ifTrue: [ idealVirtualPosition y + self popupOffset y ]
			ifFalse: [ idealVirtualPosition y - popup height - self popupOffset y ].

"	(aView canvas camera fromSpaceToPixel: 0 @ virtualPositionY) y < 0
		ifTrue: [ virtualPositionY := idealVirtualPosition y + self popupOffset y ].
"	
	^ virtualPositionX @ virtualPositionY
]

{ #category : #initialization }
RTAbstractPopup >> createAndShowPopupFor: element event: event [
	| popupPosition popup idealPosition |
	self removeLastPopup.
	
	popup := self createPopupFor: element.
	self lastPopup: popup.
	
	"The following is useful when testing"
	event position isNil
		ifTrue: [ idealPosition := element position ]
		ifFalse: [ idealPosition := event position ].
	popupPosition := self closestPositionOf: popup from: idealPosition inView: element view.

	popup translateTo: popupPosition.	
	element view add: popup.

	popup trachelShape setAsFixed.
	
	^ popup trachelShape signalUpdate
]

{ #category : #hooks }
RTAbstractPopup >> createElementFor: element [
	self subclassResponsibility
]

{ #category : #creation }
RTAbstractPopup >> createPopupFor: element [
	| el |
	el := self createElementFor: element.
	"el on: TRMouseLeave do: [ :e | el view remove: el ifAbsent: [  ] ]."

	"(self receivingViewFor: element) add: el.	"

	"self popups add: el."

	^ el
]

{ #category : #hooks }
RTAbstractPopup >> initializeElement: element [

	element
		on: TRMouseEnter
		do: [ :event | 
			self createAndShowPopupFor: element event: event ].
	element
		on: TRMouseLeave
		do: [ :event | 
			self removeLastPopup.
			element trachelShape signalUpdate ].
	element
		on: TRMouseDragging
		do: [ :event | 
			self removeLastPopup.
			element trachelShape signalUpdate ]
]

{ #category : #utility }
RTAbstractPopup >> lastPopup: anElement [
	self class lastPopup: anElement
]

{ #category : #configuration }
RTAbstractPopup >> popupOffset [
	^ 10 @ 10
]

{ #category : #utility }
RTAbstractPopup >> removeLastPopup [
	self class removeLastPopup
]

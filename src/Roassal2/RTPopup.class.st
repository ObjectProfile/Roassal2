Class {
	#name : #RTPopup,
	#superclass : #RTAbstractPopup,
	#instVars : [
		'text',
		'groupBlock'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTPopup class >> removeLastPopup [
	lastPopup ifNil: [ ^ self ].
	lastPopup remove.
	self resetLastPopup. 
]

{ #category : #'as yet unclassified' }
RTPopup class >> text: aBlockOrSymbol [
	^ self new text: aBlockOrSymbol
]

{ #category : #initialization }
RTPopup >> createAndShowPopupFor: element event: event [
	| popupPosition popup idealPosition |
	self removeLastPopup.
	
	popup := self getNewPopupFor: element.
	self lastPopup: popup.
	
	"The following is useful when testing"
	event position isNil
		ifTrue: [ idealPosition := element position ]
		ifFalse: [ idealPosition := event position ].
	popupPosition := self closestPositionOf: popup from: idealPosition inView: element view.

	popup translateTopLeftTo: popupPosition.	

]

{ #category : #hooks }
RTPopup >> createElementFor: element [
	| g |
	g := RTGroup new.
	groupBlock value: g value: element.
	^ g
]

{ #category : #initialization }
RTPopup >> getNewPopupFor: element [
	| popupGroup |
	popupGroup := self createPopupFor: element.
	popupGroup do: [ :e | element view add: e. e trachelShape setAsFixed ].
	element trachelShape signalUpdate.
	^ popupGroup
]

{ #category : #accessing }
RTPopup >> group: aTwoArgBlock [
	"aTwoArgBlock has to follow the pattern [ :group :element |  ... ]"
	groupBlock := aTwoArgBlock
]

{ #category : #initialization }
RTPopup >> initialize [
	super initialize.
	self text: #yourself
]

{ #category : #accessing }
RTPopup >> simpleText: aOneArgBlock [
	self group: [ :group :element | 
		group add: 
			(RTLabel new 
				color: Color black;
				text: (aOneArgBlock rtValue: element model)) element
		] 

]

{ #category : #accessing }
RTPopup >> text: aOneArgBlock [
	self textElement: [ :el | aOneArgBlock rtValue: el model ]
]

{ #category : #accessing }
RTPopup >> textElement: aOneArgBlock [
	self group: [ :group :element | 
		| backRectangle lbl |
		backRectangle := (RTBox new color: (Color gray alpha: 0.9); borderColor: Color black) element.
		lbl := (RTLabel new 
				color: Color black;
				text: (aOneArgBlock rtValue: element)) element.
		RTNest new centerOn: backRectangle elements: (Array with: lbl).
		group add: backRectangle; add: lbl
		] 

]

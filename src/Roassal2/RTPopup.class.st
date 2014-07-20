"
A RTPopup is xxxxxxxxx.

example of use:
-=-=-=-=-=-=-=-=-=-=-=-=
v := RTView new.

es := RTLabel elementsOn: (1 to: 10).

v addAll: es.

es @ (RTPopup new 
	background: Color blue
	group: [ :group :el |  
 
		group addAll: (RTEllipse elementsOn: (1 to: el model)).
		RTWeightedCircleLayout new
			initialRadius: 50;
			on: group.
		]).

RTHorizontalLineLayout on: es.
v open
-=-=-=-=-=-=-=-=-=-=-=-=
"
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

{ #category : #public }
RTPopup >> background: aColor group: aTwoArgBlock [
	"aTwoArgBlock has to follow the pattern [ :group :element |  ... ]
	group is an empty group. You need to add what you want to be displayed in the popup. el is the element on which the mouse is above."
	
	self group: [ :group :el |
		| b |
		b := (RTBox new color: (aColor alpha: 0.4)) element.
		group add: b.
		aTwoArgBlock value: group value: el.
		RTNest new centerOn: b elements: (group copyWithout: b).
		]
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

{ #category : #public }
RTPopup >> group: aTwoArgBlock [
	"aTwoArgBlock has to follow the pattern [ :group :element |  ... ]
	group is an empty group. You need to add what you want to be displayed in the popup. el is the element on which the mouse is above."
	groupBlock := aTwoArgBlock
]

{ #category : #initialization }
RTPopup >> initialize [
	super initialize.
	self text: #yourself
]

{ #category : #public }
RTPopup >> named: aOneArgBlock background: aColor group: aTwoArgBlock [
	"aTwoArgBlock has to follow the pattern [ :group :element |  ... ]
	group is an empty group. You need to add what you want to be displayed in the popup. el is the element on which the mouse is above."
	
	self group: [ :group :el |
		| background label |
		background := (RTBox new color: (aColor alpha: 0.4)) element.
		label := (RTLabel new text: aOneArgBlock) elementOn: el model.
		
		aTwoArgBlock value: group value: el.
		
		group addFirst: background; addFirst: label.
		RTNest new centerOn: background elements: (group copyWithoutAll: (Array with: background with: label)).
		TRConstraint move: label above: background.
		]
	
]

{ #category : #public }
RTPopup >> namedBackground: aColor group: aTwoArgBlock [
	"aTwoArgBlock has to follow the pattern [ :group :element |  ... ]
	group is an empty group. You need to add what you want to be displayed in the popup. el is the element on which the mouse is above."
	^ self named: #yourself background: aColor group: aTwoArgBlock
]

{ #category : #public }
RTPopup >> simpleText: aOneArgBlock [
	self group: [ :group :element | 
		group add: 
			(RTLabel new 
				color: Color black;
				text: (aOneArgBlock rtValue: element model)) element
		] 

]

{ #category : #public }
RTPopup >> text: aOneArgBlock [
	self textElement: [ :el | aOneArgBlock rtValue: el model ]
]

{ #category : #public }
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

"
A RTPopup is an interaction that dynamically add a text or a group of elements above the element pointed by the mouse.

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
		'groupBlock',
		'text',
		'textColor',
		'alphaPopupBackground',
		'backgroundColor',
		'borderColor'
	],
	#category : #'Roassal2-Interactions'
}

{ #category : #lastPopup }
RTPopup class >> removeLastPopup [
    self lastPopup ifNil: [ ^ self ].
    self lastPopup first view isNotNil ifTrue: [ self lastPopup do: [ :el | el view ifNotNil: [ el remove] ] ].
    self resetLastPopup
]

{ #category : #public }
RTPopup class >> text: aBlockOrSymbol [
	^ self new text: aBlockOrSymbol
]

{ #category : #visitor }
RTPopup >> accept: aVisitor with: args [
	aVisitor visitPopupInteraction: self with: args.
]

{ #category : #accessing }
RTPopup >> alphaPopupBackground [
	"Return the alpha value for the background. The alpha value is useful to make the background transparent"
	^ alphaPopupBackground
]

{ #category : #accessing }
RTPopup >> alphaPopupBackground: aValue [
	"Set the alpha value for the background. The alpha value is useful to make the background transparent"
	alphaPopupBackground := aValue
]

{ #category : #public }
RTPopup >> background: aColor group: aTwoArgBlock [
	"aTwoArgBlock has to follow the pattern [ :group :element |  ... ]
	group is an empty group. You need to add what you want to be displayed in the popup. el is the element on which the mouse is above."
	
	self group: [ :group :el |
		| backgroundElement |
		backgroundElement := self createBackgroundElement: aColor.
		group add: backgroundElement.
		aTwoArgBlock value: group value: el.
		RTNest new centerOn: backgroundElement elements: (group copyWithout: backgroundElement).
		]
]

{ #category : #accessing }
RTPopup >> backgroundColor [
	^ backgroundColor
]

{ #category : #accessing }
RTPopup >> backgroundColor: aColor [
	backgroundColor := aColor
]

{ #category : #accessing }
RTPopup >> borderColor [
	^ borderColor
]

{ #category : #accessing }
RTPopup >> borderColor: aColor [
	borderColor := aColor
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

{ #category : #public }
RTPopup >> createBackgroundElement: aColor [
	^ (RTBox new color: (aColor alpha: self alphaPopupBackground)) element
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
	self text: #yourself.
	textColor := Color black.
	alphaPopupBackground := 0.4.
	backgroundColor := Color gray alpha: 0.8.
	borderColor := Color gray alpha: 0.5
]

{ #category : #public }
RTPopup >> named: aOneArgBlock background: aColor group: aTwoArgBlock [
	"aTwoArgBlock has to follow the pattern [ :group :element |  ... ]
	group is an empty group. You need to add what you want to be displayed in the popup. el is the element on which the mouse is above."

	self
		group: [ :group :el | 
			| background label |
			background := self createBackgroundElement: aColor.
			label := (RTLabel new
				text: aOneArgBlock;
				color: Color black) elementOn: el model.
			aTwoArgBlock value: group value: el.
			group
				addFirst: background;
				addFirst: label.
			RTNest new centerOn: background elements: (group copyWithoutAll: (Array with: background with: label)).
			TRConstraint move: label above: background ]
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

{ #category : #accessing }
RTPopup >> textColor [
	^ textColor
]

{ #category : #accessing }
RTPopup >> textColor: aValueOrABlockOrASymbol [
	textColor := aValueOrABlockOrASymbol
]

{ #category : #public }
RTPopup >> textElement: aOneArgBlock [
	self group: [ :group :element | 
		| backRectangle lbl |
		backRectangle := (RTBox new color: backgroundColor; borderColor: borderColor) element.
		
		lbl := (RTLabel new 
				color: textColor;
				height: [:x | 9];
				text: (aOneArgBlock rtValue: element) asString) element.
		RTNest new centerOn: backRectangle elements: (Array with: lbl).
		group add: backRectangle; add: lbl
		] 

]

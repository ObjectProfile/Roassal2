Class {
	#name : #RTMenuBuilder,
	#superclass : #RTBuilder,
	#category : #'Roassal2-Builder-Menu'
}

{ #category : #public }
RTMenuBuilder class >> setGraphMenuOn: view [

	| b element |
	b := self new view: view.
	b menu: 'Find' background: Color blue callback: [ 
		 
		element := UIManager default chooseFrom: (view elements collect: #model) values: view elements.
		element notNil
			ifTrue: [ view canvas camera translateTo: (view canvas camera fromSpaceToPixel: element position). RTBlink on: element ] ].
]

{ #category : #utility }
RTMenuBuilder >> createBackgroundFor: lbl color: aColor [
	| box |
	box := TRBoxShape new extent: lbl encompassingRectangle extent.
	box color: (aColor alpha: 0.3).
	box strokePaint: nil.
	TRConstraint move: box onTheCenterOf: lbl.
	view canvas addFixedShape: box.
	box pushBack.
	
]

{ #category : #utility }
RTMenuBuilder >> createParentMenu: aTitle [
	| lbl |
	lbl := nil.
	lbl := self createParentMenu: aTitle action: [ self showSubmenuOf: lbl ].
	^ lbl.
	
]

{ #category : #'as yet unclassified' }
RTMenuBuilder >> createParentMenu: aTitle action: action [
	
	| lbl index |
	index := view canvas fixedShapes 
						inject: 0 into: [ :s :e | s max: (e encompassingRectangle topRight x + 10) ].
	lbl := TRLabelShape new text: aTitle; translateLeftTo: index @ 20.
	lbl color: Color black.
	lbl element: (OrderedCollection new add: false; yourself).
	
	lbl when: TRMouseClick do: [ :event | action value. ].
	lbl when: TRMouseEnter do: [ :event | lbl color: Color blue. self signalUpdate ].
	lbl when: TRMouseLeave do: [ :event | lbl color: Color black. self signalUpdate ].
	view canvas addFixedShape: lbl.
	^ lbl
]

{ #category : #utility }
RTMenuBuilder >> createParentMenu: aTitle background: aColor [
	
	| lbl |
	lbl := self createParentMenu: aTitle.
	self createBackgroundFor: lbl color: aColor.
	^ lbl
]

{ #category : #hooks }
RTMenuBuilder >> createView [
	^ RTView new
]

{ #category : #utility }
RTMenuBuilder >> getLabelNamed: aName [
	| labels |
	labels := view canvas fixedShapes select: [ :t | t class == TRLabelShape and: [ t text = aName ] ].
	^ labels isEmpty 
		ifTrue: [ nil ];
		ifFalse: [ labels first ].
	
]

{ #category : #public }
RTMenuBuilder >> menu: aTitle background: aColor callback: callback [ 
	"Return a trachel shape, in which the callback has been set up"
	| lbl |
	lbl := self menu: aTitle callback: callback.
	self createBackgroundFor: lbl color: aColor
]

{ #category : #public }
RTMenuBuilder >> menu: aTitle callback: callback [
	"Return a trachel shape, in which the callback has been set up"
	
	| lbl index |
	index := view canvas fixedShapes 
						inject: 0 into: [ :s :e | s max: (e encompassingRectangle topRight x + 10) ].
	lbl := TRLabelShape new text: aTitle; translateLeftTo: index @ 20.
	lbl color: Color black.
	lbl when: TRMouseClick do: [ :event | callback value ].
	lbl when: TRMouseEnter do: [ :event | lbl color: Color blue. self signalUpdate ].
	lbl when: TRMouseLeave do: [ :event | lbl color: Color black. self signalUpdate ].
	view canvas addFixedShape: lbl.
	^ lbl
]

{ #category : #public }
RTMenuBuilder >> menu: aTitle submenu: aSubMenuName background: aColor callback: callback [
	| parentMenu |
	parentMenu := view canvas fixedShapes select: [ :t | t class == TRLabelShape and: [ t text = aTitle ] ].
	parentMenu isEmpty 
		ifTrue: [ parentMenu := self createParentMenu: aTitle background: aColor ]
		ifFalse: [ parentMenu := parentMenu first ].
	
	parentMenu element add: aSubMenuName -> callback
]

{ #category : #public }
RTMenuBuilder >> menu: aTitle submenu: aSubMenuName callback: callback [
	| parentMenu |
	parentMenu := view canvas fixedShapes select: [ :t | t class == TRLabelShape and: [ t text = aTitle ] ].
	parentMenu isEmpty 
		ifTrue: [ parentMenu := self createParentMenu: aTitle ];
		ifFalse: [ parentMenu := parentMenu first ].
	
	parentMenu element add: aSubMenuName -> callback
]

{ #category : #utility }
RTMenuBuilder >> showSubmenuOf: lbl [

	| assocs labels previousLabel |
	assocs := lbl element.
	
	"Check if submenu is open"
	(assocs at: 1) = true
		ifTrue: [  
			"We mark it as closed"
			assocs at: 1 put: false.
			(assocs copyFrom: 2 to: assocs size) do: [ :as | 
				(self getLabelNamed: as key) remove ].
			self signalUpdate.
			^ self
			].
	
	"We mark the submenu as open" 
	assocs at: 1 put: true.
	
	assocs := assocs copyFrom: 2 to: assocs size.
	labels := assocs collect: [ :as |
						self menu: as key callback: as value
					].
	TRConstraint move: labels first onTheCenterOf: lbl.
	TRConstraint move: labels first below: lbl. 
	
	previousLabel := labels first.
	labels allButFirst do: [ :l | TRConstraint move: l below: previousLabel.  previousLabel := l ].
	self signalUpdate
]

{ #category : #signalling }
RTMenuBuilder >> signalUpdate [
	view canvas signalUpdate
]

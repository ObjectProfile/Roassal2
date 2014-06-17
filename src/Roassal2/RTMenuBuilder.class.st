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
	
	| lbl index |
	index := view canvas fixedShapes 
						inject: 0 into: [ :s :e | s max: (e encompassingRectangle topRight x + 10) ].
	lbl := TRLabelShape new text: aTitle; translateLeftTo: index @ 20.
	lbl color: Color black.
	lbl element: (OrderedCollection new add: false; yourself).
	
	lbl when: TRMouseClick do: [ :event | self showSubmenuOf: lbl ].
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
RTMenuBuilder >> menu: aTitle subcheckmenu: menuname background: color callback: callback [
	| checkmenu |
	checkmenu := nil.
	checkmenu := self
		 menu: aTitle
		 submenu: menuname
		 background: color
		 callback: [ 
			checkmenu selected: checkmenu selected not.
			callback value: checkmenu].
	checkmenu after: [ :menu | 
		menu text: checkmenu label. self signalUpdate].
	^ checkmenu.
]

{ #category : #public }
RTMenuBuilder >> menu: aTitle subcheckmenus: menus background: color [
	"format for menus
	{'Title'->[:m | do something ]}"
	^ menus collect: [ :m |
		self menu: aTitle subcheckmenu: m key background: color callback: m value.
		 ].
]

{ #category : #public }
RTMenuBuilder >> menu: aTitle submenu: aSubMenuName background: aColor callback: callback [
	| parentMenu menuItem |
	parentMenu := view canvas fixedShapes select: [ :t | t class == TRLabelShape and: [ t text = aTitle ] ].
	parentMenu isEmpty 
		ifTrue: [ parentMenu := self createParentMenu: aTitle background: aColor ]
		ifFalse: [ parentMenu := parentMenu first ].
	
	menuItem := RTMenuItem new name: aSubMenuName; callback: callback.
	parentMenu element add: menuItem.
	^ menuItem.
]

{ #category : #public }
RTMenuBuilder >> menu: aTitle submenu: aSubMenuName callback: callback [
	| parentMenu menuItem |
	parentMenu := view canvas fixedShapes select: [ :t | t class == TRLabelShape and: [ t text = aTitle ] ].
	parentMenu isEmpty 
		ifTrue: [ parentMenu := self createParentMenu: aTitle ];
		ifFalse: [ parentMenu := parentMenu first ].
	
	menuItem := RTMenuItem new name: aSubMenuName; callback: callback.
	parentMenu element add: menuItem.
	^ menuItem.
]

{ #category : #public }
RTMenuBuilder >> menu: aTitle submenus: menus background: aColor callback: callback [
	^ menus collect: [ :m | 
		self menu: aTitle submenu: m key background: aColor callback: callback].
]

{ #category : #utility }
RTMenuBuilder >> showSubmenuOf: lbl [

	| items labels previousLabel |
	items := lbl element.
	
	"Check if submenu is open"
	(items at: 1) = true
		ifTrue: [  
			"We mark it as closed"
			items at: 1 put: false.
			(items copyFrom: 2 to: items size) do: [ :item | 
				(self getLabelNamed: item label) remove ].
			self signalUpdate.
			^ self
			].
	
	"We mark the submenu as open" 
	items at: 1 put: true.
	
	items := items copyFrom: 2 to: items size.
	labels := items collect: [ :item | | m |
		m := nil.
		m := self menu: item label callback: [item execute: m].
		item menu: m.
		m ].
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

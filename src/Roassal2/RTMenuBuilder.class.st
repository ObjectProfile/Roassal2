Class {
	#name : #RTMenuBuilder,
	#superclass : #RTBuilder,
	#category : 'Roassal2-Builder-Menu'
}

{ #category : #public }
RTMenuBuilder class >> setGraphMenuOn: view [
	| builder element |
	builder := self new view: view.
	builder
		menu: 'Find'
		background: Color blue
		callback: [ 
			element := UIManager default
				chooseFrom: (view elements collect: #model)
				values: view elements.
			element notNil
				ifTrue: [
					view canvas camera translateTo: element position.
					RTBlink on: element ] ].
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
	^ box
	
]

{ #category : #utility }
RTMenuBuilder >> createParentMenu: aTitle [
	
	| lbl index |
	index := view canvas fixedShapes 
						inject: 0 into: [ :s :e | s max: (e encompassingRectangle topRight x + 10) ].
	lbl := TRLabelShape new text: aTitle; translateLeftTo: index @ 20.
	lbl color: Color black.
	lbl element: (RTMenu new view: view).
	
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
		menu text: checkmenu label.
		checkmenu background extent: menu encompassingRectangle extent.
		self signalUpdate].
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
	
	menuItem := RTMenuItem new name: aSubMenuName; callback: callback; color: aColor.
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

{ #category : #'as yet unclassified' }
RTMenuBuilder >> menu: aTitle submenus: menus background: aColor [
	^ menus collect: [ :m | 
		self menu: aTitle submenu: m key background: aColor callback: m value].
]

{ #category : #utility }
RTMenuBuilder >> showSubmenuOf: lbl [

	| menu labels backgrounds |
	menu := lbl element.
	
	"Check if submenu is open"
	menu isOpen
		ifTrue: [ menu hideItems.
			self signalUpdate.
			 ^ self].
	
	"We mark the submenu as open" 
	menu hideAll.
	menu isOpen: true.
	backgrounds := OrderedCollection new.
	labels := menu items collect: [ :item | | m |
		m := nil.
		m := self menu: item label callback: [item execute: m].
		item menu: m.
		item background: (self createBackgroundFor: m color: item color).
		backgrounds add: item background.
		m ].
	
	labels doWithIndex: [ :l :i | | p back |
		p := ((lbl position x) + (l width/2) - (lbl width/2) )@(lbl position y + (l height*i)).
		back := backgrounds at: i.
		l translateTo: lbl position.
		back translateTo: lbl position.
		view addAnimation: (RTLinearMove to: p during: 0.2 on: l).
		view addAnimation: (RTLinearMove to: p during: 0.2 on: back).
	].
	self signalUpdate
]

{ #category : #signalling }
RTMenuBuilder >> signalUpdate [
	view canvas signalUpdate
]

Class {
	#name : #RTMenuBuilderExamples,
	#superclass : #RTBuilder,
	#category : #'Roassal2-Builder-Menu'
}

{ #category : #examples }
RTMenuBuilderExamples >> example01 [

	"
	self new example01
	"
	| v b |
	v := RTView new.
	
	b := RTMenuBuilder new view: v.
	b menu: 'add values' background: Color red callback: [ 
		| es |
		es := (RTLabel new color: [ :tt| Color random ]) elementsOn: (1 to: 10).
		es do: [ :e | e translateTo: ((500 atRandom @ 500 atRandom) - (250 @ 250)) ].
		v addAll: es. 
		v canvas signalUpdate ].
	
	b menu: 'remove odd' callback: [ (v elements select: [ :e | e model odd ]) do: #remove. v canvas signalUpdate ].
	b menu: 'remove even' callback: [ (v elements select: [ :e | e model even ]) do: #remove. v canvas signalUpdate ].

	b menu: 'shuffle' callback: [ 
		| tra |
		tra := RTSmoothLayoutTranslator new.
		tra nbCycles: 0.5.
		(v elements do: [ :e | tra translate: e to: ((500 atRandom @ 500 atRandom) - (250 @ 250)) ]) ].		

	v open
]

{ #category : #examples }
RTMenuBuilderExamples >> example02 [

	"
	self new example02
	"
	| v b |
	v := RTView new.
	
	b := RTMenuBuilder new view: v.
	b menu: 'add' submenu: '10' background: Color red callback: [ 
		| es |
		es := (RTLabel new color: [ :tt| Color random ]) elementsOn: (1 to: 10).
		es do: [ :e | e translateTo: ((500 atRandom @ 500 atRandom) - (250 @ 250)) ].
		v addAll: es. 
		v canvas signalUpdate ].

	b menu: 'add' submenu: '20' background: Color red callback: [ 
		| es |
		es := (RTLabel new color: [ :tt| Color random ]) elementsOn: (1 to: 20).
		es do: [ :e | e translateTo: ((500 atRandom @ 500 atRandom) - (250 @ 250)) ].
		v addAll: es. 
		v canvas signalUpdate ].

	
	b menu: 'remove' submenu: 'odd' background: Color red callback: [ (v elements select: [ :e | e model odd ]) do: #remove. v canvas signalUpdate ].
	b menu: 'remove' submenu: 'even' background: Color red callback: [ (v elements select: [ :e | e model even ]) do: #remove. v canvas signalUpdate ].

	b menu: 'shuffle' callback: [ 
		| tra |
		tra := RTSmoothLayoutTranslator new.
		tra nbCycles: 0.5.
		(v elements do: [ :e | tra translate: e to: ((500 atRandom @ 500 atRandom) - (250 @ 250)) ]) ].		

	v open
]

{ #category : #examples }
RTMenuBuilderExamples >> example03 [

	"
	self new example03
	"
	| v b menus withBorder withText shape |
	v := RTView new.
	withBorder := false.
	withText := false.
	shape := false.
	
	b := RTMenuBuilder new view: v.
	menus := { 
		'with border'->[:m | withBorder := m selected ].
		'with text'->[:m | withText := m selected].
		'ellipse'->[:m | shape := m selected] }.
			
	b menu: 'add element' callback: [ 
		| e t s |
		t := withText ifTrue:['Demo'] ifFalse: [ '...' ].
		e := RTLabel elementOn: t.
		
		v add: e. 
		RTVerticalLineLayout on: v elements.
		s := (shape ifTrue: [TREllipseShape] ifFalse: [TRBoxShape])
		 new extent: e encompassingRectangle extent.
		s color: Color green.
		s strokePaint: (withBorder ifTrue: [Color black] ifFalse: [nil]).
		TRConstraint move: s onTheCenterOf: e.
		v canvas addShape: s.
		s pushBack.
		v canvas signalUpdate ].
	menus := b menu: 'options' subcheckmenus: menus background: Color red.
	v open.
]

{ #category : #examples }
RTMenuBuilderExamples >> example04 [

	"
	self new example04
	"
	| v b menus withBorder withBackground text shape |
	v := RTView new.
	withBorder := false.
	withBackground := true.
	text := 'test'.
	shape := TREllipseShape.
	b := RTMenuBuilder new view: v.
	
	b menu: 'add element' callback: [ 
		| e  s |
		
		e := RTLabel elementOn: text.
		v add: e. 
		RTVerticalLineLayout on: v elements.
		s := shape new extent: e encompassingRectangle extent.
		s color: (withBackground ifTrue: [Color green] ifFalse: [Color transparent]).
		s strokePaint: (withBorder ifTrue: [Color black] ifFalse: [nil]).
		TRConstraint move: s onTheCenterOf: e.
		v canvas addShape: s.
		s pushBack.
		v canvas signalUpdate ].
	b menu: 'Text' callback: [ text := text,'test'. ].

	menus := { 
		'Ellipse'->[:m | shape := TREllipseShape ].
		'Box'->[:m | shape := TRBoxShape] }.
	
	menus := b menu: 'Shape' subcheckmenus: menus background: Color red.
	RTMenuGroup on: menus.
	menus first selected: true.
	
	menus := { 
		'with background'->[:m | withBackground := m selected].
		'with border'->[:m | withBorder := m selected] }.
	menus := b menu: 'opions' subcheckmenus: menus background: Color green.
	menus first selected: true.
	v open.
]

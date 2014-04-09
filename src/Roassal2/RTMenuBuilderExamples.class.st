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

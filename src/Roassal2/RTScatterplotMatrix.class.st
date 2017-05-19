"
I am a basic builder to build a matrix of scatterplot with roassal
"
Class {
	#name : #RTScatterplotMatrix,
	#superclass : #RTAbstractGrapher,
	#instVars : [
		'metrics',
		'objects',
		'xScales',
		'yScales',
		'padding',
		'boxSize',
		'shouldUseAxisForX',
		'shouldUseAxisForY',
		'generator',
		'lineShape',
		'boxShape',
		'allowEvent',
		'boxes',
		'allDotElements',
		'labelShape'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #helpers }
RTScatterplotMatrix >> addBrushInteractionIfNecessary: aView [
	| int |
	self allowSelectableView ifFalse: [ ^ self ].
	int := RTBrushInteraction new.
	int elementsToBrush: [ :group | 
		group flatCollect: [ :e | aView elementsFromModel: e model ] ].
	int domainElements: self allDotElements.
	int groups: self boxes.
	aView @ int.
]

{ #category : #accesing }
RTScatterplotMatrix >> allDotElements [
	^ allDotElements
]

{ #category : #accesing }
RTScatterplotMatrix >> allowSelectableView [
	^ allowEvent
]

{ #category : #accesing }
RTScatterplotMatrix >> allowSelectableView: aBool [
	allowEvent := aBool
]

{ #category : #accesing }
RTScatterplotMatrix >> boxShape [
	^ boxShape
]

{ #category : #accesing }
RTScatterplotMatrix >> boxShape: aShape [
	boxShape := aShape
]

{ #category : #accesing }
RTScatterplotMatrix >> boxes [
	^ boxes ifNil: [ boxes := RTGroup new ].
]

{ #category : #helpers }
RTScatterplotMatrix >> createAxisIfNecessary: aView [
	self createAxisXIfNecessary: aView.
	self createAxisYIfNecessary: aView.
	aView edges do: #pushBack 
]

{ #category : #helpers }
RTScatterplotMatrix >> createAxisXIfNecessary: aView [
	| m min max v box line e1 e2 edge axe nticks result delta size scale |
	shouldUseAxisForX ifFalse: [ ^ self ].
	m := self metrics.
	size := (boxSize*m keys size) + (padding * m keys size) + (boxSize/2)+ (padding/2).
	box := RTBox new size: 0.
	line := self lineShape.
	axe := self axisX.
	m keys doWithIndex: [ :m0 :j |
		min := Float fmax.
		max := Float fmin.
		delta := ((boxSize*j) + (padding * j))@0.
		
		self objects do: [ :o |
			v := (m at: m0) rtValue: o.
			min := min min: v.
			max := max max: v.
			 ]. 
		nticks := axe numberOfTicks.
		nticks isZero ifTrue: [ nticks := 2 ].
		result := generator searchMin: min max: max desired: axe numberOfTicks.
		scale := xScales at: m0.
		(result min to: result max by: result step) do: [ :n |
			e1 := box element.
			e2 := box element.
			edge := RTEdge from: e1 to: e2.
			edge + line.
			v := scale scale: n.
			e1 translateTo: v @(boxSize/2).
			e2 translateTo: v @size.
			e1 translateBy: delta.
			e2 translateBy: delta.
			view add: e1; add: e2; add: edge ].
		axe minValue: result min;
			maxValue: result max;
			numberOfTicks: result numberOfTicks;
			numberOfLabels: result numberOfTicks;
			axisFrom: ((scale scale: result min)@size) + delta
			to: ((scale scale: result max)@size) + delta
		].
	


]

{ #category : #helpers }
RTScatterplotMatrix >> createAxisYIfNecessary: aView [
	| m min max v box line e1 e2 edge axe nticks result delta size scale |
	shouldUseAxisForY ifFalse: [ ^ self ].
	m := self metrics.
	size := (boxSize*m keys size) + (padding * m keys size) + (boxSize/2)+ (padding/2).
	box := RTBox new size: 0.
	line := self lineShape.
	axe := self axisY.
	m keys doWithIndex: [ :m0 :j |
		min := Float fmax.
		max := Float fmin.
		delta := 0@((boxSize*j) + (padding * j)).
		
		self objects do: [ :o |
			v := (m at: m0) rtValue: o.
			min := min min: v.
			max := max max: v.
			 ]. 
		nticks := axe numberOfTicks.
		nticks isZero ifTrue: [ nticks := 2 ].
		result := generator searchMin: min max: max desired: axe numberOfTicks.
		scale := yScales at: m0.
		(result min to: result max by: result step) do: [ :n |
			e1 := box element.
			e2 := box element.
			edge := RTEdge from: e1 to: e2.
			edge + line.
			v := scale scale: n.
			e1 translateTo: (boxSize/2)@v.
			e2 translateTo: size@v.
			e1 translateBy: delta.
			e2 translateBy: delta.
			view add: e1; add: e2; add: edge ].
		axe minValue: result min;
			maxValue: result max;
			numberOfTicks: result numberOfTicks;
			numberOfLabels: result numberOfTicks;
			axisFrom: ( (boxSize/2) @(scale scale: result min)) + delta
			to: ( (boxSize/2) @(scale scale: result max)) + delta
		].
	


]

{ #category : #hooks }
RTScatterplotMatrix >> createView [
	^ RTView new @ RTDraggableView @ RTZoomableView  
]

{ #category : #initialization }
RTScatterplotMatrix >> initialize [
	super initialize.
	self padding: 15.
	self scatterBoxSize: 150.
	self shouldUseAxis: true.
	self allowSelectableView: true.
	
	self shape circle 
		size: 4; 
		color: (Color colorFrom: '#020289').
	self boxShape: (RTBox new size: self scatterBoxSize;
		color: Color transparent; 
		borderColor: Color veryLightGray).
	self lineShape: (RTLine new color: Color veryLightGray trans).
	self labelShape: (RTLabel new).
	
	generator := RTLabelGenerator nice: RTNiceStepSizeGenerator new.
	generator setLooseFlag: true.
	metrics := Dictionary new.
	

]

{ #category : #accessing }
RTScatterplotMatrix >> labelShape [
	^ labelShape
]

{ #category : #accessing }
RTScatterplotMatrix >> labelShape: aShape [
	labelShape := aShape
]

{ #category : #accesing }
RTScatterplotMatrix >> lineShape [
	^ lineShape
]

{ #category : #accesing }
RTScatterplotMatrix >> lineShape: aShape [
	lineShape := aShape
]

{ #category : #accesing }
RTScatterplotMatrix >> metrics [
	^ metrics
]

{ #category : #accesing }
RTScatterplotMatrix >> objects [
	^ objects
]

{ #category : #accessing }
RTScatterplotMatrix >> objects: aCollection [
	objects := aCollection
]

{ #category : #accesing }
RTScatterplotMatrix >> padding [
	^ padding
]

{ #category : #accesing }
RTScatterplotMatrix >> padding: aNumber [
	padding := aNumber
]

{ #category : #helpers }
RTScatterplotMatrix >> prepareScales [
	| domain range x y m value | 
	xScales := Dictionary new.
	yScales := Dictionary new.
	m := self metrics.
	
	m keys do: [ :k |
		value := m at: k.
		domain := Array 
			with: (value value: (objects minFor: value)) 
			with: (value value: (objects maxFor: value)).
		range := Array with: (padding /2)-(boxSize /2) with: (boxSize/2) - (padding/2).
		x := RTScale linear domain: domain; range: range.
		y := RTScale linear domain: domain; range: range reverse.
		xScales at: k put: x.
		yScales at: k put: y ].
]

{ #category : #hooks }
RTScatterplotMatrix >> renderIn: aView [
	self renderMatrix: aView.
	self createAxisIfNecessary: aView.
	self addBrushInteractionIfNecessary: aView.
]

{ #category : #rendering }
RTScatterplotMatrix >> renderMatrix: aView [
	| m elements x y box delta label |
	m := self metrics.
	self prepareScales.
	allDotElements := RTGroup new.
	m keys doWithIndex: [ :metric1 :j | 
		m keys doWithIndex: [ :metric2 :k |
			delta := ((k@j)* boxSize)+((k@j)*padding).
			box := self boxShape elementOn: k@j.
			box translateBy: delta.
			self boxes add: box.
			
			k = j ifTrue: [
				label := self labelShape elementOn: metric1.
				RTConstraint new
					fix: box; movable: label; inner;
					left; top; move.
				aView add: label  ].
			
			aView add: box.
			elements := self shape elementsOn: self objects.
			elements do: [ :e | 
				x := (xScales at: metric1) scale: ((m at: metric1) rtValue: e model).
				y := (yScales at: metric2) scale: ((m at: metric2) rtValue: e model).
				e translateTo: (x @ y)+delta ].
			allDotElements addAll: elements.
			aView addAll: elements.
			 ].
		].
]

{ #category : #accesing }
RTScatterplotMatrix >> scatterBoxSize [
	^ boxSize
]

{ #category : #accesing }
RTScatterplotMatrix >> scatterBoxSize: aNumber [
	boxSize := aNumber
]

{ #category : #accesing }
RTScatterplotMatrix >> shouldUseAxis: aBool [
	self shouldUseAxisForX: aBool.
	self shouldUseAxisForY: aBool.
	
]

{ #category : #accesing }
RTScatterplotMatrix >> shouldUseAxisForX: aBool [
	shouldUseAxisForX := aBool
	
]

{ #category : #accesing }
RTScatterplotMatrix >> shouldUseAxisForY: aBool [
	shouldUseAxisForY := aBool
	
]

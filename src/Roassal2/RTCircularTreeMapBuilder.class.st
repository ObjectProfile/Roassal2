"
I am a variation of RTTreeMapBuilder in to explore in a better way any tree representation

"
Class {
	#name : #RTCircularTreeMapBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'popup',
		'elements',
		'rootNodes',
		'weight',
		'baseradius'
	],
	#category : #'Roassal2-Builder-CircularMap'
}

{ #category : #accessing }
RTCircularTreeMapBuilder >> baseradius [
	^ baseradius
]

{ #category : #accessing }
RTCircularTreeMapBuilder >> baseradius: r [
	baseradius := r.
]

{ #category : #private }
RTCircularTreeMapBuilder >> createElements: atree using: ablock depth: depth [
	| children e |
	e := ( shapeBuilder elementOn: atree) @ popup @ RTFocusElement animated.
	self elements add: e.
	
	children := ablock rtValue: atree.
	e attributes at: #depth put: depth.
	children := children collect: [ :child | | e2 |
		e2 := self createElements: child using: ablock depth: depth+1.
		e2 attributes at: #parent put: e.
		e2  ].
	children ifNotNil: [ e attributes at: #children put: children ].
	
	^ e	
]

{ #category : #hooks }
RTCircularTreeMapBuilder >> createView [
	^ super createView @ RTDraggableView @ RTZoomableView.
]

{ #category : #'default-values' }
RTCircularTreeMapBuilder >> defaultBase [
	^ 250
]

{ #category : #accessing }
RTCircularTreeMapBuilder >> elements [
	^ elements
]

{ #category : #layout }
RTCircularTreeMapBuilder >> expandCircle: e with: parent [

	e trachelShape position: parent x @ parent y.
	e trachelShape extent: (parent r*2) @ (parent r*2).
	
]

{ #category : #layout }
RTCircularTreeMapBuilder >> expandCircles: e parent: parent [
	"
	RTCircularTreeMapExample new example01
	"
	| cc |
	self expandCircle: e with: parent.
	(e attributes includesKey: #children) ifFalse: [ ^ self ].
	(e attributes at: #children) do: [ :child | 
		(child attributes includesKey: #circle) ifTrue: [ 
			cc := self relToAbsCircle: (child attributes at: #circle) parent: parent.
			self expandCircles: child parent: cc ] ].
]

{ #category : #building }
RTCircularTreeMapBuilder >> explore: atree using: ablock [
	^ (self from: (Array with: atree) using: ablock ) first.
]

{ #category : #private }
RTCircularTreeMapBuilder >> findBestGapIn: gaps children: children index: i 
	cbounding: cbounding bounds: bounds circles: circles
	 distance: distance closest: closest gap: gap ncircles: ncircles [
	| gapCircle cdistance |
	
	gaps do: [ :cgap | 
		gapCircle := cgap makeGapCircle: (self weight2rad: (self weightOf: (children at: i) )).
		cdistance := RTCircleTree distanceOf: cbounding and: gapCircle.
		cdistance < distance ifTrue: [ 
			cgap circles third isNotNil ifTrue: [ 
				(RTCircleTree doIntersect: cgap circles third with: gapCircle )
				ifTrue: [ cdistance := Float fmax. ] ]
			ifFalse: [ 
				[ :br | 
					((bounds findStart: gapCircle) to: ncircles) do: [ :ccircle |
						(RTCircleTree doIntersect: (circles at: ccircle) with: gapCircle)
						ifTrue: [ cdistance := Float fmax. br value ] ]
				] valueWithExit.  ] ].
		cdistance < distance ifTrue: [ 
			^ Array with: cdistance with: gapCircle with: cgap.  ].
	].
	^ Array with: distance with: closest with: gap
]

{ #category : #building }
RTCircularTreeMapBuilder >> from: objects using: ablock [
	rootNodes := objects collect: [ :obj | self createElements: obj using: ablock depth: 1 ].
	^ rootNodes.
]

{ #category : #initialization }
RTCircularTreeMapBuilder >> initialize [
	super initialize.
	shapeBuilder circle
		fillColor: Color white;
		borderColor: Color gray.
	popup := RTPopup new.
	baseradius := self defaultBase.
	elements := OrderedCollection new.
	rootNodes := OrderedCollection new.
]

{ #category : #layout }
RTCircularTreeMapBuilder >> layout: e [
	
	| children |
	(e attributes includesKey: #children) ifFalse: [ ^ self ].
	
	children := e attributes at: #children.
	children isEmpty ifTrue: [ ^ self ].
	
	children do: [ :child | self layout: child ].
	self sortChildren: children.
	self layoutNodes: children
	
]

{ #category : #layout }
RTCircularTreeMapBuilder >> layoutElements [
	| virtualRoot |
	virtualRoot := RTEllipse elementOn: nil.
	virtualRoot attributes at: #children put: rootNodes.
	self layout: virtualRoot.
	
	self expandCircles: virtualRoot parent: (RTCircleTree new r: self baseradius)
]

{ #category : #private }
RTCircularTreeMapBuilder >> layoutNodes: children [
	"
	RTCircularTreeMapExample new example01
	"
	| size circles bounds firstCircle cbounding circle distance   scale |
	size := children size.
	size > 100 ifTrue: [ size := 100 ].
	circles := OrderedCollection new: size.
	size = 0 ifTrue: [ ^ self ].
	
	bounds := RTBounds new max: 100.
	
	firstCircle := RTCircleTree new r: (self weight2rad: (self weightOf: children first)).
	circles add: firstCircle.
	cbounding := bounds push: firstCircle index: 1.
	size > 1 ifTrue: [ 
		circle  := RTCircleTree new r: (self weight2rad: (self weightOf: children second)) .
		circle translateBy: firstCircle center.
		circle translateBy: (RTVector new x: firstCircle r + circle r y: 0).
		circles add: circle.
		cbounding := bounds push: circle index: 2.
		size > 2 ifTrue: [ 
			| gaps closest gap ncircles |
			gaps := OrderedCollection new.
			gaps add: (RTGapTree new c1: firstCircle c2: circle).
			gaps add: (RTGapTree new c1: circle c2: firstCircle).
			ncircles := 2.
			closest := nil.
			gap := nil.
			(3 to: size) do: [ :i | | arr |
				distance := Float fmax.
				closest := nil.
				gap := nil.
				arr := self findBestGapIn: gaps children: children index: i 
					cbounding: cbounding bounds: bounds circles: circles 
					distance: distance closest: closest gap: gap ncircles: ncircles.
				
				distance := arr first.
				closest := arr second.
				gap := arr third.
				
				gaps remove: gap.
				gap addGapsTo: gaps closest: closest.
				circles add: closest.
				ncircles := ncircles + 1.
				(cbounding r < (distance + closest r)) 
					ifTrue: [ cbounding := bounds push: closest index: ncircles  ].
				
			] ] ].

	scale := 1/ cbounding r.
	(1 to: size) do: [ :i | | c |
		c := circles at: i.
		c translateBy: (cbounding center scaleBy: -1).
		c scaleFull: scale.
		(children at: i) attributes at: #circle put: c.
	 ].
	
	^ circles.
]

{ #category : #accessing }
RTCircularTreeMapBuilder >> popup [
	^ popup
]

{ #category : #layout }
RTCircularTreeMapBuilder >> relToAbsCircle: rel parent: parent [
	"
	RTCircularTreeMapExample new example02
	"
	| res |
	res := RTCircleTree new x: rel x y: rel y r: rel r.
	res scaleFull: parent r.
	res translateBy: (parent x @ parent y).
	^ res
]

{ #category : #hooks }
RTCircularTreeMapBuilder >> renderIn: aView [
	aView addAll: self elements.
	self layoutElements.
]

{ #category : #accessing }
RTCircularTreeMapBuilder >> rootNodes [
	^ rootNodes 
]

{ #category : #layout }
RTCircularTreeMapBuilder >> sortChildren: children [
	children sort: [ :a :b | (self weightOf: a) > (self weightOf: b) ].
]

{ #category : #accessing }
RTCircularTreeMapBuilder >> weight [
	^ weight
]

{ #category : #layout }
RTCircularTreeMapBuilder >> weight2rad: w [
	^ (w / Float pi) sqrt
]

{ #category : #accessing }
RTCircularTreeMapBuilder >> weight: ablockorsymbol [
	weight := ablockorsymbol 
]

{ #category : #accessing }
RTCircularTreeMapBuilder >> weightOf: e [
	(e attributes includesKey: #weight)
		ifTrue: [ ^ e attributes at: #weight ]
		ifFalse: [ | w |
			w := self weight rtValue: e model.
			w isNumber ifFalse: [ w := 1 ].
			e attributes at:#weight put: w.
			^ w ]
	 
]

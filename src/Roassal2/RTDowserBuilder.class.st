"
A RTDowserBuilder is Builder for Roassal2 that allows you to relate group of elements as columns using edges that represent the given relationship.
"
Class {
	#name : #RTDowserBuilder,
	#superclass : #Object,
	#instVars : [
		'columns',
		'view',
		'models',
		'title',
		'legend',
		'body',
		'bodyElement',
		'overBody',
		'labels',
		'colors',
		'edgeColor',
		'viewWidth',
		'distance',
		'popups',
		'popupElement',
		'heights',
		'width',
		'lineShape',
		'edges',
		'shadowEdges'
	],
	#category : #'Roassal2-Builder-Dowser'
}

{ #category : #coloring }
RTDowserBuilder class >> defaultEdgeColor [
	^ Color r: (123/256) g: (50/256) b: (148/256) 
]

{ #category : #coloring }
RTDowserBuilder class >> defaultElementColor [
	^ Color r: (0/256) g: (136/256) b: (55/256) 
]

{ #category : #coloring }
RTDowserBuilder class >> defaultLightEdgeColor [
	^ Color r: (194/256) g: (165/256) b: (207/256) 
]

{ #category : #coloring }
RTDowserBuilder class >> errorColor [
	^ Color r: (202/256) g: 0 b: (32/256)
]

{ #category : #coloring }
RTDowserBuilder class >> normalizerBotom [
	^ Color r: (199/256) g: (233/256) b: (192/256)
]

{ #category : #coloring }
RTDowserBuilder class >> normalizerTop [
	^ Color r: 0 g: (68/256) b: (27/256)
]

{ #category : #accessing }
RTDowserBuilder >> addColumn: aCollection [
	self models addAll: aCollection.
	columns add: (self from: aCollection in: (columns size + 1))
]

{ #category : #'private-edge-management' }
RTDowserBuilder >> addLinesfrom: aNode toAll: aCollection from: anotherCollection color: aColor [
	| ce1 ce2 ce3 ce4 p1 p2 p3 p4 lines |
	lines := OrderedCollection new.
	aCollection
		do: [ :l | | ed dif |
			dif := (aNode position y + (aNode height / 2)) - (l position y + (l height / 2)).
			(dif abs) < 5 
				ifTrue: [ ed := (RTLine new color: aColor) edgeFrom: aNode to: l	]
				ifFalse: [  
					p1 := self controlPoint: aNode with: l.
					ce1 := self controlElement: p1.
					p4 := self controlPoint: l with: aNode.
					ce4 := self controlElement: p4.
					p2 := self controlPoint2: aNode with: l.
					ce2 := self controlElement: p2.
					p3 := self controlPoint2: l with: aNode.
					ce3 := self controlElement: p3.
					ed := self bezierLine: aNode to: l with: ce1 with: ce2 with: ce3 with: ce4 color: aColor 
					].
			lines add: {ed to . ed}.
			view add: ed.
			 ].
	lines do: [ :l | l second trachelShape pushBack ].
	self view canvas signalUpdate.
	^lines
]

{ #category : #'private-shape-managment' }
RTDowserBuilder >> addPopup: element from: aCollection [
	| pop |
	element outgoingEdges isEmpty
		ifFalse: [ 
			pop := self popupElement value: element.
			pop model = 1 ifFalse: [  
				popups at: element 
				ifPresent: [:v |  self view add: v ]
				ifAbsent: [
					popups at: element put: pop.
					self view add: pop.
					self stickTop: pop on: element from: aCollection]]].
		 
]

{ #category : #'private-relations' }
RTDowserBuilder >> assignMissing: aBlock from: aNumber to: anotherNumber [
	| values aux |
	values := OrderedCollection new.
	aux := (columns at: aNumber) collect: [ :l | (aBlock value: l model) ].
	aux do: [ :e | (e isCollection not or: (e isString)) ifTrue: [values add: e] ifFalse: [values addAll: e] ].
	values removeDuplicates.
	columns at: anotherNumber put: (self from: values in: anotherNumber)
]

{ #category : #'private-edge-management' }
RTDowserBuilder >> bezierLine: anElement to: anotherElement with: controlPoint1 with: controlPoint2 with: controlPoint3 with: controlPoint4 color: aColor [
	| line controls|
	lineShape 
		ifTrue: [ 
			"Find the right way to do that :S" 
			controls := {controlPoint1 . controlPoint2 . controlPoint3 . controlPoint4}]
		ifFalse:[
			controls := {controlPoint1 . controlPoint2 . controlPoint3 . controlPoint4}].	
	line := (RTBezierLine new controllingElements: controls; color: aColor) 
						edgeFrom: anElement to: anotherElement.
	^line	
]

{ #category : #accessing }
RTDowserBuilder >> body [
	^body
]

{ #category : #accessing }
RTDowserBuilder >> body: aText [
	body := aText
]

{ #category : #'private-edge-management' }
RTDowserBuilder >> check: aBlock from: s to: f [
       | v r t |
		r := false.
	   (aBlock numArgs = 2)
			ifTrue: [r := (aBlock value: s value: f) ]
			ifFalse: [
				t := (aBlock value: s).
				v := (t = f).
				v	ifTrue: [ r := v] 
					ifFalse:[ t isCollection 
						ifTrue: [ r := t includes: f]]].
       ^r
]

{ #category : #accessing }
RTDowserBuilder >> color: aColor [
	colors ifNil: [colors := Dictionary new].
	colors at: 1 put: aColor.
]

{ #category : #accessing }
RTDowserBuilder >> color: aColor at: aNumber [
	colors ifNil: [colors := Dictionary new].
	colors at: aNumber put: aColor.
]

{ #category : #'private-edge-management' }
RTDowserBuilder >> controlElement: p1 [
	| elem |
	elem := (RTBox new color: Color transparent) element translateTo: p1.
	^elem
	
]

{ #category : #'private-edge-management' }
RTDowserBuilder >> controlPoint2: aNode with: anotherNode [
	| p1 p2 |
	p1 := aNode position.
	p2 := anotherNode position.
	^(p1 y < p2 y)
		ifTrue: [ 
			(p1 x < p2 x)
				ifTrue: [ (p1 x + ((p2 x - (p1 x)) / 2)) @ (p1 y + ((p2 y - (p1 y)) / 4))]
				ifFalse: [ (p1 x - ((p1 x - (p2 x)) / 2)) @ (p1 y + ((p2 y - (p1 y)) / 4))]] 
		ifFalse: [ 
			(p1 x < p2 x)
				ifTrue: [ (p1 x + ((p2 x - (p1 x)) / 2)) @ (p1 y - ((p1 y - (p2 y)) / 4))]
				ifFalse: [ (p1 x - ((p1 x - (p2 x)) / 2)) @ (p1 y - ((p1 y - (p2 y)) / 4))]] 
]

{ #category : #'private-edge-management' }
RTDowserBuilder >> controlPoint: aNode with: anotherNode [
	| p1 p2 |
	p1 := aNode position.
	p2 := anotherNode position.
	^ (p1 x < p2 x)
				ifTrue: [ (p1 x + ((p2 x - (p1 x)) / 4)) @ (p1 y) ]
				ifFalse: [ (p1 x - ((p1 x - (p2 x)) / 4)) @ (p1 y) ]
]

{ #category : #accessing }
RTDowserBuilder >> distance [
	^distance
]

{ #category : #accessing }
RTDowserBuilder >> distance: aNumber [
	distance := aNumber
]

{ #category : #accessing }
RTDowserBuilder >> edgeColor [
	^edgeColor
]

{ #category : #accessing }
RTDowserBuilder >> edgeColor: aColor [
	edgeColor := aColor
]

{ #category : #'adding edges' }
RTDowserBuilder >> edgesFrom: aBlock [
	(1 to: columns size - 1) 
		do: [ :n |  
			self edgesWith: aBlock from: n to: (n + 1).
			self edgesWith: aBlock to: (n + 1) from: n].
]

{ #category : #'adding edges' }
RTDowserBuilder >> edgesTo: aBlock [
	(1 to: columns size - 1) 
		do: [ :n |  
			self edgesWith: aBlock to: n from: (n + 1).
			self edgesWith: aBlock from: (n + 1) to: n].
]

{ #category : #'adding edges' }
RTDowserBuilder >> edgesWith: aBlock from: aNumber to: anotherNumber [
	(columns at: aNumber) 
		ifEmpty: [ columns at: aNumber put: self fromModel ].
	(columns at: anotherNumber) 
		ifEmpty: [ self assignMissing: aBlock from: aNumber to: anotherNumber ].
	self relation: aBlock with: aNumber with: anotherNumber direction: 'from'.
	self view addAll: (columns at: aNumber).
]

{ #category : #'adding edges' }
RTDowserBuilder >> edgesWith: aBlock to: aNumber from: anotherNumber [
	(columns at: aNumber) 
		ifEmpty: [ columns at: aNumber put: self fromModel ].
	(columns at: anotherNumber) 
		ifEmpty: [ self assignMissing: aBlock from: aNumber to: anotherNumber ].
	self relation: aBlock with: aNumber with: anotherNumber direction: 'to'.
	self view addAll: (columns at: aNumber).
]

{ #category : #'private-shape-managment' }
RTDowserBuilder >> fixText: aText [
	|results accumulator oldAccumulator texts|
	results := OrderedCollection new.
	texts := aText subStrings: ' '.
	accumulator := ''.
	texts do: [ :text |
		oldAccumulator := accumulator.
		accumulator := accumulator, ' ', text.
		(accumulator size > 40)
			ifTrue: [ 
				results add: oldAccumulator. 
				accumulator := text].
	].
	results add: accumulator.
	^results
	
]

{ #category : #'private-shape-managment' }
RTDowserBuilder >> from: aCollection in: aNumber [
	|h w dictionary normalizer c color height|
	color := (colors at: (aNumber + 1) ifAbsent: [ colors at: 1 ]).
	height := (heights at: (aNumber + 1) ifAbsent: [ heights at: 1 ]).
	h := [ :v | [(height value: v)] on: Error do: [ 10 ] ].
	w := [ :v | [(self width value: v)] on: Error do: [ 10 ] ].
	color isColor 
		ifTrue: [ c := [ :v | color]]
		ifFalse: [  
			dictionary := Dictionary new.
			aCollection do: [ :e | dictionary at: e put: ([(color value: e)] on: Error do: [0] ) ].
			normalizer := self getNormalizerfrom: dictionary.
			c := [ :v | [normalizer rtValue: (color value: v)] on: Error do: [ self class errorColor ] ]].
	^(aCollection collect: [ :m | | elem |
		elem := RTElement on: m.
		elem + (RTBox new height: (h value: m); width: (w value: m); color: (c value: m))]).
]

{ #category : #'private-shape-managment' }
RTDowserBuilder >> fromModel [
	^(self from: (self models) in: 1)
]

{ #category : #'private-shape-managment' }
RTDowserBuilder >> getNormalizerfrom: aDictionary [
	^(RTNColorLinearNormalizer inContext: (aDictionary values) lowColor: (self class normalizerBotom) highColor: (self class normalizerTop)).
]

{ #category : #'private-edge-management' }
RTDowserBuilder >> greyLinesfrom: aNode in: aCollection to: links [
	aNode
		when: TRMouseEnter
		do: [ :event | 
			shadowEdges at: aNode	
				ifPresent: [ :v |
					(v isNotEmpty and: [v first second to = links first])
						ifTrue: [  
							v do: [ :e | 
								self view add: e second.
								e second from: aNode.
								e second to: e first. 
								e second trachelShape pushBack].							
							]
						ifFalse: [
							v addAll: (self
								addLinesfrom: aNode
								toAll: links
								from: aCollection
								color: self class defaultLightEdgeColor) ]. 
							self view canvas signalUpdate.
							bodyElement trachelShape pushBack.]
				ifAbsent: [
					shadowEdges at: aNode put: 
					(self
						addLinesfrom: aNode
						toAll: links
						from: aCollection
						color: self class defaultLightEdgeColor)].
			"bodyElement shape color: Color veryVeryLightGray."
			bodyElement trachelShape pushBack.].
	aNode
		when: TRMouseLeave
		do: [ :event | |v|
			v := true.
			shadowEdges at: aNode	
				ifPresent: [ :node | node do: [ :e | e second remove]].
			self view canvas signalUpdate.
			overBody do: [ :e|  v := v or: [e]]. 
			v ifFalse: [ bodyElement shape color: Color darkGray].
			bodyElement trachelShape pushBack.].
]

{ #category : #accessing }
RTDowserBuilder >> height: aBlock [
	heights ifNil: [heights := Dictionary new].
	heights at: 1 put: aBlock.
]

{ #category : #accessing }
RTDowserBuilder >> height: aBlock at: aNumber [
	heights ifNil: [heights := Dictionary new].
	heights at: aNumber put: aBlock.
]

{ #category : #initialization }
RTDowserBuilder >> initialize [
	view := RTView new.
	models := OrderedCollection new.
	columns := OrderedCollection new.
	popups := Dictionary new.
	edges := Dictionary new.
	shadowEdges := Dictionary new.
	title := 'RoassalDowser'.
	legend := 'Roassal Dowser'.
	body := ''.
	self label: #asString.
	self color: self class defaultElementColor.
	self edgeColor: self class defaultEdgeColor.
	self height: 10.
	width := 10.
	lineShape := false.
	overBody := Dictionary new.
	popupElement := [ :elem | (RTElement on: ((elem outgoingEdges select: [:e | (e trachelShape strokePaint diff: self edgeColor) <= 0.1]) size)) 
		+ (RTLabel new height: 14; color: self edgeColor) ].
	viewWidth := 500.
]

{ #category : #accessing }
RTDowserBuilder >> label: aMessage [
	labels ifNil: [labels := Dictionary new].
	labels at: 1 put: aMessage.
]

{ #category : #accessing }
RTDowserBuilder >> label: aMessage at: aNumber [
	labels ifNil: [labels := Dictionary new].
	labels at: aNumber put: aMessage.
]

{ #category : #'private-shape-managment' }
RTDowserBuilder >> labels: aNumber [
	| maxWidth label|
	maxWidth := 0.
	label := (labels at: (aNumber + 1) ifAbsent: [labels at: 1]).
	(columns at: aNumber) do: [:l | | lab | 
		lab := (RTElement on: (label value: l model)) + RTLabel.
		lab @ RTHighlightable.
		maxWidth := maxWidth max: (lab width).
		self view add: lab.
		self stick: lab on: l from: (columns at: aNumber)].
	^maxWidth 
]

{ #category : #accessing }
RTDowserBuilder >> legend [
	^legend
]

{ #category : #accessing }
RTDowserBuilder >> legend: aString [
	legend := aString 
]

{ #category : #'private-edge-management' }
RTDowserBuilder >> lines: aNode in: aCollection to: links [
	aNode
		when: TRMouseClick
		do: [ :event | 
			edges at: aNode		
				ifPresent: [ :v |
					(v isNotEmpty)
						ifTrue: [
							(v first second to = links first)
								ifTrue: [  
									( v first second trachelShape isInACanvas)
										ifTrue: [ | val |
											val := false.
											v do: [ :e | e second remove].
											self removePopup: aNode.
											overBody at: aNode put: false.
											overBody do: [ :e|  val := val or: [e]]. 
											val ifFalse: [ "bodyElement shape color: Color darkGray"]]
										ifFalse: [ 
											v do: [ :e | 
												self view add: e second.
												e second from: aNode.
												e second to: e first.
												e second trachelShape pushBack]. 
											self addPopup: aNode from: aCollection.
											overBody at: aNode put: true. 
											"bodyElement shape color: Color veryVeryLightGray"]]
								ifFalse:[
									(v last second to = links last)
												ifFalse: [ 						
													v addAll: (self
														addLinesfrom: aNode
														toAll: links
														from: aCollection
														color: self edgeColor).
													edges at: aNode put: v.
													self addPopup: aNode from: aCollection.
													overBody at: aNode put: true.
													"bodyElement shape color: Color veryVeryLightGray"]]].
					bodyElement trachelShape pushBack.
					self view canvas signalUpdate]
				ifAbsent: [
					edges at: aNode put: 
					(self
						addLinesfrom: aNode
						toAll: links
						from: aCollection
						color: self edgeColor).
					((shadowEdges at: aNode) size = ((edges at:aNode) size))
						ifTrue: [  
							self addPopup: aNode from: aCollection.
							overBody at: aNode put: true.
							"bodyElement shape color: Color veryVeryLightGray"].
					bodyElement trachelShape pushBack.]]
]

{ #category : #'private-edge-management' }
RTDowserBuilder >> linesFrom: aCollection to: anotherCollection with: aBlock [
	aCollection
		do: [ :n1 | 
			| links |
			links := self linksFrom: n1 with: aBlock to: anotherCollection.
			self
				lines: n1
				in: aCollection
				to: links.
			self
				greyLinesfrom: n1
				in: aCollection
				to: links ].
]

{ #category : #'private-edge-management' }
RTDowserBuilder >> linesTo: aCollection from: anotherCollection with: aBlock [
	aCollection
		do: [ :n1 | 
			| links |
			links := self linksTo: n1 with: aBlock to: anotherCollection.
			self
				lines: n1
				in: aCollection
				to: links.
			self
				greyLinesfrom: n1
				in: aCollection
				to: links ].
]

{ #category : #'private-edge-management' }
RTDowserBuilder >> linksFrom: aNode with: aBlock to: otherCollection [
	| links aux |
	aux := otherCollection
		collect: [ :e | 
			{e.
			aNode} ].
	links := aux
		select: [ :e | 
			| f s v |
			f := e first model.
			s := e second model.
			v := self check: aBlock from: f to: s.
			v ].
	links := links collect: [ :l | l first ].
	^ links
]

{ #category : #'private-edge-management' }
RTDowserBuilder >> linksTo: aNode with: aBlock to: otherCollection [
	| links aux |
	aux := otherCollection
		collect: [ :e | 
			{e.
			aNode} ].
	links := aux
		select: [ :e | 
			| f s v |
			f := e first model.
			s := e second model.
			v := self check: aBlock from: s to: f.
			v ].
	links := links collect: [ :l | l first ].
	^ links
]

{ #category : #'private-relations' }
RTDowserBuilder >> makeBlock: aBlock [
	| newBlock |
	aBlock isBlock
		ifTrue: [ newBlock := aBlock ]
		ifFalse: [ 
			newBlock := [ :a :b | 
			| v |
			v := aBlock value: a.
			(v includes: b)
				ifTrue: [ true ]
				ifFalse: [ v = b ] ] ].
	^ newBlock
]

{ #category : #accessing }
RTDowserBuilder >> models [
	^models
]

{ #category : #accessing }
RTDowserBuilder >> models: aCollection [
	models := aCollection
]

{ #category : #accessing }
RTDowserBuilder >> octopiEdges [
	lineShape := true.
]

{ #category : #'instance creation' }
RTDowserBuilder >> open [
	columns do: [:c |  (self view elements includes: (c anyOne)) ifFalse: [self view addAll: c] ].
	self view @ RTVerticalDraggableView.
	self view canvas signalUpdate.
	self view openInWindowSized: ((self viewWidth) @ 500) titled: (self title).
]

{ #category : #accessing }
RTDowserBuilder >> popupElement [
	^popupElement
]

{ #category : #accessing }
RTDowserBuilder >> popupElement: aBlock [
	popupElement := aBlock
]

{ #category : #accessing }
RTDowserBuilder >> popups [
	^popups
]

{ #category : #'private-shape-managment' }
RTDowserBuilder >> positionateTowers [
	|maxWidths maxHeight legendElement legTrans translations accum bod bodyParts|
	translations := OrderedCollection new.
	
	maxHeight := (columns collect: [ :c | (c collect: [ :l | l height ]) max]) max.

	columns do: [ :c | (RTVerticalLineLayout withGap: 10) on: c ].	
	
	maxWidths := (1 to: columns size) collect: [ :n | self labels: n].
	
	distance := ((self models size * maxHeight ln * 5) max: 300) min: 400.	

	legendElement := (RTElement on: (self legend)) +  (RTLabel new height: 18).
	self view add: legendElement.
	legTrans := (((maxWidths at: 1) / 2) + (maxWidths allButLast sum / 2) + (columns size * 20)
				+ (((columns size - 1) * distance) / 2) - (legendElement position x)) max: 0.
	legendElement translateBy: legTrans @ 0.
	
	accum := (maxWidths at: 1) + 30.
	translations add: accum.
	(2 to: columns size) do: [ :n | | translation |
			translation := accum + distance.
			accum := translation + (maxWidths at: n) + 30. 
			translations add: translation].
		
	1 to: (columns size) do: [ :n | (columns at: n) do: [ :e | e translateBy: (translations at: n) @ 40]].	

	bodyParts := ((self fixText: (self body )) collect: [ :t | (RTElement on: t) +  (RTLabel new color: Color veryLightGray)]).
	bod := (RTElement new) + (RTBox new color: Color lightGray).
	
	RTNest new layout: RTVerticalLineLayout new; on: bod nest: (RTGroup withAll: bodyParts).
	bodyElement := bod.
	self view add: bod.
	self view addAll: bodyParts.
	bodyParts do: [ :b | b when: TREvent do: [:e | self view announce: e] ].
	bod when: TREvent do: [:e | self view announce: e].
	
	viewWidth := (columns size * distance) + (maxWidths sum) max: (legendElement width).
	bod translateTo: ( ((maxWidths at: 1) + distance - (bod width / 2) ) @ ((bodyParts first height) * (bodyParts size))).
	bod trachelShape pushBack.
	
	^ distance
]

{ #category : #'private-relations' }
RTDowserBuilder >> relation: aBlock	with: aNumber with: anotherNumber direction: aString [
	| newBlock |
	newBlock := self makeBlock: aBlock.
	self distance isNil ifTrue: [ distance := self positionateTowers].
	aString = 'to' 
		ifTrue: [ self linesTo: (columns at: aNumber) from: (columns at: anotherNumber) with: newBlock]
		ifFalse: [ self linesFrom: (columns at: aNumber) to: (columns at: anotherNumber) with: newBlock]
]

{ #category : #'private-shape-managment' }
RTDowserBuilder >> removePopup: element [
	(popups at: element ifAbsent:[^false]) remove. 
]

{ #category : #'private-shape-managment' }
RTDowserBuilder >> stick: aLabel on: anElement from: aCollection [
	(aCollection = (columns at: 1))
		ifTrue: [ TRConstraint stick: (aLabel trachelShape) onTheLeftOf: (anElement trachelShape) ]
		ifFalse: [ 
			(aCollection = (columns at: (columns size)))
				ifTrue: [ TRConstraint stick: (aLabel trachelShape) onTheRightOf: (anElement trachelShape) ]
				ifFalse: [ TRConstraint stick: (aLabel trachelShape) above: (anElement trachelShape) ]]
	
]

{ #category : #'private-shape-managment' }
RTDowserBuilder >> stickTop: aLabel on: anElement from: aCollection [
	(aCollection = (columns at: 1))
						ifTrue:  [ aLabel translateTo: anElement position + 
							((anElement width + (aLabel width) + 5) @ ((anElement height / 2) - (aLabel height)))]
						ifFalse: [ aLabel translateTo: anElement position + 
							((anElement width + (aLabel width) + 5) negated @ ((anElement height / 2) - (aLabel height)))]
	
]

{ #category : #accessing }
RTDowserBuilder >> title [
	^title
]

{ #category : #accessing }
RTDowserBuilder >> title: aString [
	title := aString 
]

{ #category : #accessing }
RTDowserBuilder >> view [
	^view
]

{ #category : #accessing }
RTDowserBuilder >> view: aView [
	view := aView
]

{ #category : #accessing }
RTDowserBuilder >> viewWidth [
	^viewWidth
]

{ #category : #accessing }
RTDowserBuilder >> width [
	^width
]

{ #category : #accessing }
RTDowserBuilder >> width: aNumber [
	width := aNumber
]

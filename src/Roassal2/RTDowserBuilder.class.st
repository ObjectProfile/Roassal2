Class {
	#name : #RTDowserBuilder,
	#superclass : #Object,
	#instVars : [
		'view',
		'models',
		'title',
		'legend',
		'body',
		'bodyElement',
		'overBody',
		'left',
		'right',
		'labelLeft',
		'labelRight',
		'colorLeft',
		'colorRight',
		'edgeColor',
		'viewWidth',
		'distance',
		'direction',
		'popups',
		'popupElement',
		'heightLeft',
		'heightRight',
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

{ #category : #'edge-management' }
RTDowserBuilder >> addLinesfrom: aNode toAll: aCollection from: anotherCollection color: aColor [
	| ce1 ce2 ce3 ce4 p1 p2 p3 p4 lines |
	lines := OrderedCollection new.
	aCollection
		do: [ :l | | ed dif |
			dif := (aNode position y + (aNode height / 2)) - (l position y + (l height / 2)).
			(dif abs) < 5 
				ifTrue: [ ed := (RTLine new color:aColor) edgeFrom: aNode to: l	]
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
			lines add: ed.
			view add: ed.
			 ].
	lines do: [ :l | l trachelShape pushBack ].
	self view canvas signalUpdate.
	^lines
]

{ #category : #'shape-managment' }
RTDowserBuilder >> addPopup: element from: aCollection [
	| pop |
	element outgoingEdges isEmpty
		ifTrue: [ Transcript show: 'hola' ] 
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

{ #category : #relations }
RTDowserBuilder >> assignMissing: aBlock from: aCollection [
	| values aux otherCollection |
	aCollection = left
		ifTrue: [ otherCollection := right ]
		ifFalse:[ otherCollection := left ].
	values := OrderedCollection new.
	aux := aCollection collect: [ :l | (aBlock value: l model) ].
	aux do: [ :e | (e isCollection not or: (e isString)) ifTrue: [values add: e] ifFalse: [values addAll: e] ].
	values removeDuplicates.
	otherCollection = left
		ifTrue: [ left := (self from: values in: 'left') ]
		ifFalse:[ right := (self from: values in: 'right')].
]

{ #category : #'edge-management' }
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

{ #category : #'edge-management' }
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
	self colorLeft: aColor.
	self colorRight: aColor
]

{ #category : #accessing }
RTDowserBuilder >> colorLeft [
	^colorLeft
]

{ #category : #accessing }
RTDowserBuilder >> colorLeft: aMessage [
	^colorLeft := aMessage
]

{ #category : #accessing }
RTDowserBuilder >> colorRight [
	^colorRight
]

{ #category : #accessing }
RTDowserBuilder >> colorRight: aMessage [
	^colorRight := aMessage
]

{ #category : #'edge-management' }
RTDowserBuilder >> controlElement: p1 [
	| elem |
	elem := (RTBox new color: Color transparent) element translateTo: p1.
	^elem
	
]

{ #category : #'edge-management' }
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

{ #category : #'edge-management' }
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
	self edgesFromLeft: aBlock.
	self edgesToLeft: aBlock.
]

{ #category : #'adding edges' }
RTDowserBuilder >> edgesFromLeft:  aBlock [
	left ifEmpty: [ left := self fromModel ].
	right ifEmpty: [ self assignMissing: aBlock from: left ].
	direction := 'from'.
	self relationLeft: aBlock.
	self view addAll: left.
]

{ #category : #'adding edges' }
RTDowserBuilder >> edgesFromLeft: aBlock edgesFromRight: anotherBlock [
	self edgesFromLeft: aBlock.
	self edgesFromRight: anotherBlock.
]

{ #category : #'adding edges' }
RTDowserBuilder >> edgesFromLeft: aBlock edgesToLeft: anotherBlock [
	self edgesFromLeft: aBlock.
	self edgesToLeft: anotherBlock.
]

{ #category : #'adding edges' }
RTDowserBuilder >> edgesFromRight: aBlock [
	right ifEmpty: [ right := self fromModel ].
	left ifEmpty: [ self assignMissing: aBlock from: right ].
	direction := 'from'.
	self relationRight: aBlock.
	self view addAll: right
]

{ #category : #'adding edges' }
RTDowserBuilder >> edgesTo: aBlock [
	self edgesToRight: aBlock.
	self edgesFromRight: aBlock.
]

{ #category : #'adding edges' }
RTDowserBuilder >> edgesToLeft:  aBlock [
	right ifEmpty: [ right :=  self fromModel].
	left ifEmpty: [ self assignMissing: aBlock from: right ].
	direction := 'to'.
	self relationRight: aBlock.
	self view addAll: right.
]

{ #category : #'adding edges' }
RTDowserBuilder >> edgesToLeft: aBlock edgesToRight: anotherBlock [
	self edgesToLeft: aBlock.
	self edgesToRight: anotherBlock.
]

{ #category : #'adding edges' }
RTDowserBuilder >> edgesToRight:  aBlock [
	left ifEmpty: [ left := self fromModel].
	right ifEmpty: [ self assignMissing: aBlock from: left ].
	direction := 'to'.
	self relationLeft: aBlock.
	self view addAll: left.
]

{ #category : #'adding edges' }
RTDowserBuilder >> edgesToRight: aBlock edgesFromRight: anotherBlock [
	self edgesToRight: aBlock.
	self edgesFromRight: anotherBlock.
]

{ #category : #'shape-managment' }
RTDowserBuilder >> from: aCollection in: aString [
	|h w dictionary normalizer c color height|
	(aString = 'left')
		ifTrue: [ color := self colorLeft.
				 height := self heightLeft  ]
		ifFalse: [ color := self colorRight.
				 height := self heightRight ].
	color ifNil: [ color := self colorRight].
	height ifNil: [ height := self heightRight].
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

{ #category : #'shape-managment' }
RTDowserBuilder >> fromModel [
	^(self from: (self models) in: 'left')
]

{ #category : #'shape-managment' }
RTDowserBuilder >> getNormalizerfrom: aDictionary [
	^(RTNColorLinearNormalizer inContext: (aDictionary values) lowColor: (self class normalizerBotom) highColor: (self class normalizerTop)).
]

{ #category : #'edge-management' }
RTDowserBuilder >> greyLinesfrom: aNode in: aCollection to: links [
	aNode
		on: TRMouseEnter
		do: [ :event | 
			shadowEdges at: aNode	
				ifPresent: [ :v | v do: [ :e | self view add: e. e trachelShape pushBack]. 
							self view canvas signalUpdate]
				ifAbsent: [
					shadowEdges at: aNode put: 
					(self
						addLinesfrom: aNode
						toAll: links
						from: aCollection
						color: self class defaultLightEdgeColor)].
			bodyElement shape color: Color veryVeryLightGray].
	aNode
		on: TRMouseLeave
		do: [ :event | |v|
			v := true.
			"Initialization missing, or add ifAbsent:[^false]"
			(shadowEdges at: aNode) do: [ :e | e remove].
			self view canvas signalUpdate.
			overBody do: [ :e|  v := v or: [e]]. 
			v ifFalse: [ bodyElement shape color: Color darkGray]].
]

{ #category : #accessing }
RTDowserBuilder >> height: aBlock [
	self heightLeft: aBlock.
	self heightRight: aBlock.
]

{ #category : #accessing }
RTDowserBuilder >> heightLeft [
	^heightLeft
]

{ #category : #accessing }
RTDowserBuilder >> heightLeft: aBlock [
	heightLeft := aBlock
]

{ #category : #accessing }
RTDowserBuilder >> heightRight [
	^heightRight
]

{ #category : #accessing }
RTDowserBuilder >> heightRight: aBlock [
	heightRight := aBlock
]

{ #category : #initialization }
RTDowserBuilder >> initialize [
	view := RTView new.
	models := OrderedCollection new.
	left := OrderedCollection new.
	right := OrderedCollection new.
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
	self labelLeft: aMessage.
	self labelRight: aMessage
]

{ #category : #accessing }
RTDowserBuilder >> labelLeft [
	^labelLeft
]

{ #category : #accessing }
RTDowserBuilder >> labelLeft: aMessage [
	labelLeft := aMessage
]

{ #category : #accessing }
RTDowserBuilder >> labelRight [
	^labelRight
]

{ #category : #accessing }
RTDowserBuilder >> labelRight: aMessage [
	labelRight := aMessage
]

{ #category : #'shape-managment' }
RTDowserBuilder >> labels: aCollection [
	| maxWidth label|
	maxWidth := 0.
	(aCollection = left) 
		ifTrue: [ label := self labelLeft ]
		ifFalse: [ label := self labelRight ].
	aCollection do: [:l | | lab | 
		lab := (RTElement on: (label value: l model)) + RTLabel.
		lab @ RTHighlightable.
		maxWidth := maxWidth max: (lab width).
		self view add: lab.
		self stick: lab on: l from: aCollection].
	^maxWidth 
]

{ #category : #accessing }
RTDowserBuilder >> left [
	^left
]

{ #category : #accessing }
RTDowserBuilder >> left: aCollection [
	self models addAll: aCollection.
	left := self from: aCollection in: 'left'.
]

{ #category : #accessing }
RTDowserBuilder >> legend [
	^legend
]

{ #category : #accessing }
RTDowserBuilder >> legend: aString [
	legend := aString 
]

{ #category : #'edge-management' }
RTDowserBuilder >> lines: aNode in: aCollection to: links [
	aNode
		on: TRMouseClick
		do: [ :event | 
			edges at: aNode		
				ifPresent: [ :v |
					((v isEmpty not) and: [ v first trachelShape isInACanvas])
						ifTrue: [ | val |
								val := false.
								v do: [ :e | e remove].
								self removePopup: aNode.
								overBody at: aNode put: false.
								overBody do: [ :e|  val := val or: [e]]. 
								val ifFalse: [ bodyElement shape color: Color darkGray]]
						ifFalse: [v do: [ :e | self view add: e. e trachelShape pushBack]. 
								self addPopup: aNode from: aCollection.
								overBody at: aNode put: true. 
								bodyElement shape color: Color veryVeryLightGray].
					self view canvas signalUpdate]
				ifAbsent: [
					edges at: aNode put: 
					(self
						addLinesfrom: aNode
						toAll: links
						from: aCollection
						color: self edgeColor).
					self addPopup: aNode from: aCollection.
					overBody at: aNode put: true. 
					bodyElement shape color: Color veryVeryLightGray]]
]

{ #category : #'edge-management' }
RTDowserBuilder >> linesFrom: aCollection with: aBlock [
	| otherCollection  |
	aCollection = left
		ifTrue: [ otherCollection := right ]
		ifFalse: [ otherCollection := left ].
	aCollection
		do: [ :n1 | 
			| links |
			links := self linksFrom: n1 with: aBlock to: otherCollection.
			self
				lines: n1
				in: aCollection
				to: links.
			self
				greyLinesfrom: n1
				in: aCollection
				to: links ].
]

{ #category : #'edge-management' }
RTDowserBuilder >> linesTo: aCollection with: aBlock [
	| otherCollection |
	aCollection = left
		ifTrue: [ otherCollection := right ]
		ifFalse: [ otherCollection := left ].
	aCollection
		do: [ :n1 | 
			| links |
			links := self linksTo: n1 with: aBlock to: otherCollection.
			self
				lines: n1
				in: aCollection
				to: links.
			self
				greyLinesfrom: n1
				in: aCollection
				to: links ].
]

{ #category : #'edge-management' }
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
	links := links collect: [ :l | l first].
	^ links
]

{ #category : #'edge-management' }
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

{ #category : #accessing }
RTDowserBuilder >> onLeftAndRight: aCollection [
	self left: aCollection.
	self right: aCollection.
]

{ #category : #'instance creation' }
RTDowserBuilder >> open [
	"self view title: (self title)."
	(self view elements includes: (left anyOne)) ifFalse: [self view addAll: left].
	(self view elements includes: (right anyOne)) ifFalse: [self view addAll: right].
	self view @ RTVerticalDraggableView.
	"self view canvas signalUpdate."
	self view openInWindowSized: (self viewWidth) @ 500.
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

{ #category : #'shape-managment' }
RTDowserBuilder >> positionateTowers [
	| maxwl maxwr maxl maxr max leg legTrans leftTrans rightTrans bod|
	
	maxl := (left collect: [ :l | l height ]) max.
	maxr := (right collect: [ :l | l height ]) max.
	max := maxl max: maxr.

	RTVerticalLineLayout on: left.
	RTVerticalLineLayout on: right.	
	
	maxwl := self labels: left.
	maxwr := self labels: right.
	
	distance := ((self models size * max ln * 5) max: 300) min: 400.	

	leg := (RTElement on: (self legend)) +  (RTLabel new height: 18).
	self view add: leg.
	legTrans := (maxwl + 40 + (distance / 2) - (leg position x)) max: 0.
	leg translateBy: legTrans @ 0.
	
	legTrans = 0
		ifTrue: [ leftTrans :=  (leg position x) - ((distance / 2) + maxwl).
				 rightTrans := (leftTrans + distance) ]
		ifFalse: [ leftTrans :=  (maxwl + 30).
				 rightTrans := (maxwl + distance + 30)].
	left do: [ :e | e translateBy: leftTrans @ ((e height/2) + 40) ].
	right do: [ :e | e translateBy: rightTrans @ ((e height/2) + 40) ].	
	
	bod := (RTElement on: (self body)) +  (RTLabel new color: Color darkGray).
	bodyElement := bod.
	"bod width: distance."
	self view add: bod.
	bod translateBy: (maxwl + 60 @ 30 ).
	"bod forward: (bod view)."
	"bod on: TREvent do: [:e | bod parentAnnounce: e]."
	
	viewWidth := distance + maxwl + maxwr + 80  max: (leg width).
	
	^ distance
]

{ #category : #relations }
RTDowserBuilder >> relation: aBlock [	
	self relationLeft: aBlock.
	self relationRight: aBlock.
]

{ #category : #relations }
RTDowserBuilder >> relationLeft: aBlock [
	| newBlock |
	aBlock isBlock 
		ifTrue: [ newBlock	:= aBlock ]
		ifFalse: 	[ newBlock := [ :a :b | |v|
				v := (aBlock value: a).
				(v includes: b) ifTrue: [true] ifFalse: [v = b] ]]. 
	self distance isNil ifTrue: [ distance := self positionateTowers].
	direction = 'to' 
		ifTrue: [ self linesTo: left with: newBlock]
		ifFalse: [ self linesFrom: left with: newBlock]
]

{ #category : #relations }
RTDowserBuilder >> relationRight: aBlock [	
	| newBlock |
	aBlock isBlock 
		ifTrue: [ newBlock	:= aBlock ]
		ifFalse: 	[ newBlock := [ :a :b | |v|
				v := (aBlock value: a).
				(v includes: b) ifTrue: [true] ifFalse: [v = b] ]]. 
	self distance isNil ifTrue: [ distance := self positionateTowers].
	direction = 'to' 
		ifTrue: [ self linesTo: right with: newBlock]
		ifFalse: [ self linesFrom: right with: newBlock]
]

{ #category : #'shape-managment' }
RTDowserBuilder >> removePopup: element [
	(popups at: element ifAbsent:[^false]) remove. 
]

{ #category : #accessing }
RTDowserBuilder >> right [
	^ right
]

{ #category : #accessing }
RTDowserBuilder >> right: aCollection [
	self models addAll: aCollection.
	right := self from: aCollection in: 'right'.
]

{ #category : #'shape-managment' }
RTDowserBuilder >> stick: aLabel on: anElement from: aCollection [
	(aCollection = left)
		ifTrue: [ TRConstraint stick: (aLabel trachelShape) onTheLeftOf: (anElement trachelShape) ]
		ifFalse: [ TRConstraint stick: (aLabel trachelShape) onTheRightOf: (anElement trachelShape) ]
	
]

{ #category : #'shape-managment' }
RTDowserBuilder >> stickTop: aLabel on: anElement from: aCollection [
	(aCollection = left)
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

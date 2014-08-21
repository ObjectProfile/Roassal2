Class {
	#name : #RTNode,
	#superclass : #RTObject,
	#instVars : [
		'parent',
		'depth',
		'alphaAngle',
		'betaAngle',
		'innerRadius',
		'externalRadius',
		'weight',
		'element',
		'model',
		'children'
	],
	#category : 'Roassal2-Builder-Sunburst'
}

{ #category : #'as yet unclassified' }
RTNode class >> convertToNode: anObject [
	(anObject class = 'RTNode')
		ifTrue:[^anObject].
	^anObject asRTNode
]

{ #category : #visitor }
RTNode >> accept: aVisitor [
	aVisitor visitNode: self.
]

{ #category : #adding }
RTNode >> addChild: aChild [
	|auxRadius|
	auxRadius:= aChild externalRadius - aChild innerRadius.
	aChild depth: self depth + 1.
	aChild innerRadius: self externalRadius .
	aChild externalRadius: (aChild innerRadius + auxRadius).
	children add: aChild.
	aChild parent: self
]

{ #category : #accessing }
RTNode >> alphaAngle [
	^alphaAngle
]

{ #category : #accessing }
RTNode >> alphaAngle: anAngle [
	alphaAngle:=anAngle
]

{ #category : #accessing }
RTNode >> attachPoint [
	| angle|
	angle:=(self alphaAngle + ((self betaAngle - self alphaAngle) / 2)) degreesToRadians.
	^(self innerRadius * angle cos) @ (self innerRadius * angle sin)
	
]

{ #category : #accessing }
RTNode >> betaAngle [
	^betaAngle
]

{ #category : #accessing }
RTNode >> betaAngle: anAngle [
	betaAngle:=anAngle
]

{ #category : #accessing }
RTNode >> center [
	| angle radius|
	(self depth = 0)
		ifTrue:[^0@0].
	angle:=(self alphaAngle + ((self betaAngle - self alphaAngle) / 2)) degreesToRadians.
	radius:=self innerRadius + ((self externalRadius - self innerRadius)/2).
	^(radius * angle cos) @ (radius * angle sin)
	
]

{ #category : #accessing }
RTNode >> children [
	^children
]

{ #category : #computing }
RTNode >> childrenCenters [
	|centers|
	centers:=OrderedCollection new.
	centers add: self center.
	(self hasChildren)
		ifTrue:[ self children do: [ :c | centers addAllLast:  c childrenCenters ]].
	^centers
		
]

{ #category : #accessing }
RTNode >> depth [
	^depth
]

{ #category : #accessing }
RTNode >> depth: aDepth [
	depth:= aDepth
]

{ #category : #accessing }
RTNode >> element [
	|shape|
	(element isNil)
		ifTrue:[
			shape:= TRArcShape new.
			shape alphaAngle: self alphaAngle.
			shape betaAngle: self betaAngle.
			shape innerRadius: self innerRadius.
			shape externalRadius: self externalRadius .
			element:= shape element
			].
	^element
]

{ #category : #accessing }
RTNode >> element: anElement [
	element:=anElement
]

{ #category : #accessing }
RTNode >> externalRadius [
	^externalRadius 
]

{ #category : #accessing }
RTNode >> externalRadius: anAngle [
	externalRadius:=anAngle
]

{ #category : #testing }
RTNode >> hasChildren [
	(children isNil not)
		ifTrue:[(children size > 0)
				ifTrue:[^true]].
	^false
]

{ #category : #initialization }
RTNode >> initialize [
	super initialize.
	children:=OrderedCollection new.
	parent:=RTNullNode new.
	depth:=0.
	alphaAngle:=0.
	betaAngle:=360.
	weight:=1.
	innerRadius:=0.
	externalRadius:=50.
	element:= nil.
	
]

{ #category : #accessing }
RTNode >> innerRadius [
	^innerRadius
]

{ #category : #accessing }
RTNode >> innerRadius: anAngle [
	innerRadius:=anAngle
]

{ #category : #'accessing-derived' }
RTNode >> maxDepth [
	|maxDepth|
	maxDepth:=self depth.
	(self hasChildren)
		ifTrue:[self children do:[:c | maxDepth:= maxDepth max: c maxDepth]].
	^maxDepth
]

{ #category : #accessing }
RTNode >> model [
	^ model
]

{ #category : #accessing }
RTNode >> model: aModel [
	model := aModel
]

{ #category : #accessing }
RTNode >> parent [
	^parent
]

{ #category : #accessing }
RTNode >> parent: aParent [
	parent:=aParent
]

{ #category : #printing }
RTNode >> printOn: str [
	super printOn: str.
	str nextPut: $<.
	model ifNotNil: [ str nextPutAll: model printString ].
	str nextPut: $>
]

{ #category : #accessing }
RTNode >> size [
	^ children size
]

{ #category : #accessing }
RTNode >> weight [
	^weight
]

{ #category : #accessing }
RTNode >> weight: aNumber [
	weight:=aNumber
]

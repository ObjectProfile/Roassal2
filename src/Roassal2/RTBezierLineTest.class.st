Class {
	#name : #RTBezierLineTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
}

{ #category : #tests }
RTBezierLineTest >> testBasic [

	| v shape  edge els |
	v := RTView new.
	shape := RTEllipse new size: 10; color: (Color purple alpha: 0.3).
	els := (shape elementsOn: (1 to: 4)) @ RTDraggable.
	v addAll: els .
	RTHorizontalLineLayout on: v elements.

	edge := (RTBezierLine new controllingElements: v elements) edgeFrom: els first to: els last.
	v add: edge.
	
	self assert: (els first isConnectedTo: edge).
	self assert: (els second isConnectedTo: edge).
	self assert: (els third isConnectedTo: edge).
	self assert: (els fourth isConnectedTo: edge).
]

{ #category : #tests }
RTBezierLineTest >> testFollow [
	| v e bezier startNode endNode edge |
	v := RTView new.
	e := RTBox elementsOn: (Collection withAllSubclasses). 
	v addAll: e.
	bezier := RTBezierLine new 
					color: Color blue;
					follow: #superclass.
	
	startNode := v elementFromModel: OrderedCollection.
	self assert: (bezier getFollowersOf: startNode using: #superclass) size = 2.
	
	endNode := v elementFromModel: Dictionary.
	edge := bezier edgeFrom: startNode to: endNode.
	self assert: ((bezier getControllingElementsFromFollowFor: edge using: #superclass) collect: #model) = { SequenceableCollection. Collection. HashedCollection } asArray.
]

{ #category : #tests }
RTBezierLineTest >> testFromTo [

	| v e1 e2 e3 l |
	v := RTView new.
	e1 := RTBox element.
	e2 := RTBox element.
	e3 := RTBox element.
	e1 @ RTDraggable.
	e2 @ RTDraggable.
	l := RTBezierLine new controllingElements: (Array with: e3); edgeFrom: e1 to: e2.
	v add: e1; add: e2; add: l.
	
	self assert: l from == e1.
	self assert: l to == e2.
]

{ #category : #tests }
RTBezierLineTest >> testFromToAndControllingElements [

	| e1 e2 l |
	e1 := RTBox element.
	e2 := RTBox element.	
	l := RTBezierLine edgeFrom: e1 to: e2.
	self assert: l shape controllingElements isEmpty
]

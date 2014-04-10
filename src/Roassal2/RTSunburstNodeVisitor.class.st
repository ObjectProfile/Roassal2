Class {
	#name : #RTSunburstNodeVisitor,
	#superclass : #RTObject,
	#instVars : [
		'arcs',
		'lines',
		'node',
		'builder',
		'radialSpacing',
		'angularSpacing',
		'interactions'
	],
	#category : #'Roassal2-Builder-Sunburst'
}

{ #category : #accessing }
RTSunburstNodeVisitor >> angularSpacing [
	^angularSpacing
]

{ #category : #accessing }
RTSunburstNodeVisitor >> angularSpacing: aNumber [
	angularSpacing:=aNumber
]

{ #category : #accessing }
RTSunburstNodeVisitor >> arcs [
	^arcs
]

{ #category : #accessing }
RTSunburstNodeVisitor >> builder: aBuilder [
	builder := aBuilder
]

{ #category : #'creating elements' }
RTSunburstNodeVisitor >> createArc [
	| el arc auxArc auxRadius |
	arc := builder shape current.
	auxArc:=(node betaAngle - (angularSpacing / 2)) - (node alphaAngle + (angularSpacing / 2)).
	(node depth ~= 0)
		ifTrue:[(auxArc > 0)
					ifTrue:[
						node alphaAngle: node alphaAngle + (angularSpacing / 2).
						node betaAngle: node betaAngle - (angularSpacing / 2)]
					ifFalse:[
						node alphaAngle: node alphaAngle.
						node betaAngle: node alphaAngle + 1.]]
		ifFalse:[
				node alphaAngle: node alphaAngle.
				node betaAngle: node betaAngle].
	auxRadius:= node externalRadius - (node innerRadius + radialSpacing ).
	node innerRadius: node innerRadius + (radialSpacing * node depth).
	node externalRadius: node externalRadius + (radialSpacing * node depth).
	
	arc alphaAngle: node alphaAngle.
	arc betaAngle: node betaAngle.
	arc innerRadius: node innerRadius.
	arc externalRadius: node externalRadius.	
	el := RTElement on: node model.
	el attributeAt: #sbDepth put: node depth.
	el attributeAt: #sbParent put: node parent.
	el attributeAt: #sbChildren put: node children.
	
	el + arc.
	node element: el.
	interactions do: [:i | el @ i ].
	
	^ el
	
	
]

{ #category : #'creating elements' }
RTSunburstNodeVisitor >> createLine [
	| line points |
	line := TRBezierShape new.
	points := OrderedCollection new.
	points add: node parent center.
	points addAll: node childrenCenters.			
	line points:points.
	line strokePaint: Color gray.
	^ line
]

{ #category : #initialization }
RTSunburstNodeVisitor >> initialize [
	arcs:= OrderedCollection new.
	lines:= OrderedCollection new.
	interactions := OrderedCollection new.
	interactions add: RTPopup.
	angularSpacing:=0.
	radialSpacing:=0
]

{ #category : #accessing }
RTSunburstNodeVisitor >> interactions [
	^ interactions
]

{ #category : #accessing }
RTSunburstNodeVisitor >> lines [
	^lines
]

{ #category : #accessing }
RTSunburstNodeVisitor >> node [
	^node
]

{ #category : #accessing }
RTSunburstNodeVisitor >> node: aNode [
	node:=aNode
]

{ #category : #accessing }
RTSunburstNodeVisitor >> radialSpacing [
	^radialSpacing
]

{ #category : #accessing }
RTSunburstNodeVisitor >> radialSpacing: aNumber [
	radialSpacing:=aNumber
]

{ #category : #visitor }
RTSunburstNodeVisitor >> visitNode: aNode [	
	| angleOffset auxAngle totalPie |
	self node: aNode.
	arcs add: self createArc.
	"(aNode depth = 1)
		ifTrue:[lines add: self createLine]."
	totalPie:=0.
	aNode children do: [ :c | totalPie:= totalPie + (1 * c weight) ].
	auxAngle:=aNode alphaAngle.
	(node hasChildren)
 		ifTrue:[
			angleOffset:=((node betaAngle - node alphaAngle) / totalPie).
			aNode children do: 
				[:c | 
				c alphaAngle: auxAngle.
				c betaAngle: c alphaAngle + (angleOffset * c weight).
				auxAngle:= c betaAngle. 
				].
			aNode children do:[
				:c | 
				c accept: self.
				] 
			]
]

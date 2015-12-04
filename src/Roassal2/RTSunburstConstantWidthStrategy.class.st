Class {
	#name : #RTSunburstConstantWidthStrategy,
	#superclass : #RTSunburstStrategy,
	#instVars : [
		'arcWidth',
		'centerWidth'
	],
	#category : #'Roassal2-Builder-Sunburst'
}

{ #category : #accesing }
RTSunburstConstantWidthStrategy >> arcWidth [
	^ arcWidth
]

{ #category : #accesing }
RTSunburstConstantWidthStrategy >> arcWidth: aNumber [
	arcWidth := aNumber
]

{ #category : #accesing }
RTSunburstConstantWidthStrategy >> centerWidth [
	^ centerWidth
]

{ #category : #accesing }
RTSunburstConstantWidthStrategy >> centerWidth: anObject [
	centerWidth := anObject
]

{ #category : #initialization }
RTSunburstConstantWidthStrategy >> initialize [
	super initialize.
	self arcWidth: 50.
	self centerWidth: 0.
]

{ #category : #public }
RTSunburstConstantWidthStrategy >> on: elements [
	| children arc parent depth radius totalPie recurse a b s |
	recurse := nil.
	recurse := [ :el | | angleOffset auxAngle |
		children := el attributes at: #children.
		parent := el attributes at: #parent.
		arc := el trachelShape.
		depth := el attributes at: #depth.
		
		depth isZero ifTrue: [ 
			arc alphaAngle: 0 betaAngle: 360 innerRadius: 0
				externalRadius: (self hasCenter ifTrue: [ self arcWidth ] ifFalse: [ self centerWidth ]). ]
		ifFalse: [ 
			radius := parent trachelShape externalRadius + self radialSpacing.
			arc
				alphaAngle: arc alphaAngle
				betaAngle: arc betaAngle
				innerRadius: radius
				externalRadius: radius + self arcWidth  ].
		children isEmpty ifFalse: [ 
			totalPie := el attributes at: #weight.
			auxAngle := arc alphaAngle.
			angleOffset := (arc betaAngle - arc alphaAngle)/totalPie.
			children do: [ :c |
				a := auxAngle.
				b := auxAngle + (angleOffset * (builder weight rtValue: c model)	).
				s := self angularSpacing.
				auxAngle := b.
				(b - a) > s ifTrue: [ b := b - (s/2). a := a + (s/2). ].
				c trachelShape
					alphaAngle: a
					betaAngle: b
					innerRadius: 0
					externalRadius: 0.
				recurse value: c. ] ].
	].
	recurse value: elements first.
]

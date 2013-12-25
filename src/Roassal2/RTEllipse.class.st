Class {
	#name : #RTEllipse,
	#superclass : #RTAbstractElementShape,
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTEllipse >> initialize [
	super initialize.
	color := self defaultColor
]

{ #category : #'as yet unclassified' }
RTEllipse >> renderOn: trachelCanvas for: anElement [
	| rec ex |
	ex := (self widthFor: anElement) @ (self heightFor: anElement).
	rec := (anElement position - (ex / 2)) extent: ex.
	^ trachelCanvas buildCircleFrom: rec origin to: rec corner color: (self colorFor: anElement)
]

{ #category : #'as yet unclassified' }
RTEllipse >> trachelShapeFor: anElement [
	|  shape ex rec |
	ex := (self widthFor: anElement) @ (self heightFor: anElement).
	rec := (anElement position - (ex / 2)) extent: ex.
	
	shape := TREllipseShape new.
	shape from: rec origin to: rec corner color: (self colorFor: anElement).
	^ shape
]

{ #category : #'as yet unclassified' }
RTEllipse >> updateFor: anElement [
	| rec ex |
	"This is a bit ugly... We need to find a better way"
	anElement trachelShape isNil ifTrue: [ ^ self ].
	ex := (self widthFor: anElement) @ (self heightFor: anElement).
	rec := (anElement position - (ex / 2)) extent: ex.
	anElement trachelShape rectangle: rec
]

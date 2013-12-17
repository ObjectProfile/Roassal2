Class {
	#name : #RTLine,
	#superclass : #RTAbstractLine,
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTLine >> renderOn: trachelCanvas for: anEdge [
	"w := self widthFor: anEdge."
	^ trachelCanvas buildLineFrom: anEdge from position to: anEdge to position color: (self colorFor: anEdge)
]

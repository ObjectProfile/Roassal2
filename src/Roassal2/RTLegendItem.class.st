Class {
	#name : #RTLegendItem,
	#superclass : #RTObject,
	#category : #'Roassal2-Builder-Legend'
}

{ #category : #hooks }
RTLegendItem >> execute [
	self subclassResponsibility
]

{ #category : #utility }
RTLegendItem >> newLabelShape: widthDescription [
	"Return a new label with the argument as the content of the label"
	^ RTLabel new color: self textColor; text: widthDescription; yourself
]

{ #category : #utility }
RTLegendItem >> textColor [
	^ Color lightGray
]

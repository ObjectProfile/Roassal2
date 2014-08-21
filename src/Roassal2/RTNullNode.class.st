Class {
	#name : #RTNullNode,
	#superclass : #RTNode,
	#category : #'Roassal2-Builder-Sunburst'
}

{ #category : #'as yet unclassified' }
RTNullNode >> accept: aVisitor [
]

{ #category : #'as yet unclassified' }
RTNullNode >> hasChilds [
	^false
]

{ #category : #'as yet unclassified' }
RTNullNode >> initialize [
	parent:= self.
	children=self.
	depth:=-1.
	alphaAngle:=0.
	betaAngle:=360.
	weight:=1
]

{ #category : #'as yet unclassified' }
RTNullNode >> size [ 
	^0
]

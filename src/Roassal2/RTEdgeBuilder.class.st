Class {
	#name : #RTEdgeBuilder,
	#superclass : #RTBuilder,
	#category : #'Roassal2-Builder-Common'
}

{ #category : #'public associations' }
RTEdgeBuilder >> fromAssociations: associationsBetweenModels [
	| fromElement toElement |
	associationsBetweenModels do: [ :assoc |
		fromElement := view elementFromModel: assoc key.
		toElement := view elementFromModel: assoc value.
		(fromElement notNil and: [ toElement notNil ]) ifTrue: 
			[ self edgeFrom: fromElement to: toElement ] ]
]

{ #category : #'public associations' }
RTEdgeBuilder >> fromElementAssociations: associationsBetweenElements [
	associationsBetweenElements do: [ :assoc |
		self edgeFrom: assoc key to: assoc value ]
]

{ #category : #accessing }
RTEdgeBuilder >> globalScope [
	^ RTGroup withAll: (self view elements collect: #model)
]

{ #category : #public }
RTEdgeBuilder >> objects: objects from: fromBlock to: toBlock [ 

	^ self objects: objects from: fromBlock to: toBlock scope: self globalScope
]

{ #category : #public }
RTEdgeBuilder >> objects: objects from: fromBlock to: toBlock scope: aGroup [

	| edges fromElement toElement fromObject toObject |
	objects isEmpty ifTrue: [ ^ #() ].
	edges := RTGroup new.
	objects do: [ :object |
		fromObject := fromBlock rtValue: object.
		toObject := toBlock rtValue: object.
		((aGroup includes: fromObject) and: [ aGroup includes: toObject ]) ifTrue: [  
				fromElement := self view elementFromModel: (fromBlock rtValue: object).
				toElement := self view elementFromModel: (toBlock rtValue: object).
				(fromElement notNil and: [ toElement notNil ])
					ifTrue: [   
						edges add: (self edgeFrom: fromElement to: toElement) ] ] ].
	^ edges

]

{ #category : #public }
RTEdgeBuilder >> objects: objects from: fromBlock toAll: toAllBlock [
	"aGroup is a group of objects"

	| edges fromElement toElement |
	edges := RTGroup new.
	objects isEmpty ifTrue: [ ^ edges ].
	objects do: [ :object |
		fromElement := self view elementFromModel: (fromBlock rtValue: object).
		(toAllBlock rtValue: object) do: [ :toObject |
			toElement := self view elementFromModel: toObject.
			(fromElement notNil and: [ toElement notNil ])
				ifTrue: [  
					(fromElement ~~ toElement) ifTrue: 
						[ | edge |
						edge := self edgeFrom: fromElement to: toElement. 
						edges add: edge.
						view add: edge ] ] ] ].
	^ edges

]

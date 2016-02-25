"
'You are calling #moveBehind without calling #connectToAll: afterwards. You have to specify z-position for elements before adding them.'
"
Class {
	#name : #RTMoveBehindNotConsumedRule,
	#superclass : #ReBasicTreeRule,
	#category : #'Roassal2-Rules'
}

{ #category : #running }
RTMoveBehindNotConsumedRule >> basicCheck: anAST [ 
	| shapeNotConsumed |
	
	shapeNotConsumed := false.

	anAST nodesDo: [ :node | 
		node isMessage ifTrue: [ 
			shapeNotConsumed := 
				node selector = #moveBehind or: [ 		
					node name ~= #connectToAll: 
					& shapeNotConsumed ] ] ]. 
	
	^ shapeNotConsumed 
]

{ #category : #running }
RTMoveBehindNotConsumedRule >> check: anAST forCriticsDo: aCriticBlock ifNone: alternativeBlock [

	| notConsumedMoveBehindNode |
	notConsumedMoveBehindNode := nil.

	anAST nodesDo: [ :node |
		node isMessage ifTrue: [
			node selector = #moveBehind ifTrue: [ notConsumedMoveBehindNode := node ].
			node name = #connectToAll: ifTrue: [ notConsumedMoveBehindNode := nil ] ] ].
	
	notConsumedMoveBehindNode
		ifNil: alternativeBlock
		ifNotNil: [ aCriticBlock value: (
			ReTrivialCritic
				withAnchor: (ReIntervalSourceAnchor
					entity: anAST
					interval: notConsumedMoveBehindNode sourceInterval)
				by: self) ]

	
]

{ #category : #accessing }
RTMoveBehindNotConsumedRule >> group [
	^ 'Roassal'
]

{ #category : #accessing }
RTMoveBehindNotConsumedRule >> name [

	^ '#moveBehind not followed by a #connectToAll:'
]

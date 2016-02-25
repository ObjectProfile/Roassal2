"
'You are calling #setAsFixed without calling #add: afterwards. You have to set the fixed property of a shape before before adding it to a view.'
"
Class {
	#name : #RTSetAsFixedNotConsumedRule,
	#superclass : #ReBasicTreeRule,
	#category : #'Roassal2-Rules'
}

{ #category : #running }
RTSetAsFixedNotConsumedRule >> basicCheck: anAST [ 
	| shapeNotConsumed |
	
	shapeNotConsumed := false.

	anAST nodesDo: [ :node | 
		node isMessage ifTrue: [ 
			shapeNotConsumed := 
				node selector = #setAsFixed or: [ 		
					node name ~= #add: 
					& shapeNotConsumed ] ] ]. 
	
	^ shapeNotConsumed 
]

{ #category : #running }
RTSetAsFixedNotConsumedRule >> check: anAST forCriticsDo: aCriticBlock ifNone: alternativeBlock [

	| notConsumedMoveBehindNode |
	notConsumedMoveBehindNode := nil.

	anAST nodesDo: [ :node |
		node isMessage ifTrue: [
			node selector = #setAsFixed ifTrue: [ notConsumedMoveBehindNode := node ].
			node name = #add: ifTrue: [ notConsumedMoveBehindNode := nil ] ] ].
	
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
RTSetAsFixedNotConsumedRule >> group [
	^ 'Roassal'
]

{ #category : #accessing }
RTSetAsFixedNotConsumedRule >> name [

	^ '#setAsFixed not followed by an #add:'
]

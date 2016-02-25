"
Edges will not be drawn if nodes are not initialized before the invocation of #edges message
"
Class {
	#name : #RTEdgesDefinedBeforeNodes,
	#superclass : #ReBasicTreeRule,
	#category : #'Roassal2-Rules'
}

{ #category : #running }
RTEdgesDefinedBeforeNodes >> basicCheck: anAST [ 

	(anAST references: #RTMondrian) and: [ 
	anAST nodesDo: [ :node |
		node isMessage ifTrue: [ 
			node selector = #nodes: ifTrue: [ ^ false ].
			node selector = #edges ifTrue: [ ^ true ] ] ] ].

	^ false
]

{ #category : #running }
RTEdgesDefinedBeforeNodes >> check: anAST forCriticsDo: aCriticBlock ifNone: alternativeBlock [

	(anAST references: #RTMondrian) ifFalse: [ ^ alternativeBlock value ].

	anAST nodesDo: [ :node |
		node isMessage ifTrue: [ 
			node selector = #nodes: ifTrue: [ ^ alternativeBlock value ].
			node selector = #edges ifTrue: [
				aCriticBlock value: (ReTrivialCritic
					withAnchor: (ReIntervalSourceAnchor
						entity: anAST
						interval: node sourceInterval)
					by: self) ] ] ].
					

	alternativeBlock value.

	
]

{ #category : #accessing }
RTEdgesDefinedBeforeNodes >> group [
	^ 'Roassal'
]

{ #category : #accessing }
RTEdgesDefinedBeforeNodes >> name [

	^ 'Calls #edges before #nodes:'
]

{ #category : #accessing }
RTEdgesDefinedBeforeNodes >> severity [

	^ #error
]

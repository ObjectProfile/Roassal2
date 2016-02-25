"
The rule checks if the #shapes definition is properly consumend
"
Class {
	#name : #RTShapesNotConsumedRule,
	#superclass : #ReBasicTreeRule,
	#category : #'Roassal2-Rules'
}

{ #category : #running }
RTShapesNotConsumedRule >> basicCheck: anAST [ 
	| shapeNotConsumed |
	
	shapeNotConsumed := false.

	(anAST references: #RTMondrian) ifTrue: [ 
	anAST nodesDo: [ :node | "traverse AST in execution order"
		node isMessage ifTrue: [ "interested only in messages"
			shapeNotConsumed := "shapes are not consumed if"
				node selector = #shapes or: [ "we just defined shapes or"				
					(self methodsThatUseShapes includes: node name) not "curently we are not consuming shape"
					& shapeNotConsumed ] ] ] ]. "and it was not consumed previously"
	
	^ shapeNotConsumed 
]

{ #category : #running }
RTShapesNotConsumedRule >> check: anAST forCriticsDo: aCriticBlock ifNone: alternativeBlock [

	| notConsumedShapeNode |
	notConsumedShapeNode := nil.
	
	(anAST references: #RTMondrian) ifFalse: [ ^ alternativeBlock value ].

	anAST nodesDo: [ :node |
		node isMessage ifTrue: [
			node selector = #shapes ifTrue: [ notConsumedShapeNode := node ].
			(self methodsThatUseShapes includes: node name) ifTrue: [ notConsumedShapeNode := nil ] ] ].
	
	notConsumedShapeNode
		ifNil: alternativeBlock
		ifNotNil: [ aCriticBlock value: (
			ReTrivialCritic
				withAnchor: (ReIntervalSourceAnchor
					entity: anAST
					interval: notConsumedShapeNode sourceInterval)
				by: self) ]

	
]

{ #category : #accessing }
RTShapesNotConsumedRule >> group [
	^ 'Roassal'
]

{ #category : #accessing }
RTShapesNotConsumedRule >> methodsThatUseShapes [

	^ #(edges node: #nodes: #node:forIt: #nodes:forEach:)
]

{ #category : #accessing }
RTShapesNotConsumedRule >> name [

	^ '#shapes not followed by a right message'
]

{ #category : #accessing }
RTShapesNotConsumedRule >> rationale [

	^ 'You are calling #sapes without calling any of #',
	  (self methodsThatUseShapes joinUsing: ', #'),
	  ' afterwards. You have to specify a shape for nodes or edges before defining them.'
]

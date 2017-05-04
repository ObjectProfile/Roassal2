Extension { #name : #TClass }

{ #category : #'*roassal2-exportervw' }
TClass >> visualworksName [
	^ self == TBehavior 
		ifTrue: [ 'Core.Behavior' ]
		ifFalse: [ self name ]
]

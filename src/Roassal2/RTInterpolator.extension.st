Extension { #name : #RTInterpolator }

{ #category : #'*Roassal2' }
RTInterpolator >> rtValue: anArgument [
	| value |
	value := anArgument.
	(anArgument isKindOf: Association)
		ifTrue: [ 
			self tension: anArgument value.
			value := anArgument key. ].
	
	^ self interpolate: value.
]

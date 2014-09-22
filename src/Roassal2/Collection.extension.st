Extension { #name : #Collection }

{ #category : #'*Roassal2-Core' }
Collection >> maxValue: aBlock [
	^ self inject: (aBlock value: self anyOne) into: [ :max :each | max max: (aBlock value: each) ]
]

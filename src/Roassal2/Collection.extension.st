Extension { #name : #Collection }

{ #category : #'*Roassal2-Core' }
Collection >> asGroup [
	^ RTGroup withAll: self
]

{ #category : #'*Roassal2-Core' }
Collection >> maxFor: aSymbolOrBlock [ 
	"Return one of the elements which has the minimum value returned by aSymbolOrBlock"
	
	"
	#(5 6 2 1 4) max
	#(5 6 2 1 4) maxFor: #negated
	"
	^self 
		inject: self anyOne 
		into: [ :max :each | 
			(aSymbolOrBlock value: each) > (aSymbolOrBlock value: max)
				ifTrue: [ each ]
				ifFalse: [ max ] ]
]

{ #category : #'*Roassal2-Core' }
Collection >> maxValue: aBlock [
	^ self inject: (aBlock value: self anyOne) into: [ :max :each | max max: (aBlock value: each) ]
]

{ #category : #'*Roassal2-Core' }
Collection >> minFor: aSymbolOrBlock [ 
	"Return one of the elements which has the minimum value returned by aSymbolOrBlock"
	
	"
	#(5 6 2 1 4) min
	#(5 6 2 1 4) minFor: #negated
	"
	^self 
		inject: self anyOne 
		into: [ :min :each | 
			(aSymbolOrBlock value: each) < (aSymbolOrBlock value: min)
				ifTrue: [ each ]
				ifFalse: [ min ] ]
]

{ #category : #'*Roassal2-Core' }
Collection >> minValue: aBlock [
	^ self inject: (aBlock value: self anyOne) into: [ :min :each | min min: (aBlock value: each) ]
]

{ #category : #'*Roassal2-Core' }
Collection >> reverseSortedAs: aSortBlockOrSymbol [
	^ (self sortedAs: aSortBlockOrSymbol) reverse
]

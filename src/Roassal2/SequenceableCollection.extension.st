Extension { #name : #SequenceableCollection }

{ #category : #'*roassal2-core' }
SequenceableCollection >> reverseSortedAs: aSortBlockOrSymbol [
	^ (self sortedAs: aSortBlockOrSymbol) reverse
]

{ #category : #'*roassal2-core' }
SequenceableCollection >> rtSwapElement: u withElement: v [
	| index1 index2 |
	index1 := self indexOf: u.
	index2 := self indexOf: v.
	self at: index2 put: u.
	self at: index1 put: v.
]

{ #category : #'*roassal2-core' }
SequenceableCollection >> sortedAs: aSortBlockOrSymbol [
	"Answer a SortedCollection whose elements are the elements of the 
	receiver. The sort order is defined by the argument, aSortBlock."
	"Return a new collection. This method does not do a side effect"

	| aSortedCollection aSortBlock |
	aSortedCollection := SortedCollection new: self size.
	aSortBlock := 
		aSortBlockOrSymbol isSymbol 
			ifTrue: [ [:a :b | |t1 t2|
							t1 := (a perform: aSortBlockOrSymbol).
							t2 := (b perform: aSortBlockOrSymbol).
							((t1 isKindOf: Boolean) and: [t2 isKindOf: Boolean])
								ifTrue: [ t1 ]
								ifFalse: [ t1 < t2 ] ] ]
			ifFalse: [ 
				(aSortBlockOrSymbol numArgs = 1)
					ifTrue: [ [ :v1 :v2 | (aSortBlockOrSymbol value: v1) < (aSortBlockOrSymbol value: v2) ] ]
					ifFalse: [ aSortBlockOrSymbol ] ].
	aSortedCollection sortBlock: aSortBlock.
	aSortedCollection addAll: self.
	^ aSortedCollection
]

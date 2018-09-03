Extension { #name : #CompiledMethod }

{ #category : #'*Glamour-Morphic-Brick' }
CompiledMethod >> phlowValue: anObject withEnoughArguments: aCollection [

	^ anObject withArgs: aCollection executeMethod: self
]

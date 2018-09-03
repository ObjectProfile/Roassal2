Extension { #name : #Integer }

{ #category : #'*IntelPowerGadget' }
Integer >> fibonacci [
	"
	44 fibonacci
	"
	self < 2 ifTrue: [^ self].
	^ (self - 1) fibonacci + (self - 2) fibonacci 
]

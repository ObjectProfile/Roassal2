Extension { #name : #TRShape }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
TRShape >> allVisibleColor: aColor [
	self color = Color transparent 
			ifFalse: [ self color: aColor ]
]

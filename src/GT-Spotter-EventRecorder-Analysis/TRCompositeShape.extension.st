Extension { #name : #TRCompositeShape }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
TRCompositeShape >> allVisibleColor: aColor [
	self shapes do: [ :aShape | aShape allVisibleColor: aColor ]
]

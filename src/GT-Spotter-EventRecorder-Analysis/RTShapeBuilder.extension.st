Extension { #name : #RTShapeBuilder }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
RTShapeBuilder >> event [
	self shape: GTAActivitySymbolBuilder new
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
RTShapeBuilder >> flexibleResultShapes [
	self shape: GTAFlexibleResultSymbolBuilder new
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
RTShapeBuilder >> oblique [
	self shape: GTAActivitySymbolBuilder new
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
RTShapeBuilder >> orthogonal [
	self shape: GTAOrthogonalSymbolBuilder new
]

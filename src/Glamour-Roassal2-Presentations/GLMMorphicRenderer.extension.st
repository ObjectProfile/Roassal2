Extension { #name : #GLMMorphicRenderer }

{ #category : #'*Glamour-Roassal2-Presentations' }
GLMMorphicRenderer >> renderRoassal2Presentation: aPresentation [
	^ GLMMorphicRoassal2Renderer render: aPresentation from: self
]

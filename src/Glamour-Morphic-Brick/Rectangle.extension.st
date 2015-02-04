Extension { #name : #Rectangle }

{ #category : #'*Glamour-Morphic-Brick' }
Rectangle >> asBrickRectangle [

	^ GLMBrickRectangle origin: self origin corner: self corner
]

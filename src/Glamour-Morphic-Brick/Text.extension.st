Extension { #name : #Text }

{ #category : #'*Glamour-Morphic-Brick' }
Text >> asBrick [

	^ GLMLabelBrick new text: self asString
]

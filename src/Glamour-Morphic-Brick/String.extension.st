Extension { #name : #String }

{ #category : #'*Glamour-Morphic-Brick' }
String >> asBrick [

	^ GLMLabelBrick new text: self asString
]

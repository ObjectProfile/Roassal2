Extension { #name : #Color }

{ #category : #'*Glamour-Morphic-Brick' }
Color >> asRGBInteger [

	^(self red * 255) asInteger + ((self green * 255) asInteger << 8) + ((self blue * 255) asInteger << 16)
]

{ #category : #'*Glamour-Morphic-Brick' }
Color class >> colorFromRGBInteger: anInteger [
	|red green blue|
	
	blue := (anInteger >> 16) & 16r0ff.
	green := (anInteger >> 8) & 16r0ff.
	red := anInteger & 16r0ff.	
	
	^ self r: red g: green b: blue range: 255.

]

Extension { #name : #Morph }

{ #category : #'*Glamour-Morphic-Brick' }
Morph >> asBrick [
	
	^ GLMMorphBrick on: self
]

{ #category : #'*Glamour-Morphic-Brick' }
Morph >> brickDoubleLink [

	^ self valueOfProperty: #brickDoubleLink ifAbsentPut: [ nil ]
]

{ #category : #'*Glamour-Morphic-Brick' }
Morph >> brickDoubleLink: aDoubleLink [

	self setProperty: #brickDoubleLink toValue: aDoubleLink
]

{ #category : #'*Glamour-Morphic-Brick' }
Morph >> brickThemer [
	^ (self nearestOwnerThat: [ :each | (each isKindOf: GLMFoundationBrick) | (each isKindOf: GLMBrick) ])
		ifNotNil: [ :brick | brick themer ]
		ifNil: [ self theme brickThemer ]
]

{ #category : #'*Glamour-Morphic-Brick' }
Morph >> brickThemerChanged [

	self submorphs do: #brickThemerChanged
]

{ #category : #'*Glamour-Morphic-Brick' }
Morph >> exportAsPNGSilently [
	| fName time |
	time := (DateAndTime now asString copyReplaceAll: ':' with: '-') copyReplaceAll: '.' with: '-'.
	fName := self externalName, time , '.png'.
	PNGReadWriter putForm: self imageForm onFileNamed: fName
]

{ #category : #'*Glamour-Morphic-Brick' }
Morph >> isBrick [

	^ false
]

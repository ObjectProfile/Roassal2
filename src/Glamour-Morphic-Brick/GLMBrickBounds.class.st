Class {
	#name : #GLMBrickBounds,
	#superclass : #Object,
	#instVars : [
		'bounds',
		'widthState',
		'heightState'
	],
	#category : #'Glamour-Morphic-Brick-Utils'
}

{ #category : #accessing }
GLMBrickBounds >> bounds [

	^ bounds ifNil: [ bounds := 0@0 corner: 50@50 ]
]

{ #category : #accessing }
GLMBrickBounds >> bounds: aRectangle [

	self bounds width = aRectangle width ifFalse: [ self markWidthDirty ].
	self bounds height = aRectangle height ifFalse: [ self markHeightDirty ].
	bounds := aRectangle
]

{ #category : #accessing }
GLMBrickBounds >> heightState [

	^ heightState ifNil: [ heightState := #clean ]
]

{ #category : #accessing }
GLMBrickBounds >> heightState: aSymbol [

	heightState := aSymbol
]

{ #category : #testing }
GLMBrickBounds >> isHeightClean [

	^ self heightState = #clean
]

{ #category : #testing }
GLMBrickBounds >> isHeightDirty [

	^ self heightState = #dirty
]

{ #category : #testing }
GLMBrickBounds >> isWidthClean [

	^ self widthState = #clean
]

{ #category : #testing }
GLMBrickBounds >> isWidthDirty [

	^ self widthState = #dirty
]

{ #category : #marking }
GLMBrickBounds >> markHeightClean [

	self heightState: #clean
]

{ #category : #marking }
GLMBrickBounds >> markHeightDirty [

	self heightState: #dirty
]

{ #category : #marking }
GLMBrickBounds >> markWidthClean [

	self widthState: #clean
]

{ #category : #marking }
GLMBrickBounds >> markWidthDirty [

	self widthState: #dirty
]

{ #category : #accessing }
GLMBrickBounds >> widthState [

	^ widthState ifNil: [ widthState := #clean ]
]

{ #category : #accessing }
GLMBrickBounds >> widthState: aSymbol [

	widthState := aSymbol
]

Class {
	#name : #GLMBrickDarkThemer,
	#superclass : #GLMBrickThemer,
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #brick }
GLMBrickDarkThemer >> contentBackgroundColor [

	^ Color darkGray darker
]

{ #category : #'brick-scrollbar' }
GLMBrickDarkThemer >> scrollbarColor [

	^ Color black alpha: 0.5
]

{ #category : #brick }
GLMBrickDarkThemer >> textColor [

	^ Color white slightlyDarker
]

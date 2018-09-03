"
I'm a style module related to a rubric text fields and its componenets
"
Trait {
	#name : #GLMBrickRubricStyle,
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #'brick-rubric' }
GLMBrickRubricStyle >> rubricBackgroundColor [

	^ self contentBackgroundColor
]

{ #category : #'brick-rubric' }
GLMBrickRubricStyle >> rubricBorderColor [

	^ Color transparent
]

{ #category : #'brick-rubric' }
GLMBrickRubricStyle >> rubricBorderWidth [

	^ 0
]

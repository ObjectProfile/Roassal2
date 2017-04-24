Class {
	#name : #TRWhiteTheme,
	#superclass : #TRAbstractTheme,
	#classInstVars : [
		'default'
	],
	#category : #'Trachel-Theme'
}

{ #category : #accessing }
TRWhiteTheme class >> default [
	"Return the default theme"
	default ifNil: [ default := self new ].
	^ default
]

{ #category : #accessing }
TRWhiteTheme >> trachelCanvasColor [
	^ Color white
]

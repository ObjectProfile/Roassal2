Class {
	#name : #TRAbstractTheme,
	#superclass : #TRObject,
	#category : #'Trachel-Theme'
}

{ #category : #accessing }
TRAbstractTheme >> trachelCanvasColor [
	^ self subclassResponsibility 
]

{ #category : #accessing }
TRAbstractTheme >> transformColor: aColor [
	"Per default, there is no color transformation"
	^ aColor
]

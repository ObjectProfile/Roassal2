Class {
	#name : #RTSVGAbstractLine,
	#superclass : #RTSVGEntity,
	#instVars : [
		'decoration'
	],
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #adding }
RTSVGAbstractLine >> addMarker: stream [
	stream 
		nextPutAll: 'marker-end = "url(#marker' , (self getDecorationId: self decoration) , ')" '
]

{ #category : #accessing }
RTSVGAbstractLine >> decoration [
	^ decoration
]

{ #category : #accessing }
RTSVGAbstractLine >> decoration: anObject [
	decoration := anObject
]

{ #category : #utils }
RTSVGAbstractLine >> getDecorationId: aLineDecorationShape [
	|t w c s lw|
	t := aLineDecorationShape type.
	w := aLineDecorationShape mySize.
	c := aLineDecorationShape color.
	s := aLineDecorationShape strokePaint.
	lw := aLineDecorationShape width.
	^(t asString, w asString, ((c red * 256) + (s red * 256)) rounded asString, ((c green * 256) + (s green * 256)) rounded asString, ((c blue * 256) + (s blue * 256)) rounded asString, lw asString)
	
]

{ #category : #accessing }
RTSVGAbstractLine >> id [
	^ id
]

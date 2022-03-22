"
A RTSVGAbstractLine refers to the common interface for both regular SVG lines and bezier lines (as paths).

The decoration refers to the Maker of the Line.
"
Class {
	#name : #RTSVGAbstractLine,
	#superclass : #RTSVGEntity,
	#instVars : [
		'decorationsInfo'
	],
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #utils }
RTSVGAbstractLine class >> getDecorationId: aDecorationInfo [

	| t w c s lw shape sp |
	shape := aDecorationInfo decoration.
	t := shape class name.
	w := shape mySize.
	c := shape color.
	sp := shape strokePaint.
	lw := shape width.
	s := aDecorationInfo startOrEnd.
	^ t asString , w asString
	  , (c red * 256 + (sp red * 256)) rounded asString
	  , (c green * 256 + (sp green * 256)) rounded asString
	  , (c blue * 256 + (sp blue * 256)) rounded asString , lw asString
	  , s asString
]

{ #category : #adding }
RTSVGAbstractLine >> addMarkers: stream [

	self decorationsInfo do: [ :eachDecorationInfo | 
		stream
			nextPutAll: 'marker-';
			nextPutAll: eachDecorationInfo startOrEnd;
			nextPutAll: ' = "url(#marker';
			nextPutAll: (self class getDecorationId: eachDecorationInfo);
			nextPutAll: ')" ' ]
]

{ #category : #accessing }
RTSVGAbstractLine >> decorationsInfo [

	^ decorationsInfo
]

{ #category : #accessing }
RTSVGAbstractLine >> decorationsInfo: anArray [

	decorationsInfo := anArray
]

{ #category : #accessing }
RTSVGAbstractLine >> id [
	^ id
]

{ #category : #initialization }
RTSVGAbstractLine >> initialize [

	super initialize.
	decorationsInfo := #(  )
]

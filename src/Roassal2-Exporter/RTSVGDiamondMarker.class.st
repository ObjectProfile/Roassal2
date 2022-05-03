"
A RTSVGDiamondMarker is a diamond shape marker.

"
Class {
	#name : #RTSVGDiamondMarker,
	#superclass : #RTSVGAbstractMarker,
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #adding }
RTSVGDiamondMarker >> addPath: stream [

	stream nextPutAll:
		(' d="M 0 5 l <2p> <1p> l <2p> -<1p> l -<2p> -<1p> z" '
			 expandMacrosWith: (yExtent / 2) rounded
			 with: (xExtent / 2) rounded)
]

{ #category : #adding }
RTSVGDiamondMarker >> addSize: stream [

	stream nextPutAll: ('markerWidth = "<1p>" markerHeight = "<2p>" '
			 expandMacrosWith: 2 * size
			 with: size)
]

{ #category : #initialization }
RTSVGDiamondMarker >> initialize [

	super initialize.
	xExtent := 20.
	yExtent := 10
]

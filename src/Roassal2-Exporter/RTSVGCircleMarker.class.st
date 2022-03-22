Class {
	#name : #RTSVGCircleMarker,
	#superclass : #RTSVGAbstractMarker,
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #adding }
RTSVGCircleMarker >> addPath: stream [

	stream nextPutAll:
		(' d="M 0, <1p> a <1p>,<1p> 0 1,0 <2p>,0 a <1p>,<1p> 0 1,0 -<2p>,0" ' 
			 expandMacrosWith: (xExtent / 2) rounded with: xExtent)
]

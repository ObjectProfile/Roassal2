"
A RTSVGArrowHeadMarker is an arrow-head marker.

"
Class {
	#name : #RTSVGArrowHeadMarker,
	#superclass : #RTSVGAbstractMarker,
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #adding }
RTSVGArrowHeadMarker >> addPath: stream [

	"<1p> = half of width
	 <2p> = move needed from x furthest from attach point to the x closest attach point
	 <3p> = opposite of <2p>
	 <4p> = x furthest from attach point"

	stream nextPutAll: (' d="M <4p> 0 l <2p> <1p> l <3p> <1p> z" '
			 expandMacrosWith: (yExtent / 2) rounded
			 with: (self isOnStart
					  ifTrue: [ xExtent negated ]
					  ifFalse: [ xExtent ])
			 with: (self isOnStart
					  ifTrue: [ xExtent ]
					  ifFalse: [ xExtent negated ])
			 with: (self isOnStart
					  ifTrue: [ xExtent ]
					  ifFalse: [ 0 ]))
]

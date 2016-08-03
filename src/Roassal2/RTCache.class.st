Class {
	#name : #RTCache,
	#superclass : #RTObject,
	#category : #'Roassal2-Cachetor'
}

{ #category : #'as yet unclassified' }
RTCache >> cacheElements: someElements [
	"This method is assuming all the elements belong to the same view"
	| view newElement group position |
	group := someElements asGroup.
	view := someElements anyOne view.
	newElement := (RTBitmap new form: (self getFormElements: group)) element.
	position := group position.
	newElement translateTo: position.
	group remove.
	view add: newElement.
]

{ #category : #'as yet unclassified' }
RTCache >> cacheElements: someElements edges: someEdges [
	"This method is assuming all the elements belong to the same view"
	| view newElement group position |
	group := someElements asGroup.
	view := someElements anyOne view.
	newElement := (RTBitmap new form: (self getFormElements: group, someEdges asGroup)) element.
	position := group position.
	newElement translateTo: position.
	group remove.
	view add: newElement.
]

{ #category : #'as yet unclassified' }
RTCache >> cacheView: aView [
	self cacheElements: aView elements edges: aView edges
]

{ #category : #'as yet unclassified' }
RTCache >> getFormElements: someElements [
	"Return a form contains the graphical representation of the elements"
	
	| extent surface formCanvas |
	extent := someElements extent asIntegerPoint.
	surface := TRPlatform current surfaceClass extent: extent.
	formCanvas := TRPlatform current formCanvasClass extent: extent.
	formCanvas fillRectangle: ((0 @ 0) extent: extent) color: Color transparent.
	surface
		drawDuring: [ :cs | 
			"Probably not necessary since we have just created a surface"
			cs pathTransform
				translateBy: (someElements encompassingRectangle topLeft) negated asFloatPoint
				"translateBy: (someElements position asFloatPoint) negated"
				"scaleBy: self cameraScale;
				translateBy: self cameraPositionNegated".
			surface clear.
			someElements do: [ :element | element trachelShape drawOn: cs ].
			cs pathTransform loadIdentity scaleBy: 1.001. ].
	formCanvas
		image: surface asForm
		at: 0 @ 0
		sourceRect: (0 @ 0 extent: surface extent)
		rule: 34.
	^ formCanvas form
]

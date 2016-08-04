"
I am class to handle a lot of elements and draw

I am still growing, if you find a best answer to cache elements, please let me to to akevalion@gmail.co
"
Class {
	#name : #RTCache,
	#superclass : #RTObject,
	#instVars : [
		'canvas',
		'trachelShapes',
		'shapeBeingPointed'
	],
	#category : #'Roassal2-Cachetor'
}

{ #category : #private }
RTCache >> cacheElements: someElements [
	^ self cacheElements: someElements edges: #().
	
]

{ #category : #private }
RTCache >> cacheElements: someElements edges: someEdges [
	"This method is assuming all the elements belong to the same view"
	| view newElement elements edges |
	
	elements := someElements asGroup.
	edges := someEdges asGroup.
	view := someElements anyOne view.
	canvas := view canvas.
	trachelShapes := canvas shapes.
	newElement := (RTBitmap new form: (self getFormElements: elements, edges)) element.
	self addEvents: newElement.
	newElement translateTo: canvas encompassingRectangle center.
	view removeAllElements.
	view add: newElement.
	^ newElement.
]

{ #category : #public }
RTCache >> cacheView: aView [
	self cacheElements: aView elements edges: aView edges
]

{ #category : #private }
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

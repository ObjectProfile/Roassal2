"
I provide some primitives for manipulating with rectangles and its sides.

!! Collaborators

DCRTResizable
"
Class {
	#name : #RTResizableRectangle,
	#superclass : #RTObject,
	#classInstVars : [
		'cornerDirections',
		'oppositeCorners'
	],
	#category : #'Roassal2-Interactions-Resize'
}

{ #category : #accessing }
RTResizableRectangle class >> cornerDirectionFor: aCorner [
	^ self cornerDirections at: aCorner
]

{ #category : #accessing }
RTResizableRectangle class >> cornerDirections [
	^ cornerDirections
		ifNil: [ 
			cornerDirections := {#top -> (0 @ 1).
			#bottom -> (0 @ -1).
			#left -> (1 @ 0).
			#right -> (-1 @ 0).
			#topRight -> (-1 @ 1).
			#bottomRight -> (-1 @ -1).
			#bottomLeft -> (1 @ -1).
			#topLeft -> (1 @ 1)} asDictionary ]
]

{ #category : #accessing }
RTResizableRectangle class >> corners [
	^ #(#topRight #bottomRight #topLeft #bottomLeft)
]

{ #category : #accessing }
RTResizableRectangle class >> cornersAndSides [
	^ {#top.
	#topRight.
	#right.
	#bottomRight.
	#bottom.
	#bottomLeft.
	#left.
	#topLeft}
]

{ #category : #'as yet unclassified' }
RTResizableRectangle class >> oppositeCornerFor: aCorner [
	^ self oppositeCorners at: aCorner
]

{ #category : #'as yet unclassified' }
RTResizableRectangle class >> oppositeCorners [
	^ oppositeCorners
		ifNil: [ 
			oppositeCorners := {#topRight -> #bottomLeft.
			#bottomLeft -> #topRight.
			#bottomRight -> #topLeft.
			#topLeft -> #bottomRight.
			#top -> #bottom.
			#bottom -> #top.
			#left -> #right.
			#right -> #left} asDictionary ]
]

{ #category : #accessing }
RTResizableRectangle class >> sides [
	^ #(#top #right #bottom #left)
]

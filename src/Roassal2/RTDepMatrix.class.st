Class {
	#name : #RTDepMatrix,
	#superclass : #RTBuilder,
	#instVars : [
		'horizontal',
		'vertical',
		'function'
	],
	#category : #'Roassal2-Builder-StructureMatrix'
}

{ #category : #accessing }
RTDepMatrix >> function: aTwoBlockArgument [
	"aTwoBlockArgument should follow the pattern [ :row :column | .... ]
	The block has to return a boolean"
	function := aTwoBlockArgument
]

{ #category : #accessing }
RTDepMatrix >> horizontal: objects [
	horizontal := objects
]

{ #category : #initialization }
RTDepMatrix >> initialize [
	super initialize.
	function := [ :x :y | x = y ].
	view @ RTDraggableView
]

{ #category : #hooks }
RTDepMatrix >> renderIn: aView [
	| x y el |
	x := 0.
	y := 0.
	vertical do: [ :v |
		horizontal do: [ :h |
			(function value: v value: h) ifTrue: [ 
				el := (RTBox new size: 5; color: Color gray) element.
				el translateTo: (x * 5) @ (y * 5).
				aView add: el.
			].
			x := x + 1.
		].
		x := 0.
		y := y + 1.
	].
]

{ #category : #accessing }
RTDepMatrix >> vertical: objects [
	vertical := objects
]

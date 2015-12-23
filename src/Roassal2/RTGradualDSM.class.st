Class {
	#name : #RTGradualDSM,
	#superclass : #RTAbstractDSM,
	#instVars : [
		'score'
	],
	#category : #'Roassal2-Builder-DSM'
}

{ #category : #examples }
RTGradualDSM class >> example01 [

	<script>
	

	| dsm values |
	dsm := RTGradualDSM new.

	values := { 1->#(2 3 1 5 6) . 2 -> #(1 2 1 1 1 1 4) . 3 -> #(1 2 5 3 2) . 4 -> #(2 5 1) . 5 -> #() . 6 -> #(4) } asDictionary.
	dsm objects: (1 to: 6).
	dsm score: [ :assoc | (values at: assoc key) occurrencesOf: assoc value ].
	dsm inspect.
]

{ #category : #UI }
RTGradualDSM >> defaultCellShape [
	^ RTBox new
		size: self cellSize
]

{ #category : #initialization }
RTGradualDSM >> initialize [
	super initialize.
	score := [ :association | 0 ].
]

{ #category : #hooks }
RTGradualDSM >> renderIn: aView [
	super renderIn: aView.
	RTMetricNormalizer new
		elements: elements;
		normalizeColor: score;
		alphaColor: self transparency.
	^ aView
]

{ #category : #accessing }
RTGradualDSM >> score [
	^ score
]

{ #category : #accessing }
RTGradualDSM >> score: oneArgBlock [
	"The argument is a one arg block that takes an association as parameter.
	The block has to return a numerical value. No predefined bounds is required"
	score := oneArgBlock
]

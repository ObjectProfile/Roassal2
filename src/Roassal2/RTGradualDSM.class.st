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

{ #category : #examples }
RTGradualDSM class >> example02Authorship [
	<script>
	| classes classesToAuthors authors authorsToClasses b |
	classes := RTShape withAllSubclasses.

	classesToAuthors := (classes collect: [ :cls | cls -> ((cls methods collect: #author) asSet sortedAs: #yourself) ]) asDictionary.
	authors := (classesToAuthors values flatCollect: #yourself) asSet sortedAs: #yourself.
	authorsToClasses := (authors collect: [ :anAuthor | anAuthor -> (classesToAuthors associations select: [ :as | as value includes: anAuthor ] thenCollect: #key) ]) asDictionary.

	b := RTGradualDSM new.
	b objectsX: classes.
	b objectsY: authors.
	b score: [ :assoc | (assoc value methods collect: #author) occurrencesOf: assoc key ].
	b inspect
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
	transparencyWhenNonHighlighted := 0.9.
	transparencyWhenHighlighted := 0.4
]

{ #category : #hooks }
RTGradualDSM >> renderIn: aView [
	super renderIn: aView.
	RTMetricNormalizer new
		elements: elements;
		normalizeColor: score using: (Array with: Color veryVeryLightGray with: Color red);
		alphaColor: self transparencyWhenNonHighlighted.
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

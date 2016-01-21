"
RTGradualDSM build a Dependency Structural Matrix for a collection of objects and an arbitrary score function. The score is used to give a color to the cell.

For example, inspect the following:
[[[ 
	dsm := RTGradualDSM new.

	values := { 1->#(2 3 1 5 6) . 2 -> #(1 2 1 1 1 1 4) . 3 -> #(1 2 5 3 2) . 4 -> #(2 5 1) . 5 -> #() . 6 -> #(4) } asDictionary.
	dsm objects: (1 to: 6).
	dsm score: [ :assoc | (values at: assoc key) occurrencesOf: assoc value ].
	dsm.
]]]
"
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

{ #category : #examples }
RTGradualDSM class >> example03AuthorshipByTime [
	<script>
	| classes classesToAuthors authors authorsToClasses b intervalDays oldAge youngAge diff c |
	classes := RTShape withAllSubclasses.
	intervalDays := 100.
	oldAge := (classes collect: #ageInDaysRounded) max.
	youngAge := (classes collect: #ageInDaysRounded) min.
	
	diff := oldAge - youngAge.
	
	c := RTComposer new.
	youngAge to: oldAge by: intervalDays do: [ :t |  
		classesToAuthors := (classes collect: [ :cls | cls -> (((cls methods select: [ :m | (t to: t + intervalDays) rangeIncludes: m ageInDaysRounded ]) collect: #author) asSet sortedAs: #yourself) ]) asDictionary.
		authors := (classesToAuthors values flatCollect: #yourself) asSet sortedAs: #yourself.
		authorsToClasses := (authors collect: [ :anAuthor | anAuthor -> (classesToAuthors associations select: [ :as | as value includes: anAuthor ] thenCollect: #key) ]) asDictionary.

		b := RTGradualDSM new.
		b view: c view.
		b objectsX: classes.
		b objectsY: authors.
		b score: [ :assoc | (assoc value methods collect: #author) occurrencesOf: assoc key ].
		b build.
		c group: t asString asSymbol.
	].
	c layout: (RTGridLayout new gapSize: 30).
	youngAge to: oldAge by: intervalDays do: [ :t |  
		c nameGroup: t asString asSymbol as: 'Time ', t asString ].
	c view inspect
]

{ #category : #UI }
RTGradualDSM >> defaultCellShape [
	^ RTBox new
		size: self cellSize;
		color: RTBox defaultColor
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
	
	"Make sure that if all the score is the same, then we paint with the maximum color. Maybe this is not the best behavior"
"	((elements collect: #model) collect: score) asSet size = 1
		ifTrue: [ elements do: [ :e | e trachelShape color: Color red ]. ^ self ].
"	
	
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

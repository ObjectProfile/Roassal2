Class {
	#name : #RTMatrixBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'table',
		'titleShapeBuilder'
	],
	#category : #'RoassalObsolete-Builder-Matrix'
}

{ #category : #factories }
RTMatrixBuilder >> createLayoutBuilder [
	layoutBuilder := RTLayoutBuilder new.
	layoutBuilder cell.
	^ layoutBuilder
]

{ #category : #hooks }
RTMatrixBuilder >> createShapeBuilder [
	^ super createShapeBuilder label
]

{ #category : #'as yet unclassified' }
RTMatrixBuilder >> createTitleShapeBuilder [

	titleShapeBuilder := RTShapeBuilder new.
	titleShapeBuilder label.
	^ titleShapeBuilder
]

{ #category : #hooks }
RTMatrixBuilder >> createView [
	^ super createView
			setDefaultMenu;
			@ RTDraggableView;
			yourself
]

{ #category : #examples }
RTMatrixBuilder >> example01 [
	"
	self new example01
	"
	| b |
	b := RTMatrixBuilder new.
	b inputCSV: 'FirstName,LastName,Title,ReportsTo.Email,Birthdate,Description
Tom,Jones,Senior Director,buyer@salesforcesample.com,1940-06-07Z,"Self-described as ""the top"" branding guru on the West Coast"
Ian,Dury,Chief Imagineer,cto@salesforcesample.com,,"World-renowned expert in fuzzy logic design. Influential in technology purchases."
'.

	b titleShape color: Color black.
	b shape color: Color gray.
	b open
]

{ #category : #examples }
RTMatrixBuilder >> example02 [
	"
	self new example02
	"
	| b |
	b := RTMatrixBuilder new.
	b inputCSV: 'FirstName,LastName,Title,ReportsTo.Email,Birthdate,Description
Tom,Jones,Senior Director,buyer@salesforcesample.com,1940-06-07Z,"Self-described as ""the top"" branding guru on the West Coast"
Ian,Dury,Chief Imagineer,cto@salesforcesample.com,,"World-renowned expert in fuzzy logic design. Influential in technology purchases."
'.

	b titleShape color: Color black.
	b shape color: Color gray.
	b open
]

{ #category : #examples }
RTMatrixBuilder >> example03 [
	"
	self new example03
	"
	| b |
	b := RTMatrixBuilder new.
	b inputCSV: RTMapLocationBuilder new seismData2.

	b titleShape color: Color black.
	b shape color: Color gray.
	b open
]

{ #category : #initialization }
RTMatrixBuilder >> initialize [
	super initialize.
	self createLayoutBuilder.
	self createTitleShapeBuilder
]

{ #category : #'as yet unclassified' }
RTMatrixBuilder >> inputCSV: aTSVString [ 
	"Argument is a string describing a tab-separated values file"
	^ self inputTable: (RTTabTable new input: aTSVString usingDelimiter: $,)
]

{ #category : #'as yet unclassified' }
RTMatrixBuilder >> inputTSV: aTSVString [ 
	"Argument is a string describing a tab-separated values file"
	^ self inputTable: (RTTabTable new input: aTSVString)
]

{ #category : #'as yet unclassified' }
RTMatrixBuilder >> inputTable: aTable [
	table := aTable
]

{ #category : #accessing }
RTMatrixBuilder >> layout [
	^ layoutBuilder
]

{ #category : #hooks }
RTMatrixBuilder >> renderIn: aView [
	| allElements |
	allElements := RTGroup new.
	
	allElements addAll: (titleShapeBuilder elementsOn: (table values first)).

	table values allButFirst do: [ :someValues |
		allElements addAll: (shapeBuilder elementsOn: someValues)
	].

	layoutBuilder layout
		lineItemsCount: table numberOfColumns;
		on: allElements.
	aView addAll: allElements.
	^ allElements
]

{ #category : #'as yet unclassified' }
RTMatrixBuilder >> titleShape [
	^ titleShapeBuilder 
]

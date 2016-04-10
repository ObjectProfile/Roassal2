"
This class contains many data sets. 
"
Class {
	#name : #RTRDatasets,
	#superclass : #Object,
	#classInstVars : [
		'packages',
		'rDataSets'
	],
	#category : #'Roassal2-Table'
}

{ #category : #'as yet unclassified' }
RTRDatasets class >> from: aPackage [
	rDataSets isNil
		ifTrue: [ self loadRDatasets ].
	^ (rDataSets values select: [ :row | row first = aPackage ]) collect:[:each | each at:2]
]

{ #category : #'as yet unclassified' }
RTRDatasets class >> initialize [
	rDataSets := nil
]

{ #category : #'as yet unclassified' }
RTRDatasets class >> listOfRDatasets [
	"Return the list of data sets availables
	self listOfRDatasets
	"
	rDataSets ifNil: [ self loadRDatasets ].
	^ rDataSets
]

{ #category : #'as yet unclassified' }
RTRDatasets class >> load: aDataSet from: aPackage [
	"Return a RTTabTable corresponding to a dataset name and a dataset package.
	The list of packages and dataset available is given by executing the expression: self listOfRDatasets
	
	For example:
	RTRDatasets load:'Titanic' from:'datasets'
	Return the list of survival of the titatic disaster.
	
	RTRDatasets load: 'Yogurt' from: 'Ecdat'
	Note that the returned table probably needs some column conversions.
	"
	| items dataSet |
	rDataSets isNil
		ifTrue: [ self loadRDatasets ].
	items := rDataSets values select: [ :row | row first = aPackage ].
	dataSet := items detect: [ :row | row second = aDataSet ].
	^ RTTabTable new input: (dataSet at: 4) asUrl retrieveContents usingDelimiter: $,
]

{ #category : #'as yet unclassified' }
RTRDatasets class >> loadRDatasets [
	"Load the list of data sets and packages"
	rDataSets  := RTTabTable new
		input: 'http://vincentarelbundock.github.com/Rdatasets/datasets.csv' asUrl retrieveContents
		usingDelimiter: $,.
	rDataSets removeFirstRow.
	rDataSets convertColumns: #(1 2 3 4) to:[:aString| aString allButFirst allButLast ]
]

{ #category : #accessing }
RTRDatasets class >> packages [
	rDataSets isNil
		ifTrue: [ self loadRDatasets  ].
	packages := Set new.
	rDataSets values do: [ :row | packages add: row first ].
	^ packages
]

Class {
	#name : #RTTabTableTest,
	#superclass : #RTTest,
	#instVars : [
		'tab'
	],
	#category : #'Roassal2-Builder-Map'
}

{ #category : #running }
RTTabTableTest >> setUp [
	super setUp.
	tab := RTTabTable new
]

{ #category : #tests }
RTTabTableTest >> testGathering [

	tab input: '1 A
2 B
1 A
1 A
5 B' usingDelimiter: $ .
	tab convertColumn: 1 to: #asInteger.
	tab gather: 2 using: [ :row1 :row2 | Array with: row1 first + row2 first with: row1 second ].
	self assert: (tab values = #( #(3 'A') #(7 'B')))
]

{ #category : #tests }
RTTabTableTest >> testProcessing [

	tab input: 'France	20
Germany	80'.
	tab convertColumn: 2 to: #asInteger.
	self assert: (tab values = #( #('France' 20) #('Germany' 80)))
]

{ #category : #tests }
RTTabTableTest >> testProcessingWithEmptyLines [

	tab input: 'France	20
Germany	80
'.
	tab convertColumn: 2 to: #asInteger.
	self assert: (tab values = #( #('France' 20) #('Germany' 80)))
]

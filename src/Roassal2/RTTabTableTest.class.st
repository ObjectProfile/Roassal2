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
RTTabTableTest >> testAccessing [

	tab input: '
	m1	m2	m3
A	1	2	5
B	2	5	4
C	1	7	4	'.
	self assert: tab numberOfRows = 4.
	tab removeFirstRow.
	self assert: tab numberOfRows = 3.
]

{ #category : #tests }
RTTabTableTest >> testAccessing2 [

	tab input: '
	m1	m2	m3

A	1	2	5

B	2	5	4

C	1	7	4	'.
	self assert: tab numberOfRows = 4.
	tab removeFirstRow.
	self assert: tab numberOfRows = 3.
	self assert: tab numberOfColumns = 4.
	self assert: tab firstColumn = (Array with: 'A' with: 'B' with: 'C').

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
RTTabTableTest >> testMassiveConvertion [

	tab input: '
	m1	m2	m3
A	1	2	5
B	2	5	4
C	1	7	4	'.
	tab removeFirstRow.
	self assert: tab values first second = '1'.
	self assert: tab values third third = '7'.
	
	tab convertColumns: (2 to: 4) to: [ :s | Integer readFrom: s ]. 
	self assert: tab values first second = 1.
	self assert: tab values third third = 7.
	
	self assert: tab minimum = 1.
	self assert: tab maximum = 7.
	
	self assert: (tab maxOfColumn: #second) = 2.
	self assert: (tab maxOfColumn: #fourth) = 5.
	self assert: (tab maxOfColumn: [ :row | row at: 3 ]) = 7.
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

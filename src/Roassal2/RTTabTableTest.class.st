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
C	1	7	4'.
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

C	1	7	4'.
	self assert: tab numberOfRows = 4.
	tab removeFirstRow.
	self assert: tab numberOfRows = 3.
	self assert: tab numberOfColumns = 4.
	self assert: tab firstColumn = (Array with: 'A' with: 'B' with: 'C').

]

{ #category : #tests }
RTTabTableTest >> testConvertAsFloats [

	tab input: '5.4,1.2,0,hello world' usingDelimiter: $,.
	tab convertColumnsAsFloat: #(1 2 3).
	self assert: tab values first equals: #(5.4 1.2 0 'hello world')
]

{ #category : #tests }
RTTabTableTest >> testConvertAsInteger [

	tab input: '5.4,1.2,0,hello world' usingDelimiter: $,.
	tab convertColumnsAsInteger: #(1 2 3).
	self assert: tab values first equals: #(5 1 0 'hello world')
]

{ #category : #tests }
RTTabTableTest >> testEmptyAndReplaceColumn [

	tab input: ',,' usingDelimiter: $,.
	tab replaceEmptyValuesWith: 0 inColumns: #(1 2 3).
	self assert: tab numberOfColumns equals: 3.
	self assert: tab values first equals: #(0 0 0)
]

{ #category : #tests }
RTTabTableTest >> testEmptyColumn [

	tab input: ',,' usingDelimiter: $,.
	self assert: tab numberOfColumns equals: 3
]

{ #category : #tests }
RTTabTableTest >> testFiltering [

	tab input: 'abc,123,123
5,0,0
1,2,3' usingDelimiter: $,.

	self assert: tab numberOfRows equals: 3.
	tab rejectRow: [ :row | row first = 'abc' ]. 
	self assert: tab numberOfRows equals: 2.
	tab rejectRow: [ :row | row first = 'abc' ].
	self assert: tab numberOfRows equals: 2.
]

{ #category : #tests }
RTTabTableTest >> testFilteringPerColumn [

	tab input: 'abc,123,123
5,0,0
1,2,3' usingDelimiter: $,.

	tab convertColumnAsInteger: 2.
	self assert: tab numberOfRows equals: 3.
	tab rejectInColumn: 2 row: #isZero. 
	self assert: tab numberOfRows equals: 2.

	tab rejectInColumn: 2 row: #isZero. 
	self assert: tab numberOfRows equals: 2.

	tab rejectRow: [ :row | row first = 'abc' ].
	self assert: tab numberOfRows equals: 1.
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
RTTabTableTest >> testMinimumAndMaximum [

	tab input: 
'5.4,1.2,0,hello world
-56,1.2,100,bravo' usingDelimiters: ','.
	tab convertColumnsAsFloat: #(1 2 3).
	self assert: tab minimum equals: -56.0.
	self assert: tab maximum equals: 100.
	
	self assert: (tab maxOfColumn: #first) equals: 5.4.
	self assert: (tab maxOfColumn: #second) equals: 1.2.
	self assert: (tab maxOfColumn: #third) equals: 100.0.
	
	self assert: tab firstColumn equals: #(5.4 -56).
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

{ #category : #tests }
RTTabTableTest >> testRemovingColumn [

	tab input: 'France	20	toremove
Germany	80	toremove'.
	tab removeColumn: 3.
	self assert: (tab values = #( #('France' '20') #('Germany' '80')))
]

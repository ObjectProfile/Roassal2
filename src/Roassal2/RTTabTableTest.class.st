Class {
	#name : #RTTabTableTest,
	#superclass : #RTTest,
	#instVars : [
		'tab'
	],
	#category : #'Roassal2-Table'
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
RTTabTableTest >> testCommasInsideQuotes [

	tab input:
  '2014-01-26 00:00:00+00,Boeing 737-3B7 (SF),ZK-TLC,"Airwork, NZ,opf. Pacific Air Express",0,Honiara-Henderson International Airport(HIR),Solomon Islands,-9.428056,160.053056,"Brisbane International Airport, QLD (BNE/YBBN), Australia","Honiara-Henderson International Airport (HIR/AGGH), Solomon Islands",Accident resulting in a total loss of the plane,0101000020E6100000691B7FA2B201644091B6F1272ADB22C0,7,2014-07-18 11:46:49.32676+00,2014-07-18 11:47:01.156893+00'
  usingDelimiter: $,.
  self assert: tab numberOfColumns equals: 16
]

{ #category : #tests }
RTTabTableTest >> testConvertAsDateAndTime [

	tab input: 
'Ebola2.1,POINT (-9.696645 9.945587),2014-01-01T00:00:00,2015-01-01T00:00:00,Guinea,9.945587,-9.696645,ZEBOV,528,337,64%,"Outbreak is currently ongoing in southeastern Guinea, including the capital?Conakry?and the neighbour countries?Sierra Leone?andLiberia"
Ebola2.2,POINT (32.290275 1.373333),2012-01-01T00:00:00,-0002-12-29T00:00:00,Uganda,1.373333,32.290275,SEBOV,24,17,71%,Outbreak occurred in the?Kibaale District.[34]
Ebola2.6,POINT (21.758664 -4.038333),2008-01-01T00:00:00,2009-01-01T00:00:00,Democratic Republic of Congo,-4.038333,21.758664,ZEBOV,32,14,45%,Outbreak occurred in the Mweka and Luebo health zones of the Province of?Kasai-Occidental.[33]' usingDelimiter: $,.
	tab convertColumnAsDateAndTime: 3.
	tab convertColumnAsDateAndTime: 4.
	self assert: tab values size equals: 3.
	
	self assert: tab values first third year equals: 2014.
	self assert: tab values last third year equals: 2008.
	self assert: tab values last fourth year equals: 2009.
	self assert: tab values last fourth month equals: 1.
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

{ #category : #tests }
RTTabTableTest >> testUsingFirstRow [

	| tabString |
	tabString :=
'
x,y
4,1
2,6
1,3
1,5
'.
	tab := RTTabTable new input: tabString usingDelimiter: $,.
	tab removeFirstRow.
	tab convertColumnsAsInteger: #('x' 'y').
	
	self assert: (tab indexOfName: 'x') equals: 1.
	self assert: (tab indexOfName: 'y') equals: 2.
	
	self assert: (tab valuesOfColumn: 'x') equals: #(4 2 1 1).
	
	self assert: (tab convertFromNameToIndexIfNecessary: 1) equals: 1.
	self assert: (tab convertFromNameToIndexIfNecessary: 100) equals: 100.
	self assert: (tab convertFromNameToIndexIfNecessary: 'x') equals: 1.
	self assert: (tab convertFromNameToIndexIfNecessary: 'y') equals: 2.
]

{ #category : #tests }
RTTabTableTest >> testWithQuote [

	tab input: 'abc,def,"ghi,ijk"' usingDelimiter: $,.
	self assert: tab numberOfColumns equals: 3
]

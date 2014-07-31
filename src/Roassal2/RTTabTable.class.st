Class {
	#name : #RTTabTable,
	#superclass : #Object,
	#instVars : [
		'attributes',
		'values'
	],
	#category : #'Roassal2-Builder-Map'
}

{ #category : #accessing }
RTTabTable >> attributes [
	attributes ifNil: [ attributes := Dictionary new ].
	^ attributes
]

{ #category : #converting }
RTTabTable >> convertColumn: index to: blockForConvertion [
	"Convert a column of the table"
	values do: [ :row | 
		| v |
		v := row at: index.
		row at: index put: (blockForConvertion rtValue: v)
		 ]
]

{ #category : #converting }
RTTabTable >> convertColumnAsInteger: nbColumn [
	^ self convertColumnsAsInteger: (Array with: nbColumn)
]

{ #category : #converting }
RTTabTable >> convertColumns: collectionOfIntegers to: aBlock [
	"collectionOfIntegers is a collection of integers corresponding to column to convert"
	"block is a one-arg block that takes as input a string and return the wanted value"

	collectionOfIntegers do: [ :index | 
		self convertColumn: index to: aBlock ]
]

{ #category : #converting }
RTTabTable >> convertColumnsAsFloat: collectionOfIntegers [
	^ self convertColumns: collectionOfIntegers to: [ :s | Float readFrom: s ]
]

{ #category : #converting }
RTTabTable >> convertColumnsAsInteger: collectionOfIntegers [
	^ self convertColumns: collectionOfIntegers to: [ :s | Integer readFrom: s ]
]

{ #category : #accessing }
RTTabTable >> firstColumn [
	^ self valuesOfColumn: 1
]

{ #category : #converting }
RTTabTable >> gather: columnIndex using: twoArgBlock [
	| d key | 
	d := Dictionary new.
	values do: [ :row |
		key := row at: columnIndex.
		(d includesKey: key)
			ifTrue: [ d at: key put: (twoArgBlock value: (d at: key) value: row) ]
			ifFalse: [ d at: key put: row ] ].
	values := d values
]

{ #category : #updating }
RTTabTable >> input: txt [
	"txt is a large string in which we have one entry per line"
	^ self input: txt usingDelimiter: Character tab
]

{ #category : #updating }
RTTabTable >> input: txt usingDelimiter: delimitersAsCharacter [
	"txt is a large string in which we have one entry per line"
	values := (txt lines select: #notEmpty
						thenCollect: [ :l | l subStringsKeepingEmptyFields: delimitersAsCharacter asString ])
						select: #notEmpty
]

{ #category : #updating }
RTTabTable >> input: txt usingDelimiters: delimitersAsString [
	"txt is a large string in which we have one entry per line"
	values := txt lines collect: [ :l | l subStrings: delimitersAsString ]
]

{ #category : #accessing }
RTTabTable >> maxOfColumn: aBlock [
	| max |
	max := -100000.
	self values do: [ :row | max := max max: (aBlock rtValue: row) ].
	^ max
]

{ #category : #accessing }
RTTabTable >> maximum [
	| max |
	"We initialize the mininum to any value found in the table"
	max := self values last detect: #isNumber ifNone: [ 0 ].
	
	self values do: [ :row |
		row do: [ :value | 
			value isNumber ifTrue: [ max := max max: value ] ] ].
	^ max
]

{ #category : #accessing }
RTTabTable >> minimum [
	"Return the minimum of the whole table"
	| min |
	"We initialize the mininum to any value found in the table"
	min := self values last detect: #isNumber ifNone: [ 0 ].
	
	self values do: [ :row |
		row do: [ :value | 
			value isNumber ifTrue: [ min := min min: value ] ] ].
	^ min
]

{ #category : #accessing }
RTTabTable >> numberOfColumns [
	^ (self values collect: #size) max
]

{ #category : #accessing }
RTTabTable >> numberOfRows [
	^ values size
]

{ #category : #updating }
RTTabTable >> rejectInColumn: nbColumn row: aBlock [
	"Remove rows for which the nbColumn element is evaluated at true"
	self rejectRow: [ :row | aBlock rtValue: (row at: nbColumn) ]

]

{ #category : #updating }
RTTabTable >> rejectRow: aBlock [
	"Remove a row for which the block evaluate to true. The block takes as argument the row"
	values := values reject: [ :v | aBlock rtValue: v ]
]

{ #category : #updating }
RTTabTable >> removeColumn: aNumber [

	values := values collect: [ :v | v copyWithoutIndex: aNumber ]
]

{ #category : #accessing }
RTTabTable >> removeFirstRow [
	"Remove the first line of the table, typically the header"
	values := values allButFirst
]

{ #category : #converting }
RTTabTable >> replaceEmptyValuesWith: aValue inColumns: columns [
	"columns is a collection of integers"
	self convertColumns: columns to: [ :s | s isEmpty ifTrue: [ aValue ] ifFalse: [ s ] ]
]

{ #category : #accessing }
RTTabTable >> values [
	^ values
]

{ #category : #accessing }
RTTabTable >> valuesOfColumn: index [
	^ values collect: [ :row | row at: index ]
]

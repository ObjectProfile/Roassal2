Class {
	#name : #RTTabTable,
	#superclass : #Object,
	#instVars : [
		'attributes',
		'values',
		'firstRow'
	],
	#category : #'Roassal2-Table'
}

{ #category : #accessing }
RTTabTable >> attributes [
	attributes ifNil: [ attributes := Dictionary new ].
	^ attributes
]

{ #category : #updating }
RTTabTable >> breakDown: l usingDelimiters: delimitersAsCharacter [
	^ l subStringsKeepingEmptyFields: delimitersAsCharacter
	

]

{ #category : #converting }
RTTabTable >> convertColumn: index to: blockForConvertion [
	"Convert a column of the table"
	values do: [ :row | 
		| v i |
		i := (self convertFromNameToIndexIfNecessary: index).
		v := row at: i.
		row at: i put: (blockForConvertion rtValue: v)
		 ]
]

{ #category : #converting }
RTTabTable >> convertColumnAsDateAndTime: integerOrString [
	"Replace each element by an instance of DateAndTime"

	self convertColumnsAsDateAndTime: (Array with: (self convertFromNameToIndexIfNecessary: integerOrString))
]

{ #category : #converting }
RTTabTable >> convertColumnAsInteger: integerOrString [
	^ self convertColumnsAsInteger: (Array with: (self convertFromNameToIndexIfNecessary: integerOrString))
]

{ #category : #converting }
RTTabTable >> convertColumns: collectionOfIntegers to: aBlock [
	"collectionOfIntegers is a collection of integers corresponding to column to convert"
	"block is a one-arg block that takes as input a string and return the wanted value"

	collectionOfIntegers do: [ :index | 
		self convertColumn: index to: aBlock ]
]

{ #category : #converting }
RTTabTable >> convertColumnsAsDateAndTime: collectionOfIntegers [
	"collectionOfIntegers is a collection of integers corresponding to column to convert"
	"Replace each element by an instance of DateAndTime"

	self convertColumns: collectionOfIntegers to: [ :s | (TRPlatform current dateAndTimeFromString: s) ]
]

{ #category : #converting }
RTTabTable >> convertColumnsAsFloat: collectionOfIntegers [
	^ self convertColumns: collectionOfIntegers to: [ :s | Float readFrom: s ]
]

{ #category : #converting }
RTTabTable >> convertColumnsAsInteger: collectionOfIntegers [
	^ self convertColumns: collectionOfIntegers to: [ :s | Integer readFrom: s ]
]

{ #category : #'private-utility' }
RTTabTable >> convertFromNameToIndexIfNecessary: anObject [
	"anObject could be a number (to indicate a column index) or a string"
	"The method return the index"
	^ anObject isNumber
		ifTrue: [ anObject ]
		ifFalse: [ 
			"Then we are surely a string" 
			self indexOfName: anObject ]
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

{ #category : #converting }
RTTabTable >> indexOfName: aString [
	"Return the index of the column named aString"
	^ firstRow indexOf: aString
]

{ #category : #updating }
RTTabTable >> input: txt [
	"txt is a large string in which we have one entry per line"
	^ self input: txt usingDelimiter: Character tab
]

{ #category : #updating }
RTTabTable >> input: txt usingDelimiter: delimitersAsCharacter [
	"txt is a large string in which we have one entry per line"

	values := (txt lines 
					select: #notEmpty 
					thenCollect: [ :l | self breakDown: l trimBoth usingDelimiters: delimitersAsCharacter asString ])
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
	firstRow := values first.
	values := values allButFirst
]

{ #category : #converting }
RTTabTable >> replaceEmptyValuesWith: aValue inColumns: columns [
	"columns is a collection of integers"
	self convertColumns: columns to: [ :s | s isEmpty ifTrue: [ aValue ] ifFalse: [ s ] ]
]

{ #category : #converting }
RTTabTable >> replaceZeroWithCumulativeValuesInColumns: columns [
	columns
		do: [ :column | 
			| previous |
			previous := 0.
			values
				do: [ :row | 
					(row at: column) = 0 ifTrue: [ row at: column put: previous ].
					previous := row at: column ] ]
]

{ #category : #accessing }
RTTabTable >> values [
	^ values
]

{ #category : #accessing }
RTTabTable >> valuesOfColumn: indexAsNumberOfString [
	^ values collect: [ :row | row at: (self convertFromNameToIndexIfNecessary: indexAsNumberOfString) ]
]

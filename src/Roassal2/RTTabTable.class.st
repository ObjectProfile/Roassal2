Class {
	#name : #RTTabTable,
	#superclass : #Object,
	#instVars : [
		'values'
	],
	#category : #'Roassal2-Builder-Map'
}

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
	values := txt lines collect: [ :l | l subStrings: delimitersAsCharacter asString ]
]

{ #category : #updating }
RTTabTable >> input: txt usingDelimiters: delimitersAsString [
	"txt is a large string in which we have one entry per line"
	values := txt lines collect: [ :l | l subStrings: delimitersAsString ]
]

{ #category : #accessing }
RTTabTable >> removeFirstRow [
	values := values allButFirst
]

{ #category : #accessing }
RTTabTable >> values [
	^ values
]

{ #category : #accessing }
RTTabTable >> valuesOfColumn: index [
	^ values collect: [ :row | row at: index ]
]

Class {
	#name : #RTSmallMultipleSingleScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins'
}

{ #category : #accessing }
RTSmallMultipleSingleScript >> description [
	^ 
'Visualize a TSV file (like a CSV file but with tabulation instead of comma) as a matrix.
The file should have 4 columns: time<TAB>n1<TAB>n2<TAB>weight.
time is an integer value. It could represent a time period.
n1 and n2 are string values. 
weight is a float value.'
]

{ #category : #hooks }
RTSmallMultipleSingleScript >> execute [
	<script: ' RTSmallMultipleSingleScript new execute'>
	| dic b | 
	dic := Dictionary new.
	RTCVSImporterTMP new
		blockToExecute: [ :line | 
			| a |
			a := line third -> line second.
			dic at: a ifAbsentPut: [ 0 ].
			dic at: a put: (dic at: a) + 1.
			];
		importFile.

	b := RTGradualDSM new.
	b objectsY: (dic keys collect: #key) asSet sorted asArray.
	b objectsX: (dic keys collect: #value) asSet sorted asArray.
	b score: [ :assoc |
		(dic at: assoc ifAbsent: [ 0 ]) ].
	b view @ RTDraggableView @ RTDoubleScrollBar.
	b inspect
]

{ #category : #hooks }
RTSmallMultipleSingleScript >> label [
	^ 'CSV as Small Multiple (All time slices in one)'
]

"
A ROCellLayout is like ROGridLayout. Elements of each column are centered along the same vertical line. And elements of each row are centered along the same horizontal line.

Instance Variables
	inCellPosition:		<Object | Block>

inCellPosition
	- Object which computes position of each element inside a cell. The cell is the space allocated for an element. Its height is maximum of heights of elements on the row. Its width is maximum of widths of elements on the column. By default elements are in the middle of their cell.
"
Class {
	#name : #RTCellLayout,
	#superclass : #RTAbstractGridLayout,
	#instVars : [
		'inCellPosition'
	],
	#category : #'Roassal2-Layouts'
}

{ #category : #hook }
RTCellLayout >> doExecute: elements [ 
	| pointer lineItemCount lineItemSize cell |
	lineItemSize := self lineItemsCountBlock roValue: elements.
	cell := RTCell elements: elements columns: lineItemSize.
	pointer := self gapSize @ self gapSize.
	lineItemCount := 0.
	elements withIndexDo: 
		[ :element :index | 
		cell element: element; number: index.
		pointer := pointer + (cell extent / 2) asIntegerPoint.
		translator translate: element to: pointer.
		pointer := (pointer x + cell extent x + (self gapSize * 2)) @ pointer y.
		lineItemCount := lineItemCount + 1.
		lineItemCount >= lineItemSize ifTrue: 
			[ pointer := self gapSize @ (pointer y + (self gapSize * 2) + cell extent y).
			lineItemCount := 0 ].
		self step ]
]

{ #category : #hook }
RTCellLayout >> doExecute: elements [ 
	| pointer lineItemCount lineItemSize cell |
	lineItemSize := self lineItemsCountBlock roValue: elements.
	cell := RTCell elements: elements columns: lineItemSize.
	pointer := self gapSize @ self gapSize.
	lineItemCount := 0.
	elements withIndexDo: 
		[ :element :index | 
		cell element: element; number: index.
		pointer := pointer + (cell extent / 2) asIntegerPoint.
		translator translate: element to: pointer.
		pointer := (pointer x + cell extent x + (self gapSize * 2)) @ pointer y.
		lineItemCount := lineItemCount + 1.
		lineItemCount >= lineItemSize ifTrue: 
			[ pointer := self gapSize @ (pointer y + (self gapSize * 2) + cell extent y).
			lineItemCount := 0 ].
		self step ]
]

{ #category : #accessing }
RTCellLayout >> inCellPosition: anObjectOrOneArgBlock [

	inCellPosition := anObjectOrOneArgBlock
]

{ #category : #accessing }
RTCellLayout >> inCellPosition: anObjectOrOneArgBlock [

	inCellPosition := anObjectOrOneArgBlock
]

{ #category : #'initialize-release' }
RTCellLayout >> initialize [

	super initialize.

]

{ #category : #'initialize-release' }
RTCellLayout >> initialize [

	super initialize.

]

{ #category : #accessing }
RTCellLayout >> leftCentred [

	self inCellPosition: [ :cell | 0 @ ((cell extent y - cell element height) / 2) ]
]

{ #category : #accessing }
RTCellLayout >> leftCentred [

	self inCellPosition: [ :cell | 0 @ ((cell extent y - cell element height) / 2) ]
]

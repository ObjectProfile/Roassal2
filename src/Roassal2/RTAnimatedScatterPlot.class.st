Class {
	#name : #RTAnimatedScatterPlot,
	#superclass : #RTBuilder,
	#instVars : [
		'tables',
		'x',
		'y',
		'color',
		'size',
		'frame',
		'maxX',
		'maxY',
		'sizeMax',
		'labelShape',
		'colors',
		'properties'
	],
	#category : #'Roassal2-Builder-AnimatedScatterPlot'
}

{ #category : #adding }
RTAnimatedScatterPlot >> addName: aTitle table: aTable [
	"This method will be enhanced later"
	aTable attributes at: #title put: aTitle.
	self addTable: aTable
]

{ #category : #adding }
RTAnimatedScatterPlot >> addTable: table [
	tables add: table.
	table convertColumnsAsInteger: (2 to: table numberOfColumns).
]

{ #category : #enumerating }
RTAnimatedScatterPlot >> allEntries [
	| answer |
	answer := Set new.
	tables do: [ :t | answer addAll: t firstColumn ].
	^ answer asSortedCollection asArray
]

{ #category : #public }
RTAnimatedScatterPlot >> build [
	self renderIn: view
]

{ #category : #accessing }
RTAnimatedScatterPlot >> color: aBlock [
	color := aBlock
]

{ #category : #hooks }
RTAnimatedScatterPlot >> createView [
	| v |
	v := RTView new .
	v setDefaultMenu.
	v @ RTDraggableView.
	^ v
]

{ #category : #accessing }
RTAnimatedScatterPlot >> frame [
	^ frame
]

{ #category : #utlity }
RTAnimatedScatterPlot >> getTableForClasses: classes [
	"
	self new getTableForClasses: { RTAnimatedScatterPlot . RTElement . RTShape }
	"
	
	| s |
	s := WriteStream on: String new.
	classes do: [ :c |
		s nextPutAll: c name.
		s nextPut: Character tab.
		s nextPutAll: (c numberOfMethods) printString.
		s nextPut: Character tab.
		s nextPutAll: (c numberOfVariables) printString.
		s nextPut: Character tab.
		s nextPutAll: (c numberOfLinesOfCode) printString.
		s nextPut: Character tab.
		s cr.
		].
	^ s contents
]

{ #category : #utlity }
RTAnimatedScatterPlot >> getTableForPackage: packageName [
	"
	self new getTableForPackage: 'GraphET2'
	"
	
	| s classes |
	classes := ((RPackageOrganizer default packageNamed: packageName) classes collect: #baseClass) asSet.
	s := WriteStream on: String new.
	classes do: [ :c |
		s nextPutAll: c name.
		s nextPut: Character tab.
		s nextPutAll: (c numberOfMethods) printString.
		s nextPut: Character tab.
		s nextPutAll: (c numberOfVariables) printString.
		s nextPut: Character tab.
		s nextPutAll: (c numberOfLinesOfCode) printString.
		s nextPut: Character tab.
		s cr.
		].
	^ s contents
]

{ #category : #coloring }
RTAnimatedScatterPlot >> if: aBlockForCondition color: aBlockForColor [
	properties add: [ :row :element |
		(aBlockForCondition rtValue: row) ifTrue: [ element trachelShape color: ((aBlockForColor rtValue: row) alpha: 0.4) ] ]
	
]

{ #category : #initialization }
RTAnimatedScatterPlot >> initialize [
	super initialize.
	tables := OrderedCollection new.
	frame := 1.
	properties := OrderedCollection new
]

{ #category : #accessing }
RTAnimatedScatterPlot >> maxOfColumn: aBlock [
	"aBlock is evaluated for each row, in each table, and return the maximum value"
	| max |
	max := tables first maxOfColumn: aBlock.
	tables do: [ :t |
		max := max max: (t maxOfColumn: aBlock)
		 ].
	^ max
]

{ #category : #'public - frames' }
RTAnimatedScatterPlot >> nextFrame [
	frame := (frame + 1) min: self numberOfTables.
	self renderFrame: frame
	
]

{ #category : #'public - frames' }
RTAnimatedScatterPlot >> numberOfTables [
	^ tables size
]

{ #category : #'public - frames' }
RTAnimatedScatterPlot >> previousFrame [
	frame := (frame - 1) max: 1.
	self renderFrame: frame
	
]

{ #category : #'public - frames' }
RTAnimatedScatterPlot >> renderFrame: aFrameNumber [

	| elements newX newY r newSize table |
	table := tables at: aFrameNumber.
	elements := self allEntries collect: [ :entryName | view elementFromModel: entryName ].
	
	elements do: [ :e |
		"We get the row that we are interested in"
		r := table values detect: [ :rrow | rrow first = e model ] ifNone: [ nil ].
		r ifNil: [ newSize := 0. newX := 0. newY := 0 ].
		r ifNotNil: [ 
			newX := (x rtValue: r) max: maxX in: (0 to: 200).
			newY := ((y rtValue: r) max: maxY in: (0 to: 200)) negated.
			newSize := (size rtValue: r) max: sizeMax in: (5 to: 30).
			properties do: [ :prop | prop value: r value: e ]
			].
		view addAnimation: (RTAccelerationMove new to: newX @ newY during: 0.4 on: e).
		e trachelShape size: newSize.
		].

	"Give indication about the frame" 
	labelShape text: 
		(table attributes at: #title ifAbsent: ''), ' ', 
		aFrameNumber printString, '/', 
		self numberOfTables printString.
		
	view signalUpdate
]

{ #category : #hooks }
RTAnimatedScatterPlot >> renderIn: aView [

	| shape es |
	"We take the maximal values"
	sizeMax := self maxOfColumn: size.
	maxX := self maxOfColumn: x.
	maxY := self maxOfColumn: y.

	"Initialize elements"
	shape := RTEllipse new 
			size: 15 "[ :row | (size rtValue: row) 
									max: sizeMax 
									in: (5 to: 30) ]";
			color: (Color gray alpha: 0.4).
	es := shape elementsOn: self allEntries.
	es @ RTPopup.
	es when: TRMouseClick do: [ :evt | evt element inspect ].
	view addAll: es. 
	
	"Set origin"
	view canvas addShape: (TRLineShape new color: Color red; from: 0 @ 0 to: 0 @ -100).
	view canvas addShape: (TRLineShape new color: Color red; from: 0 @ 0 to: 100 @ 0).

	"We render the first frame"
	labelShape := TRLabelShape new text: 'Hello'.
	self renderFrame: frame.
	
	"Render Button"
	view canvas addMenu: 	'<-' callback: [ self previousFrame ].
	view canvas addMenu: 	'->' callback: [ self nextFrame ].
		
	"Set the title"
	view canvas addFixedShape: labelShape.
	labelShape translateTo: 300 @ 20.
	"TRConstraint moveAtTheBottomOfTheWindow: labelShape.
"
]

{ #category : #accessing }
RTAnimatedScatterPlot >> size: aBlock [
	size := aBlock
]

{ #category : #accessing }
RTAnimatedScatterPlot >> x: aBlock [
	x := aBlock
]

{ #category : #accessing }
RTAnimatedScatterPlot >> y: aBlock [
	y := aBlock
]

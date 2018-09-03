"
A RTDowserBuilderTest is the TestClase for RTDowserBuilder.
"
Class {
	#name : #RTDowserBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #Roassal2DowserObsolete
}

{ #category : #initialization }
RTDowserBuilderTest >> initialize [
	builder := RTDuoDowserBuilder new.
	
]

{ #category : #initialization }
RTDowserBuilderTest >> setUp [
	super setUp.
	builder := RTDuoDowserBuilder new.
	
]

{ #category : #duoDowser }
RTDowserBuilderTest >> testAssignMissing1 [
	builder left: (1 to: 20).
	builder assignMissing: [:v |  v + 2] from: 1 to: 2.
	
	self assert: builder right size equals: (builder left size). 
	self assert: builder right size equals: (builder models size).
	self assert: builder right first model equals: 3.
	self assert: builder right last model equals: 22.
]

{ #category : #duoDowser }
RTDowserBuilderTest >> testAssignMissing2 [
	builder left: (1 to: 20).
	builder assignMissing: #ln from: 1 to: 2.
	
	self assert: builder right size equals: (builder left size). 
	self assert: builder right size equals: (builder models size).
	self assert: builder right first model equals: 0.0.
	self assert: builder right last model ceiling equals: 3.
]

{ #category : #duoDowser }
RTDowserBuilderTest >> testAssignMissing3 [
	builder left: (Array with: 'hola' with: 'chao').
	builder assignMissing: [:a | a asOrderedCollection] from: 1 to: 2.
	
	self assert: builder right size equals: 5. "without duplicated letters"
	self assert: builder right first model equals: $h.
	self assert: builder right last model equals: $c.
]

{ #category : #duoDowser }
RTDowserBuilderTest >> testAssociation [
	builder label: [ :c | c name asString].
	builder height: #numberOfMethods.
	builder color: #numberOfLinesOfCode.
	builder onLeftAndRight: Number withAllSubclasses.
	builder edgesTo: #allSubclasses.
	
	self assert: builder left size equals: (builder right size). 
	self assert: builder left first outgoingEdges size equals: 0.
	self assert: builder distance equals: 400.
]

{ #category : #basic }
RTDowserBuilderTest >> testCheckFromTo [
	|b1 b2 b3 b4|
	b1 := [ :v | v + 1 ].
	b2 := [ :a :b | a = (b - 1)].
	b3 := #asString.
	b4 := [ :a | 1 to: a ].
	
	self assert: (builder check: b1 from: 1 to: 2). 
	self assert: ((builder check: b1 from: 2 to: 1) not).
	self assert: (builder check: b2 from: 1 to: 2).
	self assert: ((builder check: b2 from: 2 to: 1) not).
	self assert: (builder check: b3 from: 1 to: '1').
	self assert: ((builder check: b3 from: '1' to: 1) not).
	self assert: (builder check: b4 from: 5 to: 2).
	self assert: ((builder check: b4 from: 2 to: 5) not).
]

{ #category : #duoDowser }
RTDowserBuilderTest >> testConstruction [
	builder models: (Array with: 'a' with: 'b' with: 'c' ).
	builder edgesTo: #yourself.
	
	self assert: builder labelLeft equals: #asString. 
	self assert: builder left size equals: builder right size.  
	self assert: builder legend equals: 'Roassal Dowser'.
	self assert: builder title equals: 'RoassalDowser'.
	self assert: builder body equals: ''.
]

{ #category : #basic }
RTDowserBuilderTest >> testControlPoint2With [
	| e1 e2 e3 e4 p1 p2 p3 p4 |
	e1 := ((RTElement on: 1) + (RTBox new)).
	e2 := ((RTElement on: 2) + (RTBox new)).
	e3 := ((RTElement on: 3) + (RTBox new)).
	e4 := ((RTElement on: 4) + (RTBox new)).
	e2 translateTo: 0@100.
	e3 translateTo: 100@0.
	e4 translateTo: 100@100.
	p1 := builder controlPoint2: e1 with: e4. 
	p2 := builder controlPoint2: e4 with: e1.
	p3 := builder controlPoint2: e2 with: e3.
	p4 := builder controlPoint2: e3 with: e2.
	self assert: p1 x equals: 50.
	self assert: p1 y equals: 25.
	self assert: p2 x equals: 50.
	self assert: p2 y equals: 75.
	self assert: p3 x equals: 50.
	self assert: p3 y equals: 75.
	self assert: p4 x equals: 50.
	self assert: p4 y equals: 25.
]

{ #category : #basic }
RTDowserBuilderTest >> testControlPointWith [
	| e1 e2 e3 e4 p1 p2 p3 p4 |
	e1 := ((RTElement on: 1) + (RTBox new)).
	e2 := ((RTElement on: 2) + (RTBox new)).
	e3 := ((RTElement on: 3) + (RTBox new)).
	e4 := ((RTElement on: 4) + (RTBox new)).
	e2 translateTo: 0@100.
	e3 translateTo: 100@0.
	e4 translateTo: 100@100.
	p1 := builder controlPoint: e1 with: e4. 
	p2 := builder controlPoint: e4 with: e1.
	p3 := builder controlPoint: e2 with: e3.
	p4 := builder controlPoint: e3 with: e2.
	self assert: p1 x equals: 25.
	self assert: p1 y equals: 0.
	self assert: p2 x equals: 75.
	self assert: p2 y equals: 100.
	self assert: p3 x equals: 25.
	self assert: p3 y equals: 100.
	self assert: p4 x equals: 75.
	self assert: p4 y equals: 0.			
]

{ #category : #duoDowser }
RTDowserBuilderTest >> testGreyLines [
	builder label: [ :c | c name asString].
	builder height: #numberOfMethods.
	builder color: #numberOfLinesOfCode.
	builder onLeftAndRight: Number withAllSubclasses.
	builder edgesTo: #allSubclasses.
	
	builder left first announce: TRMouseEnter.
	self assert: builder left first outgoingEdges size equals: 1.
	builder left first announce: TRMouseLeave.
	self assert: builder left first outgoingEdges size equals: 0.
	builder left last announce: TRMouseEnter.
	self assert: builder left last outgoingEdges size equals: 8.
	builder left last announce: TRMouseLeave.
	self assert: builder left last outgoingEdges size equals: 0.
		builder left first announce: TRMouseEnter.
	self assert: builder left first outgoingEdges size equals: 1.
	builder left first announce: TRMouseLeave.
	self assert: builder left first outgoingEdges size equals: 0.
	builder left last announce: TRMouseEnter.
	self assert: builder left last outgoingEdges size equals: 8.
	builder left last announce: TRMouseLeave.
	self assert: builder left last outgoingEdges size equals: 0.	

]

{ #category : #duoDowser }
RTDowserBuilderTest >> testLeft [
	builder left: (1 to: 20).
	
	self assert: builder right size equals: 0. 
	self assert: builder left size equals: (builder models size). 
	self assert: builder left first model equals: 1.
	self assert: builder left last model equals: 20.
]

{ #category : #duoDowser }
RTDowserBuilderTest >> testLeftAndRight [
	builder onLeftAndRight: (1 to: 20).
	
	self assert: builder left size equals: (builder right size). 
	self assert: builder right size equals: (builder models size / 2). 
	self assert: builder right first model equals: (builder left first model).
	self assert: builder right last model equals: (builder left last model).
]

{ #category : #duoDowser }
RTDowserBuilderTest >> testLines1 [
	builder label: [ :c | c name asString].
	builder height: #numberOfMethods.
	builder color: #numberOfLinesOfCode.
	builder onLeftAndRight: Number withAllSubclasses.
	builder edgesTo: #allSubclasses.
	
	builder left first announce: TRMouseEnter.
	self assert: builder left first outgoingEdges size equals: 1.
	builder left first announce: TRMouseClick.
	self assert: builder left first outgoingEdges size equals: 2.
	self assert: (builder popups at: (builder left first) ifAbsent: [nil]) equals: nil. 
	builder left first announce: TRMouseLeave.
	self assert: builder left first outgoingEdges size equals: 1.
	builder left first announce: TRMouseEnter.
	self assert: builder left first outgoingEdges size equals: 2.
	builder left first announce: TRMouseClick.
	self assert: builder left first outgoingEdges size equals: 1.
	self assert: (builder popups at: (builder left first) ifAbsent: [nil]) equals: nil. 
	builder left first announce: TRMouseLeave.
	self assert: builder left first outgoingEdges size equals: 0.
	builder left first announce: TRMouseEnter.
	self assert: builder left first outgoingEdges size equals: 1.
	builder left first announce: TRMouseClick.
	self assert: builder left first outgoingEdges size equals: 2.
	self assert: (builder popups at: (builder left first) ifAbsent: [nil]) equals: nil.
	builder left first announce: TRMouseLeave.
	self assert: builder left first outgoingEdges size equals: 1.
	builder left first announce: TRMouseEnter.
	self assert: builder left first outgoingEdges size equals: 2.
	builder left first announce: TRMouseClick.
	self assert: builder left first outgoingEdges size equals: 1.
	self assert: (builder popups at: (builder left first) ifAbsent: [nil]) equals: nil.
	builder left first announce: TRMouseLeave.
	self assert: builder left first outgoingEdges size equals: 0.
]

{ #category : #duoDowser }
RTDowserBuilderTest >> testLines2 [
	builder label: [ :c | c name asString].
	builder height: #numberOfMethods.
	builder color: #numberOfLinesOfCode.
	builder onLeftAndRight: Number withAllSubclasses.
	builder edgesTo: #allSubclasses.
	
	builder left last announce: TRMouseEnter.
	self assert: builder left last outgoingEdges size equals: 8.
	builder left last announce: TRMouseClick.
	self assert: builder left last outgoingEdges size equals: 16.
	self assert: ((builder popups at: (builder left last) ifAbsent: [nil]) model) equals: 8. 
	builder left last announce: TRMouseLeave.
	self assert: builder left last outgoingEdges size equals: 8.
	builder left last announce: TRMouseEnter.
	self assert: builder left last outgoingEdges size equals: 16.
	builder left last announce: TRMouseClick.
	self assert: builder left last outgoingEdges size equals: 8.
	self assert: ((builder popups at: (builder left last) ifAbsent: [nil]) model) equals: 8. 
	builder left last announce: TRMouseLeave.
	self assert: builder left last outgoingEdges size equals: 0.	
	builder left last announce: TRMouseEnter.
	self assert: builder left last outgoingEdges size equals: 8.
	builder left last announce: TRMouseClick.
	self assert: builder left last outgoingEdges size equals: 16.
	self assert: ((builder popups at: (builder left last) ifAbsent: [nil]) model) equals: 8. 
	builder left last announce: TRMouseLeave.
	self assert: builder left last outgoingEdges size equals: 8.
	builder left last announce: TRMouseEnter.
	self assert: builder left last outgoingEdges size equals: 16.
	builder left last announce: TRMouseClick.
	self assert: builder left last outgoingEdges size equals: 8.
	self assert: ((builder popups at: (builder left last) ifAbsent: [nil]) model) equals: 8.
	builder left last announce: TRMouseLeave.
	self assert: builder left last outgoingEdges size equals: 0.	
]

{ #category : #duoDowser }
RTDowserBuilderTest >> testLines3 [
	builder label: [ :c | c name asString].
	builder height: #numberOfMethods.
	builder color: #numberOfLinesOfCode.
	builder onLeftAndRight: Number withAllSubclasses.
	builder edgesTo: #allSubclasses.
	
	builder right last announce: TRMouseEnter.
	self assert: builder right last outgoingEdges size equals: 0.
	builder right last announce: TRMouseClick.
	self assert: builder right last outgoingEdges size equals: 0.
	self assert: (builder popups at: (builder right last) ifAbsent: [nil]) equals: nil.
	builder right last announce: TRMouseLeave.
	self assert: builder right last outgoingEdges size equals: 0.
	builder right first announce: TRMouseEnter.
	self assert: builder right last outgoingEdges size equals: 0.
	builder right last announce: TRMouseClick.
	self assert: builder right last outgoingEdges size equals: 0.
	self assert: (builder popups at: (builder right last) ifAbsent: [nil]) equals: nil.
	builder right first announce: TRMouseLeave.
	self assert: builder right last outgoingEdges size equals: 0.	
	builder right last announce: TRMouseEnter.
	self assert: builder right last outgoingEdges size equals: 0.
	builder right last announce: TRMouseClick.
	self assert: builder right last outgoingEdges size equals: 0.
	self assert: (builder popups at: (builder right last) ifAbsent: [nil]) equals: nil. 
	builder right last announce: TRMouseLeave.
	self assert: builder right last outgoingEdges size equals: 0.
	builder right last announce: TRMouseEnter.
	self assert: builder right last outgoingEdges size equals: 0.
	builder right last announce: TRMouseClick.
	self assert: builder right last outgoingEdges size equals: 0.
	self assert: (builder popups at: (builder right last) ifAbsent: [nil]) equals: nil.
	builder right last announce: TRMouseLeave.
	self assert: builder right last outgoingEdges size equals: 0.	
]

{ #category : #duoDowser }
RTDowserBuilderTest >> testRight [
	builder onLeftAndRight: (1 to: 20).
	
	self assert: builder left size equals: (builder right size). 
	self assert: builder right size equals: (builder models size / 2). 
	self assert: builder right first model equals: (builder left first model).
	self assert: builder right last model equals: (builder left last model).
]

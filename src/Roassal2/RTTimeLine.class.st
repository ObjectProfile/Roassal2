"
Define a time line, a bit like a Gantt diagram.

Here is an example:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	| b d |
	b := RTTimeLine new.
	b addEntry: (RTTimeLineEntry new identifier: #c1; start: 0; end: 5).
	b addEntry: (RTTimeLineEntry new identifier: #c1; start: 6; end: 8).

	b addEntry: (RTTimeLineEntry new identifier: #c2; start: 0; end: 5).
	b addEntry: (RTTimeLineEntry new identifier: #c2; start: 8; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c3; start: 0; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c4; start: 5; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c5; start: 5; end: 8).

	d := RTVerticalTickLineDecorator new.
	d shape line color: Color white.
	b addDecorator: d.
	b axisX 
		numberOfLabels: 5;
		labelRotation: -45;
		labelConversion: [ :v | Date year: 2015 day: v ]. 

	b shape color: (RTMultiLinearColorForIdentity new command: #identifier; objects: #(c1 c2 c3 c4 c5)).
	b  open
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RTTimeLine,
	#superclass : #RTAbstractGrapher,
	#instVars : [
		'entries',
		'maxWidth',
		'timeLineLabel',
		'timeLineElements',
		'smalestEntryWidth'
	],
	#category : #'Roassal2-Builder-TimeLine'
}

{ #category : #adding }
RTTimeLine >> addEntry: anEntry [
	entries add: anEntry
]

{ #category : #hooks }
RTTimeLine >> createShapeBuilder [
	^ super createShapeBuilder
		rectangle;
		height: [ :obj | self extent y / self numberOfTimeLines - self gapBetweenTimeLines ];
		color: (Color blue alpha: 0.4);
		yourself
]

{ #category : #accessing }
RTTimeLine >> entries [
	"return a list of entries"
	^ entries copy
]

{ #category : #examples }
RTTimeLine >> example01 [
	"
	self new example01
	"
	
	| b |
	b := RTTimeLine new.
	b addEntry: (RTTimeLineEntry new identifier: #c1; start: 0; end: 5).
	b addEntry: (RTTimeLineEntry new identifier: #c2; start: 0; end: 5).
	b addEntry: (RTTimeLineEntry new identifier: #c1; start: 6; end: 8).
	b addEntry: (RTTimeLineEntry new identifier: #c2; start: 8; end: 10).
	^ b
]

{ #category : #examples }
RTTimeLine >> example02 [
	"
	self new example02
	"	
	| b |
	b := RTTimeLine new.
	b addEntry: (RTTimeLineEntry new identifier: #c1; start: 0; end: 5).
	b addEntry: (RTTimeLineEntry new identifier: #c1; start: 6; end: 8).

	b addEntry: (RTTimeLineEntry new identifier: #c2; start: 0; end: 5).
	b addEntry: (RTTimeLineEntry new identifier: #c2; start: 8; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c3; start: 0; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c4; start: 5; end: 10).

	b addEntry: (RTTimeLineEntry new identifier: #c5; start: 5; end: 8).

	b addDecorator: RTVerticalTickLineDecorator new.
	b axisX numberOfLabels: 5.
	^ b
]

{ #category : #configuration }
RTTimeLine >> gapBetweenTimeLines [
	^ 3
]

{ #category : #'min and max' }
RTTimeLine >> homogenizeMinAndMax [
	self getAxisX minValue: self minX.
	self getAxisX maxValue: self maxX.
	
	self getAxisY minValue: self minY.
	self getAxisY maxValue: self maxY.
]

{ #category : #initialization }
RTTimeLine >> initialize [
	super initialize.
	entries := OrderedCollection new.
	self axisY noTick; noLabel.
	self timeLineLabel: #asString.
	self smalestEntryWidth: 1.
]

{ #category : #utility }
RTTimeLine >> label: aString on: position [
	"Add a label in the view"
	| e |
	e := RTLabel elementOn: aString.
	e translateTo: position.
	self view add: e.
	^ e
]

{ #category : #'accessing-computed' }
RTTimeLine >> maxEnd [
	^ entries max: #end
]

{ #category : #accessing }
RTTimeLine >> numberOfEntries [
	^ entries size
]

{ #category : #'accessing-computed' }
RTTimeLine >> numberOfTimeLines [
	"Return the number of time lines contained in myself"
	^ self timeLines size
]

{ #category : #hooks }
RTTimeLine >> renderIn: aView [
	| groupEntries elements t |
	self maxX: self maxEnd.
	self maxY: self numberOfTimeLines.
	self defineAxesIfNecessary.
	timeLineElements := OrderedCollection new.
	self timeLinesIdentifiers doWithIndex: [ :identifier :index | 	
			groupEntries := (self timeLines at: identifier) value.
			elements := self elementsOn: groupEntries.
			RTMetricNormalizer new
				elements: elements;
				normalizeWidth: #duration
					min: self smalestEntryWidth
					max: self extent x
					minValue: 0
					maxValue: self maxEnd.
			t := RTDirectLayoutTranslator new.
			elements do: [ :e | t translateTopLeftOf: e to: (e model start / self maxEnd * self extent x) asFloat @ 0 ].
			timeLineElements add: elements.
			view addAll: elements ].
	timeLineElements doWithIndex: [ :g :index | g translateBy: (self getPixelPositionOf: 0 @ index) ].	
	self homogenizeMinAndMax.
	self renderAxis.
	self renderAllDecoratorsBehind.
	self renderAllDecoratorsInFront.
	self renderTimeLineLabels
]

{ #category : #TOCLEAN }
RTTimeLine >> renderInOLD: aView [

	| groups maxEnd allGroups key groupEntries shape elements maxMiddlePeriod   t |
	groups := entries groupedBy: #identifier.
	maxEnd := entries max: #end.
	maxMiddlePeriod := entries max: #middlePeriod.

	allGroups := OrderedCollection new. 
	
	groups associationsDo: [ :assoc |
		key := assoc key.
		groupEntries := assoc value.
		
		shape := RTBox new 
					height: 10; 
					width: #duration "[ :anEntry | (anEntry duration / maxEnd * self extent x) asFloat ]";
					color: (Color red alpha: 0.4).
					
		elements := shape elementsOn: groupEntries.
		RTMetricNormalizer new
			elements: elements;
			"normalizeX: #middlePeriod min: 0 max: self extent  minValue: 0 maxValue: maxMiddlePeriod;"
			normalizeWidth: #duration min: 0 max: self extent  minValue: 0 maxValue: maxEnd.

		t := RTDirectLayoutTranslator new.
		elements do: [ :e | t translateTopLeftOf: e to: ((e model start / maxEnd * self extent x) asFloat  @ 0) ].


		elements := elements, (Array with: RTBox element with: (RTBox element translateTo: self extent  @ 0)).
		elements := elements asGroup.

		allGroups add: elements.
		view addAll: elements.
		elements @ RTPopup.
		 ].
	
"	allX := allGroups collect: [ :g | g position x ].
	RTVerticalLineLayout on: allGroups.
	allGroups with: allX do: [ :g :anX | g translateBy: anX @ 0 ]"
	allGroups doWithIndex: [ :g :index | g translateBy: 0 @ (index * 20) ]
]

{ #category : #TOCLEAN }
RTTimeLine >> renderInTOFIX: aView [

	| groups maxEnd allGroups key groupEntries shape elements     maxStart |
	groups := entries groupedBy: #identifier.
	maxEnd := entries max: #end.
	maxStart := entries max: #start.
	
	allGroups := OrderedCollection new. 
	
	groups associationsDo: [ :assoc |
		key := assoc key.
		groupEntries := assoc value.
		
		shape := RTBox new 
					height: 10; 
					color: (Color red alpha: 0.4).
					
		elements := shape elementsOn: groupEntries.
		RTMetricNormalizer new
			elements: elements;
			normalizeTopLeftOfX: #start min: 0 max: maxWidth minValue: 0 maxValue: maxStart;
			normalizeWidth: #duration min: 0 max: maxWidth minValue: 0 maxValue: maxEnd.

		allGroups add: elements.
		view addAll: elements.
		elements @ RTPopup.
		 ].

	allGroups doWithIndex: [ :g :index | g translateBy: 0 @ (index * 20) ]
]

{ #category : #utility }
RTTimeLine >> renderTimeLineLabels [
	
	| identifiers position offset verticalOffset |
	identifiers := self timeLinesIdentifiers.
	identifiers removeDuplicates.
	
	offset := -30 @ 0.

	identifiers doWithIndex: [ :anIdentifier :index |
		position := self getPixelPositionOf: 0 @ index.
		verticalOffset := 0 @ (((timeLineElements at: index) max: #height) / 2).
		self label: (timeLineLabel rtValue: anIdentifier) asString on: position + offset + verticalOffset ]
		
]

{ #category : #accessing }
RTTimeLine >> smalestEntryWidth [
	^ smalestEntryWidth
]

{ #category : #accessing }
RTTimeLine >> smalestEntryWidth: anInteger [ 
	smalestEntryWidth := anInteger
]

{ #category : #accessing }
RTTimeLine >> timeLineLabel: aSymbolOrABlock [
	"If a symbol, it is executed against the time line entry. If it is a block, the time line entry is provided as argument"

	timeLineLabel := aSymbolOrABlock
]

{ #category : #'accessing-computed' }
RTTimeLine >> timeLines [
	^ entries groupedBy: #identifier
]

{ #category : #'accessing-computed' }
RTTimeLine >> timeLinesIdentifiers [
	"Return the list of identifiers of the entries. The order of the result reflect the order of the addition in the builder."
	| t |
	t := entries collect: #identifier.
	t removeDuplicates.
	^ t
	
]

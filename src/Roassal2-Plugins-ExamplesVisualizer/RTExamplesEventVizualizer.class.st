"
I am a visualizer for the event recorder of roassal

Try to donwload the files 500megas from
 gc.dcc.uchile.cl

Then unzip the file and copy the files from roassal
"
Class {
	#name : #RTExamplesEventVizualizer,
	#superclass : #RTObject,
	#instVars : [
		'users',
		'images',
		'dates',
		'examples',
		'examplesByClass',
		'colorByClass',
		'allExamples'
	],
	#category : #'Roassal2-Plugins-ExamplesVisualizer'
}

{ #category : #processing }
RTExamplesEventVizualizer >> processEvents: events [
	| data list date count |
	data := events key.
	users := (data groupedBy: #computerUUID) size.
	images := (data groupedBy: #imageVersion) keys.
	dates := Dictionary new.
	colorByClass := Dictionary new.
	examples := (data flatCollect: #safeUnpackedData) groupedBy: [ :a | a theClass-> a theSelector ].
	examples keys do: [ :a| colorByClass at: a key ifAbsentPut: [ Color random ] ].
	examplesByClass := examples keys sortedAs: [ :a :b | 
		a key = b key 
			ifTrue: [ (examples at: a) size < (examples at: b) size ] 
			ifFalse: [ a key < b key ] ].
	allExamples := examples keys sortedAs: [ :a :b | (examples at: a) size < (examples at: b) size ].
	data do: [ :evt | 
		list := evt safeUnpackedData.
		date := evt timestamp asDate.
		count := dates at: date ifAbsentPut: [ 0 ].
		dates at: date put: count + list size. ].
	
]

{ #category : #visualization }
RTExamplesEventVizualizer >> visualize [
	| b c b2 ds lb |
	c := RTComposer new.
	c gap: 35.
	"----------------"
	b := RTCalendarBuilder new.
	b view: c view.
	b showDayNames.
	
	b dateShape box size: 15;
		if: [ :d | (dates includesKey: d) and: [ (dates at: d) < 10 ] ] color: Color green;
		if: [ :d | (dates includesKey: d) and: [ (dates at: d) > 10 and: [ (dates at: d) < 30 ] ] ] color: Color blue;
		if: [ :d | (dates includesKey: d) and: [ (dates at: d) > 30 and: [ (dates at: d) < 50 ] ] ] color: Color orange;
		if: [ :d | (dates includesKey: d) and: [ (dates at: d) > 50 ] ] color: Color red.
	b dateInteraction popup text: [ :d | d asString, '
Examples: ', (dates at: d ifAbsent: [ 0 ]) asString ].
	b yearShape composite: [ :comp | 
		comp add: (RTLabel new text: [ :d | d year ]; height: 20 ).
		comp add: (RTBox new color: Color transparent). ] .
	b dates: (dates keys min asYear to: dates keys max asYear).
	b yearLayout horizontalLine.
	b build.
	c group: #dates.
	
	"---------------"
	b2 := RTGrapher new.
	b2 view: c view.
	b2 extent: 2500@300.
	
	ds := RTData new.
	ds interaction popup text: [:a | a key, '>>', a value, '
Views: ', (examples at: a) size asString ].
	ds points: examplesByClass.
	ds y: [:a| (examples at: a) size ].
	ds x: [ :a | examplesByClass indexOf: a ].
	ds barShape rectangle color: [:a | colorByClass at: a key].
	b2 add: ds.
	b2 build.
	c group: #examplesByClass.
	
	"------------------"
	b2 := RTGrapher new.
	b2 view: c view.
	b2 extent: 2500@300.
	
	ds := RTData new.
	ds interaction popup text: [:a | a key, '>>', a value, '
Views: ', (examples at: a) size asString ].
	ds points: allExamples.
	ds y: [:a| (examples at: a) size ].
	ds x: [ :a | allExamples indexOf: a ].
	ds barShape rectangle color: [:a | colorByClass at: a key].
	b2 add: ds.
	b2 build.
	c group: #allExamples.
	"------------------"
	
	c move: #examplesByClass below: #dates.
	c move: #allExamples below: #examplesByClass.
	
	c nameGroup: #dates as: 'Calendar when a example was used'.
	c nameGroup: #examplesByClass as: 'Examples sorted by class'.
	c nameGroup: #allExamples as: 'Examples sorted uses'.
	
	lb := RTLegendBuilder new.
	lb view: c view.
	lb addText: 'Number of computers:', users asString.
	lb addText: 'Number of examples: ', examples size asString.
	lb addText: 'Number of classes: ', colorByClass size asString.
	lb addColor: Color green text: 'x < 10'.
	lb addColor: Color blue text: '10 < x < 30'.
	lb addColor: Color orange text: '30 < x < 50'.
	lb addColor: Color red text: 'x > 50'.
	lb build.
	
	b view @ RTZoomableView.
	b view inspect
]

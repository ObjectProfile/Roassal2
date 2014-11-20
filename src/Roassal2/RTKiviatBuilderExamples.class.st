Class {
	#name : #RTKiviatBuilderExamples,
	#superclass : #RTObject,
	#category : #'Roassal2-Builder-Kiviat'
}

{ #category : #'as yet unclassified' }
RTKiviatBuilderExamples >> coloredPolygonsExample1 [
	| b n |
	b := RTKiviatBuilder new.
	b objects: RTAbstractCircleLayout withAllSubclasses.
	n := RTMultiLinearColorForIdentity new objects: (b objects).
	b shape circle color: [ :value | n rtValue: value named]; size: 10.

	b addMetric: #numberOfLinesOfCode.
	b addMetric: #numberOfMethods.
	b addMetric: #numberOfVariables.
	
	b activatePolygons.

	b build.
	b view open
]

{ #category : #'as yet unclassified' }
RTKiviatBuilderExamples >> colorsExample1 [
	| b n |
	b := RTKiviatBuilder new.
	b objects: RTAbstractCircleLayout withAllSubclasses.
	
	n := RTMultiLinearColorForIdentity new objects: (b objects).
	b shape circle color: [ :value | n rtValue: value named]; size: 10.

	b addMetric: #numberOfLinesOfCode.
	b addMetric: #numberOfMethods.
	b addMetric: #numberOfVariables.
	b build.
	b view open
]

{ #category : #'as yet unclassified' }
RTKiviatBuilderExamples >> colorsExample2 [
	| b |
	b := RTKiviatBuilder new.
	"shapes: takes in argument a collection of colors, at least of the size of the numbers of objects"
	b shapes: ((ColorPalette qualitative colors: 12 scheme:'Paired') do: [:c | c alpha: 0.3]).
	b objects: RTAbstractCircleLayout withAllSubclasses.
	b addMetric: #numberOfLinesOfCode.
	b addMetric: #numberOfMethods.
	b addMetric: #numberOfVariables.
	b build.
	b view open
	
]

{ #category : #'as yet unclassified' }
RTKiviatBuilderExamples >> colorsExample3 [
	| b myKiviatNodesElems m col |
	b := RTKiviatBuilder new.
	b objects: RTAbstractCircleLayout withAllSubclasses.
	b addMetric: #numberOfLinesOfCode.
	b addMetric: #numberOfMethods.
	b addMetric: #numberOfVariables.
	b build.
	myKiviatNodesElems := (b view elements select: [ :e | (e model isKindOf: RTKiviatElement)]).
	b objects do: [:o | m:= myKiviatNodesElems select: [ :e | (e model named name= o name)]. col := 	(Color random alpha: 0.6). m do: [:e | e color: col]].
	myKiviatNodesElems do: [  :e | e @ RTDraggable].

	b view open
	
]

{ #category : #'as yet unclassified' }
RTKiviatBuilderExamples >> initialize [
	super initialize
]

{ #category : #'as yet unclassified' }
RTKiviatBuilderExamples >> simpleExample [
	| b |
	b := RTKiviatBuilder new.
	b objects: RTAbstractCircleLayout withAllSubclasses.
	b addMetric: #numberOfLinesOfCode.
	b addMetric: #numberOfMethods.
	b addMetric: #numberOfVariables.
	b build.
	b view open
	
]

{ #category : #'as yet unclassified' }
RTKiviatBuilderExamples >> simpleExample2 [
	| b |
	b := RTKiviatBuilder new.
	b objects: #('ABCDEF' ' 123' '      1').
	b addMetric: #size.
	b addMetric: [ :str | (str select: #isAlphaNumeric) size ].
	b addMetric: [ :str | (str select: [ :c | c = $ ]) size ].
	b build.
	b view open
	
]

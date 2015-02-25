"
RTComposerExample new installTitle: 'ClassAnalysis' 
		code:
		'
| classesToAnalyze c b b2 b3 b4 es |
classesToAnalyze := TRShape withAllSubclasses.

c := RTComposer new.
c gap: 35.
""-------""
b := RTGraphBuilder new.
b view: c view.
b nodes 
	if: [ :cls | cls numberOfMethods > 10 ];
	color: Color red.
b edges connectFrom: #superclass; useInLayout.
b nodes color: Color gray.
b global normalizeSize: #numberOfLinesOfCode min: 5 max: 15 using: #sqrt.
b layout tree.
b addAll: classesToAnalyze.
b build.
c propagateHighlight.
c group: #hierarchy.

""-------""
b2 := RTCharterBuilder new.
b2 view: c view.
b2 extent: 200 @ 150.
b2 interaction popup.
b2 shape rectangle size: 0.
b2 points: classesToAnalyze.

b2 allY: [ :cls | cls methods size ].
b2 shape rectangle color: Color lightBlue.
b2 stackX.
b2 histogramBarWidth: 5.

b2 axisX; axisYWithNumberOfTicks: 4.
b2 build.

c propagateHighlight.
c group: #stat.
""-------""

b3 := RTPieBuilder new.
b3 view: c view.
b3 interaction popup.
b3 objects: classesToAnalyze.
es := b3 slice: #numberOfLinesOfCode.
b3 globalRule 
		elements: es;
		distinctColor.
b3 build.
c propagateHighlight.
c group: #pie.

""-------""
b4 := RTCharterBuilder new.
b4 view: c view.
b4 extent: 290 @ 200.
b4 interaction popup.
b4 shape ellipse size: 15; color: (Color red alpha: 0.3).
b4 points: classesToAnalyze.
b4 x: #numberOfMethods; y: #numberOfVariables min: 0 max: 10.
b4 size: #numberOfLinesOfCode min: 4 max: 20 using: #sqrt.
	
b4 axisXWithNumberOfTicks: 3.
b4 axisYWithNumberOfTicks: 4.
b4 highlightIf: [ :cls | (cls numberOfLinesOfCode > 2000) or: [ cls numberOfVariables > 10 ] ] using: #name.
c propagateHighlight.
c group: #plot.

""-------""
c move: #hierarchy onTheLeftOf: #pie.
c move: #stat below: #hierarchy.
c move: #plot below: #stat.

c nameGroup: #hierarchy as: ''class hierarchy''.
c nameGroup: #stat as: ''#methods''.
""c nameGroup: #pie as: ''#LOC''.""
c nameGroup: #plot as: ''NOM x NOA x LOC''.
c open.
c view canvas'
	
"
Class {
	#name : #RTComposerExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Composer'
}

{ #category : #sources }
RTComposerExample >> exampleClassAnalysis [

| classesToAnalyze c b b2 b3 b4 es ds |
classesToAnalyze := TRShape withAllSubclasses.

c := RTComposer new.
c gap: 35.
"-------"
b := RTGraphBuilder new.
b view: c view.
b nodes 
	if: [ :cls | cls numberOfMethods > 10 ];
	color: Color red.
b edges connectFrom: #superclass; useInLayout.
b nodes color: Color gray.
b global normalizeSize: #numberOfLinesOfCode min: 5 max: 15 using: #sqrt.
b layout tree.
b addAll: classesToAnalyze.
b build.
c propagateHighlight.
c group: #hierarchy.

"-------"
b2 := RTGrapher new.
b2 view: c view.
b2 extent: 200 @ 150.

ds := RTStackedDataSet new.
ds interaction popup.
ds points: classesToAnalyze.
ds y: [ :cls | cls rtmethods size ].
ds barShape rectangle color: Color lightBlue.
"b2 histogramBarWidth: 5."
b2 add: ds.

b2 axisX; axisYWithNumberOfTicks: 4.
b2 build.

c propagateHighlight.
c group: #stat.
"-------"

b3 := RTPieBuilder new.
b3 view: c view.
b3 interaction popup.
b3 objects: classesToAnalyze.
es := b3 slice: #numberOfLinesOfCode.
b3 globalRule 
		elements: es;
		distinctColor.
b3 build.
c propagateHighlight.
c group: #pie.

"-------"
b4 := RTGrapher new.

b4 extent: 290 @ 200.
ds := RTDataSet new.
ds interaction popup.
ds dotShape ellipse size: 15; color: (Color red alpha: 0.3).
ds points: classesToAnalyze.
ds x: #numberOfMethods.
ds y: #numberOfVariables" min: 0 max: 10".
ds dotSize: #numberOfLinesOfCode min: 4 max: 20 using: #sqrt.
ds highlightIf: [ :cls | (cls numberOfLinesOfCode > 2000) or: [ cls numberOfVariables > 10 ] ] using: #name.
b4 add: ds.

"b4 axisXWithNumberOfTicks: 3.
b4 axisYWithNumberOfTicks: 4."
c propagateHighlight.
c group: #plot.

"-------"
c move: #hierarchy onTheLeftOf: #pie.
c move: #stat below: #hierarchy.
c move: #plot below: #stat.

c nameGroup: #hierarchy as: 'class hierarchy'.
c nameGroup: #stat as: '#methods'.
"c nameGroup: #pie as: '#LOC'."
c nameGroup: #plot as: 'NOM x NOA x LOC'.

^ c view
]

{ #category : #sources }
RTComposerExample >> exampleClassAnalysis2 [

| classesToAnalyze c b b2 b3 b4 es ds |
classesToAnalyze := RTShape withAllSubclasses.

c := RTComposer new.
c gap: 35.
"-------"
b := RTGraphBuilder new.
b view: c view.
b nodes 
	if: [ :cls | cls numberOfMethods > 10 ];
	color: Color red.
b edges connectFrom: #superclass; useInLayout.
b nodes color: Color gray.
b global normalizeSize: #numberOfLinesOfCode min: 5 max: 15 using: #sqrt.
b layout tree.
b addAll: classesToAnalyze.
b build.
c propagateHighlight.
c group: #hierarchy.

"-------"
b2 := RTGrapher new.
b2 view: c view.
b2 extent: 200 @ 150.

ds := RTStackedDataSet new.
ds interaction popup.
ds points: classesToAnalyze.
ds y: [ :cls | cls rtmethods size ].
ds barShape rectangle color: Color lightBlue.
b2 add: ds.
"b2 axisX; axisYWithNumberOfTicks: 4.
"
b2 build.

c propagateHighlight.
c group: #stat.
"-------"

b3 := RTPieBuilder new.
b3 view: c view.
b3 interaction popup.
b3 objects: classesToAnalyze.
es := b3 slice: #numberOfLinesOfCode.
b3 globalRule 
		elements: es;
		distinctColor.
b3 build.
c propagateHighlight.
c group: #pie.

"-------"
b4 := RTGrapher new.
b4 view: c view.
b4 extent: 290 @ 200.

ds := RTDataSet new.
ds interaction popup.
ds dotShape ellipse size: 15; color: (Color red alpha: 0.3).
ds points: classesToAnalyze.
ds x: #numberOfMethods; y: #numberOfVariables "min: 0 max: 10".
ds dotSize: #numberOfLinesOfCode min: 4 max: 20 using: #sqrt.
ds highlightIf: [ :cls | (cls numberOfLinesOfCode > 2000) or: [ cls numberOfVariables > 10 ] ] using: #name.
b4 add: ds.

"b4 axisXWithNumberOfTicks: 3.
b4 axisYWithNumberOfTicks: 4.
"
b4 build.
c propagateHighlight.
c group: #plot.

"-------"
c move: #hierarchy onTheLeftOf: #pie.
c move: #stat below: #hierarchy.
c move: #plot below: #stat.

c nameGroup: #hierarchy as: 'class hierarchy'.
c nameGroup: #stat as: '#methods'.
"c nameGroup: #pie as: '#LOC'."
c nameGroup: #plot as: 'NOM x NOA x LOC'.
^ c view
]

{ #category : #icons }
RTComposerExample >> exampleClassAnalysis2Icon [
	^ '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
jIgUtaLIAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTComposerExample >> exampleClassAnalysis3 [

| c b c2 ds |
c := RTComposer new.

"======"
b := RTGraphBuilder new.
	b view: c view.
b edges
	connectFrom: #superclass;
	useInLayout.

b edges
	if: [ :fromClass :toClass | toClass name beginsWith: 'TR' ];
	follow: #superclass;
	connectTo: #dependentClasses;
	color: (Color blue alpha: 0.3).
	

b nodes 
	if: [ :cls | cls name beginsWith: 'RT' ];
	color: Color blue.
b nodes 
	color: Color red.
b layout cluster.

b global 
	normalizeSize: #numberOfMethods min: 5 max: 40 using: #sqrt;
	alphaColor: 0.4.

b addAll: TRShape withAllSubclasses, RTShape withAllSubclasses.

b build.
c group.

"======"
c2 := RTGrapher new.
c2 view: c view.
c2 extent: 300 @ 200.

ds := RTStackedDataSet new.
ds interaction popup. 
ds points: (RTShape withAllSubclasses sortedAs: #numberOfMethods).
ds connectColor: Color blue.
ds y: #numberOfMethods.
c2 add: ds.

ds := RTStackedDataSet new.
ds interaction popup. 
ds points: (TRShape withAllSubclasses sortedAs: #numberOfMethods).
ds y: #numberOfMethods.
ds connectColor: Color red.
c2 add: ds.

c2 build.
c group.
"======"

c layout: RTVerticalLineLayout new.
c propagateHighlightToAll.
"======"
^ c view
]

{ #category : #icons }
RTComposerExample >> exampleClassAnalysis3Icon [
	^ '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
hgAAAABJRU5ErkJggg=='
]

{ #category : #icons }
RTComposerExample >> exampleClassAnalysisIcon [
	^ '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'
]

{ #category : #sources }
RTComposerExample >> exampleWorldPopulation [

	
	composer := RTComposer new.
	v := composer view.
	
	"========"
	b := RTMapBuilder new.	
	b view: v.		
		
	countries := RTMapBuilder countriesPopulation select: [ :c | RTSVGPath countries includes: (c at: 1) ].
	
	cn := RTNColorLinearNormalizer
		inContext: (countries collect: [:c | c at: 2])
		lowColor: (Color r:0.8 g:0.8 b:1)
		highColor: (Color r:0 g:0 b:0.3).
	
	b countries: countries named: [ :c | c at: 1 ].
	b color: [ :dic | cn rtValue: (dic at: 2) ].
	b withPopup: [ :c | (c at: 1) asString, ': ',(((c at: 2) / 1000000 asFloat round: 3) asString, ' Million') ].
	b build.
	composer group: #worldMap.

	"========"
	grapher := RTGrapher new.
	grapher extent: 600 @ 300.
	grapher view: v.
	ds := RTStackedDataSet new.
	ds barShape width: 5; color: Color blue.
	ds points: ((countries reverseSortedAs: #second) copyFrom: 1 to: 50).
	ds y: #second.
	ds interaction popupText.
	grapher add: ds.
	grapher axisX noLabel; noTick; title: 'countries'.
	grapher axisY noDecimal; labelConvertion: [ :aValue | (aValue / 1000000) round: 2]; title: 'Millions'.
	grapher build.
	composer group: #graph.
	
	"========"
	composer move: #graph above: #worldMap.
	
	composer nameGroup: #worldMap as: 'Human distribution across the globe'.
	composer nameGroup: #graph as: 'Chart'.
	v
]

{ #category : #icons }
RTComposerExample >> exampleWorldPopulationIcon [
	^ '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
RU5ErkJggg=='
]

{ #category : #accessing }
RTComposerExample >> label [
	^ 'Composition of Builders'
]

"
A RTHTMLExporterExample is the example class for RTHTMLExporter
"
Class {
	#name : #RTHTMLExporterExample,
	#superclass : #RTObject,
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #example }
RTHTMLExporterExample >> exampleDependencyAnalyzerBuilder [
	

	| b exporter |	
	b := RTDependencyAnalyzerBuilder new. 
	b shape circle
				size: [ :cls | cls numberOfMethods max: 5 ];
				fillColor: (Color red alpha: 0.3);
				if: [ :cls | ('TR*' match: cls name)  ] fillColor: (Color purple alpha: 0.3).
	b addClasses: RTObject withAllSubclasses.
	b addClasses: TRObject withAllSubclasses.
	b 
		dependencyFromAllClassesMatching: [ :cls | ('RT*' match: cls name) ] 
		toAllClassesMatching: [ :cls | ('TR*' match: cls name) ].

	b open.
	
	"This line does the export"
	exporter := RTHTMLExporter new 
							backgroundColor: Color white;
							builder: b filename: 'Dependencies' title: 'Dependencies between Roassal2 and Trachel'; yourself.
	exporter code: thisContext method sourceCode.
	RTSVGHightlight on: exporter color: Color blue targets: TREllipseShape.
	RTSVGDragAndDrop on: exporter targets: TREllipseShape.
	RTSVGTextPopup on: exporter text:#name color: Color black size: 15 targets: TREllipseShape.
	exporter exportToFile.  
	
]

{ #category : #example }
RTHTMLExporterExample >> exampleWithHightlight [
	
	"self new exampleWithHightlight"

	| b exporter |	
	b := RTDependencyAnalyzerBuilder new. 
	b shape circle
				size: [ :cls | cls numberOfMethods max: 5 ];
				fillColor: (Color red alpha: 0.3);
				if: [ :cls | ('TR*' match: cls name)  ] fillColor: (Color purple alpha: 0.3).
	b addClasses: RTObject withAllSubclasses.
	b addClasses: TRObject withAllSubclasses.
	b 
		dependencyFromAllClassesMatching: [ :cls | ('RT*' match: cls name) ] 
		toAllClassesMatching: [ :cls | ('TR*' match: cls name) ].

	b open.
	"exporter part"
	exporter := RTHTMLExporter new builder: b filename: 'dependecy' title: 'Roassal and Trachel'; yourself.
	RTSVGHightlight on: exporter color: Color green targets: TREllipseShape.
	exporter exportToFile.  
]

{ #category : #example }
RTHTMLExporterExample >> exampleWithMetricMap [
	
	"self new exampleWithMetricMap"

| b table exporter |
b := RTMetricMap new.
table := RTTabTable new.
table input: 'Hong Kong, China	1	0.631447
Singapore	2	0.5889286
Netherlands	3	0.515425
Switzerland	4	0.5018929
United States	5	0.4871152
Norway	6	0.4851121
Denmark	7	0.4665922
Sweden	8	0.4567912
Finland	9	0.4460537
Korea, Rep.	10	0.4382369
Ireland	11	0.4324097
Luxembourg	12	0.4227912
Germany	13	0.4190357
Belgium	14	0.4022478
Canada	15	0.3983661
Australia	16	0.3982408
United Kingdom	17	0.3930691
Japan	18	0.3904902
Spain	19	0.3876414
Kuwait	20	0.3800776
France	21	0.377015
Brunei Darussalam	22	0.3627484
Austria	23	0.3621858
Israel	24	0.3585244
China	25	0.3560882' usingDelimiters: String tab.
table convertColumn: 3 to: [ :t | Float readFrom: t ].

b allCountriesColor: Color white.
b countries: table values named: #first metric: #third.

b open.
	exporter := RTHTMLExporter new builder: b filename: 'test' title: 'test'; yourself.
	RTSVGHightlight on: exporter color: Color red targets: TRSVGPath.
	RTSVGTextPopup on: exporter text:#first color: Color white size: 15 targets: TRSVGPath.
	exporter exportToFile.  
 
]

{ #category : #example }
RTHTMLExporterExample >> exampleWithPopup [

	"self new exampleWithPopup"
	
	| b countries cn exporter|	
	b := RTMapBuilder new.	
		
	countries := RTMapBuilder countriesPopulation select: [ :c | RTSVGPath countries includes: (c at: 1) ].
	
	cn := RTNColorLinearNormalizer
		inContext: (countries collect: [:c | c at: 2])
		lowColor: (Color r:0.8 g:0.8 b:1)
		highColor: (Color r:0 g:0 b:0.3).
	
	b countries: countries named: [ :c | c at: 1 ].
	b color: [ :dic | cn rtValue: (dic at: 2) ].
	b withPopup: [ :c | (c at: 1) asString, ': ',(((c at: 2) / 1000000 asFloat roundTo: 0.001) asString, ' Million') ].
	b open.
	"exporter part"
	exporter := RTHTMLExporter new builder: b filename: 'WorldPopulation' title: 'World Population'; yourself.
	RTSVGTextPopup on: exporter text:#first targets: TRSVGPath.
	exporter exportToFile.  
]

{ #category : #example }
RTHTMLExporterExample >> exampleWithPopupAndHighlight [

	"self new exampleWithPopupAndHighlight"
	
	| b countries cn exporter|	
	b := RTMapBuilder new.	
		
	countries := RTMapBuilder countriesPopulation select: [ :c | RTSVGPath countries includes: (c at: 1) ].
	
	cn := RTNColorLinearNormalizer
		inContext: (countries collect: [:c | c at: 2])
		lowColor: (Color r:0.8 g:0.8 b:1)
		highColor: (Color r:0 g:0 b:0.3).
	
	b countries: countries named: [ :c | c at: 1 ].
	b color: [ :dic | cn rtValue: (dic at: 2) ].
	b withPopup: [ :c | (c at: 1) asString, ': ',(((c at: 2) / 1000000 asFloat roundTo: 0.001) asString, ' Million') ].
	b open.
	"exporter part"
	exporter := RTHTMLExporter new builder: b filename: 'WorldPopulation' title: 'World Population'; yourself.
	RTSVGHightlight on: exporter color: Color red targets: TRSVGPath.
	RTSVGTextPopup on: exporter text:#first color: Color white size: 15 targets: TRSVGPath.
	exporter exportToFile.  
]

{ #category : #example }
RTHTMLExporterExample >> exampleWithPopupAndHighlightAndLink [

	"self new exampleWithPopupAndHighlightAndLink"
	
	| b countries cn exporter|	
	b := RTMapBuilder new.	
		
	countries := RTMapBuilder countriesPopulation select: [ :c | RTSVGPath countries includes: (c at: 1) ].
	
	cn := RTNColorLinearNormalizer
		inContext: (countries collect: [:c | c at: 2])
		lowColor: (Color r:0.8 g:0.8 b:1)
		highColor: (Color r:0 g:0 b:0.3).
	
	b countries: countries named: [ :c | c at: 1 ].
	b color: [ :dic | cn rtValue: (dic at: 2) ].
	b withPopup: [ :c | (c at: 1) asString, ': ',(((c at: 2) / 1000000 asFloat roundTo: 0.001) asString, ' Million') ].
	b open.
	"exporter part"
	exporter := RTHTMLExporter new builder: b filename: 'WorldPopulation' title: 'World Population'; yourself.
	exporter code: thisContext method sourceCode.
	RTSVGHightlight on: exporter color: Color red targets: TRSVGPath.
	RTSVGTextPopup on: exporter text:#first color: Color purple size: 15 targets: TRSVGPath.
	RTSVGLink on: exporter link:[:l | 'http://en.wikipedia.org/wiki/', l first] targets: TRSVGPath.
	exporter exportToFile.  
]

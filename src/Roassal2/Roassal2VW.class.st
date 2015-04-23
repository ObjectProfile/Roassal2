"
A simple class to export Roassal and trachel packages to visualworks
"
Class {
	#name : #Roassal2VW,
	#superclass : #Object,
	#category : #'Roassal2-ExporterVW'
}

{ #category : #importing }
Roassal2VW >> codeForVisualWorks [
	"
	(self new packages second value) do: [ :pkg| Transcript show: 'm1 add: ''Roassal2-', pkg,'''.'; cr. ].
	"
	"
| map b btests bexamples classes p cat m1 currentB |
m1 := OrderedCollection new.
m1 add: 'Trachel-Core'.
m1 add: 'Trachel-Viva'.

m1 add: 'Roassal2-Builder-AnimatedScatterPlot'.
m1 add: 'Roassal2-Builder-AxisAdapted'.
m1 add: 'Roassal2-Builder-CircularMap'.
m1 add: 'Roassal2-Builder-Common'.
m1 add: 'Roassal2-Builder-Composer'.
m1 add: 'Roassal2-Builder-Explora'.
m1 add: 'Roassal2-Builder-Grapher'.
m1 add: 'Roassal2-Builder-Kiviat'.
m1 add: 'Roassal2-Builder-Legend'.
m1 add: 'Roassal2-Builder-Map'.
m1 add: 'Roassal2-Builder-Menu'.
m1 add: 'Roassal2-Builder-Mondrian'.
m1 add: 'Roassal2-Builder-MondrianOLD'.
m1 add: 'Roassal2-Builder-NameCloud'.
m1 add: 'Roassal2-Builder-PieChart'.
m1 add: 'Roassal2-Builder-ScatterplotMap'.
m1 add: 'Roassal2-Builder-ScrollBar'.
m1 add: 'Roassal2-Builder-SimilarityMatrix'.
m1 add: 'Roassal2-Builder-Simon'.
m1 add: 'Roassal2-Builder-Spectrograph'.
m1 add: 'Roassal2-Builder-StackBarPlot'.
m1 add: 'Roassal2-Builder-StructureMatrix'.
m1 add: 'Roassal2-Builder-Sunburst'.
m1 add: 'Roassal2-Builder-TextBuilder'.
m1 add: 'Roassal2-Builder-TimeLine'.
m1 add: 'Roassal2-Builder-TreeMap'.
m1 add: 'Roassal2-Builder-UI-Slider'.
m1 add: 'Roassal2-Builder-UML'.
m1 add: 'Roassal2-Cachetor'.
m1 add: 'Roassal2-ColorNormalizer'.
m1 add: 'Roassal2-Core'.
m1 add: 'Roassal2-ExampleBrowser'.
m1 add: 'Roassal2-Exporter-HTML5'.
m1 add: 'Roassal2-Exporter-PNG'.
m1 add: 'Roassal2-Exporter-SVG'.
m1 add: 'Roassal2-Layouts'.
m1 add: 'Roassal2-OpenStreetMap'.
m1 add: 'Roassal2-Sparkline'.
m1 add: 'Roassal2-Table'.
m1 add: 'Roassal2-Tests'.
m1 add: 'Roassal2-Utility'.

b := Registry bundleNamed: 'Roassal2'.
btests := Registry bundleNamed: 'Roassal2-Tests'.
bexamples := Registry bundleNamed: 'Roassal2-Examples'.
map := Dictionary new.
classes := b allClasses.
currentB := nil.
classes do:[:cls | 
	cat := cls myClass category asString.
	(m1 includes: cat) ifTrue: [
		('Roassal2-*' match: cat) ifTrue: [ cat := cat copyFrom: 10 to: cat size. ].
		currentB := b.
		('*Test' match: cls myClass name) ifTrue: [ currentB := btests.
			cat := cat , '-Tests'. ].
		(('*Example*' match: cls myClass name) or: [ '*Examples' match: cls myClass name]) 
			ifTrue: [ currentB := bexamples.
			cat := cat , '-Examples' ].
		p := map at: cat ifAbsent: [ 
			p := Registry packageNamedOrCreate: cat.
			currentB addItem: p.
			map at: cat put: p.
			p  ]. 
		XChangeSet current moveWholeClass: cls toPackage: p ]. ].


	"
			
			
]

{ #category : #importing }
Roassal2VW >> codeToDeletePackages [
	"

| b arr list |
list := OrderedCollection new.
list add: 'extentions'; add: 'frompharo'; add: 'fromvw'; add: 'tests-extentions';
	add: 'examples-extentions'.
arr := Array with: 'Roassal2' with: 'Roassal2-Examples' with: 'Roassal2-Tests'.
arr do: [ :ar | 
	b := Registry bundleNamed: ar.
	b leafItems do: [ :pkg | 
		(list includes: pkg name) ifFalse: [
			pkg doUnloadFromImage.
		]. ]. ].


	"
			
			
]

{ #category : #exporting }
Roassal2VW >> exportPackages [
	"
	self new exportPackages
	"
	"This code export all these packages to my workspace in order to export/import this code"
	| dirpath exporter |
	dirpath := 'c:/Users/azazael/Documents/VisualWorks Projects/roassal2/'.
	exporter := RoassalExporter new
		to: dirpath namespace: self namespace.
	
	exporter exportPackages: self packages.
		
]

{ #category : #loadExporter }
Roassal2VW >> loadExporter [
Gofer new
		squeaksource: 'PackageInfo';
		package: 'PackageInfo-Exporters';
		load.

]

{ #category : #accesing }
Roassal2VW >> namespace [
	^ #Roassal2
]

{ #category : #accesing }
Roassal2VW >> packages [
	 ^ {
		'Trachel'->{'Core'. 'Viva'}.
		'Roassal2'->{
			'Builder-AnimatedScatterPlot'. 'Builder-AxisAdapted'.
			'Builder-BoxPlot'.
			'Builder-CircularMap'. 'Builder-Common'.
			'Builder-Composer'. 'Builder-Explora'.
			'Builder-Grapher'. 'Builder-Kiviat'.
			'Builder-Legend'. 'Builder-Map'. 'Builder-Menu'.
			'Builder-Mondrian'. 'Builder-MondrianOLD'. 'Builder-NameCloud'.
			'Builder-PieChart'. 'Builder-ScatterplotMap'. 
			'Builder-ScrollBar'. 'Builder-SimilarityMatrix'.
			'Builder-Simon'. 'Builder-Spectrograph'. 
			'Builder-StackBarPlot'. 'Builder-StructureMatrix'.
			'Builder-Sunburst'. 'Builder-TextBuilder'. 'Builder-TimeLine'. 'Builder-TreeMap'.
			'Builder-UI-Slider'. 'Builder-UML'. 
			'Cachetor'. 'ColorNormalizer'.
			'Core'. 'ExampleBrowser'.
			'Exporter-HTML5'. 'Exporter-PNG'. 'Exporter-SVG'. 'Layouts'. 'OpenStreetMap'.
			'Sparkline'. 'Table'. 'Tests'. 'Utility'}
		}
]

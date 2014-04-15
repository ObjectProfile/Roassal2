Class {
	#name : #RTHTMLExporterShowroom,
	#superclass : #RTObject,
	#instVars : [
		'stream'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #examples }
RTHTMLExporterShowroom >> GraphETHistogram [
	|builder exporter|
	builder := GET2Bar data: ((1 to: 15) collect: [ :v | 10 atRandom - 5 ]).
	builder color: [ :val | 		|alpha MAX|
		MAX := 8.
		alpha := [ :v | (v abs / MAX) ].
		val positive ifTrue: [ Color blue alpha: (alpha value: val) ]
		  			  ifFalse: [ Color purple alpha: (alpha value: val) ]
		 ].
	builder open.
	exporter := RTHTMLExporter new 
		builder: builder filename: 'GraphETHistogram' title: 'GraphET2 Histogram'; yourself.
	exporter code: thisContext method sourceCode.
	exporter exportToFile.
]

{ #category : #examples }
RTHTMLExporterShowroom >> GraphETLine [
	|builder normalizer data exporter|
	data := #(#(1 4) #(3 2) #(4 5) #(5 4) #(6 10) #(10 30) #(12 25)).
	
	normalizer := RTNColorLinearNormalizer 
					inContext: data withCommand: #second lowColor: Color paleRed highColor: Color blue.
	
	builder := GET2Line data: data.
	builder
		x: #first;
		y: #second;
		lineWidth: 2;
		dotColor: [ :v |  (normalizer rtValue: v) alpha: 0.5];
		dotSize: 15.
	builder open.
	exporter := RTHTMLExporter new 
		builder: builder filename: 'GraphETLine' title: 'GraphET2 Line'; yourself.
	exporter code: thisContext method sourceCode.
	exporter exportToFile.  
	
]

{ #category : #examples }
RTHTMLExporterShowroom >> GraphETScatterPlot [
	| values builder exporter|
	values :=  #( #(1 3 9) #(3 2 7) #(5 14 5) #(6 10 7) #(7 9 9) #(8 8 10) ).

	builder := GET2Scatterplot data: values.
	builder 
		color: (Color purple alpha:0.4).
	builder open.
	exporter := RTHTMLExporter new 
		builder: builder filename: 'GraphETScatterPlot' title: 'GraphET2 ScaterPlot'; yourself.
	exporter code: thisContext method sourceCode.
	exporter exportToFile.  
	
]

{ #category : #html }
RTHTMLExporterShowroom >> endHTML [
	stream
		nextPutAll:'</body>
</html>'
]

{ #category : #export }
RTHTMLExporterShowroom >> export [
	self exportExamples.
	self makeIndex.
]

{ #category : #export }
RTHTMLExporterShowroom >> exportExamples [
	| examples showroom|
	showroom := FileSystem disk workingDirectory / 'showroom'.
	(showroom = nil or: [ (showroom isDirectory) not])
		ifTrue: [showroom createDirectory].
	RTHTMLExporter directory: showroom.
	examples := self class methods select: [ :m |  m category = #examples].
	examples do: [ :e | e valueWithReceiver: self arguments: #() ].
]

{ #category : #export }
RTHTMLExporterShowroom >> exportOnStream: fileStream [
	stream := fileStream.
	self startHTML.
	self makeExampleList.
	self endHTML.
]

{ #category : #initialization }
RTHTMLExporterShowroom >> initialize [
	super initialize.
]

{ #category : #html }
RTHTMLExporterShowroom >> makeExampleList [
	|examples |
	examples := self class methods select: [ :m |  m category = #examples] thenCollect: [ :e | e selector asString copyWithRegex: '#' matchesReplacedWith: ''].
	stream
		nextPutAll: '<ul>'.
	examples do:[ :e | stream nextPutAll: '<li><a href=',e,'.html>',e,'</a></li>'].
	stream
		nextPutAll: '</ul>'.		
]

{ #category : #export }
RTHTMLExporterShowroom >> makeIndex [
	| file  dir|
	dir := RTHTMLExporter directory.
	file := (dir / 'index.html').
	file exists ifTrue: [file delete].
	file := (dir / 'index.html') writeStream.
	[ self exportOnStream: file ] 
		ensure: [ file notNil ifTrue: [ file close ] ]
]

{ #category : #html }
RTHTMLExporterShowroom >> startHTML [
	stream
		nextPutAll:'<!DOCTYPE html>
<html>
<body>'
]

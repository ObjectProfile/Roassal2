"
RTInteractiveSVGExporter exists for the sole porpouse of adding interactions, coming from the RTHTMLExporter, smoothly
"
Class {
	#name : #RTInteractiveSVGExporter,
	#superclass : #RTSVGExporter,
	#instVars : [
		'interactions'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #exporting }
RTInteractiveSVGExporter >> exportOnStream: fileStream [
	|bounds|
	bounds := self fixedEncompassingRectangle.
	self stream: fileStream.
	self addStart: bounds.
	RTSVGVisitor visit: view on: stream with: self interactions canvas: bounds.
	self addEnd.
]

{ #category : #accessing }
RTInteractiveSVGExporter >> interactions [
	^ interactions
]

{ #category : #accessing }
RTInteractiveSVGExporter >> interactions: anObject [
	interactions := anObject
]

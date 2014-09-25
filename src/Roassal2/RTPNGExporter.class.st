Class {
	#name : #RTPNGExporter,
	#superclass : #RTObject,
	#instVars : [
		'view',
		'fileName'
	],
	#category : #'Roassal2-Exporter-PNG'
}

{ #category : #accessing }
RTPNGExporter >> builder [
	^ view
]

{ #category : #accessing }
RTPNGExporter >> builder: anObject [
	view := anObject
]

{ #category : #public }
RTPNGExporter >> exportToFile [
	self todo: 'The form is not yet correct as it only displays the visible part of the morph'.
	PNGReadWriter 
		putForm: view view canvas morph imageForm
		onFileNamed: self fileName 
]

{ #category : #accessing }
RTPNGExporter >> fileName [
	^ fileName
]

{ #category : #accessing }
RTPNGExporter >> fileName: anObject [
	fileName := anObject
]

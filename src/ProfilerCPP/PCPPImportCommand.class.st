Class {
	#name : #PCPPImportCommand,
	#superclass : #MPImportCommand,
	#category : #ProfilerCPP
}

{ #category : #'as yet unclassified' }
PCPPImportCommand >> execute [

	| filePathAsString importer stream |
	
	stream := UITheme builder fileOpen: 'Import SQL DB file' extensions: #('db').
	filePathAsString := stream fullName.
	(filePathAsString isNil or: [ filePathAsString isEmpty ]) ifTrue: [ ^ self ].
	
	importer := PCPPImporter new.
	importer import: filePathAsString.
	importer model name: stream localName.
	importer model install.
	self addModel: importer model.
	
	stream close
]

{ #category : #'as yet unclassified' }
PCPPImportCommand >> label [

	^ 'Import SQL-based C++ profiler'
]

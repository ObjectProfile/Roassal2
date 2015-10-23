Class {
	#name : #GLMAbstractExportingAction,
	#superclass : #GLMRoassal2Action,
	#category : #'Roassal2GT-Glamour-Actions'
}

{ #category : #hooks }
GLMAbstractExportingAction >> doExportToFull: fileName [

	self subclassResponsibility
]

{ #category : #hooks }
GLMAbstractExportingAction >> execute [
	| fileName |
	fileName := UITheme builder 
						fileSave: 'Enter the ', self titleExtension,' file name'
						extensions: self extensions
						path: nil.
	fileName notNil ifTrue: [ 
		RTPNGExporter new 
					builder: self roassalView;
					fileName: fileName fullName;
					exportToFile. ]
]

{ #category : #hooks }
GLMAbstractExportingAction >> extensions [
	"
	May return for example: #('png')
	"
	^ #()
]

{ #category : #hooks }
GLMAbstractExportingAction >> title [
	^ 'Export to ', self titleExtension
]

{ #category : #hooks }
GLMAbstractExportingAction >> titleExtension [
	^ 'TOOVERRIDE'
]

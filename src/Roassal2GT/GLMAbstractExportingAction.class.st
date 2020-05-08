Class {
	#name : #GLMAbstractExportingAction,
	#superclass : #GLMRoassal2Action,
	#category : #'Roassal2GT-Glamour-Actions'
}

{ #category : #accessing }
GLMAbstractExportingAction >> category [
	^ 'Export as...'
]

{ #category : #hooks }
GLMAbstractExportingAction >> doExportToFull: fileName [

	self subclassResponsibility
]

{ #category : #hooks }
GLMAbstractExportingAction >> execute [
	| fileName |
	fileName := UITheme builder 
						chooseForSaveFileReference: 'Enter the ', self titleExtension, ' file name'
						extensions: self extensions
						path: FileLocator home asPath. 

	fileName notNil ifTrue: [ 
		self doExportToFull: fileName asAbsolute ]
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

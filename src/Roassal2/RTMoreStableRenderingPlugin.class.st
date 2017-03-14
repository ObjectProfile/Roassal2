Class {
	#name : #RTMoreStableRenderingPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-Plugins'
}

{ #category : #hooks }
RTMoreStableRenderingPlugin >> description [
	^ 'Improve the class AthensCairoSurface to not keep a reference.
Instead, the image is copied. Installing this plugin may make rendering slower,
but likely more stable.'
]

{ #category : #hooks }
RTMoreStableRenderingPlugin >> execute [
	| variableName |
	variableName := #formCache.
	(AthensCairoSurface instVarNames includes: variableName)
		ifFalse: [ 
AthensSurface subclass: #AthensCairoSurface
	uses: TCairoLibrary
	instanceVariableNames: (' ' join: (AthensCairoSurface instVarNames), (Array with: variableName))
	classVariableNames: ''
	poolDictionaries: 'AthensCairoDefs'
	package: 'Athens-Cairo' ].


	AthensCairoSurface compile: 'asForm

    "create a form and copy an image data there"
    self checkSession.
    self flush.
	 formCache ifNotNil: [ ^ formCache ].
    formCache := Form extent: (self width@self height) depth: 32.
    formCache unhibernate.
    LibC memCopy: self getDataPtr to: formCache bits size: self width*self height*4.
    ^ formCache'.
]

{ #category : #hooks }
RTMoreStableRenderingPlugin >> label [
	^ 'Make Cairo / Roassal more stable'
]

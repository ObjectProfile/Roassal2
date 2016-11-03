Class {
	#name : #CPPHeader,
	#superclass : #CPPFile,
	#instVars : [
		'module'
	],
	#category : #'Roassal2-Plugins-CProjectVisualizer'
}

{ #category : #testing }
CPPHeader >> hasModule [
	^ module notNil
]

{ #category : #accessing }
CPPHeader >> module [
	^ module
]

{ #category : #accessing }
CPPHeader >> module: anObject [
	module := anObject
]

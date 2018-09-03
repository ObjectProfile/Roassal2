Class {
	#name : #JVPackage,
	#superclass : #JVObject,
	#instVars : [
		'packageName',
		'classes',
		'children'
	],
	#category : #'Roassal2-Plugins-JavaVisualizer'
}

{ #category : #adding }
JVPackage >> addClass: aClass [
	classes at: aClass classname put: aClass
]

{ #category : #accessing }
JVPackage >> classes [
	^ classes values
]

{ #category : #initialization }
JVPackage >> initialize [
	super initialize.
	classes := Dictionary new.
	
]

{ #category : #metrics }
JVPackage >> numberOfClasses [
	^ classes size
]

{ #category : #accessing }
JVPackage >> packageName [
	^ packageName
]

{ #category : #accessing }
JVPackage >> packageName: anObject [
	packageName := anObject
]

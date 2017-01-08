Class {
	#name : #JVClass,
	#superclass : #JVFile,
	#instVars : [
		'classname',
		'superclass',
		'superclassName',
		'packageName',
		'package'
	],
	#category : #'Roassal2-Plugins-JavaVisualizer'
}

{ #category : #accessing }
JVClass >> classname [
	^ classname
]

{ #category : #accessing }
JVClass >> classname: anObject [
	classname := anObject
]

{ #category : #initialization }
JVClass >> initializeFromContentAsString: aString [
	
	aString linesDo: [ :l |
		(l beginsWith: 'package') ifTrue: [ packageName := (l substrings: ' ;') second ].		
		(l substrings includes: 'class') ifTrue: [ self setSuperclassNameFrom: l ]
	].
	loc := aString lineCount.

]

{ #category : #accessing }
JVClass >> package [
	^ package
]

{ #category : #accessing }
JVClass >> package: anObject [
	package := anObject
]

{ #category : #accessing }
JVClass >> packageName [
	^ packageName
]

{ #category : #accessing }
JVClass >> packageName: anObject [
	packageName := anObject
]

{ #category : #initialization }
JVClass >> setSuperclassNameFrom: aLine [
	| ss i |
	ss := aLine substrings.
	i := ss indexOf: 'extends'.
	i = 0 ifTrue: [ superclassName := 'Object' ] ifFalse: [ superclassName := ss at: (i + 1) ]
]

{ #category : #accessing }
JVClass >> superclass [
	^ superclass
]

{ #category : #accessing }
JVClass >> superclass: anObject [
	superclass := anObject
]

{ #category : #accessing }
JVClass >> superclassName [
	^ superclassName
]

{ #category : #accessing }
JVClass >> superclassName: anObject [
	superclassName := anObject
]

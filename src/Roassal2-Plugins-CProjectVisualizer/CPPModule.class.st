Class {
	#name : #CPPModule,
	#superclass : #CPPFile,
	#instVars : [
		'header',
		'dependentModules'
	],
	#category : #'Roassal2-Plugins-CProjectVisualizer-Core'
}

{ #category : #accessing }
CPPModule >> addDependentModules: someModules [
	self assert: [ someModules allSatisfy: [ :m | m class == self class ] ].
	dependentModules addAll: (someModules copyWithout: self).
	dependentModules removeDuplicates 
]

{ #category : #accessing }
CPPModule >> dependOn: aRegExp [
	^ self dependentModules anySatisfy: [ :m | aRegExp match: m filename ]
]

{ #category : #accessing }
CPPModule >> dependentModules [
	^ dependentModules
]

{ #category : #testing }
CPPModule >> hasHeader [
	^ header notNil
]

{ #category : #testing }
CPPModule >> hasNoHeader [
	^ self hasHeader not
]

{ #category : #accessing }
CPPModule >> header [
	^ header
]

{ #category : #accessing }
CPPModule >> header: anObject [
	header := anObject
]

{ #category : #initialization }
CPPModule >> initialize [
	super initialize.
	dependentModules := OrderedCollection new
]

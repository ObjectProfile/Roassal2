Class {
	#name : #JVProcessor,
	#superclass : #JVObject,
	#instVars : [
		'classes',
		'packages'
	],
	#category : #'Roassal2-Plugins-JavaVisualizer'
}

{ #category : #dependencies }
JVProcessor >> bindClassesToPackages [
	self classes do: [ :c |
		| p |
		p := self getPackageNamed: c packageName.
		c package: p.
		p addClass: c
	]
]

{ #category : #accessing }
JVProcessor >> classes [
	^ classes values
]

{ #category : #dependencies }
JVProcessor >> createPackageIfNecessary: aPackageName [
	(self packages anySatisfy: [ :p | p packageName = aPackageName ])
		ifFalse: [ self createPackageNamed: aPackageName ]
]

{ #category : #dependencies }
JVProcessor >> createPackageNamed: aPackageName [
	packages at: aPackageName put: (JVPackage new packageName: aPackageName)
]

{ #category : #dependencies }
JVProcessor >> createPackagesIfNecessary [
	self classes do: [ :c | c packageName ifNotNil: [ self createPackageIfNecessary: c packageName ] ]
]

{ #category : #dependencies }
JVProcessor >> getPackageNamed: aPackageName [
	^ packages at: aPackageName
]

{ #category : #initialization }
JVProcessor >> initialize [
	super initialize.
	classes := Dictionary new.
	packages := Dictionary new
]

{ #category : #metrics }
JVProcessor >> numberOfClasses [
	^ classes size
]

{ #category : #metrics }
JVProcessor >> numberOfPackages [
	^ packages size
]

{ #category : #accessing }
JVProcessor >> packages [
	^ packages values
]

{ #category : #processing }
JVProcessor >> processFileAsString: fileContentAsString named: filename [
	(filename endsWith: '.java')
		ifTrue: [ ^ self processJavaFileAsString: fileContentAsString named: filename ].

]

{ #category : #processing }
JVProcessor >> processJavaFileAsString: fileContentAsString named: filename [
	| j |
	j := JVClass new.
	j classname: (filename substrings: '/.\') allButLast last.
	j filename: filename.
	j initializeFromContentAsString: fileContentAsString.
	classes at: j classname put: j

]

{ #category : #dependencies }
JVProcessor >> resolveDependencies [

	self createPackagesIfNecessary.
	self bindClassesToPackages.
]

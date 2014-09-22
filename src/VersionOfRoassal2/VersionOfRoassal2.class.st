"
A TemplateVersionOf is xxxxxxxxx.

Instance Variables
	password:		<Object>
	username:		<Object>

password
	- xxxxx

username
	- xxxxx

"
Class {
	#name : #VersionOfRoassal2,
	#superclass : #Object,
	#instVars : [
		'username',
		'password'
	],
	#category : #VersionOfRoassal2
}

{ #category : #utility }
VersionOfRoassal2 >> askForCommitCommentForVersion: version [
	"
	self new askForCommitComment
	"
	| v |
	v := UIManager default textEntry: 'Enter a commit comment' title: 'Committing' entryText: version.
	^ v
]

{ #category : #utility }
VersionOfRoassal2 >> askForPassword [
	"
	self new askForPassword
	"
	password ifNotNil: [ ^ password ].
	password := UIManager default requestPassword: 'Enter your password'.
	^ password
]

{ #category : #utility }
VersionOfRoassal2 >> askForUsername [
	"
	self new askForUsername
	"
	username ifNotNil: [ ^ username ].
	username := UIManager default request: 'Enter your username'.
	^ username
]

{ #category : #utility }
VersionOfRoassal2 >> askVersionId [
	"
	self new askVersionId
	"
	| v |
	v := UIManager default request: 'Enter a version number' initialAnswer: self nextVersion.
	^ v
]

{ #category : #public }
VersionOfRoassal2 >> commit [
	"
	self new commit
	
	1 - Generate a new version number
	2 - Ask for a class comment
	3 - Save all the packages
	4 - Create a new version method in this class
	5 - Save the class"
	
	| newVersion comment |
	newVersion := self askVersionId.
	newVersion ifNil: [ ^ self ].
	comment := self askForCommitCommentForVersion: newVersion.
	comment ifNil: [ ^ self ].	
	self saveAllPackagesWithComment: comment.
	self createNewVersion: newVersion methodWithComment: comment.
	self savePackageOfVersionWithComment: comment
	
]

{ #category : #utility }
VersionOfRoassal2 >> createNewVersion: versionIdAsString methodWithComment: comment [
	| s |
	s := self sourceCodeOfVersionWithComment: comment version: versionIdAsString.
	self class compile: s classified: 'versions'
]

{ #category : #configuration }
VersionOfRoassal2 >> dependencies [
	"Change the array given below to add dependencies. For example
	
	^ { 
		'abergel' -> 'JSON' .
		'ObjectProfile' -> 'Roassal'
	}
	
	Each dependency is an association 'Owner' -> 'Project name'.
	Each project should contains a version
	"
	^ { }
]

{ #category : #'utility-monticello' }
VersionOfRoassal2 >> getMCVersionWorkingCopyOfPackageNamed: packageName [
	"
	self new mcVersionWorkingCopy
	"
	| workingcopyOrNil |
	workingcopyOrNil := MCWorkingCopy hasPackageNamed: packageName.
	workingcopyOrNil isNil ifFalse: [ ^ workingcopyOrNil ].
	
	PackageInfo registerPackageName: packageName.
	^ MCWorkingCopy forPackage: (MCPackage named: packageName) 
]

{ #category : #'utility-monticello' }
VersionOfRoassal2 >> getMCVersions [
	"
	self new getMCVersions
	"
	^ self mcPackages collect: [ :mcPackage | MCVersion package: mcPackage ]
]

{ #category : #testing }
VersionOfRoassal2 >> isModified: aPackageName [
	"True if the package aPackageName is modified"
	
	^ self modifiedPackages includes: aPackageName
]

{ #category : #testing }
VersionOfRoassal2 >> isNewVersionOfAnyPackagesinTheRepository [
	"Return true if there is a new version of any package on the server"
	
	| versionWorkingCopyVersion allFileNames allFileNamesForVersions allVersionID currentIdVersion |
	allFileNames := self repository readableFileNames.
	self mcWorkingCopies do: [ :wc |
		versionWorkingCopyVersion := wc ancestry ancestors first name.
		allFileNamesForVersions := allFileNames select: [ :fileName | fileName beginsWith: wc package name ].
		allVersionID := (allFileNamesForVersions collect: [ :fileName | (fileName subStrings: '.') second asInteger ]) asSortedCollection. 
		currentIdVersion := (versionWorkingCopyVersion subStrings: '.') second asInteger.
		(allVersionID anySatisfy: [ :id | id > currentIdVersion ]) ifTrue: [ ^ true ]
	].
	^ false.
	

]

{ #category : #testing }
VersionOfRoassal2 >> isNewVersioninTheRepository [
	"Return true if there is a new version of the VersionOfXXX package in the server of the version package"
	
	| className versionWorkingCopyVersion allFileNames allFileNamesForVersions allVersionID currentIdVersion |
	"If the version class is not modified, we check if the class VersionOfXX is the the last version in the repository"
	className := self class name asString.
	versionWorkingCopyVersion := self mcVersionWorkingCopy ancestry ancestors first name.
	allFileNames := self repository readableFileNames.
	allFileNamesForVersions := allFileNames select: [ :fileName | fileName beginsWith: className ].
	allVersionID := (allFileNamesForVersions collect: [ :fileName | (fileName subStrings: '.') second asInteger ]) asSortedCollection. 
	currentIdVersion := (versionWorkingCopyVersion subStrings: '.') second asInteger.

	"Check if there are some more recent version"
	^ (allVersionID anySatisfy: [ :id | id > currentIdVersion ])
		
		
]

{ #category : #accessing }
VersionOfRoassal2 >> lastInfo [
	"Return the detail of the last version. Return a dictionary"

	"
	self new lastInfo
	"
	
	^ self perform: self lastSelectorVersion
]

{ #category : #utility }
VersionOfRoassal2 >> lastSelectorVersion [
	^ self selectorsForVersions asSortedCollection last
]

{ #category : #accessing }
VersionOfRoassal2 >> lastVersion [
	"Return the last version recorded"

	| lastSelector |
	self selectorsForVersions isEmpty
		ifTrue: [ ^ '0.0' ].
	lastSelector := self lastSelectorVersion.
	^ (self perform: lastSelector) at: #version
]

{ #category : #'utility-monticello' }
VersionOfRoassal2 >> mcPackages [
	"
	self new mcPackages
	"
	^ self packages collect: [ :pName | MCPackage named: pName ]
]

{ #category : #'utility-monticello' }
VersionOfRoassal2 >> mcVersionWorkingCopy [
	"
	self new mcVersionWorkingCopy
	"
	^ self getMCVersionWorkingCopyOfPackageNamed: self class name

]

{ #category : #'utility-monticello' }
VersionOfRoassal2 >> mcWorkingCopies [
	"
	Return the mcworking copies of the packages
	
	self new mcWorkingCopies
	"
	| registry |
	registry := MCWorkingCopy registry.
	^ self mcPackages collect: [ :p | 
		(registry includes: p)
			ifTrue: [ registry at: p ]
			ifFalse: [ PackageInfo registerPackageName: p. 
						  MCWorkingCopy forPackage: p ] ]
]

{ #category : #accessing }
VersionOfRoassal2 >> modifiedPackages [
	"Return the list of modified packages"
	
	^ (self mcWorkingCopies select: #modified) collect: [ :wc | wc package name ]
	
]

{ #category : #utility }
VersionOfRoassal2 >> nextVersion [
	^ self nextVersionOf: self lastVersion
]

{ #category : #utility }
VersionOfRoassal2 >> nextVersionNumberForMethod [
	| ss lastSel number versionNumberAsString |
	ss := self selectorsForVersions.
	ss isEmpty ifTrue: [ ^ '000000' ].
	
	lastSel := self lastSelectorVersion.
	
	number := lastSel copyFrom: 'version' size + 1 to: lastSel size.
	versionNumberAsString := (number asInteger + 1) printString.
	[ versionNumberAsString size < 6 ] whileTrue: 
		[ versionNumberAsString := '0', versionNumberAsString ].
	^ versionNumberAsString
	
]

{ #category : #utility }
VersionOfRoassal2 >> nextVersionOf: versionNumberAsString [
	"
	self new nextVersionOf: '1.5'
	self new nextVersionOf: '10.553'
	"
	| i minorNumber majorNumber |
	i := versionNumberAsString indexOf: $. .
	i = 0 ifTrue: [ Error signal. "Should not be" ].

	minorNumber := versionNumberAsString copyFrom: i + 1 to: versionNumberAsString size.
	majorNumber := versionNumberAsString copyFrom: 1 to: i - 1.
	
	^ majorNumber, '.', (minorNumber asInteger + 1) printString

]

{ #category : #configuration }
VersionOfRoassal2 >> owner [
	^ 'ObjectProfile'
]

{ #category : #'utility-monticello' }
VersionOfRoassal2 >> packageWithVersionOf: packageName [
	^ (MCWorkingCopy hasPackageNamed: packageName) ancestry ancestors first name
	
]

{ #category : #configuration }
VersionOfRoassal2 >> packages [
	^ { 'Trachel' . 'Roassal2' }
]

{ #category : #accessing }
VersionOfRoassal2 >> password: aPasswordAsString [
	password := aPasswordAsString
]

{ #category : #'utility-monticello' }
VersionOfRoassal2 >> repository [

	^ MCHttpRepository
			location: self url
			user: self askForUsername
			password: self askForPassword
]

{ #category : #utility }
VersionOfRoassal2 >> saveAllPackagesWithComment: commentAsText [
	| newVersions r |
	
	newVersions := self mcWorkingCopies select: #modified thenCollect: [ :wc | 
		(wc class canUnderstand: #newVersionWithMessage:)
			ifTrue: [ wc newVersionWithMessage: commentAsText ]
			ifFalse: [ wc newVersionWithMessage: commentAsText in: self repository  ]
		].
	r := self repository.
	newVersions do: [ :mcv | r storeVersion: mcv ]
]

{ #category : #utility }
VersionOfRoassal2 >> savePackageOfVersionWithComment: commentAsText [
	"
	self new savePackageOfVersionWithComment: ''
	"
	| r newVersion |
	
	(self mcVersionWorkingCopy class canUnderstand: #newVersionWithMessage:)
			ifTrue: [ newVersion := self mcVersionWorkingCopy newVersionWithMessage: commentAsText ]
			ifFalse: [ newVersion := self mcVersionWorkingCopy newVersionWithMessage: commentAsText in: self repository  ].
	
	r := self repository.
	r storeVersion: newVersion
]

{ #category : #utility }
VersionOfRoassal2 >> selectorsForVersions [
	^ self class selectors select: [ :sel | sel beginsWith: 'version' ]
]

{ #category : #utility }
VersionOfRoassal2 >> sourceCodeOfVersionWithComment: comment version: versionAsString [
	"
	self new sourceCodeOfVersionWithComment: 'Hello World'
	"
	| s |
	s := WriteStream on: String new.
	
	"Method name"
	s nextPutAll: 'version'.
	s nextPutAll: self nextVersionNumberForMethod.
	s cr.
	
	"Method body"
	s nextPutAll: '	^ Dictionary new '; cr.
	self packages do: [ :pName | 
		s nextPutAll: '	at: '''.
		s nextPutAll: pName.
		s nextPutAll: ''' put: '''.
		s nextPutAll: (self packageWithVersionOf: pName).
		s nextPutAll: ''';'.
		s cr.
	].

	"Version number"
	s nextPutAll: '	at: #version put: '''.
	s nextPutAll: versionAsString.
	s nextPutAll: ''';'.
	s cr.

	"Comment"
	s nextPutAll: '	at: #comment put: '''.
	s nextPutAll: comment.
	s nextPutAll: ''';'.
	s cr.
		
	"Date"
	s nextPutAll: '	at: #date put: '''.
	s nextPutAll: Date today printString.
	s nextPutAll: ''';'.
	s cr.

	"Closing"
	s nextPutAll: '	yourself'.
	
	"Return the result"
	^ s contents
]

{ #category : #public }
VersionOfRoassal2 >> update [

	"
	Load or update the application to its last version
	self new update
	"
	| info projectName className |
	
	(self mcWorkingCopies anySatisfy: #modified) ifTrue: [ 
		| v |
		self setStatusBar: 'Some packages have been modified'. 
		v := UIManager default confirm: 'Some packages have been modified, do you want to proceed and erase your change?'.
		v ifFalse: [ ^ self ] ].

	"self updateVersionClassIfNecessary."
	className := self class name asString.
	projectName := className copyFrom: 'VersionOf' size + 1 to: className size.

	"Load the dependencies"
	self dependencies do: [ :dep | 
		"dep is a key owner -> project"
		(Smalltalk globals includesKey: ('VersionOf', dep value) asSymbol)
			ifFalse: [ Gofer new 
							smalltalkhubUser: dep key project: dep value;  
							package: ('VersionOf', dep value) asString;
							load.
							(Smalltalk globals at: ('VersionOf', dep value) asSymbol) new update ] ].
	

	"Load all the packages"
	info := self perform: (self lastSelectorVersion).
	(info keys select: [ :key | key class == 'abc' class ]) do: [ :packageName |
			Gofer new 
				smalltalkhubUser: self owner project: projectName; 
				version: (info at: packageName); 
				load.
		 ]
]

{ #category : #public }
VersionOfRoassal2 >> updateVersionClassIfNecessary [

	"
	Update the application to its last version
	Return false if no update where necessary
	Return true if everything has been updated
	
	self new updateVersionClassIfNecessary
	"
	| className projectName |

	"Check if the version class is modified"
	self mcVersionWorkingCopy modified ifTrue: [ 
		self setStatusBar: self class name, ' has been modified. You need to save or revert manually the version. Cannot proceed.'. 
		^ self ].
	
	self isNewVersioninTheRepository ifFalse: [
		self setStatusBar: 'Up to date!'.
		^ false 
		 ].

	"We load the last version of the version class, and update"
	className := self class name asString.
	projectName := className copyFrom: 'VersionOf' size + 1 to: className size.
	Gofer new 
		smalltalkhubUser: self askForUsername project: projectName; 
		package: className; 
		load. 
	
	(Smalltalk at: className asSymbol) update

	
]

{ #category : #configuration }
VersionOfRoassal2 >> url [
	"Enter the Smalltalkhub url"
	"Check http://smalltalkhub.com if you are unsure"
	^ 'http://smalltalkhub.com/mc/ObjectProfile/Roassal2/main'
]

{ #category : #accessing }
VersionOfRoassal2 >> username: aUsernameAsString [
	username := aUsernameAsString
]

{ #category : #versions }
VersionOfRoassal2 >> version000000 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.3';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.3';
	at: #version put: '0.1';
	at: #comment put: '0.1 : first shoot!';
	at: #date put: '17 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000001 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.3';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.4';
	at: #version put: '0.2';
	at: #comment put: '0.2 : added ellipse, thanks to Igor';
	at: #date put: '17 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000002 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.4';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.5';
	at: #version put: '0.3';
	at: #comment put: '0.3 : worked on the circle';
	at: #date put: '18 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000003 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.5';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.6';
	at: #version put: '0.4';
	at: #comment put: '0.4 : added animation';
	at: #date put: '23 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000004 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.6';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.7';
	at: #version put: '0.5';
	at: #comment put: '0.5 : worked on the animations';
	at: #date put: '23 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000005 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.7';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.7';
	at: #version put: '0.6';
	at: #comment put: '0.6 : added mouse click';
	at: #date put: '23 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000006 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.8';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.8';
	at: #version put: '0.7';
	at: #comment put: '0.7 : worked a lot of both Trachel and Roassal2';
	at: #date put: '25 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000007 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.8';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.9';
	at: #version put: '0.8';
	at: #comment put: '0.8 : worked on nesting. Seems to be okay for now';
	at: #date put: '25 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000008 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.8';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.10';
	at: #version put: '0.9';
	at: #comment put: '0.9 : RTNest seems to work well now :-)';
	at: #date put: '25 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000009 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.9';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.11';
	at: #version put: '0.10';
	at: #comment put: '0.10 : working on edges';
	at: #date put: '26 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000010 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.9';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.12';
	at: #version put: '0.11';
	at: #comment put: '0.11 : worked on the edges';
	at: #date put: '27 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000011 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.9';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.13';
	at: #version put: '0.12';
	at: #comment put: '0.12 : added tree layout';
	at: #date put: '28 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000012 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.10';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.14';
	at: #version put: '0.13';
	at: #comment put: '0.13 : worked on the animations and element blinking. Not working properly so far. More work is required';
	at: #date put: '29 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000013 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.11';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.15';
	at: #version put: '0.14';
	at: #comment put: '0.14 : started to work on the labels (both in Trachel and Roassal)';
	at: #date put: '29 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000014 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.12';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.16';
	at: #version put: '0.15';
	at: #comment put: '0.15 : added labels. It seems to work well. Including with the scaling.';
	at: #date put: '29 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000015 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.13';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.17';
	at: #version put: '0.16';
	at: #comment put: '0.16 : added announcer in TRCanvas. A view (and trachel canvas) can now be draggable';
	at: #date put: '31 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000016 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.14';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.18';
	at: #version put: '0.17';
	at: #comment put: '0.17 : working on event for labels. Added menus in TRCanvas. Worked on fixed and movable shapes. A bug is still there, about the encompassing shapeof a label';
	at: #date put: '31 December 2013';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000017 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.15';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.18';
	at: #version put: '0.18';
	at: #comment put: '0.18 : worked on the label translation. Added test. ';
	at: #date put: '1 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000018 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.16';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.19';
	at: #version put: '0.19';
	at: #comment put: '0.19 : added the punch card builder. Added some guards for the shapes to be drawn. Apparently Cairo behaves strangely if an error occurs durring the rendering loop.';
	at: #date put: '1 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000019 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.17';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.20';
	at: #version put: '0.20';
	at: #comment put: '0.20 : working on the font size';
	at: #date put: '1 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000020 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.18';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.20';
	at: #version put: '0.21';
	at: #comment put: '0.21 : added Viva in it';
	at: #date put: '1 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000021 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.18';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.21';
	at: #version put: '0.22';
	at: #comment put: '0.22 : started to work on the mondrian builder';
	at: #date put: '1 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000022 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.18';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.22';
	at: #version put: '0.23';
	at: #comment put: '0.23 : worked a bit on the mondrian builder';
	at: #date put: '2 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000023 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.18';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.23';
	at: #version put: '0.24';
	at: #comment put: '0.24 : worked on the mondrian builder';
	at: #date put: '3 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000024 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.19';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.24';
	at: #version put: '0.25';
	at: #comment put: '0.25 : worked on the border';
	at: #date put: '3 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000025 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.20';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.24';
	at: #version put: '0.26';
	at: #comment put: '0.26 : stroke width is now fixed';
	at: #date put: '3 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000026 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-TudorGirba.21';
	at: 'Roassal2' put: 'Roassal2-TudorGirba.27';
	at: #version put: '0.27';
	at: #comment put: '0.27 : integrated changes of Doru';
	at: #date put: '5 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000027 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-TudorGirba.21';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.28';
	at: #version put: '0.28';
	at: #comment put: '0.28 : delegation of encompassingRectangle';
	at: #date put: '5 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000028 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-TudorGirba.21';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.29';
	at: #version put: '0.29';
	at: #comment put: '0.29 : cleaning';
	at: #date put: '5 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000029 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.22';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.30';
	at: #version put: '0.30';
	at: #comment put: '0.30 : added xxElement: on the Roassal shapes. Added similarity matrix, however it has not been ported to Roassal2';
	at: #date put: '5 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000030 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.23';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.31';
	at: #version put: '0.31';
	at: #comment put: '0.31 : fixed bugs when dynamic removal of elements / shapes. Started to work on popup';
	at: #date put: '5 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000031 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.23';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.32';
	at: #version put: '0.32';
	at: #comment put: '0.32 : improved popup. But some bugs remain!';
	at: #date put: '5 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000032 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.23';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.33';
	at: #version put: '0.33';
	at: #comment put: '0.33 : bug related to the popup fixed';
	at: #date put: '5 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000033 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.23';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.34';
	at: #version put: '0.34';
	at: #comment put: '0.34 : added a small new builder about structural matrixes';
	at: #date put: '5 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000034 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.24';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.36';
	at: #version put: '0.35';
	at: #comment put: '0.35 : minor fixes. Removed dependencies with Roassal1';
	at: #date put: '6 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000035 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.25';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.37';
	at: #version put: '0.36';
	at: #comment put: '0.36 : added push back and front';
	at: #date put: '8 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000036 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.26';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.37';
	at: #version put: '0.37';
	at: #comment put: '0.37 : Added constraints';
	at: #date put: '8 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000037 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.27';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.38';
	at: #version put: '0.38';
	at: #comment put: '0.38 : added zoom in and out';
	at: #date put: '8 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000038 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.29';
	at: 'Roassal2' put: 'Roassal2-BenjaminVanRyseghem.39';
	at: #version put: '0.39';
	at: #comment put: '0.39 : integrated Ben changes. ';
	at: #date put: '9 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000039 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.30';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.40';
	at: #version put: '0.40';
	at: #comment put: '0.40 : added smooth translator. Added new examples about this';
	at: #date put: '9 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000040 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.30';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.41';
	at: #version put: '0.41';
	at: #comment put: '0.41 : example on zooming';
	at: #date put: '9 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000041 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.31';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.41';
	at: #version put: '0.42';
	at: #comment put: '0.42 : fix in TRConstraint';
	at: #date put: '9 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000042 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.32';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.41';
	at: #version put: '0.43';
	at: #comment put: '0.43 : removed odd dependency';
	at: #date put: '9 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000043 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.32';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.43';
	at: #version put: '0.44';
	at: #comment put: '0.44 : imported the punchcard builder, and fix bugs in the celllayout';
	at: #date put: '9 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000044 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.32';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.44';
	at: #version put: '0.45';
	at: #comment put: '0.45 : added cluster layout. Nice nice nice!';
	at: #date put: '9 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000045 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.33';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.45';
	at: #version put: '0.46';
	at: #comment put: '0.46 : Added BezierCurve. But some more work is still needed';
	at: #date put: '9 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000046 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.33';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.46';
	at: #version put: '0.47';
	at: #comment put: '0.47 : all tests are green. Worked a bit on the Mondrian';
	at: #date put: '10 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000047 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.34';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.47';
	at: #version put: '0.48';
	at: #comment put: '0.48 : added bezier curves';
	at: #date put: '11 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000048 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.35';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.48';
	at: #version put: '0.49';
	at: #comment put: '0.49 : added normalizers';
	at: #date put: '12 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000049 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.35';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.49';
	at: #version put: '0.50';
	at: #comment put: '0.50 : Introduces a ContrainedDraggableView (Thanks Ben!)';
	at: #date put: '12 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000050 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.35';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.50';
	at: #version put: '0.51';
	at: #comment put: '0.51 : fixing bugs related to normalizer';
	at: #date put: '12 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000051 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.36';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.50';
	at: #version put: '0.52';
	at: #comment put: '0.52 : minor bug in Trachel';
	at: #date put: '12 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000052 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.37';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.51';
	at: #version put: '0.53';
	at: #comment put: '0.53 : cleaning + fixed failing test';
	at: #date put: '12 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000053 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.37';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.52';
	at: #version put: '0.54';
	at: #comment put: '0.54 : added radial tree layout';
	at: #date put: '13 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000054 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.38';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.54';
	at: #version put: '0.55';
	at: #comment put: '0.55 : big changes. Added composed shapes. It seems to work relatively well. Labels can be embedded in a circle or rectangle. ';
	at: #date put: '14 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000055 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.38';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.55';
	at: #version put: '0.56';
	at: #comment put: '0.56 : worked on the dependency builder';
	at: #date put: '14 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000056 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.39';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.55';
	at: #version put: '0.57';
	at: #comment put: '0.57 : added left and right click support';
	at: #date put: '14 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000057 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.40';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.55';
	at: #version put: '0.58';
	at: #comment put: '0.58 : removing a composite shape';
	at: #date put: '14 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000058 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.40';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.56';
	at: #version put: '0.59';
	at: #comment put: '0.59 : added missing methods. Thanks Sergio!';
	at: #date put: '14 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000059 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.40';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.57';
	at: #version put: '0.60';
	at: #comment put: '0.60 : added horizontal tree layout';
	at: #date put: '15 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000060 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.41';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.58';
	at: #version put: '0.61';
	at: #comment put: '0.61 : Added popup. Removed RTGenericPopup. It is not necessary';
	at: #date put: '15 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000061 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.41';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.59';
	at: #version put: '0.62';
	at: #comment put: '0.62 : fixed a bug when the linear move';
	at: #date put: '16 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000062 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.42';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.59';
	at: #version put: '0.63';
	at: #comment put: '0.63 : translating a bezier shape';
	at: #date put: '16 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000063 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.43';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.61';
	at: #version put: '0.64';
	at: #comment put: '0.64 : worked on the constraint, added the vectorial edition example. Fixed bug in TRMorph...';
	at: #date put: '17 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000064 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.43';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.62';
	at: #version put: '0.65';
	at: #comment put: '0.65 : Added ifElement:fillColor: in the shape builder';
	at: #date put: '17 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000065 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.44';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.63';
	at: #version put: '0.66';
	at: #comment put: '0.66 : first try to rotated text';
	at: #date put: '17 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000066 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.45';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.63';
	at: #version put: '0.67';
	at: #comment put: '0.67 : added examples for the rotated text';
	at: #date put: '17 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000067 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.45';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.64';
	at: #version put: '0.68';
	at: #comment put: '0.68 : small update in withText. thanks to Sergio Maass  for this!';
	at: #date put: '17 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000068 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.45';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.65';
	at: #version put: '0.69';
	at: #comment put: '0.69 : worked a bit on the mondrian builder';
	at: #date put: '18 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000069 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.46';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.66';
	at: #version put: '0.70';
	at: #comment put: '0.70 : worked on drawing border. Much nicer now!';
	at: #date put: '18 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000070 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.47';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.67';
	at: #version put: '0.71';
	at: #comment put: '0.71 : worked on the mondrian builder';
	at: #date put: '19 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000071 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.48';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.68';
	at: #version put: '0.72';
	at: #comment put: '0.72 : worked on the Mondrian builder';
	at: #date put: '19 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000072 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-JurajKubelka.49';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.69';
	at: #version put: '0.73';
	at: #comment put: '0.73 : Rotated label shape. finally!';
	at: #date put: '21 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000073 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.50';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.70';
	at: #version put: '0.74';
	at: #comment put: '0.74 : an element has always a tr shape. Tests are now all green';
	at: #date put: '21 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000074 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.51';
	at: 'Roassal2' put: 'Roassal2-RicardoJacas.72';
	at: #version put: '0.75';
	at: #comment put: '0.75 : added a canvas and a #isInACanvas';
	at: #date put: '22 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000075 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.51';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.73';
	at: #version put: '0.76';
	at: #comment put: '0.76 : added the forcebased layout algorihtm, and an animation stepper!!';
	at: #date put: '22 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000076 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.52';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.74';
	at: #version put: '0.77';
	at: #comment put: '0.77 : cleaning...';
	at: #date put: '22 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000077 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.52';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.75';
	at: #version put: '0.78';
	at: #comment put: '0.78 : worked on some examples using the spring layout';
	at: #date put: '22 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000078 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.52';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.76';
	at: #version put: '0.79';
	at: #comment put: '0.79 : changed elementFromModel:';
	at: #date put: '22 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000079 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.52';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.77';
	at: #version put: '0.80';
	at: #comment put: '0.80 : bug in RTQuadTree fixed';
	at: #date put: '22 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000080 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.52';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.78';
	at: #version put: '0.81';
	at: #comment put: '0.81 : minor fix';
	at: #date put: '22 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000081 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.53';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.79';
	at: #version put: '0.82';
	at: #comment put: '0.82 : worked on the trachel translation of composite shapes';
	at: #date put: '23 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000082 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.53';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.80';
	at: #version put: '0.83';
	at: #comment put: '0.83 : bug in the layout fixed. Pair programmed with Juraj';
	at: #date put: '23 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000083 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.54';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.80';
	at: #version put: '0.84';
	at: #comment put: '0.84 : changing the width and the height of a trachel shape';
	at: #date put: '23 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000084 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.54';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.81';
	at: #version put: '0.85';
	at: #comment put: '0.85 : all the tests are green';
	at: #date put: '23 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000085 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.56';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.85';
	at: #version put: '0.86';
	at: #comment put: '0.86 : merged from Juraj s work';
	at: #date put: '23 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000086 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.56';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.86';
	at: #version put: '0.87';
	at: #comment put: '0.87 : fixing a test';
	at: #date put: '23 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000087 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.57';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.87';
	at: #version put: '0.88';
	at: #comment put: '0.88 : removed a wrong dependency';
	at: #date put: '23 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000088 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.57';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.88';
	at: #version put: '0.89';
	at: #comment put: '0.89 : minor fix';
	at: #date put: '23 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000089 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.58';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.89';
	at: #version put: '0.90';
	at: #comment put: '0.90 : added arcs, made by Samir Samir Saleh. Excellent work!';
	at: #date put: '25 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000090 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.58';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.90';
	at: #version put: '0.91';
	at: #comment put: '0.91 : added small examples and fix';
	at: #date put: '27 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000091 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-JurajKubelka.61';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.97';
	at: #version put: '0.92';
	at: #comment put: '0.92 : added on:do:';
	at: #date put: '27 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000092 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-JurajKubelka.61';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.98';
	at: #version put: '0.93';
	at: #comment put: '0.93 : bug fixed related to the popup with a group';
	at: #date put: '27 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000093 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.63';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.100';
	at: #version put: '0.94';
	at: #comment put: '0.94 : merged with Juraj extension of the text builder. Added a new animation (resize). fixed bug ';
	at: #date put: '28 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000094 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.63';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.101';
	at: #version put: '0.95';
	at: #comment put: '0.95 : added explora';
	at: #date put: '28 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000095 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.64';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.102';
	at: #version put: '0.96';
	at: #comment put: '0.96 : removed the position variable from RTElement';
	at: #date put: '28 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000096 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.65';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.104';
	at: #version put: '0.97';
	at: #comment put: '0.97 : added SVG shapes';
	at: #date put: '28 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000097 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.66';
	at: 'Roassal2' put: 'Roassal2-JurajKubelka.108';
	at: #version put: '0.98';
	at: #comment put: '0.98 : fixed bug in Roassal2 and Trachel, for the SVG';
	at: #date put: '29 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000098 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.66';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.110';
	at: #version put: '0.99';
	at: #comment put: '0.99 : Dowser is working well! All the tests are green';
	at: #date put: '29 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000099 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.66';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.111';
	at: #version put: '0.100';
	at: #comment put: '0.100 : minor cleaning';
	at: #date put: '30 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000100 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.67';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.111';
	at: #version put: '0.101';
	at: #comment put: '0.101 : added a constraint';
	at: #date put: '30 January 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000101 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.67';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.112';
	at: #version put: '0.102';
	at: #comment put: '0.102 : worked a bit on Mondrian';
	at: #date put: '3 February 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000102 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.67';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.115';
	at: #version put: '0.103';
	at: #comment put: '0.103 : adding Sunburst';
	at: #date put: '3 February 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000103 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.67';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.116';
	at: #version put: '0.104';
	at: #comment put: '0.104 : integrated Map';
	at: #date put: '3 February 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000104 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.68';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.117';
	at: #version put: '0.105';
	at: #comment put: '0.105 : cleaning, refactoring';
	at: #date put: '7 February 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000105 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.69';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.118';
	at: #version put: '0.106';
	at: #comment put: '0.106 : making Arc animated!! Cool stuff!';
	at: #date put: '10 February 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000106 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.70';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.119';
	at: #version put: '0.107';
	at: #comment put: '0.107 : Added a small example in Trachel, about animated argc';
	at: #date put: '10 February 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000107 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.71';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.120';
	at: #version put: '0.108';
	at: #comment put: '0.108 : worked a bit on the Mondrian builder';
	at: #date put: '13 February 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000108 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.72';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.122';
	at: #version put: '0.109';
	at: #comment put: '0.109 : Working on the normalizer, and making Trachel compatible with Amber';
	at: #date put: '26 February 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000109 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.75';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.122';
	at: #version put: '0.110';
	at: #comment put: '0.110 : merged with Doru version';
	at: #date put: '26 February 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000110 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.76';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.122';
	at: #version put: '0.111';
	at: #comment put: '0.111 : added a comment in TRTest>>readme to export Trachel to Amber';
	at: #date put: '26 February 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000111 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.76';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.124';
	at: #version put: '0.112';
	at: #comment put: '0.112 : added utility method in CityBuilder, in the map category';
	at: #date put: '2 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000112 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.76';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.126';
	at: #version put: '0.113';
	at: #comment put: '0.113 : added color utility, and incorporated Doru and Juraj improvements';
	at: #date put: '2 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000113 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.76';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.127';
	at: #version put: '0.114';
	at: #comment put: '0.114 : added an example in the MapBuilder that uses DBPedia';
	at: #date put: '2 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000114 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.76';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.128';
	at: #version put: '0.115';
	at: #comment put: '0.115 : added an example about universities using DBPedia';
	at: #date put: '3 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000115 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.76';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.129';
	at: #version put: '0.116 : Fix comments for exporting to Amber';
	at: #comment put: '0.116 : Fix comments for exporting to Amber';
	at: #date put: '3 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000116 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.76';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.130';
	at: #version put: '0.117';
	at: #comment put: '0.117 : Minor fix in the comment to export to Amber';
	at: #date put: '4 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000117 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.81';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.137';
	at: #version put: '0.118';
	at: #comment put: '0.118 : 0.118 : Roassal2-JurajKubelka.136
- It adds RTInteractionBuilder>>menu

Roassal2-SergioMaass.135
- Small refactoring: passed some responsibility from Roassal to Trachel

Roassal2-JurajKubelka.133:
- Refactoring: now TRSVGPath does the parsing of the SVG instead of RTSVGPath.
- Added RTShapedObject>>updateShape for updating a shaped object''s trachelShape, and modified RTBezierLine and RTAbstractLine for them to update their width and color when reconstructing their trachel shape.
- Added a few tests.

Roassal2-JurajKubelka.133 : It adds RTMenuActivable

Trachel-SergioMaass.80
- Small refactoring: passed some responsibility from Roassal to Trachel

Trachel-SergioMaass.79
- Refactoring: now TRSVGPath does the parsing of the SVG instead of RTSVGPath.
- Added the possibility of changing line''s and bezier''s width

Trachel-JurajKubelka.78: It adds TRUtil and TRMorphWidgetFactory.
 Trachel-JurajKubelka.77: It adds TRComposedShape>>resetPath.';
	at: #date put: '11 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000118 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.82';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.138';
	at: #version put: '0.119';
	at: #comment put: '0.119 : added RTBoundedShapeBuilder and updated RTMondrianViewBuilder.';
	at: #date put: '17 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000119 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-RicardoJacas.83';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.141';
	at: #version put: '0.120';
	at: #comment put: '0.120 : added an improvement in the shape builder. Make it specific for Mondrian';
	at: #date put: '17 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000120 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-RicardoJacas.83';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.142';
	at: #version put: '0.121';
	at: #comment put: '0.121 : improvement in the SVGExporter';
	at: #date put: '17 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000121 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-RicardoJacas.83';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.150';
	at: #version put: '0.122';
	at: #comment put: '0.122 : added a comment inRTPopup>>group:';
	at: #date put: '19 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000122 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-RicardoJacas.83';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.152';
	at: #version put: '0.123';
	at: #comment put: '0.123 : added an example with popup with background + merged with Ricardo code';
	at: #date put: '21 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000123 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-RicardoJacas.83';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.153';
	at: #version put: '0.124';
	at: #comment put: '0.124 : worked a bit on the mondrian builder';
	at: #date put: '22 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000124 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-RicardoJacas.83';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.154';
	at: #version put: '0.125';
	at: #comment put: '0.125 : fix with max:in:';
	at: #date put: '22 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000125 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.84';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.155';
	at: #version put: '0.126';
	at: #comment put: '0.126 : added the color wave example';
	at: #date put: '22 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000126 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.85';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.156';
	at: #version put: '0.127';
	at: #comment put: '0.127 : bug with gridLayout fixed. The space between elements is constant now';
	at: #date put: '23 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000127 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.85';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.157';
	at: #version put: '0.128';
	at: #comment put: '0.128 : added more examples. cleaned a bit';
	at: #date put: '23 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000128 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.85';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.158';
	at: #version put: '0.129';
	at: #comment put: '0.129 : improved a bit the example of the HTMLExporter';
	at: #date put: '24 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000129 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.85';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.160';
	at: #version put: '0.130';
	at: #comment put: '0.130 : Including Ricardos work. Worked a bit on the example';
	at: #date put: '24 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000130 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.86';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.160';
	at: #version put: '0.131';
	at: #comment put: '0.131 : Minor update in Trachel. The extent of a canvas happens to be made of Float sometimes. This is now fixed';
	at: #date put: '24 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000131 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.86';
	at: 'Roassal2' put: 'Roassal2-RicardoJacas.163';
	at: #version put: '0.132';
	at: #comment put: '0.132 : lastest improvemement with the HTML exporter';
	at: #date put: '24 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000132 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.87';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.164';
	at: #version put: '0.133';
	at: #comment put: '0.133 : fixed the Mondrian shape builder for edges';
	at: #date put: '27 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000133 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.88';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.165';
	at: #version put: '0.134';
	at: #comment put: '0.134 : started to work on GraphBuilder';
	at: #date put: '28 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000134 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.88';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.166';
	at: #version put: '0.135';
	at: #comment put: '0.135 : a bit more on the graph builder';
	at: #date put: '28 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000135 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.88';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.167';
	at: #version put: '0.136';
	at: #comment put: '0.136 : worked a lot on the map builder. Added MetricMap';
	at: #date put: '30 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000136 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.88';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.168';
	at: #version put: '0.137';
	at: #comment put: '0.137 : adding a utility method in the MetricMap';
	at: #date put: '30 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000137 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.88';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.169';
	at: #version put: '0.138';
	at: #comment put: '0.138 : added a new example, growth and development bridge index';
	at: #date put: '30 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000138 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.89';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.170';
	at: #version put: '0.139';
	at: #comment put: '0.139 : Started to work on a read eval loop for Roassal. Improved the example of the map builder';
	at: #date put: '30 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000139 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.89';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.171';
	at: #version put: '0.140';
	at: #comment put: '0.140 : added exampleWithMetricMap in RTHTMLExporterExample';
	at: #date put: '31 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000140 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.90';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.171';
	at: #version put: '0.141';
	at: #comment put: '0.141 : worked on the composed shape in trachel. Usman found a bug';
	at: #date put: '31 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000141 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.91';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.172';
	at: #version put: '0.142';
	at: #comment put: '0.142 : fixed an important bug about scaling and the camera. Thanks To Ronie about this!';
	at: #date put: '31 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000142 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-FaviolaMolina.92';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.175';
	at: #version put: '0.143';
	at: #comment put: '0.143 : Improvement of the GraphBuilder';
	at: #date put: '31 March 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000143 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.93';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.176';
	at: #version put: '0.144';
	at: #comment put: '0.144 : work on the graph builder + a minor class renaming';
	at: #date put: '1 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000144 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.94';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.181';
	at: #version put: '0.145';
	at: #comment put: '0.145 : worked on a legend builder';
	at: #date put: '2 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000145 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.95';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.181';
	at: #version put: '0.146';
	at: #comment put: '0.146 : improved the stroke width for circles';
	at: #date put: '2 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000146 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.96';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.182';
	at: #version put: '0.147';
	at: #comment put: '0.147 : minor fix';
	at: #date put: '2 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000147 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.97';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.182';
	at: #version put: '0.148';
	at: #comment put: '0.148 : moved bitmap directlly into AstroCloud';
	at: #date put: '2 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000148 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.97';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.183';
	at: #version put: '0.149';
	at: #comment put: '0.149 : started to work on a menu builder';
	at: #date put: '2 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000149 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.97';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.184';
	at: #version put: '0.150';
	at: #comment put: '0.150 : added flow layout. Worked a bit on the graph builder. Added zoom buttons per default';
	at: #date put: '4 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000150 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.98';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.185';
	at: #version put: '0.151';
	at: #comment put: '0.151 : worked on the zooming and drag-and-dropping';
	at: #date put: '4 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000151 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.98';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.186';
	at: #version put: '0.152';
	at: #comment put: '0.152 : pushing the edges behind nodes';
	at: #date put: '5 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000152 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.98';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.187';
	at: #version put: '0.153';
	at: #comment put: '0.153 : worked on the highlight';
	at: #date put: '6 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000153 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.99';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.188';
	at: #version put: '0.154';
	at: #comment put: '0.154 : Issue 393:	Composed shape and highlighting is not working';
	at: #date put: '7 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000154 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.99';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.189';
	at: #version put: '0.155';
	at: #comment put: '0.155 : worked on the graph builder and the ShowEdges interaction. Works well ;-)';
	at: #date put: '7 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000155 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.100';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.190';
	at: #version put: '0.156';
	at: #comment put: '0.156  : worked on the graph builder';
	at: #date put: '7 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000156 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.101';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.191';
	at: #version put: '0.157';
	at: #comment put: '0.157 : more work on the graph builder, plus a missimg method in RTEdge';
	at: #date put: '7 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000157 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.101';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.192';
	at: #version put: '0.158';
	at: #comment put: '0.158 : added examples about dynamic edges, including with curvy edges. Cleaned a bit the code of RTShowEdge';
	at: #date put: '8 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000158 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.101';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.193';
	at: #version put: '0.159';
	at: #comment put: '0.159 : minor cleaning';
	at: #date put: '8 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000159 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.101';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.194';
	at: #version put: '0.160';
	at: #comment put: '0.160 : added example about the camera control';
	at: #date put: '8 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000160 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-RicardoJacas.102';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.195';
	at: #version put: '0.161';
	at: #comment put: '0.161 : Merged with Name: Trachel-RicardoJacas.102
Author: RicardoJacas
Time: 7 April 2014, 4:45:35.764509 pm
UUID: 4468e43f-f42d-9c40-9f44-d028992d5711
Ancestors: Trachel-JurajKubelka.101, Trachel-AlexandreBergel.101

Added ArrowedLine';
	at: #date put: '8 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000161 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-JurajKubelka.113';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.204';
	at: #version put: '0.162';
	at: #comment put: '0.162 : worked a lot on the builder';
	at: #date put: '9 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000162 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-JurajKubelka.113';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.205';
	at: #version put: '0.163';
	at: #comment put: '0.163 : worked on the graph builder';
	at: #date put: '9 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000163 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-JurajKubelka.115';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.207';
	at: #version put: '0.164';
	at: #comment put: '0.164 : improvement of Juraj, plus addition of bitmap support and many more';
	at: #date put: '10 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000164 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-JurajKubelka.115';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.208';
	at: #version put: '0.165';
	at: #comment put: '0.165 : added small examples on directed edges';
	at: #date put: '10 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000165 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-FaviolaMolina.116';
	at: 'Roassal2' put: 'Roassal2-FaviolaMolina.208';
	at: #version put: '0.166';
	at: #comment put: '0.166 : merged with Ricardo. Added the bitmap support. No idea why it was not added before';
	at: #date put: '10 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000166 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-FaviolaMolina.116';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.209';
	at: #version put: '0.167';
	at: #comment put: '0.167 : bitmap support, again and again...';
	at: #date put: '10 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000167 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-FaviolaMolina.116';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.210';
	at: #version put: '0.168';
	at: #comment put: '0.168 : worked on the graph builder';
	at: #date put: '11 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000168 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-FaviolaMolina.116';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.211';
	at: #version put: '0.169';
	at: #comment put: '0.169 : worked on the graph builder';
	at: #date put: '11 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000169 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-azazael.119';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.212';
	at: #version put: '0.170';
	at: #comment put: '0.170 : merged with various contribution from Ricardo, Milton and Juraj';
	at: #date put: '14 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000170 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.120';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.213';
	at: #version put: '0.171';
	at: #comment put: '0.171 : started to work on the example browser';
	at: #date put: '14 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000171 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.120';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.214';
	at: #version put: '0.172';
	at: #comment put: '0.172 : Merging';
	at: #date put: '14 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000172 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.120';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.216';
	at: #version put: '0.173';
	at: #comment put: '0.173 : added flow layouts. merged with Ricardo version';
	at: #date put: '14 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000173 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.120';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.218';
	at: #version put: '0.174';
	at: #comment put: '0.174';
	at: #date put: '14 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000174 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.120';
	at: 'Roassal2' put: 'Roassal2-TudorGirba.220';
	at: #version put: '0.175';
	at: #comment put: '0.175 : fix from Uko and Doru';
	at: #date put: '15 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000175 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.120';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.221';
	at: #version put: '0.176';
	at: #comment put: '0.176 : added grouped drag and drop (RTDraggableTest)';
	at: #date put: '15 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000176 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-JurajKubelka.122';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.229';
	at: #version put: '0.177';
	at: #comment put: '0.177 : worked on the nesting. Thanks to Leo!';
	at: #date put: '15 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000177 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-JurajKubelka.123';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.233';
	at: #version put: '0.178';
	at: #comment put: '0.178 : improvement of the bezier lines. Merged with improvment of Pablo Ricardo and Juraj';
	at: #date put: '16 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000178 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.124';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.234';
	at: #version put: '0.179';
	at: #comment put: '0.179 : Fixed a bug with the bitmap in Trachel, and added many many examples. Cool!';
	at: #date put: '16 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000179 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.125';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.234';
	at: #version put: '0.180';
	at: #comment put: '0.180 : speeded up the bitmap rendering';
	at: #date put: '16 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000180 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.127';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.242';
	at: #version put: '0.181';
	at: #comment put: '0.181 : more example added, improvememtn of the graph builder. ';
	at: #date put: '18 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000181 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.127';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.243';
	at: #version put: '0.182';
	at: #comment put: '0.182 : nodes may be labelled in the graph builder';
	at: #date put: '18 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000182 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.127';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.244';
	at: #version put: '0.183';
	at: #comment put: '0.183 : worked on the animated scatter plot builder. Cool stuff!';
	at: #date put: '19 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000183 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.127';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.245';
	at: #version put: '0.184';
	at: #comment put: '0.184 : worked on the animated scatter plot';
	at: #date put: '19 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000184 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.127';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.246';
	at: #version put: '0.185';
	at: #comment put: '0.185 : added condition for edges. Works well! Yupi!';
	at: #date put: '20 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000185 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.127';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.247';
	at: #version put: '0.186';
	at: #comment put: '0.186 : worked on the directed shape and the graph builder';
	at: #date put: '20 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000186 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.127';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.248';
	at: #version put: '0.187';
	at: #comment put: '0.187 : Added RTLabelled. Useful to label things';
	at: #date put: '20 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000187 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.127';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.249';
	at: #version put: '0.188';
	at: #comment put: '0.188 : Worked on a small example and cleaned a bit RTLabelled';
	at: #date put: '20 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000188 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.127';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.249';
	at: #version put: '0.188';
	at: #comment put: '0.188';
	at: #date put: '20 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000189 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.127';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.250';
	at: #version put: '0.189';
	at: #comment put: '0.189 : added new Roassal example ';
	at: #date put: '20 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000190 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.127';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.251';
	at: #version put: '0.190';
	at: #comment put: '0.190 : added the dot index example';
	at: #date put: '21 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000191 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.127';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.252';
	at: #version put: '0.191';
	at: #comment put: '0.191 : worked on the examples generation';
	at: #date put: '21 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000192 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.128';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.253';
	at: #version put: '0.192';
	at: #comment put: '0.192 : added small methods in the node element of the graph builder';
	at: #date put: '21 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000193 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.128';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.255';
	at: #version put: '0.193';
	at: #comment put: '0.193 : worked on the RTLabelled interaction';
	at: #date put: '21 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000194 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.129';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.255';
	at: #version put: '0.194';
	at: #comment put: '0.194 : bug fixed, spotted by Leo:   with the new interaction RTLabelled, I have played with it to integrate in my work and I have found a little bug.

| view box els |
view := RTView new.
box := RTBox new element.
els := (RTEllipse new color: Color red) elementsOn: (1 to: 30).
view add: box; addAll: els.

box @ RTDraggable.
box @ (RTLabelled new text: ''Container'').

RTNest new layout: RTGridLayout; on: box nest: els.

view open

The label is not at the right place. If you move the box it will move to its place.
But if you add the interaction RTLabelled after the nest everything is ok.
';
	at: #date put: '22 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000195 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.129';
	at: 'Roassal2' put: 'Roassal2-PabloEstefo.256';
	at: #version put: '0.195';
	at: #comment put: '0.195 : Improvement by Pablo on RTLabelling. Thanks!';
	at: #date put: '22 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000196 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.130';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.257';
	at: #version put: '0.196';
	at: #comment put: '0.196 : pair programmed with Juraj on the animations. A small intent is being done with RTCompositeShape and offsets';
	at: #date put: '23 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000197 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.131';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.258';
	at: #version put: '0.197';
	at: #comment put: '0.197 : Minor fix in the RTExampleBrowser. Fixed a bug with pushBack and pushFront on composite trachel shapes, discovered by Johan Fabry';
	at: #date put: '23 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000198 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.131';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.259';
	at: #version put: '0.198';
	at: #comment put: '0.198 : bug: RTEdge class>>on:from:to: produces a MNU';
	at: #date put: '23 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000199 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.131';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.260';
	at: #version put: '0.199';
	at: #comment put: '0.199 : Cleaning a bit the layouts. And fixed a bug in the force based layout';
	at: #date put: '23 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000200 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.131';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.261';
	at: #version put: '0.200';
	at: #comment put: '0.200 : added examples in the graph builder';
	at: #date put: '23 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000201 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.132';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.263';
	at: #version put: '0.201';
	at: #comment put: '0.201 : included composition shapes!! Added TRExtensibleLabelShape. moved distinctTenLightColors and distinctTenStrongColors to Roassal because these should be typical color schemes to be used in visualizations.';
	at: #date put: '24 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000202 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.132';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.264';
	at: #version put: '0.202';
	at: #comment put: '0.202 : RTElement and RTEdge can now be fixed';
	at: #date put: '24 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000203 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.132';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.265';
	at: #version put: '0.203';
	at: #comment put: '0.203 : added example for an horizontal bezier line';
	at: #date put: '24 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000204 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.132';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.266';
	at: #version put: '0.204';
	at: #comment put: '0.204 : added RTExtensibleLabel';
	at: #date put: '24 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000205 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.132';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.268';
	at: #version put: '0.205';
	at: #comment put: '0.205 : worked on the graph builder. Integrated Pablo changes';
	at: #date put: '25 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000206 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.132';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.269';
	at: #version put: '0.206';
	at: #comment put: '0.206 : added examples using color palette and the graph builder';
	at: #date put: '25 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000207 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.132';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.270';
	at: #version put: '0.207';
	at: #comment put: '0.207 : one yellow test, ups!';
	at: #date put: '25 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000208 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.132';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.274';
	at: #version put: '0.208';
	at: #comment put: '0.208 : Merged with Pablo and Doru version. Improvement of the ColorPalette for GTInspector.';
	at: #date put: '25 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000209 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.133';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.275';
	at: #version put: '0.209';
	at: #comment put: '0.209 : labels on an edge are now nicer. They are a bit closer to the extremities';
	at: #date put: '25 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000210 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.134';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.276';
	at: #version put: '0.210';
	at: #comment put: '0.210 : two changes: (i) composite in Roassal do not change the size of the shapes, except for RTCompositeShape, Verticical and horizontal keep the size of the shape as it is. (ii) added a time builder. It simply allow for vertical bars to be dynamically added. Cool stuff :-)';
	at: #date put: '27 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000211 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.134';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.277';
	at: #version put: '0.211';
	at: #comment put: '0.211 : fixed a test in RTShapeTest. Worked a bit more on the RTTimeLineBuilder';
	at: #date put: '27 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000212 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.134';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.278';
	at: #version put: '0.212';
	at: #comment put: '0.212 : moving a small method in the composite shapes';
	at: #date put: '27 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000213 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.134';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.279';
	at: #version put: '0.213';
	at: #comment put: '0.213 : added directedLine on the shape builder';
	at: #date put: '28 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000214 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.134';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.280';
	at: #version put: '0.214';
	at: #comment put: '0.214 : added a #offsetOnEdge: to RTLabelled.
The method takes as argument a float, between 0.0 and 1.0. 
1.0 means it is on the starting extremity. 
0.0 means it is on the ending extremity.';
	at: #date put: '28 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000215 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.134';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.281';
	at: #version put: '0.215';
	at: #comment put: '0.215 : added utility methods in RTLinearMove. Added new example in RTRoassalExample. Started to work on a RTVerticalBagCompositeShape. But thisis not ready yet...';
	at: #date put: '28 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000216 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.135';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.282';
	at: #version put: '0.216';
	at: #comment put: '0.216 : merged with Pablo version. added TRCompositeShape>>canvas ';
	at: #date put: '29 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000217 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.136';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.283';
	at: #version put: '0.217';
	at: #comment put: '0.217 : minor version';
	at: #date put: '29 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000218 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.136';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.284';
	at: #version put: '0.218';
	at: #comment put: '0.218 : fixed the test de ColorPaletteTest. Added a new class RTTableTableData with some example';
	at: #date put: '29 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000219 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.136';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.286';
	at: #version put: '0.219';
	at: #comment put: '0.219 : inserted singleton for the attachpoint';
	at: #date put: '30 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000220 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.137';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.287';
	at: #version put: '0.220';
	at: #comment put: '0.220 : added tests that identify a bug (tests are yellow) + set the background in trachel as white, instead of being transparent';
	at: #date put: '30 April 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000221 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.138';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.288';
	at: #version put: '0.221';
	at: #comment put: '0.221 : fixed the problem identified by Leo about composite shapes and line attachment';
	at: #date put: '1 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000222 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.139';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.289';
	at: #version put: '0.222';
	at: #comment put: '0.222 : fixed problem with the double callback registration with nesting on composite shape (c.f., #testNesting). Thanks Leo for having spotted it!';
	at: #date put: '1 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000223 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.139';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.290';
	at: #version put: '0.223';
	at: #comment put: '0.223 : work on the graph builder';
	at: #date put: '2 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000224 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.139';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.291';
	at: #version put: '0.224';
	at: #comment put: '0.224 : added new example and cleaned a bit the graph builder';
	at: #date put: '2 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000225 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.140';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.292';
	at: #version put: '0.225';
	at: #comment put: '0.225 : fixed bug identified by Johan Fabry and merged with Pablo Estefo version';
	at: #date put: '3 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000226 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.141';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.294';
	at: #version put: '0.226';
	at: #comment put: '0.226 : worked on the partitioning of the graph builder and added new examples';
	at: #date put: '5 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000227 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.141';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.295';
	at: #version put: '0.227';
	at: #comment put: '0.227 : added RTColorCycle';
	at: #date put: '8 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000228 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.141';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.296';
	at: #version put: '0.228';
	at: #comment put: '0.228 : improvement of the spring layout, to meet Johan requirements';
	at: #date put: '8 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000229 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.141';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.297';
	at: #version put: '0.229';
	at: #comment put: '0.229 : worked a lot on AnimatedScatterPlot. Improve RTTablTable and RTEdge builder';
	at: #date put: '10 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000230 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.141';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.298';
	at: #version put: '0.230';
	at: #comment put: '0.230 : Worked on the spectrograph. Cool stuff!!';
	at: #date put: '11 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000231 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.141';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.299';
	at: #version put: '0.231';
	at: #comment put: '0.231 : More example on the spectrograph';
	at: #date put: '11 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000232 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.141';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.300';
	at: #version put: '0.232';
	at: #comment put: '0.232 : added an entry for the stectograph in the example browser';
	at: #date put: '11 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000233 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.141';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.301';
	at: #version put: '0.233';
	at: #comment put: '0.233 : RTLabel now handles multi-lines txt! Yupi!';
	at: #date put: '15 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000234 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.143';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.311';
	at: #version put: '0.234';
	at: #comment put: '0.234 : merge with many versions. Several improvement';
	at: #date put: '15 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000235 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.144';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.312';
	at: #version put: '0.235';
	at: #comment put: '0.235 : worked a bit on the composite shape';
	at: #date put: '15 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000236 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.144';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.313';
	at: #version put: '0.236';
	at: #comment put: '0.236 : added alignment for the flow layout';
	at: #date put: '16 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000237 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.144';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.314';
	at: #version put: '0.237';
	at: #comment put: '0.237 : More work on the flow layout';
	at: #date put: '16 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000238 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.144';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.317';
	at: #version put: '0.238';
	at: #comment put: '0.238 : added #seed: in the edge builder for the graph builder. Merged with Doru version as well';
	at: #date put: '19 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000239 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.144';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.318';
	at: #version put: '0.239';
	at: #comment put: '0.239 : improved the example browser';
	at: #date put: '19 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000240 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.144';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.319';
	at: #version put: '0.240';
	at: #comment put: '0.240 : added #seed: for nodes as well';
	at: #date put: '20 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000241 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.144';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.320';
	at: #version put: '0.241';
	at: #comment put: '0.241 : Worked on the graphBuilder. Bug fixed with the seed';
	at: #date put: '20 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000242 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.144';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.321';
	at: #version put: '0.242';
	at: #comment put: '0.242 : added a new graph example';
	at: #date put: '20 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000243 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.144';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.322';
	at: #version put: '0.243';
	at: #comment put: '0.243 : started to work on the pharo code analyzer';
	at: #date put: '20 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000244 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.144';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.323';
	at: #version put: '0.244';
	at: #comment put: '0.244 : added layout menu';
	at: #date put: '20 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000245 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.145';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.324';
	at: #version put: '0.245';
	at: #comment put: '0.245 : worked a bit more on the data studio';
	at: #date put: '21 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000246 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.145';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.325';
	at: #version put: '0.246';
	at: #comment put: '0.246 : added a new layout animation and an example';
	at: #date put: '21 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000247 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.145';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.326';
	at: #version put: '0.247';
	at: #comment put: '0.247 : minor recategorization';
	at: #date put: '21 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000248 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.145';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.327';
	at: #version put: '0.248';
	at: #comment put: '0.248 : fix in RTIdentityMatrix';
	at: #date put: '21 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000249 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.145';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.328';
	at: #version put: '0.249';
	at: #comment put: '0.249 : changed ROSortBlock into RTSortBlock';
	at: #date put: '21 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000250 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.145';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.329';
	at: #version put: '0.250';
	at: #comment put: '0.250 : More work on the data studio';
	at: #date put: '21 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000251 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.145';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.330';
	at: #version put: '0.251';
	at: #comment put: '0.251 : Started to work on DataStudio and SmallBrowser';
	at: #date put: '22 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000252 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.145';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.331';
	at: #version put: '0.252';
	at: #comment put: '0.252 : Renamed Small Browser into Smart Browser';
	at: #date put: '22 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000253 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.145';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.332';
	at: #version put: '0.253';
	at: #comment put: '0.253 : More work on the smart browser';
	at: #date put: '22 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000254 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.145';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.333';
	at: #version put: '0.254';
	at: #comment put: '0.254 : worked on the smart browser';
	at: #date put: '22 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000255 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.145';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.334';
	at: #version put: '0.255';
	at: #comment put: '0.255 : minor fix';
	at: #date put: '22 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000256 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.145';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.335';
	at: #version put: '0.256';
	at: #comment put: '0.256 : Added missing metrics';
	at: #date put: '23 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000257 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.146';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.335';
	at: #version put: '0.257';
	at: #comment put: '0.257 : update in Trachel by Sergio';
	at: #date put: '23 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000258 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.146';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.336';
	at: #version put: '0.258';
	at: #comment put: '0.258 : More worked on the smart browser. It is now becoming usable :-) Yupi!';
	at: #date put: '23 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000259 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.146';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.337';
	at: #version put: '0.259';
	at: #comment put: '0.259 : Added number of lines of code';
	at: #date put: '23 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000260 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.146';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.338';
	at: #version put: '0.260';
	at: #comment put: '0.260 : added missing methods on SequenceableCollection';
	at: #date put: '23 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000261 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.147';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.338';
	at: #version put: '0.261';
	at: #comment put: '0.261 : fix a strange problem that happens time to time';
	at: #date put: '23 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000262 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.147';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.339';
	at: #version put: '0.262';
	at: #comment put: '0.262 : a bit more work on the smart browser';
	at: #date put: '23 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000263 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.147';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.340';
	at: #version put: '0.263';
	at: #comment put: '0.263 : added  RTMultiLinearColorCached';
	at: #date put: '28 May 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000264 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.147';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.346';
	at: #version put: '0.264';
	at: #comment put: '0.264 : improved Code Analyzer (in data studio) by implementing the missing methods';
	at: #date put: '4 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000265 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-YuriyTymchuk.148';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.348';
	at: #version put: '0.265';
	at: #comment put: '0.265 : mouse wheel by Yuriy!!! Excellent work!';
	at: #date put: '6 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000266 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.149';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.349';
	at: #version put: '0.266';
	at: #comment put: '0.266 : added RTArrow. Cool!';
	at: #date put: '6 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000267 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.149';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.350';
	at: #version put: '0.267';
	at: #comment put: '0.267 : improved the arrow';
	at: #date put: '6 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000268 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.149';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.351';
	at: #version put: '0.268';
	at: #comment put: '0.268 : added a new example';
	at: #date put: '6 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000269 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.150';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.352';
	at: #version put: '0.269';
	at: #comment put: '0.269 : removed expectedFailures, Maybe this will generate some problems. Added RTView>>openRaw, thanks Yuriy for the suggestion';
	at: #date put: '7 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000270 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.150';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.353';
	at: #version put: '0.270';
	at: #comment put: '0.270 : added a small test about the camera projection';
	at: #date put: '8 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000271 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.150';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.354';
	at: #version put: '0.271';
	at: #comment put: '0.271 : added example on arrowed lines with offset';
	at: #date put: '8 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000272 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.151';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.355';
	at: #version put: '0.272';
	at: #comment put: '0.272 : bug fixed for the clean  function';
	at: #date put: '8 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000273 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-YuriyTymchuk.153';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.356';
	at: #version put: '0.273';
	at: #comment put: '0.273 : improved the force based layout to be dynamically updated. Works well! Example have been added';
	at: #date put: '10 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000274 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.154';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.357';
	at: #version put: '0.274';
	at: #comment put: '0.274 : fixing popup text with multiline. Wow! It was highly necessary! Now it works okay :-)';
	at: #date put: '11 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000275 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.154';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.358';
	at: #version put: '0.275';
	at: #comment put: '0.275 : zooming improvement by Yuriy';
	at: #date put: '11 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000276 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.155';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.363';
	at: #version put: '0.276';
	at: #comment put: '0.276 : merged with Milton version';
	at: #date put: '11 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000277 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.155';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.364';
	at: #version put: '0.277';
	at: #comment put: '0.277 : worked on the punchcard';
	at: #date put: '12 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000278 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.155';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.365';
	at: #version put: '0.278';
	at: #comment put: '0.278 : worked on the punchcard example';
	at: #date put: '12 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000279 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.155';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.366';
	at: #version put: '0.279';
	at: #comment put: '0.279 : Fixed Celllayout. Improved the Punchcard';
	at: #date put: '13 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000280 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.155';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.370';
	at: #version put: '0.280';
	at: #comment put: '0.280 : added RTConstraint>>move:below: and fixed move:above:. minor fix in RTGlobalBuilder. Added RTLegend2Builder. Cool stuff!';
	at: #date put: '18 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000281 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.157';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.370';
	at: #version put: '0.281';
	at: #comment put: '0.281 : bug fix in Trachel';
	at: #date put: '18 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000282 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.158';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.370';
	at: #version put: '0.282';
	at: #comment put: '0.282 : recategorization of a method';
	at: #date put: '18 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000283 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.158';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.371';
	at: #version put: '0.283';
	at: #comment put: '0.283 : Added a addLayoutMenu on RTView';
	at: #date put: '18 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000284 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-YuriyTymchuk.159';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.373';
	at: #version put: '0.284';
	at: #comment put: '0.284 : Added zoom in the RTAbstractsmartBrowser>>setMenu method, added examples about rotating elements. Added RTSparkline and some example';
	at: #date put: '24 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000285 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.160';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.373';
	at: #version put: '0.285';
	at: #comment put: '0.285 : merged with the sparkline version and moved TRMorph into a specific category';
	at: #date put: '30 June 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000286 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.161';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.374';
	at: #version put: '0.286';
	at: #comment put: '0.286 : Added TRConstraintclass>>fix:for: useful :-) Added RTMultiLinearColorForIdentity, really really useful. Added more example about this';
	at: #date put: '1 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000287 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.161';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.375';
	at: #version put: '0.287';
	at: #comment put: '0.287 : slightly changed RTLabelled>>text:. Added examples and commented a bit';
	at: #date put: '1 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000288 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.161';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.376';
	at: #version put: '0.288';
	at: #comment put: '0.288 : conflict solved with Roassal1';
	at: #date put: '2 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000289 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-akevalion.162';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.377';
	at: #version put: '0.289';
	at: #comment put: '0.289 : removing all { }. Preparing for the migration to VW';
	at: #date put: '2 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000290 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-akevalion.162';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.378';
	at: #version put: '0.290';
	at: #comment put: '0.290 : fixed a bug to update RTLabel';
	at: #date put: '2 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000291 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-akevalion.162';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.379';
	at: #version put: '0.291';
	at: #comment put: '0.291 : added a comment for RTShape';
	at: #date put: '2 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000292 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.161';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.380';
	at: #version put: '0.292';
	at: #comment put: '0.292 : Fix in the multilinecolorforidentity - Bug fix';
	at: #date put: '3 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000293 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.161';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.381';
	at: #version put: '0.293';
	at: #comment put: '0.293 : Added RTEquidistantCircleLayout and RTWeightedCircleLayout. Thanks Daniel Rojas about this!';
	at: #date put: '3 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000294 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.161';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.382';
	at: #version put: '0.294';
	at: #comment put: '0.294 : Added a utility method';
	at: #date put: '3 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000295 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.161';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.383';
	at: #version put: '0.295';
	at: #comment put: '0.295 : added RTObject>>basicNew. Useful when we do some memory profiling';
	at: #date put: '4 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000296 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.161';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.384';
	at: #version put: '0.296';
	at: #comment put: '0.296 : added a method in mondrian. Need some more work';
	at: #date put: '4 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000297 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.161';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.385';
	at: #version put: '0.297';
	at: #comment put: '0.297 : added an example and a comment';
	at: #date put: '9 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000298 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.161';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.387';
	at: #version put: '0.298';
	at: #comment put: '0.298 : added a namecloud';
	at: #date put: '11 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000299 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.161';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.388';
	at: #version put: '0.299';
	at: #comment put: '0.299 : worked on name cloud';
	at: #date put: '11 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000300 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.162';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.389';
	at: #version put: '0.300';
	at: #comment put: '0.300 : fix the bug when you removed a labelled edge or element, the label was not removed. Now it is!';
	at: #date put: '12 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000301 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.162';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.390';
	at: #version put: '0.301';
	at: #comment put: '0.301 : added a dictionary in the name cloud. Much better!';
	at: #date put: '12 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000302 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.162';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.391';
	at: #version put: '0.302';
	at: #comment put: '0.302 : Added more examples';
	at: #date put: '12 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000303 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.163';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.391';
	at: #version put: '0.303';
	at: #comment put: '0.303 : fixed a bug in TRMorph about Scaling and we now have a session management ! Yupi!!!! (Thanks Thierry!)';
	at: #date put: '12 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000304 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.164';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.392';
	at: #version put: '0.304';
	at: #comment put: '0.304 : Added multi composite shape, both in Trachel and Roassal. Worked on the metricnormalizer. Cool stuff!';
	at: #date put: '13 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000305 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.165';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.393';
	at: #version put: '0.305';
	at: #comment put: '0.305 : Working on Charter';
	at: #date put: '14 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000306 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.165';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.393';
	at: #version put: '0.306';
	at: #comment put: '0.306 : bug fixed in TRMorph related to the Athens surface creation';
	at: #date put: '14 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000307 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.166';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.394';
	at: #version put: '0.307';
	at: #comment put: '0.307 : Added support for fontname';
	at: #date put: '17 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000308 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.167';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.394';
	at: #version put: '0.308';
	at: #comment put: '0.308 : fixed the bug related to surfaces. The surface gets properly initialized when one resize a window';
	at: #date put: '17 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000309 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.167';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.395';
	at: #version put: '0.309';
	at: #comment put: '0.309 : Edge transparency example. Added the new interaction RTSetEdgeAlpha';
	at: #date put: '18 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000310 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.168';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.396';
	at: #version put: '0.310';
	at: #comment put: '0.310 : added a font example';
	at: #date put: '18 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000311 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.169';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.397';
	at: #version put: '0.311';
	at: #comment put: '0.311 : Working on nesting and composed shapes. It has been quite though!';
	at: #date put: '18 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000312 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.170';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.398';
	at: #version put: '0.312';
	at: #comment put: '0.312 : merged with Milton version';
	at: #date put: '19 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000313 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.171';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.399';
	at: #version put: '0.313';
	at: #comment put: '0.313 : Worked on the nesting and composition. Much better now!';
	at: #date put: '20 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000314 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.171';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.401';
	at: #version put: '0.314';
	at: #comment put: '0.314 : Started to work on a edge builder';
	at: #date put: '21 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000315 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.171';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.402';
	at: #version put: '0.315';
	at: #comment put: '0.315 : Added RTShorterDistanceAttachPointAndCompositeShape and a corresponding example';
	at: #date put: '21 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000316 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.171';
	at: 'Roassal2' put: 'Roassal2-YuriyTymchuk.405';
	at: #version put: '0.316';
	at: #comment put: '0.316 : Added progress bar to rectangle packing layout';
	at: #date put: '23 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000317 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.171';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.406';
	at: #version put: '0.317';
	at: #comment put: '0.317 : a bit more work on Charter';
	at: #date put: '24 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000318 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.172';
	at: 'Roassal2' put: 'Roassal2-akevalion.410';
	at: #version put: '0.318';
	at: #comment put: '0.318 : Milton improvement of Trachel.';
	at: #date put: '30 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000319 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.173';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.411';
	at: #version put: '0.319';
	at: #comment put: '0.319 : Added multilines, including orthogonal vertical and horizontal';
	at: #date put: '30 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000320 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.173';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.412';
	at: #version put: '0.320';
	at: #comment put: '0.320 : Improved the edge builder';
	at: #date put: '30 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000321 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.173';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.413';
	at: #version put: '0.321';
	at: #comment put: '0.321 : Added seismData2, new class MapLocationExample. Improved the test of RTTableTable. Added a utility function in String';
	at: #date put: '31 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000322 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.173';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.414';
	at: #version put: '0.322';
	at: #comment put: '0.322 : More work on Charter';
	at: #date put: '31 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000323 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.173';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.415';
	at: #version put: '0.323';
	at: #comment put: '0.323 : Worked on the tab table. Added filtering out';
	at: #date put: '31 July 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000324 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.173';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.416';
	at: #version put: '0.324';
	at: #comment put: '0.324 : fixing undeclared temporary variables in the charter example';
	at: #date put: '1 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000325 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.174';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.416';
	at: #version put: '0.325';
	at: #comment put: '0.325 : Added TRMouseDragStart and TRMouseDragEnd';
	at: #date put: '1 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000326 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.174';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.417';
	at: #version put: '0.326';
	at: #comment put: '0.326 : added highlightIf:using: in Charter. Improved RTTabTable and RTLabelled';
	at: #date put: '2 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000327 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.174';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.418';
	at: #version put: '0.327';
	at: #comment put: '0.327 : Improved a bit RTChapterBuilder and RTLabelled';
	at: #date put: '2 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000328 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.175';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.420';
	at: #version put: '0.328';
	at: #comment put: '0.328 : Worked on the composer. Added example';
	at: #date put: '3 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000329 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.176';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.421';
	at: #version put: '0.329';
	at: #comment put: '0.329 : Added double click, by Juan Pablo Sandoval';
	at: #date put: '5 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000330 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.177';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.421';
	at: #version put: '0.330';
	at: #comment put: '0.330 : moved extensions of TRConstraint from Telescope to Trachel. Thanks Leo!';
	at: #date put: '5 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000331 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.178';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.421';
	at: #version put: '0.331';
	at: #comment put: '0.331 : Cleaning in Trachel';
	at: #date put: '5 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000332 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.179';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.422';
	at: #version put: '0.332';
	at: #comment put: '0.332 : Added support for SVG. Thanks Juraj! Here is Juraj report Improved TRSVGPath
- fixed draggable problem
- fixed encompassing rectangle
- now it use matrix (affinite transformation)
- you can use #path: for a default behavior or #centeredPath: which recomputes points and the figure is in 0@0 by default.

There are one crutial differences between #path: and #centeredPath:
- if someone uses #centeredPath: svg position = svg center (always!)
- if someone uses #path: svg position ~= svg center (usually)
';
	at: #date put: '5 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000333 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-VincentBlondeau.180';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.422';
	at: #version put: '0.333';
	at: #comment put: '0.333 : Trachel now handles sessions. Yupi!!! Finally!';
	at: #date put: '6 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000334 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-VincentBlondeau.180';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.423';
	at: #version put: '0.334';
	at: #comment put: '0.334 : Fixed  RTTable does not parse commas inside quotes correcly identified by Serge S.';
	at: #date put: '6 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000335 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-VincentBlondeau.180';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.424';
	at: #version put: '0.335';
	at: #comment put: '0.335 : Added an example with pie and legend';
	at: #date put: '6 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000336 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-VincentBlondeau.180';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.425';
	at: #version put: '0.336';
	at: #comment put: '0.336 : Fixed a problem with force based layout and group of groups. Added an example. Thanks Usamn for having spotted that bug';
	at: #date put: '6 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000337 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-VincentBlondeau.180';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.426';
	at: #version put: '0.337';
	at: #comment put: '0.337 : Minor cleaning. Method protocol reclassified';
	at: #date put: '8 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000338 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-VincentBlondeau.180';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.426';
	at: #version put: '0.338';
	at: #comment put: '0.338 : Added version by Vincent Bondeau about managing the session in Trachel';
	at: #date put: '8 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000339 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-VincentBlondeau.180';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.427';
	at: #version put: '0.339';
	at: #comment put: '0.339 : Negative values in Charter';
	at: #date put: '8 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000340 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-VincentBlondeau.180';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.429';
	at: #version put: '0.340';
	at: #comment put: '0.340 Making sure all groups can be used by the layout';
	at: #date put: '11 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000341 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.181';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.430';
	at: #version put: '0.341';
	at: #comment put: '0.341 : Improvement of Charter. Examples have been added. Test on bitmap has been added. The method TRSVGPath>>includesPoint: has been improved. Thanks Natalia for this!';
	at: #date put: '12 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000342 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.182';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.430';
	at: #version put: '0.342';
	at: #comment put: '0.342 : Fix in the TRBitmapShape class. Spotted by Nicolas Heiss. Thanks!!';
	at: #date put: '12 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000343 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.182';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.431';
	at: #version put: '0.343';
	at: #comment put: '0.343 : Added new example in Charter';
	at: #date put: '12 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000344 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.183';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.432';
	at: #version put: '0.344';
	at: #comment put: '0.344 : Worked on Charter.... Preparing the book chapter';
	at: #date put: '14 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000345 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.183';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.433';
	at: #version put: '0.345';
	at: #comment put: '0.345 : Example about Charter';
	at: #date put: '15 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000346 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.184';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.434';
	at: #version put: '0.346';
	at: #comment put: '0.346 : Trachel: minor change, simply a recategorization of methods -- Roassal: Added examples about crosses, added guards in MultiCompositeShape, added RTShapeBuilder>>cross';
	at: #date put: '17 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000347 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.185';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.435';
	at: #version put: '0.347';
	at: #comment put: '0.347 : Improvement of Roassal and Trachel. About the labelling and layout in the multi shape composed';
	at: #date put: '18 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000348 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.186';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.436';
	at: #version put: '0.348';
	at: #comment put: '0.348 : More work on the multi composed shape. Still not working proberly :-(';
	at: #date put: '20 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000349 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.187';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.437';
	at: #version put: '0.349';
	at: #comment put: '0.349 : Improved RTBitmap, by adding formElement, and doing a rtValue. Added RTEventForwarder. Improved TRCamera and TRShape. Added comments and a #isVisible method. Really useful!';
	at: #date put: '20 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000350 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.188';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.438';
	at: #version put: '0.350';
	at: #comment put: '0.350 : Reverted TRBitmapShape>>drawOn: and added RTVisible';
	at: #date put: '20 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000351 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.188';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.439';
	at: #version put: '0.351';
	at: #comment put: '0.351 : Menu re-organization';
	at: #date put: '21 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000352 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.189';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.440';
	at: #version put: '0.352';
	at: #comment put: '0.352 : Fixed a serious bug related to the visibility and the camera movement';
	at: #date put: '21 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000353 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.189';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.441';
	at: #version put: '0.353';
	at: #comment put: '0.353 : Improved the composer with a layout and the propagation to all elements. ';
	at: #date put: '21 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000354 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.191';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.442';
	at: #version put: '0.354';
	at: #comment put: '0.354 : Merged with Juraj added back missing methods in Trachel';
	at: #date put: '21 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000355 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.192';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.443';
	at: #version put: '0.355';
	at: #comment put: '0.355 : Improved the push:behind: in TRCanvas. Replaced CompositeShape by MultiCompositeShape in RTArrow. Added test';
	at: #date put: '21 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000356 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.193';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.443';
	at: #version put: '0.356';
	at: #comment put: '0.356 : added width and height in TRShape ';
	at: #date put: '21 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000357 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.193';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.444';
	at: #version put: '0.357';
	at: #comment put: '0.357 : Added some utility methods. Improved the example brwoser by adding event forwarding';
	at: #date put: '21 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000358 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.194';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.444';
	at: #version put: '0.358';
	at: #comment put: '0.358 : Bug fixed in TRCamera>>translateTo:';
	at: #date put: '21 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000359 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.194';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.446';
	at: #version put: '0.359';
	at: #comment put: '0.359 : merged with Juraj new class to show labels';
	at: #date put: '21 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000360 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.194';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.447';
	at: #version put: '0.360';
	at: #comment put: '0.360 : minor fix in the RTTabTable';
	at: #date put: '22 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000361 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.195';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.448';
	at: #version put: '0.361';
	at: #comment put: '0.361 : Added #restoreCamera in RTView and RTBuilder. This is useful when scripting in a playground. Added an accessor for the camera in TRCanvas';
	at: #date put: '31 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000362 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.195';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.450';
	at: #version put: '0.362';
	at: #comment put: '0.362 : Merged with Juraj version (he contributed to #classReferences and friends)';
	at: #date put: '31 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000363 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.196';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.451';
	at: #version put: '0.363';
	at: #comment put: '0.363 : Worked on the vertical layout for MultiCompositeShapes. Added tests';
	at: #date put: '31 August 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000364 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.196';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.452';
	at: #version put: '0.364';
	at: #comment put: '0.364 : some temporary variables were undeclared. Fixed';
	at: #date put: '2 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000365 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.197';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.453';
	at: #version put: '0.365';
	at: #comment put: '0.365 : Added RTGroup>>extent:, width:, height: Useful for resizing a group of elements';
	at: #date put: '3 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000366 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.197';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.454';
	at: #version put: '0.366';
	at: #comment put: '0.366 : Fixed example by removing undeclared temporary variables';
	at: #date put: '3 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000367 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.197';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.455';
	at: #version put: '0.367';
	at: #comment put: '0.367 : removed RTCharterBuilder>>#exampleHistogram and added comments in RTCharterExample>>exampleHistogram';
	at: #date put: '3 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000368 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.198';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.456';
	at: #version put: '0.368';
	at: #comment put: '0.368 : Added RTPolygon, TRPolygon and an example. Thanks Natalia for these classes!';
	at: #date put: '3 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000369 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.198';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.457';
	at: #version put: '0.369';
	at: #comment put: '0.369 : Did a bit of cleaning in Charter';
	at: #date put: '3 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000370 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.198';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.458';
	at: #version put: '0.370';
	at: #comment put: '0.370 : Heavy refactoring of Charter';
	at: #date put: '3 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000371 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.198';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.459';
	at: #version put: '0.371';
	at: #comment put: '0.371 : minor update. Just a comment';
	at: #date put: '4 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000372 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.199';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.460';
	at: #version put: '0.372';
	at: #comment put: '0.372 : RTVisible now handle a better detection of isVisible. Useful for the OpenStreeMap integration';
	at: #date put: '4 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000373 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.200';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.460';
	at: #version put: '0.373';
	at: #comment put: '0.373 : improved the TRMorph>>step method';
	at: #date put: '4 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000374 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.201';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.461';
	at: #version put: '0.374';
	at: #comment put: '0.374 : Added a camera initializer. Improved RTView>>restoreCamera';
	at: #date put: '4 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000375 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.202';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.462';
	at: #version put: '0.375';
	at: #comment put: '0.375 : More work on the inner shapes. Not easy thing to get right';
	at: #date put: '4 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000376 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.203';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.463';
	at: #version put: '0.376';
	at: #comment put: '0.376 : A bit of cleaning in Trachel. fixed broken test in Roassal2';
	at: #date put: '4 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000377 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.203';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.464';
	at: #version put: '0.377';
	at: #comment put: '0.377 : Added double bar charter with an example';
	at: #date put: '4 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000378 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.204';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.465';
	at: #version put: '0.378';
	at: #comment put: '0.378 : Added facilities to have a start stop button for the setting force based layout';
	at: #date put: '5 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000379 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.205';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.466';
	at: #version put: '0.379';
	at: #comment put: '0.379 : In trachel, the initial scale of a camera has been changed (1.0 -> 1.01), since this seems to remove the font problem. Several examples have been added to Charter. The RTDoubleBarBuilder has been improved. RTBuilder, RTTabTable have also been improved. Bug fixed in RTLayoutTranslator';
	at: #date put: '5 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000380 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.206';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.467';
	at: #version put: '0.380';
	at: #comment put: '0.380 : Fixed some tests. The previous changes were breaking some tests';
	at: #date put: '5 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000381 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.206';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.468';
	at: #version put: '0.381';
	at: #comment put: '0.381 : Commented allY:';
	at: #date put: '5 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000382 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.207';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.469';
	at: #version put: '0.382';
	at: #comment put: '0.382 : Added a RTView setCanvas: This is necessary to be able to use TRCanvas in a GTInspector. Minor reclassification in TREllipseShape';
	at: #date put: '8 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000383 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.207';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.470';
	at: #version put: '0.383';
	at: #comment put: '0.383 : Worked on charter. We now have histogram with labels';
	at: #date put: '9 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000384 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.207';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.471';
	at: #version put: '0.384';
	at: #comment put: '0.384 : Cleaning in Roassal2';
	at: #date put: '10 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000385 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.208';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.472';
	at: #version put: '0.385';
	at: #comment put: '0.385 : Fixed big problems with the composite shapes. Everything is okay now.';
	at: #date put: '10 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000386 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.208';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.473';
	at: #version put: '0.386';
	at: #comment put: '0.386 : cleaning of RTCharterBuilder';
	at: #date put: '11 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000387 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-akevalion.209';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.476';
	at: #version put: '0.387';
	at: #comment put: '0.387 : Removed non VW things from Trachel and Roassal for the migration to VW.';
	at: #date put: '19 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000388 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-akevalion.209';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.477';
	at: #version put: '0.388';
	at: #comment put: '0.388 : I have improved the RTMetricNormalizer. And factored out the common part. That was indeed necessary.

In the RTDoubleBarBuilder>>metric: aBlock color: aColor height: anHeight I have inserted the following:
	...
	RTMetricNormalizer new 
		elements: boxes;
		normalizeWidth: aBlock min: 2 max: width minValue: 0.
	…
';
	at: #date put: '20 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000389 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-akevalion.209';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.478';
	at: #version put: '0.389';
	at: #comment put: '0.389 : Added some class comments';
	at: #date put: '20 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000390 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.210';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.479';
	at: #version put: '0.390';
	at: #comment put: '0.390 : Organizing the icons and fixing a bug in Trachel';
	at: #date put: '21 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000391 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.210';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.480';
	at: #version put: '0.391';
	at: #comment put: '0.391 : Added many class comments';
	at: #date put: '21 September 2014';
	yourself
]

{ #category : #versions }
VersionOfRoassal2 >> version000392 [
	^ Dictionary new 
	at: 'Trachel' put: 'Trachel-AlexandreBergel.211';
	at: 'Roassal2' put: 'Roassal2-AlexandreBergel.481';
	at: #version put: '0.392';
	at: #comment put: '0.392 : Added pushBack in shapedObject. Modified Charter to move the tick behind the scene';
	at: #date put: '22 September 2014';
	yourself
]

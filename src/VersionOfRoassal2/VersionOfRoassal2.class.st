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

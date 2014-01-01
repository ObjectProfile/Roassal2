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

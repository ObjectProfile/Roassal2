Class {
	#name : #GTATool,
	#superclass : #Object,
	#classInstVars : [
		'semaphore',
		'process'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Utilities'
}

{ #category : #private }
GTATool class >> checkProcess [
	process isComplete ifTrue: [ semaphore signal ].

]

{ #category : #defaults }
GTATool class >> defaultDownloadDirectory [
	^ FileSystem disk workingDirectory
]

{ #category : #defaults }
GTATool class >> defaultDownloadFilename [
	^ self defaultDownloadDirectory / 'gt-events.tar.gz'
]

{ #category : #defaults }
GTATool class >> defaultEventsDirectory [
	^ self defaultDownloadDirectory / 'gt' / 'events'
]

{ #category : #defaults }
GTATool class >> defaultUrl [
	^ 'http://gc.dcc.uchile.cl:8080/gt/events/data'
]

{ #category : #api }
GTATool class >> download [
	"self download"
 	UIManager default informUserDuring: [ :bar |
		bar label: 'Download Spotter Event Data...'.
		[ ZnClient new
			url: self defaultUrl;
			downloadTo: self defaultDownloadFilename ]
		on: HTTPProgress 
		do: [ :progress |
			progress isEmpty ifFalse: [ bar current: progress percentage ].
			progress resume ] 
	]
]

{ #category : #api }
GTATool class >> ensureDownloadedData [
	self defaultDownloadFilename exists ifFalse: [ self download ]
]

{ #category : #api }
GTATool class >> ensureExctractedData [
	self defaultEventsDirectory exists ifFalse: [ self extract ]
]

{ #category : #api }
GTATool class >> ensureLocalDirectory [
	self 
		ensureDownloadedData;
		ensureExctractedData
]

{ #category : #api }
GTATool class >> extract [
	semaphore := Semaphore new.
	process := ExternalUnixOSProcess 
		forkAndExec: '/usr/bin/tar' 
		arguments: (Array with: 'xzf' with: self defaultDownloadFilename fullName)
		environment: nil 
		descriptors: nil 
		workingDir: self defaultDownloadDirectory fullName.
	process addDependent: self.
	self checkProcess.
	semaphore wait.
	process := nil.
	semaphore := nil.
]

{ #category : #updating }
GTATool class >> update: aParameter [
	aParameter = #runState ifTrue: [ self checkProcess ]
]

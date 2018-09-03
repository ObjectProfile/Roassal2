Class {
	#name : #PCPPImporter,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #ProfilerCPP
}

{ #category : #'as yet unclassified' }
PCPPImporter >> browse [

	"This is the main method
	PCPPMain new browse
	"

	| db result row f functionsDictionary c calledFunction instructionsDictionary instruction segmentsDictionary segment  callingFunction callsDictionary |
	db := NBSQLite3Connection on: self dbFilePath.
	db open.
	
	"Reifying the functions"
	functionsDictionary := Dictionary new.
	result := db execute: 'SELECT * FROM FUNCTION_TABLE;'.
	[ (row := result next) isNotNil ] whileTrue: [
		f := PCPPFunction new.
		f id: (row at: 'ID').
		f signature: (row at: 'SIGNATURE').
		model add: f.
		functionsDictionary at: f id put: f.
	].
	
	"Reifying instructions"
	instructionsDictionary := Dictionary new.
	result := db execute: 'SELECT * FROM INSTRUCTION_TABLE;'.
	[ (row := result next) isNotNil ] whileTrue: [
		instruction := PCPPInstruction new.
		instruction id: (row at: 'ID').
		instruction segmentId: (row at: 'SEGMENT_ID').
		instructionsDictionary at: instruction id put: instruction.
	].	
	
	"Reifying segment"
	segmentsDictionary := Dictionary new.
	result := db execute: 'SELECT * FROM SEGMENT_TABLE;'.
	[ (row := result next) isNotNil ] whileTrue: [
		segment := PCPPSegment new.
		segment id: (row at: 'ID').
		segment callId: (row at: 'CALL_ID').
		segmentsDictionary at: segment id put: segment.
	].	
	
	"Reifying the call"
	callsDictionary := Dictionary new.
	result := db execute: 'SELECT * FROM CALL_TABLE;'.
	[ (row := result next) isNotNil ] whileTrue: [
		c := PCPPCall new.
		c id: (row at: 'ID').
		c functionId: (row at: 'FUNCTION_ID').
		c instructionId: (row at: 'INSTRUCTION_ID').
"		self haltIf: [ c instructionId = -1 ]."
		c startTime: (row at: 'START_TIME').
		c endTime: (row at: 'END_TIME').
		
		callsDictionary at: c id put: c.
	].

	"We process the call, so we read the table again. Note that this is not necessary, however easy."
	result := db execute: 'SELECT * FROM CALL_TABLE;'.
	[ (row := result next) isNotNil ] whileTrue: [
		c := callsDictionary at: (row at: 'ID').

		"We link the function, if it exists"
		(functionsDictionary includesKey: c functionId) ifTrue: 
			[ calledFunction := functionsDictionary at: c functionId.
			  c calledFunction: calledFunction.
			  calledFunction addIncomingCall: c .
		
			(instructionsDictionary includesKey: (c instructionId)) ifTrue: 
				[callingFunction := 
					functionsDictionary at: 
						(callsDictionary at: 
							((segmentsDictionary at: 
								((instructionsDictionary at: (c instructionId)) segmentId)) callId)) functionId.
				c callingFunction: callingFunction.
				callingFunction addOutgoingCall: c ].
			].
		"
		So the function_id of a call_table entity refers to the called function of this entity. If you want to get the caller  function you have to go this way:

call_table::instruction_id -> instruction::segment_id -> segment::call_id -> call::function_id -> call

		"
		model add: c.
	].	
	
	db close.
	self inspect
]

{ #category : #'as yet unclassified' }
PCPPImporter >> dbFilePath [

"	^ '/Users/alexandrebergel/Downloads/moose-5-5/mydb.db'
"	^ '/Users/alexandrebergel/Downloads/cppcheck/Wed_Mar_11_09_06_34_2015_cppcheck.exe_Parceive.db'
]

{ #category : #'as yet unclassified' }
PCPPImporter >> import: fileNameWithFullPath [

	"This is the main method
	PCPPMain new browse
	"

	| db result row f functionsDictionary c calledFunction instructionsDictionary instruction segmentsDictionary segment  callingFunction callsDictionary accessDictionary a referenceDictionary ref |
	db := NBSQLite3Connection on: fileNameWithFullPath.
	db open.
	
	"Reifying the functions"
	functionsDictionary := Dictionary new.
	result := db execute: 'SELECT * FROM FUNCTION_TABLE;'.
	[ (row := result next) isNotNil ] whileTrue: [
		f := PCPPFunction new.
		f id: (row at: 'ID').
		f signature: (row at: 'SIGNATURE').
		model add: f.
		functionsDictionary at: f id put: f.
	].
	
	"Reifying instructions"
	instructionsDictionary := Dictionary new.
	result := db execute: 'SELECT * FROM INSTRUCTION_TABLE;'.
	[ (row := result next) isNotNil ] whileTrue: [
		instruction := PCPPInstruction new.
		instruction id: (row at: 'ID').
		instruction segmentId: (row at: 'SEGMENT_ID').
		instructionsDictionary at: instruction id put: instruction.
	].	
	
	"Reifying segment"
	segmentsDictionary := Dictionary new.
	result := db execute: 'SELECT * FROM SEGMENT_TABLE;'.
	[ (row := result next) isNotNil ] whileTrue: [
		segment := PCPPSegment new.
		segment id: (row at: 'ID').
		segment callId: (row at: 'CALL_ID').
		segmentsDictionary at: segment id put: segment.
	].	
	
	"Reifying the call"
	callsDictionary := Dictionary new.
	result := db execute: 'SELECT * FROM CALL_TABLE;'.
	[ (row := result next) isNotNil ] whileTrue: [
		c := PCPPCall new.
		c id: (row at: 'ID').
		c functionId: (row at: 'FUNCTION_ID').
		c instructionId: (row at: 'INSTRUCTION_ID').
"		self haltIf: [ c instructionId = -1 ]."
		c startTime: (row at: 'START_TIME') asInteger.
		c endTime: (row at: 'END_TIME') asInteger.

		callsDictionary at: c id put: c.
	].

	"Reifying access"
	accessDictionary := Dictionary new.
	result := db execute: 'SELECT * FROM ACCESS_TABLE;'.
	[ (row := result next) isNotNil ] whileTrue: [
		a := PCPPAccess new.
		a id: (row at: 'ID').
		a instructionId: (row at: 'INSTRUCTION_ID').
		a referenceId: (row at: 'REFERENCE_ID').
		a accessType: (row at: 'ACCESS_TYPE').
		model add:a. 
		accessDictionary at: a id put: a.
	].	
	
	"Reifying references"
	referenceDictionary := Dictionary new.
	result := db execute: 'SELECT * FROM REFERENCE_TABLE;'.
	[ (row := result next) isNotNil ] whileTrue: [
		ref := PCPPReference new.
		ref id: (row at: 'ID').
		ref referenceId: (row at: 'REFERENCE_ID').
		ref name: (row at: 'NAME').
		model add: ref.
		referenceDictionary at: ref id put: ref.
	].	


	"We process the call, so we read the table again. Note that this is not necessary, however easy."
	result := db execute: 'SELECT * FROM CALL_TABLE;'.
	[ (row := result next) isNotNil ] whileTrue: [
		c := callsDictionary at: (row at: 'ID').

		"We link the function, if it exists"
		(functionsDictionary includesKey: c functionId) ifTrue: 
			[ calledFunction := functionsDictionary at: c functionId.
			  c calledFunction: calledFunction.
			  calledFunction addIncomingCall: c .
		
			(instructionsDictionary includesKey: (c instructionId)) ifTrue: 
				[callingFunction := 
					functionsDictionary at: 
						(callsDictionary at: 
							((segmentsDictionary at: 
								((instructionsDictionary at: (c instructionId)) segmentId)) callId)) functionId.
				c callingFunction: callingFunction.
				callingFunction addOutgoingCall: c ].
			].
		"
		So the function_id of a call_table entity refers to the called function of this entity. If you want to get the caller  function you have to go this way:

call_table::instruction_id -> instruction::segment_id -> segment::call_id -> call::function_id -> call
	"
	model add: c.
	].
	
	"Process the accesses, link them with functions, associate them with reference"
	accessDictionary values do: [ :ac | 
		(callsDictionary at: 
			((segmentsDictionary at: 
				((instructionsDictionary at: 
					(ac instructionId)) segmentId)) callId)) calledFunction addReferenceAccess: ac.
					
		ac reference: (referenceDictionary values detect: [:r | r referenceId = ac referenceId]). 
		"model add:ac. "
		].
	
	"List function calls of each call"
		callsDictionary valuesDo: [ :ca | 
		| ar |
		result := db execute: 'SELECT C2.*
FROM call_table as C1
INNER JOIN segment_table ON segment_table.call_id = C1.id
INNER JOIN instruction_table ON instruction_table.segment_id = segment_table.id
INNER JOIN call_table AS C2 ON C2.instruction_id = instruction_table.id
WHERE instruction_table.instruction_type = ''CALL''
AND C1.id = ''',ca id,''';'.
		ar := Set new.
		[ (row := result next) isNotNil ] whileTrue: [
			ar add: (callsDictionary at: (row at: 'ID'))
			].
		ca functionCalls: ar.
	].


 "Process de accesses, link accesses to calls"
	callsDictionary valuesDo: [ :ca | 
		| ar |
		result := db execute: 'SELECT C2.*
FROM call_table as C1
INNER JOIN segment_table ON segment_table.call_id = C1.id
INNER JOIN instruction_table ON instruction_table.segment_id = segment_table.id
INNER JOIN access_table AS C2 ON C2.instruction_id = instruction_table.id
WHERE instruction_table.instruction_type = ''ACCESS''
AND C1.id = ''',ca id,''';'.
ar := OrderedCollection new.
		[ (row := result next) isNotNil ] whileTrue: [
			ar add: (referenceDictionary values detect: [:r | r referenceId = (row at: 'REFERENCE_ID')])
			].
		ca referenceAccesses: ar.
	].

	db close.
	^ model
]

{ #category : #'as yet unclassified' }
PCPPImporter >> initialize [
	super initialize.
	model := MooseModel new.
]

{ #category : #'as yet unclassified' }
PCPPImporter >> model [
	^ model
]

{ #category : #'as yet unclassified' }
PCPPImporter >> readme [

	"
You need to install NBSQLite3 using the following incantation:

Gofer new
    url: 'http://smalltalkhub.com/mc/PharoExtras/NBSQLite3/main';
    package: 'ConfigurationOfNBSQLite3';
    load.
((Smalltalk at: #ConfigurationOfNBSQLite3) project stableVersion) load.

For more informations about installation: http://smalltalkhub.com/#!/~PharoExtras/NBSQLite3

	"
]

{ #category : #'as yet unclassified' }
PCPPImporter >> visu01 [

| b |
b := RTMondrian new.
b nodes: (model entities select: #isFunction).

b edges connectToAll: #outgoingFunctions.
b layout tree.
^ b

]

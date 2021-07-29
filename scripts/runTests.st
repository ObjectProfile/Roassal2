| path stream unitTests |
"We capture all the unit tests in Pharo"

"We load the application software analyzer"
[ Metacello new
    baseline: 'Roassal2';
    repository: 'github://ObjectProfile/Roassal2/src';
    load. ] on: MCMergeOrLoadWarning do: [ :warning | warning load ].

"We identify the unit tests contained in the loaded application"
unitTests := (TestCase withAllSubclasses
	select: [:cls |  
		('Roassal2*' match: cls package name) or: [
			('Trachel*' match: cls package name) ] ]) 
	sorted: [ :c1 :c2 | c1 name < c2 name ].

"We create a file that will contain the result of the test execution"
path := '/tmp/result.txt'.
path asFileReference exists ifTrue: [ path asFileReference delete ].
stream := path asFileReference writeStream.

"We run the unit tests"
unitTests do: [ :unitTestClass | | res |
	res := unitTestClass buildSuite run.
	(res hasFailures or: [ res hasErrors ]) ifTrue: [ 
		stream nextPutAll: '--> ERROR: '; nextPutAll: unitTestClass name; crlf.
		res failures , res errors do: [:error | 
			stream tab; nextPutAll: error asString; crlf]
	] ifFalse: [
		stream nextPutAll: unitTestClass name; space; nextPutAll: res asString. ].
	
	stream crlf
].

"We close the stream and quit Pharo"
stream close.
SmalltalkImage current quitPrimitive

Extension { #name : #MooseModel }

{ #category : #'*ProfilerCPP' }
MooseModel >> allExecutedPCPPFunction [
	<navigation: 'All Executed PCPP functions'>
	^ (self allWithType: PCPPFunction) select: #hasBeenExecuted
]

{ #category : #'*ProfilerCPP' }
MooseModel >> allPCPPFunction [
	<navigation: 'All PCPP functions'>
	^ self allWithType: PCPPFunction
]

{ #category : #'*ProfilerCPP' }
MooseModel >> allPCPPInstruction [
	<navigation: 'All PCPP calls'>
	^ self allWithType: PCPPCall
]

{ #category : #'*ProfilerCPP' }
MooseModel >> allPCPPSegment [
	<navigation: 'All PCPP segment'>
	^ self allWithType: PCPPSegment
]

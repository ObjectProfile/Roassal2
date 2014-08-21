Class {
	#name : #RTSimonExample,
	#superclass : #RTObject,
	#category : 'Roassal2-Builder-Simon'
}

{ #category : #basic }
RTSimonExample >> basic01 [
	"
	self new basic01
	"
	| builder |
	builder := RTSimon new.
	builder models: (1 to: 20).
	builder open
]

{ #category : #basic }
RTSimonExample >> basic02 [
	"
	self new basic02
	"
	| builder |
	builder := RTSimon new.
	builder shape current externalRadius: [ :obj | (obj * 3) + 80].
	builder models: (1 to: 20).
	builder open
]

{ #category : #basic }
RTSimonExample >> basic03 [
	"
	self new basic03
	"
	| builder |
	builder := RTSimon new.
	builder shape current 
						innerRadius: [ :r | 200 atRandom ];
						externalRadius: [ :obj | 200 + 40 atRandom ];
						outerAngle: [ :o | 360 atRandom ] innerAngle: [ :o | 50 atRandom ];
						color: [ :o | ((Array with: Color red with: Color blue with: Color white) atRandom alpha: 0.1)].
	builder models: (1 to: 10).
	builder open
]

{ #category : #basic }
RTSimonExample >> basic03Animated [
	"
	self new basic03Animated
	"
	| builder timer |
	timer := VITimer new cycleLength: 10.
	
	builder := RTSimon new.
	builder shape current 
						innerRadius: [ :r | 200 atRandom ];
						externalRadius: [ :obj | 200 + 40 atRandom ];
						outerAngle: [ :o | 
							| a b |
							a := 300 atRandom.
							b := 200 atRandom.
							VIAnimatedValue new
													evaluator: [ :t | a interpolateTo: (a + b) at: t ];
													timer: timer;
													yourself. ]
							innerAngle: [ :o | 50 atRandom ];
						color: [ :o | ((Array with: Color red with: Color blue with: Color white) atRandom alpha: 0.1)].
	builder models: (1 to: 10).
	timer start.
	builder view addAnimation: (TRResetAllShapes new trCanvas: builder view canvas). 
	builder open
]

{ #category : #'software visualization' }
RTSimonExample >> softviz01 [
	"
	self new softviz01

	LOC, NOM, NOV, NOS
	"
	| b | 
	b := RTSimon new.
	b shape current
				outerAngle: [ :cls | cls numberOfVariables * 25 ] innerAngle: [ :cls | cls numberOfMethods / 1 ];
				innerRadius: [ :cls | cls withAllSuperclasses size * 10 ];
				thickness: [ :cls | cls numberOfMethods * 2 ];
				color: (Color red alpha: 0.2).
	b models: RTObject withAllSubclasses.
	b open
]

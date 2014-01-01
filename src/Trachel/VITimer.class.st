"
I am using system time to implement a timer.

See my supeclass (and my method comments) for more details.
"
Class {
	#name : #VITimer,
	#superclass : #VIBasicTimer,
	#instVars : [
		'active',
		'cycleLength',
		'repeat',
		'startTime',
		'elapsedCycles'
	],
	#category : #'Trachel-Viva'
}

{ #category : #private }
VITimer >> currentTime [
	^ Time millisecondClockValue 
]

{ #category : #accessing }
VITimer >> cycleLength [
	^ cycleLength
]

{ #category : #accessing }
VITimer >> cycleLength: anObject [
	cycleLength := anObject
]

{ #category : #private }
VITimer >> cycleLengthScale [
	"cycle length are given in seconds,
	while internally we using milliseconds to calculate time difference, hence scale is equal to 1000"
	
	^ 1000.0
]

{ #category : #accessing }
VITimer >> elapsedCycles [

	"Answer the total number of cycles passed during which timer was active since its first activation.
	For example, if timer's cycle length is 2 seconds, and its total active time is 3.5 seconds,
	a total number of elapsed cycles will be 3.5 / 2 = 1.75.
	
	Suspending timer (stopping then starting after a while) does not contributes to elapsedCycles, e.g.:
	for fresh timer with 4 seconds cycle, we start timer, run for 0.5 seconds, then stop it,
	wait for arbitrary amound of time, then start it again and run for extra 0.5 seconds,
	the measures elapsedCycles value will be equal to 1/4 .
	
	As you may guess, for non-repeating timer, the elapsed cycles value can never be
	greater than 1 (timer always stops at 1 and never advanced since then).
	
	Resetting timer sets elapsed cycles to zero.
	" 
	
	| cycles |
	active ifFalse: [  ^ elapsedCycles  ].

	cycles := elapsedCycles + (self elapsedTime / cycleLength).

	(repeat value not and: [ cycles  >= 1.0 ]) ifTrue: [ 
		active := false.
		^ elapsedCycles := 1.0
	].	
	^ cycles
]

{ #category : #private }
VITimer >> elapsedTime [
	^  (self currentTime - startTime) / self cycleLengthScale

]

{ #category : #'initialize-release' }
VITimer >> initialize [
	"defaults"
	repeat := false.
	cycleLength := 1.0.
	
	self reset.
]

{ #category : #testing }
VITimer >> isActive [
	self value. "making sure it will stop if cycle time elapsed for non-repeating timer"
	
	^ active
]

{ #category : #testing }
VITimer >> isRepeating [
	^ repeat 
]

{ #category : #accessing }
VITimer >> noRepeat [
	"make receiver to be non-repeating timer (stops once first cycle elapses)"
	repeat := false 
]

{ #category : #accessing }
VITimer >> repeat [
	"make receiver to be a repeating timer"
	repeat := true 
]

{ #category : #accessing }
VITimer >> repeat: veces [
	"make receiver to be a repeating timer"
	repeat := [elapsedCycles < veces ]
]

{ #category : #actions }
VITimer >> reset [
	"Reset the timer: stopping it, if it was active,
	and setting its internal elapsed cycles counter to Zero "
	
	active := false.
	elapsedCycles := 0.0.

]

{ #category : #actions }
VITimer >> start [
	"Activate (start or resume) the timer.
	Ignored if timer is already active"
	
	active ifFalse: [
		startTime := self currentTime.
		active := true.
	].

]

{ #category : #accessing }
VITimer >> startTime [
	^ startTime
]

{ #category : #actions }
VITimer >> stop [
	"Stop/pausing the timer "
	
	active ifTrue: [
		elapsedCycles := self elapsedCycles.
		active := false.
	].

]

{ #category : #accessing }
VITimer >> value [
	"Answer the current timer value.
	The value is normalized in range between 0 and 1
	relative to cycle length and elapsed time since timer started, e.g.
	if cycle length is 0:01:00
	and elapsed time is 0:00:30,
	the value will be 0.5 (half of a minute).
	For repeating timer the value goes from 0 to 1, then repeats over.
	For non-repeating timer, when value reaching 1, timer stops.
	If timer is inactive, answer the phase of cycle where it was stopped.
	"
	| cycles |

	active ifFalse: [ 
		^ repeat 
			ifTrue: [ elapsedCycles fractionPart ]
			ifFalse: [ elapsedCycles min: 1.0 ]
	].

	cycles := self elapsedCycles.
	active ifFalse: [
		 "non-repeating timer was stopped" 
		^ 1.0
	].	
	 
	^  cycles fractionPart.

]

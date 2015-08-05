"
I represent an abstract behavior of timer.

We defining a cycle length (cycleLength) for timer, expressed in seconds.
The value of timer (#value) then can be observed over time
as a number which goes from 0 to 1 and then stops.
The moment when value reaches 1 is at time equal to timer's cycle length passed from the moment we started it.
 
Timers can be one-shot or repeating.
One-shot timer stops after elapsing its cycle length, reaching value = 1.
The repeating timer keeps running repeating the cycle over and over again, and its value goes from 0 to 1 , then drops to 0 and goes again to 1 and again...
Additionally to #value, there is #elapsedCycles , which can be used to tell, how many cycles are passed since timer's first start.

Timer can be stopped (paused), resumed or fully reset. The timer value & elapsed cycles is changing only when timer active.
"
Class {
	#name : #VIBasicTimer,
	#superclass : #TRObject,
	#category : #'Trachel-Viva'
}

{ #category : #accessing }
VIBasicTimer >> cycleLength [
	"answer the timer cycle length, in seconds"
	self subclassResponsibility 
]

{ #category : #accessing }
VIBasicTimer >> cycleLength: aNumber [
	"Set the timer cycle length, in seconds"
	self subclassResponsibility 
]

{ #category : #accessing }
VIBasicTimer >> elapsedCycles [
	self subclassResponsibility 
]

{ #category : #testing }
VIBasicTimer >> isActive [
	"Answer whether timer currently active or not"
	
	self subclassResponsibility 
]

{ #category : #testing }
VIBasicTimer >> isRepeating [
	"Answer whether timer is one-shot or repeating"
	
	self subclassResponsibility 
]

{ #category : #converting }
VIBasicTimer >> mirrored [
	self error: 'not yet supported'
	"^ VIMirrorRepeatTimer on: self"
]

{ #category : #accessing }
VIBasicTimer >> noRepeat [
	self subclassResponsibility 
]

{ #category : #actions }
VIBasicTimer >> pause [
	"synonym to stop"
	
	^ self stop
]

{ #category : #accessing }
VIBasicTimer >> repeat [
	self subclassResponsibility 
]

{ #category : #actions }
VIBasicTimer >> reset [
	"Reset the timer"
	self subclassResponsibility 
]

{ #category : #actions }
VIBasicTimer >> resume [
	"synonym to start"
	
	^ self start
]

{ #category : #actions }
VIBasicTimer >> start [
	"Start the timer, after which its value change can be observed over time"
	self subclassResponsibility 
]

{ #category : #actions }
VIBasicTimer >> stop [

	"Stop the timer"
	self subclassResponsibility 
]

{ #category : #accessing }
VIBasicTimer >> value [
	"answer the current value of timer"
	self subclassResponsibility 
]

{ #category : #converting }
VIBasicTimer >> withBias: aWeight [
	self error: 'not yet supported'
	"^ (VIBiasedTimerModifier on: self) weight: aWeight"
]

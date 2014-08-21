Class {
	#name : #RTAccelerationMove,
	#superclass : #RTLinearMove,
	#category : 'Roassal2-Core'
}

{ #category : #public }
RTAccelerationMove >> to: anEndPoint during: seconds on: anElement [
	| position |
	element := anElement.
	
	position := anElement position.
	animatedValue := VIAnimatedValue new
							evaluator: [ :t | position interpolateTo: anEndPoint at: (t sqrt) ];
							timer: (VITimer new cycleLength: seconds);
							yourself.
	
]

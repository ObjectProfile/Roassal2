"
A RTMultiLinearColorForIdentityTest is a test class for testing the behavior of RTMultiLinearColorForIdentity
"
Class {
	#name : #RTMultiLinearColorForIdentityTest,
	#superclass : #TestCase,
	#category : #'Roassal2-Tests'
}

{ #category : #tests }
RTMultiLinearColorForIdentityTest >> testBasic [

	| n s e |
	n := RTMultiLinearColorForIdentity new 
				command: #first; 
				objects: #(#c1 #c2 #c3 #c4 #c5);
				yourself.
	s := RTBox new color: n.
	e := s elementsOn: #(#(c1) #(c2) #(c3) #(c4) #(c5)).
	RTView new add: e.
	
]

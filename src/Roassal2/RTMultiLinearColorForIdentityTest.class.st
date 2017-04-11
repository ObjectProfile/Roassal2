"
A RTMultiLinearColorForIdentityTest is a test class for testing the behavior of RTMultiLinearColorForIdentity
"
Class {
	#name : #RTMultiLinearColorForIdentityTest,
	#superclass : #RTTest,
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

{ #category : #tests }
RTMultiLinearColorForIdentityTest >> testDefaultColor [

	| v wordsToHighlight normalizer shape strings es |
	v := RTView new.
	
	wordsToHighlight := #('all' 'me' 'you').
	normalizer := RTMultiLinearColorForIdentity new.
	normalizer objects: wordsToHighlight.
	normalizer defaultColor: Color yellow.
	shape := RTBox new color: [ :w | normalizer rtValue: w ].
	strings := 'you and me make us all' substrings.
	es := shape elementsOn: strings.
	v addAll: es.
	es @ RTPopup.
	RTHorizontalLineLayout new gapSize: 1; on: es.

	self assert: (v elementFromModel: 'make') trachelShape color equals: Color yellow
]

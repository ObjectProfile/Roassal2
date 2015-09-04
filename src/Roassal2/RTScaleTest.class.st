Class {
	#name : #RTScaleTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Scaling-Tests'
}

{ #category : #tests }
RTScaleTest >> testLinearScale [

	| s |
	s := RTScale linear 
		domain: #(0 100);
		range: #(5 10).
	self assert: (s scale: 50) equals: 15 / 2.
	self assert: (s scale: 0) equals: 5.
	self assert: (s scale: 100) equals: 10.	
]

{ #category : #tests }
RTScaleTest >> testLinearScaleWithColors [

	| s |
	s := RTScale linear 
		domain: #(0 100);
		range: (Array with: Color white with: Color black).
	self assert: (s scale: 50) equals: Color gray.
	self assert: (s scale: 0) equals: Color white.
	self assert: (s scale: 100) equals: Color black.	
]

{ #category : #tests }
RTScaleTest >> testLinearScaleWithNegative [

	| s |
	s := RTScale linear 
		domain: #(0 100);
		range: #(-10 -5).
	self assert: (s scale: 50) equals: -15 / 2.
	self assert: (s scale: 0) equals: -10.
	self assert: (s scale: 100) equals: -5.	
]

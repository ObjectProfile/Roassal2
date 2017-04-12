"
A Roassal2VWTest is a test class for testing the behavior of Roassal2VW
"
Class {
	#name : #Roassal2VWTest,
	#superclass : #RTTest,
	#category : #'Roassal2-ExporterVW'
}

{ #category : #helpers }
Roassal2VWTest >> hasArraySelector: met [
	^ self hasRBArray: met ast.
	
]

{ #category : #helpers }
Roassal2VWTest >> hasRBArray: node [
	node class = RBArrayNode ifTrue: [ ^ true ].
	node children do: [ :child |
		(self hasRBArray: child) ifTrue: [ ^ true ].
		 ].
	^ false.
	
]

{ #category : #helpers }
Roassal2VWTest >> simple [
	"
	self new hasArraySelector: self >> #simple
	"
	"^ #(1 2)"
	^ { 1. 2 }.
]

{ #category : #tests }
Roassal2VWTest >> testNoArray [
	| t |
	t := Roassal2VW new.
	t packages do: [ :pkg | 
		(pkg classes flatCollect: #methods),
		(pkg classes flatCollect: [:cls | cls class methods]),
		(pkg package extensionsForTag: pkg) do: [ :met |
			(t blacklist includes: met) ifFalse: [ 
				self deny: (self hasArraySelector: met) 
				description: 'Remove brackets {} from: ',met methodClass name,'>>#', met selector.
				]. ] ].
]

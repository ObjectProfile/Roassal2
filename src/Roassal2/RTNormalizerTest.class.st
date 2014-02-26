Class {
	#name : #RTNormalizerTest,
	#superclass : #RTTest,
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #'gray color' }
RTNormalizerTest >> testGray [

	| n es v |
	v := RTView new.
	es := RTBox elementsOn: (0 to: 255).
	v addAll: es.
	
	n := RTGrayLinearColor new.
	n command: #yourself.
	n scope: (0 to: 255).
	
	self assert: (n rtValue: es first model) = Color white.
	self assert: (n rtValue: (es at: 100) model) = ( (Color r: 0.612 g: 0.612 b: 0.612 alpha: 1.0)).
]

{ #category : #'gray color' }
RTNormalizerTest >> testOnCharacters [

	| es n |
	n := RTGrayLinearColor new 
				command: #asInteger; 
				scope: ($a to: $z).
				
	es := RTBox new
				color: n;
				elementsOn: ($a to: $z).

	self assert: n max = $z asInteger.
	self assert: n min = $a asInteger.
	
	self assert: es first trachelShape color = Color white.
	self assert: es last trachelShape color = Color black.
]

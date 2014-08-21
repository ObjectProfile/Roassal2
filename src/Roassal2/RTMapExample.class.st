Class {
	#name : #RTMapExample,
	#superclass : #RTAbstractExample,
	#category : 'Roassal2-ExampleBrowser'
}

{ #category : #sources }
RTMapExample >> exampleCity01 [

	| b |
	b := RTMapBuilder new.
	
	b countries: RTMapBuilder southAmerica.
	b cities: #( " (name, population) pairs "
		#('Santiago' 6027000)
		#('Bogota' 6763000)
		#('Buenos Aires' 12801365)
		#('Brasilia' 2481000)
		#('Montevideo' 1338000)
		#('Lima' 8473000)
		#('La Paz' 789585)
		#('Quito' 1608000)
		#('Sao Paulo' 19889559)
		#('Caracas' 2104000))
		named: [ :c | c at: 1 ].
	
	" Cities' pop-ups show their population "
	b cities
		withPopup: [ :c | (c at: 1), ': ', (((c at: 2) / 1000000 roundTo: 0.01) asString), 'M'].
	
	" Cities' size and color depend on the population "
	b cities shape
		size: [ :c | (c at: 2)/300000 + 10 ];
		if: [ :c | (c at: 2) < 1000000 ] fillColor: (Color green alpha: 0.5);
		if: [ :c | (c at: 2) >= 1000000 and: (c at: 2) < 5000000 ] fillColor: (Color yellow alpha: 0.5);
		if: [ :c | (c at: 2) >= 5000000 ] fillColor: (Color red alpha: 0.5).
	
	" We define some routes and color them, then we set the pop-ups to show each route's length "
	b routes
		from: 'Santiago' toAll: #('Buenos Aires' 'Lima' 'Sao Paulo');
		from: 'Bogota' toAll: #('Sao Paulo' 'Brasilia' 'Quito');
		ifRoute: [ :r | r fromCityName = 'Bogota' ] lineColor: (Color brown);
		ifRoute: [ :r | r fromCityName = 'Santiago' ] lineColor: (Color blue);
		withPopup: #lengthString.
	
	" We set the countries' colors, scale, and pop-up "
	b color: Color veryVeryLightGray.
	b scale: 3.
	b withPopup.
	
	b open.
	b view canvas.

]

{ #category : #icons }
RTMapExample >> exampleCity01Icon [
	^ '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
AAAASUVORK5CYII='
]

{ #category : #sources }
RTMapExample >> exampleSouthAmericaPopulation [

	| b countries cn sum|
	b := RTMapBuilder new.	
		
	countries := RTMapBuilder countriesPopulation select: [ :c | RTSVGPath southAmerica includes: (c at: 1) ].
	sum := (countries collect: [ :c | c at: 2 ])inject: 0 into: [ :acc :n | acc + n ].
	
	cn := RTNColorLinearNormalizer
		inContext: (countries collect: [:c | c at: 2])
		lowColor: (Color r:0.8 g:0.8 b:1)
		highColor: (Color r:0 g:0 b:0.3).
	
	b countries: countries named: [ :c | c at: 1 ].
	b color: [ :c | cn rtValue: (c at: 2) ].
	b withPopup: [ :c |
		(c at: 1) asString, ': ',
		(((c at: 2) / sum * 100 asFloat roundTo: 0.01) printString), '%'].
	b scale: 2.
	b open.
	b view canvas.

]

{ #category : #icons }
RTMapExample >> exampleSouthAmericaPopulationIcon [
	^ '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
iAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTMapExample >> exampleWorldPopulation [

	| b countries cn |
	b := RTMapBuilder new.	
		
	countries := RTMapBuilder countriesPopulation select: [ :c | RTSVGPath countries includes: (c at: 1) ].
	
	cn := RTNColorLinearNormalizer
		inContext: (countries collect: [:c | c at: 2])
		lowColor: (Color r:0.8 g:0.8 b:1)
		highColor: (Color r:0 g:0 b:0.3).
	
	b countries: countries named: [ :c | c at: 1 ].
	b color: [ :dic | cn rtValue: (dic at: 2) ].
	b withPopup: [ :c | (c at: 1) asString, ': ',(((c at: 2) / 1000000 asFloat roundTo: 0.001) asString, ' Million') ].
	b open.
	b view canvas.

]

{ #category : #icons }
RTMapExample >> exampleWorldPopulationIcon [
	^ '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
TkSuQmCC'
]

{ #category : #accessing }
RTMapExample >> label [
	^ 'Geographical maps'
]

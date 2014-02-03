Class {
	#name : #RTMapBuilderExample,
	#superclass : #RTObject,
	#category : #'Roassal2-Builder-Map'
}

{ #category : #'as yet unclassified' }
RTMapBuilderExample >> citiesExample1 [
	"self new citiesExample1"
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
]

{ #category : #'as yet unclassified' }
RTMapBuilderExample >> citiesExample2 [
	"self new citiesExample2"
	| b |
	b := RTMapBuilder new.	
	
	b countries: RTMapBuilder countries.
	b cities: #(
		#('New York City' 8337000)
		#('Washington, D.C.' 632323)
		#('Paris' 2211000)
		#('Santiago' 6027000)
		#('Shanghai' 23710000))
		named: [ :c | c at: 1 ].
		
	b cities withPopup.
	b cities shape
		size: [ :c | (c at: 2)/300000 + 10 ];
		color: (Color red alpha: 0.5).
	
	b routes
		from: 'Paris' toAll: #('Santiago' 'New York City' 'Washington, D.C.' 'Shanghai');
		color: Color blue;
		withPopup: #lengthString.
	
	b color: Color veryVeryLightGray.
	b open.
]

{ #category : #'as yet unclassified' }
RTMapBuilderExample >> cityEvolution [
	"self new cityEvolution"
	| b |
	b := RTMapBuilder new.
	
	b countries: RTMapBuilder southAmerica.
	b cities: #(
		#('Santiago' #(332724 507296 696231 952075 1353400 1907378 2436398 3650541 4679900 5822316))
		#('Buenos Aires' #(950891 1800000 2200000 2700000 2970000 2966634 2972453 2922829 2965403 2776138))
		#('Sao Paulo' #(240000 400000 900000 1300000 2000000 3700000 5800000 8400000 9500000 10300000))
		#('Lima' #(120000 198875 400000 661508 1200000 1901927 3418452 4835793 6386308 7000000))
		#('Bogota' #(0 0 0 325650 715250 1697311 2855065 4000000 5200000 7000000))
		) named: [ :c | c at: 1 ].
		
	b cities evolveAt: 2
		through: #(1910 1920 1930 1940 1950 1960 1970 1980 1990 2000). " This list is only used for changing a label "
	
	" Cities' pop-ups show their population "
	b cities withPopup: [ :c |
		|population|
		population := (c at: 2) currentValue.
		(c at: 1), ': ', (population = 0 ifTrue: ['no data'] ifFalse: [((population / 1000000 roundTo: 0.01) asString), 'M'])
	].
	
	" Cities' size and color depend on the population "
	b cities shape
		size: [ :c | (c at: 2) currentValue /50000 + 10 ];
		if: [ :c | (c at: 2) currentValue < 1000000 ] fillColor: (Color green alpha: 0.5);
		if: [ :c | (c at: 2) currentValue >= 1000000 and: (c at: 2) currentValue < 5000000 ] fillColor: (Color yellow alpha: 0.5);
		if: [ :c | (c at: 2) currentValue >= 5000000 ] fillColor: (Color red alpha: 0.5);
		if: [ :c | (c at: 2) currentValue = 0 ] fillColor: (Color black alpha: 0.5).
	
	" We set the countries' colors, scale, and pop-up "
	b color: Color veryVeryLightGray.
	b scale: 3.
	b withPopup.
	
	b open.
]

{ #category : #'as yet unclassified' }
RTMapBuilderExample >> simpleExample [
	"self new simpleExample"
	| b |
	b := RTMapBuilder new.	
		
	b countries: #('Chile').
	b color: Color red.
	b scale: 3.
	b open.
]

{ #category : #'as yet unclassified' }
RTMapBuilderExample >> southAmericaPopulation [
	"self new southAmericaPopulation"
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
]

{ #category : #'as yet unclassified' }
RTMapBuilderExample >> worldPopulation [
	"self new worldPopulation"
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
]

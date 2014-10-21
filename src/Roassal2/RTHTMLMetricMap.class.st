"
A RTHTMLMetricMap is a RTHTMLBuilder that mimics the functionality of RTMetricMap to directly have exported results.
"
Class {
	#name : #RTHTMLMetricMap,
	#superclass : #RTHTMLBuilder,
	#instVars : [
		'countryData',
		'countryName',
		'menus'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #hooks }
RTHTMLMetricMap >> addCustomizations [
	exporter
		title: 'MetricMap';
		fileName: 'metricmap'.
	menus keysAndValuesDo: [ :k  :v | RTSVGButton on: exporter name: k values: [ :e |  (v select: [ :i | e = i first ]) first third rtValue: e] targets: TRSVGPath ].
	RTSVGBoxedTextPopup on: exporter targets: TRSVGPath.
]

{ #category : #public }
RTHTMLMetricMap >> allCountriesColor: aColor [
	^ self countries: RTSVGPath countries color: aColor

]

{ #category : #utility }
RTHTMLMetricMap >> convertIntoSVGCountryName: aName [
	| normalizedName |
	aName = 'Mauritius' ifTrue: [ ^ #Mauritania ].
	aName = 'Russian Federation' ifTrue: [ ^ #Russia ].
	aName = 'Turkey' ifTrue: [ ^ #RepublicofTurkey ].
	
	#(
		#('FR' #France) 
		#('UK' #GreatBritian)
		#('DE' #Germany)
		#('US' #UnitedStates)
		#('CH' #Switzerland)
		#('CA' #Canada)
		#('AU' #Austria)
		#('IE' #Israel)
		#('IT' #Italy)) do: [ :arr | arr first = aName ifTrue: [ ^ arr second ] ].
	
	normalizedName := (aName copyWithoutAll: '. ') asSymbol.
	^ (RTSVGPath class methodDict keys includes: normalizedName)
			ifTrue: [ normalizedName ]
			ifFalse: [ nil ]
]

{ #category : #adding }
RTHTMLMetricMap >> countries: countryNames [
	^ self countries: countryNames color: [ :c | Color random ]
]

{ #category : #public }
RTHTMLMetricMap >> countries: countryNames color: aColor [
	"Display a list of countries"
	countryNames do: [ :country |
		| elem |
		elem := (RTSVGPath new
			path: (RTSVGPath perform: country asSymbol);
			fillColor: aColor;
			scale: 1) elementOn:(country asString).
		view add: elem.
	].
]

{ #category : #adding }
RTHTMLMetricMap >> countries: collection named: selectorOrBlockForName [
	collection do: [ :country |
		| elem |
		elem := (RTSVGPath new
			path: (RTSVGPath perform: (selectorOrBlockForName rtValue: country) asSymbol);
			fillColor: Color random;
			scale: 1) elementOn: (country asString).
		view add: elem.
	].
]

{ #category : #public }
RTHTMLMetricMap >> countries: collection named: selectorOrBlockForName metric: selectorOrBlockForMetric [
	countryData := collection.
	countryName := selectorOrBlockForName.
	self fillViewWithCountries: countryData named: countryName metric: selectorOrBlockForMetric
]

{ #category : #private }
RTHTMLMetricMap >> fillViewWithCountries: collection named: selectorOrBlockForName metric: selectorOrBlockForMetric [
	
	| triplets |
	
	triplets := self getTripletsFor: collection named: selectorOrBlockForName  metric: selectorOrBlockForMetric. 
									
	triplets do: [ :t |
		| elem |
		elem := (RTSVGPath new
			path: (RTSVGPath perform: t second);
			fillColor: t third;
			scale: 1) elementOn: t first.
		view add: elem.
	].
]

{ #category : #private }
RTHTMLMetricMap >> getTripletsFor: collection named: selectorOrBlockForName metric: selectorOrBlockForMetric [
	
	| cn maxValue cName svgCountryName normalizedCountries cFillColor triplets|
	
	cn := RTMultiLinearColor new colors: (Array with: (Color r:0.8 g:0.8 b:1) with: (Color r:0 g:0 b:0.3)).
	maxValue := (collection collect: selectorOrBlockForMetric) max.
	normalizedCountries := collection select: [ :country | 
										cName := selectorOrBlockForName rtValue: country.
										svgCountryName := self convertIntoSVGCountryName: cName. 
										svgCountryName notNil ].
									
	triplets := normalizedCountries collect: [ :country |
		cName := selectorOrBlockForName rtValue: country.
		svgCountryName := self convertIntoSVGCountryName: cName.
		cFillColor := [ :cc | cn level: (selectorOrBlockForMetric rtValue: cc) / maxValue ].
		Array with: country with: svgCountryName with: cFillColor
	].
	^triplets
]

{ #category : #initialization }
RTHTMLMetricMap >> initialize [
	super initialize.
	menus := Dictionary new.
]

{ #category : #public }
RTHTMLMetricMap >> makeSelectable: aBlock as: title [
	menus at: title put: (self getTripletsFor: countryData named: countryName metric: aBlock).
]

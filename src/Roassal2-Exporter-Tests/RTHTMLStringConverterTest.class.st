Class {
	#name : #RTHTMLStringConverterTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Exporter-Tests'
}

{ #category : #tests }
RTHTMLStringConverterTest >> testBasic [

	self assert: (RTHTMLStringConverter new convertString: 'Hello world') equals: 'Hello&#160;world' 
]

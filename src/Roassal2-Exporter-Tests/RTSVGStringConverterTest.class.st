Class {
	#name : #RTSVGStringConverterTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Exporter-Tests'
}

{ #category : #tests }
RTSVGStringConverterTest >> testBasic [

	self assert: (RTSVGStringConverter new convertString: 'Hello world') equals: 'Hello&#160;world' 
]

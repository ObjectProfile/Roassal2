Class {
	#name : #RTSVGStringConverterTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Exporter-Tests'
}

{ #category : #tests }
RTSVGStringConverterTest >> testBasic [

	self
		assert: (RTSVGStringConverter new convertString: '< What''s up? >')
		equals: '&lt; What&apos;s up? &gt;'
]

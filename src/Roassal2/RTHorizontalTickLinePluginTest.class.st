Class {
	#name : #RTHorizontalTickLinePluginTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #tests }
RTHorizontalTickLinePluginTest >> testDefault [

	| b p |
	b := RTGrapherBuilder new.
	p := RTHorizontalTickLinePlugin new.
	p builder: b.
	p lineFrom: 10 @ 10 to: 20 @ 20.
]

Class {
	#name : #RTGraphBuilderExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #'as yet unclassified' }
RTGraphBuilderExample >> exampleFading [

	| b |
	b := RTGraphBuilder new.
	b nodes shape: (RTEllipse new size: 40).

	b global
		normalizeColor: #yourself using: (Array with: Color green with: Color red).

	b layout use: RTGridLayout new.
	b addAll: (1 to: 20).
	b open.
	b view canvas

]

{ #category : #'as yet unclassified' }
RTGraphBuilderExample >> exampleFadingIcon [
	^ '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
QmCC'
]

{ #category : #'as yet unclassified' }
RTGraphBuilderExample >> exampleSimple01 [

	| b |
	b := RTGraphBuilder new.
	b nodes
		if: [ :obj | obj < 15 ]; shape: (RTEllipse new size: 20; color: Color blue).
	b nodes
		if: [ :obj | obj >= 15 ]; shape: (RTEllipse new size: 10; color: Color red).
		
	b layout 
		if: [ :obj | obj < 15 ]; use: (RTCircleLayout new).
	b layout
		if: [ :obj | obj >= 15 ]; use: (RTGridLayout new).
	b addAll: (1 to: 20).
	b open.
	b view canvas.

]

{ #category : #'as yet unclassified' }
RTGraphBuilderExample >> exampleSimple01Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAADRElEQVR4XuXcTShlYRzH8V/q
MhsbLBQLSaaUZrw0xssMKWpqLJQok4WFhWLKlBrKS7ExTczKQlKamZUVS1FsZGGpWMgaSyFE
5nk6o3Ovhrm48Zzz/XRP92yee5/n+d/zvN1zHvHx8d0lS3qfLjXmS/n/OrKlbH4tPaGP5mUq
/tdr6XuV9KVYGjPvPeXS1zfSkHkv59fSEzLB+P1O6n4p/SySvpnzz6+kHx/MVVMnfeIH5Bmu
kLsOfkD4+Pj4+Pj4+Pj4+Pj4+Pj4+MLkhXkNmZXhu875npCt9CvpqlVqve388d8yOGg+znxk
XV38aZKTvTT2yMrCBOStedlSR6TIbeeP+4bmZhPXK/9IS4sv3cqKn2Zzk99kJazJGh+PDUh9
fXzpotPYg99kJajJqq72K/XgIP50MzN+uqUlfpOVsCbLKi72+oKUlPul6+gw/0j38Ht6viDJ
y/NHPzk5jjXAf/PV3g4KyMmJ37YfH7uTr97e2EFAQQEkIK6OfuyVEZ2vzk5IQEZG/ELbCZ8r
MjP9fO3t8bsWZyQl8euAj4+Pj4+Pj4/vv3Z3vbH8+nr4ytbU5M9VamoCkOGbs92uLv4qw7Nq
a4vNcG1tuAJyduaXbWcnIJkeHpY2NryrJWzsn2Vzc9LsrFRRwe+e+Pj4+Pj4+Pj4+Pj4+Fxl
Z+ULC1J/P6fMlZXS5KR3ODVrt7fLRK9fFRUxArK/7+hdKjdXeO3jAwTOrvxGItLhoZeptTVO
k9XQ4AfDbp7Ex8fHx8fHx8fHx8fHx+emqipvOaWwMJzls2ULzCKqvTEuen2npCRcwdja8su2
uhqQX090QAYGwhWQwN1KWlrqZ/b8XEpPD1dAFhf98k1PByTTubnelZKREc4+pLsbtrEAHx8f
Hx8fHx/fQ9iHJbe3vVmvfSLJJVNT0sWFt0EOhp0wXk+uTk/dyVdfX+ws3N4IhxCU/bIaGyEB
id5l1LUmyz6savM1P8/vWvj4+B4kNVU6OvKakuXl+43mrpvGlhZ+PSbM2FhsZ2s3VQ7y4CHw
RkdjK9Yu7993eM0PSILZnYVspU5MxJ+mrMzbI/jy0r3RHB8fHx8fHx8fHx8fHx8fHx8fHx8f
Hx8fHx+fA/4A7jmRoQn4CJgAAAAASUVORK5CYII='
]

{ #category : #'as yet unclassified' }
RTGraphBuilderExample >> label [
	^ 'Graph builder'
]

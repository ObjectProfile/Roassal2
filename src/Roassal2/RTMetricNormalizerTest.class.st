Class {
	#name : #RTMetricNormalizerTest,
	#superclass : #RTTest,
	#category : 'Roassal2-ColorNormalizer'
}

{ #category : #'test y' }
RTMetricNormalizerTest >> testBasicNegativeRange [
	
	| es |
	es := RTEllipse new elementsOn: (Array with: 0 @ 0 with: 50 @ 25 with: 100 @ 50).

	RTMetricNormalizer new
			elements: es;
			normalizeY: #y min: -200 max: 200.
	self assert: (es collect: #position) asArray equals: (Array with: 0 @ -200 with: 0 @ 0 with: 0 @ 200)
]

{ #category : #'test y' }
RTMetricNormalizerTest >> testBasicNegativeRange2 [
	
	| es |
	es := RTEllipse new elementsOn: (Array with: 0 @ 0 with: 50 @ 25 with: 100 @ 50).

	RTMetricNormalizer new
			elements: es;
			normalizeY: #y min: -200 max: -100.
	self assert: (es collect: #position) asArray equals: (Array with: 0 @ -200 with: 0 @ -150 with: 0 @ -100)
]

{ #category : #'test y' }
RTMetricNormalizerTest >> testBasicNegativeRange3 [
	
	| es |
	es := RTEllipse new elementsOn: (Array with: 0 @ 0 with: 50 @ 25 with: 100 @ 50).

	RTMetricNormalizer new
			elements: es;
			normalizeY: #y min: 0 max: -200.
	self assert: (es collect: #position) asArray equals: (Array with: 0 @ 0 with: 0 @ -100 with: 0 @ -200)
]

{ #category : #'test y' }
RTMetricNormalizerTest >> testBasicNegativeRange4 [
	
	| es |
	es := RTEllipse new elementsOn: (Array with: 0 @ 0 with: 50 @ 25 with: 100 @ 50).

	RTMetricNormalizer new
			elements: es;
			normalizeY: #y min: -200 max: 0.
	self assert: (es collect: #position) asArray equals: (Array with: 0 @ -200 with: 0 @ -100 with: 0 @ 0)
]

{ #category : #'test x' }
RTMetricNormalizerTest >> testBasicNegativeRangeX [
	
	| es |
	es := RTEllipse new elementsOn: (Array with: 0 with: 25 with: 50).

	RTMetricNormalizer new
			elements: es;
			normalizeX: #yourself min: -200 max: 200.
	self assert: (es collect: #position) asArray equals: (Array with: -200 @ 0 with: 0 @ 0 with: 200 @ 0)
]

{ #category : #'test y' }
RTMetricNormalizerTest >> testBasicPositiveRange [
	
	| es |
	es := RTEllipse new elementsOn: (Array with: 0 @ 0 with: 50 @ 25 with: 100 @ 50).

	RTMetricNormalizer new
			elements: es;
			normalizeY: #y min: 0 max: 200.
	self assert: (es collect: #position) asArray equals: (Array with: 0 @ 0 with: 0 @ 100 with: 0 @ 200)
]

{ #category : #'test size' }
RTMetricNormalizerTest >> testBasicPositiveRangeSize [
	
	| es |
	es := RTEllipse new elementsOn: (Array with: 0 with: 25 with: 50).

	RTMetricNormalizer new
			elements: es;
			normalizeSize: #yourself min: 0 max: 200.
	self assert: (es collect: [ :e | e extent x ]) asArray equals: (Array with: 0 with: 100 with: 200)
]

{ #category : #'test x' }
RTMetricNormalizerTest >> testBasicPositiveRangeX [
	
	| es |
	es := RTEllipse new elementsOn: (Array with: 0 with: 25 with: 50).

	RTMetricNormalizer new
			elements: es;
			normalizeX: #yourself min: 0 max: 200.
	self assert: (es collect: #position) asArray equals: (Array with: 0 @ 0 with: 100 @ 0 with: 200 @ 0)
]

{ #category : #'test x' }
RTMetricNormalizerTest >> testBasicPositiveRangeX2 [
	
	| es |
	es := RTEllipse new elementsOn: (Array with: 25 with: 50).

	RTMetricNormalizer new
			elements: es;
			normalizeX: #yourself min: 0 max: 200 minValue: 0 maxValue: 50.
	self assert: (es collect: #position) asArray equals: (Array with: 100 @ 0 with: 200 @ 0)
]

{ #category : #'test x' }
RTMetricNormalizerTest >> testBasicPositiveRangeX3 [
	
	| es |
	es := RTEllipse new elementsOn: (Array with: 25 with: 50).

	RTMetricNormalizer new
			elements: es;
			normalizeX: #yourself min: 0 max: 200 minValue: 0.
	self assert: (es collect: #position) asArray equals: (Array with: 100 @ 0 with: 200 @ 0)
]

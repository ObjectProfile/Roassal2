Class {
	#name : #RTDSMTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Builder-DSM'
}

{ #category : #tests }
RTDSMTest >> testDefault [

	| dsm |
	dsm := RTDSM new.
	self assert: dsm numberOfObjects equals: 0
]

{ #category : #tests }
RTDSMTest >> testDep [

	| dsm v ts |
	dsm := RTDSM new.
	dsm doNotShowLabels.
	dsm objects: (1 to: 10).
	dsm dependency: [ :aValue | aValue // 2 ].
	dsm build.
	v := dsm view.
	self assert: v numberOfElements equals: 100.
	
	ts := v elements collect: [ :e | e trachelShape color ].
	self assert: ts asSet size equals: 2 

]

{ #category : #tests }
RTDSMTest >> testExample01 [

	| dsm |
	dsm := RTDSM new.
	dsm objects: RTShape withAllSubclasses.
	dsm dependency: #dependentClasses.
	dsm build
]

{ #category : #tests }
RTDSMTest >> testExample02 [

	| dsm es column5 row5 |
	dsm := RTDSM new.
	dsm objects: (1 to: 10).
	dsm dependency: [ :aValue | aValue // 2 ].
	dsm build.
	
	es := dsm elements.
	self assert: es size equals: 100.
	self assert: (dsm elementAt: 1 @ 1) model equals: 1 -> 1.
	self assert: (dsm elementAt: 3 @ 1) model equals: 1 -> 3.
	self assert: (dsm elementAt: 10 @ 10) model equals: 10 -> 10.
	self assert: (dsm elementAt: 5 @ 2) model equals: 2 -> 5.
	
	column5 := dsm columnAt: 5.
	self assert: column5 size equals: 10.
	self assert: column5 first model equals: 1 -> 5.
	
	row5 := dsm rowAt: 5.
	self assert: row5 size equals: 10.
	self assert: row5 first model equals: 5 -> 1.
	
	column5 first announce: (TRMouseEnter new shape: column5 first trachelShape)
]

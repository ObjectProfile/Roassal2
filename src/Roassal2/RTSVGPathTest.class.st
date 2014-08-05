Class {
	#name : #RTSVGPathTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
}

{ #category : #'point inclusion' }
RTSVGPathTest >> testIncludesPointBasic [
	| v e |
	v := RTView new.
	e := (RTSVGPath new path: 'M 100 100 L 300 100 L 200 300 z') element.
	v add: e.
	self assert: (e trachelShape includesPoint: 200@200).
	self assert: (e trachelShape includesPoint: 200@80) not
]

{ #category : #tests }
RTSVGPathTest >> testParseSimple [
	|res p1 |
	res := '{#m->{(100.0@100.0)}. #l->{(300.0@100.0)}. #l->{(200.0@300.0)}. #l->{(100.0@100.0)}}'.
	p1 := (TRSVGPath new path: 'M 100 100 L 300 100 L 200 300 z') processPath asString.
	self assert: p1 = res.
	
	"
	According to the specification: 
	
	The command letter can be eliminated on subsequent commands if the same command is used multiple times in a row (e.g., you can drop the second 'L' in 'M 100 200 L 200 100 L 	-100 -200' and use 'M 100 200 L 200 100 -100 -200' instead).
		
	Hence, the following assertion should be true:
	
	p2 := (RTSVGPath new path: 'M 100 100 L 300 100 200 300 z') processPath asString.
	self assert: p2 = res."
]

{ #category : #tests }
RTSVGPathTest >> testTranslateBy [
	| v e |
	v := RTView new.
	e := (RTSVGPath new path: 'M200,200l100,0l0,100l-100,0z') element.
	v add: e.
	self assert: (e trachelShape includesPoint: 210@210).
	e translateBy: -10@0.
	self assert: (e trachelShape includesPoint: 200@200).
	self assert: (e trachelShape includesPoint: 0@0) not.
]

{ #category : #tests }
RTSVGPathTest >> testTranslateTo [
	| v e |
	v := RTView new.
	e := (RTSVGPath new path: 'M200,200l100,0l0,100l-100,0z') element.
	v add: e.
	self assert: (e trachelShape includesPoint: 210@210).
	e translateTo: 0@0.
	self assert: (e trachelShape includesPoint: 200@200) not.
	self assert: (e trachelShape includesPoint: 0@0).
]

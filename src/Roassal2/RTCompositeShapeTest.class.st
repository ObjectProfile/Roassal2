Class {
	#name : #RTCompositeShapeTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
}

{ #category : #centering }
RTCompositeShapeTest >> testCenter [
	| v es shape |
	v := RTView new. 
	shape := RTCompositeShape new.
	shape add: (RTBox new height: 10; color: Color green; width: #yourself).
	shape add: (RTBox new height: 10; color: Color red; width: [ :cc | 100 - cc ]).

	es := shape elementsOn: #(0 50 100).
	v addAll: es.
	
	self assert: es first position equals: 0 @ 0.
	self assert: es second position equals: 0 @ 0.
	self assert: es third position equals: 0 @ 0.

]

{ #category : #centering }
RTCompositeShapeTest >> testCenter2 [
	| v es shape |
	v := RTView new. 
	shape := RTCompositeShape new.
	shape add: (RTBox new height: 10; color: Color green; width: #yourself).
	shape add: (RTBox new height: 10; color: Color red; width: [ :cc | 100 - cc ]).
	shape horizontal.
	
	es := shape elementsOn: #(0 50 100).
	v addAll: es.
	
	self assert: es first position equals: 0 @ 0.
	self assert: es second position equals: 0 @ 0.
	self assert: es third position equals: 0 @ 0.

]

{ #category : #centering }
RTCompositeShapeTest >> testCenter2AndTranslation [
	| v es shape |
	v := RTView new. 
	shape := RTCompositeShape new.
	shape add: (RTBox new height: 10; color: Color green; width: #yourself).
	shape add: (RTBox new height: 10; color: Color red; width: [ :cc | 100 - cc ]).
	shape horizontal.
	
	es := shape elementsOn: #(0 50 100).
	v addAll: es.
	es translateTo: 10 @ 10.
	
	self assert: es first position equals: 10 @ 10.
	self assert: es second position equals: 10 @ 10.
	self assert: es third position equals: 10 @ 10.

]

{ #category : #centering }
RTCompositeShapeTest >> testCenter3 [
	| v es shape |
	v := RTView new. 
	shape := RTCompositeShape new.
	shape add: (RTBox new height: 10; color: Color green; width: #yourself).
	shape add: (RTBox new height: 10; color: Color red; width: [ :cc | 100 - cc ]).
	shape vertical.
	
	es := shape elementsOn: #(0 50 100).
	v addAll: es.
	
	self assert: es first position equals: 0 @ 0.
	self assert: es second position equals: 0 @ 0.
	self assert: es third position equals: 0 @ 0.

]

{ #category : #centering }
RTCompositeShapeTest >> testCenter3AndTranslation [
	| v es shape |
	v := RTView new. 
	shape := RTCompositeShape new.
	shape add: (RTBox new height: 10; color: Color green; width: #yourself).
	shape add: (RTBox new height: 10; color: Color red; width: [ :cc | 100 - cc ]).
	shape vertical.
	
	es := shape elementsOn: #(0 50 100).
	v addAll: es.
	es translateTo: 10 @ 10.
	
	self assert: es first position equals: 10 @ 10.
	self assert: es second position equals: 10 @ 10.
	self assert: es third position equals: 10 @ 10.

]

{ #category : #centering }
RTCompositeShapeTest >> testCenterAndTranslation [
	| v es shape |
	v := RTView new. 
	shape := RTCompositeShape new.
	shape add: (RTBox new height: 10; color: Color green; width: #yourself).
	shape add: (RTBox new height: 10; color: Color red; width: [ :cc | 100 - cc ]).

	es := shape elementsOn: #(0 50 100).
	v addAll: es.
	es translateTo: 10 @ 10.
	
	self assert: es first position equals: 10 @ 10.
	self assert: es second position equals: 10 @ 10.
	self assert: es third position equals: 10 @ 10.

]

{ #category : #centering }
RTCompositeShapeTest >> testCenterVerticalLineLayout [
	| v es shape |
	v := RTView new. 
	shape := RTCompositeShape new.
	shape add: (RTBox new height: 10; color: Color green; width: #yourself).
	shape add: (RTBox new height: 10; color: Color red; width: [ :cc | 100 - cc ]).
	shape horizontal.
	
	es := shape elementsOn: #(0 50 100).
	v addAll: es.
	RTVerticalLineLayout on: es.

	self assert: es second width equals: 100.0.
	
	self assert: (es collect: [ :e | e width ]) asArray equals: #(100 100 100).
	self assert: (es collect: [ :e | e position x ]) asArray equals: #(50 50 50).
	
	self assert: es first trachelShape shapes first encompassingRectangle  equals: ( (0.0@0.0) corner: (0.0@10.0)).
	self assert: es first trachelShape shapes second encompassingRectangle  equals: ( (0.0@0.0) corner: (100.0@10.0)).
	
	self assert: es second trachelShape shapes first encompassingRectangle equals: ( (0.0@20.0) corner: (50.0@30.0)).
	self assert: es second trachelShape shapes second encompassingRectangle  equals: ( (50.0@20.0) corner: (100.0@30.0)).
	
	self assert: es third trachelShape shapes first encompassingRectangle equals: ( (0.0@40.0) corner: (100.0@50.0)).
	self assert: es third trachelShape shapes second encompassingRectangle equals: ( (100.0@40.0) corner: (100.0@50.0)).
]

{ #category : #centering }
RTCompositeShapeTest >> testCenterVerticalLineLayout2 [
	| v es shape |
	v := RTView new. 
	shape := RTCompositeShape new.
	shape add: (RTBox new height: 10; color: Color green; width: #yourself).
	shape add: (RTBox new height: 10; color: Color red; width: [ :cc | 100 - cc ]).
	shape horizontal.
	
	es := shape elementsOn: #(0 100).
	v addAll: es.
	RTVerticalLineLayout on: es.
			
	self assert: es first trachelShape shapes first encompassingRectangle  equals: ( (0.0@0.0) corner: (0.0@10.0)).
	self assert: es first trachelShape shapes second encompassingRectangle  equals: ( (0.0@0.0) corner: (100.0@10.0)).
	
	self assert: es second trachelShape shapes first encompassingRectangle equals: ( (0.0@20.0) corner: (100.0@30.0)).
	self assert: es second trachelShape shapes second encompassingRectangle  equals: ( (100.0@20.0) corner: (100.0@30.0)).
	

]

{ #category : #tests }
RTCompositeShapeTest >> testRemoving [

	| s e v |
	s := RTCompositeShape new.
	s add: RTLabel new.
	s add: RTBox new.
	e := s element.
	
	v := RTView new.
	v add: e.
	self assert: v numberOfElements equals: 1.
	
	e remove.
	self assert: v numberOfElements equals: 0.
]

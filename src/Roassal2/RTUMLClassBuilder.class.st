"
I am a builder to create UML diagrams in Roassal2, see examples
"
Class {
	#name : #RTUMLClassBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'classes',
		'classesGroup',
		'classname',
		'instanceVariables',
		'methodsNames',
		'superclass',
		'methodselector',
		'methodShapeBuilder',
		'layout'
	],
	#category : #'Roassal2-Builder-UML'
}

{ #category : #public }
RTUMLClassBuilder >> addClass: class [
	| group box r label e1 e2  l h |
	group := RTGroup new.
	classes add: class.
	
	group add: ((RTLabel new height: 15; 
		text: [:c| self classNameFor: c]) 
		elementOn: class).
		
	(self varNamesFor: class) do: [ :varName |
		group add: (RTLabel elementOn: varName)	].
	RTVerticalLineLayout on: group.
	r := group encompassingRectangle.
	h := r height.
	label := RTLabel new text: [ :e | (self selectorForMethod: e) ].
	(self methodsForClass: class) do: [:method | 
		group add: (label elementOn: method) ].
	
	RTVerticalLineLayout on: group.
	r := group encompassingRectangle.
	group first trachelShape translateTo: (r center x @ group first trachelShape center y).
	box := (RTBox new color: Color white; borderColor: Color black) elementOn: class.
	e1 := (RTBox new extent: 0@0) elementOn: 'p1'.
	e2 := (RTBox new extent: 0@0) elementOn: 'p2'.
	e1 trachelShape translateTo: r left@h.
	e2 trachelShape translateTo: r right@h.
	l := RTEdge from: e1 to: e2.
	l + (RTLine new color: Color black).
	group add: e1; add: e2; add: l.
	RTNest new on: box nest: group.
	
	box @ RTDraggable.
	classesGroup add: box.
	view add: box.
	view addAll: group.
]

{ #category : #public }
RTUMLClassBuilder >> addObject: object [
	
	classes add: object.
	
]

{ #category : #public }
RTUMLClassBuilder >> addObjects: objects [
	objects do: [ :obj | self addObject: obj ].
]

{ #category : #public }
RTUMLClassBuilder >> applyLayout [
	self layout on: classesGroup elements.
]

{ #category : #public }
RTUMLClassBuilder >> buildSchema [
	| group box r label e1 e2  l h |
	shapeBuilder := self methodShape.
	(shapeBuilder shape class = RTNoShape) ifTrue: [
		shapeBuilder label].
	shapeBuilder text: [ :met | (self selectorForMethod: met)].
	classes do: [ :object | 
		group := RTGroup new.
		
		group add: ((RTLabel new height: 15; 
			text: [:c| self classNameFor: c]) 
			elementOn: object).

		(self varNamesFor: object) do: [ :varName |
			group add: (RTLabel elementOn: varName)	].
		RTVerticalLineLayout on: group.
		r := group encompassingRectangle.
		h := r height.
		
		label := shapeBuilder shape.
		(self methodsForClass: object) do: [:method | 
			group add: (label elementOn: method) ].
	
		RTVerticalLineLayout on: group.
		r := group encompassingRectangle.
		group first trachelShape 
			translateTo: (r center x @ group first trachelShape center y).
		box := (RTBox new color: Color white; borderColor: Color black) 
			elementOn: object.
		e1 := (RTBox new extent: 0@0) elementOn: 'p1'.
		e2 := (RTBox new extent: 0@0) elementOn: 'p2'.
		e1 trachelShape translateTo: r left@h.
		e2 trachelShape translateTo: r right@h.
		l := RTEdge from: e1 to: e2.
		l + (RTLine new color: Color black).
		group add: e1; add: e2; add: l.
		RTNest new on: box nest: group.
	
		box @ RTDraggable.
		classesGroup add: box.
		view add: box.
		view addAll: group.
	].

	RTEdge buildEdgesFromObjects: 
		classes from: (self superclass) to: #yourself using: (RTMultiLine new orthoVertical attachPoint: RTVerticalAttachPoint instance) inView: view
]

{ #category : #accessing }
RTUMLClassBuilder >> classNameFor: obj [
	^ obj perform: self classname.
]

{ #category : #accessing }
RTUMLClassBuilder >> classname [
	^ classname
	
]

{ #category : #accessing }
RTUMLClassBuilder >> classname: aSelector [
	classname := aSelector
	
]

{ #category : #public }
RTUMLClassBuilder >> createView [
	^ super createView @ RTDraggableView
]

{ #category : #examples }
RTUMLClassBuilder >> example1 [
	"
	self new example1
	"

	RTUMLClassBuilder new
		addObjects: RTShape withAllSubclasses;
		gridLayout;
		open.
]

{ #category : #examples }
RTUMLClassBuilder >> example2 [
	"
	self new example2
	"

	RTUMLClassBuilder new
		addObjects: RTShape withAllSubclasses;
		treeLayout;
		open.
		
]

{ #category : #examples }
RTUMLClassBuilder >> example3 [
	"
	self new example3
	"
	| objects|
	objects :=  {
		{ 'MyClass' . { 'iv1' . 'iv2' } . { 'method1' . 'method2' . 'method3' }}  .
		{ 'MyClass2' . { 'iv2' . 'iv1' } . { 'method1' . 'method2' . 'method4' }}  }.

	RTUMLClassBuilder new
		addObjects: objects;
		classname: #first;
		instanceVariables: #second;
		methodsNames: #third;
		methodselector: #yourself;
		superclass: nil;
		open
]

{ #category : #examples }
RTUMLClassBuilder >> example4 [
	"
	self new example4
	"
	| b |
	b := RTUMLClassBuilder new.
	b methodShape label
        if: [ :method | method selector beginsWith: 'init' ] color: Color green.
	b addObjects: RTShape withAllSubclasses.
	b treeLayout; open.
		
]

{ #category : #layouts }
RTUMLClassBuilder >> gridLayout [
	^ self layout: RTGridLayout new.
]

{ #category : #initialization }
RTUMLClassBuilder >> initialize [
	super initialize.
	classesGroup := RTGroup new.
	classes := OrderedCollection new.
	
	self classname: #name.
	self instanceVariables: #instVarNames.
	self methodsNames: #methods.
	self superclass: #superclass.
	self methodselector: #selector.

	self methodShape: RTMethodShapeBuilder new.
]

{ #category : #accessing }
RTUMLClassBuilder >> instanceVariables [
	^ instanceVariables
]

{ #category : #accessing }
RTUMLClassBuilder >> instanceVariables: aSelector [
	instanceVariables := aSelector
]

{ #category : #accessing }
RTUMLClassBuilder >> layout [
	layout ifNil: [ layout := RTHorizontalLineLayout new ].
	^ layout
]

{ #category : #accessing }
RTUMLClassBuilder >> layout: aRTLayout [
	^ layout := aRTLayout
]

{ #category : #shapes }
RTUMLClassBuilder >> methodShape [
	^ methodShapeBuilder
]

{ #category : #accessing }
RTUMLClassBuilder >> methodShape: aMethodShapeBuilder [
	methodShapeBuilder := aMethodShapeBuilder
]

{ #category : #accessing }
RTUMLClassBuilder >> methodsForClass: obj [
	^ obj perform: self methodsNames
]

{ #category : #accessing }
RTUMLClassBuilder >> methodsNames [
	^ methodsNames
]

{ #category : #accessing }
RTUMLClassBuilder >> methodsNames: aSelector [
	methodsNames := aSelector
]

{ #category : #accessing }
RTUMLClassBuilder >> methodselector [
	^ methodselector.
]

{ #category : #accessing }
RTUMLClassBuilder >> methodselector: aSelector [
	methodselector := aSelector.
]

{ #category : #hooks }
RTUMLClassBuilder >> renderIn: aView [
	self buildSchema.
	self applyLayout
]

{ #category : #accessing }
RTUMLClassBuilder >> selectorForMethod: method [
	^ self methodselector value: method
]

{ #category : #accessing }
RTUMLClassBuilder >> superclass [
	^ superclass
]

{ #category : #accessing }
RTUMLClassBuilder >> superclass: aSelector [
	superclass := aSelector
]

{ #category : #layouts }
RTUMLClassBuilder >> treeLayout [
	^ self layout: RTTreeLayout new
]

{ #category : #accessing }
RTUMLClassBuilder >> varNamesFor: object [
	^ self instanceVariables value: object
]

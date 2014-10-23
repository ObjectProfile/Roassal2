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
		'layout',
		'attributeselector',
		'attributeShapeBuilder'
	],
	#category : #'Roassal2-Builder-UML'
}

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

{ #category : #shapes }
RTUMLClassBuilder >> attributeShape [
	^ attributeShapeBuilder
]

{ #category : #shapes }
RTUMLClassBuilder >> attributeShape: aUMLShapeBuilder [
	attributeShapeBuilder := aUMLShapeBuilder
]

{ #category : #accessing }
RTUMLClassBuilder >> attributesOf: object [
	^ self instanceVariables ifNil: [ #() ] ifNotNil: [ :m | m rtValue: object]
]

{ #category : #accessing }
RTUMLClassBuilder >> attributeselector [
	^ attributeselector
]

{ #category : #accessing }
RTUMLClassBuilder >> attributeselector: aSelector [
	attributeselector := aSelector.
]

{ #category : #public }
RTUMLClassBuilder >> buildEdges [
	RTEdge buildEdgesFromObjects: 
		classes from: (self superclass) to: #yourself using: (RTMultiLine new orthoVertical attachPoint: RTVerticalAttachPoint instance) inView: view
]

{ #category : #public }
RTUMLClassBuilder >> buildSchema: aView [
	| group box r label e1 e2  l h |
	self prepare: self methodShape selector: #methodselector.
	self prepare: self attributeShape selector: #attributeselector.

	classes do: [ :object | 
		group := RTGroup new.
		
		group add: ((RTLabel new height: self fontSizeOfClassname; 
			text: [:c| self classNameFor: c]) 
			elementOn: object).
			
		label := self attributeShape shape.
		(self attributesOf: object) do: [ :attribute |
			group add: (label elementOn: attribute) ].
		RTVerticalLineLayout new gapSize: 0; on: group.
		r := group encompassingRectangle.
		h := r height.
		
		label := self methodShape shape.
		(self methodsForClass: object) do: [:method | 
			group add: (label elementOn: method) ].
	
		RTVerticalLineLayout new gapSize: 0; on: group.
		r := group encompassingRectangle.
		group first trachelShape 
			translateTo: (r center x @ group first trachelShape center y).
		box := (RTBox new color: Color white; borderColor: Color gray) 
			elementOn: object.
		e1 := (RTBox new extent: 0@0) elementOn: 'p1'.
		e2 := (RTBox new extent: 0@0) elementOn: 'p2'.
		e1 trachelShape translateTo: r left@h.
		e2 trachelShape translateTo: r right@h.
		l := RTEdge from: e1 to: e2.
		l + (RTLine new color: Color gray).
		group add: e1; add: e2; add: l.
		RTNest new on: box nest: group.
	
		box @ RTDraggable.
		classesGroup add: box.
		aView add: box.
		aView addAll: group.
	].
	
]

{ #category : #accessing }
RTUMLClassBuilder >> classNameFor: obj [
	^ self classname rtValue: obj
]

{ #category : #accessing }
RTUMLClassBuilder >> classesGroup [
	^ classesGroup.
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
		{ 'MyClass' . { #iv1 . #iv2 } . { #method1 . #method2 . #method3 }}  .
		{ 'MyClass2' . { #iv2 . #iv2 } . { #method1 . #method2 . #method4 }}  }.

	RTUMLClassBuilder new
		addObjects: objects;
		classname: #first;
		instanceVariables: #second;
		methodsNames: #third;
		methodselector: #yourself;
		attributeselector: #yourself;
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
		if: [ :method | method selector beginsWith: 'init' ] color: Color green;
		if: [ :method | method selector beginsWith: 'with' ] color: Color red.
			
	b attributeShape label
		if: [ :attribute | attribute beginsWith: 'a' ] color: Color blue.
	b addObjects: RTShape withAllSubclasses.
	b treeLayout; open.
		
]

{ #category : #examples }
RTUMLClassBuilder >> example5 [
	"
	self new example5
	"
	| objects b |
	objects :=  {
		{ 'MyClass' . { #iv1 . #iv2 } . { #method1 . #method2 . #method3 }}  .
		{ 'MyClass2' . { #iv2 . #iv2 } . { #method1 . #method2 . #method4 }}  }.

	b := RTUMLClassBuilder new.
	b attributeShape label if: [ :a | a = #iv1 ] color: Color red.
	b
		addObjects: objects;
		classname: #first;
		instanceVariables: #second;
		methodsNames: #third;
		methodselector: #yourself;
		attributeselector: #yourself;
		superclass: nil;
		open
]

{ #category : #private }
RTUMLClassBuilder >> fontSizeOfClassname [
	^ 12
]

{ #category : #private }
RTUMLClassBuilder >> fontSizeOfMembers [
	^ 10
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
	self attributeselector: #yourself.

	self methodShape: RTShapeBuilder new.
	self attributeShape: RTShapeBuilder new.
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

{ #category : #shapes }
RTUMLClassBuilder >> methodShape: aUMLShapeBuilder [
	methodShapeBuilder := aUMLShapeBuilder
]

{ #category : #accessing }
RTUMLClassBuilder >> methodsForClass: obj [
	^ self methodsNames rtValue: obj
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

{ #category : #private }
RTUMLClassBuilder >> prepare: builder selector: selector [
	builder shape class = RTNoShape ifTrue: [ 
		builder label height: self fontSizeOfMembers ].
	builder text: [ :obj | (self perform: selector) rtValue: obj ].
	
]

{ #category : #hooks }
RTUMLClassBuilder >> renderIn: aView [
	self buildSchema: aView.
	self buildEdges.
	self applyLayout
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

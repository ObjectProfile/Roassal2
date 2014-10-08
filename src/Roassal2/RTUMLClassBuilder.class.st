"
I am a builder to create UML diagrams in Roassal2, see examples
"
Class {
	#name : #RTUMLClassBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'classes',
		'selectorsForClass',
		'selectorsForMethod'
	],
	#classVars : [
		'classesGroup'
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
RTUMLClassBuilder >> addClasses: classes [
	classes do: [ :cls | self addClass: cls ]
]

{ #category : #accessing }
RTUMLClassBuilder >> classNameFor: class [
	^ class perform: (self selectorsForClass at: 1).
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
		addClasses: RTShape withAllSubclasses;
		gridLayout;
		build;
		open.
]

{ #category : #examples }
RTUMLClassBuilder >> example2 [
	"
	self new example2
	"

	RTUMLClassBuilder new
		addClasses: RTShape withAllSubclasses;
		treeLayout;
		build; open.
		
]

{ #category : #layouts }
RTUMLClassBuilder >> gridLayout [
	RTGridLayout on: classesGroup
]

{ #category : #initialization }
RTUMLClassBuilder >> initialize [
	super initialize.
	classesGroup := RTGroup new.
	classes := OrderedCollection new.
	
	self
		selectorsForClass: { #name. #instVarNames. #methods. #superclass}
		selectorsForMethod: { #selector }.
	
]

{ #category : #accessing }
RTUMLClassBuilder >> methodsForClass: class [
	^ class perform: (self selectorsForClass at: 3).
]

{ #category : #accessing }
RTUMLClassBuilder >> selectorForMethod: method [
	^ method perform: (self selectorsForMethod at: 1).
]

{ #category : #accessing }
RTUMLClassBuilder >> selectorsForClass [
	^ selectorsForClass
]

{ #category : #accessing }
RTUMLClassBuilder >> selectorsForClass: anArray [
	selectorsForClass := anArray
]

{ #category : #accessing }
RTUMLClassBuilder >> selectorsForClass: anArray1 selectorsForMethod: anArray2 [
	selectorsForClass := anArray1.
	selectorsForMethod := anArray2.
]

{ #category : #accessing }
RTUMLClassBuilder >> selectorsForMethod [
	^ selectorsForMethod
]

{ #category : #accessing }
RTUMLClassBuilder >> selectorsForMethod: anArray [
	selectorsForMethod := anArray
]

{ #category : #accessing }
RTUMLClassBuilder >> superClassSelector [
	^ self selectorsForClass at: 4.
]

{ #category : #layouts }
RTUMLClassBuilder >> treeLayout [
	RTEdge buildEdgesFromObjects: 
		classes from: (self superClassSelector) to: #yourself using: (RTMultiLine new orthoVertical attachPoint: RTVerticalAttachPoint instance) inView: view.
	RTTreeLayout on: classesGroup
]

{ #category : #accessing }
RTUMLClassBuilder >> varNamesFor: class [
	^ class perform: (self selectorsForClass at: 2).
]

"
This is a conditional layout that allow one to compose layouts.
Here is an example:

[[[
	v := RTView new.
	es := (RTBox new
				color: [ :value | value odd ifTrue: [ Color red ] ifFalse: [ Color blue ] ])
				elementsOn: (1 to: 4).
	v addAll: es.
	
	l := RTConditionalLayout new
				condition: [ :element | element model odd ];
				thenLayout: RTVerticalLineLayout new;
				elseLayout: RTHorizontalLineLayout new.
	l on: es.
	v
]]]


Another example:

[[[
classes := (RPackageOrganizer default packageNamed: 'Roassal2') definedClasses.
classes := classes copyWithout: RTObject.

b := RTMondrian new.
b nodes: classes.
b edges connectFrom: #superclass.
b layout partition
	withinGroup: RTTreeLayout;
	forGroups: (RTConditionalLayout new 
						condition: [ :g | g size > 1 ];
						thenLayout: RTFlowLayout;
						elseLayout: RTGridLayout
						).

b
]]]
"
Class {
	#name : #RTConditionalLayout,
	#superclass : #RTLayout,
	#instVars : [
		'condition',
		'thenLayout',
		'elseLayout',
		'overallLayout'
	],
	#category : #'Roassal2-Layouts'
}

{ #category : #accessing }
RTConditionalLayout >> condition [
	^ condition
]

{ #category : #accessing }
RTConditionalLayout >> condition: aBlockOrSymbolOrValue [
	"The argument will be evaluated for each Roassal elements.
	elements that meet the condition will be evaluated using the thenLayout, else they will be given to the elseLayout
	"
	condition := aBlockOrSymbolOrValue
]

{ #category : #hook }
RTConditionalLayout >> doExecute: elements [
	| thenElements elseElements |
	thenElements := RTGroup new.
	elseElements := RTGroup new.
	elements do: [ :anElement | (condition rtValue: anElement) 
											ifTrue: [ thenElements add: anElement ] 
											ifFalse: [ elseElements add: anElement ] ].
	thenLayout on: thenElements.
	elseLayout on: elseElements.
	overallLayout on: (RTGroup with: thenElements with: elseElements)


]

{ #category : #accessing }
RTConditionalLayout >> elseLayout [
	^ elseLayout
]

{ #category : #accessing }
RTConditionalLayout >> elseLayout: aLayout [
	elseLayout := aLayout
]

{ #category : #initialization }
RTConditionalLayout >> initialize [
	super initialize.
	condition := true.
	thenLayout := RTTreeLayout new.
	elseLayout := RTGridLayout new.
	overallLayout := RTHorizontalLineLayout new.
]

{ #category : #accessing }
RTConditionalLayout >> overallLayout [
	^ overallLayout
]

{ #category : #accessing }
RTConditionalLayout >> overallLayout: anObject [
	overallLayout := anObject
]

{ #category : #accessing }
RTConditionalLayout >> thenLayout [
	^ thenLayout
]

{ #category : #accessing }
RTConditionalLayout >> thenLayout: aLayout [
	thenLayout := aLayout
]

Class {
	#name : #RTMenu,
	#superclass : #Object,
	#instVars : [
		'view',
		'items',
		'isOpen'
	],
	#category : #'Roassal2-Builder-Menu'
}

{ #category : #'as yet unclassified' }
RTMenu >> add: menuitem [
	self items add: menuitem.
]

{ #category : #'as yet unclassified' }
RTMenu >> getLabelNamed: aName [
	| labels |
	labels := view canvas fixedShapes select: [ :t | t class == TRLabelShape and: [ t text = aName ] ].
	^ labels isEmpty 
		ifTrue: [ nil ];
		ifFalse: [ labels first ].
	
]

{ #category : #'as yet unclassified' }
RTMenu >> hideAll [
	view canvas fixedShapes do: [ :s |
		
		(s element isKindOf: RTMenu) ifTrue: [ s element hideItems ]. ]
]

{ #category : #'as yet unclassified' }
RTMenu >> hideItems [
	self isOpen ifFalse: [ ^ self ].
	self isOpen: false.
	self items do: [:item |
		(self getLabelNamed: item label) remove].
]

{ #category : #initialization }
RTMenu >> initialize [
	super initialize.
	view := nil.
	isOpen := false.

]

{ #category : #'as yet unclassified' }
RTMenu >> isOpen [
	^ isOpen
]

{ #category : #'as yet unclassified' }
RTMenu >> isOpen: abool [
	isOpen := abool
]

{ #category : #'as yet unclassified' }
RTMenu >> items [
	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
RTMenu >> view: v [
	view := v
]

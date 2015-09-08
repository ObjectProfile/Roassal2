"
Visual browser of Roassal example.
This class create a world menu item to open the examples
"
Class {
	#name : #RTExampleBrowser,
	#superclass : #RTObject,
	#category : #'Roassal2-MorphSpecific'
}

{ #category : #menu }
RTExampleBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>
	((aBuilder item: #Roassal) icon: RTIcon smallRoassal)
	withSeparatorAfter;
	with: [
		(aBuilder item: #'Roassal Examples')
			order: 0.1; 
			parent: #Roassal;
			label: 'Roassal examples';
			icon: RTIcon smallRoassal;
			action: [ self new open ] ]
]

{ #category : #'instance creation' }
RTExampleBrowser >> examples [
	| es |
	es := RTAbstractExample allSubclasses collect: #new.
	^ es sortedAs: #label
]

{ #category : #'instance creation' }
RTExampleBrowser >> open [
	| pager |
	pager := GLMPager new.
	pager title: 'Roassal examples browser'.
	pager showFirst: [ :a | a list format: #label ].
	pager
		show: [ :a :each | 
			a title: [ GTInspector new printObjectAsAnItem: each ].
			a dynamicActions: [ :aPresentation | each gtInspectorActions asOrderedCollection ].
			a dynamic
				display: [ :x | (GLMCompositePresentation new with: [ :d | each gtInspectorPresentationsIn: d inContext: pager ]) startOn: x ] ].
	pager openOn: self examples
]

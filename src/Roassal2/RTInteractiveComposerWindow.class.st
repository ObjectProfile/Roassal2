Class {
	#name : #RTInteractiveComposerWindow,
	#superclass : #ComposablePresenter,
	#instVars : [
		'menu',
		'text',
		'tabManager',
		'view',
		'initialScript',
		'codePanel',
		'model'
	],
	#category : #'Roassal2-InteractiveComposer'
}

{ #category : #specs }
RTInteractiveComposerWindow class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :c | 
			c 
				add: #menu height: self toolbarHeight;
				add: #tabManager ];
		yourself
]

{ #category : #specs }
RTInteractiveComposerWindow class >> example2 [
	<sampleInstance>
	^ self new 
		initialScript: [ :aView |
			aView add: (RTEllipse new size: 30; color: Color green) element.
		];
		openWithSpec
]

{ #category : #'world menu' }
RTInteractiveComposerWindow class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Roassal Easel') action: [ self open ]
]

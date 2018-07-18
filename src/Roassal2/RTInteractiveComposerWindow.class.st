Class {
	#name : #RTInteractiveComposerWindow,
	#superclass : #ComposablePresenter,
	#instVars : [
		'menu',
		'text',
		'tabManager',
		'view'
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
RTInteractiveComposerWindow class >> example [
	<sampleInstance>
	^ self new openWithSpec
]

{ #category : #accessing }
RTInteractiveComposerWindow >> addItemTo: aGroup [
	aGroup
		addItem: [ :item | 
			item
				name: 'Dynamic';
				icon: (self iconNamed: #delete);
				action: [ aGroup menuItems remove: item.
					self needRebuild: false.
					self buildWithSpec ] ].
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #initialization }
RTInteractiveComposerWindow >> initializeWidgets [
	menu := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: 'File';
						icon: (self iconNamed: #openIcon);
						subMenu: self subMenu ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Open file';
						icon: (self iconNamed: #openIcon);
						action: [ self inspect ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Save File';
						icon: (self iconNamed: #smallSaveIcon);
						action: [ self inform: 'Save File' ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Print file';
						icon: (self iconNamed: #smallPrintIcon);
						action: [ self inform: 'Print file' ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Undo';
						icon: (self iconNamed: #smallUndoIcon);
						action: [ self inform: 'Undo' ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Redo';
						icon: (self iconNamed: #smallRedoIcon);
						action: [ self inform: 'Redo' ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Add menu item';
						icon: (self iconNamed:  #add);
						action: [ self addItemTo: group ] ] ].
	menu applyTo: self.
	text := self newText.
	tabManager := self newTabManager.
	tabManager whenTabSelected: [ self updateTitle ].
	self populateManager.
	self focusOrder add: text.
]

{ #category : #accessing }
RTInteractiveComposerWindow >> menu [
	^ menu
]

{ #category : #initialization }
RTInteractiveComposerWindow >> populateManager [

	tabManager
		addTab: self tab1;
		addTab: self tab2
]

{ #category : #accessing }
RTInteractiveComposerWindow >> subMenu [ 

	^ MenuPresenter new
		addGroup: [ :group |
			group addItem: [ :item |
				item
					name: 'Open';
					icon: (self iconNamed: #openIcon);
					shortcut: $o meta;
					action: [ self inform: 'Open' ] ].
			group addItem: [ :item |
				item 
					name: 'Save';
					icon: (self iconNamed: #smallSaveIcon);
					shortcut: $s meta;
					action: [ self inform: 'Save' ] ].
			group addItem: [ :item |
				item 
					name: 'Print';
					shortcut: $p meta;
					icon: (self iconNamed: #smallPrintIcon);
					action: [ self inform: 'Print' ] ].
			group addItem: [ :item |
				item 
					name: 'Kill';
					shortcut: $k meta;
					icon: (self iconNamed: #smallCancelIcon);
					action: [ self inform: 'Kill' ] ] ]
]

{ #category : #initialization }
RTInteractiveComposerWindow >> tab1 [

	| tab |
	tab := self newTab.
	tab
		label: 'Tab1';
		icon: (tab iconNamed: #nautilusIcon);
		model:
			(self newCode).
	^ tab
]

{ #category : #initialization }
RTInteractiveComposerWindow >> tab2 [

	| tab diagram |
	diagram := self instantiate: RoassalModel.
	diagram script: [ :aView :canvas | self view: aView.
		self halt.
		self inform: 'execute!'.
		aView add: (RTEllipse new size: 30; color: Color red) element. 
		 aView @ RTDraggableView ].
	
	tab := self newTab.
	tab
		label: 'Tab2';
		icon: (tab iconNamed: #nautilusIcon);
		model: diagram.
	^ tab
]

{ #category : #accessing }
RTInteractiveComposerWindow >> tabManager [
	^ tabManager
]

{ #category : #accessing }
RTInteractiveComposerWindow >> text [
	^ text
]

{ #category : #api }
RTInteractiveComposerWindow >> title [

	^ 'Roassal'
]

{ #category : #accessing }
RTInteractiveComposerWindow >> view [
	^ view
]

{ #category : #accessing }
RTInteractiveComposerWindow >> view: aview [
	view := aview
]

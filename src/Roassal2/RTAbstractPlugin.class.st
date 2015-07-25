Class {
	#name : #RTAbstractPlugin,
	#superclass : #RTObject,
	#category : #'Roassal2-Plugins'
}

{ #category : #'as yet unclassified' }
RTAbstractPlugin class >> menuCommandOn: aBuilder [
	<worldMenu>
	((aBuilder item: #RoassalPlugin; parent: #Roassal) icon: RTIcon smallRoassal)
		withSeparatorAfter;
		with: [
			self allSubclasses do: [ :cls |
				(aBuilder item: (#'Plugin: ', cls new label))
					order: 0.3; 
					parent: #RoassalPlugin;
					label: cls new label;
					icon: RTIcon smallRoassal;
					action: [ cls new run ] ] ]
]

{ #category : #hooks }
RTAbstractPlugin >> description [
	"description of the of the plugin"
	^ 'Need to be described'
]

{ #category : #hooks }
RTAbstractPlugin >> execute [
	"Code to be executed"
	self subclassResponsibility
]

{ #category : #hooks }
RTAbstractPlugin >> label [
	"Menu entry"
	^ 'Need to define'
]

{ #category : #public }
RTAbstractPlugin >> run [
	| answer |
	answer := UIManager default confirm: self description label: 'Do you want to load plugin ', self label, '?'.
	answer ifNil: [ ^ self ].
	answer ifTrue: [ self execute ].
]

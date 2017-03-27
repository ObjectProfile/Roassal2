Class {
	#name : #RTAbstractPlugin,
	#superclass : #RTAbstractMenuEntry,
	#category : #'Roassal2-Plugins'
}

{ #category : #'world menu' }
RTAbstractPlugin class >> menuCommandOn: aBuilder [
	<worldMenu>
	((aBuilder
		item: self menuConfigurationSymbol;
		order: 15;
		parent: #Roassal) icon: RTIcon smallRoassal)
		withSeparatorAfter;
		with: [ self allSubclasses
						do: [ :cls | 
							(aBuilder item:
							self menuConfigurationEntryTitle , cls new label)
								order: 15;
								parent: self menuConfigurationSymbol;
								label: cls new label;
								icon: RTIcon smallRoassal;
								action: [ cls new run ] ] ]
]

{ #category : #'world menu' }
RTAbstractPlugin class >> menuConfigurationEntryTitle [
	^ #'Plugin: '
]

{ #category : #'world menu' }
RTAbstractPlugin class >> menuConfigurationSymbol [
	^ #RoassalPlugin
]

{ #category : #public }
RTAbstractPlugin >> configurationMessage [
	^ 'Do you want to load plugin '
]

{ #category : #hooks }
RTAbstractPlugin >> description [
	"description of the of the plugin"
	^ 'Need to be described'
]

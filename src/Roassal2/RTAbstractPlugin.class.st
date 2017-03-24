Class {
	#name : #RTAbstractPlugin,
	#superclass : #RTAbstractMenuEntry,
	#category : #'Roassal2-Plugins'
}

{ #category : #'world menu' }
RTAbstractPlugin class >> allLoadedPluginClasses [
	^ self allPluginClasses select: [ :c | c new isLoaded ]
]

{ #category : #'world menu' }
RTAbstractPlugin class >> allNotLoadedPluginClasses [
	^ self allPluginClasses select: [ :c | c new isLoaded not ]
]

{ #category : #'world menu' }
RTAbstractPlugin class >> allPluginClasses [
	"Return the list of plugin"
	^ self allSubclasses select: [ :c | c new isEnabled ]
]

{ #category : #'world menu' }
RTAbstractPlugin class >> menuCommandOn: aBuilder [
	<worldMenu>
	| b |
	b := ((aBuilder
		item: self menuConfigurationSymbol;
		order: 15;
		parent: #Roassal) icon: RTIcon smallRoassal)
		withSeparatorAfter;
		yourself.
	b
		with: [ self allNotLoadedPluginClasses
						do: [ :cls | 
							(aBuilder item: self menuConfigurationEntryTitle , cls new label)
								order: 15;
								parent: self menuConfigurationSymbol;
								label: cls new pluginName;
								icon: RTIcon smallRoassal;
								action: [ cls new run ] ] ].
	b withSeparatorAfter.

	b
		with: [ self allLoadedPluginClasses
						do: [ :cls | 
							(aBuilder item: self menuConfigurationEntryTitle , cls new label)
								order: 25;
								parent: self menuConfigurationSymbol;
								label: cls new pluginName;
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

{ #category : #testing }
RTAbstractPlugin >> doesItLoadCode [
	^ true
]

{ #category : #testing }
RTAbstractPlugin >> isLoaded [
	^ false
]

{ #category : #public }
RTAbstractPlugin >> pluginName [
	self doesItLoadCode ifFalse: [ ^ self label ].
	^ self isLoaded 
		ifTrue: [ 'Update ', self label ]
		ifFalse: [ 'Load ', self label ]
]

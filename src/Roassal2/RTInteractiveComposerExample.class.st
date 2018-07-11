Class {
	#name : #RTInteractiveComposerExample,
	#superclass : #RTObject,
	#category : #'Roassal2-InteractiveComposer'
}

{ #category : #examples }
RTInteractiveComposerExample >> example01 [
	<script: 'self new example01'>

| i b |
i := RTInteractiveComposer new.

i forCollectionOf: Class do: [ :someClasses |
	b := RTMondrian new.
	b nodes: someClasses.
	b normalizer normalizeSize: #numberOfMethods; 	normalizeColor: #numberOfLinesOfCode.
	b layout flow.
	b ].

i for: Class do: [ :aClass |
	b := RTMondrian new.
	b shape label text: #selector.
	b nodes: aClass methods.
	b edges connectToAll: #dependentMethods.
	b layout force.
	b
].

i openOn: Collection withAllSubclasses.

]

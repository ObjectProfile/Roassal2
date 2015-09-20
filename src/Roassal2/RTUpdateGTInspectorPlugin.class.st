Class {
	#name : #RTUpdateGTInspectorPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-Plugins'
}

{ #category : #'as yet unclassified' }
RTUpdateGTInspectorPlugin >> description [
	^ 'GTInspector is a powerful framework to build dedicated inspectors. 
Roassal uses GTInspector to render RTViewn and browse examples.
In case you get an error involving a class whose name begins with "GT",
than you may want to update GTInspector.'
]

{ #category : #'as yet unclassified' }
RTUpdateGTInspectorPlugin >> execute [
	Gofer new
		smalltalkhubUser: 'Moose' project: 'GToolkit';
		package: 'GT-Inspector';
		package: 'GT-InspectorExtensions-CoreRoassal';
		load
]

{ #category : #'as yet unclassified' }
RTUpdateGTInspectorPlugin >> label [
	^ 'Update the GT Inspector'
]

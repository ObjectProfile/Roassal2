Class {
	#name : #RTVisualIDPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-Plugins'
}

{ #category : #hooks }
RTVisualIDPlugin >> description [
	^ 'VisualID is a glyph-based object identification technique. It generates a unique glyph for each
 object that is inputed. Similarities may exist between two glyphs depending on how similar their
respective objects are.'
]

{ #category : #hooks }
RTVisualIDPlugin >> execute [
	Gofer new
		smalltalkhubUser: 'IgnacioFernandez' project: 'VisualiDs';
		package: 'VisualID-Clustering';
		package: 'VisualID-Random';
		package: 'VisualID-Roassal';
		package: 'VisualID-Canvas';
		package: 'VisualID-Random';
		package: 'VisualID-Test';
		load
]

{ #category : #hooks }
RTVisualIDPlugin >> label [
	^ 'VisualID shapes'
]

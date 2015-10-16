Extension { #name : #CPDiverging }

{ #category : #'*Roassal2GT-Inspector' }
CPDiverging classSide >> gtExampleColorPalette [
	<gtExample>
	<label: 'Colors: diverging scheme'>
	
	^ self new
]

{ #category : #'*Roassal2GT-Inspector' }
CPDiverging >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'View';
		painting: [ :view | self viewOn: view ]
]

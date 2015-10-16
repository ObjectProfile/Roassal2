Extension { #name : #CPSequential }

{ #category : #'*Roassal2GT-Inspector' }
CPSequential classSide >> gtExampleColorPalette [
	<gtExample>
	<label: 'Colors: sequential scheme'>
	
	^ self new
]

{ #category : #'*Roassal2GT-Inspector' }
CPSequential >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'View';
		painting: [ :view | self viewOn: view ]
]

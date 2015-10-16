Extension { #name : #CPQualitative }

{ #category : #'*Roassal2GT-Inspector' }
CPQualitative classSide >> gtExampleColorPalette [
	<gtExample>
	<label: 'Colors: qualititive scheme'>
	
	^ self new
]

{ #category : #'*Roassal2GT-Inspector' }
CPQualitative >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'View';
		painting: [ :view | self viewOn: view ]
]

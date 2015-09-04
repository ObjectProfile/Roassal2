Extension { #name : #RTBuilder }

{ #category : #'*Glamour-Roassal2-Presentations' }
RTBuilder >> openWithToolbar [
	^ GLMCompositePresentation new 
		title: 'Roassal painting';
		with: [:composite |
			composite roassal2 initializeView: [ self ] ];
		openOn: self
]

{ #category : #'*Glamour-Roassal2-Presentations' }
RTBuilder >> openWithToolbarEntitled: aTitle [
	^ self openWithToolbar title: aTitle
]

Class {
	#name : #GLMRoassal2Examples,
	#superclass : #GLMExamples,
	#category : #'Glamour-Roassal2-Presentations'
}

{ #category : #'as yet unclassified' }
GLMRoassal2Examples >> roassalPainting [
	<glmBrowser: 'Roassal painting' input: '42'>
	"self new roassalPainting openOn: 42"
	| browser |
	browser := GLMTabulator withStatusbar.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [ :a |
		a list 
			title: 'Select and trigger from menu';
			display: [:x | 1 to: x ];
			selectionAct: [:list | 
				| value |
				value := list selection * 10. "simulate some custom setup"
				(list pane port: #customSelection) value: value ] 
			entitled:  'Multiply by 10 and then send outside'
			].
	browser transmit to: #two; from: #one port: #customSelection; andShow: [ :a |
		a roassal2
			title: 'Numbers in Roassal';
			initializeView: [ RTMondrian new ];
			painting: [:view :number | 
				view shape label.
				view nodes: (1 to: number).
				view edges connectFrom: [:each | each // 5 ].
				view layout tree ] ].
	^ browser
]

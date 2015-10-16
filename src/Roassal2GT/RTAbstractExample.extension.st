Extension { #name : #RTAbstractExample }

{ #category : #'*Roassal2GT-Inspector' }
RTAbstractExample >> gtDisplayExamplesIn: aComposite [

	^ (self gtInspectorPreviewIn: aComposite)
		title: 'E.g'
]

{ #category : #'*Roassal2GT-Inspector' }
RTAbstractExample class >> gtExamplesProvider [
	^ self new
]

{ #category : #'*Roassal2GT-Inspector' }
RTAbstractExample >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 4>
	^ composite roassal2
		title: 'Examples';
		when: [ self gtExamples notEmpty ];
		send: [ :example | example ];
		painting: [ :view | 
			view @ RTDraggableView.
			self gtOpenOn: view ]
]

{ #category : #'*Roassal2GT-Inspector' }
RTAbstractExample class >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 4>
	<gtInspectorTag: #examples>
	^ self new gtInspectorPreviewIn: composite
]

{ #category : #'*Roassal2GT-Inspector' }
RTAbstractExample >> gtOpenOn: v [
	|  icon64Mime form element  |

	self gtExamples do: [ :anExample |
		icon64Mime := self perform: (anExample method selector, #Icon) asSymbol.
		form := TRPlatform current formClass fromBinaryStream: 
							(TRPlatform current mimeDecodeToBytes: icon64Mime readStream).
		element := (RTBitmap new form: form) elementOn: anExample.
		element @ (RTPopup new text: anExample method selector asString).
		element @ (RTEventForwarder new eventClass: TRMouseDragging). 
		v add: element ].

	RTGridLayout new on: v elements.
	
]

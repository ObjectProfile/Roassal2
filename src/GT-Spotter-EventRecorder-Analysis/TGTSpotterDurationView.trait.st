Trait {
	#name : #TGTSpotterDurationView,
	#category : #'GT-Spotter-EventRecorder-Analysis-Traits'
}

{ #category : #'gt-inspector-extension' }
TGTSpotterDurationView >> durationView [
	| b ds |
	b := RTGrapher new.
	b extent: 500 @ 100.
	self ifEmpty: [ ^ b view ].
	ds := RTStackedDataSet new.
	ds interaction highlight.
	ds interaction popup text: [ :obj | obj sessionPopupText ].
	ds points: self.
	ds barShape 
			color: [ :obj | obj isWithPreview 
				ifTrue: [ Color green alpha: 0.3 ]
				ifFalse: [ Color blue alpha: 0.3 ] ]; 
			width: 10.
	ds y: [ :c | c duration asSeconds ].
	b add: ds.
	b axisX noTick; noLabel.
	b axisY.
	b build.
	^ b view.
	
]

{ #category : #'gt-inspector-extension' }
TGTSpotterDurationView >> gtInspectorDurationViewIn: composite [
	<gtInspectorPresentationOrder: 5>
	composite roassal2
		title: 'Duration';
		initializeView: [ self durationView ]
		
]

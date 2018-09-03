Trait {
	#name : #TGTSpotterUpdateEvents,
	#category : #'GT-Spotter-EventRecorder-Analysis-Traits'
}

{ #category : #'gt-inspector-extension' }
TGTSpotterUpdateEvents >> gtInspectorActionRefreshEvents [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ self updateEvents ];
		icon: Smalltalk ui icons glamorousRefresh;
		title: 'Update events'
]

Trait {
	#name : #TGTSpotterCategoryView,
	#category : #'GT-Spotter-EventRecorder-Analysis-Traits'
}

{ #category : #enumerating }
TGTSpotterCategoryView >> categoryLabelOccurrences [
	| col |
	col := OrderedCollection new.
	self categoryLabels asBag 
		doWithOccurrences: [ :obj :occurrences | 
			col add: obj -> occurrences ].
	^ col
]

{ #category : #'gt-inspector-extension' }
TGTSpotterCategoryView >> categoryView [
	| builder |
	builder := GTACategoryBuilder new collection: self; build; yourself.
	GTAMenuCategoryBuilder new categoryBuilder: builder; build.
	^ builder view.
	
]

{ #category : #'gt-inspector-extension' }
TGTSpotterCategoryView >> gtInspectorCategoryViewIn: composite [
	<gtInspectorPresentationOrder: -2>
	composite roassal2
		title: 'Category';
		initializeView: [ self categoryView ]
		
]

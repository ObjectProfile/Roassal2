Extension { #name : #RTView }

{ #category : #'*RoassalSpotterIntegration' }
RTView >> spotterElementsFor: aStep [
	<spotterOrder: 10>
	^ aStep listProcessor
		title: 'Elements';
		candidatesLimit: 100;
		allCandidates: [ self elements ];
		itemName: [ :each | each model gtDisplayString ];
		matchSubstring;
		wantsToDisplayOnEmptyQuery: true
]

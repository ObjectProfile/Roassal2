Class {
	#name : #GTAOrthogonalIconBuilderTest,
	#superclass : #GTAAbstractIconBuilderTest,
	#category : #'GT-Spotter-EventRecorder-Analysis-Tests'
}

{ #category : #initialization }
GTAOrthogonalIconBuilderTest >> initializeBuilder [	
	builder := GTAOrthogonalSymbolBuilder new
]

{ #category : #'instance creation' }
GTAOrthogonalIconBuilderTest >> lineWithDownSelectionsFrom: aGTAComputers [
	| selection2 session1 selection1 selection3 selection4 |
	selection1 := GTSpotterRecorderSelectedCandidateChangedEvent new
		infoAt: #eventType put: #keyPressedArrowDown;
		infoAt: #elementName put: 1;
		yourself.
	selection2 := GTSpotterRecorderSelectedCandidateChangedEvent new
		infoAt: #eventType put: #keyPressedArrowDown;
		infoAt: #elementName put: 1;
		yourself.
	session1 := GTASession with: selection1 with: selection2.
	selection1 previousSelection: selection1.
	selection2 previousSelection: selection1.
	selection1 session: session1.
	selection2 session: session1.
	selection3 := aGTAComputers first fifth at: 25.
	selection4 := aGTAComputers first second at: 51.
	^ RTGroup 
		with: (self newElementForEvent: selection1)
		with: (self newElementForEvent: selection2)
		with: (self newElementForEvent: selection3)
		with: (self newElementForEvent: selection4)

]

{ #category : #'instance creation' }
GTAOrthogonalIconBuilderTest >> lineWithMouseSelectionsFrom: aGTAComputers [
	| selection1 selection2 selection3 selection4 |
	selection1 := aGTAComputers first second at: 33.
	selection2 := aGTAComputers first second at: 34.
	selection3 := aGTAComputers first second at: 39.
	selection4 := aGTAComputers first second at: 41.
	^ RTGroup 
		with: (self newElementForEvent: selection1)
		with: (self newElementForEvent: selection2)
		with: (self newElementForEvent: selection3)
		with: (self newElementForEvent: selection4)

]

{ #category : #'instance creation' }
GTAOrthogonalIconBuilderTest >> lineWithQueries [
	^ RTGroup
		with:
			(self
				newElementForEvent:
					(GTSpotterRecorderContextChangedEvent new
						currentTextInfoFromString: 'query';
						yourself))
		with:
			(self
				newElementForEvent:
					(GTSpotterRecorderContextChangedEvent new
						currentTextInfoFromString: 'query2 longer-query';
						yourself))
		with:
			(self
				newElementForEvent:
					(GTSpotterRecorderContextChangedEvent new
						currentTextInfoFromString: 'query33 #c';
						yourself))
]

{ #category : #'instance creation' }
GTAOrthogonalIconBuilderTest >> lineWithUnknownSelectionsFrom: aGTAComputers [
	| selection1 element |
	selection1 := aGTAComputers first first at: 4.
	element := self newElementForEvent: selection1.
	element trachelShape strokePaint: Color black.
	^ RTGroup with: element
]

{ #category : #'instance creation' }
GTAOrthogonalIconBuilderTest >> lineWithUpSelectionsFrom: aGTAComputers [
	| selection2 session1 selection1 selection3 selection4 |
	selection1 := GTSpotterRecorderSelectedCandidateChangedEvent new
		infoAt: #eventType put: #keyPressedArrowUp;
		infoAt: #elementName put: 1;
		yourself.
	selection2 := GTSpotterRecorderSelectedCandidateChangedEvent new
		infoAt: #eventType put: #keyPressedArrowUp;
		infoAt: #elementName put: 1;
		yourself.
	session1 := GTASession with: selection1 with: selection2.
	selection1 previousSelection: selection1.
	selection2 previousSelection: selection1.
	selection1 session: session1.
	selection2 session: session1.
	selection3 := aGTAComputers first sixth at: 9.
	selection4 := aGTAComputers first second at: 47.
	^ RTGroup 
		with: (self newElementForEvent: selection1)
		with: (self newElementForEvent: selection2)
		with: (self newElementForEvent: selection3)
		with: (self newElementForEvent: selection4)

]

{ #category : #running }
GTAOrthogonalIconBuilderTest >> testShapesForVissoft2015Paper [
	| view line1 line2 line3 line4 line5 line6 computers line7 line8 line9 |
	view := RTView new.
	computers := GTASessionExamples allRecordedExamples.
	line1 := RTGroup
		with: (self newElementForEventClass: GTSpotterRecorderActOnEvent)
		with: (self newElementForEventClass: GTSpotterRecorderExitAnnouncementEvent).
	line2 := RTGroup
		with: (self newElementForEventClass: GTSpotterRecorderShowPreviewEvent)
		with: (self newElementForEventClass: GTSpotterRecorderHidePreviewEvent).
	line3 := RTGroup
		with: (self newElementForEventClass: GTSpotterRecorderDiveInElementEvent)
		with: (self newElementForEventClass: GTSpotterRecorderDiveInCategoryEvent)
		with: (self newElementForEventClass: GTSpotterRecorderDiveOutEvent).
	line4 := self lineWithQueries.
	line5 := RTGroup with: (self newElementForEventClass: GTSpotterRecorderSearchFinishedEvent).
	line6 := self lineWithUnknownSelectionsFrom: computers.
	line7 := self lineWithUpSelectionsFrom: computers.
	line8 := self lineWithDownSelectionsFrom: computers.
	line9 := self lineWithMouseSelectionsFrom: computers.
	view
		addAll: line1;
		addAll: line2;
		addAll: line3;
		addAll: line4;
		addAll: line5;
		addAll: line6;
		addAll: line7;
		addAll: line8;
		addAll: line9.
	RTHorizontalLineLayout
		on: line1;
		on: line2;
		on: line3;
		on: line4;
		on: line5;
		on: line6;
		on: line7;
		on: line8;
		on: line9.
	RTVerticalLineLayout
		on:
			(RTGroup new
				add: line1;
				add: line2;
				add: line3;
				add: line4;
				add: line5;
				add: line6;
				add: line7;
				add: line8;
				add: line9;
				yourself).
	view elements @ RTDraggable.
	view elements do: [ :eachElement | eachElement trachelShape allVisibleColor: Color black ].
	view inspect
]

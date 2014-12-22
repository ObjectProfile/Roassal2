Extension { #name : #SequenceableCollection }

{ #category : #'*roassal2-core' }
SequenceableCollection >> cumsum [
	"Cumulative sum
	#(1 2 3 4 5) cumsum = #(1 3 6 10 15)
	"
   | sum |
	sum := 0.
	^ self collect: [ :v | sum := sum + v. sum ]
 
]

{ #category : #'*roassal2-core' }
SequenceableCollection >> plot [
	"
	#(1 2 3 4 5) plot
	"
	| b ds |
	b := RTGrapherBuilder new.
	
	"We defien the size of the charting area"
	b extent: 500 @ 100.
	
	ds := RTStackedDataSet new.
	"When the mouse is above a bar, say which class we are point at"
	ds interaction popup.
	ds points: self.
	ds dotShape rectangle color: Color blue.
	b add: ds.
	
	b build.
	^ b view
	
]

{ #category : #'*roassal2-core' }
SequenceableCollection >> plotFrequency [
	self plotFrequency: 10
]

{ #category : #'*roassal2-core' }
SequenceableCollection >> plotFrequency: nbOfInterval [
	
	"
	#(1 1 1 3 4 3 4) plotFrequency: 3
	"
	
	| b ds |
	b := RTGrapherBuilder new.
	
	"We defien the size of the charting area"
	b extent: 500 @ 100.
	
	ds := RTStackedDataSet new.
	"When the mouse is above a bar, say which class we are point at"
	ds interaction popupText: [ :set | set size printString, ' x ', set anyOne printString ].
	ds points: ((RTDistribution on: self) frequencyWithAmountOfIntervals: nbOfInterval).
	ds y: #size.
	ds dotShape rectangle color: Color blue.
	b add: ds.

	b build.
	^ b view
	
]

{ #category : #'*roassal2-core' }
SequenceableCollection >> rtSwapElement: u withElement: v [
	| index1 index2 |
	index1 := self indexOf: u.
	index2 := self indexOf: v.
	self at: index2 put: u.
	self at: index1 put: v.
]

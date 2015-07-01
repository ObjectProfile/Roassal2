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
SequenceableCollection >> histogram [
	"
	Plot the histrogram (distribution) of the numerical values contained in myself.
	#(5 6 5 6 4 2 10) histogram
	#(5 6 5 6 4 2 10 10 10 10 10) histogram
	"
	
	| b ds |
	b := RTGrapher new.
	ds := RTHistogramSet new.
	ds points: self.
	ds barShape width: 10.
	ds barChartWithBarTitle: #second rotation: 0 color: Color black.
	b add: ds. 
	b axisX title: 'Values'.
	b axisY title: 'Occurences'.
	^ b
	
	
"	| b ds values |
	values := (RTDistribution on: self) annotatedFrequency.
	b := RTGrapher new.
	ds := RTStackedDataSet new.
	ds points: values.
	ds y: #first.
	ds interaction popupText: [ :tupple | tupple first asString, ' occurences of ', tupple second asString ].
	ds barShape width: 10.
	ds barChart #second rotation: 0 color: Color black.
	b add: ds.
	b axisX noLabel; noTick; title: 'Values'.
	b axisY title: 'Occurences'; noTick; noLabel.
	
	b addDecorator: (RTVerticalValuesDecorator new addAll: (0 to: (values collect: #first) max)).
	^ b "
]

{ #category : #'*roassal2-core' }
SequenceableCollection >> plot [
	"
	#(1 2 3 4 5) plot
	"
	| b ds |
	b := RTGrapher new.
	
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
	^ self plotFrequency: 10
]

{ #category : #'*roassal2-core' }
SequenceableCollection >> plotFrequency: nbOfInterval [
	
	"
	#(1 1 1 3 4 3 4) plotFrequency: 3
	"
	
	| b ds |
	b := RTGrapher new.
	
	"We defien the size of the charting area"
"	b extent: 500 @ 100.
"	
	ds := RTStackedDataSet new.
	"When the mouse is above a bar, say which class we are point at"
	ds interaction popupText: [ :set | set size printString, ' x ', set anyOne printString ].
	ds points: ((RTDistribution on: self) frequencyWithAmountOfIntervals: nbOfInterval).
	ds y: #size.
	ds barShape rectangle color: Color blue.
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

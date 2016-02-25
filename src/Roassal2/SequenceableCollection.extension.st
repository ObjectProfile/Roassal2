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
	"Plot the histrogram (distribution) of the numerical values given the metric block or symbol on my elements.
	#('yes' 'no' 'no' 'yes' 'yes' 'maybe' 'maybe' 'yes') histogram
	#(5 6 5 6 4 2 10 10 10 10) histogram
	(RTShape withAllSubclasses) histogram: #numberOfMethods
	"
	^ self histogram: #yourself.

]

{ #category : #'*roassal2-core' }
SequenceableCollection >> histogram: aBlockOrSymbol [
	"Plot the histrogram (distribution) of the numerical values given the metric block or symbol on my elements.
	#('yes' 'no' 'no' 'yes' 'yes' 'maybe' 'maybe' 'yes') histogram
	#(5 6 5 6 4 2 10 10 10 10 12 12 14 8 5 6 4 2 3 4 5 6) histogram
	(RTShape withAllSubclasses) histogram: #numberOfMethods
	"
	| b ds |
	b := RTGrapher new.
	
	ds := RTHistogramSet new.
	ds points: self.
	ds barShape width: 20.
	ds x: aBlockOrSymbol.
	
	ds barChartWithBarTitle: [:ar | 
		ar second isEmpty 
			ifTrue: ['[:]']
			ifFalse: ['[', (ar second first isNumber ifTrue: [ar second first floor] ifFalse: [ar second first]) asString,':', (ar second last isNumber ifTrue: [ar second last ceiling] ifFalse: [ar second last]) asString,']']
			].
			
	b add: ds. 
	b axisX title: 'Values'.
	b axisY title: 'Frequency'.
	
	^ b.
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
	
	ds := RTData new.
	"When the mouse is above a bar, say which class we are point at"
	ds interaction popup.
	ds points: self.
	ds dotShape rectangle color: Color blue.
	b add: ds.
	
	b build.
	^ b view
	
]

{ #category : #'*roassal2-core' }
SequenceableCollection >> removeDuplicates [
	| iterator |
	"Remove the copies of elements, but keep the same order"
	
	self ifEmpty: [ ^ self ].
	iterator := 1.
	[ iterator <= self size ]
		whileTrue: [ | each newIndex |
			each := self at: iterator.			
			[ newIndex := (self indexOf: each startingAt: iterator+1).
			newIndex > 0 ]
				whileTrue: [ self removeAt: newIndex ].
			iterator := iterator + 1.
	 ]
]

{ #category : #'*roassal2-core' }
SequenceableCollection >> rtSwapElement: u withElement: v [
	| index1 index2 |
	index1 := self indexOf: u.
	index2 := self indexOf: v.
	self at: index2 put: u.
	self at: index1 put: v.
]

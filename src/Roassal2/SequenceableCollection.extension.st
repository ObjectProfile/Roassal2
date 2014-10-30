Extension { #name : #SequenceableCollection }

{ #category : #'*roassal2-core' }
SequenceableCollection >> plot [

	| b |
	b := RTCharterBuilder new.
	
	"We defien the size of the charting area"
	b extent: 500 @ 100.
	
	"When the mouse is above a bar, say which class we are point at"
	b interaction popup.
	
	b points: self.
	b allY: #yourself.
	
	
	b shape rectangle color: Color blue.
	
	"All the bar have to be stacked from left to right"
	b stackX.
	
	b histogramBarWidth: 10.
	
	b axisX.
	b axisYWithNumberOfTicks: 4.
	
	b build.
	^ b view
	
]

{ #category : #'*roassal2-core' }
SequenceableCollection >> plotFrequency [
	self plotFrequency: 10
]

{ #category : #'*roassal2-core' }
SequenceableCollection >> plotFrequency: nbOfInterval [

	| b |
	b := RTCharterBuilder new.
	
	"We defien the size of the charting area"
	b extent: 500 @ 100.
	
	"When the mouse is above a bar, say which class we are point at"
	b interaction popup.
	
	b points: (RTDistribution on: self).
	b allY: #yourself.
	
	
	b shape rectangle color: Color blue.
	
	"All the bar have to be stacked from left to right"
	b stackX.
	
	b histogramBarWidth: 10.
	
	b axisX.
	b axisYWithNumberOfTicks: 4.
	
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

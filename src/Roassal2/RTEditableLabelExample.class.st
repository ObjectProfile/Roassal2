Class {
	#name : #RTEditableLabelExample,
	#superclass : #RTObject,
	#category : #'Roassal2-MorphSpecific'
}

{ #category : #examples }
RTEditableLabelExample >> editableSearchField [
	"
	self new editableSearchField.
	"
	| b lbl searchField |
b := RTMondrian new.

b nodes: Collection withAllSubclasses.
b edges connectFrom: #superclass.
b layout tree.
lbl := RTEditableLabel new text: 'Enter a pattern'.
searchField := lbl element.
searchField setAsFixed.

lbl editLabelShape: false;
	updateMorphExtent: false.
lbl onKeystroke: [ :text | 
	(b view elements select: [ :es | ('*', text, '*') match: es name ]) do: [ :e | RTBlink on: e ]].
lbl onPressingEnter: [ :text| lbl hideTextMorphFor: searchField ].

b view add: searchField.
RTHorizontalLineLayout on: (Array with: searchField). 

b
]

{ #category : #examples }
RTEditableLabelExample >> editableTextMultiLine [
	"
	self new editableTextMultiLine.
	"
	| v shape |
	v := RTView new.
	1 to: 20 do: [ :i |
			shape := RTEditableLabel new.
			shape text: 
'Red 
Yellow
Green'.
			v add: shape element@RTDraggable.
	].
	RTGridLayout on: v elements.
	
	v open
]

{ #category : #examples }
RTEditableLabelExample >> editableTextOneLine [
	"
	self new editableTextOneLine.
	"
	| v shape |
	v := RTView new.
	1 to: 20 do: [ :i |
			shape := RTEditableLabel new.
			shape text: 'Hello World'.
			v add: shape element@RTDraggable.
	].
	RTGridLayout on: v elements.
	
	v open
]

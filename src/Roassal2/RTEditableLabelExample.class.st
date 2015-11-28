"
I am a class example of RTEditable label
"
Class {
	#name : #RTEditableLabelExample,
	#superclass : #RTObject,
	#category : #'Roassal2-MorphSpecific'
}

{ #category : #examples }
RTEditableLabelExample >> editableSearchField [
	<gtExample>
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

^ b
]

{ #category : #examples }
RTEditableLabelExample >> editableTextMultiLine [
	<gtExample>
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
	
	^ v
]

{ #category : #examples }
RTEditableLabelExample >> editableTextOneLine [
	<gtExample>
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
	
	^ v
]

"
I am a label that can be emphasized.

!! Usage

==label emphasis: TextEmphasis bold.==
or
==label emphasis: { TextEmphasis bold . TextEmphasis underlined }==

!! Example

[[[
|v|
v := RTView new.
l := RTStyledLabel new
	color: Color black;
	emphasis: TextEmphasis underlined;
	elementOn: 'Underlined Text'.
v add: l.
v open.
]]]
"
Class {
	#name : #RTStyledLabel,
	#superclass : #RTLabel,
	#instVars : [
		'emphasis'
	],
	#category : #'Roassal2-Shapes'
}

{ #category : #accessing }
RTStyledLabel >> emphasis: aValueOrOneArgBlock [
	self emphasisElement: [ :anElement | aValueOrOneArgBlock rtValue: anElement model ]
]

{ #category : #accessing }
RTStyledLabel >> emphasisElement: aValueOrBlock [
	emphasis := aValueOrBlock
]

{ #category : #accessing }
RTStyledLabel >> emphasisFor: anElement [
	^ emphasis rtValue: anElement
]

{ #category : #initialization }
RTStyledLabel >> initialize [
	super initialize.
	emphasis := #()
]

{ #category : #'trachel shape production' }
RTStyledLabel >> trachelShapeForOneLine: anElement [
	| shape |
	shape := TRStyledLabelShape new.
	shape
		text: (self textFor: anElement);
		color: (self colorFor: anElement);
		position: anElement position;
		fontSize: (self heightFor: anElement);
		fontName: (self fontNameFor: anElement);
		emphasis: (self emphasisFor: anElement).
	^ shape
]

{ #category : #rendering }
RTStyledLabel >> widthFor: anElement [
	^ TRStyledLabelShape
		widthOfText: (self textFor: anElement)
		fontName: (self fontNameFor: fontName)
		fontSize: (self heightFor: anElement)
		emphasis: (self emphasisFor: anElement)
]

Class {
	#name : #RTTitleDecorator,
	#superclass : #RTAbstractGrapherDecorator,
	#instVars : [
		'title',
		'height'
	],
	#category : #'Roassal2-Builder-Grapher-Decorators'
}

{ #category : #accessing }
RTTitleDecorator >> height [
	^ height
]

{ #category : #accessing }
RTTitleDecorator >> height: heightAsInteger [
	height := heightAsInteger
]

{ #category : #initialization }
RTTitleDecorator >> initialize [
	super initialize.
	height := RTLabel defaultFontSize
]

{ #category : #hooks }
RTTitleDecorator >> render [
	| label |
	label := RTLabel new height: height; elementOn: title.
	self view add: label.
	TRConstraint move: label above: self view elements
]

{ #category : #accessing }
RTTitleDecorator >> title [
	^ title
]

{ #category : #accessing }
RTTitleDecorator >> title: titleAsString [
	title := titleAsString
]

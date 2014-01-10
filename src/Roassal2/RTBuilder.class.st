Class {
	#name : #RTBuilder,
	#superclass : #RTObject,
	#instVars : [
		'view'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #initialization }
RTBuilder >> initialize [
	super initialize.
	view := RTView new.
]

{ #category : #'public-ui' }
RTBuilder >> open [
	^ self openIn: view
]

{ #category : #'public-ui' }
RTBuilder >> openIn: aView [
	self renderIn: aView.
	^ aView open
]

{ #category : #hooks }
RTBuilder >> renderIn: aView [
	self subclassReponsibility
]

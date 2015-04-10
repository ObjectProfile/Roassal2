Class {
	#name : #RTAction,
	#superclass : #RTObject,
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTAction class >> on: element [
	"override this method to particularize the animation. 
	This method should return the animation"
	self subclassResponsibility
]

{ #category : #public }
RTAction class >> on: element in: view [
	| anim |
	anim := self on: element.
	view addAnimation: anim.
	anim start
]

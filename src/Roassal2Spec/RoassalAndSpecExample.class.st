Class {
	#name : #RoassalAndSpecExample,
	#superclass : #ComposableModel,
	#instVars : [
		'label',
		'diagram',
		'button1',
		'button2'
	],
	#category : #'Roassal2Spec-Example'
}

{ #category : #'as yet unclassified' }
RoassalAndSpecExample class >> defaultSpec [ 
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :tcol|
					tcol
						add: #label height: self toolbarHeight;
						add: #button1 height: self toolbarHeight;
						add: #button2 height: self toolbarHeight;
						add: #diagram ]
]

{ #category : #accessing }
RoassalAndSpecExample >> button1 [
	^ button1
]

{ #category : #accessing }
RoassalAndSpecExample >> button1: anObject [
	button1 := anObject
]

{ #category : #accessing }
RoassalAndSpecExample >> button2 [
	^ button2
]

{ #category : #accessing }
RoassalAndSpecExample >> button2: anObject [
	button2 := anObject
]

{ #category : #accessing }
RoassalAndSpecExample >> diagram [
	^ diagram
]

{ #category : #accessing }
RoassalAndSpecExample >> diagram: anObject [
	diagram := anObject
]

{ #category : #'as yet unclassified' }
RoassalAndSpecExample >> initializePresenter [

	"This causes the diagram's script to be executed again."
	button1 action: [ diagram inspect ]
]

{ #category : #initialization }
RoassalAndSpecExample >> initializeWidgets [

	label := self newLabel.
	label label: 'Simple example of combining Roassal and Spec' .

	button1 := self newButton.
	button1 label: 'Add Circle'.

	button2 := self newButton.
	button2 label: 'Layout!'.

	
	diagram := self instantiate: RoassalModel.	
"	diagram script: [ :view :canvas | self textAsCode value: view value: canvas ]"
]

{ #category : #accessing }
RoassalAndSpecExample >> label [
	^ label
]

{ #category : #accessing }
RoassalAndSpecExample >> label: anObject [
	label := anObject
]

"
A RTExampleBrowser is the main class to browse examples of Roassal
"
Class {
	#name : #RTExampleBrowser,
	#superclass : #RTObject,
	#classInstVars : [
		'icon'
	],
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #menu }
RTExampleBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>

	(aBuilder item: #'Roassal Examples')
		order: 0.1; 
		parent: #Roassal;
		label: 'Roassal examples';
		icon: RTIcon smallRoassal;
		action:[ self new open ]
]

{ #category : #utility }
RTExampleBrowser >> lineUpAndAnimate: aView [
	"Structure a view with a proper layout and animation"
	RTVerticalLineLayout on: aView elements.
	aView elements doWithIndex: [ :each :index | 
		| p |
		p := each position.
		each translateBy: (index * 50) @ 0.
		aView addAnimation: (RTLinearMove to: p during: 0.4 on: each) ].
	

]

{ #category : #'instance creation' }
RTExampleBrowser >> listExamplesOn: v [
	RTAbstractExample subclasses do: [ :c | c new installOn: v ]
]

{ #category : #'instance creation' }
RTExampleBrowser >> open [
	| v |
	v := RTView new.
	v @ RTVerticalDraggableView.
	self listExamplesOn: v.
	self lineUpAndAnimate: v.
	self show: v.
	self positionCameraOn: v
]

{ #category : #'instance creation' }
RTExampleBrowser >> positionCameraOn: v [
	| p |
	"We set the camera position where it fits to. We need to do this since there is an animation"
	p := v canvas camera position.	
	v canvas camera translateTo: 50 @ p y
]

{ #category : #'instance creation' }
RTExampleBrowser >> show: v [
	v openInWindowSized: 500 @ 500 titled: 'Roassal'
]

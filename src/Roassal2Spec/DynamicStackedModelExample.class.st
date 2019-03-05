"
I am an example to use spec with roassal and RTDynamicStackedGrapher
"
Class {
	#name : #DynamicStackedModelExample,
	#superclass : #ComposablePresenter,
	#instVars : [
		'buttonStart',
		'buttonStop',
		'roassalView',
		'play'
	],
	#category : #'Roassal2Spec-Example'
}

{ #category : #specs }
DynamicStackedModelExample class >> defaultSpec [ 
	<spec: #default>
	^ SpecLayout composed 
		newRow: [:trow | 
			trow add: #buttonStart; add: #buttonStop ] 
			height: self toolbarHeight ;
		newRow: [:trow | trow add: #roassalView ] top: self toolbarHeight.
]

{ #category : #'instance creation' }
DynamicStackedModelExample class >> open [
	<script>
	^ self new openWithSpec
]

{ #category : #accessing }
DynamicStackedModelExample >> buttonStart [
	^ buttonStart
]

{ #category : #accessing }
DynamicStackedModelExample >> buttonStart: anObject [
	buttonStart := anObject
]

{ #category : #accessing }
DynamicStackedModelExample >> buttonStop [
	^ buttonStop
]

{ #category : #accessing }
DynamicStackedModelExample >> buttonStop: anObject [
	buttonStop := anObject
]

{ #category : #initialization }
DynamicStackedModelExample >> initializePresenter [
	super initializePresenter.
	play := false.
	buttonStart action: [ play := true ].
	buttonStop action: [ play := false. ].
	
	roassalView script: [ :view :canvas | | builder animation |
		builder := self showChartOnView: view andCanvas: canvas.
		"T.T animations are not ok for roassal2, check out roassal3"
		animation := nil.
		
		animation := [ 
			view addAnimation: (RTNopAnimation new 
				waitFor: 0.5 after: [ 
					play ifTrue: [ builder add: 400 atRandom - 200 ].
					animation value.
					]).
			 ].
		animation value
	]
]

{ #category : #initialization }
DynamicStackedModelExample >> initializeWidgets [
    buttonStart := self newButton label: 'Start'.
    buttonStop := self newButton label: 'Stop'.
    roassalView := self instantiate: RoassalModel.
]

{ #category : #accessing }
DynamicStackedModelExample >> roassalView [
	^ roassalView
]

{ #category : #accessing }
DynamicStackedModelExample >> roassalView: anObject [
	roassalView := anObject
]

{ #category : #'as yet unclassified' }
DynamicStackedModelExample >> showChartOnView: iView andCanvas: iCanvas [
	| b cam |
	b := RTDynamicStackedGrapher new.
	b numberOfBars: 10.
	b
		minY: -200;
		maxY: 200.
	b y: #yourself.
	b barShape color: (Color red alpha: 0.3).
	iView addMenu: '+ 1' callback: [ b add: 400 atRandom - 200 ].
	b view: iView.
	b build.
	cam := iCanvas camera.
	cam focusOnCenter.
	^ b
]

{ #category : #accessing }
DynamicStackedModelExample >> title [
	^ 'Example for Discord'
]

Class {
	#name : #SpRoassal2Presenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'script'
	],
	#category : #'Roassal2Spec2-Core'
}

{ #category : #specs }
SpRoassal2Presenter class >> adapterName [
	^ #SpMorphicRoassal2Adapter
]

{ #category : #'instance creation' }
SpRoassal2Presenter class >> open [
	<script>
	^ self new openWithSpec
]

{ #category : #initialization }
SpRoassal2Presenter >> initialize [
	super initialize.
	script := [ :v | ] asValueHolder.
	script whenChangedDo: [ :s | self refresh ].
]

{ #category : #refreshing }
SpRoassal2Presenter >> refresh [ 
	self changed: #applyScript with: #()
]

{ #category : #initialization }
SpRoassal2Presenter >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #accessing }
SpRoassal2Presenter >> script [
	^ script value
]

{ #category : #accessing }
SpRoassal2Presenter >> script: anObject [

	"Set the block that draws the visualization.
	 It should take two arguments: the view and the canvas"

	script value: anObject
]

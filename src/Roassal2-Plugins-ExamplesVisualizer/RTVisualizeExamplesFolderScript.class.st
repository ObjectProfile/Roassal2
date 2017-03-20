"
I am a script that allows you to load the folder of the event examples
"
Class {
	#name : #RTVisualizeExamplesFolderScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins-ExamplesVisualizer'
}

{ #category : #accessing }
RTVisualizeExamplesFolderScript >> description [
	^ 'Let you select a directory containing the roassal2examples from event recorder and visualize it'
]

{ #category : #accessing }
RTVisualizeExamplesFolderScript >> execute [
	| root |
	"
	self new execute
	"
	root := UIManager default chooseDirectory: 'Open your roassal2examples directory'.
	root ifNil: [ ^ self ].
	root := 'c:\Users\azazael\Downloads\roassal2Examples\' asFileReference.
	self inform: 'Loading data please wait...'.
	[ | events v |
		events := GTEventUnpacking default safeUnpackDirectory: root.
		v := RTExamplesEventVizualizer new.
		v processEvents: events.
		v visualize.
	] fork.
	
	
]

{ #category : #accessing }
RTVisualizeExamplesFolderScript >> label [
	^ 'Visualize roassal2examples'
]

Class {
	#name : #RTVisualizeCSVFileScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins'
}

{ #category : #'as yet unclassified' }
RTVisualizeCSVFileScript >> description [
	^ 
'Let you select a csv file and open a Grapher visualization'
]

{ #category : #'as yet unclassified' }
RTVisualizeCSVFileScript >> execute [
	FileSystem disk inspect
]

{ #category : #'as yet unclassified' }
RTVisualizeCSVFileScript >> label [
	^ 'Browse and visualize CSV file'
]

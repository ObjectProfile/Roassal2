Class {
	#name : #RTViewFolderScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins'
}

{ #category : #'as yet unclassified' }
RTViewFolderScript >> description [
	^ 
'Let you select a directory and see its content. 
A color is given to each file based on its extension.'
]

{ #category : #'as yet unclassified' }
RTViewFolderScript >> execute [
	
	| fr allChildren b |
	fr := UIManager default chooseDirectory.
	fr ifNil: [ ^ self ].
	allChildren := fr allChildren.
	allChildren := allChildren copyWithout: fr.

	b := RTMondrian new.

	b nodes: fr children forEach: [ :fileRef |
		b shape box 
			size: [ :f | (f size + 1) log * 3 ].
		b nodes: fileRef allChildren.
		b edges connectFrom: #parent.
		b layout tree.

	].
	b layout verticalLine.
	b normalizer
		objects: allChildren;
		distinctColorUsing: #extension.

	b inspect
]

{ #category : #'as yet unclassified' }
RTViewFolderScript >> label [
	^ 'Visualizing Folder'
]

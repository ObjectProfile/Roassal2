Class {
	#name : #RTInspectorScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins'
}

{ #category : #accessing }
RTInspectorScript >> description [
	^ 
'Simple visual object inspector'
]

{ #category : #hooks }
RTInspectorScript >> execute [
	"This is the initial object you would like to inspect"
	| initialObject v b block |
	initialObject := RTView new.

	v := RTView new.
	v @ RTDraggableView.

	block := [ :anObject | 

		b := RTMondrian new.
		b shape box color: Color gray trans; withTextAbove.
		b node: anObject class name forIt: [
			b shape label text: #key;
				if: [:assoc | assoc value isNil ] color: Color brown.
			b interaction 
					noInteractions;
					highlight;
					when: TRMouseClick do: [ :evt | 
						| toElement |
						"When we click on a label, we add the nodes, and create a link"
						toElement := block value: evt element model value.
						v add: (RTArrowedLine new withShorterDistanceAttachPoint; edgeFrom: evt element to: toElement).
						v signalUpdate.
						 ];
					popupText: [ :ass | ass value asString ].
					
			b nodes: (anObject class instVarNames collect: [ :n | n -> (anObject instVarNamed: n) ]).
			b layout verticalLine.
		].
		b build.
		"The elements we have just built are added to the view"
		v addAll: b view elements.
		
		"We refresh the view"
		v signalUpdate.
		
		"We return the outter box, useful to draw the edge"
		b view elements first.
	].

	block value: initialObject.

	v inspect
]

{ #category : #accessing }
RTInspectorScript >> label [
	^ 'Simple Object Inspector'
]

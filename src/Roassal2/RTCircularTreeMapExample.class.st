"
I am an example class
"
Class {
	#name : #RTCircularTreeMapExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-CircularMap'
}

{ #category : #sources }
RTCircularTreeMapExample >> example01 [

	| b inst |
	b := RTCircularTreeMapBuilder new.
	b shape
		color: Color transparent;
		if: [ :m | Smalltalk includesKey: (m theClass name,'Test') asSymbol ] fillColor: (Color purple alpha: 0.3);
		if: [ :m | m theClass hasAbstractMethods ] fillColor: Color red;
		borderWidth: 2.
	inst := nil.
	b
		baseradius: 400;
		weight: #tally.
	b explore: (MessageTally new
		spyEvery: 1
		on: [ inst := Nautilus open]; yourself)
		using: #children.
	inst close.
	
	b build.
	^ b view
]

{ #category : #sources }
RTCircularTreeMapExample >> example02 [

	| b |
	b := RTCircularTreeMapBuilder new.
	b shape
		color: Color transparent;
		borderWidth: 1.
	b
		baseradius: 400;
		weight: [:n | n].
	b explore: 1
		using: [:n | n< 3 ifTrue: [Array with: n+1 with: n+2] ifFalse: [ #() ] ].
	
	b build.
	^ b view
]

{ #category : #sources }
RTCircularTreeMapExample >> example03 [

	| b dirSize |
	b := RTCircularTreeMapBuilder new.
	
	b shape
		color: Color transparent;
		borderWidth: 1;
		borderColor: Color white;
		if: [ :f | f isDirectory ] fillColor: Color transparent;
		if: [ :f | f isDirectory not ] fillColor: Color white.
	dirSize := nil.
	dirSize := [ :file | | size |
		file isDirectory 
		ifTrue: [
			size := 0.
			file children do: [ :child | size := size + (dirSize value: child)].
			size isZero ifTrue: [ 1 ] ifFalse: [ size ] ]
		ifFalse: [ size := file size.
			size isNumber ifTrue: [ size ] ifFalse: [ 1 ] ] ].
	b
		baseradius: 200;
		weight: [:file | file isDirectory ifTrue: [ dirSize value: file ] ifFalse: [ file size ] ].
	b explore: FileLocator home asFileReference
		using: [:file |	| children |
				[ children := file isDirectory ifTrue: [ file children ] ifFalse: [ #() ] ]
				on: Error do: [ children := #() ].
				children ] .
	
	b build.
	b view canvas color: Color black.
	^ b view
]

{ #category : #accessing }
RTCircularTreeMapExample >> label [
	^ 'Circular Tree map'
]

Class {
	#name : #RoassalSpotterIntegrationExample,
	#superclass : #Object,
	#category : #RoassalSpotterIntegration
}

{ #category : #'as yet unclassified' }
RoassalSpotterIntegrationExample >> example01 [
	"
	self new example01
	"
	
	| b |
	b := RTMondrian new.
	b nodes: GLMPresentation withAllSubclasses.
	b edges connectFrom: #superclass.
	b layout tree.
	b build.

	b view when: TRKeyDown do: [ :evt |
		(evt keyCombination = $F asKeyCombination) ifTrue: 
		 [ GTSpotterMorph new
				width: 400;
				doLayout;
				spotterModel: (GTSpotter on: b view);
				openCenteredInWorld ] ].
			
	b open
]

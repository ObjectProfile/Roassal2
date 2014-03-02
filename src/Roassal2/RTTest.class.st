Class {
	#name : #RTTest,
	#superclass : #TestCase,
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTTest >> readme [

"
Exporting the core of Roassal2 to Amber
Note that you need to have Trachel also exported

| exporter rootClasses soleClasses |
exporter := P2AExporterV11 new.
rootClasses := Array with: RTAnnounceableObject.
rootClasses do: [ :c |
	c withAllSubclasses do: [ :cc | exporter addClass: cc ] ].
soleClasses := { RTObject . RTShape . RTAbstractElementShape . RTBox . RTEllipse . RTAbstractLine . RTLine . RTNoShape }.
soleClasses do: [ :cc | exporter addClass: cc ].
exporter fileOutAsString


| exporter rootClasses |
exporter := P2AExporterV11 new.
rootClasses := Array with: RTShapeTest with: RTViewTest with: RTShape with: RTExample with: RTAnnounceableObject.
rootClasses do: [ :c |
	c withAllSubclasses do: [ :cc | exporter addClass: cc ] ].
exporter fileOutAsString

 

"
]

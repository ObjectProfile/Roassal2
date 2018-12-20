Extension { #name : #RTExperimentalExample }

{ #category : #'*Roassal2-UML' }
RTExperimentalExample >> exampleRadarOnUML [

| view radar |
view := RTUMLExample new exampleNoInstVar.
radar := RTRadar on: view.
"radar build. temporal disable"
^ view
]

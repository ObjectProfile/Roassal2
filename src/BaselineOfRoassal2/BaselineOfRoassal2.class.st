"
Baseline for https://github.com/ObjectProfile/Roassal2
"
Class {
	#name : #BaselineOfRoassal2,
	#superclass : #BaselineOf,
	#category : #BaselineOfRoassal2
}

{ #category : #baselines }
BaselineOfRoassal2 >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [			
			spec baseline: 'GToolkitExamples' with: [ 
				spec repository: 'github://feenkcom/gtoolkit-examples/src' ].
			spec baseline: 'Geometry' with: [ 
				spec repository: 'github://peteruhnak/geometry/repository' ].
					
			spec package: 'Athens-SVG' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
			spec
				package: 'Trachel';
				package: 'Roassal2-Core' with: [ spec requires: #('Trachel' 'Athens-SVG' 'Geometry') ];
				package: 'Roassal2' with: [ spec requires: #('Roassal2-Core') ];
				package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2-Exporter' with: [ spec requires: #('Trachel' 'Roassal2') ];
				package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'GToolkitExamples' 'Roassal2-Exporter') ];
				package: 'Roassal2-Rules' with: [ spec requires: #('Roassal2') ];
				
				package: 'Roassal2-Tests' with: [ spec requires: #('Trachel' 'Roassal2' 'Roassal2-Exporter') ];
				package: 'Roassal2-OpenStreetMap' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2-ExporterVW' with: [ spec requires: #('Roassal2') ] ]. 

			spec group: 'Core' with: #('Trachel' 'Roassal2-Core' 'Roassal2' 'Roassal2Spec' 'Roassal2-Exporter' 'Roassal2-Rules').
			spec group: 'Minimal' with: #('Core' 'Roassal2GT').
			spec group: 'NoGlamour' with: #('Core' 'Roassal2-Tests').
			spec group: 'Tests' with: #('Minimal' 'Roassal2-Tests').
			spec group: 'default' with: #('Tests' 'Roassal2-OpenStreetMap' 'Roassal2-ExporterVW').
]

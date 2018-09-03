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

			spec
				project: 'Neo-JSON-Core'
				with: [ spec
						className: #ConfigurationOfNeoJSON;
						version: #stable;
						repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].
					
			spec package: 'Athens-SVG' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
			spec
				package: 'WebBrowser-Core';
				package: 'Trachel';
				package: 'Roassal2' with: [ spec requires: #('Trachel' 'Athens-SVG' 'Geometry') ];
				package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'GToolkitExamples') ];
				package: 'Roassal2-Rules' with: [ spec requires: #('Roassal2') ].
				
			spec group: 'default' with: #('WebBrowser-Core' 'Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2GT' 'Roassal2-Rules').
			spec group: 'NoGlamour' with: #('WebBrowser-Core' 'Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2-Rules').
			spec group: 'Tests' with: #('WebBrowser-Core' 'Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2GT' 'Roassal2-Rules') ]
]

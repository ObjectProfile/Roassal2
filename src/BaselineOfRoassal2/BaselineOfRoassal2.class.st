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
				spec repository: 'github://pharo-contributions/Geometry/src' ].
			
			spec package: 'Athens-SVG-PathConverter' with: [
				spec repository: 'github://pharo-contributions/Athens-SVG' ].
			spec
				package: 'Trachel';
				package: 'Roassal2-Core' with: [ spec requires: #('Trachel' 'Athens-SVG-PathConverter' 'Geometry') ];
				package: 'Roassal2' with: [ spec requires: #('Roassal2-Core') ];
				package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2Spec2' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2-Exporter' with: [ spec requires: #('Trachel' 'Roassal2') ];
				package: 'Roassal2-Exporter-Tests' with: [ spec requires: #('Roassal2-Exporter' 'Roassal2-Tests') ];
				package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'GToolkitExamples' 'Roassal2-Exporter') ];
				package: 'Roassal2GT-Tests' with: [ spec requires: #('Roassal2GT' 'Roassal2-Tests') ];
				package: 'Roassal2-Rules' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2-Calendar' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2-BoxPlot' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2-DependencyStructuralMatrices' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2-Kiviat' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2-AxisAdapted' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2-AnimatedScatterPlot' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2-UML' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2-Benchmarks' with: [ spec requires: #('Roassal2' 'Roassal2-UML') ];
			
				package: 'Roassal2-Tests' with: [ spec requires: #('Trachel' 'Roassal2' 'Roassal2-Exporter') ];
				package: 'Roassal2-OpenStreetMap' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2-ExporterVW' with: [ spec requires: #('Roassal2') ] ]. 

			spec for: #(#'pharo10.x' #'pharo11.x' #'pharo12.x') do: [
				spec group: 'Roassal2SpecGroup' with: #(Roassal2Spec2)
			].
			spec for: #(#'pharo9.x') do: [
				spec group: 'Roassal2SpecGroup' with: #(Roassal2Spec Roassal2Spec2)
			].
			spec for: #(#'pharo8.x' #'pharo7.x') do: [
				spec group: 'Roassal2SpecGroup' with: #(Roassal2Spec).
			].	

			spec group: 'Core' with: #(
				'Trachel' 
				'Roassal2-Core'
				'Roassal2'
				'Roassal2SpecGroup'
				'Roassal2-Exporter'
				'Roassal2-Rules'
				'Roassal2-Calendar'
				'Roassal2-BoxPlot'
				'Roassal2-DependencyStructuralMatrices'
				'Roassal2-Kiviat'
				'Roassal2-AxisAdapted'
				'Roassal2-AnimatedScatterPlot'
				'Roassal2-UML'
				'Roassal2-Benchmarks').
			spec group: 'NoGlamour' with: #('Core' 'Roassal2-Tests' 'Roassal2-Exporter-Tests').
			
			spec for: #(#'pharo9.x' #'pharo8.x' #'pharo7.x') do: [
				spec group: 'Minimal' with: #('Core' 'Roassal2GT').
				spec group: 'Tests' with: #('Minimal' 'Roassal2-Tests' 'Roassal2-Exporter-Tests' 'Roassal2GT-Tests').
			].			
			spec for: #(#'pharo10.x' #'pharo11.x' #'pharo12.x') do: [
				spec group: 'Minimal' with: #('Core').
				spec group: 'Tests' with: #('NoGlamour').
			].
			
			spec group: 'default' with: #('Tests' 'Roassal2-OpenStreetMap' 'Roassal2-ExporterVW').
]

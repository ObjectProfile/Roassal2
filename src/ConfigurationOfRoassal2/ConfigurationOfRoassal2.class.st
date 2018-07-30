"
Copy me to create a new configuration or edit and evaluate the following doits.

        ""Create configuration class and initial baseline method""

        MetacelloToolBox 
                createBaseline: '1.0-baseline'
                for: 'MyProject'
                repository: 'http://www.example.com/MyProjectRepository'
                requiredProjects: #('Gofer')
                packages: #('MyProject-Core' 'MyProject-Tests')
                dependencies:
                        {('MyProject-Core' -> #('Gofer')).
                         ('MyProject-Tests' -> #('MyProject-Core'))}
                groups:
                        {('default' -> #('Core')).
                        ('Core' -> #('MyProject-Core')).
                        ('Tests' -> #('MyProject-Tests'))}.

	   ""create initial development method from the baseline""

         MetacelloToolBox
               createDevelopment: '1.0'
               for: 'MyProject'
                importFromBaseline: '1.0-baseline'
                description: 'initial version'.

"
Class {
	#name : #ConfigurationOfRoassal2,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfRoassal2
}

{ #category : #'development support' }
ConfigurationOfRoassal2 class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfRoassal2 class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #catalog }
ConfigurationOfRoassal2 class >> catalogContactInfo [
	^ 'info@objectprofile.com'
]

{ #category : #catalog }
ConfigurationOfRoassal2 class >> catalogDescription [
	^ 'Roassal is an agile visualization engine. Roassal graphically renders objects using short and expressive Smalltalk expressions. A large set of interaction facilities are provided for a better user experience. Painting, brushing, interconnecting, zooming, drag and dropping will just make you more intimate with any arbitrary object model.'
]

{ #category : #catalog }
ConfigurationOfRoassal2 class >> catalogKeywords [
	^ #('visualization' 'data' 'charting')
]

{ #category : #private }
ConfigurationOfRoassal2 class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfRoassal2 class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfRoassal2 class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfRoassal2 class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfRoassal2 class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfRoassal2 class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfRoassal2 class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfRoassal2 class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox)
		validateConfiguration: self
		debug: #()
		recurse: false) inspect
]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline10: spec [
	"Baselines are used by convention in Metacello and essentially are nothing else than normal versions.
	Name the baseline after the first version it was introduced.
	In this case 1.0-baseline was introduced the first time with the 1.0 version defined in the #version10 method.
	Metacello only uses the following tag to figure out the name of this baseline:"
	<version: '1.0-baseline'>

	"Using #common makes this dependency declaration available for all Smalltalks.
	If you need more fine-grained control you can add several #for:do: sections for other releases."
	spec for: #common do: [	
		spec blessing: #baseline.
		"specify the default repository for your project's packages"
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
	
		"specify the dependencies between packages and projects"
		spec
			"a package without dependencies:"
			package: 'Trachel';
			package: 'Roassal2' with: [ 
				"Specfiy dependencies using the #requires: directive, you can refer to any name here, in this case to an external project"
				spec requires: #('Trachel')].
			
		"using groups certain packages and projects can be loaded conditionally"
		spec 
			"load the tests by default"
			group: 'default' with: #('Trachel' 'Roassal2');
			group: 'test'    with: #('Trachel' 'Roassal2');
			group: 'core'    with: #('Trachel' 'Roassal2')]
]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline110: spec [
	<version: '1.10-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
		
		spec project: 'GlamourCore' with: [
			spec
				className: #ConfigurationOfGlamourCore;
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
		
		spec project: 'Neo-JSON-Core' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					version: #stable;
					repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].
				
		spec 
			package: 'Trachel';
			package: 'Roassal2' with: [ spec requires: #('Trachel') ];
			package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
			package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'GlamourCore') ];
			package: 'Roassal2-Rules' with: [ spec requires: #('Roassal2') ] ].

]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline111: spec [
	<version: '1.11-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
		
		spec project: 'GlamourCore' with: [
			spec
				className: #ConfigurationOfGlamourCore;
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
		
		spec project: 'Neo-JSON-Core' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					version: #stable;
					repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].
				
		spec 
			package: 'Trachel';
			package: 'Roassal2' with: [ spec requires: #('Trachel') ];
			package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
			package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'GlamourCore') ];
			package: 'Roassal2-Rules' with: [ spec requires: #('Roassal2') ] ].

]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline112: spec [
	<version: '1.12-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
		
		spec project: 'GlamourCore' with: [
			spec
				className: #ConfigurationOfGlamourCore;
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
		
		spec project: 'Neo-JSON-Core' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					version: #stable;
					repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].

	spec
		package: 'Athens-SVG' with: [ 
			spec
				repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
				
		spec 
			package: 'Trachel';
			package: 'Roassal2' with: [ spec requires: #('Trachel' 'Athens-SVG') ];
			package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
			package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'GlamourCore') ];
			package: 'Roassal2-Rules' with: [ spec requires: #('Roassal2') ] ].

]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline113: spec [
	<version: '1.13-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
		
		spec project: 'GlamourCore' with: [
			spec
				className: #ConfigurationOfGlamourCore;
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
		
		spec project: 'GTExamples' with: [
			spec
				className: #ConfigurationOfGTExamples;
				version: #development;
				repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			
		spec baseline: 'Geometry' with: [
			spec repository: 'github://peteruhnak/geometry/repository' ].

		spec project: 'Neo-JSON-Core' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					version: #stable;
					repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].

	spec
		package: 'Athens-SVG' with: [ 
			spec
				repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
				
		spec 
			package: 'Trachel';
			package: 'Roassal2' with: [ spec requires: #('Trachel' 'Athens-SVG' 'Geometry') ];
			package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
			package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'GlamourCore' 'GTExamples') ];
			package: 'Roassal2-Rules' with: [ spec requires: #('Roassal2') ] ].

]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline114: spec [
	<version: '1.14-baseline'>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
			spec
				project: 'GlamourCore'
				with: [ spec
						className: #ConfigurationOfGlamourCore;
						version: #development;
						repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
			spec
				project: 'GTExamples'
				with: [ spec
						className: #ConfigurationOfGTExamples;
						version: #development;
						repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			spec baseline: 'Geometry' with: [ spec repository: 'github://peteruhnak/geometry/repository' ].
			spec
				project: 'Neo-JSON-Core'
				with: [ spec
						className: #ConfigurationOfNeoJSON;
						version: #stable;
						repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].
			spec package: 'Athens-SVG' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
			spec
				package: 'Trachel';
				package: 'Roassal2' with: [ spec requires: #('Trachel' 'Athens-SVG' 'Geometry') ];
				package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'GlamourCore' 'GTExamples') ];
				package: 'Roassal2-Rules' with: [ spec requires: #('Roassal2') ] ]
]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline115: spec [
	<version: '1.15-baseline'>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
			spec
				project: 'GlamourCore'
				with: [ spec
						className: #ConfigurationOfGlamourCore;
						version: #development;
						repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
			spec
				project: 'GTExamples'
				with: [ spec
						className: #ConfigurationOfGTExamples;
						version: #development;
						repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			spec baseline: 'Geometry' with: [ spec repository: 'github://peteruhnak/geometry/repository' ].
			spec
				project: 'Neo-JSON-Core'
				with: [ spec
						className: #ConfigurationOfNeoJSON;
						version: #stable;
						repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].
			spec package: 'Athens-SVG' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
			spec
				package: 'Trachel';
				package: 'Roassal2' with: [ spec requires: #('Trachel' 'Athens-SVG' 'Geometry') ];
				package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'GlamourCore' 'GTExamples') ];
				package: 'Roassal2-Rules' with: [ spec requires: #('Roassal2') ].
				
			spec group: 'default' with: #('Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2GT' 'Roassal2-Rules').
			spec group: 'NoGlamour' with: #('Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2-Rules') ]
]

{ #category : #baselines }
ConfigurationOfRoassal2 >> baseline116: spec [
	<version: '1.16-baseline'>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
			spec
				project: 'GlamourCore'
				with: [ spec
						className: #ConfigurationOfGlamourCore;
						version: #development;
						repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
			spec
				project: 'GTExamples'
				with: [ spec
						className: #ConfigurationOfGTExamples;
						version: #development;
						repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			spec baseline: 'Geometry' with: [ spec repository: 'github://peteruhnak/geometry/repository' ].
			spec
				project: 'Neo-JSON-Core'
				with: [ spec
						className: #ConfigurationOfNeoJSON;
						version: #stable;
						repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].
			spec package: 'Athens-SVG' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
			spec
				package: 'Trachel';
				package: 'Roassal2' with: [ spec requires: #('Trachel' 'Athens-SVG' 'Geometry') ];
				package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'GlamourCore' 'GTExamples') ];
				package: 'Roassal2-Rules' with: [ spec requires: #('Roassal2') ].
				
			spec group: 'default' with: #('Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2GT' 'Roassal2-Rules').
			spec group: 'NoGlamour' with: #('Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2-Rules').
			spec group: 'Tests' with: #('Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2GT' 'Roassal2-Rules') ]
]

{ #category : #baselines }
ConfigurationOfRoassal2 >> baseline117: spec [
	<version: '1.17-baseline'>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
			spec
				project: 'GlamourCore'
				with: [ spec
						className: #ConfigurationOfGlamourCore;
						version: #development;
						repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
			spec
				project: 'GTExamples'
				with: [ spec
						className: #ConfigurationOfGTExamples;
						version: #development;
						repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
					
					
			spec baseline: 'Geometry' with: [ 
				spec repository: 'github://peteruhnak/geometry/repository' ].

			spec
				project: 'Neo-JSON-Core'
				with: [ spec
						className: #ConfigurationOfNeoJSON;
						version: #stable;
						repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].

			"Some menu added by Roassal open a webpage"
			spec
				project: 'WebBrowser'
				with: [ spec
						className: #ConfigurationOfWebBrowser;
						version: #stable;
						repository: 'http://smalltalkhub.com/mc/TorstenBergmann/WebBrowser/main' ].
					
			spec package: 'Athens-SVG' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
			spec
				package: 'Trachel';
				package: 'Roassal2' with: [ spec requires: #('Trachel' 'Athens-SVG' 'Geometry') ];
				package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'GlamourCore' 'GTExamples') ];
				package: 'Roassal2-Rules' with: [ spec requires: #('Roassal2') ].
				
			spec group: 'default' with: #('WebBrowser' 'Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2GT' 'Roassal2-Rules').
			spec group: 'NoGlamour' with: #('WebBrowser' 'Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2-Rules').
			spec group: 'Tests' with: #('WebBrowser' 'Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2GT' 'Roassal2-Rules') ]
]

{ #category : #baselines }
ConfigurationOfRoassal2 >> baseline118: spec [
	<version: '1.18-baseline'>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
			spec
				project: 'GlamourCore'
				with: [ spec
						className: #ConfigurationOfGlamourCore;
						version: #development;
						repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
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

			"Some menu added by Roassal open a webpage"
			spec
				project: 'WebBrowser'
				with: [ spec
						className: #ConfigurationOfWebBrowser;
						version: #stable;
						repository: 'http://smalltalkhub.com/mc/TorstenBergmann/WebBrowser/main' ].
					
			spec package: 'Athens-SVG' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
			spec
				package: 'Trachel';
				package: 'Roassal2' with: [ spec requires: #('Trachel' 'Athens-SVG' 'Geometry') ];
				package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'GlamourCore' 'GToolkitExamples') ];
				package: 'Roassal2-Rules' with: [ spec requires: #('Roassal2') ].
				
			spec group: 'default' with: #('WebBrowser' 'Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2GT' 'Roassal2-Rules').
			spec group: 'NoGlamour' with: #('WebBrowser' 'Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2-Rules').
			spec group: 'Tests' with: #('WebBrowser' 'Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2GT' 'Roassal2-Rules') ]
]

{ #category : #baselines }
ConfigurationOfRoassal2 >> baseline119: spec [
	<version: '1.19-baseline'>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
			
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

			"Some menu added by Roassal open a webpage"
			spec
				project: 'WebBrowser'
				with: [ spec
						className: #ConfigurationOfWebBrowser;
						version: #stable;
						repository: 'http://smalltalkhub.com/mc/TorstenBergmann/WebBrowser/main' ].
					
			spec package: 'Athens-SVG' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
			spec
				package: 'Trachel';
				package: 'Roassal2' with: [ spec requires: #('Trachel' 'Athens-SVG' 'Geometry') ];
				package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
				package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'GToolkitExamples') ];
				package: 'Roassal2-Rules' with: [ spec requires: #('Roassal2') ].
				
			spec group: 'default' with: #('WebBrowser' 'Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2GT' 'Roassal2-Rules').
			spec group: 'NoGlamour' with: #('WebBrowser' 'Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2-Rules').
			spec group: 'Tests' with: #('WebBrowser' 'Trachel' 'Roassal2' 'Roassal2Spec' 'Roassal2GT' 'Roassal2-Rules') ]
]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline11: spec [
	"Baselines are used by convention in Metacello and essentially are nothing else than normal versions.
	Name the baseline after the first version it was introduced.
	In this case 1.0-baseline was introduced the first time with the 1.0 version defined in the #version10 method.
	Metacello only uses the following tag to figure out the name of this baseline:"
	<version: '1.1-baseline'>

	"Using #common makes this dependency declaration available for all Smalltalks.
	If you need more fine-grained control you can add several #for:do: sections for other releases."
	spec for: #common do: [	
		spec blessing: #baseline.
		"specify the default repository for your project's packages"
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
	

		"specify the dependencies between packages and projects"
		spec
			"a package without dependencies:"
			package: 'Trachel';
			package: 'Roassal2' with: [ 
				"Specfiy dependencies using the #requires: directive, you can refer to any name here, in this case to an external project"
				spec requires: #('Trachel')];
			package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ].
			
		spec 
			"load the tests by default"
			group: 'default' with: #('Trachel' 'Roassal2' 'Roassal2Spec');
			group: 'test'    with: #('Trachel' 'Roassal2' 'Roassal2Spec');
			group: 'core'    with: #('Trachel' 'Roassal2' 'Roassal2Spec')]
]

{ #category : #baselines }
ConfigurationOfRoassal2 >> baseline120: spec [
	<version: '1.20-baseline'>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
			
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

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline12: spec [
	"Baselines are used by convention in Metacello and essentially are nothing else than normal versions.
	Name the baseline after the first version it was introduced.
	In this case 1.0-baseline was introduced the first time with the 1.0 version defined in the #version10 method.
	Metacello only uses the following tag to figure out the name of this baseline:"
	<version: '1.2-baseline'>

	"Using #common makes this dependency declaration available for all Smalltalks.
	If you need more fine-grained control you can add several #for:do: sections for other releases."
	spec for: #common do: [	
		spec blessing: #baseline.
		"specify the default repository for your project's packages"
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
	

		"specify the dependencies between packages and projects"
		spec
			"a package without dependencies:"
			package: 'Trachel';
			package: 'Roassal2' with: [ 
				"Specfiy dependencies using the #requires: directive, you can refer to any name here, in this case to an external project"
				spec requires: #('Trachel')];
			package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
				
			package: 'GT-SpotterExtensions-CoreRoassal' with: [ 
				spec 
						repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main' ].
			
		spec 
			"load the tests by default"
			group: 'default' with: #('Trachel' 'Roassal2' 'Roassal2Spec' 'GT-SpotterExtensions-CoreRoassal');
			group: 'test'    with: #('Trachel' 'Roassal2' 'Roassal2Spec' 'GT-SpotterExtensions-CoreRoassal');
			group: 'core'    with: #('Trachel' 'Roassal2' 'Roassal2Spec' 'GT-SpotterExtensions-CoreRoassal') ]
]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline13: spec [
	"Baselines are used by convention in Metacello and essentially are nothing else than normal versions.
	Name the baseline after the first version it was introduced.
	In this case 1.0-baseline was introduced the first time with the 1.0 version defined in the #version10 method.
	Metacello only uses the following tag to figure out the name of this baseline:"
	<version: '1.3-baseline'>

	"Using #common makes this dependency declaration available for all Smalltalks.
	If you need more fine-grained control you can add several #for:do: sections for other releases."
	spec for: #common do: [	
		spec blessing: #baseline.
		"specify the default repository for your project's packages"
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
	

		"specify the dependencies between packages and projects"
		spec
			"a package without dependencies:"
			package: 'Trachel';
			package: 'Roassal2' with: [ 
				"Specfiy dependencies using the #requires: directive, you can refer to any name here, in this case to an external project"
				spec requires: #('Trachel')];
			package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
				
			package: 'GT-SpotterExtensions-CoreRoassal' with: [ 
				spec 
						repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main' ];

			package: 'Neo-JSON-Core' with: [ 
				spec 
						repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].
			
		spec 
			"load the tests by default"
			group: 'default' with: #('Trachel' 'Roassal2' 'Roassal2Spec' 'GT-SpotterExtensions-CoreRoassal' 'Neo-JSON-Core');
			group: 'test'    with: #('Trachel' 'Roassal2' 'Roassal2Spec' 'GT-SpotterExtensions-CoreRoassal' 'Neo-JSON-Core');
			group: 'core'    with: #('Trachel' 'Roassal2' 'Roassal2Spec' 'GT-SpotterExtensions-CoreRoassal' 'Neo-JSON-Core') ]
]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline14: spec [
	"Baselines are used by convention in Metacello and essentially are nothing else than normal versions.
	Name the baseline after the first version it was introduced.
	In this case 1.0-baseline was introduced the first time with the 1.0 version defined in the #version10 method.
	Metacello only uses the following tag to figure out the name of this baseline:"
	<version: '1.4-baseline'>

	"Using #common makes this dependency declaration available for all Smalltalks.
	If you need more fine-grained control you can add several #for:do: sections for other releases."
	spec for: #common do: [	
		spec blessing: #baseline.
		"specify the default repository for your project's packages"
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.
	

		"specify the dependencies between packages and projects"
		spec
			"a package without dependencies:"
			package: 'Trachel';
			package: 'Roassal2' with: [ 
				"Specfiy dependencies using the #requires: directive, you can refer to any name here, in this case to an external project"
				spec requires: #('Trachel')];
			package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
			package: 'GT-SpotterExtensions-CoreRoassal' with: [ 
				spec 
						repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main' ];
			package: 'Neo-JSON-Core' with: [ 
				spec 
						repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].
			]
]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline15: spec [
	<version: '1.5-baseline'>

	spec for: #common do: [	
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.

		spec project: 'GlamourCore' with: [ 
			spec
				className: 'ConfigurationOfGlamourCore'; 
				repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
			].	

		spec
			package: 'Trachel';
			package: 'Roassal2' with: [ 
				spec requires: #('Trachel')];
			package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
			package: 'Glamour-Tools' with: [ 
				spec 
					 	requires: 'GlamourCore';
						repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main' ];
			package: 'Glamour-Roassal2-Presentations' with: [ 
				spec 
						requires: 'Glamour-Tools';
						repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main' ];
					
			package: 'GT-InspectorExtensions-CoreRoassal' with: [ 
				spec 
						requires: 'Glamour-Roassal2-Presentations';
						repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main' ];
			package: 'GT-SpotterExtensions-CoreRoassal' with: [ 
				spec 
						requires: 'Glamour-Roassal2-Presentations';
						repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main' ];
			package: 'Neo-JSON-Core' with: [ 
				spec 
						repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].
			]
]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline16: spec [
	<version: '1.6-baseline'>

	spec for: #common do: [	
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.

		spec project: 'GlamourCore' with: [ 
			spec
				className: 'ConfigurationOfGlamourCore'; 
				version: #development;
				repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
			].	

		spec project: 'Neo-JSON-Core' with: [ 
			spec
				className: 'ConfigurationOfNeoJSON'; 
				repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main'.
			].	

		spec
			package: 'Trachel';
			package: 'Roassal2' with: [ 
				spec requires: #('Trachel')];
			package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
			package: 'Glamour-Tools' with: [ 
				spec 
					 	requires: 'GlamourCore';
						repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main' ];
			package: 'Glamour-Roassal2-Presentations' with: [ 
				spec 
						requires: 'Glamour-Tools';
						repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main' ];
					
			package: 'GT-InspectorExtensions-CoreRoassal' with: [ 
				spec 
						requires: 'Glamour-Roassal2-Presentations';
						repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main' ];
			package: 'GT-SpotterExtensions-CoreRoassal' with: [ 
				spec 
						requires: 'Glamour-Roassal2-Presentations';
						repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main' ] ]
]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline17: spec [
	<version: '1.7-baseline'>

	spec for: #common do: [	
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.

		spec project: 'GlamourCore' with: [ 
			spec
				className: 'ConfigurationOfGlamourCore'; 
				version: #development;
				repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
			].	

		spec project: 'Neo-JSON-Core' with: [ 
			spec
				className: 'ConfigurationOfNeoJSON'; 
				repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main'.
			].	

		spec
			package: 'Trachel';
			package: 'Roassal2' with: [ 
				spec requires: #('Trachel')];
			package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
			package: 'Glamour-Tools' with: [ 
				spec 
					 	requires: 'GlamourCore';
						repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main' ];
			package: 'Glamour-Roassal2-Presentations' with: [ 
				spec 
						requires: 'Glamour-Tools';
						repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main' ];
					
			package: 'GT-InspectorExtensions-CoreRoassal' with: [ 
				spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main'.
				
				spec 
						requires: 'Glamour-Roassal2-Presentations';
						repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ];
			package: 'GT-SpotterExtensions-CoreRoassal' with: [ 
				spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main'.
				spec 
						requires: 'Glamour-Roassal2-Presentations';
						repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ] ]
]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline18: spec [
	<version: '1.8-baseline'>

	spec for: #common do: [	
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.

		spec project: 'GlamourCore' with: [ 
			spec
				className: 'ConfigurationOfGlamourCore'; 
				version: #development;
				repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
			].	

		spec project: 'Neo-JSON-Core' with: [ 
			spec
				className: 'ConfigurationOfNeoJSON'; 
				repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main'.
			].	

		spec
			package: 'Trachel';
			package: 'Roassal2' with: [ 
				spec requires: #('Trachel')];
			package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
			package: 'Glamour-Tools' with: [ 
				spec 
					 	requires: 'GlamourCore';
						repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main' ];
			package: 'Roassal2GT'
"			package: 'Glamour-Roassal2-Presentations' with: [ 
				spec 
						requires: 'Glamour-Tools';
						repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main' ];
					
			package: 'GT-InspectorExtensions-CoreRoassal' with: [ 
				spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main'.
				
				spec 
						requires: 'Glamour-Roassal2-Presentations';
						repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ];
			package: 'GT-SpotterExtensions-CoreRoassal' with: [ 
				spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main'.
				spec 
						requires: 'Glamour-Roassal2-Presentations';
						repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ] 
"					
					]
]

{ #category : #'old-baselines' }
ConfigurationOfRoassal2 >> baseline19: spec [
	<version: '1.9-baseline'>

	spec for: #common do: [	
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main'.

		spec project: 'Glamour' with: [ 
			spec
				className: 'ConfigurationOfGlamour'; 
				version: #development;
				repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
			].	
		
		spec project: 'Neo-JSON-Core' with: [ 
			spec
				className: 'ConfigurationOfNeoJSON'; 
				repository: 'http://www.smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main'.
			].	

		spec
			package: 'Trachel';
			package: 'Roassal2' with: [ 
				spec requires: #('Trachel')];
			package: 'Roassal2Spec' with: [ spec requires: #('Roassal2') ];
			package: 'Roassal2GT' with: [ spec requires: #('Roassal2' 'Glamour') ]			
	]
]

{ #category : #accessing }
ConfigurationOfRoassal2 >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #symbolic }
ConfigurationOfRoassal2 >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.4-baseline'.
	spec for: #'pharo4.x' version: '1.5-baseline'.
	spec for: #'pharo5.x' version: '1.13-baseline'.
	spec for: #'pharo6.x' version: '1.20-baseline'.
	spec for: #'pharo7.x' version: '1.21-baseline'.
]

{ #category : #accessing }
ConfigurationOfRoassal2 >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #symbolic }
ConfigurationOfRoassal2 >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.11'.
	spec for: #'pharo4.x' version: '1.13'.
	spec for: #'pharo3.x' version: '1.6'.
	spec for: #'pharo5.x' version: '1.50'.
	spec for: #'pharo6.x' version: '1.58'.
	spec for: #'pharo7.x' version: '1.61'.
]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version10: spec [
	<version: '1.0' imports: #('1.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '7/2/2014 11:25'.
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.161';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.375';
			package: 'Roassal2Spec' with: 'Roassal2Spec-BenjaminVanRyseghem.4'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version110: spec [
	<version: '1.10' imports: #('1.4-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.10'.
		spec author: 'AndreiChis'.
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.285';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.898';
			package: 'Roassal2Spec' with: 'Roassal2Spec-johanfabry.6';
			package: 'GT-SpotterExtensions-CoreRoassal' with: 'GT-SpotterExtensions-CoreRoassal-AndreiChis.15';
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.29'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version111: spec [
	<version: '1.11' imports: #('1.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.11'.
		spec author: 'AlejandroInfante'.
		spec project: 'GlamourCore' with: '3.1.1'.
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.285';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.898';
			package: 'Roassal2Spec' with: 'Roassal2Spec-johanfabry.6';
			package: 'Glamour-Tools' with: 'Glamour-Tools-TudorGirba.85';
			package: 'Glamour-Roassal2-Presentations' with: 'Glamour-Roassal2-Presentations-TudorGirba.38';
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-TudorGirba.44';
			package: 'GT-SpotterExtensions-CoreRoassal' with: 'GT-SpotterExtensions-CoreRoassal-AndreiChis.15';
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.29'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version112: spec [
	<version: '1.12' imports: #('1.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'broken'.
		spec description: 'version 1.12 - For Pharo4/Moose5.1'.
		spec author: 'AndreiChis'.
		spec project: 'GlamourCore' with: '3.1.4'.
		spec 
			package: 'Trachel' with: 'Trachel-akevalion.287';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.913';
			package: 'Roassal2Spec' with: 'Roassal2Spec-johanfabry.6';
			package: 'Glamour-Tools' with: 'Glamour-Tools-TudorGirba.85';
			package: 'Glamour-Roassal2-Presentations' with: 'Glamour-Roassal2-Presentations-TudorGirba.38';
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-TudorGirba.44';
			package: 'GT-SpotterExtensions-CoreRoassal' with: 'GT-SpotterExtensions-CoreRoassal-AndreiChis.15';
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.29'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version113: spec [
	<version: '1.13' imports: #('1.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.13'.
		spec author: 'AndreiChis'.
		spec project: 'GlamourCore' with: '3.1.4'.
		spec 
			package: 'Trachel' with: 'Trachel-akevalion.290';
			package: 'Roassal2' with: 'Roassal2-AndreiChis.923';
			package: 'Roassal2Spec' with: 'Roassal2Spec-johanfabry.6';
			package: 'Glamour-Tools' with: 'Glamour-Tools-TudorGirba.85';
			package: 'Glamour-Roassal2-Presentations' with: 'Glamour-Roassal2-Presentations-TudorGirba.38';
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-TudorGirba.44';
			package: 'GT-SpotterExtensions-CoreRoassal' with: 'GT-SpotterExtensions-CoreRoassal-AndreiChis.15';
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.29'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version114: spec [
	<version: '1.14' imports: #('1.6-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.14'.
		spec author: 'AndreiChis'.
		spec project: 'GlamourCore' with: '3.1.4'.
		spec project: 'Neo-JSON-Core' with: '10'.
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.291';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.942';
			package: 'Roassal2Spec' with: 'Roassal2Spec-johanfabry.6';
			package: 'Glamour-Tools' with: 'Glamour-Tools-TudorGirba.85';
			package: 'Glamour-Roassal2-Presentations' with: 'Glamour-Roassal2-Presentations-TudorGirba.38';
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-TudorGirba.44';
			package: 'GT-SpotterExtensions-CoreRoassal' with: 'GT-SpotterExtensions-CoreRoassal-AndreiChis.15' ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version115: spec [
	<version: '1.15' imports: #('1.6-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.15 for Pharo4'.
		spec author: 'AlexandreBergel'.
		spec project: 'GlamourCore' with: '3.1.4'.
		spec project: 'Neo-JSON-Core' with: '10'.
		spec 
			package: 'Trachel' with: 'Trachel-PeterUhnak.325';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1049';
			package: 'Roassal2Spec' with: 'Roassal2Spec-johanfabry.6';
			package: 'Glamour-Tools' with: 'Glamour-Tools-TudorGirba.85';
			package: 'Glamour-Roassal2-Presentations' with: 'Glamour-Roassal2-Presentations-TudorGirba.38';
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-TudorGirba.44';
			package: 'GT-SpotterExtensions-CoreRoassal' with: 'GT-SpotterExtensions-CoreRoassal-AndreiChis.15' ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version116: spec [
	<version: '1.17' imports: #('1.7-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Release'.
		spec author: 'AlexandreBergel'.
		spec project: 'GlamourCore' with: '3.1.4'.
		spec project: 'Neo-JSON-Core' with: '10'.
		spec 
			package: 'Trachel' with: 'Trachel-akevalion.330';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1102';
			package: 'Roassal2Spec' with: 'Roassal2Spec-johanfabry.10';
			package: 'Glamour-Tools' with: 'Glamour-Tools-TudorGirba.85';
			package: 'Glamour-Roassal2-Presentations' with: 'Glamour-Roassal2-Presentations-AlexandreBergel.41';
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-StefanReichhart';
			package: 'GT-SpotterExtensions-CoreRoassal' with: 'GT-SpotterExtensions-CoreRoassal-StefanReichhart.21' ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version117: spec [
	<version: '1.17' imports: #('1.7-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Release'.
		spec author: 'AlexandreBergel'.
		spec project: 'GlamourCore' with: '3.1.4'.
		spec project: 'Neo-JSON-Core' with: '10'.
		spec 
			package: 'Trachel' with: 'Trachel-akevalion.330';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1102';
			package: 'Roassal2Spec' with: 'Roassal2Spec-johanfabry.10';
			package: 'Glamour-Tools' with: 'Glamour-Tools-TudorGirba.85';
			package: 'Glamour-Roassal2-Presentations' with: 'Glamour-Roassal2-Presentations-AlexandreBergel.41';
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-StefanReichhart';
			package: 'GT-SpotterExtensions-CoreRoassal' with: 'GT-SpotterExtensions-CoreRoassal-StefanReichhart.21' ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version118: spec [
	<version: '1.18' imports: #('1.7-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Release'.
		spec author: 'AlexandreBergel'.
		spec project: 'GlamourCore' with: '3.1.4'.
		spec project: 'Neo-JSON-Core' with: '10'.
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.331';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1105';
			package: 'Roassal2Spec' with: 'Roassal2Spec-johanfabry.10';
			package: 'Glamour-Tools' with: 'Glamour-Tools-TudorGirba.85';
			package: 'Glamour-Roassal2-Presentations' with: 'Glamour-Roassal2-Presentations-AlexandreBergel.41';
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-StefanReichhart';
			package: 'GT-SpotterExtensions-CoreRoassal' with: 'GT-SpotterExtensions-CoreRoassal-StefanReichhart.21' ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version119: spec [
	<version: '1.19' imports: #('1.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Release'.
		spec author: 'AlexandreBergel'.
		spec project: 'GlamourCore' with: '3.1.4'.
		spec project: 'Neo-JSON-Core' with: '10'.
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.331';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1105';
			package: 'Roassal2Spec' with: 'Roassal2Spec-johanfabry.10';
			package: 'Glamour-Tools' with: 'Glamour-Tools-TudorGirba.85';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.1' ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version11: spec [
	<version: '1.1' imports: #('1.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.1'.
		spec author: 'AndreiChis'.
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.234';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.585';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.5'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version120: spec [
	<version: '1.20' imports: #('1.9-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Release'.
		spec author: 'AlexandreBergel'.
		spec project: 'Glamour' with: '3.3.2'.
		spec project: 'Neo-JSON-Core' with: '10'.
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.345';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1188';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-TudorGirba.31' ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version122: spec [
	<version: '1.22' imports: #('1.9-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Release'.
		spec author: 'AlexandreBergel'.
		spec project: 'Glamour' with: '3.3.2'.
		spec project: 'Neo-JSON-Core' with: '10'.
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.348';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1224';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-TudorGirba.31' ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version123: spec [
	<version: '1.23' imports: #('1.10-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.23'.
		spec author: 'YuriyTymchuk'.
		spec timestamp: '3/2/2016 13:03'.
		
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.352';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1238';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.33';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.1'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version124: spec [
	<version: '1.24' imports: #('1.10-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.24'.
		spec author: 'AlexandreBergel'.
		spec timestamp: '5/5/2016'.
		
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.360';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1300';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.33';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version125: spec [
	<version: '1.25' imports: #('1.10-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.25'.
		spec author: 'AlexandreBergel'.
		spec timestamp: '5/6/2016'.
		
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.361';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1303';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.33';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version126: spec [
	<version: '1.26' imports: #('1.10-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.26'.
		spec author: 'AlexandreBergel'.
		spec timestamp: '5/8/2016'.
		
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.361';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1307';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.33';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version127: spec [
	<version: '1.27' imports: #('1.11-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'All tests are green'.
		spec author: 'AlexandreBergel'.
		spec timestamp: '5/13/2016'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.367';
			package: 'Roassal2' with: 'Roassal2-akevalion.1315';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-TudorGirba.34';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version128: spec [
	<version: '1.28' imports: #('1.12-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'All tests are green'.
		spec author: 'AlexandreBergel'.
		spec timestamp: '5/13/2016'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.367';
			package: 'Roassal2' with: 'Roassal2-akevalion.1315';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-TudorGirba.34';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version129: spec [
	<version: '1.29' imports: #('1.13-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Added geometry package'.
		spec author: 'AlexandreBergel'.
		spec timestamp: '5/17/2016'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-PeterUhnak.368';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1319';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-TudorGirba.34';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version12: spec [
	<version: '1.2' imports: #('1.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2'.
		spec author: 'AndreiChis'.
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.237';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.600';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.5'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version130: spec [
	<version: '1.30' imports: #('1.13-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Added geometry package'.
		spec author: 'AlexandreBergel'.
		spec timestamp: '5/20/2016'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-AlexandreBergel.370';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1323';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-TudorGirba.34';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version131: spec [
	<version: '1.31' imports: #('1.13-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '5/20/2016'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.371';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1329';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-TudorGirba.34';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version132: spec [
	<version: '1.32' imports: #('1.13-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '06/02/2016'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.371';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1335';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.35';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version133: spec [
	<version: '1.33' imports: #('1.13-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '15/07/2016'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-PeterUhnak.386';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1378';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.37';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version134: spec [
	<version: '1.34' imports: #('1.13-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '25/07/2016'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-PeterUhnak.386';
			package: 'Roassal2' with: 'Roassal2-PeterUhnak.1388';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.38';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version135: spec [
	<version: '1.35' imports: #('1.13-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '05/08/2016'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.388';
			package: 'Roassal2' with: 'Roassal2-akevalion.1402';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-StefanReichhart.42';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version136: spec [
	<version: '1.36' imports: #('1.13-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '29/08/2016'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.390';
			package: 'Roassal2' with: 'Roassal2-akevalion.1417';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-StefanReichhart.43';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version137: spec [
	<version: '1.37' imports: #('1.13-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Update of Kendrick'.
		spec author: 'AlexandreBergel'.
		spec timestamp: '29/08/2016'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.390';
			package: 'Roassal2' with: 'Roassal2-akevalion.1418';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-StefanReichhart.43';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version138: spec [
	<version: '1.38' imports: #('1.13-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Solved an important bug in Grapher'.
		spec author: 'AlexandreBergel'.
		spec timestamp: '01/09/2016'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.390';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1425';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-StefanReichhart.43';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version139: spec [
	<version: '1.39' imports: #('1.13-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '28/11/2016'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.399';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1471';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.44';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version13: spec [
	<version: '1.3' imports: #('1.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.3'.
		spec author: 'AndreiChis'.
		spec 
			package: 'Trachel' with: 'Trachel-akevalion.240';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.604';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.5'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version140: spec [
	<version: '1.40' imports: #('1.15-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '02/02/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-AlexandreBergel.403';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1511';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.46';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version141: spec [
	<version: '1.41' imports: #('1.15-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '02/21/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-PeterUhnak.406';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1531';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-akevalion.47';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version142: spec [
	<version: '1.42' imports: #('1.15-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '03/15/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.407';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1542';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-akevalion.48';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version143: spec [
	<version: '1.43' imports: #('1.15-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '03/27/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.409';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1561';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-akevalion.48';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version144: spec [
	<version: '1.44' imports: #('1.15-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '03/30/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.409';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1568';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-akevalion.48';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version145: spec [
	<version: '1.45' imports: #('1.17-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '04/07/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.409';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1578';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-akevalion.48';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version146: spec [
	<version: '1.46' imports: #('1.17-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '04/18/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-AlexandreBergel.410';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1598';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.55';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version147: spec [
	<version: '1.47' imports: #('1.17-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '05/04/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-AlexandreBergel.413';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1622';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.55';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version148: spec [
	<version: '1.48' imports: #('1.17-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '05/15/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-AlexandreBergel.415';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1638';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.56';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version149: spec [
	<version: '1.49' imports: #('1.17-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '07/09/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.421';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1672';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.56';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version14: spec [
	<version: '1.4' imports: #('1.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.4'.
		spec author: 'AndreiChis'.
		spec 
			package: 'Trachel' with: 'Trachel-akevalion.251';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.640';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.5'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version150: spec [
	<version: '1.50' imports: #('1.17-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '09/26/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-AliakseiSyrel.16';
			package: 'Trachel' with: 'Trachel-akevalion.421';
			package: 'Roassal2' with: 'Roassal2-SergeStinckwich.1694';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AlexandreBergel.57';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version151: spec [
	<version: '1.52' imports: #('1.18-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '10/16/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-PeterUhnak.17';
			package: 'Trachel' with: 'Trachel-akevalion.422';
			package: 'Roassal2' with: 'Roassal2-akevalion.1702';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AndreiChis.61';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version152: spec [
	<version: '1.5.2' imports: #('1.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.5.2'.
		spec author: 'AlexandreBergel'.
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.265';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.782';
			package: 'Roassal2Spec' with: 'Roassal2Spec-johanfabry.6'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version153: spec [
	<version: '1.53' imports: #('1.19-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '10/16/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-PeterUhnak.17';
			package: 'Trachel' with: 'Trachel-akevalion.425';
			package: 'Roassal2' with: 'Roassal2-akevalion.1718';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.13';
			package: 'Roassal2GT' with: 'Roassal2GT-AndreiChis.61';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version154: spec [
	<version: '1.54' imports: #('1.19-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '11/25/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-PeterUhnak.17';
			package: 'Trachel' with: 'Trachel-akevalion.425';
			package: 'Roassal2' with: 'Roassal2-akevalion.1718';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.14';
			package: 'Roassal2GT' with: 'Roassal2GT-AndreiChis.61';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version155: spec [
	<version: '1.55' imports: #('1.19-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '11/25/2017'.
		
		spec 
			package: 'Athens-SVG' with: 'Athens-SVG-PeterUhnak.17';
			package: 'Trachel' with: 'Trachel-akevalion.425';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1721';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.14';
			package: 'Roassal2GT' with: 'Roassal2GT-AndreiChis.61';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version156: spec [
	<version: '1.56' imports: #('1.20-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '02/22/2018'.
		
		spec 
			package: 'WebBrowser-Core' with: 'WebBrowser-Core-TorstenBergmann.6';
			package: 'Athens-SVG' with: 'Athens-SVG-PeterUhnak.17';
			package: 'Trachel' with: 'Trachel-akevalion.428';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1737';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.14';
			package: 'Roassal2GT' with: 'Roassal2GT-AndreiChis.61';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version157: spec [
	<version: '1.57' imports: #('1.20-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '04/12/2018'.
		
		spec 
			package: 'WebBrowser-Core' with: 'WebBrowser-Core-TorstenBergmann.6';
			package: 'Athens-SVG' with: 'Athens-SVG-PeterUhnak.17';
			package: 'Trachel' with: 'Trachel-akevalion.428';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1758';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.14';
			package: 'Roassal2GT' with: 'Roassal2GT-AndreiChis.61';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version158: spec [
	<version: '1.58' imports: #('1.20-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '05/22/2018'.
		
		spec 
			package: 'WebBrowser-Core' with: 'WebBrowser-Core-TorstenBergmann.6';
			package: 'Athens-SVG' with: 'Athens-SVG-PeterUhnak.17';
			package: 'Trachel' with: 'Trachel-AlexandreBergel.429';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1774';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.14';
			package: 'Roassal2GT' with: 'Roassal2GT-AndreiChis.61';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version159: spec [
	<version: '1.59' imports: #('1.20-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '06/04/2018'.
		
		spec 
			package: 'WebBrowser-Core' with: 'WebBrowser-Core-TorstenBergmann.6';
			package: 'Athens-SVG' with: 'Athens-SVG-PeterUhnak.17';
			package: 'Trachel' with: 'Trachel-akevalion.430';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1778';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.14';
			package: 'Roassal2GT' with: 'Roassal2GT-AndreiChis.61';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version15: spec [
	<version: '1.5' imports: #('1.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.5'.
		spec author: 'AndreiChis'.
		spec 
			package: 'Trachel' with: 'Trachel-akevalion.251';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.647';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.5'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version160: spec [
	<version: '1.60' imports: #('1.20-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '06/10/2018'.
		
		spec 
			package: 'WebBrowser-Core' with: 'WebBrowser-Core-TorstenBergmann.6';
			package: 'Athens-SVG' with: 'Athens-SVG-PeterUhnak.17';
			package: 'Trachel' with: 'Trachel-akevalion.430';
			package: 'Roassal2' with: 'Roassal2-akevalion.1780';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.14';
			package: 'Roassal2GT' with: 'Roassal2GT-AndreiChis.61';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version161: spec [
	<version: '1.61' imports: #('1.20-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '06/20/2018'.
		
		spec 
			package: 'WebBrowser-Core' with: 'WebBrowser-Core-TorstenBergmann.6';
			package: 'Athens-SVG' with: 'Athens-SVG-PeterUhnak.17';
			package: 'Trachel' with: 'Trachel-akevalion.430';
			package: 'Roassal2' with: 'Roassal2-akevalion.1782';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.15';
			package: 'Roassal2GT' with: 'Roassal2GT-AndreiChis.61';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #versions }
ConfigurationOfRoassal2 >> version162: spec [
	<version: '1.62' imports: #('1.20-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'AlexandreBergel'.
		spec timestamp: '07/30/2018'.
		
		spec 
			package: 'WebBrowser-Core' with: 'WebBrowser-Core-TorstenBergmann.6';
			package: 'Athens-SVG' with: 'Athens-SVG-PeterUhnak.17';
			package: 'Trachel' with: 'Trachel-AlexandreBergel.431';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.1800';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.15';
			package: 'Roassal2GT' with: 'Roassal2GT-AndreiChis.61';
			package: 'Roassal2-Rules' with: 'Roassal2-Rules-YuriyTymchuk.2'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version16: spec [
	<version: '1.6' imports: #('1.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.6'.
		spec author: 'TudorGirba'.
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.252';
			package: 'Roassal2' with: 'Roassal2-PierreChanson.686';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.5'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version17: spec [
	<version: '1.7' imports: #('1.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.7'.
		spec author: 'AndreiChis'.
		spec 
			package: 'Trachel' with: 'Trachel-akevalion.253';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.704';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.5'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version18: spec [
	<version: '1.8' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.8'.
		spec author: 'Alexandre'.
		spec 
			package: 'Trachel' with: 'Trachel-akevalion.253';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.705';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.5'. ].

]

{ #category : #'old-versions' }
ConfigurationOfRoassal2 >> version19: spec [
	<version: '1.9' imports: #('1.4-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.9'.
		spec author: 'Alexandre'.
		spec 
			package: 'Trachel' with: 'Trachel-AlexandreBergel.255';
			package: 'Roassal2' with: 'Roassal2-AlexandreBergel.718';
			package: 'Roassal2Spec' with: 'Roassal2Spec-AlexandreBergel.5'. ].

]

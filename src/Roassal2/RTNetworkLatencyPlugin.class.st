Class {
	#name : #RTNetworkLatencyPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-PluginsAndScripts'
}

{ #category : #'as yet unclassified' }
RTNetworkLatencyPlugin >> description [
	^ 'NetworkLatency shows the network latency of 145 cities, from 70 countries'
]

{ #category : #'as yet unclassified' }
RTNetworkLatencyPlugin >> execute [
	Gofer new
		smalltalkhubUser: 'merino'
			project: 'NetworkLatency';
		package: 'ConfigurationOfNetworkLatency';
		load.
	(Smalltalk at: #ConfigurationOfNetworkLatency)
		loadDefault.
		
	(Smalltalk at: #NLVisualise) new open
]

{ #category : #'as yet unclassified' }
RTNetworkLatencyPlugin >> label [
	^ 'Network Latency application'
]

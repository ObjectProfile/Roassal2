Class {
	#name : #RTVoronojPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-PluginsAndScripts'
}

{ #category : #hooks }
RTVoronojPlugin >> description [
	^ 'A Voronoi diagram is a partitioning of a plane into regions based on distance 
to points in a specific subset of the plane.'
]

{ #category : #hooks }
RTVoronojPlugin >> execute [

	Gofer new
	  smalltalkhubUser: 'NataliaTymchuk'
	  project: 'VoronoiDiagram';
	  configuration;
	  load.
	#ConfigurationOfVoronoiDiagram asClass loadDevelopment
]

{ #category : #hooks }
RTVoronojPlugin >> label [
	^ 'Voronoj diagrams'
]

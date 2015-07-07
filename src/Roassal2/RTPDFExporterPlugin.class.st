Class {
	#name : #RTPDFExporterPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-Plugins'
}

{ #category : #'as yet unclassified' }
RTPDFExporterPlugin >> description [
	^ 'When you open a visualization, you can export it by clicking on the "..." icon. By loading this plugin, you will be able to export the visualization as a PDF file.'
]

{ #category : #'as yet unclassified' }
RTPDFExporterPlugin >> execute [
	Gofer new 
		smalltalkhubUser: 'azazael' project: 'RTPDFExporter';
		package: 'ConfigurationOfRTPDFExporter'; load.
	(Smalltalk at: #ConfigurationOfRTPDFExporter) loadDevelopment
]

{ #category : #'as yet unclassified' }
RTPDFExporterPlugin >> label [
	^ 'PDF Exporter'
]

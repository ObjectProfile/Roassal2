Class {
	#name : #RTOpenUrlPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-Plugins'
}

{ #category : #hooks }
RTOpenUrlPlugin >> description [
	^ 
'When you open a visualization, you can export it by clicking on the "..." icon. 
One of the available exporter is HTML. Without this plugin, if you exporter your 
visualization as HTML _does not_ open the page within the web browser (you need 
to do it automatically). After having loaded this plugin, the web browser will 
automatically open the exporter HTML file.'
]

{ #category : #hooks }
RTOpenUrlPlugin >> execute [
	Gofer it
		smalltalkhubUser: 'SeanDeNigris' project: 'SeansPlayground';
		package: 'NewExternalWebBrowser';
		load.
]

{ #category : #hooks }
RTOpenUrlPlugin >> label [
	^ 'Automatic open in web browser'
]

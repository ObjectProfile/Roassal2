Class {
	#name : #RTKendrickPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-PluginsAndScripts'
}

{ #category : #hooks }
RTKendrickPlugin >> description [
	^ 
'Kendrick is a modeling language and simulation platform, with an emphasis
on Epidemiological models. Kendrick has been used to model propagation of 
diseases, and in particular Ebola.

This plugin may cause problem when loaded directly in Pharo. 
We recommand to use the Moose distribution of Pharo.'
]

{ #category : #hooks }
RTKendrickPlugin >> execute [
	Gofer new
	   url: 'http://smalltalkhub.com/mc/SergeStinckwich/SciSmalltalk/main/';
	   configurationOf:'SciSmalltalk';
	   loadVersion: '0.28-baseline'.
	
	Gofer new
	   url: 'http://ss3.gemstone.com/ss/STON';
	   configurationOf:'Ston';
	   loadStable.
	
	Gofer new
	   url: 'http://smalltalkhub.com/mc/UMMISCO/Kendrick/main';
	   configurationOf:'Kendrick';
	   loadVersion:'0.35'
]

{ #category : #hooks }
RTKendrickPlugin >> label [
	^ 'Load Kendrick'
]

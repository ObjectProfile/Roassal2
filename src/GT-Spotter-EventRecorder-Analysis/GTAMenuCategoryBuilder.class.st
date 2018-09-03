Class {
	#name : #GTAMenuCategoryBuilder,
	#superclass : #Object,
	#instVars : [
		'menuBuilder',
		'categoryBuilder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Category'
}

{ #category : #building }
GTAMenuCategoryBuilder >> build [
	self renderIn: categoryBuilder view.
]

{ #category : #accessing }
GTAMenuCategoryBuilder >> categoryBuilder [
	^ categoryBuilder
]

{ #category : #accessing }
GTAMenuCategoryBuilder >> categoryBuilder: anObject [
	categoryBuilder := anObject
]

{ #category : #'event handling' }
GTAMenuCategoryBuilder >> displayActOnAndCloseActions [
	self categoryBuilder 
		initiliazeSessionsPerActOnOrCloseActionCategories;
		rebuild
]

{ #category : #'event handling' }
GTAMenuCategoryBuilder >> displayCategorySelections [
	self categoryBuilder 
		initiliazeSessionsPerSelectedCategories;
		rebuild
]

{ #category : #initialization }
GTAMenuCategoryBuilder >> initialize [
	super initialize.
	menuBuilder := RTMenuBuilder new.
]

{ #category : #hooks }
GTAMenuCategoryBuilder >> renderIn: aView [
	menuBuilder view: aView.
	menuBuilder menu: 'User Activity' submenu: 'Category Selections' callback: [ self displayCategorySelections ].
	menuBuilder menu: 'User Activity' submenu: 'Act-On and Close Actions' callback: [ self displayActOnAndCloseActions ].
	
]

"
A ROExploraBuilderExample is xxxxxxxxx.

"
Class {
	#name : #RTExploraBuilderExample,
	#superclass : #Object,
	#category : #'Roassal2-Builder-Explora'
}

{ #category : #basic }
RTExploraBuilderExample >> exploreCircularList [
	"
	self new exploreCircularList
	"
	| builder lst |
	
	" A circular linked list "
	lst := LinkedList new.
	lst add: 1; add: 2; add: 3; add: 4.
	lst lastLink nextLink: (lst firstLink).
	
	builder := RTExploraBuilder new.
	builder layout: RTCircleLayout new;
		withPopup;
		node: lst firstLink;
		onClickExplore: [ :link | {link nextLink} ];
		open.
]

{ #category : #basic }
RTExploraBuilderExample >> exploreClassHierarchy [
	"
	self new exploreClassHierarchy
	"
	| builder |
	builder := RTExploraBuilder new.
	builder shape circle
		size: 20;
		color: (Color blue alpha: 0.5);
		if: [ :cls | cls subclasses isEmpty ] fillColor: (Color red alpha: 0.5);
		if: [ :cls | cls == ProtoObject ] fillColor: (Color green alpha: 0.5).
	builder
		onRightClickExplore: [ :cls | {cls superclass}] edges: #To;
		onLeftClickExplore: [ :cls | cls subclasses ] edges: #From;
		withPopup;
		dragChildren;
		node: String;
		open.
]

{ #category : #basic }
RTExploraBuilderExample >> exploreClassHierarchy2 [
	"
	self new exploreClassHierarchy2
	"
	| builder |
	builder := RTExploraBuilder new.
	builder shape circle
		size: [ :cls | cls numberOfMethods / 3 + 10];
		color: (Color blue alpha: 0.5);
		if: [ :cls | cls subclasses isEmpty ] fillColor: (Color red alpha: 0.5);
		if: [ :cls | '*Array*' match: cls name] fillColor: (Color green alpha: 0.5).
	builder
		layout: [RTClusterLayout new horizontalGap: 80];
		onClickExplore: [ :cls | cls subclasses ];
		withPopup;
		dragChildren;
		node: Collection;
		open.
]

{ #category : #basic }
RTExploraBuilderExample >> exploreClassHierarchy3 [
	"
	self new exploreClassHierarchy3
	"
	| builder |
	builder := RTExploraBuilder new.
	builder shape rectangle
		width: [ :cls | cls numberOfVariables * 10 max: 5 ];
		height: [ :cls | cls numberOfMethods / 2 max: 5];
		color: (Color blue alpha: 0.5);
		if: [ :cls | cls subclasses notEmpty ] borderColor: (Color red alpha: 0.5).
		
	builder
		layout: [ RTClusterLayout new horizontalGap: 80 ];
		onClickExplore: [ :cls | cls subclasses ];
		withPopup;
		dragChildren;
		node: Collection.
	builder view canvas color: Color white.
	builder open.
]

{ #category : #basic }
RTExploraBuilderExample >> exploreFileSystem [
	"
	self new exploreFileSystem
	"
	| builder |
	builder := RTExploraBuilder new.
	builder shape circle size: 10;
		if: [ :x | x isFile ] fillColor: (Color yellow alpha: 0.8);
		if: [ :x | x isDirectory ] fillColor: (Color brown alpha: 0.8).
	builder
		layout: (RTTreeLayout new);
		onLeftClickExplore: [ :elem | (elem isFile) ifTrue: [ #() ] ifFalse: [elem children] ];
		onRightClickExplore: [ :elem | {elem parent} ];
		withPopup: [ :file | file basename ];
		dragChildren;
		node: FileSystem disk workingDirectory;
		open.
]

{ #category : #basic }
RTExploraBuilderExample >> exploreNumbers [
	"
	self new exploreNumbers
	"
	| builder |
	builder := RTExploraBuilder new.
	builder shape circle size: 30;
		if: [:n | (n < 100)] fillColor: (Color green alpha: 0.5);
		if: [:n | (n > 100) and: (n < 500)] fillColor: (Color yellow alpha: 0.5);
		if: [:n | (n >= 500)] fillColor: (Color red alpha: 0.5);
		withText.
	builder
		layout: [RTClusterLayout new verticalGap: 40];
		withPopup;
		dragChildren;
		node: 1;
		onClickExplore: [ :aNumber | aNumber*5 to: (aNumber*5 + 5) ];
		open
]

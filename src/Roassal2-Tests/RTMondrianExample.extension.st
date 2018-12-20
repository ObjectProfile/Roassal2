Extension { #name : #RTMondrianExample }

{ #category : #'*Roassal2-Tests' }
RTMondrianExample >> exampleBezier [
	<gtExample> 
	<noTest>
| classes b |
(TRPlatform current dialogConfirm: 'This example takes a long time to load, execute?')
	ifFalse: [ ^ self ].
classes := RTObject withAllSubclasses, RTTest withAllSubclasses.

b := RTMondrian new.
b shape circle.
b nodes: classes.
b edges connectFrom: #superclass.

b shape bezierLineFollowing: #superclass;
	color: (Color blue alpha: 0.2).
b edges 
	notUseInLayout;
	connectToAll: #dependentClasses.
b normalizer
	normalizeSize: #numberOfMethods using: #sqrt;
	normalizeColor: #numberOfMethods using: (Array with: Color green with: Color red) using: #sqrt.
b layout cluster.
^ b
]

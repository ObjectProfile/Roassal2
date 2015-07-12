"
RTLineDecorationExample new installTitle: 'Cool' 
		code:
		'
	| v b1 b2 edges |
	b1 := (RTBox new
		size: 100;
		element)
		translateTo: 0 @ 0;
		@ RTDraggable.
	b2 := (RTBox new
		size: 100;
		element)
		translateTo: 400 @ 0;
		@ RTDraggable.
	edges := OrderedCollection new.
	edges add: ((RTArrowedLine new head: RTFilledDiamond asHead; color: Color black; width: 2; attachPoint: (RTRectangleAttachPoint new offset: 15)) edgeFrom: b1 to: b2).
	edges add: ((RTDecoratedLine new color: Color blue; width: 2; attachPoint: (RTRectangleAttachPoint new offset: 15)) edgeFrom: b1 to: b2).
	edges add: ((RTDecoratedLine new filledDiamondHead; color: Color green; width: 2; attachPoint: (RTRectangleAttachPoint new offset: 15)) edgeFrom: b1 to: b2).
	edges add: ((RTDecoratedLine new filledDiamondHead; emptyCircleTail; color: Color red; width: 2; attachPoint: (RTRectangleAttachPoint new offset: 15)) edgeFrom: b1 to: b2).


v := RTView new
	add: b1;
	add: b2;
	addAll: edges.
edges do: [ :each | each update ].
v
'
	
"
Class {
	#name : #RTLineDecorationExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #sources }
RTLineDecorationExample >> exampleCool [

	| v b1 b2 edges |
	b1 := (RTBox new
		size: 100;
		element)
		translateTo: 0 @ 0;
		@ RTDraggable.
	b2 := (RTBox new
		size: 100;
		element)
		translateTo: 400 @ 0;
		@ RTDraggable.
	edges := OrderedCollection new.
	edges add: ((RTArrowedLine new head: RTFilledDiamond asHead; color: Color black; width: 2; attachPoint: (RTRectangleAttachPoint new offset: 15)) edgeFrom: b1 to: b2).
	edges add: ((RTDecoratedLine new color: Color blue; width: 2; attachPoint: (RTRectangleAttachPoint new offset: 15)) edgeFrom: b1 to: b2).
	edges add: ((RTDecoratedLine new filledDiamondHead; color: Color green; width: 2; attachPoint: (RTRectangleAttachPoint new offset: 15)) edgeFrom: b1 to: b2).
	edges add: ((RTDecoratedLine new filledDiamondHead; emptyCircleTail; color: Color red; width: 2; attachPoint: (RTRectangleAttachPoint new offset: 15)) edgeFrom: b1 to: b2).


v := RTView new
	add: b1;
	add: b2;
	addAll: edges.
edges do: [ :each | each update ].
^ v

]

{ #category : #icons }
RTLineDecorationExample >> exampleCoolIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAByElEQVR4XuXau43CQBSGURdC
BdCZG4BgBSEZJUACvZgCCHmInBL4vQObbbDBConB5xtNAz72cEei6Xu/mmr8R+CD+PkgPoif
D+KD+PkgPoifD+KD+Pkgfj6ID+Lng/ggfj6ID+Lng/ggfj6Inw/ig/j5ID6Inw/ig/j5ID6I
nw/i54P4IH4+iA/i54P4IH4+iA/i54P4+SCVg5zP5/6VW+t0OuWVz88H8UGG0e12iw9SQdfr
NaPRKE3T9Ov1OtWDLJfLDHm3bfvEeOzJZJLD4eB/Ie9uv99nNpv5R5b/o/6PvVj01D4e/S+k
jikr/pRVx5SVMmWV1ZS1Kav+I2vgq02ZsvqfNc44h4s/Zb29Ll2+bu1nHFlZrZLdLrnfM0SM
lIthuRmmXEaSzQccWdlunxCZzzPEsarcDFNuhf1jZzzOpfaL4ePLeLxFQz6y0nXJdOpPWf7F
0AfxQXwQH8QH8UH+AMmL00Be/fz8f51Ulg/ig/j5ID6Inw/ig/j5ID6Inw/ig/j5IH4+iA/i
54P4IH4+iA/i54P4IH4+iJ8P4oP4+SA+iJ8P4oP4+SA+iJ8P4ueD+CB+PogP4ueD+CB+PogP
4ueD+P3uG69wVbQ1PZxEAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTLineDecorationExample >> exampleCoolWithJump [
	| v b1 b2 edges |
	b1 := (RTBox new
		size: 150;
		element)
		translateTo: 0 @ 0;
		@ RTDraggable.
	b2 := (RTBox new
		size: 150;
		element)
		translateTo: 400 @ 0;
		@ RTDraggable.
	edges := OrderedCollection new.
	edges add: ((RTArrowedLine new head: RTFilledDiamond asHead; color: Color black; width: 2; attachPoint: (RTShorterDistanceWithOffsetAttachPoint new offset: 15)) edgeFrom: b1 to: b2).
	edges add: ((RTDecoratedLine new color: Color blue; width: 2; attachPoint: (RTShorterDistanceWithOffsetAttachPoint new offset: 15)) edgeFrom: b1 to: b2).
	edges add: ((RTDecoratedLine new filledDiamondHead; color: Color green; width: 2; attachPoint: (RTShorterDistanceWithOffsetAttachPoint new offset: 15)) edgeFrom: b1 to: b2).
	edges add: ((RTDecoratedLine new filledDiamondHead; emptyCircleTail; color: Color red; width: 2; attachPoint: (RTShorterDistanceWithOffsetAttachPoint new offset: 15)) edgeFrom: b1 to: b2).
	v := RTView new
		add: b1;
		add: b2;
		addAll: edges.
	edges do: [ :each | each update ].
	^ v
]

{ #category : #icons }
RTLineDecorationExample >> exampleCoolWithJumpIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAByElEQVR4XuXbsXHCMBiGYQ/C
BLAZWYAiByUlG0ADu8AAlOA7eo/A58jJCgFsPa9OC/ixhf6Cpu/9xlTjPwIfxM8H8UH8fBAf
xM8H8UH8fBAfxM8H8fNBfBA/H8QH8fNBfBA/H8QH8fNB/HwQH8TPB/FB/HwQH8TPB/FB/HwQ
Px/EB/HzQXwQPx+kXpC2bftX71q63+959bPyQXwQH8QH8UF8EB/EB/FBfJAP1XVdfJAR9Hg8
MpvN0jRNv9/vUw3IdrvNFPdyufzFGPZiscj1evW/kE93uVyyWq38I8v/UX/h3mz6Kvbt5n8h
47hlxb9ljeOWlXLLKqsp61BWPUfWRNcy5ZbV/6155rm2/i3r451zznf3VdeRld0uOZ2S5zNT
wkgZDMtkmDKMJIeKjqwcj78QWa8zpWtVmQxTpsJ+2JnP09YyGA5fxvC2TfHIyvmc+IOhPxj6
ID6ID+KD+CA+iA/ig/ggPogP4oP4ICpI3lAtIO94Vv7/Q0aWD+KD+PkgPoifD+KD+PkgPoif
D+KD+Pkgfj6ID+Lng/ggfj6ID+Lng/ggfj6Inw/ig/j5ID6Inw/ig/j5ID6Inw/i54P4IH4+
iA/i94/9AObDevK8Tn8bAAAAAElFTkSuQmCC'
]

{ #category : #accessing }
RTLineDecorationExample >> label [
	^ 'Line decoration'
]

"
RTLegendBuilderExample new installTitle: 'OnDemand' 
		code:
		'
| l lb |
b := RTMondrian new.
b shape rectangle
	width: [ :c | c numberOfVariables * 5 ];
	height: #numberOfMethods.
b nodes: RTShape withAllSubclasses.
b edges connectFrom: #superclass.
b layout tree.
b normalizer
	normalizeColor: #numberOfLinesOfCode using: { Color black. Color red }.
b build.

lb := RTLegendBuilder new.
lb onDemand.
lb view: b view.

lb addText: ''System complexity view''.
lb addRectanglePolymetricWidth: ''number of methods'' height: ''Line of code'' box: ''a Pharo class''.
lb build.

b view'
	
"
Class {
	#name : #RTLegendBuilderExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Legend'
}

{ #category : #sources }
RTLegendBuilderExample >> exampleOnDemand [

| l lb |
b := RTMondrian new.
b shape rectangle
	width: [ :c | c numberOfVariables * 5 ];
	height: #numberOfMethods.
b nodes: RTShape withAllSubclasses.
b edges connectFrom: #superclass.
b layout tree.
b normalizer
	normalizeColor: #numberOfLinesOfCode using: { Color black. Color red }.
b build.

lb := RTLegendBuilder new.
lb onDemand.
lb view: b view.

lb addText: 'System complexity view'.
lb addRectanglePolymetricWidth: 'number of methods' height: 'Line of code' box: 'a Pharo class'.
lb build.

b view
]

{ #category : #icons }
RTLegendBuilderExample >> exampleOnDemandIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEjElEQVR4XuXbS08bVxjGcZM2
ajf9Cv0qkfolknaRSFUSKUFQKUQlbQQ2pe2qXfIB0h0LWLDLAuwiIYFEhLjf7/eruN953fOc
cKyJC8GuYmr4P9LRzJiZsTm/mTnvMSKWTvNTTInZu3dmb98avyuKBWRxkY9RVCC9vXyQYgLh
dwEfhB8+CB+EHz4IH4QfPggfhB8+CB+EHz4IP3wQPgg/fBA+CD98ED4IP3wQPgg/fBB++CB8
EH6YIOZydnZmfJAiSbKlxb65d48Pwgfhg/BB+CB8kJyzs7Njvb291uJA/nrzxjo7O214ePhG
D/A3AuTo6Mh3/NbWlk1OTtrs7KwtLy/b4uKiHR8fW8BZXV21iYkJa21tta6uLquvr7dkMmlT
U1M2ODhoJycnxgfJs3wdGxuz+fl5W1lZ8Z0Yvdr18+npaY9y0bGKjtO2sASn6HzCamhosI2N
DWtqarLR0VFbW1vz0ALHg6jDRkZGLDx2Dg8PL+2UmZkZ37m5PIpOT09taWkps5+OCcDhNd1d
an19ff5O2t7e9usDAwMeXHdiT0+PHRwc2K0ESVRXm9q39+9bWWmp5XPc08ePLZdzh6YB/udX
rzLrYb8at/39w4empVr0+NJnz+yHsjJ/jI6tq6uz5uZm+9Ntq5U/emQ/PX+e2VYr1Dh1LSCf
x2IftFxz1+1794r9s8/9SzyeOS7a8V+47Wi77Hg1jTsqFL6OxdTSFzXdiXyQawIJ4YN8ApBU
MulR1FKRR9ZlICGpVOpfHcwHycp3Dx5cOYbkc25VVhqws1/XQN7e3s4BUdra2qyxsdGXoVft
qwqou7vb5ubmrL+/31c/n+IzaI6iz5H9uiowQakkRoCotOzo6PAlrsrJy+p+/ZLj4+N+fqBo
qf1V9i4sLPhS9b9+hnBn6G4QcvTuCOt6v1sPok7UvECPC3XE5uamv/Kzr0Z1+v7+vq2vr1u4
mrXc3d31s/G9vT2PFF7PN2FuEjoyzEtirnPj8bhVuwLArX9Qzt4qEN0Fmh1Hv1sKd4Ymarpi
NTlUnj55Yn+7Abjm9Wv7zXVMqys7Kysr/Tzix5cvM3OLcO7y8vKcOyMM4l+WlPil3k8ItbW1
6YQb+D+WWwVS4j60IHTVVVdVWSKRsLQGXdfUEWqfnXeQW7dfHcRXblvtd7ddUVFhNW4fDdQ1
56Vs9Nz5goSWyxiGGNTfv9t7kIuSDaLHmkpY3RlaRtMSKWcLGT5IFshFA234ZpcPUmAQZWho
KPNLBhBVWdF99G1wdDzigxQQJDppq3jxwq+rusqeS2gZLV35IAUCif6dQ4O++5LPtxANyHdU
prrH253z4oAPUkCQ7PBB/seok1X+fmyf8xL52j4TGqQYwwfhg/BB+CB8ED4IH4QPwgfhg/BB
+CB8ED4IH4QPwg8fhA/CB+GD8EH4IHwQPggfhA/CB+GD8EH44YPciOi/bf+oqrqw3ej/wuWH
D8IH4YcPwgfhhw/CB+GHD8IPH4QPwg8fhA/CDx+ED8IPH4QPwg8fhB8+CB+EHz4IH4QfPggf
hB8+CB+EHz4IPz7/AM9D0yGxSRIjAAAAAElFTkSuQmCC'
]

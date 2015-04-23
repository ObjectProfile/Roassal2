"
RTBoxPlotExample new installTitle: 'BoxPlot1' 
		code:
		'
| b createList r ds |
r := Random new.
createList := [ :size :d1 :d2 | (1 to: size) collect: [ :i | d1 + (r next * (d2-d1))] ].

b := RTGrapher new.
ds := RTBoxPlotDataSet new.
	ds points: (createList value: 20 value: 0 value: 20).
	b add: ds.
b build.
b view.
 '
"
Class {
	#name : #RTBoxPlotExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-BoxPlot'
}

{ #category : #sources }
RTBoxPlotExample >> exampleBoxPlot1 [

| b createList r ds |
r := Random new.
createList := [ :size :d1 :d2 | (1 to: size) collect: [ :i | d1 + (r next * (d2-d1))] ].

b := RTGrapher new.
b extent: 70@300.
ds := RTBoxPlotDataSet new.
	ds points: (createList value: 20 value: 0 value: 20).
	b add: ds.
b axisX noLabel; noTick.
b build.
^ b view.
 
]

{ #category : #icons }
RTBoxPlotExample >> exampleBoxPlot1Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACjUlEQVR4XuXcvWrCUBiAYW8u
gxfiLTg4+DO4eAfOjg6OguLPpOLipCgILiq6KCIIKn6pX6g2hTRTck7s+0LQ1uE0eYjhI9aU
6/JLUin+IeCD8OOD8EH48UH4IPz4IHwQfnwQPgg/Pgg/PggfhB8fhA/Cjw/CB+HHB+GD8OOD
8OOD8EH48UH4IPz4IHwQfp8Bst1u5X6/e5v+vNlshH9ILYJUq1VZLBbettvtZL/fv0GOx6M7
n8+9R34GQPTgp9NpabVa3jYcDiWfz/86Q1arFf+MSdI1hA/CB+GD8EF+Wi6Xwgfhg/BB+CB8
ED7IR4Lcbjc5nU7eFjSp80EMg4zHY6nVatLv9wMn9dFohJrUrYNkMhnpdDr8Sf3Z4/GQ9Xot
+si/hiSgw+Egz/31HvkgfBA+CB+ED8IH4YPwQfgg/wpEJ/Wwe+p8EAuTetg9ddKknggQndT5
99T51xA+CB+ED8IH4YPwQfggfBA+CB/EJMj1en0Pg0GffOeDGAap1+veUPg9mYv/j+FP6hZA
ZrOZ5HI5eR54KRQKor1e0+d6hvh/xwfhX0P4IHwQPkhi4n+UlA/CB+GD8EH4IB8NEjap661d
GwfmcrlYWXc6ndoFKRaLUiqVAid1fd5ut91msym9Xs81uTUaDdf0mroNBgPXKki325Vyufzn
pK7f9GBjUtd1bZwhUawb2zUk7K0szl7r6r8GmFz3fD5Hsr+xgIS9lcWZf91sNmsUpFKpRLK/
sYCEvZXFmX9dhdHbAybWnUwm4jhOJPvL/3qmhMUH4YPw44PwQfjxQfgg/PggfBB+fBA+CD8+
CD8+CB+EHx+ED8KPD8IH4ccH4YPw44Pw44PwQfjxQfgg/PggfBB+5voCUYQRoBEyxGMAAAAA
SUVORK5CYII='
]

{ #category : #sources }
RTBoxPlotExample >> exampleBoxPlot2 [

| b createList r |
r := Random new.
createList := [ :size :d1 :d2 | (1 to: size) collect: [ :i | d1 + (r next * (d2-d1))] ].

b := RTGrapher new.
(1 to: 10) do: [ :i | | ds |
	ds := RTBoxPlotDataSet new.
	ds points: (createList value: 20 value: 0 value: 20).
	b add: ds.].
b build.
^ b view.
 
]

{ #category : #icons }
RTBoxPlotExample >> exampleBoxPlot2Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADyklEQVR4XuXcTUvrQBSHcT+1
W19Av4O4tCCCC0FcWFHRTe2i+4qvSK2Kb2CrCLYn9gQK3jozt2kzmYnPHwa8uaHmnl8nyWQm
dyZJ+IkpM/wS8EH44YPwQfjhg/BB+OGD8EH44YPwQfjhg/DDB+GD8MMH4YPwwwfhg/DDB+GD
8MMH4YcPwgfhhw/CB+GHD8IH4Sd+kLe3N+n3+3J7eyv656+vL9HGL2nAHrKysiKvr6/y8vIi
p6enaRv+3dXVVdJsNvkVLgpkfn5etra2ZG5uTmq1mlSr1bT93GeAkkuPUfTRbZ1OR25ubrz1
SO35w94/mouLCynlNcQEonhHR0cy7edoLi8vM31O1v1thTdtPzw8lI2NDdGUCkRzfX39a7ue
9mwFywJSr9dFW9EgmvPzcyldD7GBuPY3bddv4t3dXabC80E8guhNg7ZpQT4/P+X+/l74IJGA
TFL4PwXiKqQNxHS3wwcJBGLbPxTIx8eHtFqtX3dT+tl6PMHvsvTgbCP1vwhiK3w0ILOzs+kB
mEbqJycnCR+kIJDBQCjZ39+XhYUFOT4+HnukzgcpyTXk+fnZOK7IC6Tb7crw9MoHmaLAk24f
LYxtOx8kMpD393fjXdPwUc64heeD5ASStcB8kMhAdnZ2ZNASnZzjg4yxfX19PW38HsI/ZcUB
4ppT9wky7Al8kJG45tSzjNT5PSSnkXrWOXU+SGTXEL3nN42Y+SCBQDSmCaq8QHS9mGk1Ch8k
EIjtWRYfJDKQRqORtnELqbN/g2dZfBB+D+GD8EFMIIPxTJLH3VdWEE0ej9mjAHl8fBSd9Nef
Hx4eZBoQ1/55LAPStVfafIHoBJvWICjI8vJy+o/Uhdc6lTtaMNNIPRSIa3teE1HBlwGtrq6m
o/ODgwNZWlr652D0gMu8UM5VeNtxolcu6jXHtgTUNwh/KWnG1xHyALFN4fJBAoFMsp0PwgeJ
B0RPKdqyFN62Px7E9M7gJD3Eliwv5ugd4ubmpky7XqvUIK7CFA1iS7vdFm1ZelpwkJ+j89GR
eq/Xk7OzMykaVkfMlUql8PflB0+SZXd3N+xIfThCN43U9Vu6trYmOtVbZNvb25Pt7e0gv9f2
GnVhIIuLi+nKd9NIXd/de3p6KvybWvbf6+Ua4jqV+cz/Hnb6TF7/xYgXENepzGdcDzt9x7Yc
KgoQ16nMZ1wPO31lnOVQ0dz28sMH4YPwwwfhg/DDB+GD8MMH4YcPwgfhhw/CB+GHD8IH4YcP
wgfhhw/CDx+ED8IPH4QPwg8fhA/CDx+ED8IPH4QfPkjM+Qbkn0SlmLU0PQAAAABJRU5ErkJg
gg=='
]

{ #category : #sources }
RTBoxPlotExample >> exampleBoxPlot3 [

| b createList r d today |
r := Random new.
createList := [ :size :d1 :d2 | (1 to: size) collect: [ :i | d1 + (r next * (d2-d1))] ].

b := RTGrapher new.
today := d := Date today.
(1 to: 10) do: [ :i | | ds |
	ds := RTBoxPlotDataSet new.
	ds points: (createList value: 20 value: 0 value: 20).
	ds model: d.
	ds x: [ :date| date julianDayNumber - today julianDayNumber + 1 ].
	b add: ds.
	d := d next.].
b build.
^ b view.
 
]

{ #category : #icons }
RTBoxPlotExample >> exampleBoxPlot3Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADzUlEQVR4XuXcS0vzQBSHcT91
t7WCfgcpuunCRQULBRdKFQRpsbpW8V5b8C5oEUV7Yk94C77pJGY00yQ+f5iF05Km8zOXkxmd
8jx+spQp/hDwQfjhg/BB+OGD8EH44YPwQfjhg/BB+OGD8MMH4YPwwwfhg/DDB+GD8MMH4YPw
wwfhhw/CB+GHD8IH4YcPwgfhJ/sgT09PMhgMpNfrif78/v4u2vhDmuIRMj8/L4+Pj/Lw8CCH
h4d+G712dnbmHRwcZH4Anp+fRVvuQaanp6VWq0mxWJRmsylra2t++/qeIYrxiypisG9jY0Ma
jUYqA3NyciKIa0gYyPn5udi8P6yfDwIDSQMKA/L29ibagv2np6ei1zsZJgtQqCNEB58PEsj9
/b1cXl7GHvhOpyPa8gCi3y13IPrltQVzc3Mj2uK+P4sgx8fHfwfEtp8PEpJutxtaqacFYhp4
DEihUPB3wlSpt1otzxXI3t6ebG9vCx/kXzY3Nz2trEulkmxtbcWu1JM8QmwGnn8NgYFEbYcP
4hDk6upKtAXfjwfR2iSswDQN/Gg7NgNpcyTkFmRpaclvkz5y+CCOj5Dv+oMDYwuSVD8fhA/C
B8kUSNScOh8kBZCoOXWXlXrWQLQ4HjZPF36kWqnbzqnnHWR4hyh6lxgceP41hH/K4oPwQX7Q
Pyo8+SAxQTSjORT+EZIRENMzqLRAwvaHD5IiiOmZVbValWHjg2QFJJdHyO3trby8vPg7cH19
Lb8B0dX0puU+tiDDQtUfHEP9YLzY/ymQubk5f7JGF17rVG5wwEyVehhIGKCiX1xcWC0Psnn8
bgvS7/f9X5xgv96omPonClIul/3qXFeuz87O/rcjumO2KxdNq+Jtb5+TAtEB1gV9NlO7uZxT
jwJJop5JCuQn/XwQPggfhA+SEIjefZlWi/BBIi7etttJYhmQ7cBr3+7urhE2tyBJbcc0wO12
e2xeJkmQqPBBQgY4LH8e5Gt1HqzUPz4+5Ojo6Nc7qDXO+vr62HZ0lnJ1dXWsXz/39fU1NqBu
f3l5eewUpPuur8XdT/3c/f39dEFGFbqpUtcvX6lURKd6J9kUr16vj33uysqKt7i46Gx/FhYW
ZGdnJ12QmZkZf+W7qVLX39K7u7uJ/xVr3j/XyTUk6lTmMt897HSZpP7FiBOQqFOZy0Q97HSd
sOVQmQCJOpW5TNTDTleJsxwqM7e9/PBB+CD88EH4IPzwQfgg/PBB+OGD8EH44YPwQfjhg/BB
+OGD8EH44YPwwwfhg/DDB+GD8MMH4YPwwwfhg/DDB+GHD5LlfAI06kS7B0UeLAAAAABJRU5E
rkJggg=='
]

{ #category : #sources }
RTBoxPlotExample >> exampleBoxPlot4 [

| b createList r d today |
r := Random new.
createList := [ :size :d1 :d2 | (1 to: size) collect: [ :i | d1 + (r next * (d2-d1))] ].

b := RTGrapher new.
today := d := Date today.
(1 to: 10) do: [ :i | | ds |
	ds := RTBoxPlotDataSet new.
	ds points: (createList value: 20 value: 0 value: 20).
	ds model: d.
	ds x: [ :date| date julianDayNumber - today julianDayNumber + 1 ].
	b add: ds.
	d := d next.].
b axisX labelRotation: -30;
	labelConversion: [ :v | Date julianDayNumber: v + today julianDayNumber -1];
	numberOfLabels: 10.
b build.
^ b view.
 
]

{ #category : #icons }
RTBoxPlotExample >> exampleBoxPlot4Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAFJ0lEQVR4XuWcZ0v8TBTF/59Z
v4D6QkRQQRRfKHZZRBHrC8Xee++KvWPv9e6zJxCJMVk2PtnMZM+FZfUYk8n9JZm5d27mXzTK
bzrZP34X8APhN34g/ED4jR8IPxB+4wfCD4Tf+IHwA+E3fiD8xg+EHwi/8QPhB8Jv/ED4gfAb
PxB+IPzGD4Tf+IHwA+E3tUByc3NlZGRERkdHBb8XFRUJv4sVApmYmJCtrS3js7u7K4+Pj99A
Xl5eZHx8PHpycpIUSDjW3NycbG5uil3HBYI2WfXb21vp6OiQ6elpSVkg3d3dMjk5KVNTU7K6
uir9/f0/TnZgYMDTyff29vqyvRf97u5Oenp6ZGFh4cffXl9fDc1+QQFsaWmpb2AD7UPCAMRP
nQLI8/OzdHZ2ysHBgegOZGdnRyjukLDr2gNJVcenFBCMymIjtV+jMonZ8vKyfH5+Cj8QDYC4
6fxAyICYxz0+PpbQAMF4HLHH0NCQY6SuAoibI9/f32V7e1uur68lZYEgdbK+vi5LS0uOkXpL
S4tnRyYKxM1hXvWUAoIG7O3tGdG6l0jdzH3xA9GgD/mr43UB8vb2JmdnZ3J5eSn8QDQA4qZ/
fHzI7Oys3N/fCz+QJDjST+D8QDTSQwvk/PxcIpFItKurix+IznfI1dUVsr3R2GQXPxD+R1bI
gCBSjzenzg9EQaQeb07dKVIPCxDEGU1NTdG+vr7wAMH4HXPLXubU+e8Q/j6EHwg/kBABMXNB
Nzc3CTt+f39fTk9P+YEkA4jX9Lvb9qiPis3DRFEsl6hj7H3cXxyMC+ro6EguLi74geiQRPxL
uj6UQFDMgImuRIsZ/HIkMgFtbW3RwcFBfiD/R4/nAKcJMJo7JCcnx2hAYWGh6ALEj/38EYh4
LS73HQgKrvGNIgJrY7zOqWsKRPxof2BAkDJHamFlZUWc7oYw3yF+tZO/D+EHwg+EH4iP+49X
nMAPhL/6XQ0QpxSGSsfQA0m2Y7y+ycQPJMmO8WopBcScR3eK1PFuIMyuI/XupLe2tv7Sn56e
BKVBCNIS3Y9XPZbLSnh7ZHtramp+ZXvj7ScwINZ5dKdIHe+pYxu8uGn9oGIejrZqmCPBiY6N
jSW0fTx9Y2PDVUd77TqubCfdbXs3He/Mf319qU2doIN2i9T9uoLDrmvTh/CbRkAaGxtFFx13
7/DwsJL2KAWCfmB+fl7QOaMsyHyMqdJh2dnZguUz8FIRovKgjqscSF1dneTn50t1dbUUFBR8
FzGo0tGp43VqOCktLc1YnySI4yoHgpEORhyRSEQwDdrQ0CAqdbzYidEehtwYijc3NwdyXC36
EKyWg6j48PBQMFGFagyVOh4blZWVxs8VFRXGYyqI42oBpKqqSvApKyv78exUoWNhGtNRuHIX
FxcDa49yIHl5eUa6Gs9MBEMqdXTS9fX1hpPwaAKQoNqjHEhGRoaxRBI6Mkzb1tbWGo0rLi42
vu16Zmamo56VleWol5SUOOrmcNJte1TgYxuMeOCw9PR0x+3hWLf24H/tutv5KgeCVRra29uN
DtJcscGqI7eDK9SuY8IHS+rZdVQcmoURVr28vNz42HX7cNLUAWJtbe17JThTR4drre0yddw9
1lXgTB3DYoyYrDo6a/v5ahUYosFO1RfQnaY+oc/MzIiX/eikA9zDw4OkVKTOb/xA+IHwGz8Q
fiD8xg+EHwi/8QPhN34g/ED4jR8IPxB+4wfCD4Tf+IHwA+E3fiD8xg+EHwi/8QPhB8Jv/ED4
gfBbsuw/+njh8GU4VAsAAAAASUVORK5CYII='
]

{ #category : #sources }
RTBoxPlotExample >> exampleBoxPlot5 [

| b createList r d today |
r := Random new.
createList := [ :size :d1 :d2 | (1 to: size) collect: [ :i | d1 + (r next * (d2-d1))] ].

b := RTGrapher new.
today := d := Date today.
(1 to: 10) do: [ :i | | ds |
	ds := RTBoxPlotDataSet new.
	ds showMean: true.
	ds boxShape if: [ :item | item median > 10 ] fillColor: [ Color green ];
	if: [ :item | item median < 5 ] fillColor: [ Color orange ];
	if: [ :item | item hasOutlier ] fillColor: [ Color red ].
	ds boxLineShape color: Color blue.
	
	ds points: (createList value: 20 value: 0 value: 20).
	ds model: d.
	ds x: [ :date| date julianDayNumber - today julianDayNumber + 1 ].
	b add: ds.
	
	d := d next.].

b axisX labelRotation: -30;
	labelConversion: [ :v | Date julianDayNumber: v + today julianDayNumber -1];
	numberOfLabels: 10.
b build.
^ b view.
 
]

{ #category : #icons }
RTBoxPlotExample >> exampleBoxPlot5Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAFpUlEQVR4XuWcyU4bSxSGeY/s
YEuWbLLlLbhPwOJuYJMleMHlogASghAJxCQQQrAAgqUgIWaQGYxsMxsLEwxcGxFmbDBw+vZp
yZGHauLGPdn/kVrGP0V39fm6qs6pqqZIkvDNTlaE7wJ8IPiGDwQfCL7hA8EHgm/4QPCB4Bs+
EHwg+IYPBN/wgeADwTd8IPhA8A0fCD4QfMMHgg8E3/CB4Bs+EHwg+GYtkIaGBlpaWqLl5WXi
762trYTvYguBrKys0MHBgXIEg0G6v7//DSQWi5HL5ZLOzs4gIN3cEDmdROvrRJYBmZqaotXV
VVpbW6OdnR2anZ1Nqczc3JxhMK6viTo6iNzu7BwQjxNFIkSXl6nl+Tzfvml3pMimp7Wfw9Qx
RC8gajdqlY4PxGZA9AJoCyDRKMlBAFEolFr5x0ciuTiFw5k3hQ/E4BaS7w7GB4IPBB8IPhCd
9OfnZzkEv6QbOTGAA9IhJwKceywsLAgzdaOBLC5m6pyQykmqdHp6igeEp0729vZoc3NTmKmP
jY0JM3U9blTN8dBApuUaHB0dKdm6lkwdH0gBjiH4QAoUCMnmcr3yR8rvXl5eyOe7pYeHBypo
IMQBQFGRRJ8+CR2ZPuZw1LSxcUm3t7dkBBCjz1NwQP6kmw2EW47Xe5MSwOADeScQjyd3IO+5
Lj4QG+n4QJCBcKb+1pq6GpB/bAakoqKiMIBwpv7WmrooU2cgqxqBlJaWGvpky4mtpvKBQECo
y4mytUA4U1+XF6O1rKmb0WUVFxdn7eDz80caHPxPmpw8z0rn85SXl0snJycZemVlZeGMIZFI
jD5+/FvoADUgZWVlQsfo1XJKSkqyLh+NxsjvD0o/f+YbkIsLOvwyQjQzk3Gjbrcbf1C3y9SJ
0YM6d0EfPvwl/fhxjg/ECCDcRQQCQSkUyg0UT80EArlPzeC3EB0dpseUCgwQMxyGDySPgWid
fTYdSH19vVKBlpYWQgBi++l33nDNn/F4nJKdqXVNPd+BvKWbBiQSicjpxAxtb2+TqDUgtRBb
AEEcQ2CAPD09KV3ehZzJ5+owPfZrwQPRqvNS6tbWPUWj0ZwdfHgo3gEpiqbwgUjG7lJ5ezYb
5IUdvZ4w0ZOtdh6OAk9Ofgn3/OID0bHJG3l+GCAOR3/GxjR++bKzM/uXOO0I5D2mO5DEOroo
U5+cnMxwPH///PlfksfkjPJXV1cZ5d+jf/9+p0kXnYcfkK9fo8K3c7XWxzQgyevookyd31Pn
MhwJJR+8Y563aBql7+/vq+pcX6N0v99Pr6+v1k6d8Dq6Wqau1xOf77ptxhB8sxGQkZERsovO
rXdRTt+tqI+lQMLhMHk8HhofH1e2BSW6Mat0trq6OiX34JeKOPs267qWAxkYGKCmpibq6+uj
5uZm4v7USp0H9a2tLcVJVVVVxLsszbiu5UA40uGIY3BwkObn52l4eJis1AOBgBLtccjNofjo
6Kgp17XFGOL1eulQnr8IhULEC1WJTWtW6dxt9PT0KD93d3cr3ZQZ17UFkN7eXuKjU06vk/tO
K/Tj4+PfjuIn1+fzmVYfy4E0NjbK09IbSp+ZPPVthc6D9NDQkOIk7poYiFn1sRxITU0N8ZPI
Axkv2/b39yuVa2trUz7T9draWqHucDiEent7u1BPhJNq5XkHPpfhiIcdVl1dLSzPjlWrD/9t
uq52v5YD4f/SMDExoQyQif/YkKzzSh8/oek6L+w4nc4M/VqeJEpsjEjWu7q6lCNdTw8nEzqD
2N3dJe7Xk3UecHnxKr08tx7eqZ+uc1jMEVOyzoN1+v3aKjHkCovWulkXLfiw7panbbWcx046
g7u7u6OCytTxDR8IPhB8wweCDwTf8IHgA8E3fCD4hg8EHwi+4QPBB4Jv+EDwgeAbPhB8IPiG
DwTf8IHgA8E3fCD4QPANHwg+EHwzyv4HUxntoerK5gkAAAAASUVORK5CYII='
]

{ #category : #accessing }
RTBoxPlotExample >> label [
	^ 'Box Plot'.
]

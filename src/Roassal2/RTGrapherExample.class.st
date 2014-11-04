"
RTGrapherExample new installTitle: 'histogram' 
		code:
		'
	| grapher dataSet |
	grapher := RTGrapherBuilder new.
	grapher extent: 300 @ 200.
	
	dataSet := RTDataSet new 
		points: RTShape withAllSubclasses; 
		stackX; 
		y: #numberOfMethods.
	dataSet barShape width: 10.
	grapher add: dataSet.

	dataSet := RTDataSet new 
		points: RTShape withAllSubclasses; 
		stackX; 
		y: #numberOfMethods.
	dataSet dotShape color: (Color red alpha: 0.3).
	grapher add: dataSet.

	grapher resetAxisConfiguration.
	grapher axisY.
	grapher axisXNoLabel.
	grapher build.
	
grapher open.
^ grapher view canvas'
	
"
Class {
	#name : #RTGrapherExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #sources }
RTGrapherExample >> exampledoubleCurves [

| f g b ds xValues |
f := [ :x | x ].
g := [ :x | x * x ].

xValues := (0 to: 100 by: 0.1).

b := RTGrapherBuilder new.
b extent: 300 @ 200.

ds := RTDataSet new.
ds points: xValues.
ds y: g.
ds x: #yourself.
ds connectColor: Color green.
b add: ds.

ds := RTDataSet new.
ds points: xValues.
ds y: f.
ds x: #yourself.
ds connectColor: Color blue.
b add: ds.

b axisX; axisY.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampledoubleCurvesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAErklEQVR4XuWc20sqURTG+2d7
6qGnXnqoFIrEJ4kkrOhiIKQIUUnTdMPqxSAqKCroQkfnona/39Y+rQ0TdjBRjzrjfB8srJzR
cX6z117fmm0tQuDLSWrBPwX4QPCFDwQfCL7wgeADwRc+EHwg+MIHgg8EX/hA8IUPBB8IvvCB
4APBFz4QfCD4wgeCDwRf+EDwhQ8EHwi+8IHgA8EXPhB8IPhyLpC3tzd6f3+XkclkiP9mmiZx
8M/Wc/intkFAUqkUHR0dybi+vqb29nbyeDzU09MjH63nrO01TSMOlBN6d3dHj4+P1DAgra2t
tLi4KKO7u5tWVlaot7eXvF4vJZPJ7+es7Z+enogDAcbz87Pw5D3i9fWV8OcQm/X5+UkT+oQc
IfiTugOkmAqdGWf4VZYTpBkaxc044Ze9DtD9/T2NG+OiVpUlPpD/m8TJn/OL/6mq8IHUcBKf
ycwILv3xnbpDJnFN1+w3hre3t5ROpymXy0l/wW690J1bjt3NOjVOhWqq5AinzorH49TX10d7
e3uyZWK5c8ut/6hAXObUs9kszWXmZMpyDJDDw0MaHh6mhYUF6urq+nbnPp9PuvbCbd3k1Dk7
BM2g7OfV6z3w55Ay9XVRybYIt0fqKXwg5cGoeXmLD6RKcXoa18fFzc1NQ9IuPpAS4spR/aOK
y8vLhs2B+EB+0cfHB81mZkWjK0R8IL+MDAmjDsYPH0gVIyORTtgCoyogfDes8B66m5w6f4b5
9LxtMKoCEo1GpQlkV97W1uYap87VlBwZNh9rxUAODg6os7NT3kNfW1tzhVNn0zetTTtidMPP
Iey8fTlfzdvo+ECqEPemvHmvvOvnlGOCBaLrOg2ZQ3XvTeEDKUOb2U2aTc/WtWuLD6SCslbN
qo4tMmCAPDw80IA5IAzDcHTFBwHky1uIiBZpSPscH0jpkpaiWpQUQ2maFfkVA9nf36dEIkHB
YJC4bNza2qL19XVpEgOBAA0ODjrCqfO9b3/WL3gxRjNdRFU59aWlJbnAob+/n1ZXV0lVVVIU
hTo6OigUCtnq1K1REdNj9PLy0nR9NdekLF4FwnNFIBsQ+Xy+aRucrgDCd/RCZkikjFTTf3ur
qYFw/4kXOnOKaoYKyrVArq6uZNsjZIQc1YeCAsKpiOcGTk1hLUyNWgWCD6TIaIhpMQrrYTlH
uCU1NQ0QHglfc4NQ0gpF9IgYMUaIoQgQtThhBDCAZDpJXLLyJL1xsSEh1GtBs2uB7OzsEDft
ijl0SxcXFxQO6z9iakoXHBNTGTH5FeEpTf7+73alYnJSKxljYzpFo5qwI/gCswUIt0x2d3dl
G2V0dJR+a2Fw64Sv+ErDartUu2+1J4b3s2NfVzl1/JRVo5RWTNzA5FUsJycnVPg65exb2PSs
dF8W9+oqfV/rf77w9vxFJv6shcfgGCDlpLRi4gbl+fk5LS8v0/Hxsewml9ugLGx6VrovXzi8
FKjS9+UmJgdvz6/Bx7+9vS2PAT9l4acsfOEDwQeCL3wg+EDwhQ8EX/hA8IHgCx8IPhB84QPB
B4IvfCD4QPCFDwRf+EDwgeALHwg+EHzhA8EHgi98IPhA8IUPBF/4QPCB4KtM/QXWS8k76Tz9
LAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> examplehistogram [

	| grapher dataSet |
	grapher := RTGrapherBuilder new.
	grapher extent: 300 @ 200.
	
	dataSet := RTDataSet new 
		points: RTShape withAllSubclasses; 
		stackX; 
		y: #numberOfMethods.
	dataSet barShape width: 10.
	grapher add: dataSet.

	dataSet := RTDataSet new 
		points: RTShape withAllSubclasses; 
		stackX; 
		y: #numberOfMethods.
	dataSet dotShape color: (Color red alpha: 0.3).
	grapher add: dataSet.

	grapher resetAxisConfiguration.
	grapher axisY.
	grapher axisXNoLabel.
	grapher build.

^ grapher view
]

{ #category : #icons }
RTGrapherExample >> examplehistogramIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADa0lEQVR4XuXb3UtiQRzG8f5a
/4aEIIjAy7rpMuquojJ6EyIKjS4qgl6oFCpfWozdCzUVKiIe9/xmnbAyazc12+8Dw8Rh6Bzm
c2ZOvw6nr1bjp5fSx58CPgg/fBA+CD98ED4IP3wQPgg/fBA+CD98EH74IHwQfvggfBB++CB8
EH74IHwQfvgg/PBB+CD88EH4IPzwQfgg/PBB+CD8fF+Q6elpTU1NaXl5WQMDA7Jji4uLWlpa
UuO4h4cH3d7eyvp2XKyKRfFBmmRvb0/r6+uKRqOamZkJ5qmoVCql09PTZxNWqVS0v78v6z97
oaVSqZaPxVzPB2l2t9Zzd3fXcgWk0+m23NUGkclk+CCfDR+ED8IH4YPwQfggfBA+CB+ED/KN
K3Ur9gYHB2uTk5NuwmOxmCKRyKtKPZlMtqVS54O8U6mfnJwoHA7LfrZjQ0NDGh4e7milzgf5
y1jVzt+y+M8QPggfhA/CB+GD8EH4IHwQPggfpBMgiURCOzs7ssm2d+Z2bG1t7dXE8yv1LoFs
bW2pv79foVBIm5ubyuVyqlarryadX6l3CeTs7Ezb29vy1fnu7q7GxsbE37L4zxA+CB+ED8IH
4YPwQfggfBA+CB+kkyAbGxsqFAquBuFX6l8MMjEx8fQZwv39Pb9S74UVYp8g+P9j8St1/jOE
D8IH4YPwQToJouAdisrlZzian9f/ClJZXVUpn1dPgliyqdSfCc1kVF5YkE1sNpl0E6zzc+ni
Qp0C0dWVrHUTxK7VWs+C+Av0rXGCM+m0a61WzWdAcoeHrgXvbmrVkRH7LpIP0hKkfsz+lLZV
Y305GlUpm1U7QJqd82n13NxIwRtQv61+W5CjoyMdHBy8WaW/rNQ/CtLYv9zi/PibeFzWGldU
ZWVFpetrt2/b/u1Xg9VKzc5pEH7ibDu1c/6Ix12vx0fXGleUH+8RXV//bt5fjxs/Our6roOc
B/u+tbeqdF+pXweT5HvDuby8fLddBM+Tj4yzlgtujH/5HT/n5pQ9Pm46Ph+sGGvNxlv7NTvr
xhfGx1uex9I1EFsdx8HFtarSnz1Y66nx87XPEH74IHwQfvggfBB++CB8EH74IPzwQfgg/PBB
+CD88EH4IPzwQfgg/PBB+OGD8EH44YPwQfjhg/BB+OGD8EH44YPwwwfhg/DzofwGc3EH7cin
41IAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> examplescatterPlots [

| methodsRoassal methodsTrachel greatestAge b ds | 
methodsRoassal := RTObject withAllSubclasses flatCollect: #rtmethods.
methodsTrachel := TRObject withAllSubclasses flatCollect: #rtmethods.

methodsRoassal := methodsRoassal select: [ :m | m numberOfLinesOfCode < 300 ].
methodsTrachel := methodsTrachel select: [ :m | m numberOfLinesOfCode < 300 ].

greatestAge := (methodsTrachel , methodsRoassal collect: [ :m | m date asUnixTime ]) min.

b := RTGrapherBuilder new.
b extent: 300 @ 300.

ds := RTDataSet new
				points: methodsRoassal;
				x: [ :m | (m date asUnixTime - greatestAge) / 3600 ];
				y: #numberOfLinesOfCode.
ds dotShape circle color: (Color blue alpha: 0.3); size: 5.
ds interaction popup.
b add: ds.

ds := RTDataSet new
				points: methodsTrachel;
				x: [ :m | (m date asUnixTime - greatestAge) / 3600 ];
				y: #numberOfLinesOfCode.
ds dotShape circle color: (Color red alpha: 0.3); size: 5.
ds interaction popup.
b add: ds.


"b allX: [ :m | (m date asUnixTime - greatestAge) / 3600 ] .
b allY: #numberOfLinesOfCode.
"
b axisXWithNumberOfTicks: 4.
b axisYWithNumberOfTicks: 4.
"b axisX; axisY."
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> examplescatterPlotsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAKc0lEQVR4XuWdC1BU1xnHLwZj
Rq1Nm0wyPjKNJlMbsc40JjrTmjbYJhIxMzVO0NSoGSWOBhtqnEYZo6C8BKNiA4jxAYIpoFZB
ERDkJQKrKIiFDS5U0fpAKiYKi4jwp+e7NxcvsKtiYLnL983cWXb3nHPvnt/5Huc7516k1lb+
oieR+HcBfyD8hT8Q/kD4C38g/IHwF/5A+APhL/yB8AfCX/gD4S/8gfAHwl/4A+EPhL/wB8If
SHuJjY3FvXv3EBUVhezsbOTl5YE+Dw0NBf/u7AUgBMNgMMhAGhsbERgYiAsXLqC+vr4dEAg5
e/Zs6/nz53sEVEUFQAd7IATDbDYjOTkZ1NklJSUwGo2ytnQs21Mw+GvIYwp/IPyB8AfCHwh/
IPyB8AfCHwh/IPyB8AfCX/gD4Q+EPxD+QDpLcbH95LzsGsjNmwAdDyvX0NBHgRw7dgwnT57E
tm3bcPXqVRw/flz+oevWrZOTjNu3b4cegfRpk7Vv3z4EBwcjISEB06ZNkzsjMjJSBhIfH9/W
OZR+z8/P5+9HehIIaURdXR0yMzNx8eJFmEwmlJWVoaamhtY+UFBQ0KMaIk4nzqVoBJkh8g32
ZI76nA/RAtGbo75zp3uuh3/Y201SWQl0BxS7AiJiiT65bMtfQ/gD6Vkhv6L6Fv5AdACkpQWg
gz+QXgRiT+kQFkDMZv5A+Dt1/kAe7jvImfelXYx9Agh/DeFvsvQDJC0tTe7kjIwMSuhix44d
8nt/f/9e39vbFyKvLgOh9ZBbt25h/vz58Pb2bk1KSpI7ISsrC83NzTZLv4skc6d2bZkBhgjz
dAGkUmTR6DYEAaCVbkOgVDyl4Kurq22qIcnJoD5Bb2kFnZi/D9GIUEz+8xC9TQzpEBaUf5Sl
ByBffaWsP9A6RMfvumuxiD+QbhBrkPgD4T8P4QOE0iShoV3TAjUk1ntwYbdA9u/nH2XpBoge
F6RI+7pjScAuNzl0Zcn2UbLAj9qeLeY+fd6pPwoQPWlcnwDCfz1EB0B6K3VibdLZazsXL1++
LGd76ZXeX7t2DernttaQntr9rtU42bkIe/awSSclO7vjWroMpEEE9E1NTfD19W07OW2yplsU
tOVssfvdFrcjaIHo0mQRCHoi0Jo1a3DixAm4uLggPT0dfn5+NtWQHxtikgaoZq+nJo2sfEjH
ieGjro2opoheLZmg3r4JyG6BiJVjWNOcB4HRgqSOv3q1/e0NXQGinb8UFXXPSqUugXTcTWJp
njBpUvv3P5j6R7rfkLRDWFmcPn0fiMFgua7WtFm6ToJ3+DAQHd09cxmbAOnqUmtHIJZm0nFx
7fdj0ffXr1vvlI5tqiZLC8pSvcTE+ykRaxNIaic2to+kTqyBsvS5VgtWrlT+1naQ+r22o9V0
y8P2cFlz7FrtoPq02Ub7PQ2CrCxgyxY7BaKdUVPHpaR0/hH0w0QA1+nztDSgtlb5nDSEOkft
ZFULH3eBSgXyzTfAuXPtNU8LXe10Hx/lNScHOHoUWLECqKqycyAklrbzWJuoZWYqP546nXyI
6ny1pqu0FKBJmlr30iWAjgfN8AnGokWWAWjfq6ZTq4FqEDBvHnDmjJ0BUfdM0Q9SO1EdcVp1
v2usgKW0hDYqGjoUWLVKaU/bTsco6UFA6HrofUP+aWzdbEZhYed9wtrrIjCkPaSpubmKJlIb
dLz5JnDokM6BlJdfaLtA1QSRigcGKj+MRhttVqDP6TO18y9nV7Qza0eOKKN0927xo/2KUVxg
hpMTQNpAbVBbFHZSGdIgKqdqi0gitBvx5FM6mqlb4dHw821BSYnynkwP+QYqo2oOidF435Tu
3QuQw4+KUs4xbBgQHq5zIDExN9rWL6IilJ1+NFo/+gjYuRP424fX8bG7kpa4EZMES4k66kwa
udTG3LkimvE14YbBhDeGmjByJJCdrXQ4vW7dqmgKAaTzGlJr4besFgEBCjDqbHX+MmMGQIOD
oIS8nYRZs5RVSGqruvo+kLKZa1BvrJL/jo//Ib8lKpXHF8maSOHzxo3A4MHKq66BfPttldyR
NIK2LVF2+gUFAW+NMuHvHvVwnVANpzEtcpmEhPumIvdog9xR1IOnM27i1Cmlo+rrgQ3uZYjx
NmHisyZMnaqYJzIdIqMj+w7SioMHlXayNhVhwWtFWLwYoNG9fLkCgYBPnKjYfDJ7y5YBC91q
5fNTue3bWpCYoAyU0PXmtkBi3DhlHxjBdXq5QfYbbm6AhwfQvz+waWGZvoGELTTggrEBcf4m
LBmxH+tmnIDraBMmPGPCohcOIuhpf/TrB9DII7NDdRq/v4ONSyoRF9ssD/f/pFfCY1IxCuaG
weeXMVg8IhHxz32Cvwzcj+HDgffeAyIjgTlzFEdPUZsaAWWFFGHer/KxdHKxPOK9vETCM9OM
KynFmD4dmDlT6Uxvb+EXnnJFzBdGeXB8uaIGGfGKB/981B78Y+QG1NUBzs5KeGtI+w5eDgF4
9RUzRv+iQQ4IXPsl4eDU8N4DcuXKFShx+HWrF7F5TgFMiWW48evfI2mwGz5+8QjCf7ocvo7e
2DFuE6Ic5uH5J2oQHKyYC5o5X6k0Y9dnxQiZU4jUgEIsXQr8dnwDZkyuxYwBiQhz8IBb/39h
teSD1yUDPhySgC3PrcLYsUDQSxFwGvEdHB0ha9WqDyoQ5vhXvPGaGWfPAkveMcnmLCH6e4xz
LEXkK+sQFgYsWADsfcINGRM/R35wDnLHe+La2q9xNzsPXw/3RuRIH9mvLH+/EnN/cwanlkbj
jwNysPLFaLz180L82aVBHlgpIxb86LnIYwGhjdUqCB8xHCnz2yltLSRx9KetuQP/gGMDnNEs
9cMdaQD+Jz0DSA5olJ6EWRqI2VIMxowx44OnD2DPniq4z/4vfJ7fAL9hXyJ1yLsolMZjlFSB
2Q4xSHFwQb00SG6rXtQtlcZgp6M7/CUvYTKa8eqgf8P5J3kYNOguNm26BPchu3FK1D/85Ls4
6rkdoWM3YMJwE3Y6ecvXcLjfO2J0X8NkAfuS9AIifxeIt8eUoElyhPHTAJR/5oNa6WdIf/0T
GLJLMfulNLg+lYrpz6YhTfoT/inNQoiDJwYOvAdJakGTgyNoecLmQFqEQV+9erWcfl+7di3o
sU2WytEjnB73ArnVtYkP4S86AUJLvIUiVpX9yObNwk6HPXDU0P0m9AwuWuSilUdn4T13i8nE
JREj0/dnRDjkJTzyVhHXdqxbJYz7fuGA6DledK4cEUbdvn0bERERcllaPNu1axfojq+OdQ8c
OCA/iI3qxolcTEhISFtZ+g8Q1Ia1ukr6Jg7K/MQoJoWH5Ie70U1Myqy+BtoyvQqEnqlFd1TR
87TCxWxJve3NmqhLwtS5dGvclClTQA9FoyfVnRPhV66YFpeXl4u5y85O7RSJGDRIxNIEkw7q
ZCpPUOj89G806OFqlswqPeNr/fr1cj1PT08RoaW0laW6qampVusqKXuDPAhuitibroMGzAIR
IdA10/nJtFMZ/iaLv8niL/yB8AfCX/gD4Q+Ev/AHwl/4A+EPhL/wB8IfCH/hD4Q/EP7CHwh/
IPyFPxD+wh+IbuX/VfQ6glP26KYAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> examplesinAndCos [
| b ds |
b := RTGrapherBuilder new.
b extent: 400 @ 400.

ds := RTDataSet new.
ds dotShape rectangle size: 0.
ds points: (-3 to: 3.1415 * 5 by: 0.01).
ds y: [ :v | v sin ].
ds x: #yourself.
ds connectColor: (Color red alpha: 0.4).
b add: ds.

ds := RTDataSet new.
ds dotShape rectangle size: 0.
ds points: (0 to: 3.1415 * 5 by: 0.01).
ds y: [ :v | v cos ].
ds x: #yourself.
ds connectColor: (Color blue alpha: 0.4).
b add: ds.

b axisX.
b axisY.

b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> examplesinAndCosIcon [
	^ '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'
]

{ #category : #accessing }
RTGrapherExample >> label [
	^ 'Grapher'
]

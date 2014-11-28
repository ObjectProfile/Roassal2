"
RTGrapherExample new installTitle: 'MethodSize2' 
		code:
		'


	| b classes normalizer |
	b := RTGrapherBuilder new.
	b extent: 400 @ 200.
	
	classes := RTShape withAllSubclasses.
	normalizer := RTMultiLinearColorForIdentity new objects: classes.
	classes do: [ :c |
		| data ds |
		ds := RTStackedDataSet new.
		data := (c rtmethods reverseSortedAs: #numberOfLinesOfCode ).
		
		ds interaction popup.
		ds dotShape rectangle color: (normalizer rtValue: c).
		ds points: data.
		ds connectColor: (normalizer rtValue: c).
		ds y: #numberOfLinesOfCode.
		b add: ds.
	].

	b axisX.
	b axisY.
b build.
b open.
^ b view canvas'
	
"
Class {
	#name : #RTGrapherExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #sources }
RTGrapherExample >> exampleAgeOfRoassalAndTrachel [
 
methodsRoassal := RTObject withAllSubclasses flatCollect: #rtmethods.
methodsTrachel := TRObject withAllSubclasses flatCollect: #rtmethods.

methodsRoassal := methodsRoassal select: [ :m | m numberOfLinesOfCode < 300 ].
methodsTrachel := methodsTrachel select: [ :m | m numberOfLinesOfCode < 300 ].

greatestAge := (methodsTrachel , methodsRoassal collect: [ :m | m date asUnixTime ]) min.

b := RTGrapherBuilder new.
b extent: 300 @ 300.

ds := RTDataSet new.
ds interaction popup.
ds dotShape circle color: (Color blue alpha: 0.3); size: 5.
ds points: methodsRoassal.
ds x: [ :m | ((m date asUnixTime - greatestAge) / 3600) asFloat ] .
ds y: #numberOfLinesOfCode.
b add: ds.

ds := RTDataSet new.
ds dotShape circle color: (Color red alpha: 0.3); size: 5.
ds points: methodsTrachel.
ds x: [ :m | ((m date asUnixTime - greatestAge) / 3600) asFloat ] .
ds y: #numberOfLinesOfCode.
b add: ds.

b axisXWithNumberOfTicks: 4.
b axisYWithNumberOfTicks: 4.
b build.
b open.
^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleAgeOfRoassalAndTrachelIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleColoredAndInteractionLabel [

	| b |
	b := RTDoubleBarBuilder new.
	b interaction action: #inspect.
	b shape label 
		text: [ :cls | '<', cls name, '>' ];
		if: [ :cls | cls name endsWith: 'Shape' ] fillColor: Color green;
		if: [ :cls | cls name endsWith: 'Box' ] fillColor: Color red.
	
	b points: RTShape withAllSubclasses.
	b bottomValue: #numberOfMethods.
	b topValue: #numberOfVariables.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleColoredAndInteractionLabelIcon [
	^ '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
AElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleCrosses [
 

| b |
b := RTGrapherBuilder new.
b extent: 300 @ 300.

ds := RTDataSet new.
ds dotShape cross color: (Color red alpha: 0.3).
ds points: (RTShape withAllSubclasses flatCollect: #rtmethods).
ds x: #numberOfLinesOfCode.
ds y: [ :m | m getSource size ].
b add: ds.

b axisX.
b axisY.
b build.
b open.
^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleCrossesIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleDateOnXAxis [
 


| methods oldestMethod b |
methods := RTObject withAllSubclasses flatCollect: #rtmethods.
methods := methods reject: [ :m | m numberOfLinesOfCode > 150 ].
oldestMethod := methods minFor: #date.

b := RTGrapherBuilder new.
b extent: 300 @ 200.

ds := RTDataSet new.
ds dotShape circle size: 5; color: (Color blue alpha: 0.1).
ds interaction popup.
ds points: methods.
ds y: #numberOfLinesOfCode.
ds x: [ :m | m date julianDayNumber - oldestMethod date julianDayNumber ].
b add: ds. 

b axisConfiguration 
	noDecimals;
	title: 'LOC'.
b axisY.
b axisConfiguration 
	title: '';
	labelRotation: -30;
	labelConvertion: [ :v | (Date julianDayNumber: v + oldestMethod date julianDayNumber) ].
b axisX.

b build.
b open.
^ b view canvas
]

{ #category : #sources }
RTGrapherExample >> exampleDateOnXAxis2 [
 

| dates minDate b |
dates := Array with: Date today with: Date yesterday with: Date yesterday previous.
minDate := dates min.

b := RTGrapherBuilder new.
b extent: 300 @ 200.

ds := RTDataSet new.
ds interaction popup.
ds dotShape rectangle color: Color blue.
ds points: dates.
ds x: [ :aDate | aDate julianDayNumber - minDate julianDayNumber ].
ds y: [ :d | d dayOfWeek \\ 7 ].
b add: ds.

b axisY.
b axisConfiguration 
	labelRotation: -30;
	labelConvertion: [ :v | (Date julianDayNumber: v + minDate julianDayNumber) ].  
b axisX.
b build.

b open.
^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleDateOnXAxis2Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADKklEQVR4XuXczUtqQRzGcf+5
/pkWLjNpYS4KdRFtglAUCSNcCBYVGpEpJb6BIkobXZmGIYovkBL8jDmXe7lw48qxPCN9H4ha
9NB4Puo4M3Rs8zk/6xQb/xLwQfjhg/BB+OGD8EH44YPwQfjhg/BB+OGD8MMH4YPwwwfhg/DD
B+GD8MMH4YPwwwfhxzqQdrstf3/nRyOI1+uVi4sLA2IwGEi/3/8HZTgcSrVanfd6PQyYzaYJ
JJPJyPb2tuRyOXG5XKLy2e/VajX+q2ed5hA+CB+ED8IH4YPwQfggfBBLPn7yQfhZHcjb25tx
sZ+fn4UPohmk2WxKvV43LvbW1tanF12t1FOpFGqlrg1kNBpJPp83Vuput1tmsxl/pc6fQ/gg
prO52eWD8EH4IPy3LD4IH4QPwgfhg5jK7wXf/87U+SAWghweHi48U+ev1C0CeXp6ErVlwj9T
588hfBA+CB+ED8IH4YPwQfggfBA+iJUg4/GYf6a+TiA+n49/pr4uIOVyWTY2Nvhn6vw5hA/C
B+GD8EH4IHwQPggfhA/CB7EUpNvtLjxTL5VK8tWdgJ/Y/XaQ3d1dY0Gofl50pv7w8CCVSsX0
1+3t7XyZns5uoVDQ8wq5u7uTvb29hWfqr6+vSz/bfnKXf68T/qT+a/NxMpkIv6sZRM0dDodD
AoGAOJ1O4Xc1gZyensrBwYHc398bg4rFYsLvagJRH33f39+NwV1dXQm/qwmkWCzK+fm5tFot
Y1DX19fC72oAUWuLo6MjsdvtEo/H/wyQ39UAcnx8LOr9c39/X8w+Q2jdlYJks1k5OTkRtR1i
9rZ+tO5KQdTkpf4nfWdnRxqNhqTTaeF3NYCovZnLy0tjYMFgUPhdjSDqJpdnZ2cSCoWM908r
uureKTq6X328KwNRG2NqQJFIxBhQIpGQ6XQqVnRvbm6ML6u7Ho9HHh8fTXctAel0OpJMJsXv
94vaDjDzB76jGw6HTV+M7+hGo1F5eXmRtdxcXOaBUbtrsw7hhw/CB+GHD8IH4YcPwg8fhA/C
Dx+ED8IPH4QPwg8fhA/CDx+EHz4IH4QfPggfhB8+CB+En1XlA+KfYhAltsKuAAAAAElFTkSu
QmCC'
]

{ #category : #icons }
RTGrapherExample >> exampleDateOnXAxisIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAALfUlEQVR4XuVcaWxUVRT2h1GI
mhijEvctxsSYaIgmajTRCO7RqAniD43REIliDEhYRG3LTg2rQoGy71gsOwKl7PtOWVpKQbaC
rKWUlrbQr57v3VzmdToznTed6bx6TjJ5s7zz7n3nO/u9826qrdVPfqKb9ItAPyD6ST8g+gHR
T/oB0Q+IftIPiH5A9JN+QPQDop/0A6Kf9AOiHxD9pB8Q/YDoJ/2A6AdEP+kHRD8gTUPnz5+H
PR45csR5v337duiHIUmALFmyxBH+oEGDMHbsWOTm5uoHI9mApKSk1E6dOpVH5OTkICMjQz8o
+mOIIkDKysocjb969SpOnjyJ0tJS/RaQTEDS09Nx+PBh7N+/HxUVFaiurq4HSElJSW1RUZFz
jCedPo16Y9XUAIWFgFpA2rZti0uXLmHLli3o06dPWEGUl5fHXUgbNwJioLh8GdBvIR4pEYDQ
GviqqtIPiC8AOXgQ0B9DfAQI6eJF4N9/9VuILwBZvhw4cwY4dUo/IL4AJFwwl4QP+gFJksvS
H0P0A9I8KnUez4hDb0pAQhWGkSiewT9eyURCKnV7TE1NRVpaWshKvaCgIK6V+p49wLx53gTi
x+CfkEp9x44d4LF3795Yu3Ytkh3Um5quX499Hv+rGNIYQcSLIHT0qGJApKHs+G62TBojCK+x
JT8/MeA3e0CuXIF0laMXTjSFYzJji/60twmIALMLrRoQCkFWAaC/MEwiIMXF/gTAy7xU9LIa
S6EsLdxKJLOsXbvqfn/oUBIBuXbtmrOWzkr9uuShTe2yCIqXIB8NnT/v7XrB53tJEhJiIYsW
LcJp6WOsWLEi5EQSUalbqqz0n9ui1US7rp8QQLiWvnLlStiNcc0hy2JRuXOnERrbMPqDehzI
CtSr+3IXldRm/VlWnGj37rrCjMZ9uXlKS4ELF+ryBF+zMRaoDpADB0LfdCQX5BY4izcKLpa9
XHbsUFmWl/5WswKEgor0+4gRdX9v6Hx3FlRSAhQVBbYQhUp1CRZ7Z+Guwx4YWznMsrg+4v5N
GuDNAxCrldHwnD0LCBvCuZPsbLNJzsYNL9uCeK47PQ2V6ublRd6ER3dHQAnu5s11z4t2LkkH
hDcYr41t1Gp33GjI9USKD6GCu3uu4RSJSsNOcHW1sRbbOY52o4VvXVYo18CgG5w12Rvne64Y
hhKkW3Ds9m7Y0LBwgq0xOBYRnOPH61sBv6clcZ72PfmSGkNYqRsTvhBzHRKqug2VNVFo1o1Q
IHQVVpB2nZuxoTEVf7j1Efu7tbTp042Fjh4daGyuWQNkZUW/3p6wwnDZsmVYI7OJtlIPzoTW
rYsuZSVfQYE5t2vX+hlTQ72kUIKSmhbumsYK3t1BDmWJtFSOmZJiAju/W7AAYEAfMyZJgLCX
xY0Nq1evxuLFi6OyELfb8VqcuRecpkwBTpxAvdgU7L+XLg18Du7EUuDRJBl0aRzbjkeiK+S9
vPtuXX5aatIAiSWGWLdDbQ0uzqxGNpSNMYC/9RZAjbSab3kjtb/d2Q8tjprNa2zfXp8nOJXl
nP/5J+COCBCV4KOP6p7HOPLmm80EEBuoeaSvpebxRq1Wr1+PiNkYg+WcOcZKvvnG8BI4XtO6
jZEjA3zWvVnau7fuZwqX+7sYsK31WYFPnBg4170Pa98+gIUh011+36qVCebWcmnxn3/uc0AW
LrzqTJAaZtPVtWsB+m8GYVvtBmtlcO+KQZwaTUH/9hswe3Yg1ZVms0O8Pq3ExgCCbIVpAz79
PEHki9dwJxU2vlFprJVaq3P3wX7/3YBy771mTryHv/4COI+PP/Y5IOvWVdywALve3K4dkJMD
pKYCU6fWz3DcqbAVyOHDAHe9MwZ9+inQpUvAkigUAk5h03LIT83//nvzPTOgP/8050rYu1Gh
t2ljNJ1ju10ftd5em8ImOIwZdG+0tJ9/NlZJQCZMAPiPrg8+MO/pTn0NSFlZuaO1FCa1klr4
ySfA4MEAhfP++3XjCTXRXSVv2WJ6Tnw/cyYwfDjw3nvAl18aQdHlWUvJzQ24PbpEBlgCYhMJ
Cp/jUsjbtgEPPBCoZ3iOJIw3LI4A8D2tkW6KCQIVYdIk4LPPDPi33AL88gvANJgK8u23QM+e
PgekT58qxy0MHAj89BMwbZq5IWpS375GswiUdREU5MKFgZuSNTDHxWVkAJJlOwJlMOW1CA41
lsKSZA8zZgTcE62mW7dAjUGroZCpzbwOBUohMu0maPzNpuDjx5v5WrdG0Bk/CAjHJUirVgH3
3WeOVIhnngFefBF45RWfA5KWVgXbEBw2zLyeftoIjJr+1VcmqLqDMLXX/qmTuT618J13gKee
MkDecw9w993mWhRcv37A/PlA69bGjxMQgtWxoxEWLYMubOtW4NVXgb//BmhN331nrJQtEGZh
P/xg5kCLGDTI8HDeFDpdLl0gAWnfHvjxR+Cuu4D0dKNkHToYQJ57LsmARNr5TqJbYMF2660m
K6FAbr7ZCPX++42QKQybxo4daypgWg8Bo5C/+AJo29bwPf+8OfJF3iefNNekkPjdQw8BdG08
8jtaF7MpWg+TgzvuAD780Aj48ccNaP37A927Ay+9ZBShTZvrjiUSTAJAV8TjnXea8d54w4Dz
2GPA228DPXoADz5o5tGqVU3yAAm3691dqd92W6VU1nvwyCNlMulLIqhLAk4NWrS4Jq8aAaYc
f/yRL+likbiTXfj113xxacdFCIUCxrHaFi0I3hU8++wZtGxJLSwGv2vZskbcwzG5bgmeeOKc
8BTi9tsr0LXrIXkdFO0trW3d+oJo8H6xnjx8/fUREXqBw/fyy6eQnb3HmUu7dkfFCvPw2mvF
Mt5JAW0XHn30XG1m5h5nPt265eP114ulCDwqQbxcLLNC+MpkPqfxwgun5dwSAapSrnsNDz98
EbzfpAHC9fR+4i8iV7pnY+7w/p959T/rxGeUFECGS2QVtxWTtjVkeZFonvTnY+XlH5CuSA6c
aN4mA4R/3NktzaLxkjteljSpv0RML/zrJdry2EHSljnSK/HCa8fqwSjroXHJB+hwsx/nnJmZ
KbVEz4TzNgkgOyWNoRAnT54saWyBdEhPwIvv3SfJPlv5tKxoBVopvRi+NktvhQ/A6SLFhbe0
PE3S4a1S8E3yPOfG8CYckGKW44Czk3GYFAheeGlRMyQvHSFJP92Nl40Rlnew5KleXVVNjUlR
OR4fstZUvAkFZJtUcfOlKqN25EkTKNRjmsIR+ShImjy1Ldz/FCONzWNHKSaqqqrgha9Xr17O
+dRwL+M2hjehgEyXBs7cuXOlSp3maKYXcyWNkUaT6U/NdJ65FS0f49JAKc9nS0+jU6dOziOi
Yp1zuJXOePMmHJDRUkpzggyetIpo+TbIUtsCKcmnyJIfLWnAgAGeXNOxY8fAWDNq1ChPINKV
ctyl0vTyOufG8CYckI3SmaMw+chXxgwvvDTvNtLv7is9kYmyAsSn0HlxSyTGCmYyXudMQZJ3
lTSlvPBOkH76kCFDYuJNOCB0EfSdRdK582KuI2UZj0eCsEv63gelceVlXFoRx2V66VU7u0m7
187ZS4w5d+4cxo0bh86dO4MK4YU3YYDslb42///B/JrP32V+TbfhxcXQ1HkzvLlYJ86YsVwW
U7w0O7Ozs2UN44DzvOCGmp/Bc+a9zpo1C6yDfFOp0x2xJrB+npOMZdChQ4dK6/tik2z7J+h0
g92lbcs/ELWXVq8Xft4jEwwG7UJp8/qidcIHWvLIwo5EN+P3nhC1mlZkP9M6oo1PVJZNmzbd
iEsM3CwyfdXLYqV9VFbzE+E3E0XM+rykv8EFXlZWFnzbXGxMYy5ZFOuD/pmBsThNxpz1t999
RvoB0Q+IftIPiH5A9JN+QPQDop/0A6IfEP2kHxD9gOgn/YDoJ/2A6AdEP+kHRD8g+kk/IPoB
0U/6AdFM/wHYRxAyEaJaiwAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> exampleDoubleBar [

| b |
	b := RTDoubleBarBuilder new.
	b points: RTShape withAllSubclasses.
	b bottomValue: #numberOfMethods.
	b topValue: #numberOfVariables.
	b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleDoubleBarIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleEbola [

	| tab data b ds |
	"Preparing the data"
	tab := RTTabTable new input: (ZnEasy get: 'http://mapstory.org/geoserver/wfs?typename=geonode%3AEbola2&outputFormat=csv&version=1.0.0&request=GetFeature&service=WFS') contents usingDelimiter: $,.
	tab removeFirstRow.
	tab replaceEmptyValuesWith: '0' inColumns: #(10 11).
	tab convertColumnsAsInteger: #(10 11).
	tab convertColumnsAsDateAndTime: #(3 4).
	data := tab values reversed.


	b := RTGrapherBuilder new.
	b extent: 350 @ 150.

	ds := RTStackedDataSet new.
	ds interaction popupText: [ :row | row at: 12 ].
	ds dotShape ellipse 
		color: (Color blue alpha: 0.3);
		size: [ :row  | (row at: 11) / 5 ].
	ds points: data.
	ds highlightIf: [ :row | (row at: 10) > 100 ] using: [ :row | row third year ].
	ds y: [ :r | r at: 10 ].
	ds interaction popup.
	ds connectColor: Color black.

	b add: ds.
	b axisX; axisY.

	b build.

	^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleEbolaIcon [
	^ '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
Ifwxffgff5Jw1WkAY5wAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleFunctions [


	| b |
	b := RTGrapherBuilder new.
	b extent: 300 @ 300.
	
	(Array with: Color red with: Color blue with: Color green with: Color yellow) doWithIndex: [ :color :i |
		ds := RTDataSet new.
		ds dotShape ellipse size: 0.
		ds points: (0.0 to: 10.0 by: 0.1).
		ds connectColor: color.
		ds x: #yourself.
		ds y: [ :v | v raisedTo: i ].
		b add: ds.
	].
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.
b open.
^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleFunctionsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEl0lEQVR4XuXd3UobQRgG4FxB
r6S34WnxuLfgQY604oFrBAUj9a/QntjS0hapAQ+0LVbRqq2/YBUqGlsUBRUDkmBDFJW+2/km
TjDF2nWzyY55v2XIbjTr7D67M+bb7CTiuvxhU0T4dwE/CH/wg/CD8Ac/CD8If/CD8IPwBz8I
Pwh/8IPwBz8IPwh/8IPwg/AHPwg/SHGcn59DHvf393FxcaGLzMtzqVSq8DP+XVshkKWlJRwe
HkJ2/ubmpi6ZTAbRaBSxWExDyHI6ndbz8phMJl2zzBDAFioGUl9fj4mJCTQ3N2NsbEwXx3Ew
OTmJtrY2LCws6GUJ85rt7W2qMwZ4Dav7ECYQ4AzWd+pcIO38IHaBfOEHsQvkLT+IPRhHuBNv
DHlAevlB7ALp5wexC+QHP4g9GO8D2UZ+kMBAxvlBqq3/4AcJDOMgsO3zBbK3t4dcLqczvn+n
3M0yF0h/uCAjIyNIJBI609vS0oK6uroCjCybNLyEpN3n5uaqOv0OxMMFWVlZwfr6OpqamtDa
2oqpqSmdjl9cXNTLMzMz4DpDfocLwt+HlOfs4AcJBCTBD2IXSIofxB6M7sC3ix+kJJBBfhC7
QE74Qaq5ueIH4QepFoxc2baHH8SC9x78ICWDjPOD2IPxoqzb4jv9Lo+M6XdgwD6QhoYGmDQ7
U/odyJR9G3yByA4fHR3Vn3ZnSr+X++zg70NuDbLCD2IPxtOKbAM/iGeQD/wg9mA8q1j9+UE8
gTznB7EHY6SidecHsaTv4AexrKniB/EEMsMPYg/Gu1DqzA9yLUYOwAY/iD0gr0Krry+Q3d1d
nJ2dVeWn34E3odbVF8jx8fFtP/2Ou5B+B5KhNVUlgdTW1mJ+ft7Tp99lEJqtra2iwWjsBfkU
eh35+5ACRqsVdeQH0RgfrakfPQjwNfR+gx+kgLGoMOatqhstSP7MWLCuXpQgeYxZK89aOhDg
s8L4aW2fRgUC9FWkHtOY5h8E82aIWZT7QlM3utGjJv4z5EaIjIJ4GfjfVhk8JNT0TU3LauJv
sv4LkVIQnQjqDtkYYhhVk+M6GoO/D/GMkFDFf7MhO16OeDn6H6vpznXqZux3mb9pvPeNjWDf
CZ+cnKgdv6xKPqvsBUF2tBzhicubbbrQVTjiZX1B1y8UEDP2uxkL/rrfkbT72lqfe3r6SKV7
HVeKe/noZb5T7zY14T4cRFzn10NEo2nXUb9iygNnGRE1Y4osOw4ufw7XzHc6WbfohZclE41e
+/zV0nXPgRNR9fBQvj8ZDOcMMWO/Sype0u/XNyXAwcFBoOl3WV+QR7RN6ytrH+K1SfMaR0f5
cXF3dnZwddlvmDrJDpSLbuZGJL+RzWaLWop/tRqhgXhp0m4TPT35vmJgIH+fhln2Ex0dHRge
Htav7+3Nj7c7NDRUUh3j8XjRjUxXr5xaAeKlSfMa8o+B3LklX4chVyVXV1f1st/1yVXNxsZG
vb729nb9HSjJZNL3+mQMsZqamsIVU/P1HVb+28sf/CD8IPzBD8IPwh/8IPwg/MEPwh/8IPwg
/MEPwg/CH/wg/CD8wQ/CD8If/CD8YeIPX2amRIdH+ZAAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleGroupViewOnHistogram [



| b |
b := RTGrapherBuilder new.
b extent: 300 @ 200.

ds := RTStackedDataSet new.
ds dotShape rectangle size: 0.
ds points: RTShape withAllSubclasses.
ds y: [ :c | c rtmethods size ].
ds barShape rectangle 
	width: 10;
	color: Color veryLightGray.
ds interaction 
	highlightColored: Color red.

ds interaction popup 
	named: [ :c | c name, ' methods' ] 
	background: Color veryVeryLightGray 
	group: [ :group :element | 
		| s ms |
		s := RTBox new size: #numberOfLinesOfCode; color: Color red.
		ms := element model rtmethods sortedAs: #numberOfLinesOfCode.
		group addAll: (s elementsOn: ms).
		RTGridLayout on: group ].
	
b add: ds.

b axisY.
b newAxisConfiguration plain.
b axisX.
b build.
b open.
^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleGroupViewOnHistogramIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADJElEQVR4XuXaSWsiQRiH8Xxu
L979CMnBi4ecBD0qLigEEdxRlKBBiYIejHjw4PI6vk0qNE6NOqPd2vP8oSh7SVvWL71Udz/t
9/w8Up74XcAH4YcPwgfhhw/CB+GHD8IH4YcPwgfhhw/CDx+ED8IPH4QPwg8fhA/CDx+ED8IP
H4QfPggfhB8+CB+EHz4IH4QfPggfhJ9ggxQKBYnFYhKJRESnE4mEJJNJOV5vtVqJFn5XewzS
brfl/f1dnp+fnc7udrui847Xm0wmUqlU+CB+HrLW6/XJDv/4+JB+vy+5XG4/GAx+5uu0Fn58
PofwQfggfBA+CB+ED8IH4YPwQfggV/9Wp8ghvg8MtdaRuubl5UWKxaJ1pN7r9TAg5jftdju5
yx6it1Bms5mDop//NFI3IFq/vb05xTR+OBw606PRSPggV0b3AB2pb7dbueSQZWp3MfN0V+eD
+HwO8RtEt+knNh+EDxJcED8uIvggfBA+CAakVqs5Hff19fUzwOKD3BHElFt2HgZkPB47XxiN
Rp260WjI4T/87EidD+LxHmJectDn61ouGanzQTwA0S/NZDISDof3ettD945msyn8Qxb/HMIH
4YPwQfggjwbyr/ek+CABAlkul6JXgVrzQR4AxIs7wXyQG4CYWzbz+VwCDVIqlZw32/X5+nQ6
tTbgViN1L0Hc7Qg0SDwel9fXV2m1WhIKhawNuNVInQ9yQfRNE32e3ul0JJVKSVAPWf8NyD3O
IYPBQC65fDXrmPX/FiSbzZ7tWBs2H4QP4i/I8TwbyKmO4YP4CKIXDFr4IA8CcryMD8IH4YPw
QU4knU47o3R9nn5ohLUBi8XiqoGhFyDmZW8biFlmQMyL4KZ2F9u27wpyeHzrPMI1tS2fn59S
LpelWq06jTe1u+jjX/d0vV7/bR0z73hd9zLb35n1T23T1g4DYmu3WXZq23cB0b1C33rfbDaS
z+etDZDv7Pl5nHMIP3wQPgg/fBA+CD98ED4IP3wQfvggfBB++CB8EH74IHwQfvggfBB++CD8
8EH4IPzwQfgg/PBB+CD88EH4IPzwQfjhg/BB+DmbX54DDngf154DAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleHistogram2 [
	| b ds |
	b := RTGrapherBuilder new.
	
	"We defien the size of the charting area"
	b extent: 500 @ 100.
	
	ds := RTStackedDataSet new.
	"When the mouse is above a bar, say which class we are point at"
	ds interaction popup.
	
	"Each subclass of RTShape will be a bar"
	ds points: RTShape withAllSubclasses.
	
	"The height of a bar will be the number of methods (defined in the instance side)"
	ds y: [ :c | c rtmethods size ].
	
	"We set a color of the rectangle"
	ds dotShape rectangle color: Color blue.
	
	"All the bar have to be stacked from left to right"
	ds stackX.
	
	"Set the width of a bar"
	ds barShape color: Color blue; width: 10.
	b add: ds.
	
	b axisX.
	b axisYWithNumberOfTicks: 4.
	
b build.
^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleHistogram2Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADI0lEQVR4XuXaP2vqUBjHcd9J
+5bcS/sGCu1soVXRqUPfQTsoOLjpVL3+nVxKNyU4xEEEwUVxULSPzZOQS0yDt71Nau79/uCQ
HELOycnH5OjBxG7HT5yS4N8CPgg/fBA+CD98ED4IP3wQPgg/fBA+CD98EH74IHwQfvggfBB+
+CB8EH74IHwQfvgg/PBB+CD88EH4IPzwQfgg/PBB+CD88EH44YPwQfjhg/BB+OGD8EH44YPw
QfiJGYhpmjvDMPh3JU5PyGg0kt8HE04Jyt2dc0y3/PBB+CB8ED4IH0Qn9V6vtwsCeXsTeXx0
ShDIy4tz7PVVhH9bf+AJWa9FvHU/yM2NczyOT4z3g8QHicMgfa9evca4vmqRIIfmxv8W5P5e
5ORE5OHBeVXovhY+SEiT+ldB/PVj3gT+E8IH4YPwQUIE2W732+aD8EFiswIRi0k9ziA/DbR3
WWLFQonFE/L0JKLlbwblPzdKkO9cpy4z6bnucpPuH+2V5f217Af50xPTbIroua1W8C9v91xd
f4sa5DtPtr9tu61jgRwC8Nf1xnsBbm8/1/Y/D7K17sRwOIwURPtYrVbyFRB/X3EACRpH6CA6
qReLReuT2LKL25nu1+tt8dYvLkx7X7daPzsbyaG6e269XpdqtbrXVqPROlj393V+bga27b/u
ZrMlh47r/tWVaS/p6DaoL3/99NRZAnp+/vVhHFrcJaKg+vW109fl5Siwrw8gKj6bzSJdb+L3
8clvWdPpVIL2w8xisdAvcrK23n9R9eGdBzebjWiJoo/xeGy3O5/PRUvoIOl0WjKZjLjbKAaR
TCZlMplIuVyWWq0WGUipVLLbNgxDtETRx2AwkOVyKYVCQdrtdvgg2WxWut2uNK3vlPl8PpJB
5HI5qVQq0u/3JZVKhd6HM/80RMfS6XRs9LDh3T50LNaPaNH9MPvg/3Mx7mtZ/PBB+OGD8EH4
4YPwQfjhg/BB+OGD8EH44YPwwwfhg/DDB+GD8MMH4YPwwwfhg/DDB+GHD8IH4YcPwgfhhw/C
B+GHD8IH4YcPwg8fhA/CDx+ED8IPH4QPwg8fBJF3z7uGtXujWGMAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleMethodSize2 [

	| b classes normalizer |
	b := RTGrapherBuilder new.
	b extent: 400 @ 200.
	
	classes := RTShape withAllSubclasses.
	normalizer := RTMultiLinearColorForIdentity new objects: classes.
	classes do: [ :c |
		| data ds |
		ds := RTStackedDataSet new.
		data := (c rtmethods reverseSortedAs: #numberOfLinesOfCode ).
		
		ds interaction popup.
		ds dotShape rectangle color: (normalizer rtValue: c).
		ds points: data.
		ds connectColor: (normalizer rtValue: c).
		ds y: #numberOfLinesOfCode.
		b add: ds.
	].

	b axisX.
	b axisY.
b build.
^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleMethodSize2Icon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleMultipleCurvesStacking [

| b points1 points2 minY maxY ds1 ds2 |
points1 := TRShape withAllSubclasses sortedAs: #numberOfVariables.
points2 := TRShape withAllSubclasses sortedAs: #numberOfMethods.

minY := 0.
maxY := (points1 maxValue: #numberOfVariables) max: (points2 maxValue: #numberOfMethods).

b := RTGrapherBuilder new.
b extent: 300 @ 200.

ds1 := RTStackedDataSet new.
ds1 points: points1.
ds1 connectColor: Color blue.
ds1 y: #numberOfVariables" min: minY max: maxY".
ds1 stackX.
b add: ds1.

ds2 := RTStackedDataSet new.
ds2 points: points2.
ds2 connectColor: Color green.
ds2 y: #numberOfMethods" min: minY max: maxY".
ds2 stackX.
b add: ds2.

b axisXNoLabel; axisY.

b build.
^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleMultipleCurvesStackingIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEnUlEQVR4XuWbX08TSxjG/Wrc
8DHgQ3DDXUONOa1GUqIo2iAXBVvbGDiBHKyQUAgeaJEQaZAARkMEqiD9A8tuoe2z7ju0pkGI
Wtvuts9vs5kSNu3M/nZ25p1395Zp8uMkbvGfAn4h/PAL4RfCD78QfiH88AvhF8IPvxB+Ifzw
C+GHXwi/EH74hfAL4YdfCL8QfviF8Avhh18IP/xC+IXwwy+EXwg//EL4hfDDL4RfCD+tL6S7
uxuRSARerxfyt9vtRqlUwtXjdF2H7Cwn9eLiArYIgcX+/j66urpUBY6OjpDNZn+qzNbWFg4O
DmiEjORHYBgGmi6k8qPSK+SquKkS6XQaTLedZ3gGR48hTEJKuNz4hTgEP/xw/CyLScgABviF
OIUNbKAl4hAWIROY4BfiFCTOmtVn+YU4BTfcKBaL9gmJxWIqCOzo6FCVCAaDWFtbg8fj+alS
EhS2c6Q+gpG6ta1mIeFwWAno6elRlVlcXFRlIpGgitSj+Whd21WXW1b12o2maWC5ZckKxdv0
W+cJYR1D/jbm4BdSRzaxiSKK/EKcwnM8b0ib+IXUwGR2smHt4RdSA768j1+IU4gj3tC28Av5
Q4IIOlfI9vY25ufnsby8rCoZjV4fJKVSqbaI1NNIN2RmVTchsnyysLCA3t5eVUm/34/rAsN2
idTruUTSECEul8tcWlqCLJtIL+nr62vbnLphGGaykHS2EJYxZBjDmDamUSgU+IXYQSaTMe/h
Ht5k3yB6Fm1q3fmFXB0XEcP7k/e2/T6/kCsykkjaWld+IWVeZ17bLoNfSJlHeISz8zNH1JFO
iOS9X+ZeQh5oC5wFMJwfdtTFUrOQlZUV1ZCBgcskzd7eHuLxOKS8eqzdOXV5tHM0NWpO4nKV
9vz8XJV/85S644RI7nx9fR2dnZ2qUZXlk/7+fkdF6jJQy9Yqs7yahfh8PszNzZmyS8+QUq64
oaEhW3Pq8oqE5LplXJhNzyKn5VoqBmq7MWTCmMChftiyKwNtJeQBHtgmQnqmTBg+fQK8Xu3a
RVYaIXIiXFmXbTKs7AIikYI1Tur8j5IKHnhQmTk1g8pvDQ4Cfv9Xq2cA/Lcsi2/Zb/jP2prZ
G0IhIBzO8eTUq6/0fD6P6pnTR2u7q93FK+0V5CE1a1UW9b7qBXlXUq7627cNBIMnCASAUCiH
x491ruX3EKztJIRAeZvKTKly/GIcKSP1W98hJ1OSSeXPZiWHIUvqFU5PT1H5/+hoEVbiE0+e
aOrEyx6LHaNlZ1mVPPrMzAw2Nq5/g2hnZwfHx5eNrJ59yMlLWZtX8+Kp/hS/6iHV0bWVpMTD
h4fqBI6Nlays5RfcuQN8+PBnQpqRdGqakN3dXVQaZ6VzISndm45bXV2FlIkvCfyTHMf9zX/x
/+47a1DU1e1gbExXn6ens6qUfWoqo8pwWMeLF9qPYz9/TqnvcvJuWw8ZtKYa5Uj9xhdWUMbk
xxljCD/8QviF8MMvhF8IP/xC+IXwwy+EH34h/EL44RfCL4QffiH8QvjhF8IvhB9+IfzwC+EX
wg+/EH4h/PAL4RfCD78QfiH88Avhh18IvxB+fsl3T+IO9OMHW7cAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleScatterPlot2 [

	| b ds |
	b := RTGrapherBuilder new.
	b extent: 290 @ 200.
	b interaction popup.
	
	ds := RTDataSet new.
	ds dotShape ellipse size: 15; color: (Color red alpha: 0.3).
	ds points: RTObject withAllSubclasses.
	 
	ds x: #numberOfMethods; y: #numberOfVariables.
	ds dotSize: #numberOfLinesOfCode min: 4 max: 20 using: #sqrt.
	
	b add: ds.
	b axisXWithNumberOfTicks: 4.
	b axisYWithNumberOfTicks: 4.
	b build.

	^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleScatterPlot2Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAFvElEQVR4XuWczU8TQRjGUY96
8OIfYUz06EkTYjBwMPFg4kkPetPoQUIMhG8DMUSMmqgBLkYSjKJUA8YEhAIlKWCEE0hDAD/4
lM9K+Cw8OO9st5a6bZeKpfA8yaa72+7O7vx25v2Y2SZtbPArkZTEXwX8QPjFD4QfCL/4gfAD
4Rc/EH4g/OIHwg+EX/xA+MUPhB8Iv/iB8APhFz8QfiD84gfCD4Rf/ED4xQ+EHwi/+IHwA+EX
PxB+IPzaPUCGh4fh8/kCC3+V7jCQ2tpaDcHj8UCW0O+HhoY2+vr6op4Hvb3AkyfgBxKjnE7n
RmNjI7q7u9He3o76+nq9WP1WQbFV0fB6+YHEoxC7QPjFD4QfCL92ERDcvQt8+gR+IPwthB8I
v/iB7G0g8/PzGBsb0xXtVfGDROyTk5NYXFxELEDUwYi0zQ8kikpKSnSFud1u/VlTU4Pi4mKM
j48jNFJXgWN0g56bi0jb/EAiSKLzlJQUpKamQiJ2kUqPoKKiwjJa5++y+G0IPxB+IHsICOrq
gJERhNvmBxJvIJJ6X1pCuG1+IPxdFh8QPHrED4m/hexxIJP+aHplZQUTExOIBkTbhqdPYScw
DOx3uYCLF4E3b8APJIpKS0vR1taG6urqSMO3myL1cMO0mJ623r+2plPy+PmTH0g0ZWdnQ1Im
verJz8rKQsxelscDPHwIqHSMrvyeHvB3WTvp9n79CkUWaGoC5uYg2/xAEsCoCwx+o76DQDAz
A7x9+8fg++dloasLUAnM3VSRmJ0FHA7wu738LSR2ILpFvHsHpKcDZ84Y+x4/Br58AT5/hrQM
vc/phCz8QHaghVi5wfD5ANJ5wvFtIWp4Fx8/As+fQwUwkH7XbBF/QXnxIvA9PxCb8vqf7tHR
Uci6N0zQFwCixt1RVgY8eAC8fAkMDhr7X7/+G0hODvD9Oz8Qu2ppaUFeXp5eL1OVXFlZiebm
ZkSL1EO7KzNCD47UmSddxwxEcleZmZlqLKkOaWlpkJnwVukTKAVaiHJlUVAAHD4MnD4NHDsG
nD9vfKdyWaYbbBp6fiD8bi8PEHFzdYs4cgQ4dw44ehQ4exa4dg24fn1LGWB+IP+hhchEOJ27
+vED4SbFMU6Wiw8Q5U3B7YbK0+v0Au7dM7wt/yS7TRC+fTNsihpTZ7Qj8QHS3g7cuQPk5wP3
7xuR+q1bBqCgqadYWAik3rWL/P49P5BEMOqMAWF8gVy5AiQlAYcOAZcuAa9e6fhD25ELF2AG
gvpT7Ip/PdGEX78gS8ICCR5HDzemvqaGYPv7+/9Uto0bMltI6Ex63d0J0Nu3DYfAIhA1y1xe
Xo6p4qxm7+uy5SGS7IEsKsuwnWVuG5B8ZRMKVKBnflr9ZlAZ9PX9+40Wsm8f1g8cgO/gQcyc
PImuZ8/0ZO1wi8PhCKy7VXplTLnJs8ePw3vihF4funwZbhVIhh7X0NAAeX8+0rntlBm8SFnB
i1WZI9sw2/KfgBQWFqK1tVU9rE0oKiqyvBh5aqampgyvKjkZ6ofAhw9QNSZBfMQbkBxZ4Ald
Xwdu3ABOnQKuXgVu3oTK3UQsM5Z7Ci5zUwuR9x/NFqLWt7PMuNkQO12alSRJOa1szIxKpci2
+eRpz0u6KjW6aHXcgnhpSjItSbbt/t2HvHwkn0vK1V5dXbW8ZnVSYyxHFv/5zWPN6VDmdW7l
XuMKxE6XZqVk1ZLkU/Jj8gKQ3Rvs6OhQYY4DVVVVEf/uI1Ty8tHAwIDyuHvQ2dmJ4Gu3c6w5
HSrH74xs9X7jBsROl2ZlVNNVnGIaV3lDK9dmCkUAulwuPS1Jyo30dx/BkpeP5ubmIEAzMjK0
fbBzzeaLSzIdqry8XIORc5j3nbBuL7/4gfAD4Rc/EH4g/OIHwg+EX/xA+MUPhB8Iv/iB8APh
Fz8QfiD84gfCD4Rf/ED4xQ+EHwi/+IHwA+EXPxB+IPziB8IPhF/8QPjFDyQR9RuT0X8DSNC9
VgAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> exampleSimpleValues [

| b values ds |
b := RTGrapherBuilder new.
values := #(5 6 7 -1 -3).
b extent: 400 @ 300.

ds := RTStackedDataSet new.
ds interaction popup.
ds points: values.
ds connectColor: Color red.
ds y: #yourself.

b add: ds.

b axisXWithNumberOfTicks: values size.
b axisYWithNumberOfTicks: 6.
b build.
^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleSimpleValuesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEeUlEQVR4XuWdy0srMRTG/evc
ubkLt/4ZLlwI4srrC6XgRgVRXAiCouLbIkWsIL6QqqAot1gfqFXRatXj7QkdL9zJTMe0M570
+2BwwDkk5jf5kpOEsebzE1+SVIPfBPhA8IUPBB8IvvCB4APBFz4QfCD4wgeCDwRf+EDwhQ8E
Hwi+8IHgA8EXPhB8IPjCB4IP5J9ubm6orq6O+L61tZXm5+dJF/j8/Ex82fqH5/N5sqaHjIyM
qMq2tLQQQ9E9c3h4SOfn51YCoY4OysVilMvlyBrL4jfIr8Lck6yCMD1NNDlJlMl81Zt+/6aq
GUNsAELpNNHUlAKh/f3gID6QqCyJr5LPPT7iA4nSkgLFCbMta4HwGFfKkgIBEWZbVgKp5CxJ
mm1ZA8TUkmyzLdFAlCUVQYRazsCAXCANDQ2qcvF4nPr7+6m9vV1bWU4Kw8rU1SypqyuyRpJk
Wy4gVBA39MvLC42NjRFn5Hz//3MHBwcVzdTDtCSbbMsFhAdKnsG8v7+rCnr1gnItq1KzpGqz
rR8bQ+7u7rQ978eACLGtql46sdG28IEIsy18IMJsCx+IMNvCByLMtvCBCLMtFxAnM19cXKRE
IkFNTU2UzWYpykwd2bZcQJzMfKqQsG1vb6ufusBKZ+r4tuUBhN9650QGL6OgWdZP2xb+GCLM
tvCBCLMtfCDCbAsfiDDbwgcizLbwgQizLXwgwmzLBeTp6YnGx8dVJRYWFmh/fz/yPXVk29L2
kO7ublWJ5uZmKlzaQJtPv0u2LReQy8tLBSGZTNLKysrX3jqqZUVtW/hjiDDbwgcizLbwgQiz
LXwgwmwLH4gw28IHIsy28IEIsy0XEM7OnQbnXOTo6Ag6U4/atlxAXl9fKZPJqIuBjI6O0sfH
R+in3/FtywNIb28vra+v0/LyMm1ubhJ/PEAXeHx8TA8PD8aVu7q6sjLesa1yy7++vtbGG48h
DCSVStHZ2ZnRtbOzY2X8n4IzVKL83d3dygLhMcbvVErJN60oG+PZtsIq3wjI3NwcMRC/5Xk/
8dvlTCC+Gx90e8CvISYmJozjWanGxrLi0+m0Z/y3gXB3eyzMNhiI3/K8nzY2Nkou7/spyPaA
n3p6eozj2Wp+1daWVX5nZ6dnvFEPicVitLa25rs876cgy/teCro94KW3tzdiIKbxrELcZ7K+
3iieDyH29fV5lo+fGJqOASF9AQIfiKGyt7eUGxqi0IHwQevZ2VlVEGfpp6entLq6SviZukdP
KY4HoQA5OTlRA3ZbW5sqxMnSdckhaqauhbK0RJRIUCg9ZGtrSw2anK0zCG74mZkZwresElDu
74mGhwl/DKkyC8MHIszC8IGEaWHFr7viA7HYwvCBCLMwfCDCZmH4QIRZWI1XY/PiF9/zUrvu
GfxMvTwLy8fjFAjI3t7e1366s9TuBQQ/UzfX/cWF9quq2h7i7KczFF5qx2++6IT//0PwgeAL
Hwg+EHzhA8EHgi98IPhA8IUPBB8IvvCB4AsfCD4QfOEDwQeCL3wg+EDwhQ8EWX8BBR3Ll9qy
s4kAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleTwoInteractions [

	| b ds |
	b := RTGrapherBuilder new.
	b extent: 300 @ 200.

	ds := RTDataSet new.
	ds interaction popupText: [ :c | 'Roassal class: ', c name ].
	ds dotShape circle color: (Color blue alpha: 0.3).
	ds points: RTShape withAllSubclasses.
	ds x: #numberOfMethods.
	ds y: #numberOfLinesOfCode.
	b add: ds.

	ds := RTDataSet new.
	ds interaction popupText: [ :c | 'Trachel class: ', c name ].
	ds dotShape circle color: (Color red alpha: 0.3).
	ds points: TRShape withAllSubclasses.
	ds x: #numberOfMethods.
	ds y: #numberOfLinesOfCode.
	b add: ds.

	b axisX; axisY.

	b build.
	^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleTwoInteractionsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAD7UlEQVR4XuXcS0sbURyGcT9a
N+5d9gu46K4bF4qaeEUEbXcFXbgQ7KItggYkSmK8LFSKsS4kbgzxLhrwjtc3nTN4gpeJTDQm
o88LQzKlh8b5deZc/sdU5XL8BClV/EvAB+GHD8IH4YcPwgfhhw/CB+GHD8IH4YcPwg8fhA/C
Dx+ED8IPH4QPwg8fhA/CDx+EHz4IH4QfPggfhB8+CB+En2CDZLNZXV1dybzf2tpyX/f29sS/
nBUCGR8f18LCgnZ3d2UhwuGwWlpaHqCk0+lcKpUqyQfV+rq0sSE+yKPE43E1NDSorq5OsVhM
zc3Nmp+fV2trq6anp59cMAeFf+cEqQ/hg3wgECUS4oOUEUSLi9L5Of8O4j+y+CD88EH4IHyQ
SoGcnJxof39fx8fH2tzcdC+4OT/36KD5IGUA6e7uVmdnpztTj0Qi7gW3549n6nNzc/yr/JYg
yWRS1dXV6u/vl1lCaWtrc2fq9px/h/D7ED4IH+SDgehuIMBPUEBSKT5IUECWltzlKz7Ie+pD
tLyMXXTkd+ofZaZuS7d2pl6ops4HKdNM3dbQzYTQ/FmhmrrXTN0x5COVeqZuauimvt7e3l50
Td0ZZPFBgtqH6G7YxacIYKeukRHxQfijLD4IP3wQPshjEKd7ePDq9hmQ7aGBvUPMGpZZFTHv
d37GNDnJH/6WBOTo6EjmyGQyun/+HEjyW9x9NUPcTKhfOztSNssHKQnI4OCgEolEHsGee2A8
mKnbR5SdqTvzSj5IKUDMrndTP6+pqVE0GpU9fzKvcGLuEP6FD1gf4nghQM7O5G5XDjwIv2Qb
JJCZGS2Hf/FBAgPi9DFjX8fyIyz9+8fHqfQd8vv7Oh8hKCDRaFpdXfxRVmBAfnyOiF8hLAPI
/Rp6oXr67empvnz6+yKMm5sbXVxcYNq+GsTW0L1q6TZra2v609vrrFlN5oo9JiYmNDo6+u7a
2i9SKDuIraGbunpHR4fnhzD/Ww4ODl70AWlt37wP8fNIKxSzRma2F11fX+cPfzPlM7Nao8vL
S/fvF9PWbG1yH7O3t/mvDfH7ue0vMJn3r/2qkTcD8fNI88rU1JRCoVDOPDbM+erqqszhp63Z
/TI8PKyhoaGi25qtTQMDAzo8PHS/NuT+z+CnbU9Pj2ZnZ9XU1FRU27KB+HmkFbqz6uvrZbYb
OSvF7qKl18KlV8wi54wz71lZWXH/bb9t7dam7e1t96itrX12a5NX28bGRvX19bkwfttWZNjL
Dx+ED8IPH4QPwg8fhA/CDx+EHz4IH4QfPggfhB8+CB+EHz4IH4QfPgg/fBA+CD98ED4IP3wQ
Pgg/fBA+CD98EH74IEHNf4EL0NxGzOIGAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleTwoStackedCurves [

	| b ds |
	b := RTGrapherBuilder new.
	b extent: 200 @ 200.
	
	ds := RTStackedDataSet new.
	ds points: #(0 1 2 3 10 20).
	ds connectUsing: (RTLine new color: Color blue).
	b add: ds.
	
	ds := RTStackedDataSet new.
	ds points: #(0 10 20 30).
	ds connectUsing: (RTLine new color: Color red).
	b add: ds.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.
^ b view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleTwoStackedCurvesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEQUlEQVR4XuWcW0vrQBSF/XM+
+EP8C+KT1yqWvouXo1al+CBI8X6v1LsvCqK0LwqioiK9CEertitndjWHQmtN2mmaZi0YQkpm
muyveyZ79kybDINfblITvwn4gfCLHwg/EH7xA+EHwi9+IPxA+MUPhB8Iv/iB8IsfCD8QfvED
4QfCL34g/ED4xQ+EHwi/+IHwix8IPxB+8QPhB8IvfiD8QPjlHSC3t7f4/PzMFzm/u7sDv9nr
CKS3txfxeDxfHh4e8Pj4WAQkmUwasVgsf6y13t/f8XR9DUog4hXd3d1YX1/Pl8PDQ3R0dJQ0
xrVDRsL8PPjHEAtyDMjgID8QtwDBygr437LcBGRoiB+IW4BgcxP8b1luAjI6yg/ELUCwswP+
OMRNQIJBfiCm7u/v8fLyglwuBzNydxIIdnfBH6kXaHh4GIXH0RJ9uUToKmisSaSO6Wl+IKZk
mqSlpQVdXV0Ih8PY39+Hz+dzzENwcNBw82aeHkMwM8MPxC1A/p6eam0vlUqBH0g1BgyFtLYX
CvEDqbyrOjrSajzVHPi7LBeNHao5fiAVw9jb02o89WII/kG9GiDaxw6PAfn4+EA6nc4XOf8p
p64DCKJRrcZTzcFzr70nJycqWJ5W83s7ZXPqOiJ1TE5qNeDUlAeBtLa2Ymtrq+Y5dUQiWo2n
mgN/YFgNkLExrQYcH+cHUrEBdGcDVXN1m3LxBhDN2UDVHD+QSoHoXkmyuoq6Tkg2PpCREa0G
VM3xA6kUSHJuDm9vb9oMuLiY0NoeHRB8ZyF1KJOBzLrUPX9ScyASoZt59J/y6ZUA0b1GNxiE
K5JZjnjInOpa5NjW1lbyoSuJ1HV6Rz0i8roCicViKkVxlF8JL9sBioyrdHV1JQc47R0ym/v6
SgZE9xii0zvW1uCqvHvDAdHpHT4fXLcIovGAaPKO5WW4ckVKQwHR5R2pFNTMMz+Q6oFo8I6z
syzC4STnHkOdQOx6x1f8A/T3A2dnQCAA5HLg37CjDcgv3qEyxRgYAM7PvyDc3KSNRpQjQMy0
bbk96hKrWPUOiRvE+EtLT/D7M7i8tP7Lz2azyKh5ErvP8Kq+1BNAZKG1BITfETkSiUTRg8ln
GxsbxoqaSo9EIkZhubi4MOJ/Fo1AIIrm5ghmZyP/r1lYWJB6RXXKFble6tmpI0VmEjwBZHt7
G319fflIvbOzs2Q0Lp/JPhKrkbqp5+dn2792uV7q2X0OuT+aMcRKl/aTgUqtYiknc+OQnXrm
fTnxtyB1B2KlSyslcwNQYf3fNDExAVnFbqeO3+9XQ9i87ftrWCBWurRSHiUbgY6Pj9HT04Oo
xQVy4lVSzO+0Ukfabm9vt3V/nnjt5Rc/EH4g/OIHwg+EX/xA+IHwix8IPxB+8QPhFz8QfiD8
4gfCD4Rf/ED4gfCLHwg/EH7xA+EXPxB+IPziB8IPhF/8QPiB8IsfCD8Qfjmtf+Fp+dApOMdF
AAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleUsingLegend [

| clss b lb n ds |
b := RTGrapherBuilder new.
b extent: 300 @ 200.

clss := Array with: RTElement with: RTEdge.
n := RTMultiLinearColorForIdentity new objects: clss.
clss do: [ :cls |
	ds := RTStackedDataSet new.
	ds points: (cls rtmethods sortedAs: #numberOfLinesOfCode).
	ds connectColor: (n rtValue: cls).
	ds y: #numberOfLinesOfCode.
	b add: ds.
].
	
b axisY; axisX.
b build.


"defining the legend"
lb := RTLegendBuilder new.
lb view: b view.
lb addText: 'Distribution of number of Methods in some classes'.
clss do: [ :aClass |
	lb addColor: (n rtValue: aClass) text: aClass name.
].
lb build.

^ lb view canvas
]

{ #category : #icons }
RTGrapherExample >> exampleUsingLegendIcon [
	^ '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
gg=='
]

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
	
	dataSet := RTStackedDataSet new 
		points: RTShape withAllSubclasses; 
		y: #numberOfMethods.
	dataSet barShape width: 10.
	grapher add: dataSet.

	dataSet := RTStackedDataSet new 
		points: RTShape withAllSubclasses; 
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
	^ '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'
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

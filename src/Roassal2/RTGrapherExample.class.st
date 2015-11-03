"
RTGrapherExample new installTitle: 'MinAndMaxSetManually' 
		code:
		'
| b ds |
b := RTGrapher new.
ds := RTDataSet new.
ds points: #(1 2 3).
b add: ds.

b maxX: 6.
b minX: -2.
b maxY: 5.

b build.
^ b view'
	
"
Class {
	#name : #RTGrapherExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Grapher-Core'
}

{ #category : #sources }
RTGrapherExample >> dataEbola [

^ 'FID,the_geom,Year,YearEnd,Country,latitude,longitude,Type,cases,deaths,PerFatalit,Descriptio
Ebola2.1,POINT (-9.696645 9.945587),2014-01-01T00:00:00,2015-01-01T00:00:00,Guinea,9.945587,-9.696645,ZEBOV,528,337,64%,"Outbreak is currently ongoing in southeastern Guinea, including the capital?Conakry?and the neighbour countries?Sierra Leone?andLiberia"
Ebola2.2,POINT (32.290275 1.373333),2012-01-01T00:00:00,-0002-12-29T00:00:00,Uganda,1.373333,32.290275,SEBOV,24,17,71%,Outbreak occurred in the?Kibaale District.[34]
Ebola2.3,POINT (15.827659 -0.228021),2012-01-01T00:00:00,-0002-12-29T00:00:00,Republic of Congo,-0.228021,15.827659,ZEBOV,77,36,,
Ebola2.4,POINT (32.290275 1.373333),2011-01-01T00:00:00,-0002-12-29T00:00:00,Uganda,1.373333,32.290275,SEBOV,1,1,,
Ebola2.5,POINT (121.774017 12.879721),2008-01-01T00:00:00,-0002-12-29T00:00:00,Philippines,12.879721,121.774017,REBOV,0,0,0%,Outbreak in the?Philippines?and the first known occurrence of REBOV in pigs. Strain closely similar to earlier strains. Six workers from the pig farm and slaughterhouse developed antibodies but did not become sick.[31][32]
Ebola2.6,POINT (21.758664 -4.038333),2008-01-01T00:00:00,2009-01-01T00:00:00,Democratic Republic of Congo,-4.038333,21.758664,ZEBOV,32,14,45%,Outbreak occurred in the Mweka and Luebo health zones of the Province of?Kasai-Occidental.[33]
Ebola2.7,POINT (21.758664 -4.038333),2007-01-01T00:00:00,-0002-12-29T00:00:00,Democratic Republic of Congo,-4.038333,21.758664,ZEBOV,264,187,71%,Outbreak occurred in?Kasai-Occidental Province. The outbreak was declared over on November 20. Last confirmed case on October 4 and last death on October 10.[30]
Ebola2.8,POINT (32.290275 1.373333),2007-01-01T00:00:00,2008-01-01T00:00:00,Uganda,1.373333,32.290275,Bundibugyo ebolavirus,149,37,25%,Outbreak occurred in?Bundibugyo District?in western Uganda. First reported occurrence of a new strain.[2][3][4]
Ebola2.9,POINT (30.217636 12.862807),2004-01-01T00:00:00,-0002-12-29T00:00:00,Sudan,12.862807,30.217636,SEBOV,17,7,41%,"Outbreak occurred in Yambio county in?Western Equatoria?of southern Sudan. This outbreak was concurrent with an outbreak of measles in the same area, and several suspected EHF cases were later reclassified as measles cases.[29]"
Ebola2.10,POINT (15.827659 -0.228021),2003-01-01T00:00:00,-0002-12-29T00:00:00,Republic of Congo,-0.228021,15.827659,ZEBOV,35,29,83%,"Outbreak occurred in Mbomo and Mbandza villages located in Mbomo district, Cuvette Ouest D?partement.[28]"
Ebola2.11,POINT (15.827659 -0.228021),2002-01-01T00:00:00,2003-01-01T00:00:00,Republic of Congo,-0.228021,15.827659,ZEBOV,143,128,90%,Outbreak occurred in the districts of Mbomo and K?ll? in Cuvette Ouest D?partement.[27]
Ebola2.12,POINT (11.609444 -0.803689),2001-01-01T00:00:00,2002-01-01T00:00:00,Gabon,-0.803689,11.609444,ZEBOV,65,53,82%,Outbreak occurred over the border of Gabon and the Republic of the Congo.[26]
Ebola2.13,POINT (15.827659 -0.228021),2001-01-01T00:00:00,2002-01-01T00:00:00,Republic of Congo,-0.228021,15.827659,ZEBOV,57,43,75%,Outbreak occurred over the border of Gabon and the Republic of the Congo. This was the first time that Ebola hemorrhagic fever was reported in the Republic of the Congo.[26]
Ebola2.14,POINT (32.290275 1.373333),2000-01-01T00:00:00,2001-01-01T00:00:00,Uganda,1.373333,32.290275,SEBOV,425,224,53%,"Occurred in Gulu, Masindi, and Mbarara districts of Uganda. The three most important risks associated with Ebola virus infection were attending funerals of Ebola hemorrhagic fever case-patients, having contact with case-patients in one''s family, and prov"
Ebola2.15,POINT (11.609444 -0.803689),1996-01-01T00:00:00,-0002-12-29T00:00:00,Gabon,-0.803689,11.609444,ZEBOV,37,21,57%,Occurred in Mayibout area. A chimpanzee found dead in the forest was eaten by people hunting for food. Nineteen people who were involved in the butchery of the animal became ill; other cases occurred in family members.[19]
Ebola2.16,POINT (11.609444 -0.803689),1996-01-01T00:00:00,1997-01-01T00:00:00,Gabon,-0.803689,11.609444,ZEBOV,60,45,75%,Occurred in Boou? area with transport of patients to Libreville. Index case-patient was a hunter who lived in a forest camp. Disease was spread by close contact with infected persons. A dead chimpanzee found in the forest at the time was determined to be
Ebola2.17,POINT (22.937506 -30.559482),1996-01-01T00:00:00,-0002-12-29T00:00:00,South Africa,-30.559482,22.937506,ZEBOV,2,1,50%,"A medical professional traveled from Gabon to Johannesburg, South Africa, after having treated Ebola virus-infected patients and thus having been exposed to the virus. He was hospitalized, and a nurse who took care of him became infected and died.[22]"
Ebola2.18,POINT (-95.712891 37.09024),1996-01-01T00:00:00,-0002-12-29T00:00:00,USA,37.09024,-95.712891,REBOV,0,0,0%,REBOV was introduced into a quarantine facility in Texas by monkeys imported from the Philippines. No human infections were identified.[23]
Ebola2.19,POINT (121.774017 12.879721),1996-01-01T00:00:00,-0002-12-29T00:00:00,Philippines,12.879721,121.774017,REBOV,0,0,0%,REBOV was identified in a monkey export facility in the Philippines. No human infections were identified.[24]
Ebola2.20,POINT (21.758664 -4.038333),1995-01-01T00:00:00,-0002-12-29T00:00:00,Democratic Republic of Congo (formerly Zaire),-4.038333,21.758664,ZEBOV,315,250,79%,Occurred in Kikwit and surrounding area. Traced to index case-patient who worked in forest adjoining the city. Epidemic spread through families and hospitals.[21]
Ebola2.21,POINT (11.609444 -0.803689),1994-01-01T00:00:00,-0002-12-29T00:00:00,Gabon,-0.803689,11.609444,ZEBOV,52,31,60%,Occurred in M?kouka and other gold-mining camps deep in the rain forest. Initially thought to be yellow fever; identified as Ebola hemorrhagic fever in 1995.[19]
Ebola2.22,POINT (-5.54708 7.539989),1994-01-01T00:00:00,-0002-12-29T00:00:00,Ivory Coast,7.539989,-5.54708,CIEBOV,1,0,0%,Scientist became ill after conducting an necropsy on a wild chimpanzee in the Tai Forest. The patient was treated in Switzerland.[20]
Ebola2.23,POINT (12.56738 41.87194),1992-01-01T00:00:00,-0002-12-29T00:00:00,Italy,41.87194,12.56738,REBOV,0,0,0%,REBOV was introduced into quarantine facilities in Siena by monkeys imported from the same export facility in the Philippines that was involved in the episodes in the United States. No humans were infected.[18]
Ebola2.24,POINT (-95.712891 37.09024),1990-01-01T00:00:00,-0002-12-29T00:00:00,USA,37.09024,-95.712891,REBOV,0,0,0%,REBOV was introduced once again into quarantine facilities in Virginia and Texas by monkeys imported from the Philippines. Four humans developed antibodies but did not get sick.[15]
Ebola2.25,POINT (-95.712891 37.09024),1989-01-01T00:00:00,-0002-12-29T00:00:00,USA,37.09024,-95.712891,REBOV,0,0,0%,REBOV was introduced into quarantine facilities in Virginia and Pennsylvania by monkeys imported from the Philippines.[14]
Ebola2.26,POINT (121.774017 12.879721),1989-01-01T00:00:00,1990-01-01T00:00:00,Philippines,12.879721,121.774017,REBOV,0,0,0%,High mortality among cynomolgus macaques in a primate facility responsible for exporting animals in the USA.[16]?Three workers in the animal facility developed antibodies but did not get sick.[17]
Ebola2.27,POINT (30.217636 12.862807),1979-01-01T00:00:00,-0002-12-29T00:00:00,Sudan,12.862807,30.217636,SEBOV,34,22,65%,"Occurred in Nzara, Maridi. Recurrent outbreak at the same site as the 1976 Sudan epidemic.[13]"
Ebola2.28,POINT (21.758664 -4.038333),1977-01-01T00:00:00,-0002-12-29T00:00:00,Zaire,-4.038333,21.758664,ZEBOV,1,1,100%,Noted retroactively in the village of Tandala.[12]
Ebola2.29,POINT (21.758664 -4.038333),1976-01-01T00:00:00,-0002-12-29T00:00:00,Zaire,-4.038333,21.758664,ZEBOV,318,280,88%,Occurred in Yambuku and surrounding area. Disease was spread by close personal contact and by use of contaminated needles and syringes in hospitals/clinics. This outbreak was the first recognition of the disease.[10]
Ebola2.30,POINT (30.217636 12.862807),1976-01-01T00:00:00,-0002-12-29T00:00:00,Sudan,12.862807,30.217636,SEBOV,284,151,53%,"Occurred in Nzara, Maridi and the surrounding area. Disease was spread mainly through close personal contact within hospitals. Many medical care personnel were infected.[11]"
'
]

{ #category : #sources }
RTGrapherExample >> exampleAgeOfRoassalAndTrachel [
 
| methodsRoassal methodsTrachel greatestAge b ds |
methodsRoassal := RTObject withAllSubclasses flatCollect: #rtmethods.
methodsTrachel := TRObject withAllSubclasses flatCollect: #rtmethods.

methodsRoassal := methodsRoassal select: [ :m | m numberOfLinesOfCode < 300 ].
methodsTrachel := methodsTrachel select: [ :m | m numberOfLinesOfCode < 300 ].

greatestAge := (methodsTrachel , methodsRoassal collect: [ :m | m date asUnixTime ]) min.

b := RTGrapher new.
b extent: 300 @ 300.

ds := RTData new.
ds interaction popup.
ds dotShape circle color: (Color blue alpha: 0.3); size: 5.
ds points: methodsRoassal.
ds x: [ :m | ((m date asUnixTime - greatestAge) / 3600) asFloat ] .
ds y: #numberOfLinesOfCode.
b add: ds.

ds := RTData new.
ds dotShape circle color: (Color red alpha: 0.3); size: 5.
ds points: methodsTrachel.
ds x: [ :m | ((m date asUnixTime - greatestAge) / 3600) asFloat ] .
ds y: #numberOfLinesOfCode.
b add: ds.

b axisX numberOfTicks: 4.
b axisY numberOfTicks: 4.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleAgeOfRoassalAndTrachelIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleAverage [

| b ds |
b := RTGrapher new.
ds := RTData new. 
ds dotShape color: Color red. 
ds points: #(5 1 20 8).
b add: ds.
b addDecorator: (RTAverageDecorator new withLabel; labelConvertion: #asFloat).
b build.

^ b view
]

{ #category : #sources }
RTGrapherExample >> exampleAverageAndStdev [

	| b ds |
	b := RTGrapher new.

	ds := RTData new.
	ds interaction popup.
	ds points: #(600 470 170 430 300).
	ds barShape width: 20; color: Color lightGreen.
	b add: ds.

	b axisX noLabel; noTick.
	b axisY noDecimal.

	b addDecorator: RTMeanDevVarDecorator new.
	b build.
	^ b view

]

{ #category : #icons }
RTGrapherExample >> exampleAverageAndStdevIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACvElEQVR4XuXbX0vCYBTH8d6w
b8ALBRUE30EgeCmEIAQD0QvF6qoEh0r+uUkowa5EcILaWXsGK7MpwjY39/3F4WFtOtqH7em4
eWOa/EQpN/xDwAfhhw/CB+GHD8IH4YcPwgfhhw/CB+GHD8IPH4QPwg8fhA/CDx+ED8IPH4QP
wg8fhB8+CB+EHz4IH4QfPggfhB8+CB+En3iAFAoF0TRN8vm85HI5qdfr4qzbbDZiGIaokX+o
LwTSbrclkUjYGJlMxh6ddcvlUmazmajx2Os/zBfr5/an1DIfxEPUGaDG9Xotqg7Xi5VTr+eD
XHgO4YNEDOT19Uvu7+VoNYfPsg+ilk9tH/UaDkX4IHwQPggfhA/CB+GD8EG8g1QqFanValIs
Fl079W7XkGp16xnkWuBCB+l0OvbHI9ls1rVTf3iYy92dwQe59CVLnQ1unbpflyy/QWpP7/Z7
OqWW+XNIiCBBnXF8ED4IH4QPwgfhg/BB+CB8kFiCjMdj0XVdms2mNBoNGQwGfzp1XV9HslOP
LUi5XJZUKiXpdNq0yh73O/XHx89IdupB7Td0EPVxyXa7lVarZZ8lu91O4nTJujqQuM8hfBA+
SLAZjb5E0+RotcZ//2C17GW7cyuo/Vr/4wjiMSC/HxcKa798ED4IH4QPwgf5TalUsrvz+Xzu
2qmvVquTT7/7fWDC2i4yIOrrCL1eT5LJpLh16n49/c4HOTMKoN/v20+buHXql75k4UGiNofw
QfggfBA+CB+ED8IH4YPwQfggAYE499QPf8/v1EMCOezQ9zv1yWRi3bQZynQ6da236du/usbt
nFosFuHfD3HuqZv8RH8O4YcPwgfhhw/CB+GHD8IH4YcPwg8fhA/CDx+ED8IPH4QPwg8fhA/C
Dx+EHz4IH4QfPggfhB8+CB+EHz4IH4QfPgg/fBA+CD9n5Rv6/4j1KSpjNgAAAABJRU5ErkJg
gg=='
]

{ #category : #icons }
RTGrapherExample >> exampleAverageIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACuElEQVR4XuXczWrCQBiF4d5s
F/YC3PoD6tatuPQGBBeC4g9u9BIUQSlVURRFFyKoJ3UCQis6sVab1PfALEoN6DzJTL5MkhfH
4SdIeeF3AR+EHz4IH4QfPggfhB8+CB+EHz4IH4QfPgg/fBA+CD98ED4IP3wQPgg/fBA+CD98
EH74IHwQfvggfBB++CB8EH6CD7JarbTf7zUcDmX+3m63Mo3fpT4eIZlMRovFQvP5XJ1Ox23H
//X7fafdbmM6Uh8f0uurfAOJRqPK5/OKRCJqNpsqlUpu+/qZAwr/iAnSHMIH4YPwQfggfBA+
CB+ED8IH4YM8CchgMLhYqfNBfAAJh8Nup5+r1FutFr+H/wqkVqs5lUpFsVhMjUaDX6nz5xA+
CB+ED8IH4YPwQfjhg/BB+PkzENuaOh/EBxDbmvqzV+qj0cj9vcvlUqYFolInr6mnUin39+Vy
OdXrdfHnEJ+TTqdVLBZldszTnTGwIIchzaE0HYI9QvT+LoVC4k/q/CGLD8IH4YPwQfi5A8h0
OtV6vXY7fTKZiA/iM0gymdR4PJa58dos5Z5g3FypP+sZ1MNBstmsWxBVq1UlEolvHWjOyflH
CH8O4YPwQfggfBA+CB+ED8IHAYG4dcXbGx/n0SBfq/PTSn2326nb7d6EYLbdbDaYbe8GcqzQ
z1XqvV5PZmnTLPX+tJXLZRUKhX+37fGGD99A4vG4e+f7uUrd7C2z2eymL0jb9uFziG0o84rX
BUuv/OZVH7aHjy7l3q8YeQiIbSjziu2C5TW5dFvSNbn08JFXbK8YCQSIbSjziu2CpS3X3Jbk
ta3t4SPbzuf1ipHAnPbywwfhg/DDB+GD8MMH4YPwwwfhhw/CB+GHD8IH4YcPwgfhhw/CB+GH
D8IPH4QPwg8fhA/CDx+ED8IPH4QPwg8fhB8+SJDzCdJH+DKX7bt+AAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleAverageWithName [

| b ds |
b := RTGrapher new.
ds := RTData new. 
ds dotShape color: Color red. 
ds points: #(5 1 20 8).
b add: ds.
b addDecorator: (RTAverageDecorator new withLabel; labelConvertion: [ :aValue | 'average = ', aValue asFloat asString ]).
b build.

^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleAverageWithNameIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADHklEQVR4XuXczUsqURjH8f5O
V25a2F63qZBu3Wq0CsSNILgI0krd6EJw6wsolYovkeRCBOuZO+eA0BU94/VqTn5/cIioE835
nHl55oxzZln8uCln/CHgg/DDB+GD8MMH4YPwwwfhg/DDB+GD8MMH4YcPwgfhhw/CB+GHD8IH
4YcPwgfhhw/CDx+ED8IPH4QPwg8fhA/Cj/tBptOpfH19Sa/XE/X9YrEQ1fhDesQ9JB6Py2Qy
kff3d2k0Grotf9bpdKx6vY4ZSHl9FTk/l6OBBINByWQycnl5KeVyWe7v73X7/js2Cn+PcdM5
hA/CB+GD8EH4IHwQPggfhA/CBzkRkG63u7FS54McASQQCOhBX1epVyoV/gj/FMjT05P18PAg
oVBISqUSv1Lnn0P4IHwQPggfhA/CB+GHD8IH4efHQExr6nyQI4CY1tRPvVLv9/t6ez8+PkQ1
V1Tqp7Cm3mw29f8+Go0kl8uJel4gFouJvY2Sz+fF7/dLtVoVe4LJYDCQRCKhtysajeqvt7e3
UigUhH8O2VNSqZTUajXxeDyiJtnNzY0kk0nx+Xxqwller1eKxaJu8/lcXl5e9HYptLu7O91n
dTK6FsQ+pFm/ub29vUk6nd5qO8QOdg+R52exp7DwT+r8y14+CB+ED8IH4WcPIOPxWGazmR70
4XAofJAjg0QiEV0oqUJKLeWuYOxcqZ/qFdTBQa6vr3VB9Pj4KFdXV38NoLom5+8h/HMIH4QP
wgfhg/BB+CB8ED4ICETXFRcXfJxDg3yvzlcr9c/PT2m1WjshqL5qIYjSd28gywp9XaXebrdF
LW2qpd5/bWoZNZvN/rq+ywc+jgYSDof1k+/rKnU1W9Rq2y5/l9b34OcQ06HMKU43LJ3yP6/6
MH34aFP2/YqRg4CYDmVOMd2w3CabHkvaJps+fOQU0ytGXAFiOpQ5xXTD0pRtHkty6mv68JFp
8jm9YsQ1l7388EH4IPzwQfgg/PBB+CD88EH44YPwQfjhg/BB+OGD8EH44YPwQfjhg/DDB+GD
8MMH4YPwwwfhg/DDB+GD8MMH4YcP4ub8ASxv3uJpWgWIAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleBarAndCurve [


| b ds |
b := RTGrapher new.
b extent: 400 @ 400.

ds := RTData new.
ds barShape color: (Color red).
ds points: (-3 to: 3.1415 * 5 by: 0.1).
ds y: [ :v | v sin ].

b add: ds.

ds := RTData new.
ds noDot.
ds connectColor: Color blue.
ds points: (-3 to: 3.1415 * 5 by: 0.1).
ds y: [ :v | v cos ].
b add: ds.

b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleBarAndCurveIcon [
	^ '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
DqzquEBjAy0AAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleBarsAndDots [

| data b ds |
data := (-5 to: 5 by: 0.1).
 
b := RTGrapher new.

b extent: 300 @ 200.

ds := RTData new.
ds points: data.
ds y: #cos.
ds barShape color: (Color blue).
b add: ds.


ds := RTData new.
ds points: data.
ds y: #cos.
"ds barShape color: (Color blue)."

b add: ds.

b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleBarsAndDotsIcon [
	^ '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
UYtIR/UAAAAASUVORK5CYII='
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
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAALNElEQVR4XuWdyVNUyRbG/Wvs
3r1Fb3vavlWzYmG40OjWNmyn1xrQoSHgrCCKihOoiLMgDqGCIsisouDUKihCGw6IEyoIzue+
/CVkecUqKJuCKjjnREbduvdyNfKrzC/PkOeO8bzhkePHj0tHR4dwfOfOHVm8eLGcO3dOsrKy
ZNeuXXLmzBlpaWmRoqIikbIy8caM8YazSVKSeDEgY4brH2ptbZVbt25JXV2dIACyf/9+mT59
uuzZs0dWrlwpVVVV8vDhQ/2AxJoASE5OjhesjXaJWUA8pTKiRoh+QAYp79+/t7xQUFAgp0+f
lnHjxsmWLVvsr990sOUOCP3evXty7do1S/BR45Affxz9HAIQTU1NlrD5DpE7QA4ePCg7duyQ
2tpau7K6ePGibNiwQQ4dOqQfkGjI27dvbQd0d3fbz48fP0pXV5fon7L0k7p+QMIBBEPS3/QD
EkRKSkqkurpa6uvrLUljaQe7j/MvXrzotxPPnj1recN/7tWrV4Epq23sWM/f5PvvJZot5gDJ
y8sTiHj27NmB/1xhYaE9ZrW0fv16mTJliuzdu9eemzt3rgUMAJ89exa4j88TJ05IRkaGfd7C
hQvtKgyrffPmzZboo0HqA7ZYHCG4Pl6/fh0AJDs72/RdmXf16lXrEiktLZWGhgZZsWKFvYfO
5ntlZaUsWrRIuI/zBw4ckPPnz8uVK1eEUdfW1iY3btyQ27dvB0ZI4V9/ef4mFRUSzaaeQ7BH
/E0/h0QZkEuXLnmuqVxl1UiN5BvdbfSK0TKvRwMkLGftr7RVWmWb0S7pCutX2y7t4v83yo26
Z/ULyC+/eK55ycnht7KykQ1It3TLAqOZRpO9ZK9O6mxnxUu8/MfoJqPLje4w+sQon1zPldye
vzE6yWi60TSja4zS6Vx/YPSE0dVG/zB62ijXVho9ZJR/wz1/ltEMozxrUKQOKKNhhNRLvZw3
Sify/W/5246SWqmVCqMA9cLoDaP8wiuNHjN61SidzL107n2jDUYZGZxvM8qzeC73nzHKMxhl
gLXd6CWjPP+5UfUjJJIP65ROicTf6OeQGCT1Bw8eBEK++gEZhFRLtbQYhS/uGPWPgGZplnBG
EYDkp6aqGx0RBaRIiqTKKDxhLAdZbDTP6C6jgMTqDY55afSA0TdGWUywCCgxus7oSaOFRu2U
FRenH5DBSpM0WeKH2AEEMPYYdR0OKHQ697Ja+6/R/xkFBFZpt+WTpV7522/6AYmGsEoLNmUR
tCK4pR+QGCF1T6mMuDSgkdaiCgjxcGLmycZAw/vLudTUVFm9erVkZmbapAZiHrjtK4wH9fr1
69ZF/+TJEykuLrbL3GhlLsaK2z6igOTn51tANm7cKA4QeGDfvn22w8kwIRbi4ihLly614L15
88Z+v3nzZtSyTkYlIPqnrBibsvST+igndTe16QdkkELyGyROZjtJcoRqZ86cKdu2bbOkbQw+
IUYPpxAWJrRLfP3Ro0fhccgId7EPKyAkvpFRAiDbt28PkDtkTyIEqaXuXmLoNFZnADJjxozw
Mhf1AxJZcVmLyLt37+yxy1bRP2XpJ3X9gIQDiMbRMayASGenSHq6SEGByO7dItXVIqWln3W6
+DIXq379Vf8IGTIwystFSkpE/vxTpKFBhH2GZgSYJZiYFYBIdraI4RAxlrr0Zi4SD9EPyFAD
U1/fkwlowrNmvSuSkSHS2Chm6dUDjAHEjZC8tDT9gMQSh7BrVz8gMQQI0UJjJOoHJJJSU1Mj
eIB3GxLHWsc4xADEcCSrpD9AihIT9YdwI2mtL1iwwFrr/tjImjVrbEwEUPhMS0uzIOFOmTVr
lqxdu1bGjx+vP8lhqISNPWw7cKOBbQmcAyD8V5s2bbK+LGwOzj1//ilzUf8IiYJ0dgbP0dLP
ITG6ytKfuRghYfqhM9mHSIUftrW5a+yUCgcQpqxbWVliHvJlM8/UD0gYUoZBZ+IcuNnZM0ih
AAcCsRC2uEHoO3futPGRyZMn23gJwHEvQAKefvd7BIWkBkh669atAUAQ9h8mJSXZBAhc7WSb
zJkzR+bPny+nTp0SV9nBjZCH33zjdXz3nchPP33ZcnL0j5BIysmTJ21JDXbfhpqyAJUVmH4O
iRFS95RKVABx+9ad3REMECKG+u2QQUiorMXLly8Hph+MRKYrrHT2psMbGIhHjhwR3Czsaeec
flKPgITKWoyLi7OdDJEDhqsGceHCBcshgEOdLIoQABpFBfQDMoRCtdF/wyH6pyz9pK4fkIFG
iL9pGS3/GhCy2Ulso6gM1ja5VtS1IvsQDrl79679zpaD+/fvCxXjMA6JhcA1NI5JnINr4BiO
P3z4oL9wwNcKlnVzc7NMnTpV2tvbLQC4Q1hVQdq0lJQUu3o6evSotdrN6ssGqliFOUBcXARS
h8ydsagfkCESV5DMCTUVXY3FvuLqLeqfsvSTun5AwgEEY9Lf9APyFULkj21rFEMmlk4MBMvb
n1TtjEUnEH7fcy4gZQNU337r+Zv8/LOE1Ua4J3jQgBADIfZBDIRCyM7lDjDx8fGSnp5uV1eQ
N4sBXClUtYbUOcffEg+hXiMxE+Ip+kk9AoLbg70eFb31CQGGJWzvCsu63LmH6wSsOAdArtai
q9foRkhRQoLnb+QBh9VGeDQxpmPq/qafQ6IMiMbg1LAC0jeLkfysUNmLAHJx1Sr9gAyFhMpi
dKTOJ7EUYuuPHz+WSZN6ai62/v67fkCGUoJlMbIb15E6Ky39I0Q/h+gHJFxAtFW0HjJASHTD
UndZi5xzxWVc1iJvRXj69OkXlvpnrhNX853tcH3bP//oz8saSNhSQDzj2LFj9peNYYhLHRc7
2w6w5DlOTEy02w/wTx0+fNha78RCuIdP/ZmLERQCTbw3hIAUgODfgrxZ7uJGIQGC6g4Ak5CQ
YFNJOSbYRVZjWa+X105ZY8d6NPnhB/miGReLfkCGmUO0eXljHhBPqQwpILzztr8sRXfNiX8H
lcYUoLABaWxstCsmf2Yi0wlhVww+3pLDqglCxkWCa4R7WFWRBAGPwBVcd+8x5DqWOs9xWYu5
ubmfEuVSUvQDEkpwo9PpdCbWtgMEEMg4IRmOZAdc6I6kcbtzTAIDMQ++c53vBKLYX8j2A+5x
WYskSti3SesHJPY4RP+UpZ/U9QPSHyD6C5h9hfTNWiQhDh7AIMSDu2TJEmvk4cWFE1y1uAkT
JgRIHS5xb4tmexsJEWFnLuq31D9JsKxFfslY2hA+1jgdSyJDcm/HsXKaNm1aIIWUtFJX1YFs
xYkTJ9q/AcCwMhf1AxK+0NkEpVwmov/YORkR/3Xeu86x+9Q/Zekndf2ADASIxneHRBwQMhix
xol3EEd3Lx3u+1boUOJ/W3RHZqb+ETIYwe2BtQ0QfMf9DoFj4Tu3CasyeAI3CXtDWJlB7Lwl
gb/h7QiBt0Xrt9QjJyx/yVDkTdJ0PD4tYiNlvS99xKmIf4yVlXvTNFkpn01ZxcX6AYklDtFY
CSimAdGfdRJCgtVN5BVFfe/DKHTH/nJMfaW/jnZJD/rzsoLIQHUT2fzPvkHc6MuXL5d58+bZ
eAaukIyMDHuMtc4xz8BFz3di6WQovnz50v4drpZVpvNxr2AIupqL+jMXQ0iwjEPAKS8vtyRN
0gKdynaDdevW2Y4n8geRQ9iMCDJRIHeI3j9CiKcQ+GJZzHPdNf0jZJC2hzsONpXp55BRQuqh
CmSqB8SfiQiv4JENZnkzPbnjln52MTFNDUT4doSUlOi3Q/wSLBORmDgrLa5B7OwfJPsQC9wV
RmYzJ/cRI4FTli1bZmstsrcQNwrbDVgkEPcgJgIIxFe4Dys9kLmo1FL/P7OKbCEdHLTCAAAA
AElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleCrosses [
 

| b ds |
b := RTGrapher new.
b extent: 300 @ 300.

ds := RTData new.
ds dotShape cross color: (Color red alpha: 0.3).
ds points: (RTShape withAllSubclasses flatCollect: #rtmethods).
ds x: #numberOfLinesOfCode.
ds y: [ :m | m getSource size ].
b add: ds.

b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleCrossesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAF40lEQVR4XuWdS0hUURjH3bSo
FkGLllFt2rVsV1Btkh64qlUQlBBEi4o0pXy7CAqEEDIkqcCN+AhfqOVroaMYuvFFqYhvUUfF
FBX/0/3O9Y7TPHRmcu7ce/8fHM68zjDz/eY73+OccyfB4+EXK0kCvwr4gfALPxB+IPzCD4Qf
CL/wA+EHwi/8QPiB8As/EH7hB8IPhF/4gfAD4Rd+IPxAAmVychIrKyuQXu7v7Oyofm5uDk5U
EhYWYGkgg4ODWFtbQ0VFBUpKSrC8vIysrCxkZ2f/88HdbrdnaGhI9baF8f078PYtRCwLJC8v
T304TdmYnp5Wrbm5Gfn5+QEfemxszPZWg58/4Rgf4gQgjnLq/ED4gfAD4QfCD4QfCD8QfiD8
QPiBxD9n4QdymDC05Bg3b0Kye34g/BbCD4Tfh/ADCS5Sdt/e3taq0gswSu6bm5sIVn7nB2IC
kOrqaqXkgoICb9m9rKwMjY2NAeV3l8tl6/K7LYD09vZC1kRSUlKQk5OD9vZ2DAwMID093XEW
oiKnd++svR5iJR+C0VGYAYXfqYerrHv3gNevwR9lEVkIPxB+p84PhB8Iv/AD4QfCD4QfCHp6
wA/EIkBUVn3jBsxM5PiBHATl2zfY2XKcZSFakojnz+GfLBr1KMcCkVK79PPz8zB2wsv9eJbf
DQi+FuILCIuLzgVSWlqqzQA9KCwsxPr6Ora2tkLufjer/B6qpoWPH+F4HyKl9vLycqSmpiI3
N1d9YTN3v/v6A+O2sgJpjx/rfQhfwu9DDhGIUrSfP8CtW17LUM9fv66/Jogv4QcSJRC8ehU4
9WhKl2lJ3db8AX790lttLYJFWZiYsGW0ZTkgqKgAzp2D9KEct7r99StUiyDnsEO0ZU0LCeNX
rKxEmiyvRgLF4tFWXIHIYcpgCkJR0cFAxHlrzeMwiS+QIEpVjvnZMz1S2vUDXr/gG13tWgg/
EBMs5J+kzoiYxLfYJNt2jA/xh+MfMfk+D5cL0viBxAiI2vi0j4NWlvLmzR6Qly8hjR9ILC0k
RHQljysgL17sAfnzB9L4gcQ6D/F16gaIS5f0XksC7VS5tS0QY5oypiw8eQLvYpNk6Bcvqizd
m6nbeAEqJkDGx8eVQjY2NjAzM/Nfu9+V70hL0wH8+AGMjABPn+q9WIhYyp07MIqH/FFWEJH1
jxFNYf39/ejo6EBfX1/Q3e9LS0vo7OyE9PsCkYu7aDC8jxlR1W7p3K6VW9OAJCUlaTqbQFdX
F4qLi1FXVxd097voWizkoJ3j/pc/kkzdW7klsArrJIYSKWkLXAFO/cEDW5fQbQdEKVtb2ML7
99CWHUOWTjyEEh8gV64AZ84Ad++qFvB8VRXt5rr4ADl2DDhyBPj9W4+mgmTooXaQ8AM5ZCCq
Siu5xdWrqpqLyUmVgftGWd7oS5y7SUfJKIHg0yfg/n0diExbnz8DX77oit/ZofUb8QMiF5R8
+BA4fRo4cQIoKNCbWIu2ju67YYEfiBlAxDKuXdsDkpent+PHgVOngPx8OLksYj0gYglnz+4B
efRIbx8+qCnLwy8mAzl5Ejh6VC8UXriA/VYM+YGYASQhAb6NX/1WASK+5PJlfiCHDcQot09N
TYVU7vDwcCCQ3dLJQe+/7lfnikTsOPa/gPjudne73UFL7PJYU1OTp76+Hi0tLZ6W27cxev68
fjuMVllZ6Qn3tVYZqy1HxMdCjN3uLpcLmZmZQTNqeUyuCx9tti1jo/18dhwbcx8SzpQWSuQw
UDRj5ayK9Iu70Vsk4w1lGgeQIhkrB5dWV1dh/HVHNN85pkDCmdJCiXEYKJqx3d3daGhoQFtb
G2ZnZxHJf5oUaSUcGadZvCfSscY5GXmPSMeaAiScKS2U1NTUqMNA0YxNTk5Ga2sramtr1fJx
RkYGwrXmxMREpcg0bY0/krFydT358cmPsEpbOohkrOlhL7/wA+EHwi/8QPiB8As/EH4g/MIP
hF/4gfAD4Rd+IPxA+IUfCD8QfuEHwg+EX/iB8Iuv/AW9/y7tOrRBIwAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> exampleCursorFollower [

	| b ds |
	b := RTGrapher new.

	ds := RTData new.
	ds points: #(5 10 6 2 -2.5).
	b add: ds.

	b addDecorator: (RTCursorFollower new color: Color blue).
	b build.
	^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleCursorFollowerIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACdUlEQVR4XuXazYsBYQDHcf82
F5G4Kpz4AzhyUDhw83ZC5ERKSQ7Ka95+1jOt2t12t91m1o75fmty8nhmPs0wj/Fdr/zclI9/
CPgg/PggfBB+fBA+CD8+CB+EHx+ED8KPD8KPD8IH4ccH4YPw44PwQfjxQfgg/Pgg/PggfBB+
fBA+CD8+CB+EHx+ED8KPD5LNZpXP51UoFFQsFhWLxfRMB0+3LpeLPAPSarU0HA7V7/cVDocV
iUTe7dx4PHY10G6303a7lScvWcfjUfv9XvxLFj8+CD8+CB+EHx+ED8KPD8IH4ccHeVjmRvS2
8UHcklmHOp1O4oO8ZtaqMpmMdUCSyaT4F6x/Bul0OsrlcjIwm81Gn4E5+XnL5VK3jQ/yVd1u
V/V63VrtrdVq/DOE/yuLD8KPD8IH4ccH4YPw44M8530F/wzhg/Djg/BB+D0tyGq10k838/ho
NBo1X8zy+/36zXvdsnnqDLk/PrpYLDSdTvmLi264ZJl/7fiPkf4BiFlCn8/n1kEtlUq2D26l
UtH91Yxtd7z7nJwYr91u6+OYrgIZjUZqNBoKBAKaTCZar9e2J3g4HDSbzRQMBs1me47pdNr6
E8yJ8cxT+2/38z5XV50hg8FA5XLZgkmlUrYnl0gkrLGq1arO57Pt8UKhkGPjxeNxM87V7Gez
2ZSZK/9nL/87xLm8uAbFP0P4IPz4IHwQfnwQfu4CcfIOmg9is16vp+/uoM0KAB/kwTl5B80H
4ccH4YPw44PwQfjxQfjxQfgg/PggfBB+fBA+CD8+CB+EHx+EHx+ED8KPD8IH4ccH4YPw44Pw
QfjxQfjxQfgg/PggfBB+TvUCoQ9cNP2p/78AAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleDateOnXAxis [
 	| methods oldestMethod b ds |
	methods := RTObject withAllSubclasses flatCollect: #rtmethods.
	methods := methods reject: [ :m | m numberOfLinesOfCode > 150 ].
	oldestMethod := methods minFor: #date.

	b := RTGrapher new.
	b extent: 300 @ 200.

	ds := RTData new.
	ds dotShape circle size: 5; color: (Color blue alpha: 0.1).
	ds interaction popup.
	ds points: methods.
	ds y: #numberOfLinesOfCode.
	ds x: [ :m | m date julianDayNumber - oldestMethod date julianDayNumber ].
	b add: ds. 

	b axisY 
		noDecimal;
		title: 'LOC'.
	
	b axisX 
		title: '';
		labelRotation: -30;
		labelConversion: [ :v | (Date julianDayNumber: v + oldestMethod date julianDayNumber) ].

	b build.
	^ b view
]

{ #category : #sources }
RTGrapherExample >> exampleDateOnXAxis2 [
 

| dates minDate b ds |
dates := Array with: Date today with: Date yesterday with: Date yesterday previous.
minDate := dates min.

b := RTGrapher new.
b extent: 300 @ 200.

ds := RTData new.
ds interaction popup.
ds dotShape rectangle color: Color blue.
ds points: dates.
ds x: [ :aDate | aDate julianDayNumber - minDate julianDayNumber ].
ds y: [ :d | d dayOfWeek \\ 7 ].
b add: ds.

b axisX 
	labelRotation: -30;
	labelConversion: [ :v | (Date julianDayNumber: v + minDate julianDayNumber) ].  
b build.
^ b view
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
	^ '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
0U/6AdFM/wHYRxAyEaJaiwAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> exampleDeviation [

| b colors points ds pts dec lb |
b := RTGrapher new.
colors := Array with: Color red with: Color blue.
points := OrderedCollection new.

colors do: [ :c |
	ds := RTData new.
	pts := ((1 to: 100) collect: [ :i | 50 atRandom - 25 ]) cumsum.
	points add: pts.
	ds points: pts.
	dec := RTDevVarDecorator new.
	dec moveBehind;
		deviation: 0.5;
		color: (c alpha: 0.3);
		points: pts.
	ds connectUsing: (RTLine new color: (c alpha: 0.5); width: 1 ).
	b add: ds.
	b addDecorator: dec.
	 ].

b axisX; axisY.
b build.

lb := RTLegendBuilder new.
lb view: b view.
colors doWithIndex: [ :c :i | 
	lb addColor: c text: 'Series  ', i printString ].
lb build.
b view @ RTZoomableView.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleDeviationIcon [
	^ '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
QmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleDotsLeyendAndImageBackground [

| b ds  title lb |
b := RTGrapher new.
b extent: 750 @ 450.

title := (RTLabel new text: 'Global Sales') element.
title setAsFixed.
b view add: title.
RTHorizontalLineLayout on: (Array with: title). 

(Array with: Color red with: Color blue with: Color green) do: [ :c |
	ds := RTData new.
	ds dotShape circle size: 10.
	ds points: ((1 to: 100) collect: [ :i | 50 atRandom - 25 ]) cumsum.
	ds connectUsing: (RTLine new color: (c alpha: 0.5); width: 5).
	b add: ds.
	 ].

b axisX; axisY.
b build.

lb := RTLegendBuilder new.
lb view: b view.
lb addColor: Color red text: 'Corporation 1'.
lb addColor: Color blue text: 'Corporation 2'.
lb addColor: Color green text: 'Corporation 3'.
lb build.
b view  canvas camera scale:  0.7.
b view @ RTZoomableView.

^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleDotsLeyendAndImageBackgroundIcon [
	^ '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'
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
RTGrapherExample >> exampleDoubleYAXis [

	| b ds |
	b := RTDoubleGrapher new.
	b extent: 300 @ 200.
	
	ds := RTData new.
	ds points: #(4 3 2 2).
	ds barShape width: 40.
	b add: ds.
	
	ds := RTData new.
	ds points: (10 to: 13).
	ds dotShape color: Color blue.
	ds connectColor: Color red.
	b addRight: ds.
	
	b axisX noLabel.
	b axisYRight color: Color red.
	b build.

	^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleDoubleYAXisIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADmUlEQVR4XuXbW0vbYADGcb+Z
CPsKskvxbrsTvNIbQRRPg3oxRRAH0ot65YUXgspQUTyjFbEyL2wd4hQHlpXqPPTJ8sYJKk0T
NW2T/h8IrfYQ8/5M3jyx1lkWP2FKHX8I+CD88EH4IPzwQfgg/PBB+CD88EH4IPzwQfjhg/BB
+OGD8EH44YPwQfjhg/BB+OGD8MMH4YPwwwfhg/DDB+GD8MMH4YPwEy2QhoYGmduuri7Nzs7q
5eOyc3V15SxRHYxUSq/62d22t7m5WQcHB4rFYpqenlZPT48CBTk7O1Nra6vzpp2dnTIoxUC2
trZ0enrqunLznHQ6bZVaqhHF49LKir5/HNFrUH5PThbd3v7+frOp6u3tldt4BXLIur291fX1
teubHx0dlVxxWECUTMpB6OuTLi/fvEdrYaHka29ubpzHS41ZWeeQsIIom30YfIOwsxPYIdUL
pOqTelhAVChI3d36/OGHcl+/lW1O44N4AGhpSRobq9hJBR+kygB8kKevteeAT/Up5WMjoTmt
RoE4E/DiojMZh7W31DTIz+Vl61c8br33VBQBcn9/r5aWFt3d3TlFx22wTTst1dRfgjQ2/rGS
XxIORjWL4Vvz175iUWx7BwYGnO9NTU2pra1NTU1NwfeQ8fFxXVxc6OTkxBUk6KYe1mbv1dSH
h4efFejHy0qBguTzeVW6qYcdxO2QZcbIjNXTr2viLCuqIDV72ssH4YPwQfggfBA+CB+ED1Lb
IKaDTNolyNyfm5vT/v6+gmjqUQdxa+omKftvweZ2bW3tVZ8z8L2HDA4OOm/a0dEhewltUy/3
8/009fPzc/uS3MNFUfOLPDExESyIWYFBWF9f1/z8vMy1rbAesioJUuqQZUDMeI2Ojj5r7bg5
JCwg/EmdD8IH4YPwQfggfBA+CB8kkiC7u7uRaOqVBHFr6oeHh3q8NWNlelzgIBsbG/ym7rOp
JxIJFQoFewda0N7entrb24MH4Td1/4cs88kccw3LjNnq6mrR/6fhzyH8SZ0Pwgfhg/BB+CB8
ED4IH4QP4p2ZmRnPpr65ualsNotv6n7G610gx8fHyuVynk09k8loe3tb5vmEJZlMFm3qfsbr
3XvI0NCQvJq6/sfix9d4lX0O4Sdkkzo/fBA+CD98ED4IP3wQfvggfBB++CB8EH74IHwQfvgg
fBB++CD88EH4IPzwQfgg/PBB+CD88EH4IPzwQfjhg/BB+OGDRCn/ACEOsXsP+FT6AAAAAElF
TkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleDynamicStacked [

| b |

	b := RTDynamicStackedGrapher new.
	b numberOfBars: 10.
	b minY: -200; maxY: 200.

	b y: #yourself.
	 
	b barShape color: (Color red alpha: 0.3).
	b view addMenu: '+ 1' callback: [ b add: 400 atRandom - 200 ].
	b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleDynamicStackedIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACMklEQVR4XuXcvWoiURiA4dyz
FyCIINh6ATZegohgodhoJyo2sRArC0Xt/P8SzsAsy7Ik22R0eV4YzGB3Hk4OnyO+fXz4vVJv
/hL4IH7/AnI+n6Pb7Ya/JE8G6XQ6vyDq9boP8io7ZDKZRLlc9lfEP0P8fBAfxM8H8UH8fBAf
xM8H8UH8fBA/H8QH8fNBfBA/H8QH8fNBfBA/H8TPB/FB/HwQH8TviSDD4TBarVZUKpVot9tR
q9WyL9ql+8fj4X/prmiQxWIRy+UyttttlEqlqFarGUK6Px6P2d+HwyHSl/D8pS7wX9bpdIr8
9Xq9Rn6ft1qtfJBXOkN8EB/EB/FBfBAfxAfxQXwQH+Q/HwzzyfyrSd0HKXiH+JO6P6n7IP4Z
4oP4ID6ID+Lng/ggPogPgoP0er1swafT6V+HQB+kYJDL5RKbzSZ7vp6u39/b7/cxGo1ivV4z
V/p04qkgjUYjxuNxtjtms5m/Q/wzxAfxQXwQH8QH8UH8fBAfxO9HQZrNZqQJvd/vR5rY03P2
/N4HKRhkPp9H+q3fcrmc/cTsn6/5pO4/Uy9wh6SFTx+dDAaDbFfc7/e43W7Zvb9D/DPEB/FB
fBAfxAfxQXwQH8QH8fsJkPf3d39Sf6VJPQ2A303q6fKXusBJfbfbfTmp+73YGeLng/ggfj6I
D+Lng/ggfj6Inw/ig/j5ID6Inw/ig/j5ID6Inw/i54P4IH4+iA/i54P4IH4+iA/i54P4+SA+
iN+3fQIe1z3fETJGzQAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> exampleEbola [

	"Preparing the data"
	| tab data b ds |
	tab := RTTabTable new input: (RTGrapherExample new dataEbola readStream) contents usingDelimiter: $,.
	tab removeFirstRow.
	tab replaceEmptyValuesWith: '0' inColumns: #(10 11).
	tab convertColumnsAsInteger: #(10 11).
	tab convertColumnsAsDateAndTime: #(3 4).
	data := tab values reversed.

	"Charting the data"
	b := RTGrapher new.
	b extent: 400 @ 200.

	ds := RTData new.
	ds interaction fixedPopupText: [ :row | row value at: 12 ]. 
	ds dotShape ellipse 
		color: (Color blue alpha: 0.3);
		size: [ :row  | (row at: 11) / 5 ].
	ds points: data.
	ds connectColor: Color blue.
	ds y: [ :r | r at: 10 ].
	ds highlightIf: [ :row | (row at: 10) > 100 ] using: [ :row | row third year ].
	b add: ds. 

	b axisX noLabel; numberOfTicks: tab values size.
	b axisY noDecimal.
	b build.
	^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleEbolaIcon [
	^ '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
Ifwxffgff5Jw1WkAY5wAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleFunctions [


	| b ds |
	b := RTGrapher new.
	b extent: 300 @ 300.
	
	(Array with: Color red with: Color blue with: Color green with: Color yellow) doWithIndex: [ :color :i |
		ds := RTData new.
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

^ b view
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



| b ds |
b := RTGrapher new.
b extent: 300 @ 200.

ds := RTData new.
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

b axisX noTick; noLabel.
b build.

^ b view
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
	b := RTGrapher new.
	
	"We defien the size of the charting area"
	b extent: 500 @ 100.
	
	ds := RTData new.
	"When the mouse is above a bar, say which class we are point at"
	ds interaction popup.
	
	"Each subclass of RTShape will be a bar"
	ds points: RTShape withAllSubclasses.
	
	"The height of a bar will be the number of methods (defined in the instance side)"
	ds y: [ :c | c rtmethods size ].
	
	"We set a color of the rectangle"
	ds dotShape rectangle color: Color blue.
	
	"Set the width of a bar"
	ds barShape color: Color blue; width: 10.
	b add: ds.
	
	b axisX.
	b axisYWithNumberOfTicks: 4.
	
b build.
^ b view
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
RTGrapherExample >> exampleHistogramWithNegativeValues [

	| data b ds |
	data := (1 to: 20) collect: [ :v | 10 atRandom - 5 ].
	 
	b := RTGrapher new.

	b extent: 300 @ 200.

	ds := RTData new.
	ds interaction popup.
	ds points: data.
	ds barShape width: 8; 
	      color: (Color green alpha: 0.3);
	     if: [:value | value < 0 ] fillColor: (Color red alpha: 0.3).
	b add: ds.
	b build.
	^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleHistogramWithNegativeValuesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAD+0lEQVR4XuXbzU7iUBiHcW/O
W/EOXJmIH9GFC5fGRHeuTFyocWEgiooGiRkM+B1HUwwgxAQDOpqoeZm+xympTtFSqQPz/Jum
B9LTlvOjPRwoPfU6P52UHn4T8EH44YPwQfjhg/BB+OGD8EH44YPwQfjhg/DDB+GD8MMH4YPw
wwfhg/DDB+GD8MMH4YcPwgfhhw/CB+GHD8IH4YcPwgfhp7tBZmZmJJFIyPPzs4yMjIjXOk9P
T/Lw8CC65Dd1yCBiZ2trS25ubiSfz3s2eK1Wk7OzM9Gln20uy7Ls2xMfJEBeXl7EOQseHx+b
NmKlUvHdwHyQb+hD+CB8ED4IH4QPwgfhg/BB+CD/AsSN8L58ak85e9LyL3vigzTJ0dGRTE1N
mQYaGBiQ+fl5mZ2dFa+RerFY/HCkzgdpA4iO0re3t00DraysiA4SR0dHJchInQ/SxkuW+53f
7CzgX7L4fQgfhA/CB+GD8EH4IL5BYhIz67TrmN3b02XanvggfBA+SFeDZDIZ2d9/bbxmP+Hq
2OT6+jr0kTofxM75+bnorOXJycnAv6nzQdoEomdHNpuVnZ0dmZ6ebnrAlmUFvmTtVfcCg9ze
3gZulMXaYmCQr+z3W/qQZDJZz+VyUrDxyomEaLmUTDbKUSsqKSvlWV7dW61nrawp/7R+mue9
5rgVN+u4n0ulUnX3Y92fHkOzbbjnhR8LdWd7uty1dhvbKKbTb9bNHx+b568uLszjw8PDzgZx
zhA5PRVZfn3XSSzWKIf1bntfV/enx/CVd7nZRvrt2SJXV+a1yP29dPQZojfQ6ayfsgqFgrQC
Uq1WRWcta91W9nt3dyflcrlRxyn7AdG6ep+Z3tznrusHpGJ/sPHab8eAaGeu88nJiTnQVkDm
5uZkY2NDSqWStPrCJiYmZGhoSIaHhxtLvyBad3x83OzXXdcPSGxpyXO/HQMSjUZFZ+30BwcH
WwJZW1szde3+x9Rt5YNGb2+vubVV76pcX1+XsbExXyBOXb1FVvftrvsZSMZeL9Lf77nfrhgY
+u1D2plW+pAPt/FJH9KVI3U+SAggTmerHbde7/Xy4nTE7pG612/qfJA2g+g10v14c3NTP/eb
mx38jNT5ICGcIfF43HS+CuGUDw4OxNclyx5EfbVx+CAhfdvLB+GD8EH4IHwQPggB5DvCB+GD
8EFCA7m8vDRfVevv6/ZYJNDd73yQNoHoILCvr898sxmJRHT+ax0doSuI3/+phwryJ//9JUv/
o+58n1Xnp/P7EH74IHwQfvggfBB++CB8EH74IPzwQfgg/PBB+CD88EH4IPzwQfgg/PBB+OGD
8EH44YPwQfjhg/BB+OGD8EH44YPwwwfhg/DjK78B7gqeCFF7BtEAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleLabelledBars [


| b ds |
b := RTGrapher new.
b extent: 500 @ 200.

ds := RTData new.
ds interaction highlight.
ds points: RTShape withAllSubclasses.
ds barShape width: 10.
ds y: #numberOfMethods.
ds barChartWithBarTitle: #name.
b add: ds.

b axisY.
b axisX noTick; noLabel.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleLabelledBarsIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleLabelsInBar [

| b ds |
b := RTGrapher new.

ds := RTData new.
ds barShape.
barElements := ds points: #(1 2 3 2 1).
b add: ds.

b axisX noTick.
b build.


ds barShape createdElements do: [ :back |
	someElements := (RTLabel new color: Color red) elementsOn: (1 to: back model * 3).
	b view addAll: someElements.

	RTFlowLayout new maxWidth: back trachelShape width; on: someElements.
	someElements translateTo: back position.
	(RTConstraint  on: someElements background: back)
		top ; center ; inner; padding: 5; move.
].

^ b 
]

{ #category : #icons }
RTGrapherExample >> exampleLabelsInBarIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAABwUlEQVR4XuXavYrCQBSAUd//
NcTW3krBEMFOIiRWBl/An0JS3UjCVq6Fu7jrmPPBYCMhMwenuDhqW7+UGvlH4IP4+SA+iJ8P
4oP4+SA+iJ8P4oP4+SB+PogP4ueD+CB+PogP4ueD+CB+PoifD+KD+PkgPoifD+KD+PkgPojf
MEB2u110n3meh3+cCYCUZRnX6zUmk0k8wprP5/+2mcPhEPv9vr1fl8sl/CvrKx/EB/FBfBAf
xAfxQXwQH8QH8UF8EB/EB/FBfBAfxAdJBaSu636zq9Xq26arqnrJcPF0OsXxeGzvV9M08RuQ
Z5/3kSCLxSLO53Os1+v4q1/Iswf96u/5V5YP4oP4ID6ID+KD+CA+iA/ig/ggPogP4oP4ID7I
sECyLOs3MZvN/FlWCiDj8bgfLk6n0x+DvOugU4Z765Xlg/ggPogP4oP4ID6ID+KD+CA+iA/i
g/ggPogPMnCQoij6l9tut/4sK5Vpb9dyuXz4V9IObLPZMKsbtCZ9Zfn5ID6Inw/ig/j5ID6I
nw/i54P4IH4+iA/i54P4IH4+iA/i54P4+SA+iJ8P4oP4+SA+iJ8P4oP4+SB+PogP4ueDfGI3
wxBGiYmHNxEAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleLinesAndBars [

| b d |
b := RTGrapher new.

d := RTData new.
d points: #(3 4 3.5).
d barShape.
d noAlignmentOffset.
b add: d.

d := RTData new.
d points: #(3 4 3.5).
d connectColor: Color red.
b add: d.

b maxX: 5.
b axisX numberOfLabels: 5; noDecimal.
b
]

{ #category : #icons }
RTGrapherExample >> exampleLinesAndBarsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACvUlEQVR4XuXcz0vCYBzH8f76
/oOIoEvHqINgh6BDIYiX1cCDUB60sOksdYRIB/0sH2GRyye3NXX1/sCDP3im43m559kX5vbC
kJ8iZY8/BHwQfvggfBB++CB8EH74IHwQfvggfBB++CD88EH4IPzwQfgg/PBB+CD88EH4IPzw
Qfjhg/BB+OGD8EH44YPwQfj5OyCj0UjmsdfriT+cOwYxCLVaTZ7nyff9byCDwSBXpDn+Uhtc
XYVvJyeKv8+fsuaZTqffBl/z5LmzrVbrs/kHB5/Pn6rV0Ds7Cx/v7hav+SCWbArkZX9/CWcJ
6vAwVKkkPsg2QO7vw+eLCytG1BbffXMjXV4q733gg0SfdXsr7/x8LUZ8ytL7u3R9Lbmu+CA5
gchxpCBQEoyvIPHF/vX4WOZEpMgnAYUH0empVi3qSUDS9ueDrNv+6Ei2syw+yBZBFvP+fM34
6bSXD2IZ8KggXFWpZwExEKpWta4O4YPYa4PMlXp8ce12u6H/8GBddPkgCTKbzWRalkp90wPM
X0P4IHwQPggfhA/CB+GD8EH4IHyQ/1mp9/v9zJU6H2QDR4iBsFXqw+GQD7KrKYtfqfPXED4I
H4QPwgfhg/BB+CB8ED4IH2RbIEEQ8Cv1IoHU63V+pc6v1Pkg/DWED8IH4YPwQfggfBA+CB+E
D0IGiSp0fqVeAJCoQv+pUjdXwNta/Cp30z/+3uL/6Jb+tpa1fx5t50eIqdCzXv3+2/7/Mfx7
nZBAHMdJ9YtvNBqp+jebTaWdYs3RnLR/p9NJ9fmrpu1CgVQqlVQ7WEp5B4ZyuZyqf7vd1mQy
SbyN67qKbq6TJObfZOPxWPwpiz9l8cMH4YPwwwfhhw/CB+GHD8IH4YcPwgfhhw/CB+GHD8IH
4YcPwg8fhA/CDx+ED8IPH4QPwg8fhA/CDx+EHz4IH4SfDPkAjjgATwwDm+UAAAAASUVORK5C
YII='
]

{ #category : #sources }
RTGrapherExample >> exampleMarkerOnTheXAxis [

| b ds |
b := RTGrapher new.

ds := RTData new.
ds connectColor: Color blue.
ds points: #(3 4 5 6 7).
ds x: #yourself.
ds y: #yourself.

b add: ds.
b addDecorator: (RTMarkerOnX new value: 5).
b addDecorator: (RTMarkerOnX new value: 6).

b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleMarkerOnTheXAxisIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADFklEQVR4XuXcQUtqQRjG8VZ9
jL5my1q6qYULaREItYoKC1clolJqauZChMhCQRQRFLV7E0oer3PAS2HIDc/VOef/gKsDwzg/
3zPH16mNyYQfm7LBXwI+CD98ED4IP3wQPgg/fBA+CD98ED4IP3wQfvggfBB++CB8EH74IHwQ
fvggfBB++CD88EH4IPzwQfgg/PBB+CD8eAMkEAio3+8rmUzq5uZG/OVcM0g4HHYQHh8fVS6X
v4C8vb2p1+vxkVYJ0ul0VKlUVK/Xlc/n5xafD2LZHuJ3kNfXV/FBLMndnVQs8kHWnvFYuryU
+LcsS6pi+vwi/h7i86rgg1hWFXyQf6yKw8M2/7GXWBV8EAv2Cj6IxVXBB7GsKlwDCYVCzhsx
nV7T8f18zTQX2+221SDX130rqsI1ENN6L5VKisViurq68kxzcVYVHx8f1s0Pd8uyZa/Ag5iq
uLiQ9XsaAuT21u6qwIAMh791diZPfRfyLcj0wU+ZzC/PdQp8B2L2Cq9VhW9BTFWUy/J0h9kX
IF6vCl+B+KEqfANyetqa+C38bq+fQJ6enpwFz2azGgwG/INy6waZdXhzuZxOTk6+LH6r1dLz
8zMfZJUgOzs7E9Pljcfjc2d7+RXC30P4IHwQPggfhA/CB+GDUEG0v79wftrbEx9klSBbW1rm
Oh+ED8IH4YOsCmN3V2bBdXyshdePjuQZkGAw6Ew2nU5Pf7/OeKp1ovNzaXNTenjQwuvFondA
3t/fZZqI1WrVeX2+NhqNVKvV1O12XXs1m01Xxxttby+8Pm3WTX4ynhsfwKVAUqmU83fq9/f3
KhQKc5Mx53vd/PS4PZ750Ng2Hv9/nRC+GM5Ow5sfrb6rnJ9mOBzq4ODAGefl5WXp8SKRiEy1
uTU/k9lh82Xn919AZqfhzcn4RCIhN4ANinl4ML+9LDteo9FQNBp1bX7j8fjvw82y8+Pfsgi3
LH74IHwQfvggfBB++CB8EP4S8EH44YPwQfjhg/BB+OGD8EH44YPwQfjhg/DDB+GD8MMH4YPw
wwfhg/DDB+GD8MMH4efb/AE7UEBHDfiIBAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> exampleMethodSize [


	| b classes normalizer |
	b := RTGrapher new.
	b extent: 400 @ 200.
	
	classes := RTShape withAllSubclasses.
	normalizer := RTMultiLinearColorForIdentity new objects: classes.
	classes do: [ :c |
		| ds data |
		data := ((c rtmethods reverseSortedAs: #numberOfLinesOfCode ) collect: [ :m | m numberOfLinesOfCode ]).
		ds := RTData new.
		ds dotShape ellipse size: 0.
		ds points: data.
		ds connectColor: (normalizer rtValue: c).
		ds y: #yourself.
		b add: ds.
	].

	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.

	b build.
^ b view
]

{ #category : #sources }
RTGrapherExample >> exampleMethodSize2 [

	| b classes normalizer |
	b := RTGrapher new.
	b extent: 400 @ 200.
	
	classes := RTShape withAllSubclasses.
	normalizer := RTMultiLinearColorForIdentity new objects: classes.
	classes do: [ :c |
		| data ds |
		ds := RTData new.
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
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleMethodSize2Icon [
	^ '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'
]

{ #category : #icons }
RTGrapherExample >> exampleMethodSizeIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAGmElEQVR4XuWca2/TSBSG+Yn8
CX4EEhIXCbRC4gMf+Y7g0wLa7iLovWyFSsuqS4HQNGmbNvf4bie++83O2CRtaZs2IkmzvK80
amynHmUen3PmjGfmWrfLr2nSNf4m4AfCL34g/ED4xQ+EHwi/+IHwA+EXPxB+IPziB8IvfiD8
QPjFD4QfCL/4gfAD4Rc/EH4g/OIHwi9+IPxA+MUPhB8Iv/iB8APh19UAcRwHcRzj4OAA8jiK
IsjC30xXBKRer2N+fh6WZaUQ8vk8ZPnxn/b39+W1/nGS8EMbC5DFxUW8fv0a169fx9u3bzE7
O5uWs/6xVCr1zwMJP5CrjiHHgfBrCoFEocUPaJqAeO4hP5BpAhLHLj+QaQIShiY/kKlyWR6/
y5oaIIFbFwmlzw9k1EBs20aSJAiC4MJM/UcL8SObH8g4LOTJkyd49uzZhZn62traiXN1/W8k
/FYyWiB37tzBq1evkMvl8O7du0tn6lLlz7/B88r8QKYlqPvtCsLQ4AcyNXlI7QMsl384ZXqA
KF9Q15f5gUwLkDSOmCv8QKYJSBzwDzBOBZAoznKVqDQPtfONH8pVA5HJpGHpSJwqjPY2P5BR
A6nVakNl6hBqide/sbqN3dbv/EBGDeTx48dDZepivAW6qcLdEdl6EvIDGRWQpaWl7sLCAh48
eIA3b94Mlam7ahOmrsJrVFG1PvBDuepeVquioV7ehabsIO4E0ov1r2sd/rgyUSBxlL0tLFcO
Uf/4V/r5OBStk+cHMtFeFhJ07GI6dB+r32CUD05BaTqf+KFMzELE+xPV+poetw4/QWmWoFeb
SKIwdV9h3ep2KtX0b6R3+MFMIoZouWwcy9lbgpyBImWrJsJOu/+9uv0PEo+/FzYRIJZpwvbq
sB0DUWhCUyvp9bblIvKOZqSY3n5qNfxNP0YgvufDFEDUyvv0XBgG0DUNvldLLcWot456XG6+
e9BYRFGb6coirYYfwwAgiqL0G6jZbOIyQGSj5/NFOMZn2BuzUA830TsvrUVaiK1nriuOHMS2
d+K+VWuNH8p5QB49eoTV1VXI17l37949s6F+zNT9MMS2yOillejODqLiMuy2lVpJ7zsdVYGl
OemxfNWbBBE/lMsAuXXrFl68eAE5E/7+/ftnNpJ88gWUE9c+lnIolQpwnRJ8MQxvljZg6EdA
AseC7wZwzKyX5RnVU/fmhzKiGIIkxu7+Ib4VtqErC+gINwW/jUb+6IVVEsfpZ9top3ElEi5s
2EkRuivcol9FO2iAH8igPEQkhMXSFsqVJgqNItygCNOvi35vC1p15yj4G2qWuTeyaadI54CJ
4C++O2z9qhiOMdw98AM5p9srtbS+iq2tryJ2LMOL94WlGNDLeSiHudQqvO9A0m6y7iAyOjAD
E0GcZfQSzLAzVxrO5olxM34g8kn/7o4cpYSv3wrYVOtY2J/DtvYnVmslWI0coo1FqHoLip51
geM4gX14FGMUT4Ed2AKkN7TF2H4FB8ZSvysti+HugtpCvEYLgaphL7+V9rayfERB08wyeL3y
L6qb7+ErDcQi5liOiWq5dubT3XSbqKZjYz+X1cvXydK1Jfj/rIEcqcuSMcEsbsO029BMG+Vm
ltMo+q44V4Pf/CLifwi52tcyswkRiRiITFoNJOXsfla9BkdVEbieuF2Q5jaWupFZoL8Lw9uF
F54O6omwrCi0hXVdHPC9UIftl6G0v+CXBtIfs8pviB7Waves0tRz3Wan0C/HLSTRFMTLs91e
cfd2up1GpV+Uyh/9YmoL3bb7YUBZu+D6z5eO/6nrxjtHJdo5eTygnBf3TgE5np2fl6nLteyF
QmEiT5fv++na+UnU5bqTWQUmf4/8XZcC0svQB2Xqe3t7ePr0KeQr33GXmZkZzM3NTaSuly9f
didRj/w91Wr1ckDu3buXznwflKlLuqqqTuRpkvWc9zSNWr3ZNpOw+uNjhj8VQy7j0kahSqWS
TkHqbfcxrnXxYZj15Hq7V8h6NDEGp+v6yOvrLYgatHXJ0EAu49JGIemq0g7C9+0+nj9/Ppa6
1tfXsbKygtu3b6cN9vDhw7QeOftmHPXJBVGDti4ZGshlXNootLm5CTGijN52H7LecbiuGzdu
QFr6zZs30/rkFKhxBffegqhBW5fwb8/0q+Qh/OIHwg+EX/xA+IHwNwE/EH7xA+EHwi9+IPxA
+MUPhB8Iv/iB8APhFz8QfvED4QfCL34g/ED4xQ+EHwi/+IHwA+EXPxB+8QPhB8KvofUfARe3
igib9zQAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleMethods [


	| methods trachelMethods b ds |
	methods := Collection withAllSubclasses flatCollect: #rtmethods.
	trachelMethods := TRObject withAllSubclasses flatCollect: #rtmethods.

	b := RTGrapher new.
	b extent: 200 @ 200.

	"Data set 1"
	ds := RTData new.
	ds interaction popup.
	ds dotShape circle color: (Color red alpha: 0.3).
	ds points: methods.
	ds x: #numberOfLinesOfCode.
	ds y: [ :m | m getSource size ].
	b add: ds.

	"Data set 2"
	ds := RTData new.
	ds interaction popup.
	ds dotShape circle color: (Color blue alpha: 0.3).
	ds points: trachelMethods.
	ds x: #numberOfLinesOfCode.
	ds y: [ :m | m getSource size ].
	b add: ds.

	b axisX withThousandsSeparator; title: 'LOC'.
	b axisY noDecimal; title: 'Size'.
	b build.

	^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleMethodsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEZUlEQVR4XuWczUtUURiHr0Wt
gty0aJF/QK78B1oEItFGiqTATRAtBHc6fsTo+AkqSoMZigsDUQllFCF1xHFUVFqIo2AghPnt
oPhtI/n1s3mP3MHKcQwc53p/DxxmmHu4yn3uOe9577nnaMfH/BgJjf8S8Avhh18IvxB++IXw
C+GHXwi/EH74hfAL4YdfCD/8QviF8MMvhF8IP/xC+IXwwy+EXwg//EL44RfCL4QffiH8Qvgx
l5CpqSns7OxgdHQU/DoMIKS6uhpbW1soKipCfn4+Kisr4fP5wC8kQjQ0NMDpdCI5ORmNjY0o
Ly8Hfwvhh0OIxIbl5eXAHS9dk/wm39fW1vhjxlULKS0thc1mQ15eHvr7+5Gbm6t+k2Pd3d1/
CJmenlbFqMzNAVKurRCPx4P4+HgVqAcGBjA7O4usrCz1W09PD7Kzs/lbSKRiyMHBAf/F5w/q
/EL44RfCL4QffiH8QvgxqxDJxtfX19WQd2VlJZC1Ly4u8g+DI9VCXC4XRkZGUFVVpbL2lJQU
dHV1/SPE6Jm6KYTs7u6qC5+WloaMjAyVtff19aG4uJi/hUQyhgDgF8Af1PmF8MMvhF8IP/xC
+IXwY1YhMocuRc/a9Ux9ZmaGfxgcCSH19fUqEZTvMocumXp6ejr0eXX+TP2KhchjExGRk5Oj
5tAlU5eXHfgzdf5MnV8IP/xC+IXwwy/kv/D5AI/nesUvuhaC3l7wC+HHGEK2t7dxdHQUmEfX
M/WFhYWw3qXwz1RifBz8Qs6gpqYGJSUlaG9vD7wJX1BQwJ+pR0KICGhra1MCMjMzVabudruV
lLOSx3AnkHrL8d8d4M/U+eEI6ka+200vRHqb3clZqK5HyuvXgMmWxhlWiOrrW1rUxUZrK1yP
coGmJsBqBSoqAKcTmJ+HPyidfPpLOP6P1dVVdV5ZBSafw8PD4BQyNoa9cju8rm9AUhLc918C
sbFAQgIwOAhMTl5Jy+jo6Aism7fb7aBrIXKh9z47sPTmHX7euQerlgdERwMxMUBcHNDcfKVd
lMVikZHhcVlZGWR+R9bRHx4egkKI6qZSU1ESZcErrQEz2gM81now//Qt5rI/Ym7gB/hHWZfE
6fXqZ7G/v4/WZ5/wUJvADe0Qt7Q9PL/pwPvU7ycBfGgIej0pof5epOpdGyF6lh7s+ETXV0RF
Abe1X3hy9ws+vLCpruLv0tnZqcpZx8Jdb2NjwzwtRF+vHuy4PPeSEuo8Rq9nmhgSqksTZFsO
CahLS0vn1tUXCslmBaHOd5FFRPp2IPKgNNwPRg0jJFSXJni9XrULxEWGnzIi0t8JC8bprT+s
/vzmvHp1dXXY3NxEbW0th5BQXZrQ659ckrxAXiPy9+dB6+oLhRITE4PWO731h8PhCLotlF5P
WqW0uMLCQvA/OiGCXwi/EH74hfAL4YdfCL8QfviF8Avhh18IvxB++IXwwy+EXwg//EL4hfDD
L4RfCD/8QviF8MMvhB9+IfxC+OEXwi+En8vlN9AkwQP3P1GfAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleMinAndMaxSetManually [

| b ds |
b := RTGrapher new.
ds := RTData new.
ds points: #(1 2 3).
b add: ds.

b maxX: 6.
b minX: -2.
b maxY: 5.

b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleMinAndMaxSetManuallyIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAC/0lEQVR4XuXcS2vqQBiH8X45
934aQRdeQDeu3EqXrkRFQURU6mUhuhNcKOJK8VaoileQ4pvTCXjw1Es9KY2pzx9ChPqSOr9O
0pmJedI0fqyUJ34T8EH44YPwQfjhg/BB+OGD8EH44YPwQfjhg/DDB+GD8MMH4YPwwwfhg/DD
B+GD8MMH4YcPwgfhhw/CB+GHD8IH4ecxQRaLhahNvR4Oh8Jv/juDRCIRKZfLMplM5PX19R+Q
+Xyudbtdfc8HMSkvLy+Sz+elVquJ2+0+6SGz2Uz4PcRC4YPwQfggfBA+CB+ED8IH4YPwQR4A
5O3tTW/wwWAgm83mZHDIBzEZJBQK6Q2eTqclFovpg8TjkXqz2eSP1M06ULvdFofDIfV6XRqN
hrRaLXG5XPwewr+G8EH4IHwQPggfhA9ye9Si2Hq9Fj4Iv4fwQfgg/5Hlcin7/f7vaJ0PYoEe
Eg6H9UZ/fn4+WVPnj9RNBvF6vZJKpaRarYrf7+f3EP41hA/CB6GC9Pt94YPwewgfhA/CB+GD
8EFMymq10hu81+vJbrfjr6nfGyQYDOoNrmZf+WvqdwZR6+g2m01fU7fb7fod8Mdr6vKR6XSq
dsIH+QXXkN+0psG/qPNB+CB8ED4IH4QPwgfhgzw8yHa7vdio7+/vojb1+tz31MfjsfzEca1a
awrIx4BPK5VKZ7d4PK6P0AuFgiQSCTn+WTablWg0qu8v1V/bksmkZqTuu7Xq81oaZDQaXfyL
UVMll76nrkboqtboSP3aca1a++MgatLw86nplnx1KruW41uLjDyu4zuP+lBTPWr/eZLUMiCH
D9fpdERtt9Yd3n/ukRu3RN1aZKS2UqmIx+PRjNTmcjlR9epOGp/PZ00QNWmoftHDqenWumun
sq9yuLXISK1CcDqdhmrVM1symYwUi0UJBALykP/28sMH4YPwwwfhg/DDB+GD8MMH4YPwwwfh
g/CbgA/CDx+ED8IPH4QPwg8fhA/CDx+ED8IPH4QfPggfhB8+CB+EHz4IH4QfM/MH1/IkxV9v
yMYAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleMinAndMaxValues [

| b ds |
b := RTGrapher new.

ds := RTData new.
ds points: RTShape withAllSubclasses.
ds y: #numberOfMethods.
b add: ds.

b addDecorator: RTVerticalMinValueDecorator new red.
b addDecorator: RTVerticalMaxValueDecorator new blue.

b axisY noLabel.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleMinAndMaxValuesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACrElEQVR4XuXbvWvqYBjGYf/z
UhEKnTo41M1NMupUXFrEKQ6lgyB0EEEQFT9BrV93Tp+UlFSO57T1TdX+bgg1mD4m7/V+JNKm
goCfU0qK3wR8EH74IHwQfvggfBB++CB8EH74IHwQfvgg/PBB+CD88EH4IPzwQfgg/PBB+CD8
8EH44YPwQfjhg/BB+OGD8EH4OX+Q0WgkfvP+IMjLi3R3J3me9PwsPT2JD3DsEXJ9LT08SJeX
ku9/BLm9PQyo1WqJD/KFPD5KFxdBkMu9Nby95oe/qPNB+OGD8EH44YPwwwfhP6nzwx8hfBB+
+CB8EH74IHwQfvgg/PBB+CD8HA1kOBzyn9T5I4QPwg8fhA/CDx+ED8IPH4QfPggfhB/+kzof
hB8+CB/ktLJardTr9cQH4ef8QWazmbbb7XtvXi6Xv6pnLxYL2XY2IPP5XBabYtbrtabTqTab
zfsFdDodJdU4g8Eg/Mwkr886mMtOdrQpK/qXtWj0uPjT093GiY9M/pT1xUwmk8Qbr9lsKj4q
o/1fBaJaTUk0WnzferqtRTb92DQUvWejKr59dqraN3L+BRSdQ/RZ1oGS6ESHg/j+X09qcHUV
rhcuNrvwbrcbvh6Px/89fveYdrst++Zg3/EGsbtvx0e/Zz/j57BvOw2QmxsF9/f8+1X+cwgf
5NNJp9PhvF8sFlUqlQ4ayvl8PlwPrKbtZzIZlcvlb9csFAqvy17NWT3P81SpVJzVSwSk3++H
83ij0VC9Xj8IxH9do6yezeMRtl30d+tVq1Wn9ewGIpvNOquXSurp1b5vSqKmq6diV/Xszstl
Pf4awl/U+eGD8EH44YPwQfjhg/BB+OGD8EH44YPwwwfhg/DDB+GD8MMH4YPwwwfhg/DDB+GH
D8IH4YcPwgfhhw/CB+GHD4LNHyhras4H+gdeAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleMultiDataPoint [

| b d |
b := RTGrapher new.

d := RTMultipleData new.
d barShape color: Color blue.
d points: #( #('hello' 1 2 1) #('world' 2 4 2) #('bonjour' 3 5 4) #('Gutten Morgen' -1 4 -5)).
d addMetric: #second.
d addMetric: #third.
d addMetric: #fourth.

"d barChartWithBarCenteredTitle: #first."
d barChartWithBarTitle: #first rotation: -30.

b add: d.
^ b 
]

{ #category : #icons }
RTGrapherExample >> exampleMultiDataPointIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABeCAYAAADVA7GfAAADrUlEQVR4XuXbS08TURiHcT6r
Cze6EzV+AhMTVm4QiJFE3UCCMSGmRg1U27SU3svFXqCUXkILhJJwCbTv6HvIGFKr7UCB6Tz/
5IRAO9OZ93fOmdN2GLEsftyUEX4J+CD88EH4IPzwQfgg/PBB+CD88EH4IPzwQfjhg/BB+OGD
8EH44YPwQfjhg/BB+OGD8MMH4YPwwwfhg/DDB+GD/CPtdluSyaTUajWpVqvS+fjGxoa48aRF
2nLRRDw3Qg4PD6XRaEi9Xpe/T1xcCdIau2daO/iBNWXxQfggfBA+CB/Eaqe/i13U64Jkcg0Z
exOxtKWz9Z7H25p8cvHarx4JH4QPwgfhg/BBvA9y3//OtI/FFB+ED8IH4YPwQTwA0poYvTix
ycc9T+xHLS92UQO1gnSCBOMVyy4qH4QPwgfhg/BBvAeixbAL0w1kYiZhCjM5kxQ+CB+ED8IH
uQEQLfjJyYlsb29LuVwWPsgdg+zv74u2dDptbnbofFxvctja2hrq9j78TR5+nLKefXrb9fEX
4z5L2/yX6J+/aSe9symr1WrJbb9TPzg4uLVvIu2R/TQ01/U17dGlo3Qol71669DZ2Zm5dWhz
c9PxPpvNpqyvr5tp8irHdH5+LolEQq4Coj0/n8+LnoMnQLRnBwIBWVxclL29va73cv0v+vxK
pWKmhWw262hb7QC5XE78fr+ZZp2APJh/bY3OTUkqlTIdoVgsDjfI7u6urK6uSigUMgjHx8eO
inl6eio+n88UU4txuSC9onhHR0dmVOrI0N+djMavmag8H38pn3/GTWfwxJSlU5PeSKc9TEeG
k2Lu7OyYKer3Pkzrd1u9gU+3zWQysrCwYDpDv9vq66ysrJjt9Rj09SORiLeuIU569eXMzs6K
jrB+n18qlcxztaBaxEKhYDpCv9vr8n16elqWlpYMSq/nD/1F/aajI0Eh9OKrU46TlZterOPx
uFlw9NsJ+CA9okWNxWLiZNkeDAYlGo3K8vKy4+PlgwwoOgr0zayu+vSn0xUfH2TA0VGhnzBo
u85++CDXiF4fdAms72F0JeVkscAHuYHoElbf2OkyWP+nZRD75IO47Jj4IC4LH4QPwgfhg/BB
+CB8ED7I4EF0Lb+2tmaKrt93dD6un7R6HSQQK4u2UrUprhgh4XDYfLVpw/Dj4imLHz4IH4Qf
PggfhB8+CB+EHz4IP3wQPgg/fBA+CD98ED4IP3wQPgg/fBB++CB8EH74IHwQfvggfBB++CB8
EH7uOr8Ao4yOPnBNaKAAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleMultipleCurvesStacking [

| b points1 points2 minY maxY ds1 ds2 |
points1 := TRShape withAllSubclasses sortedAs: #numberOfVariables.
points2 := TRShape withAllSubclasses sortedAs: #numberOfMethods.

minY := 0.
maxY := (points1 maxValue: #numberOfVariables) max: (points2 maxValue: #numberOfMethods).

b := RTGrapher new.
b extent: 300 @ 200.

ds1 := RTData new.
ds1 points: points1.
ds1 connectColor: Color blue.
ds1 y: #numberOfVariables" min: minY max: maxY".
b add: ds1.

ds2 := RTData new.
ds2 points: points2.
ds2 connectColor: Color green.
ds2 y: #numberOfMethods" min: minY max: maxY".
b add: ds2.


b build.
^ b view
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
RTGrapherExample >> exampleNegativeY [

| b ds |
b := RTGrapher new.
b extent: 200 @ 200.

ds := RTData new.
ds points: (-3 to: 6).
ds y: [ :v | v - 4 ].
ds x: #yourself.
ds connect.
b add: ds.

b axisXWithNumberOfTicks: 4.
b axisYWithNumberOfTicks: 4.

b build.

^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleNegativeYIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAD1ElEQVR4XuXcS0vzQBiGYf+j
P8GVW5cqCCriwqW4EF24EleiCIJ4ruBho9YzIiqIooLn8+GNfYKFWmvTfp+mk7kfCLUY0zJX
Z5J3JrUqCPhxKVX8JuCD8MMH4YPwwwfhg/DDB+GD8MMH4YPwwwfhhw/CB+GHD8IH4YcPwgfh
hw/CB+GHD8IPH4QPwg8fhA/CDx+ED8IPH4QPwg8fJJuNjQ3r6uoy/dzc3Gzv7++Wv8/r66s9
PDzY8/OzxfGeXl5eDAtimczNzYUNcH5+bldXV98a4/7+3qanp+3y8vLPG0ofiLOzM8MPWfpU
Pj4+/tgQy8vLsWAUew/8c0iMIJXG4IM4hsEH+czNzY1p419lOQCinnF3d2f8y14HQFwZpvgg
jmJUFGR/f7/s/YqBlHM8FZdRGKUezxuQ9fX14PDw0LQNDg6G28HBgbW1tVl3d7fNzMyEv1tc
XAz329vbs9HRUdvd3bXs3+Vu2f2iNu2noi9qP70/5JCVTqdte3vbNH2i5319fSrcbXZ21n67
Und1mKo4SEdHR9goQ0NDNjw8bLmVuh7f3t6stbXVxsbGLJVKWV1dnTU2Nlp/f/+3xsxCKu3t
7QUbe2tryzo7O0OMhoYGGxgYsJ6enoL7jo+Ph9M4mjvTvJr3IOoROzs79vT09KVn5DeKGkMo
ej4yMmJCqq6uLtpAS0tL9lPP6O3t/XKslpaWgvvq9ysrK6Y5taOjI0P0EM3aRs2m5g8tqhWK
ndR1vEL1xPX1tV1cXISzxLmvWez1NWRGzavxL3v/4bI3CecMDEgSMbwFSSqGlyA6ZyQVwzsQ
9Yw4VhQRIBMTE5aZrggvg09PTwuuqWeq7B/X1JM8TDkHMjk5aaurq3Z7e2tra2tWX19f1pq6
LxhO9ZCmpqZgamoq2NzcDCv0UocsnzASfw7JFn2BR0ksiG89I9EgvmIkEsRnjMSBaJbYZ4xE
gahnaF0j8DxVScFQz4jjVlI+yGe0cqhqXMXf/Py86ZI2FyOqUueD/FJUmdfW1lpNTU3Y0Lq5
QQ2vZdbcE3icd7/ze0gmqtIFoUfNa2kZ9eTkxKIqdT5IjOeMqEqdD1JBDD6IYxh8kJhTylcC
+CAx9oxSvhLAB3FgmOKDOIrBB/nj5N8ZqNs2VYdoKTdTi5S9ps4H+c/kfg9ca+oLCwvh88xS
rmk5Nz+q1I+Pj/mVepyVerYnaIokgIb/v074IPzwQfgg/PBB+CD88EH4IPzwQfgg/PBB+OGD
8EH44YPwQfjhg/BB+OGD8EH44YPwwwfhg/DDB+GD8MMH4YPwwwfhg/DjRj4AuTQugM8hpswA
AAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleNestingElementsInBars [

| b ds back barElements someElements |
b := RTGrapher new.

ds := RTData new.
ds barShape.
barElements := ds points: #(1 2 3).
b add: ds.

b axisX noTick.
b build.


#(1 2 3) do: [ :value |
	back := b view elementFromModel: value.
	someElements := (RTBox new color: Color red) elementsOn: (1 to: back model * 20).
	b view addAll: someElements.

	RTFlowLayout new maxWidth: back trachelShape width; on: someElements.
	someElements translateTo: back position.
	(RTConstraint  on: someElements background: back)
		top ; center ; inner; padding: 5; move.
].

^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleNestingElementsInBarsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAB/0lEQVR4XuXbMYrCQACG0ZxK
j+Wt1NIbCFpaiI02EVHRlAELAxaTJZHtsmMhZmPeDzLtZh6fgqxJWfrr0hL/CnwQfz6ID+LP
B/FB/PkgPog/H8QH8eeD+PNBfBB/PogP4s8H8UH8+SA+iD8fxJ8P4oP480F8EH8+iA/izwfx
Qfz1AyTLslCd+/0++NfZAZDz+Ryqrdfr0IQ1n887DXW9XsPhcChfve73e+jFW9Y3gBSDQX3p
sdMHaREkm07ri4+dPohfiF+IX4hfiA/iF+IX4oP4hXx7IcPhs4TI6YO0Wchk8iwhcvogfiF+
Ib0o5HK51H/odrsNTQ/bBsjtdgt5npevXo/HI/S+kOVyGYqiCLvdLvxXIdWl5qNRfXmxs+lS
/c+QDoL4nyF+IT6IX4hfiA/iF+IX4oP4hfiF+IX4heiFjMfPEiKnD9IiSK/+Ue73S8XVahV8
kA6AzGaz+svFxWLxFsg7F+ODfOAtq7qYMknqh4+dPkiLIH4hPSrkHUwf5AOF+CB+IX4hfiF+
IX4hfiE+iA/ig/ggDkiaptHfqfsgLYNsNps/f6dePezpdArH45F5VV+0dvoty58P4oP480F8
EH8+iA/izwfx54P4IP58EB/Enw/ig/jzQXwQfz6IPx/EB/Hng/gg/nwQH8SfD+KD+PNB/Pkg
Pog/H+Qb9wNAW4BOOD56cQAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> examplePointAspects [
	| b ds |
	b := RTGrapher new.

	ds := RTData new.
	ds dotShape rectangle color: Color red.
	ds points: (RTShape withAllSubclasses sortedAs: #ageInDays).
	ds y: [ :c | c ageInDays ].
	b add: ds.

	ds := RTData new.
	ds dotShape circle color: Color blue.
	ds points: (TRShape withAllSubclasses sortedAs: #ageInDays).
	ds y: [ :c | c ageInDays ].
	b add: ds.

	b axisX noDecimal; title: 'Classes'.
	b axisY noDecimal; title: 'Age in days'.

	b build.

	^ b view
]

{ #category : #icons }
RTGrapherExample >> examplePointAspectsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAADx0lEQVR4XuWaPUtjQRSG82vE
znI7PwohpT/BdQsLS9E1FkaUVbSyE0H0F6hBLRZERQMJWqVQ1kYTxfgBalZFC8X37swNyYqb
3EQ2388DQy7cQ7iZ586cOTPxOQ6fWsLH7wK+ED58IXwhfPhC+EL48IXwhfDhC+EL4cMXwocv
hC+ED18IXwgfvhC+ED58IXwhfPhC+PCF8IXw4QvhC+HDF8IXwocvhC+ED18IH74QvhA+fCF8
IXz4QvhC+PCF8IWUg8vLS9nP+/t7PT09ycLv9ioKiUQiisVi6ujo0N7enlZWVv4RkkqlnKOj
I/ez0qRSMs+Ubva6qcm8MQsL0vGxNDIibW2lm7luCCHz8/NaWlpSf3+/Njc3FQ6Hc/6weDxe
0ZFjHkO9vdLpqRSNmtb+XeYB5QSDjhYXpZMT99rZ3k43e03KIaUQ8r7/7JseDKabzyclokl9
9SfV4os5v39GFPryQ2pvT4+C1lbxk3oZhCwvS8lkun28J/P99s2v1Jte80k9kUjo4eFBb29v
NTFloZe9Gxsbmp6edjt8bm4uZ1KPRqNVSeo4IX6/3yxStjQxMaHR0VGFQqGSjxCboLNTUw5q
fZqq2xzS3S3t7ko9PVJfn3R2JrW0yEiWTJnzt/Nt8/mc7DVfSGmF2KWpXaLmu6+2NrdWcCXw
pyxvXl5e9Pr6qvPz82zFzk/qVRSyv7/vdvT6+rp2dnZMXRB0/iepu1WzHRENNCoqKmRgYEDb
plIbHx/X9fW1AoHAp0ZIc7OUlWAKOPNl4o+QKuSQu7v0/lI9JeSGFmL3ksLfFvlCysHFxYVs
Ms8k9mKFuFsd/KReeiYnJ92OXTabTbnu8yv1CguZmZnRnUkK5swjpxBb0J3YEcE/vGqs3V6+
kFILeb/twRdSXpLmkMLrfr7p7CPPz881HVcXQq6urtyiMN99m8zNFr0TCPzS2Fhcthi0xWSu
Zs7knXz3yhlnFx0NI8QeSo14/EnAJnO7NC4mqdu4Ypfa1YhrmBxSaErLYE8eC8U8Pj66MTc3
Nyom7vb21jPu1Gw3f+YZ615IoSktgz0Czpw8epGJscvtQnG2RhoeHvaMs0Xt1NSUVldXGUIK
TWnvpzZ78lgorrOzU4eHhxocHFShuIODA83OznrGdXV1aW1tTUNDQ8JMWXz4QvhC+PCF8IXw
4QvhC+HDF8IXwocvhA9fCF8IH74QvhA+fCF8IXz4QvhC+PCF8OEL4QvhwxfCF8KHL4QvhA9f
CF8IH74QvhA+fCF8+EL4QvjwhfCF8OEL4QvhwxdC5g9sF+trm6wBMAAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> examplePopulationUSA [

| b  tab |
tab := RTTabTable new input: (TRPlatform current download: 'https://www.census.gov/popest/data/state/asrh/2013/files/SCPRC-EST2013-18+POP-RES.csv') contents usingDelimiter: $,.
tab removeFirstRow.
tab convertColumnsAsInteger: #('POPESTIMATE2013' 'POPEST18PLUS2013').

b := RTDoubleBarBuilder new.
b pointName: [ :row | row at: (tab indexOfName: 'NAME') ].
b points: tab values allButFirst. 
b bottomValue: [ :row | ((row at: (tab indexOfName: 'POPESTIMATE2013')) / 1000) asInteger ] titled: 'Pop estimate'.
b topValue: [ :row | ((row at: (tab indexOfName: 'POPEST18PLUS2013')) / 1000) asInteger ] titled: 'Pop +18 estimate'.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> examplePopulationUSAIcon [
	^ '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
XcWjA7UAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> examplePopupOnCurves [

	| b ds |
	b := RTGrapher new.

	b extent: 300 @ 200.

	ds := RTData new.
	ds points: (0 to: 100 by: 0.1).
	ds y: [ :x | (0.1 * x) sin  ].
	ds noDot.
	ds interaction popupText: 'sinus'.
	ds connectColor: Color blue.
	b add: ds.

	ds := RTData new.
	ds points: (0 to: 100 by: 0.1).
	ds y: [ :x | (0.1 * x) cos  ].
	ds noDot.
	ds interaction popupText: 'cosinus'.
	ds connectColor: Color red.
	b add: ds.

	b build.
	^ b view 
]

{ #category : #icons }
RTGrapherExample >> examplePopupOnCurvesIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> examplePositiveAndNegativeValues [

| b ds |
b := RTGrapher new.
ds := RTData new. 
ds barShape
		width: 15;
		if: [:v | v < 0 ] fillColor: Color red;
		if: [:v | v > 0 ] fillColor: Color green.
ds points: #(5 -6 10 20 -9).
b add: ds.
b axisX noLabel; noTick. b axisY noDecimal.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> examplePositiveAndNegativeValuesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACBklEQVR4XuXavWrCUBiA4VxO
e5WCODl6Ay4OvQYXf25ARJwU3FwEFRd/wM9yplSwrbQaQ543HBwUg+dJDDkku1z8ylTmT4EP
4ueD+CB+PogP4ueD+CB+PogP4ueD+PkgPoifD+KD+PkgPoifD+KD+Pkgfj6ID+Lng/ggfj6I
D+Lng/ggftUAGQ6H0el0ol6vx/l8Dn9KXwwynU5jNpvFarWK7XZ7BbLZbGI0GpUW6S3yrXJ/
Wfv9/uaPWiwWUd6jMd+Ya4gP4oP4ID6ID+KD+CA+iA/ig/ggPogP4oP4IEWCpLWs9Npqtfyl
kzKdIafTKZbLZSkWFz8i3ziQw+EQaQwGg9KcIfdOtH8N8UF8EB/EB/FBfBAfpNog75FvPkgJ
QB49MT6ID+KD+CA+iA/ig/yxRqMR3W735sTP5/PY7XY/jq8T89tn7xn3ft+j95tGWtd7OUh6
rjehPP0+JMvyUehhW9x+H7KH7x4j9UGqfqfug/ggPogP4oP4ID6ID+KDPAPkZbfPPogP4oP4
ID7Is0Da7XaMx+Po9XpRSZAi7f/7BZPJJJrNZtRqtTSu3luv15GGP80FnyEJ4ng8Rr/f9ye/
7NcQPx/EB/HzQXwQPx/EB/HzQfx8EB/EzwfxQfx8EB/EzwfxQfx8ED8fxAfx80F8ED8fxAfx
80F8ED8fxM8H8UH87uoTt/3tJ829VVMAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> examplePrimeNumberSpace [

	| diag v ds anim |
	"Made by Serge Serge Stinckwich <serge.stinckwich@gmail.com>"
	v := RTView new.

	diag := RTGrapher new.
	diag view: v.
	ds := RTData new.
	ds dotShape ellipse color: (Color r: 0.9450000000000001 g: 0.768 b: 0.059000000000000004 alpha: 1.0); size: 0.1.
	ds points: ((0 to: 5e5) select:#isPrime);
	   y: [ :p |(p* (p cos))];
	   x: [ :p |(p* (p sin))].

	diag add: ds.
	diag axisX color: (Color black alpha:0); noTick; noLabel.
	diag axisY color: (Color black alpha:0); noTick; noLabel.
	diag build.

	anim := RTActiveAnimation new.
	anim intervalInMilliseconds: 100.
	anim blockToExecute: [ 
	    v canvas camera scale: v canvas camera scale + 0.2.
	    v signalUpdate.
	].
	anim inView: v.

	v canvas color: Color black.
	^ v
]

{ #category : #icons }
RTGrapherExample >> examplePrimeNumberSpaceIcon [
	^ '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
11sAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleRandomCurves [

| b ds |
b := RTGrapher new.
b extent: 300 @ 200.

5 timesRepeat: [ 
	ds := RTData new.
	ds noDot.
	ds points: ((1 to: 500) collect: [ :i | 50 atRandom - 25 ]) cumsum.
	ds connectColor: Color green.
	b add: ds.
].
b axisX; axisY.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleRandomCurvesIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleScatterPlot2 [

	| b ds |
	b := RTGrapher new.
	b extent: 290 @ 200.
	b interaction popup.
	
	ds := RTData new.
	ds dotShape ellipse size: 15; color: (Color red alpha: 0.3).
	ds points: RTObject withAllSubclasses.
	 
	ds x: #numberOfMethods; y: #numberOfVariables.
	ds dotSize: #numberOfLinesOfCode min: 4 max: 20 using: #sqrt.
	
	b add: ds.
	b axisXWithNumberOfTicks: 4.
	b axisYWithNumberOfTicks: 4.
	b build.

	^ b view
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
RTGrapherExample >> exampleScatterplotWithHighlighting [
	| b ds |
	b := RTGrapher new.
	b extent: 290 @ 200.
	
	ds := RTData new.
	ds interaction popup.
	ds dotShape ellipse size: 15; color: (Color red alpha: 0.3).
	ds points: RTObject withAllSubclasses.
	ds x: #numberOfMethods; y: #numberOfVariables.
	ds dotSize: #numberOfLinesOfCode min: 4 max: 20 using: #sqrt.
	ds highlightIf: [ :c | (c numberOfLinesOfCode > 2000) or: [ c numberOfVariables > 10 ] ] using: #name.
	b add: ds.
	
	b axisX 
			numberOfTicks: 4;
			title: 'LOC'.

	b axisY 
			numberOfTicks: 4;
			title: 'NOM'.
	
	b build.
	^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleScatterplotWithHighlightingIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampleSeismDepthAndMag [

|tab ds b |
tab := RTTabTable new input:  'http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_month.csv' asUrl retrieveContents usingDelimiter: $,.
tab removeFirstRow.
tab replaceEmptyValuesWith: '0' inColumns: #(4 5).
tab convertColumnsAsFloat: #(4 5).


b := RTGrapher new.
ds := RTData new.
ds interaction popup.
ds points: tab values.
ds dotShape color: (Color blue alpha: 0.3).
ds x: [ :row | row at: 4 ].
ds y: [ :row | row at: 5 ].
b add: ds.

b maxY: 8.
b maxX: 700.

b axisX title: 'depth'.
b axisY title: 'magnitude'.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleSeismDepthAndMagIcon [
	^ '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
H3lF1g9+YtrbAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleSimpleCurve [

	| b ds |
	b := RTGrapher new.
	b extent: 300 @ 300.
	
	ds := RTData new.
	ds dotShape ellipse color: (Color blue alpha: 0.5).
	ds points: (0.0 to: 1.0 by: 0.05).
	ds connect.
	ds y: [ :v | v sqrt ].
	b add: ds.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.
^ b view
]

{ #category : #sources }
RTGrapherExample >> exampleSimpleCurve2 [

	| b ds |
	b := RTGrapher new.
	b extent: 300 @ 300.
	
	ds := RTData new.
	ds dotShape ellipse color: (Color blue alpha: 0.5).
	ds points: (RTObject withAllSubclasses sortedAs: #numberOfMethods).
	ds connect.
	ds y: #numberOfMethods.
	b add: ds.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleSimpleCurve2Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAE4UlEQVR4XuWdS08TURiG0X/g
kqU/wB/gzgRI+AdqXBhNGm8bI7Hh1rQUEWgkLlyQsGFhAomRkEDBhAINF8PFGBIXCCEpLChI
gF7Tcil963ynjqKW2o6lM/q+yclwyZx853vObb4zc05FJsMvK6mC3wX8QPjFD4QfCL/4gfAD
4Rc/EH4g/OIHwg+EX/xA+MUPhB8Iv/iB8APhFz8QfiC/Kx6PY3d3F/JzMBhU152dHfC70yQg
Ho8HXV1dmJ2dhcPhUCBcLhdaWlp+grK+vp5ZWVmhcebWFvDqVQplBbK0tISamho0Nzejp6dH
gVlYWIDb7cb09PRvxmhQqFpOMpmEpccQNiDpdJofCP8six8IPxB+IPxAitbJyQn4gVhIgUCS
H4iV9OlTHNEo+GdZVlEsFuNvIVZSVGse/ED4gfADOUuRSIQfCD+QTDb8LleJ2xwfH+cNv/MD
KQMQCb/39vZCDFhcXMwbfp+fn6d5yg6Hw+UHoofft7TgvySbzcYffjcTCP8Ywg+EHwg/EGMK
hUL8QPiB8APhB8IPhB8I/6D+n7SQDD8Qa7UQfiD8Ywg/EH4g/ED+oEQiAdHR0ZEyIJVKQRI/
EJOASHR3cHAQfX19yoDV1VVIygGDKvxuGpCJiQnMzMxgeXlZhdzHxsZU4p9l8T+H8APhB8IP
hB8IPxBj4n8NiB8IP5B84n9zkR8IPxB+IP+Qrl+P8wPhn/byA8mpYBB4946/hVhGIyOA1wvz
gMgAtrm5CT30zh5+9/limj9MAjI1NQWn05kZHh7OG34PBAKYm5ujAOJwxEpSTkNA5FuQhoYG
yJvw2nrHmeF3WcRiaCGfPwMdHSYC4R9DfujNG+D27ahWMcEPxAqqqwtDm+2WrIz8QP5CN27E
0dp6XNLy8QMxoA8fgEePonj+PFXysvEDKVI3b6bx+HEI79/jXMrFD6QIDQwAL19GzrU8/EAK
0JcvwK1bcVRWnuDjR/ADMUtv3wI2WwrV1Qm8fo2ylIMfyCm9eCEAkqirC+HOnYiWknC7UVb7
aYFoUR88fRpS6eHDMJ48CeH+fUCgmGnXfw9EpqhOZ9b5TU3i9Kzz794tTTCQH0hGFoIAlyvr
aLneu5dERQVw8SLU9cIF4PLlI+X4Bw+i2sMbIOsV/0K3aRjI6c1mztp4RjaFXFtbw1kD5rNn
gMcD1U+LY3UnX72adbDuZPldnGu3h9RV+nhxsqSODuPdjNh3eHhYMlClyM8wEH2zmVybzuiS
8PuVK4lvtTZ9yslpXLqUxLVr/u+pujqbqqr8GiQ//H5/5tfk8/kgIf9c/zOSziM//XCCsgPR
N5uZnJxEW1tbTiMODg6wt7dXshootc/q+emnRlhuDCmkSytU+/v72N7e/p6H1EJZrTTy2o3s
7yWrm/KxkeQhf5P9v6S72djYgFH7dHv+9viOcwNSSJdWiNrb29HY2Kjul9XHzs5ODA0NQU4h
0DdPK0ayv9eItgAu3Yvdblf3C+zx8XH09/cbslMW53R78h3fYSqQQrq0QiQfBXV3d6O2tlb1
9ZJnfX29NqC3GspT9veSccPr9SqH6TaOjo6qPb+KHZTlXqkwYo90V386vsP0aS+/+IHwA+EX
PxB+IPziB8IPhF/8QPjFD4QfCL/4gfAD4Rc/EH4g/OIHwg+EX/xA+HVaXwHyHHqxNmVDtQAA
AABJRU5ErkJggg=='
]

{ #category : #icons }
RTGrapherExample >> exampleSimpleCurveIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAD/UlEQVR4XuWdTUsyURTH+3JC
Wz9JqwxaWL5BuOgL2BdoEYEICYkShRotbOlOAivd+N74fubxDPgw9KjP6IzOuff/BxmY4qLz
m3PPyz1z58g08SVJR/iXAB8IvvCB4APBFz4QfCD4wgeCDwRf+EDwgeALHwi+8IHgA8EXPhB8
IPjCB4IPZL36/T7x8fPzk/AvpQAgyWTSAtFut6nVav0DZXHerFar1hFFZ2dD8gVIpVKhQCBA
5XKZLi4uiLXq/2q1GoT19Ho9MgyDxPsQ3YEMBgO6uhqQMk5dVyAvLwaxVSgXZekGZDQaEQcz
uRyRkmGvLkCm0ymdnPRJ+TxEdSDZLFlT07qgBR/IgSOnu7spaZWpqwikWDSIoyflEkMdgXQ6
nb05bHwgWyga/aHhcOj7d4UHwhD2kU/gA9lSHDWFQj1x3w0SCCd2nOBJvFF2BrIsudfrdep2
u8RH6UAmkwklEgPRU+hOQBqNBjWbTeuHcYWTf2gqlVpZfl9Ug0WU3/mmmc1m4gOMnYDM53MK
h8P0+vpKsVjMAhKPx0VaCDvtWMxQJvTW2odwTqFaUqolEHbYkYihZMlGOyAcQangKyCAnJ93
lS/1awFkPB57sp6ND8QDPT8PiYGYmkhpIFyD8rMyiw/EplV9YPhAfAISj/e0bS1SCgiHs36t
5OED+aVcbqRNJKU8EAbx9DSGaEl1BWRZ8V1XevcCCE9Rh2rBURrI5eXlol4UsS5UKBRaecHc
lt8jkS7cYw47A8nn84vFnoTV/c5g1iVnu1oIr1+YgBLpQ3SPpJQCks0OoZ/GEgWEV/cKhRk+
EAlAOJJCyDOUAYLqxEUCOT3t4cOQAgR/mhIGREKDMz4QfL8hD8jt7QAfhhQgHOK+vU3wgUgB
omJHoXggy+737+/vjSX430C4CIlUTj8IEHv3O6tUKq3sfudGBP6bvSFB0tNK2gCxd78fHx/T
4+Pjyu53tgS2kKVF4OccwnzI9TW+dYgCIvUxMkgg+I5cGBDedQ7/cgsCgj9d4VsIPpBNQHi/
KfzLLQQIPgxhQPCnK2FA8B06voXgA9kEBD8pPBCQZcV3097vHx8fnsLwukApbTxPut/X7f3O
56LRpvnw8ECFQsH04nN/f296NdY+xisWi/5YiL37fd3e73zu6+vL0ymLx/PyjpY23l59iJMp
zamcrlBuOx4vmPFuRm7HY3nx+o69AXEypTmVfYVyMSXQ+/u7tS2UF+MFg0HLijOZjGsg/3t9
h69AnExpTmVfoby5uaF0Ov0XttvxeKWTx3MDmOX09R2+h734wgeCDwRf+EDwgeALHwg+EHzh
A8EXPhB8IPjCB4IPBF/4QPCB4AsfCD4QfOEDwZddfwAbTfhlYJ+zmQAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> exampleSimpleValues [

| b values ds |
b := RTGrapher new.
values := #(5 6 7 -1 -3).
b extent: 400 @ 300.

ds := RTData new.
ds interaction popup.
ds points: values.
ds connectColor: Color red.
ds y: #yourself.

b add: ds.

b build.
^ b view
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
RTGrapherExample >> exampleStackingX [

	| b ds |
	b := RTGrapher new.
	b extent: 400 @ 300.
	
	ds := RTData new.
	ds points: #( 5 6 7 ).
	ds connectColor: Color red.
	ds y: #yourself.
	b add: ds.
	
	ds := RTData new.
	ds points: #(1 7 10 4).
	ds connectColor: Color blue.
	ds y: #yourself.
	b add: ds.
	

	b axisXWithNumberOfTicks: 4.
	b axisYWithNumberOfTicks: 4.
	b build.
 	^ b view
]

{ #category : #sources }
RTGrapherExample >> exampleStackingX3 [

	| b nbOfCurves normalizer |
	b := RTGrapher new.
	b extent: 400 @ 200.
	
	nbOfCurves := 3.
	normalizer := RTMultiLinearColorForIdentity new numberOfColors: (nbOfCurves).
	1 to: nbOfCurves do: [ :i |
		| data ds |
		ds := RTData new.
		data := (100 to: 1 by: -1) collect: #atRandom.
		ds dotShape ellipse size: 0.
		ds points: data.
		ds connectColor: (normalizer rtValue: i).
		b add: ds.
	].

	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.

^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleStackingX3Icon [
	^ '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
TkSuQmCC'
]

{ #category : #icons }
RTGrapherExample >> exampleStackingXIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEZ0lEQVR4XuWdSU/jQBCF8+f4
KfwFDhxYDnDIhSCO7MsJBEisIgECB9ZLkNhBCA5JhmhYBJFAYSmPu2eAjGwn3Xbb6fZ7kpUQ
SBH1567qV25MwrLwpZMS+EOADwRf+EDwgeALHwg+EHzhA8EHgi98IPhA8IUPBF/4QPCB4Asf
CD4QfOEDQQPy9vZG7+/v/GBfFwoFwh+mBgLZ39+n8/Nzftze3lKpVHIAeXx8tOzv80cUbW5G
c2I6gDQ3N1M6nebHzs4OtbW1uX6Qm5sbmJkzMUH0+Ul0ckKkbQ1BAdLd/QOBgcEH0kB1djoB
rK2FCwUfiIf6+twHfmgIH0ikYrVifr72oIcJBR9IlfJ5oo2N+oMdZtrCB/JPW1tiMMIu8PhA
bGWzRIeHcgN8dET08aEeCjwQln7KZX8D29uLD0S54Qu6AFBtFmGBVBu+RkLFB+Jh+IKmPXwg
ig1fEKn0JQ4gT09PlLcX5H/X5XmKCxARw6cDFNcZMjMzw4O3tLS4/hLWdt/d3TWm/S5q+HRI
W65Azs7OyB5w6rSTbaVSMbr9Lmv4Gl3gY11D/Bi+IFJhFmMLZHW16Nvwualg0xX5uVQKH4jn
7AjyfmKFh1XqZJJfLhR9H5shQcxiLIGMjfkbEFpaIspkOIhG1ZLYAbHXIHRxIT4gfAYsLvLT
WodVV+yA1MvhflORrAYH8YFYuRxxhZWKojCLsQIyPv4zAL9Zj4RZc8WpSG6lBwwkvfIZSSoK
e4FhNJDqVDQ8TFrWNFmzaBwQPgMWFv5LRf39pLUn6umJERCRVVFQExi2ZMxiwrmOr3xvsK61
8z1MIDKrIr8mUNda4gAyNTXFN1qz53Z7nR4eHlx3v6tuv/+am5NeFcmawEZLxCw6gJzYA9La
2srb7+3t7a7rel2KetBGXtQaGPABxJRV1sEBeZ4sOquegzcWSLUJNEn1zKKRQOwSZ/QWpFoF
3kggIyNmA2FXMb3MonFARAqjCZqcLMYDiO4mMKiMAmKKCYQAYpoJjD2QMLb+4wMBM4GxBWKq
CYwlENNNoBIg9/f32ux+N90EKgHy1X732v3OWvLsPihurXl8E6gYyPr6+nf73Wv3Oyuw19fX
oRfaqHat49cQ/EJuFhBmAi8v8YFoAwTFBBoBhJlAC1jaAYniJmH4QPBNoJlARkfxgWgDZHq6
hH87Wgv/bkD4QPCFDwQfCL4UAxHZ/c5uRa7yg7y8vODHcwPS0dHBu7zsudfud/ZaJpOxlpeX
KZvNWiqO2dlZS1UsE+Jtb2+LzRDWfu/q6qq5+529ViwWlbbfWTyVZ6Cp8XzVEJGUJqNyuaw0
3tcVT1Xx7u7ulMZ7fX31jCcNRCSlySqZTCqNV+8PjmSVSqWUxbu6uqLj42PPeNJARFKajHK5
HDU1NSmLV33FU0W809NTYpeyVcV7fn6mvb09z3j4//IoLj4EX/hA8IHgCx8IPhD8IcAHgi98
IPhA8IUPBB8IvvCB4APBFz4QfCD4wgeCL3wghugPLJi7puVmqhwAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGrapherExample >> exampleTwoInteractions [

	| b ds |
	b := RTGrapher new.
	b extent: 300 @ 200.

	ds := RTData new.
	ds interaction popupText: [ :c | 'Roassal class: ', c name ].
	ds dotShape circle color: (Color blue alpha: 0.3).
	ds points: RTShape withAllSubclasses.
	ds x: #numberOfMethods.
	ds y: #numberOfLinesOfCode.
	b add: ds.

	ds := RTData new.
	ds interaction popupText: [ :c | 'Trachel class: ', c name ].
	ds dotShape circle color: (Color red alpha: 0.3).
	ds points: TRShape withAllSubclasses.
	ds x: #numberOfMethods.
	ds y: #numberOfLinesOfCode.
	b add: ds.

	b axisX; axisY.

	b build.
	^ b view
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
	b := RTGrapher new.
	b extent: 200 @ 200.
	
	ds := RTData new.
	ds points: #(0 1 2 3 10 20).
	ds connectUsing: (RTLine new color: Color blue).
	b add: ds.
	
	ds := RTData new.
	ds points: #(0 10 20 30).
	ds connectUsing: (RTLine new color: Color red).
	b add: ds.
	
	b axisXWithNumberOfTicks: 3.
	b axisYWithNumberOfTicks: 4.
b build.
^ b view
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
b := RTGrapher new.

clss := Array with: RTElement with: RTEdge.
n := RTMultiLinearColorForIdentity new objects: clss.
clss do: [ :cls |
	ds := RTData new.
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

^ lb view
]

{ #category : #icons }
RTGrapherExample >> exampleUsingLegendIcon [
	^ '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
gg=='
]

{ #category : #sources }
RTGrapherExample >> exampleValuesDecoration [
| b ds deco |

b := RTGrapher new.

ds := RTData new.
ds points: #(0 1 2 3 4 5 6).
b add: ds.

deco :=  RTHorizontalAllValuesDecorator new.
deco labelConversion: [ :value | '#', value asString ].
b addDecorator: deco.

deco :=  RTVerticalValuesDecorator new.
deco addAll: #(2 3 4).
deco labelConversion: [ :value | '#', value asString ].
b addDecorator: deco.

b axisX noTick; noLabel.
b axisY noTick; noLabel.
b build.
^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleValuesDecorationIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACrUlEQVR4XuXbyYoiQRSF4Xpu
Nz6JuBFEfAHRjRMq4gSigjgh6EJwWjigeOy+TQtd3WJIU1Zm+h9IqMXFKuIzMrLiZnxcr/z4
KR/8IeCD8MMH4YPwwwfhg/DDB+GD8MMH4YPwwwfhhw/CB+GHD8IH4YcPwgfhhw/CB+GHD8IP
H4QPwg8fhA/CDx+ED/KfWa1Wogzk+XzWYrGQr0HG47H433k+CB+ED8IH4YPwQfggvoh+Zr/f
iw/ik1wuF+12Oz4I/5bFB+GD8MMHeX+Q7Xar2+LHB/EYZDKZKJPJKBqNarPZfBr8crksP4PY
ZuByudRbgTQaDdVqNc3n819X0GaI/Y/BX0P44YPwQfggfBA+yO8Mh0NVKhV1u13+Y6/XIPV6
XZFIRKVSSfl8/tPgDwYDTx57T6fTl/S2AwkyGo1kl6Hc2xHlzxD+GsIH4YPwQfggfJCAgNjm
om0sxuNxNZvNly7q393bDiTIdDpVp9NRsVjUq2fId/e2+bcsfvggfBB++CB8ED5IsEH82ttG
zxA/9rb5tyx++CB8EH74IHwQPog/Qay3bbvB1lt3Xfb24zvUfcW5/JfOkPV6LS/qnh0Yr+o8
A+GHD8IH4ScgINZNLBQKOhwOctWl02k983nWKra9L1ddIpFwdhetzrqQz/x9sVhMvV7PWZfN
Zu+2sj0HsddKk8mkwuHw1S5XXbVa1TOfZxj9fl+uOltcW62Ws84G+u+DRvfqUqnUP29m3qsL
hULK5XL+A7HDO7PZTHagx979ddXZI+PxeHTW2TvEj775tzrr8T9CvtXZz49myJ+/t91uO+us
xk6O8dcQ/hrCDx+ED8IPH4QfPggfhB8+CB+EHz4IH4QfPggfhB8+CB+EHz4IP3wQPgg/fBA+
CD98ED4IP3wQPgg/fBB++CDByA9txEgft66zuwAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTGrapherExample >> exampleVerticalAndHorizontalBars [

	| b ds p |
	b := RTGrapher new.

	ds := RTData new.
	ds points: #( 0 1 2 10).

	b add: ds.

	b minY: -3.33.

	p := RTHorizontalLineDecorator new.
	p add: 5; add: 7; add: 3.34.
	p shape line color: (Color red alpha: 0.3).
	b addDecorator: p.

	p := RTVerticalLineDecorator new.
	p add: 5.
	p shape line color: (Color blue alpha: 0.3).
	b addDecorator: p.

	b build.
	^ b view 
]

{ #category : #icons }
RTGrapherExample >> exampleVerticalAndHorizontalBarsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABeCAYAAADVA7GfAAADiklEQVR4XuWby0ojQRSGfUd3
voJ7t0o2bhQUdOdS9AHcKC6ihohGFO+aRRIVgzHEGPF+ycn0X0yJzQyazqjdzvdD0d2Qsqvr
85yqc6qqq9XiK0nq4ncBHwhffCB8IHzxgfCB8MUHwgfCFx8IHwhffCB88YHwgfDFB8IHwhcf
CB8IX3wgfCB88YHwxQfCB8IXHwgfCF/JAnJ+fm66lstl43dnjEAEYHR01MbHxx2I3d1dazQa
r1Dq9Xrr8vIS1Zn39/euxAKkv7+/NTc3ZwMDA7aysmLDw8N2d3f3CuTo6MhoQB4fHy02IB8p
sBC+C+MD4QPhA+ED4QPhA+ED4QPhA+ED4evTgCgAGhkZMUlB4cLCgvX09IQidQWG9ULB7OKC
VV5e7NuBXF1dWW9vr21vb7vUSTqdttnZ2VBDiJF6rC5L1vH09GT+nu+y+GMIHwgfCB8IH8hn
AsHNsOKaZfEthO+y+ED4QH4QEMUdPhC8CPzm6uqqLS8vhwCcnZ2FlnT5+mILmZmZsWazaep4
Aenu7raTk5NXAPl83ipBCcJ1VoljUK9Wqy6HpU4/Pj62ra0tu729Nb7L4o8hfCBfBUTj0vPz
s/GBJASIJgB8q+K7LD4QvhIGRKuKwcIVHxbfQv5zIIo7xsbGXKdnMhltMg4BqFQqHW88fgmC
q7fr81H1L0vHNzc39vDw0NG7Y9/9rsb7e5W3KpVKOqLQUuAYtRQKBVtbW7NO6qoEmYNWp3UV
5B4cHHRUd29vz2q1WjxAFKVrt8n+/r5tbGy4TuRbSIwW8p6GhoZcTLG+vv5H0vEjTU9PuwAx
sDCbmJiIVFf/IHKfvg1R6ipJOjg46OpMTk46K2m37tLSUuid2Ww28nd/GRAdcZP1FItF070/
8tauBGNnZ8eZv//QdnV4eGiyLt+GqLO5qakp9/uo787lcqF36qqSCCDKAOt4mxKQGvjluqLU
V9LSp1Lm5+ctqqvzLkdt+Nv2pPck69LWJv2NdDrddr3T01Pz3636+nZlwfnTXn4cwgfCB8IH
wgfyI4BcX18rCHKdro3VuvpnPpAYgGgWoSMJPnbQ1T//noK6aJ2vbwKyuLhofX19bm09lUrZ
5uame+Z3aULHEL74QPhA+OID4QPhiw+ED4QvPhC++ED4QPjiA+ED4YsPhA+ELz4QPhC++ED4
4gPhA+GLD4QPhC8+ED4QvvhA+ED4SoJ+AbqWxW0ZX8E0AAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTGrapherExample >> exampleVerticalAndHorizontalLines [

	| b ds |
	b := RTGrapher new.

	b extent: 300 @ 200.

	ds := RTData new.
	ds points: (-50 to: 100 by: 0.1).
	ds y: [ :x | (0.1 * x) sin  ].
	ds noDot.
	ds interaction popupText: 'sinus'.
	ds connectColor: Color blue.
	b add: ds.

	ds := RTData new.
	ds points: (-50 to: 100 by: 0.1).
	ds y: [ :x | (0.1 * x) cos  ].
	ds noDot.
	ds interaction popupText: 'cosinus'.
	ds connectColor: Color red.
	b add: ds.

	b addDecorator: RTHorizontalTickLineDecorator new.
	b addDecorator: RTVerticalTickLineDecorator new.

	b build.
	^ b view
]

{ #category : #icons }
RTGrapherExample >> exampleVerticalAndHorizontalLinesIcon [
	^ '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'
]

{ #category : #sources }
RTGrapherExample >> exampledoubleCurves [

| f g b ds xValues |
f := [ :x | x ].
g := [ :x | x * x ].

xValues := (0 to: 100 by: 0.1).

b := RTGrapher new.
b extent: 300 @ 200.

ds := RTData new.
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
	grapher := RTGrapher new.
	grapher extent: 300 @ 200.
	
	dataSet := RTData new. 
	dataSet barShape width: 10.
	dataSet 
		points: RTShape withAllSubclasses; 
		y: #numberOfMethods.
	 
	grapher add: dataSet.

	dataSet := RTData new.
	dataSet dotShape color: (Color red alpha: 0.3).
	dataSet 
		points: RTShape withAllSubclasses; 
		y: #numberOfMethods. 
	grapher add: dataSet.

	grapher axisY.
	grapher axisX noLabel.
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

b := RTGrapher new.
b extent: 300 @ 300.

ds := RTData new
				points: methodsRoassal;
				x: [ :m | (m date asUnixTime - greatestAge) / 3600 ];
				y: #numberOfLinesOfCode.
ds dotShape circle color: (Color blue alpha: 0.3); size: 5.
ds interaction popup.
b add: ds.

ds := RTData new
				points: methodsTrachel;
				x: [ :m | (m date asUnixTime - greatestAge) / 3600 ];
				y: #numberOfLinesOfCode.
ds dotShape circle color: (Color red alpha: 0.3); size: 5.
ds interaction popup.
b add: ds.


b axisX noDecimal; noLabel; title: 'Time'.
b axisY noDecimal; title: 'Number of lines of code'.

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
b := RTGrapher new.
b extent: 400 @ 400.

ds := RTData new.
ds dotShape rectangle size: 0.
ds points: (-3 to: 3.1415 * 5 by: 0.01).
ds y: [ :v | v sin ].
ds x: #yourself.
ds connectColor: (Color red alpha: 0.4).
b add: ds.

ds := RTData new.
ds dotShape rectangle size: 0.
ds points: (0 to: 3.1415 * 5 by: 0.01).
ds y: [ :v | v cos ].
ds x: #yourself.
ds connectColor: (Color blue alpha: 0.4).
b add: ds.

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

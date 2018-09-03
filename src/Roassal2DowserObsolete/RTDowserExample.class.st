"
A RTDowserExample is a group of examples to show the different capabilities of RTDowserBuilder.

"
Class {
	#name : #RTDowserExample,
	#superclass : #Object,
	#category : #Roassal2DowserObsolete
}

{ #category : #basic }
RTDowserExample >> basic [
	"
	self new basic
	"
	|a |
	a := RTDowserBuilder new.
	a addColumn: (Array with: 'a' with: 'b' with: 'c').
	a addColumn: (Array with: 'a' with: 'b' with: 'c').
	a addColumn: (Array with: 'a' with: 'b' with: 'c').
	a edgesTo: #yourself.
	a open.
]

{ #category : #duoDowser }
RTDowserExample >> coolStuff [
	"
	self new coolStuff 
	"
	| builder |

	builder := RTDuoDowserBuilder new.
	builder legend: 'Compiler instance variables usage'.
	builder labelRight: [:a | a selector asString]. 
	builder left: Compiler instanceVariables.
	builder right: Compiler rtmethods.
	builder edgesTo: [ :a :b | b referredInstVars includes: a  ].
	builder open
]

{ #category : #duoDowser }
RTDowserExample >> differentRelations [
	"
	self new differentRelations
	"
	| builder |

	builder := RTDuoDowserBuilder new.
	builder legend: 'Example of a relation between two set of integers'.
	builder left: (1 to: 10).
	builder right: (1 to: 20).
	builder edgesFromLeft: [ :v | (v - 5) to: (v + 5) ] edgesToLeft: [ :v | (v / 2) ].
	builder octopiEdges.
	builder open
]

{ #category : #duoDowser }
RTDowserExample >> doubleParameterRelation [
	"
	self new doubleParameterRelation
	"
	| builder | 
	builder := RTDuoDowserBuilder new.
	builder left: (1 to: 20).
	builder right: (RTObject withAllSubclasses).
	builder edgesFrom: [ :a :b | a numberOfSubclasses = b].
	builder open
]

{ #category : #duoDowser }
RTDowserExample >> duoBasic [
	"
	self new duoBasic
	"
	|a |
	a := RTDuoDowserBuilder new.
	a left: (Array with: 'a' with: 'b' with: 'c' ).
	a body: 'a b c a b c'.
	a edgesTo: #yourself.
	a open.
]

{ #category : #duoDowser }
RTDowserExample >> inferedRight [
	"
	self new inferedRight
	"
	| builder |

	builder := RTDuoDowserBuilder new.
	builder height:  [ :e | e numberOfLinesOfCode  / 10].
	builder color: #numberOfMethods.
	builder left: RTShape withAllSubclasses.
	builder edgesTo: #referencedClasses.
	builder open
]

{ #category : #duoDowser }
RTDowserExample >> ironMaiden [
	"
	self new ironMaiden
	"
	|builder maiden1 maiden2 arr |
	
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'Germany'; add: 'United Kingdom'; add: 'Brazil'; add: 'Spain'; add: 'Russia';
		add: 'France'; add: 'Poland'; add: 'Sweden'; add: 'Austria'; add: 'Finland'; add: 'Argentina'; add: 'Switzerland';
		add: 'Romania'; add: 'Paraguay'; add: 'Netherlands'; add: 'Turkey'; add: 'Chile'; add: 'Portugal'; add: 'Slovakia'; add: 'Czech Republic';
		add: 'Belgium'; add: 'Croatia'; add: 'Italy'; add: 'Mexico'.
	maiden1 := OrderedCollection new.
	maiden1 add: (Array with: 2013 with: 46 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'Canada'.
	maiden1 add: (Array with: 2012 with: 34 with: arr).
	arr := OrderedCollection new.
	arr add: 'United Kingdom'; add: 'Brazil'; add: 'Australia'; add: 'Germany'; add: 'France'; add: 'Russia'; add: 'Indonesia';
		add: 'United States'; add: 'Mexico'; add: 'Colombia'; add: 'Netherlands'; add: 'Peru'; add: 'Poland'; add: 'Denmark'; add: 'Czech Republic';
		add: 'Sweden'; add: 'Singapore'; add: 'Argentina'; add: 'Austria'; add: 'Belgium'; add: 'Chile'; add: 'Greece'; add: 'Norway'; add: 'Puerto Rico'; 
		add: 'Turkey'; add: 'Finland'; add: 'South Korea'; add: 'Switzerland'; add: 'Portugal'; add: 'Italy'; add: 'Spain'.
	maiden1 add: (Array with: 2011 with: 63 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'Canada'; add: 'Italy'; add: 'Ireland'; add: 'Belgium' ; add: 'United Kingdom'; add: 'Spain'; add: 'Sweden'; 
		add: 'Germany'; add: 'Finland'; add: 'Norway'; add: 'Hungary'; add: 'Romania'.
	maiden1 add: (Array with: 2010 with: 36 with: arr).
	arr := OrderedCollection new.
	arr add: 'Brazil'; add: 'Mexico'; add: 'New Zealand'; add: 'Colombia'; add: 'Ecuador'; add: 'Serbia'; add: 'India'; add: 'Chile'; add: 'United Arab Emirates'; 
		add: 'Peru'; add: 'Argentina'; add: 'United States'; add: 'Venezuela'; add: 'Costa Rica'.
	maiden1 add: (Array with: 2009 with: 22 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'Canada'; add: 'Australia'; add: 'Mexico'; add: 'Brazil'; add: 'Japan'; add: 'Sweden'; add: 'Norway'; add: 'France'; 
		add: 'Finland'; add: 'Argentina'; add: 'Puerto Rico'; add: 'Czech Republic'; add: 'Chile'; add: 'Poland'; add: 'Hungary'; add: 'Portugal'; 
		add: 'Costa Rica'; add: 'Romania'; add: 'Colombia'; add: 'Greece'; add: 'United Kingdom'; add: 'Croatia'; add: 'Denmark'; add: 'Netherlands'; 
		add: 'Russia'; add: 'India'; add: 'Switzerland'; add: 'Germany'; add: 'Italy'; add: 'Belgium'; add: 'Spain'.
	maiden1 add: (Array with: 2008 with: 68 with: arr).
	arr := OrderedCollection new.
	arr add: 'United Kingdom'; add: 'Germany'; add: 'Italy'; add: 'Slovenia'; add: 'Belgium'; add: 'India'; add: 'Greece'; add: 'United Arab Emirates'; 
		add: 'Spain'; add: 'Serbia'; add: 'Netherlands'; add: 'Czech Republic'; add: 'Bulgaria'.
	maiden1 add: (Array with: 2007 with: 16 with: arr).
	arr := OrderedCollection new.
	arr add:	'United Kingdom'; add: 'United States'; add: 'Japan'; add: 'Sweden'; add: 'Finland'; add: 'Canada'; add: 'Norway' ; add: 'Italy'; 
		add: 'Denmark'; add: 'Germany'; add: 'Switzerland'; add: 'Ireland'; add: 'France'; add: 'Spain'; add: 'Netherlands'.
	maiden1 add: (Array with: 2006 with: 45 with: arr).
	arr := OrderedCollection new.
	arr add:	'United States'; add: 'United Kingdom'; add: 'Germany'; add: 'Finland'; add: 'Norway'; add: 'Canada'; add: 'Portugal'; add: 'Belgium'; 
		add: 'Czech Republic'; add:	'Switzerland'; add: 'Netherlands'; add: 'Greece'; add: 'Austria'; add: 'Sweden'; add: 'Poland'; 		add: 'Ireland'; add: 'Iceland'; add: 'Italy'; add: 'France'; add: 'Spain'.
	maiden1 add: (Array with: 2005 with: 46 with: arr).
	arr := OrderedCollection new.
	arr add:	'United States'; add: 'Japan'; add: 'Brazil'; add: 'Canada'; add: 'Argentina'; add: 'Chile'.
	maiden1 add: (Array with: 2004 with: 14 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'Germany'; add: 'United Kingdom'; add: 'Spain'; add: 'France'; add: 'Sweden'; add:	'Italy'; add: 'Canada'; add: 'Belgium'; 		add: 'Czech Republic'; add: 'Denmark'; add: 'Switzerland'; add: 'Finland'; add: 'Hungary'; add: 'Netherlands'; add:	'Poland'; add: 'Norway'; 
		add: 'Croatia'; add:	'Portugal'; add: 'Slovakia'; add: 'Austria'; add: 'Ireland'.
	maiden1 add: (Array with: 2003 with: 90 with: arr).
	arr := OrderedCollection new.
	arr add: 'United Kingdom'.
	maiden1 add: (Array with: 2002 with: 4 with: arr).
	arr := OrderedCollection new.
	arr add: 'United Kingdom'; add: 'Argentina'; add: 'Brazil'; add: 'Mexico'; add: 'Chile'.
	maiden1 add: (Array with: 2001 with: 6 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'Japan'; add: 'United Kingdom'; add: 'Germany'; add: 'Canada'; add: 'Spain'; add: 'France'; add: 'Poland'; 
		add: 'Czech Republic'; add: 'Switzerland'; add: 'Sweden'; add: 'Slovenia'; add: 'Portugal'; add: 'Norway'; add: 'Greece'; add: 'Belgium'; 
		add: 'Netherlands'; add: 'Hungary'; add: 'Denmark'; add: 'Slovakia'; add: 'Finland'; add: 'Italy'; add: 'Austria'; add: 'Estonia'.
	maiden1 add: (Array with: 2000 with: 79 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'Canada'; add: 'Germany'; add: 'Spain'; add: 'Sweden'; add: 'Italy'; add:	'Netherlands'; add: 'Greece'; 
		add: 'France'; add: 'Finland'.
	maiden1 add: (Array with: 1999 with: 28 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'Germany'; add: 'United Kingdom'; add: 'France'; add: 'Spain'; add: 'Italy'; add: 'Japan'; add: 'Brazil'; add: 'Canada'; 
		add: 'Mexico'; add: 'Turkey'; add: 'Greece'; add: 'Argentina'; add: 'Hungary'; add: 'Poland'; add: 'Finland'; add: 'Czech Republic'; add: 'Portugal'; 
		add: 'Malta'; add: 'Belgium'; add: 'Denmark'; add: 'Sweden'; add: 'Switzerland'; add: 'Netherlands'.
	maiden1 add: (Array with: 1998 with: 87 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'France'; add: 'Japan'; add: 'Spain'; add: 'Italy'; add: 'Brazil'; add: 'Canada'; add: 'Argentina'; add: 'United Kingdom'; 
		add: 'Greece'; add: 'Mexico'; add: 'Slovenia'; add: 'Denmark'; add: 'Netherlands'; add: 'Chile'; add: 'Ireland'; add: 'Colombia'; add: 'Finland'; add: 'Belgium'.
	maiden1 add: (Array with: 1996 with: 75 with: arr).
	arr := OrderedCollection new.
	arr add: 'Germany'; add: 'Italy'; add: 'United Kingdom'; add: 'Spain'; add: 'Israel'; add: 'South Africa'; add: 'Sweden'; add: 'Switzerland'; add: 'Greece'; 
		add: 'Denmark'; add: 'Norway'; add: 'Romania'; add: 'Belgium'; add: 'Finland'; add: 'France'; add: 'Portugal'; add: 'Bulgaria'; add: 'Austria'; 
		add: 'Poland'; add: 'Slovakia'; add: 'Netherlands'; add: 'Hungary'; add: 'Czech Republic'.
	maiden1 add: (Array with: 1995 with: 55 with: arr).
	arr := OrderedCollection new.
	arr add: 'Italy'; add: 'United Kingdom'; add: 'Germany'; add: 'France'; add: 'Russia'; add: 'Spain'; add: 'Czech Republic'; add: 'Slovakia'; add: 'Sweden'; 
		add: 'Netherlands'; add: 'Ireland'; add: 'Austria'; add: 'Switzerland'; add: 'Portugal'.
	maiden1 add: (Array with: 1993 with: 45 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'Japan'; add: 'Canada'; add: 'Spain'; add: 'France'; add: 'Mexico'; add: 'Brazil'; add: 'Australia'; add: 'United Kingdom'; 
		add: 'Venezuela'; add: 'Sweden'; add: 'Italy'; add: 'Germany'; add: 'Belgium'; add: 'Argentina'; add: 'Puerto Rico'; add: 'Finland'; add: 'Norway'; 
		add: 'Denmark'; add: 'Switzerland'; add: 'Uruguay'; add: 'Iceland'; add: 'Netherlands'; add: 'New Zealand'.
	maiden1 add: (Array with: 1992 with: 65 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'Canada'; add: 'Japan'; add: 'Switzerland'; add: 'Denmark'; add: 'France'.
	maiden1 add: (Array with: 1991 with: 50 with: arr).
	arr := OrderedCollection new.
	arr add: 'United Kingdom'; add: 'Germany'; add: 'Italy'; add: 'Spain'; add: 'Netherlands'; add: 'Belgium'; add: 'France'; add: 'Sweden'; add: 'Finland'; 
		add: 'Ireland'; add: 'Portugal'; add: 'Norway'; add: 'Denmark'.
	maiden1 add: (Array with: 1990 with: 56 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'United Kingdom'; add: 'Canada'; add: 'Germany'; add: 'Spain'; add: 'France'; add: 'Sweden'; add: 'Finland'; add: 'Portugal'; 
		add: 'Italy'; add: 'Belgium'; add: 'Hungary'; add: 'Denmark'; add: 'Netherlands'; add: 'Austria'; add: 'Switzerland'; add: 'Norway'; add: 'Greece'.
	maiden1 add: (Array with: 1988 with: 97 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'Canada'; add: 'Japan'.
	maiden1 add: (Array with: 1987 with: 85 with: arr).
	arr := OrderedCollection new.
	arr add: 'United Kingdom'; add: 'Germany'; add: 'Poland'; add: 'France'; add: 'Italy'; add: 'Sweden'; add: 'Spain'; add: 'Austria'; add: 'Serbia'; add: 'Portugal';
		add: 'Hungary'; add: 'Switzerland'; add: 'Croatia'; add: 'Slovenia'; add: 'Netherlands'; add: 'Norway'; add: 'Belgium'; add: 'Finland'.
	maiden1 add: (Array with: 1986 with: 66 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'Japan'; add: 'Australia'; add: 'Brazil'; add: 'United Kingdom'.
	maiden1 add: (Array with: 1985 with: 104 with: arr).
	arr := OrderedCollection new.
	arr add: 'United Kingdom'; add: 'Canada'; add: 'Germany'; add: 'United States'; add: 'France'; add: 'Poland'; add: 'Italy'; add: 'Spain'; add: 'Portugal'; 
		add: 'Sweden'; add: 'Slovenia'; add: 'Switzerland'; add: 'Finland'; add: 'Hungary'; add: 'Belgium'; add: 'Netherlands'; add: 'Austria'; add: 'Denmark'; add: 'Serbia'.
	maiden1 add: (Array with: 1984 with: 87 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'United Kingdom'; add: 'Germany'; add: 'Canada'; add: 'France'; add: 'Sweden'; add: 'Netherlands'; add: 'Denmark'; add: 'Belgium'; 
		add: 'Finland'; add: 'Switzerland'; add: 'Norway'.
	maiden1 add: (Array with: 1983 with: 137 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'United Kingdom'; add: 'France'; add: 'Canada'; add: 'Australia'; add: 'Japan'; add: 'Germany'; 
		add: 'Spain'; add: 'Belgium'; add: 'Switzerland'; add: 'Netherlands'.
	maiden1 add: (Array with: 1982 with: 181 with: arr).
	arr := OrderedCollection new.
	arr add: 'United States'; add: 'United Kingdom'; add: 'France'; add: 'Germany'; add: 'Italy'; add: 'Sweden'; add: 'Netherlands'; add: 'Japan'; add: 'Canada'; 
		add: 'Denmark'; add: 'Belgium'; add: 'Serbia'; add: 'Switzerland'.
	maiden1 add: (Array with: 1981 with: 137 with: arr).
	arr := OrderedCollection new.
	arr add: 'United Kingdom'; add: 'Germany'; add: 'Italy'; add: 'France'; add: 'Belgium'; add: 'Sweden'; add: 'Portugal'; add: 'Netherlands'; add: 'Finland'; 
		add: 'Norway'; add: 'Switzerland'; add: 'Ireland'; add: 'Denmark'.
	maiden1 add: (Array with: 1980 with: 157 with: arr).
	maiden1 add: (Array with: 1979 with: 89 with: (Array with: 'United Kingdom') ).
	maiden1 add: (Array with: 1978 with: 4 with: (Array with: 'United Kingdom')).
	maiden1 add: (Array with: 1977 with: 38 with: (Array with: 'United Kingdom')).
	maiden1 add: (Array with: 1976 with: 34 with: (Array with: 'United Kingdom')).
	
	maiden2 := OrderedCollection new.
	maiden2 add: 'United States' -> 686; add: 'United Kingdom' -> 538; add: 'Germany' -> 154; add: 'Canada' -> 111; add: 'France' -> 109; add: 'Japan' -> 70; 
		add: 'Italy' -> 70; add: 'Spain' -> 68; add: 'Sweden' -> 39; add: 'Australia' -> 32; add: 'Brazil' -> 32; add: 'Netherlands' -> 28; add: 'Finland' -> 24; 
		add: 'Belgium' -> 24; add: 'Poland' -> 23; add: 'Switzerland' -> 22; add: 'Denmark' -> 19; add: 'Norway' -> 18; add: 'Mexico' -> 17; add: 'Portugal' -> 16; 
		add: 'Greece' -> 13; add: 'Czech Republic' -> 11; add: 'Austria' -> 11; add: 'Hungary' -> 10; add: 'Argentina' -> 10; add: 'Ireland' -> 8; add: 'Russia' -> 8; 
		add: 'Chile' -> 7; add: 'Serbia' -> 5; add: 'Slovenia' -> 5; add: 'Slovakia' -> 5; add: 'Croatia' -> 4; add: 'Romania' -> 4; add: 'Colombia' -> 4; 
		add: 'Turkey' -> 4; add: 'New Zealand' -> 3; add: 'Venezuela' -> 3; add: 'India' -> 3; add: 'Israel' -> 3; add: 'South Africa' -> 3; add: 'Puerto Rico' -> 3; 
		add: 'United Arab Emirates' -> 2; add: 'Indonesia' -> 2; add: 'Bulgaria'	-> 2; add: 'Peru' -> 2; add: 'Iceland' -> 2; add: 'Costa Rica' -> 2; add: 'South Korea' -> 1;
		add: 'Uruguay' -> 1; add: 'Ecuador' -> 1; add: 'Estonia' -> 1; add: 'Malta' -> 1; add: 'Singapore' -> 1; add: 'Paraguay' -> 1.
	
	builder := RTDuoDowserBuilder new.
	builder title: 'Iron Maiden'.
	builder legend: 'Concerts around the world per year'.
	builder body: 'Iron Maiden are an English heavy metal band formed in Leyton, east London, in 1975 by bassist and primary songwriter Steve Harris. 
The band''s discography has grown to thirty-seven albums, including fifteen studio albums, eleven live albums, four EPs, and seven compilations.
Pioneers of the New Wave of British Heavy Metal, Iron Maiden achieved initial success during the early 1980s. After several line-up changes, the band went on to release a series of US and UK platinum and gold albums, including 1982''s The Number of the Beast, 1983''s Piece of Mind, 1984''s Powerslave, 1985''s live release Live After Death, 1986''s Somewhere in Time and 1988''s Seventh Son of a Seventh Son. Since the return of lead vocalist Bruce Dickinson and guitarist Adrian Smith in 1999, the band have undergone a resurgence in popularity, with their latest studio offering, The Final Frontier, peaking at No. 1 in 28 different countries and receiving widespread critical acclaim. Considered one of the most successful heavy metal bands in history, Iron Maiden have sold over 85 million records worldwide 
with little radio or television support. The band won the Ivor Novello Award for international achievement in 2002, and were also inducted into the Hollywood RockWalk in Sunset Boulevard, Los Angeles, California during their United States tour in 2005. As of October 2013, the band have played over 2000 live shows throughout their career. For the past 35 years, the band have been supported by their famous mascot, ''Eddie'', who has appeared on almost all of their album 
and single covers, as well as in their live shows.'.
	builder colorLeft: #second.
	builder colorRight: #value.
	builder heightLeft: #second.
	builder heightRight: [:v| (v value / 10) max: 10].
	builder left: maiden1.
	builder right: maiden2.
	builder labelLeft: #first.
	builder labelRight: #key.
	builder edgesTo: [:a :b | a third includes: (b key) ].
	builder open.
]

{ #category : #basic }
RTDowserExample >> manyRelations [
	"
	self new manyRelations
	"
	|builder |
	builder := RTDowserBuilder new.
	builder legend: 'Four Columns'.
	builder addColumn: (1 to: 10).
	builder addColumn: (1 to: 10).
	builder addColumn: (1 to: 10).
	builder addColumn: (1 to: 10).
	builder edgesWith: [ :v | (v - 5) to: (v + 5) ] from: 1 to: 2.
	builder edgesWith: [ :v | (v - 2) to: (v + 2) ] from: 2 to: 3.
	builder edgesWith: [ :v | (v / 2) ] from: 3 to: 4.
	builder open.
]

{ #category : #duoDowser }
RTDowserExample >> numberSubclasses [
	"
	self new numberSubclasses
	"
	| a |
	a := RTDuoDowserBuilder new.
	a label: [ :c | c name asString].
	a height: #numberOfMethods.
	a color: #numberOfLinesOfCode.
	a onLeftAndRight: Number withAllSubclasses.
	a edgesTo: #allSubclasses.
	a open.
	a inspect.
]

{ #category : #duoDowser }
RTDowserExample >> santas [
	"
	self new santas
	"
	|builder hohoho|
	
	hohoho := OrderedCollection new.
	hohoho add: 'Afghanistan' -> 'Baba Chaghaloo'; add: 'Albania' -> 'Babadimri'; add: 'Argentina' -> 'Papá Noel'; add: 'Armenia' -> 'Gaghant Baba'; 
		add: 'Belgium' -> 'Pere Noel'; add: 'Bosnia and Herzegovina' -> 'Deda Mraz'; add: 'Bolivia' -> 'Papá Noel'; add: 'Brazil' -> 'Papai Noel'; 
		add: 'Bulgaria' -> 'Dyado Koleda'; add: 'Canada' -> 'Santa Claus'; add: 'Chile' -> 'Viejo Pascuero'; add: 'China' -> 'Dun Che Lao Ren';
		add: 'Colombia' -> 'Papá Noel'; add: 'Denmark' -> 'Julemanden'; add: 'Ecuador' -> 'Papá Noel'; add: 'Egypt' -> 'Papa Noël'; add: 'France' -> 'Pere Noel';
		add: 'French Canada' -> 'Père Noël'; add: 'Finland' -> 'Joulupukki'; add: 'Germany' -> 'Weihnachtsmann'; add: 'Hawaii' -> 'Kanakaloka'; 
		add: 'Hungary' -> 'Mikulas'; add: 'Iran' -> 'Baba Noel'; add: 'Iraq' -> 'Vader Kersfees'; add: 'Ireland' -> 'Daidí na Nollaig'; add: 'Italy' -> 'Babbo Natale';
		add: 'Jamaica' -> 'Santa Claus'; add: 'Japan' -> 'Hoteiosho'; add: 'Lithuania' -> 'Kaledu Senelis'; add: 'Malta' -> 'San Niklaw';
		add: 'Netherlands' -> 'Kerstman'; add: 'Norway' -> 'Julenissen'; add: 'Perú' -> 'Papá Noel'; add: 'Poland' -> 'Swiety Mikolaj'; add: 'Portugal' -> 'Pai Natal'; 
		add: 'Romania' -> 'Mos Craciun'; add: 'Russia' -> 'Ded Moroz'; add: 'Serbia' -> 'Deda Mraz'; add: 'Scottish Highlands' -> 'Daidaín na Nollaig'; 
		add: 'South Africa' -> 'Vader Kersfees'; add: 'Spain' -> 'Papá Noel'; add: 'Sweden' -> 'Jultomten'; add: 'Turkey' -> 'Noel Baba'; 
		add: 'United Kingdom' -> 'Father Christmas'; add: 'US' -> 'Santa Claus'.
	
	builder := RTDuoDowserBuilder new.
	builder title: 'Merry Christmas'.
	builder legend: 'Santa Claus over the World'.
	builder colorLeft: (Color green).
	builder colorRight: (Color red).
	builder left: hohoho.
	builder labelLeft: #key.
	builder edgesTo: #value.
	builder open.
]

{ #category : #duoDowser }
RTDowserExample >> singleParameterRelation [
	"
	self new singleParameterRelation
	"
	| builder | 
	builder := RTDuoDowserBuilder new.
	builder legend: 'Power'.
	builder onLeftAndRight: (1 to: 20).
	builder edgesTo: [ :v | v * v].
	builder open
]

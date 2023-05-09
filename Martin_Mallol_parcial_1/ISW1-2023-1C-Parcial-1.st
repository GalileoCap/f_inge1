!classDefinition: #TestDePerforación category: 'ISW1-2023-1C-Parcial-1'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:55:31'!
assertCalcula: aBlock igualQue: aNumber

	| excavadora sueloAExcavar |
	
	sueloAExcavar := Suelo with:{ CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar capas.
	
	self assert: aNumber equals: (aBlock value: excavadora).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 20:52:44'!
createExcavadoraWithSuelo: aSuelo andMecha: aMecha
	| excavadora |
	
	excavadora := Perforadora sobreSuelo: aSuelo.
	aMecha mePoneComoMecha: excavadora.
		
	^excavadora.
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:48:34'!
createExcavadoraWithSuelo: aSuelo andMecha: aMecha andDo: anAccion
	| excavadora |
	
	excavadora := Perforadora sobreSuelo: aSuelo.
	aMecha mePoneComoMecha: excavadora.
	
	anAccion value: excavadora.
		
	^excavadora.
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:25:27'!
shouldThrowNoPuedePerforarError: anExcavadora withExpectedCapaDeSueloInmediata: aCapaDeSuelo
	
	self should: [anExcavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'No puede perforar' equals: unError messageText.
			self assert: (aCapaDeSuelo) equals: anExcavadora capaDeSueloInmediata ].	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:21:18'!
shouldThrowSeRompioErrorWIth: anExcavadora

	self should: [anExcavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: anExcavadora conMechaRota ].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:50:52'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| excavadora sueloAExcavar |
	sueloAExcavar := Suelo with: {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := self createExcavadoraWithSuelo: sueloAExcavar capas andMecha: Soft new andDo: [:aValue | aValue darGolpeDeTaladro.]. 
		
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:53:22'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := Suelo with: {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := self createExcavadoraWithSuelo: sueloAExcavar capas andMecha: Soft new andDo: [:aValue | aValue darGolpeDeTaladro.]. 
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:53:32'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := Suelo with: {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.} .
	
	excavadora := self createExcavadoraWithSuelo: sueloAExcavar capas andMecha: Soft new andDo: [:aValue | aValue ]. 
	
	self shouldThrowSeRompioErrorWIth: excavadora.
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:53:44'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := Suelo with: {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := self createExcavadoraWithSuelo: sueloAExcavar capas andMecha: Widia new andDo: [:aValue | aValue darGolpeDeTaladro.]. 
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:53:52'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := Suelo with: {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := self createExcavadoraWithSuelo: sueloAExcavar capas andMecha: Widia new andDo: [:aValue | aValue darDosGolpesDeTaladro]. 
	
	self assert: CapaDeSuelo arenoso equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:54:03'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := Suelo with: {
			CapaDeSuelo concretoConResistencia: 5.	
			CapaDeSuelo tierra.
} .
	
	excavadora := self createExcavadoraWithSuelo: sueloAExcavar capas andMecha: Widia new andDo: [:aValue | aValue darDosGolpesDeTaladro]. 
	
	self shouldThrowSeRompioErrorWIth: excavadora.
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:54:12'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := Suelo with: {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := self createExcavadoraWithSuelo: sueloAExcavar capas andMecha: Diamante new andDo: [ :aValue | aValue ]. 
	
	self shouldThrowSeRompioErrorWIth: excavadora.! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:54:23'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := Suelo with: {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := self createExcavadoraWithSuelo: sueloAExcavar capas andMecha: Diamante new andDo: [:aValue | aValue darGolpeDeTaladro]. 
	
	self assert: (CapaDeSuelo concretoConResistencia: 5) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:54:32'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| excavadora sueloAExcavar |
	
	sueloAExcavar := Suelo with: {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.
			} .
	
	excavadora := self createExcavadoraWithSuelo: sueloAExcavar capas andMecha: Diamante new andDo: [:aValue | aValue darDosGolpesDeTaladro]. 
	
	self assert: (CapaDeSuelo concretoConResistencia: 4) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:54:41'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	| excavadora sueloAExcavar |
	
	sueloAExcavar := Suelo with: {
			CapaDeSuelo arenoso.
			'Mica'.
			'Marmol'
			} .
	
	excavadora := self createExcavadoraWithSuelo: sueloAExcavar capas andMecha: Soft new andDo: [:aValue | aValue darGolpeDeTaladro]. 
	
	self assert: {	'Mica'. 'Marmol'} equals: excavadora elementsInContainer
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:54:48'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada

	| excavadora sueloAExcavar |
	
	sueloAExcavar := Suelo with: {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := self createExcavadoraWithSuelo: sueloAExcavar capas andMecha: Soft new andDo: [:aValue | aValue darGolpeDeTaladro]. 
	
	self assert: excavadora elementsInContainer isEmpty
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:54:58'!
test12NoPuedePerforarSinMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := Suelo with: {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar capas.
	
	self shouldThrowNoPuedePerforarError: excavadora withExpectedCapaDeSueloInmediata: CapaDeSuelo arenoso.
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:55:09'!
test13PuedeCalcularProfundidadDelSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := Suelo with: { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso} .
	excavadora := Perforadora sobreSuelo: sueloAExcavar capas.
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:08:17'!
test14PuedeContarLasCapasDeTipoArenoso
	
	self assertCalcula: [:aValue | aValue contarCapas: (Arenoso new)] igualQue: 2.! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:07:31'!
test15PuedeContarLasCapasDeTipoTierra

	self assertCalcula: [:aValue | aValue contarCapas: (Tierra new)] igualQue: 1.! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:07:01'!
test16PuedeContarLasCapasDeTipoConcreto

	self assertCalcula: [:aValue | aValue contarCapas: (Concreto new)] igualQue: 1.
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:06:29'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso

	self assertCalcula: [:aValue | aValue calcularProfundidadDelSueloHasta: Arenoso new] igualQue: 0.
	! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:05:57'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra
	
	self assertCalcula: [:aValue | aValue calcularProfundidadDelSueloHasta: Tierra new] igualQue: 2.
! !

!TestDePerforación methodsFor: 'test' stamp: 'mm 5/8/2023 21:05:25'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto

	self assertCalcula: [:aValue | aValue calcularProfundidadDelSueloHasta: Concreto new] igualQue: 42.
	! !


!classDefinition: #Mecha category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Mecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Mecha methodsFor: 'asignar' stamp: 'mm 5/8/2023 20:46:52'!
mePoneComoMecha: aPerforadora

	self subclassResponsibility.! !


!Mecha methodsFor: 'excavar' stamp: 'mm 5/8/2023 19:20:26'!
perforadoraDaGolpeDeTaladroEnSueloArenoso: aPerforadora

	aPerforadora error: 'error'.! !

!Mecha methodsFor: 'excavar' stamp: 'mm 5/8/2023 19:20:24'!
perforadoraDaGolpeDeTaladroEnSueloConcreto: aPerforadora

	aPerforadora error: 'error'.! !

!Mecha methodsFor: 'excavar' stamp: 'mm 5/8/2023 18:40:09'!
perforadoraDaGolpeDeTaladroEnSueloTierra: aPerforadora

	aPerforadora error: 'error'.! !


!classDefinition: #Diamante category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Diamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Diamante methodsFor: 'excavar' stamp: 'mm 5/8/2023 19:18:29'!
perforadoraDaGolpeDeTaladroEnSueloArenoso: aPerforadora

	aPerforadora seRompeMechaConError.! !

!Diamante methodsFor: 'excavar' stamp: 'mm 5/8/2023 18:59:52'!
perforadoraDaGolpeDeTaladroEnSueloConcreto: aPerforadora

	aPerforadora vecesQueGolpeoCapaActualIsEven ifTrue: [ ^aPerforadora capaDeSueloInmediata bajaUnDecimoDeResistencia].
	aPerforadora capaDeSueloInmediata sinResistencia ifTrue: [ ^aPerforadora transformarCapaEnArenoso].
	^aPerforadora getVecesQueGolpeoCapaActual! !

!Diamante methodsFor: 'excavar' stamp: 'mm 5/8/2023 18:36:12'!
perforadoraDaGolpeDeTaladroEnSueloTierra: aPerforadora

	^aPerforadora pasarAProximaCapa.! !


!Diamante methodsFor: 'asignar' stamp: 'mm 5/8/2023 20:46:13'!
mePoneComoMecha: aPerforadora

	^aPerforadora ponerMechaDiamante .! !


!classDefinition: #Rota category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Rota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Rota methodsFor: 'check' stamp: 'mm 5/8/2023 19:15:03'!
isEqualTo: aMecha
	"comment stating purpose of message"
	
	^self class = aMecha class.! !


!classDefinition: #SinMecha category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #SinMecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!SinMecha methodsFor: 'excavar' stamp: 'mm 5/8/2023 18:34:00'!
perforadoraDaGolpeDeTaladroEnSueloArenoso: aPerforadora

	aPerforadora error: 'No puede perforar'.! !

!SinMecha methodsFor: 'excavar' stamp: 'mm 5/8/2023 18:34:19'!
perforadoraDaGolpeDeTaladroEnSueloConcreto: aPerforadora

	aPerforadora error: 'No puede perforar'.! !

!SinMecha methodsFor: 'excavar' stamp: 'mm 5/8/2023 18:34:13'!
perforadoraDaGolpeDeTaladroEnSueloTierra: aPerforadora

	aPerforadora error: 'No puede perforar'.! !


!classDefinition: #Soft category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Soft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Soft methodsFor: 'asignar' stamp: 'mm 5/8/2023 20:46:03'!
mePoneComoMecha: aPerforadora

	^aPerforadora ponerMechaSoft.! !


!Soft methodsFor: 'excavar' stamp: 'mm 5/8/2023 18:32:39'!
perforadoraDaGolpeDeTaladroEnSueloArenoso: aPerforadora

	^aPerforadora pasarAProximaCapa.! !

!Soft methodsFor: 'excavar' stamp: 'mm 5/8/2023 19:18:39'!
perforadoraDaGolpeDeTaladroEnSueloConcreto: aPerforadora

	^aPerforadora seRompeMechaConError.! !

!Soft methodsFor: 'excavar' stamp: 'mm 5/8/2023 18:35:14'!
perforadoraDaGolpeDeTaladroEnSueloTierra: aPerforadora

	^aPerforadora.! !


!classDefinition: #Widia category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Widia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Widia methodsFor: 'asignar' stamp: 'mm 5/8/2023 20:45:54'!
mePoneComoMecha: aPerforadora

	^aPerforadora ponerMechaWidia.! !


!Widia methodsFor: 'excavar' stamp: 'mm 5/8/2023 18:32:59'!
perforadoraDaGolpeDeTaladroEnSueloArenoso: aPerforadora

	^aPerforadora pasarAProximaCapa.! !

!Widia methodsFor: 'excavar' stamp: 'mm 5/8/2023 19:18:44'!
perforadoraDaGolpeDeTaladroEnSueloConcreto: aPerforadora

	(aPerforadora vecesQueGolpeoCapaActualIs: 3) ifTrue: [ ^aPerforadora seRompeMechaConError ].
	^self! !

!Widia methodsFor: 'excavar' stamp: 'mm 5/8/2023 18:35:39'!
perforadoraDaGolpeDeTaladroEnSueloTierra: aPerforadora

	(aPerforadora vecesQueGolpeoCapaActualIs: 2) ifTrue: [ ^aPerforadora transformarCapaEnArenoso ].! !


!classDefinition: #Perforadora category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Perforadora
	instanceVariableNames: 'tipoDeSuelo mechaPuesta vecesQueGolpeoCapaActual capasDeSueloDebajo container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Perforadora methodsFor: 'cambiar capa' stamp: 'mm 5/8/2023 19:42:56'!
pasarAProximaCapa
	
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst.
	capasDeSueloDebajo ifEmpty: [^self]. 
	(self capaDeSueloInmediata isKindOf: CapaDeSuelo) ifFalse:[
			container addAll: capasDeSueloDebajo.
		]! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 4/27/2023 20:46:30'!
transformarCapaEnArenoso
	capasDeSueloDebajo :=
			capasDeSueloDebajo allButFirst asOrderedCollection
			addFirst: CapaDeSuelo arenoso;
			yourself! !


!Perforadora methodsFor: 'excavation' stamp: 'mm 5/8/2023 20:58:04'!
darDosGolpesDeTaladro
	
	self darGolpeDeTaladro.
	self darGolpeDeTaladro! !

!Perforadora methodsFor: 'excavation' stamp: 'mm 5/8/2023 19:42:20'!
darGolpeDeTaladro
	
	vecesQueGolpeoCapaActual := vecesQueGolpeoCapaActual + 1.
	
	^self capaDeSueloInmediata perforadoraDaGolpeDeTaladro: self.! !

!Perforadora methodsFor: 'excavation' stamp: 'mm 5/8/2023 18:59:27'!
darGolpeDeTaladroEnSueloArenoso

	^mechaPuesta perforadoraDaGolpeDeTaladroEnSueloArenoso: self.! !

!Perforadora methodsFor: 'excavation' stamp: 'mm 5/8/2023 18:59:23'!
darGolpeDeTaladroEnSueloConcreto

	^mechaPuesta perforadoraDaGolpeDeTaladroEnSueloConcreto: self.! !

!Perforadora methodsFor: 'excavation' stamp: 'mm 5/8/2023 18:59:19'!
darGolpeDeTaladroEnSueloTierra

	^mechaPuesta perforadoraDaGolpeDeTaladroEnSueloTierra: self.! !

!Perforadora methodsFor: 'excavation' stamp: 'mm 5/8/2023 19:08:54'!
getVecesQueGolpeoCapaActual

	^vecesQueGolpeoCapaActual.! !

!Perforadora methodsFor: 'excavation' stamp: 'mm 5/8/2023 17:53:38'!
vecesQueGolpeoCapaActualIs: aCantidadDeVeces

	^vecesQueGolpeoCapaActual = aCantidadDeVeces.! !

!Perforadora methodsFor: 'excavation' stamp: 'mm 5/8/2023 17:59:52'!
vecesQueGolpeoCapaActualIsEven

	^vecesQueGolpeoCapaActual even.! !


!Perforadora methodsFor: 'initialization' stamp: 'mm 5/8/2023 19:45:47'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	capasDeSueloDebajo := capasDeSueloAExcavarInicialmente.
	vecesQueGolpeoCapaActual := 0.
	container := OrderedCollection new.
	mechaPuesta := SinMecha new.! !


!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:17:21'!
capaDeSueloInmediata
	^capasDeSueloDebajo first! !

!Perforadora methodsFor: 'accessing' stamp: 'mm 5/8/2023 19:14:43'!
conMechaRota

	^Rota new isEqualTo: mechaPuesta! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:12:20'!
elementsInContainer
	^container asArray! !

!Perforadora methodsFor: 'accessing' stamp: 'mm 5/8/2023 18:45:31'!
sinMecha

	^mechaPuesta = SinMecha.! !


!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:17'!
sobreSueloArenoso
	^capasDeSueloDebajo first esArenoso! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:16:14'!
sobreSueloConcreto
	^capasDeSueloDebajo first esConcreto! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:58'!
sobreSueloTierra
	^capasDeSueloDebajo first esTierra! !


!Perforadora methodsFor: 'colocar mecha' stamp: 'mm 5/8/2023 18:42:17'!
ponerMechaDiamante
	mechaPuesta := Diamante new.! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'mm 5/8/2023 18:42:25'!
ponerMechaSoft
	mechaPuesta := Soft new.! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'mm 5/8/2023 18:42:35'!
ponerMechaWidia
	mechaPuesta := Widia new.! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'mm 5/8/2023 18:41:50'!
seRompeMecha

	^mechaPuesta := Rota new.! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'mm 5/8/2023 19:17:59'!
seRompeMechaConError

	mechaPuesta := Rota new.
	self error: 'Se rompió'.
	! !


!Perforadora methodsFor: 'scan' stamp: 'mm 5/8/2023 20:30:53'!
calcularProfundidadDelSuelo
	
	| profundidades |
	
	"Primero seteo alturas nil a 0, luego hago sum de todo."	
	
	profundidades := self profundidadesDeLasCapasDelSuelo. 
	
	^profundidades sum.
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'mm 5/8/2023 20:26:34'!
calcularProfundidadDelSueloHasta: tipoDeCapa
	
	| valorDeCapa profundidadAcumulada|
	
	valorDeCapa := tipoDeCapa scan.
	
	self cambiarAlturaNilDeProfundidadPor0.
	
	profundidadAcumulada := 0.	
	capasDeSueloDebajo do: [ :aCapa |
		valorDeCapa = aCapa scan ifTrue: [ ^ profundidadAcumulada ].
		profundidadAcumulada := profundidadAcumulada + aCapa altura.
	].

	^ profundidadAcumulada.
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'mm 5/8/2023 20:28:54'!
cambiarAlturaNilDeProfundidadPor0
	
	capasDeSueloDebajo do: [ :aCapa | 		aCapa altura = nil ifTrue: [ ^aCapa setAltura: 0]. 	].! !

!Perforadora methodsFor: 'scan' stamp: 'mm 5/8/2023 20:08:40'!
contarCapas: tipoDeCapa
	
	"Cuenta las capas de tipo tipoDeCapa. Recordar que para identificar cada capa se utiliza el valor de scan que retorna. Por ej. un capa tipo Arenoso retorna 7 al scan"
	
	| valorDeCapa |
	
	valorDeCapa := tipoDeCapa scan.
	
	^ capasDeSueloDebajo count: [ :aCapa | valorDeCapa = aCapa scan].! !

!Perforadora methodsFor: 'scan' stamp: 'mm 5/8/2023 20:17:14'!
profundidadesDeLasCapasDelSuelo

	^ (capasDeSueloDebajo collect: [:aCapa | aCapa altura]) copyWithout: nil! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: 'ISW1-2023-1C-Parcial-1'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'ARM 4/27/2023 20:07:05'!
sobreSuelo: capasDeSueloAExcavar 

	^self new initializeSobreSuelo: capasDeSueloAExcavar ! !


!classDefinition: #Suelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Suelo
	instanceVariableNames: 'suelo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Suelo methodsFor: 'as yet unclassified' stamp: 'mm 5/8/2023 21:47:29'!
capas
	"comment stating purpose of message"

	^suelo.! !

!Suelo methodsFor: 'as yet unclassified' stamp: 'mm 5/8/2023 21:45:17'!
initializeCapas: aCapaDeSueloList

	| idx |
	suelo := aCapaDeSueloList.
	
	idx := 1.
	[idx < suelo size] whileTrue: [
		((suelo at: idx) = (suelo at: (idx+1))) ifTrue: [ self class dosCapasContiguasNoPuedenSerDelMismoTipoErrorDescription ].
		idx := idx + 1.
		].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Suelo class' category: 'ISW1-2023-1C-Parcial-1'!
Suelo class
	instanceVariableNames: ''!

!Suelo class methodsFor: 'as yet unclassified' stamp: 'mm 5/8/2023 21:29:09'!
dosCapasContiguasNoPuedenSerDelMismoTipoErrorDescription
	
	^'no se debe poder crear un suelo donde dos capas contiguas sean del mismo tipo de suelo.'! !

!Suelo class methodsFor: 'as yet unclassified' stamp: 'mm 5/8/2023 21:52:49'!
with: aCapaDeSueloList
	"comment stating purpose of message"

	^self new initializeCapas: aCapaDeSueloList.! !


!classDefinition: #CapaDeSuelo category: 'ISW1-2023-1C-Parcial-1'!
Suelo subclass: #CapaDeSuelo
	instanceVariableNames: 'tipo resistencia altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDeSuelo methodsFor: 'initialization' stamp: 'FRT 5/5/2023 16:08:54'!
initializeArenoso
	
	tipo := #Arenoso.
	altura := nil.! !

!CapaDeSuelo methodsFor: 'initialization' stamp: 'ARM 5/8/2023 13:10:22'!
initializeConcretoConResistencia: resistenciaInicial 

	resistencia := resistenciaInicial.
	tipo := #Concreto.
	altura := nil.! !

!CapaDeSuelo methodsFor: 'initialization' stamp: 'FRT 5/5/2023 16:08:42'!
initializeTierra
	
	tipo := #Tierra.
	altura := nil.! !


!CapaDeSuelo methodsFor: 'tipo' stamp: 'ARM 4/27/2023 20:13:01'!
esArenoso
	^tipo = #Arenoso! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'ARM 4/27/2023 20:15:50'!
esConcreto
	^tipo = #Concreto! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'ARM 4/27/2023 20:14:55'!
esTierra
	^tipo = #Tierra! !


!CapaDeSuelo methodsFor: 'comparing' stamp: 'ARM 5/8/2023 13:10:22'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: self class) and: [ tipo = unaCapaDeSuelo tipo and: [resistencia = unaCapaDeSuelo resistencia]]! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'ARM 5/8/2023 13:10:22'!
hash

	^tipo hash + resistencia hash! !


!CapaDeSuelo methodsFor: 'bajar resistencia' stamp: 'ARM 5/8/2023 13:10:22'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!CapaDeSuelo methodsFor: 'bajar resistencia' stamp: 'ARM 5/8/2023 13:10:22'!
sinResistencia
	^resistencia = 0! !


!CapaDeSuelo methodsFor: 'accessing' stamp: 'FRT 5/5/2023 16:48:52'!
altura

	^ altura.! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'ARM 5/8/2023 13:10:35'!
resistencia

	^ resistencia.! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:18:41'!
tipo

	^tipo! !


!CapaDeSuelo methodsFor: 'scan' stamp: 'mm 5/8/2023 20:08:08'!
scan

	self subclassResponsibility.! !


!CapaDeSuelo methodsFor: 'setters' stamp: 'mm 5/8/2023 18:56:44'!
perforadoraDaGolpeDeTaladro: aPerforadora.
	self subclassResponsibility.! !

!CapaDeSuelo methodsFor: 'setters' stamp: 'FRT 5/5/2023 16:07:55'!
setAltura: unaAltura

	altura := unaAltura! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSuelo class' category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo class
	instanceVariableNames: ''!

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'mm 5/8/2023 18:03:08'!
arenoso

	^Arenoso new initializeArenoso! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'mm 5/8/2023 18:03:35'!
concretoConResistencia: resistencia 

	^Concreto new initializeConcretoConResistencia: resistencia ! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'mm 5/8/2023 18:03:43'!
tierra

	^Tierra new initializeTierra! !


!classDefinition: #Arenoso category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Arenoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Arenoso methodsFor: 'setters' stamp: 'mm 5/8/2023 19:20:14'!
perforadoraDaGolpeDeTaladro: aPerforadora.

	^aPerforadora darGolpeDeTaladroEnSueloArenoso.
	"aPerforadora error: 'error'."! !


!Arenoso methodsFor: 'scan' stamp: 'mm 5/8/2023 20:08:17'!
scan

	 ^7.! !


!classDefinition: #Concreto category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Concreto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Concreto methodsFor: 'setters' stamp: 'mm 5/8/2023 19:16:25'!
perforadoraDaGolpeDeTaladro: aPerforadora.

	^aPerforadora darGolpeDeTaladroEnSueloConcreto.
	"aPerforadora error: 'error'."! !


!Concreto methodsFor: 'scan' stamp: 'mm 5/8/2023 20:08:24'!
scan

	^ 50. ! !


!classDefinition: #Tierra category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Tierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Tierra methodsFor: 'setters' stamp: 'mm 5/8/2023 19:16:32'!
perforadoraDaGolpeDeTaladro: aPerforadora.
	
	^aPerforadora darGolpeDeTaladroEnSueloTierra! !


!Tierra methodsFor: 'scan' stamp: 'mm 5/8/2023 20:08:30'!
scan

	^10.! !

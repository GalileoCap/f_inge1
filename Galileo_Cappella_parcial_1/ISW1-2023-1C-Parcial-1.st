!classDefinition: #TestDePerforación category: 'ISW1-2023-1C-Parcial-1'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 20:26:00'!
noPuedeExcavarSobreSuelo: capasDeSuelo conMecha: unTipoDeMecha
	| excavadora |
	
	excavadora := Perforadora sobreSuelo: capasDeSuelo conMecha: unTipoDeMecha.
		
	self should: [excavadora darGolpeDeTaladro]
	raise: Error
	withExceptionDo: [:unError |
		self assert: 'Se rompió' equals: unError messageText.
		self assert: excavadora conMechaRota.
	].! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 20:29:50'!
sobreSuelo: capasDeSuelo conMecha: unTipoDeMecha darGolpes: n yPrimeraCapaDebeSer: unTipoDeCapa
	self sobreSuelo: capasDeSuelo conMecha: unTipoDeMecha darGolpes: n yRevisar: [ :excavadora | self assert: (excavadora capaDeSueloInmediata isKindOf: unTipoDeCapa) ].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 20:29:50'!
sobreSuelo: capasDeSuelo conMecha: unTipoDeMecha darGolpes: n yRevisar: anAssertingBlock
	| excavadora |
	
	excavadora := Perforadora sobreSuelo: capasDeSuelo conMecha: unTipoDeMecha.
	
	excavadora darGolpesDeTaladro: n.
	
	anAssertingBlock value: excavadora.
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:05:15'!
sobreSuelo: capasDeSuelo cuenta: n capasDeTipo: unTipoDeCapa

	| excavadora |
	
	excavadora := Perforadora sobreSuelo: capasDeSuelo.
	
	self assert: n equals: (excavadora contarCapas: unTipoDeCapa).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:05:09'!
sobreSuelo: capasDeSuelo cuentaProfundidad: n hastaCapaDeTipo: unTipoDeCapa

	| excavadora |
	
	excavadora := Perforadora sobreSuelo: capasDeSuelo.
	
	self assert: n equals: (excavadora calcularProfundidadDelSueloHasta: unTipoDeCapa).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:19:03'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa	

	self sobreSuelo: {
		CapaArenosa new.
		CapaTierra new.
		CapaConcreto conResistencia: 5
	} conMecha: MechaSoft darGolpes: 1 yPrimeraCapaDebeSer: CapaTierra.
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:19:28'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	self sobreSuelo: {
		CapaTierra new.
		CapaConcreto conResistencia: 5
	} conMecha: MechaSoft darGolpes: 1 yPrimeraCapaDebeSer: CapaTierra.
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:19:41'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	
	
	self noPuedeExcavarSobreSuelo: {
		CapaConcreto conResistencia: 5.
		CapaTierra new.
	} conMecha: MechaSoft.
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:25:26'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	
	
	self sobreSuelo: {
		CapaArenosa new.
		CapaTierra new.
		CapaConcreto conResistencia: 5.
	} conMecha: MechaWidia darGolpes: 1 yPrimeraCapaDebeSer: CapaTierra.
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:25:32'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	
	
	self sobreSuelo: {
		CapaTierra new.
		CapaConcreto conResistencia: 5.
	} conMecha: MechaWidia darGolpes: 2 yPrimeraCapaDebeSer: CapaArenosa.
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:25:40'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	self sobreSuelo: {
		CapaConcreto conResistencia: 5.	
		CapaTierra new.
	} conMecha: MechaWidia darGolpes: 2 yRevisar: [ :excavadora |
		self should: [excavadora darGolpeDeTaladro]
			raise: Error
			withExceptionDo: [:unError |
				self assert: 'Se rompió' equals: unError messageText.
				self assert: excavadora conMechaRota.
			].
	]
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:25:43'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	self sobreSuelo: {
		CapaArenosa new.
		CapaTierra new.
		CapaConcreto conResistencia: 5
	} conMecha: MechaDiamante darGolpes: 0 yRevisar: [ :excavadora |
		self should: [excavadora darGolpeDeTaladro]
			raise: Error
			withExceptionDo: [:unError |
				self assert: 'Se rompió' equals: unError messageText.
				self assert: excavadora conMechaRota ].
	].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:25:46'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa
	
	self sobreSuelo: {
		CapaTierra new.
		CapaConcreto conResistencia: 5
	} conMecha: MechaDiamante darGolpes: 1 yRevisar: [ :excavadora |
		self assert: 5 equals: (excavadora capaDeSueloInmediata resistencia).
	].

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:25:50'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	self sobreSuelo: {
		CapaConcreto conResistencia: 5.
		CapaTierra new.
	} conMecha: MechaDiamante darGolpes: 2 yRevisar: [ :excavadora |
		self assert: 4 equals: (excavadora capaDeSueloInmediata resistencia).
	].

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:20:06'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	self sobreSuelo: {
		CapaArenosa new.
		'Mica'.
		'Marmol'
	} conMecha: MechaSoft darGolpes: 1 yRevisar: [ :excavadora |
		self assert: {	'Mica'. 'Marmol'} equals: excavadora elementsInContainer
	].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:20:12'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada
	
	self sobreSuelo: {
		CapaArenosa new.
	} conMecha: MechaSoft darGolpes: 1 yRevisar: [ :excavadora |
		self assert: excavadora elementsInContainer isEmpty
	].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:20:15'!
test12NoPuedePerforarSinMecha

	| excavadora |
	
	excavadora := Perforadora sobreSuelo: {
		CapaArenosa new.
	}.
		
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'No puede perforar' equals: unError messageText.
			self assert: (CapaDeSuelo arenoso) equals: excavadora capaDeSueloInmediata ].	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:24:49'!
test13PuedeCalcularProfundidadDelSuelo

	| excavadora |
	
	excavadora := Perforadora sobreSuelo: { CapaArenosa new setAltura: 2. CapaTierra new setAltura: 40. CapaDeSuelo arenoso} .
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:25:59'!
test14PuedeContarLasCapasDeTipoArenoso

	self sobreSuelo: {
		CapaArenosa new setAltura: 2.
		CapaTierra new setAltura: 40.
		CapaArenosa new.
		CapaConcreto conResistencia: 10
	} cuenta: 2 capasDeTipo: CapaArenosa.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:26:02'!
test15PuedeContarLasCapasDeTipoTierra

	self sobreSuelo: {
		CapaArenosa new setAltura: 2.
		CapaTierra new setAltura: 40.
		CapaArenosa new.
		CapaConcreto conResistencia: 10
	} cuenta: 1 capasDeTipo: CapaTierra.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:26:06'!
test16PuedeContarLasCapasDeTipoConcreto

	
	
	self sobreSuelo: { CapaArenosa new setAltura: 2. CapaTierra new setAltura: 40. CapaArenosa new. CapaConcreto conResistencia: 10 }
		cuenta: 1 capasDeTipo: CapaConcreto.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:26:13'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso

	
	
	self sobreSuelo: { CapaArenosa new setAltura: 2. CapaTierra new setAltura: 40. CapaArenosa new. CapaConcreto conResistencia: 10 }
		cuentaProfundidad: 0 hastaCapaDeTipo: CapaArenosa.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:26:16'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra

	
	
	self sobreSuelo: { CapaArenosa new setAltura: 2. CapaTierra new setAltura: 40. CapaArenosa new. CapaConcreto conResistencia: 10 }
		cuentaProfundidad: 2 hastaCapaDeTipo: CapaTierra.
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:26:19'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto

	
	
	self sobreSuelo: {CapaArenosa new setAltura: 2. CapaTierra new setAltura: 40. CapaArenosa new. CapaConcreto conResistencia: 10 }
	cuentaProfundidad: 42 hastaCapaDeTipo: CapaConcreto.

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FGCL 5/8/2023 21:24:12'!
test20NoSePuedeCrearSueloConCapasContiguasDelMismoTipo

	self should: [Perforadora sobreSuelo: {	 CapaArenosa new. CapaArenosa new. } ]
		raise: Error
		withExceptionDo: [:unError |
			self assert: (Perforadora capasContiguasErrorMessage) equals: (unError messageText).
		].
! !


!classDefinition: #CapaDeSuelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: 'altura vecesQueFueGolpeada'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDeSuelo methodsFor: 'tipo' stamp: 'FGCL 5/8/2023 18:12:06'!
esArenoso
	self subclassResponsibility.! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'FGCL 5/8/2023 18:12:03'!
esConcreto
	self subclassResponsibility.! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'FGCL 5/8/2023 18:12:01'!
esTierra
	self subclassResponsibility.! !


!CapaDeSuelo methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 18:28:26'!
= unaCapaDeSuelo
	^(unaCapaDeSuelo isKindOf: self class)! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 21:14:25'!
checkDifferentClassAs: unaCapa
	self subclassResponsibility.! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 21:07:48'!
checkNotArenosa
	self subclassResponsibility.! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 21:07:50'!
checkNotConcreto
	self subclassResponsibility.! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 21:07:45'!
checkNotTierra
	self subclassResponsibility.! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 19:18:57'!
hash

	^self scan.! !


!CapaDeSuelo methodsFor: 'accessing' stamp: 'FRT 5/5/2023 16:48:52'!
altura

	^ altura.! !


!CapaDeSuelo methodsFor: 'scan' stamp: 'FGCL 5/8/2023 18:27:10'!
scan
	self subclassResponsibility.! !


!CapaDeSuelo methodsFor: 'setters' stamp: 'FRT 5/5/2023 16:07:55'!
setAltura: unaAltura

	altura := unaAltura! !


!CapaDeSuelo methodsFor: 'initialization' stamp: 'FGCL 5/8/2023 21:18:03'!
initialize
	self initializeWithAltura: nil.! !

!CapaDeSuelo methodsFor: 'initialization' stamp: 'FGCL 5/8/2023 21:17:56'!
initializeWithAltura: unaAltura
	altura := unaAltura.
	vecesQueFueGolpeada := 0.! !


!CapaDeSuelo methodsFor: 'ser golpeada' stamp: 'FGCL 5/8/2023 18:41:05'!
serGolpeada
	vecesQueFueGolpeada := vecesQueFueGolpeada + 1.! !

!CapaDeSuelo methodsFor: 'ser golpeada' stamp: 'FGCL 5/8/2023 18:10:10'!
serGolpeadaConMechaDiamantePor: unaPerforadora
	self subclassResponsibility.! !

!CapaDeSuelo methodsFor: 'ser golpeada' stamp: 'FGCL 5/8/2023 18:10:16'!
serGolpeadaConMechaSoftPor: unaPerforadora
	self subclassResponsibility.! !

!CapaDeSuelo methodsFor: 'ser golpeada' stamp: 'FGCL 5/8/2023 18:10:15'!
serGolpeadaConMechaWidiaPor: unaPerforadora
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSuelo class' category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo class
	instanceVariableNames: ''!

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'FGCL 5/8/2023 21:15:43'!
arenoso " NOTA: Intente hacer inline de este metodo, pero me tira un error raro. "

	^CapaArenosa new.! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'FGCL 5/8/2023 21:15:49'!
concretoConResistencia: resistencia " NOTA: Intente hacer inline de este metodo, pero me tira un error raro. "

	^CapaConcreto conResistencia: resistencia ! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'FGCL 5/8/2023 21:15:51'!
tierra " NOTA: Intente hacer inline de este metodo, pero me tira un error raro. "

	^CapaTierra new.! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'FGCL 5/8/2023 21:23:08'!
withAltura: unaAltura " NOTA: Intente usar este metodo y me tiro un error raro "
	self new initializeWithAltura: unaAltura.! !


!classDefinition: #CapaArenosa category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #CapaArenosa
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaArenosa methodsFor: 'ser golpeada' stamp: 'FGCL 5/8/2023 18:42:01'!
serGolpeadaConMechaDiamantePor: unaPerforadora
	self serGolpeada.

	unaPerforadora ponerMechaDeTipo: MechaRota.
	self error: 'Se rompió'! !

!CapaArenosa methodsFor: 'ser golpeada' stamp: 'FGCL 5/8/2023 18:42:06'!
serGolpeadaConMechaSoftPor: unaPerforadora
	self serGolpeada.

	^unaPerforadora pasarAProximaCapa.! !

!CapaArenosa methodsFor: 'ser golpeada' stamp: 'FGCL 5/8/2023 18:42:09'!
serGolpeadaConMechaWidiaPor: unaPerforadora
	self serGolpeada.

	^unaPerforadora pasarAProximaCapa.
		! !


!CapaArenosa methodsFor: 'scan' stamp: 'FGCL 5/8/2023 18:32:45'!
scan
	^CapaArenosa scan.! !


!CapaArenosa methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 20:52:47'!
checkDifferentClassAs: unaCapa
	unaCapa checkNotArenosa.! !

!CapaArenosa methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 20:53:26'!
checkNotArenosa
	Perforadora capasContiguasError.! !

!CapaArenosa methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 20:53:43'!
checkNotConcreto
	" Do nothing "! !

!CapaArenosa methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 20:53:45'!
checkNotTierra
	" Do nothing "! !


!CapaArenosa methodsFor: 'tipo' stamp: 'FGCL 5/8/2023 18:11:29'!
esArenoso
	^true.! !

!CapaArenosa methodsFor: 'tipo' stamp: 'FGCL 5/8/2023 18:11:47'!
esConcreto
	^false.! !

!CapaArenosa methodsFor: 'tipo' stamp: 'FGCL 5/8/2023 18:11:50'!
esTierra
	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaArenosa class' category: 'ISW1-2023-1C-Parcial-1'!
CapaArenosa class
	instanceVariableNames: ''!

!CapaArenosa class methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 18:32:36'!
scan
	^7.! !


!classDefinition: #CapaConcreto category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #CapaConcreto
	instanceVariableNames: 'resistencia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaConcreto methodsFor: 'tipo' stamp: 'FGCL 5/8/2023 18:12:33'!
esArenoso
	^false.! !

!CapaConcreto methodsFor: 'tipo' stamp: 'FGCL 5/8/2023 18:12:40'!
esConcreto
	^true.! !

!CapaConcreto methodsFor: 'tipo' stamp: 'FGCL 5/8/2023 18:12:37'!
esTierra
	^false.! !


!CapaConcreto methodsFor: 'initialization' stamp: 'FGCL 5/8/2023 18:39:04'!
initializeConResistencia: resistenciaInicial 
	self initialize.
	resistencia := resistenciaInicial.! !


!CapaConcreto methodsFor: 'scan' stamp: 'FGCL 5/8/2023 18:32:51'!
scan
	^CapaConcreto scan.! !


!CapaConcreto methodsFor: 'bajar resistencia' stamp: 'FGCL 5/8/2023 18:27:24'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !


!CapaConcreto methodsFor: 'accessing' stamp: 'FGCL 5/8/2023 18:28:36'!
resistencia

	^ resistencia.! !


!CapaConcreto methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 18:29:00'!
= unaCapaDeSuelo
	^(unaCapaDeSuelo isKindOf: self class) and: (resistencia = (unaCapaDeSuelo resistencia)).! !

!CapaConcreto methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 20:53:55'!
checkDifferentClassAs: unaCapa
	unaCapa checkNotConcreto.! !

!CapaConcreto methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 20:54:12'!
checkNotArenosa
	" Do nothing "! !

!CapaConcreto methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 20:54:07'!
checkNotConcreto
	Perforadora capasContiguasError.! !

!CapaConcreto methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 20:54:15'!
checkNotTierra
	" Do nothing "! !

!CapaConcreto methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 18:35:08'!
hash
	^self scan + self resistencia.! !


!CapaConcreto methodsFor: 'ser golpeada' stamp: 'FGCL 5/8/2023 19:08:20'!
serGolpeadaConMechaDiamantePor: unaPerforadora	
	self serGolpeada.
	
	(EstadoCapaDeConcreto withGolpes: vecesQueFueGolpeada andResistencia: resistencia) bajarResistenciaA: self.
	(EstadoCapaDeConcreto withGolpes: vecesQueFueGolpeada andResistencia: resistencia) transformarCapaPara: unaPerforadora.

	^vecesQueFueGolpeada.! !

!CapaConcreto methodsFor: 'ser golpeada' stamp: 'FGCL 5/8/2023 18:42:15'!
serGolpeadaConMechaSoftPor: unaPerforadora	
	self serGolpeada.

	unaPerforadora ponerMechaDeTipo: MechaRota.
	self error: 'Se rompió'.
! !

!CapaConcreto methodsFor: 'ser golpeada' stamp: 'FGCL 5/8/2023 19:11:19'!
serGolpeadaConMechaWidiaPor: unaPerforadora	
	self serGolpeada.

	(EstadoCapaDeConcreto withGolpes: vecesQueFueGolpeada andResistencia: resistencia) romperMechaA: unaPerforadora.
	
	^unaPerforadora.
	
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaConcreto class' category: 'ISW1-2023-1C-Parcial-1'!
CapaConcreto class
	instanceVariableNames: ''!

!CapaConcreto class methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 18:19:22'!
conResistencia: unaResistencia
	^self new initializeConResistencia: unaResistencia.! !

!CapaConcreto class methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 18:32:30'!
scan
	^50.! !


!classDefinition: #CapaTierra category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #CapaTierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaTierra methodsFor: 'tipo' stamp: 'FGCL 5/8/2023 18:12:22'!
esArenoso
	^false.! !

!CapaTierra methodsFor: 'tipo' stamp: 'FGCL 5/8/2023 18:12:25'!
esConcreto
	^false.! !

!CapaTierra methodsFor: 'tipo' stamp: 'FGCL 5/8/2023 18:12:17'!
esTierra
	^true.! !


!CapaTierra methodsFor: 'scan' stamp: 'FGCL 5/8/2023 18:32:57'!
scan
	^CapaTierra scan.! !


!CapaTierra methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 20:54:26'!
checkDifferentClassAs: unaCapa
	unaCapa checkNotTierra.! !

!CapaTierra methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 20:54:42'!
checkNotArenosa
	" Do nothing "! !

!CapaTierra methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 20:54:45'!
checkNotConcreto
	" Do nothing "! !

!CapaTierra methodsFor: 'comparing' stamp: 'FGCL 5/8/2023 20:54:37'!
checkNotTierra
	Perforadora capasContiguasError.! !


!CapaTierra methodsFor: 'ser golpeada' stamp: 'FGCL 5/8/2023 18:42:21'!
serGolpeadaConMechaDiamantePor: unaPerforadora
	self serGolpeada.

	^unaPerforadora pasarAProximaCapa.! !

!CapaTierra methodsFor: 'ser golpeada' stamp: 'FGCL 5/8/2023 18:42:25'!
serGolpeadaConMechaSoftPor: unaPerforadora
	self serGolpeada.

	^unaPerforadora.! !

!CapaTierra methodsFor: 'ser golpeada' stamp: 'FGCL 5/8/2023 19:16:02'!
serGolpeadaConMechaWidiaPor: unaPerforadora
	self serGolpeada.

	(EstadoCapaDeTierra with: vecesQueFueGolpeada) serGolpeadaPor: unaPerforadora.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaTierra class' category: 'ISW1-2023-1C-Parcial-1'!
CapaTierra class
	instanceVariableNames: ''!

!CapaTierra class methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 18:32:24'!
scan
	^10.! !


!classDefinition: #EstadoCapaDeSuelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #EstadoCapaDeSuelo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!


!classDefinition: #EstadoCapaDeConcreto category: 'ISW1-2023-1C-Parcial-1'!
EstadoCapaDeSuelo subclass: #EstadoCapaDeConcreto
	instanceVariableNames: 'capa'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!EstadoCapaDeConcreto methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:09:27'!
bajarResistenciaA: unaCapaDeConcreto
	" Do nothing "! !

!EstadoCapaDeConcreto methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:11:12'!
romperMechaA: unaPerforadora
	" Do nothing "! !

!EstadoCapaDeConcreto methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:09:33'!
transformarCapaPara: unaPerforadora
	" Do nothing "! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoCapaDeConcreto class' category: 'ISW1-2023-1C-Parcial-1'!
EstadoCapaDeConcreto class
	instanceVariableNames: ''!

!EstadoCapaDeConcreto class methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:14:17'!
canHandleGolpes: unaCantidadDeGolpes andResistencia: unaResistencia
	self subclassResponsibility.! !

!EstadoCapaDeConcreto class methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:13:21'!
withGolpes: unaCantidadDeGolpes andResistencia: unaResistencia
	^(self subclasses detect: [ :anEstadoCapaDeTierraClass | anEstadoCapaDeTierraClass canHandleGolpes: unaCantidadDeGolpes andResistencia: unaResistencia ] ifNone: self) new.	! !


!classDefinition: #EstadoCapaDeConcretoGolpesPar category: 'ISW1-2023-1C-Parcial-1'!
EstadoCapaDeConcreto subclass: #EstadoCapaDeConcretoGolpesPar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!EstadoCapaDeConcretoGolpesPar methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:08:05'!
bajarResistenciaA: unaCapaDeConcreto
	^unaCapaDeConcreto bajaUnDecimoDeResistencia.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoCapaDeConcretoGolpesPar class' category: 'ISW1-2023-1C-Parcial-1'!
EstadoCapaDeConcretoGolpesPar class
	instanceVariableNames: ''!

!EstadoCapaDeConcretoGolpesPar class methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:14:03'!
canHandleGolpes: unaCantidadDeGolpes andResistencia: unaResistencia
	^unaCantidadDeGolpes even.! !


!classDefinition: #EstadoCapaDeConcretoSinResistencia category: 'ISW1-2023-1C-Parcial-1'!
EstadoCapaDeConcreto subclass: #EstadoCapaDeConcretoSinResistencia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!EstadoCapaDeConcretoSinResistencia methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:07:06'!
transformarCapaPara: unaPerforadora
	^unaPerforadora transformarCapaEnArenoso.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoCapaDeConcretoSinResistencia class' category: 'ISW1-2023-1C-Parcial-1'!
EstadoCapaDeConcretoSinResistencia class
	instanceVariableNames: ''!

!EstadoCapaDeConcretoSinResistencia class methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:13:48'!
canHandleGolpes: unaCantidadDeGolpes andResistencia: unaResistencia
	^unaResistencia = 0.! !


!classDefinition: #EstadoCapaDeConcretoTresGolpes category: 'ISW1-2023-1C-Parcial-1'!
EstadoCapaDeConcreto subclass: #EstadoCapaDeConcretoTresGolpes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!EstadoCapaDeConcretoTresGolpes methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:11:05'!
romperMechaA: unaPerforadora
	unaPerforadora ponerMechaDeTipo: MechaRota.
	self error: 'Se rompió'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoCapaDeConcretoTresGolpes class' category: 'ISW1-2023-1C-Parcial-1'!
EstadoCapaDeConcretoTresGolpes class
	instanceVariableNames: ''!

!EstadoCapaDeConcretoTresGolpes class methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:14:09'!
canHandleGolpes: unaCantidadDeGolpes andResistencia: unaResistencia
	^unaCantidadDeGolpes = 3.! !


!classDefinition: #EstadoCapaDeTierra category: 'ISW1-2023-1C-Parcial-1'!
EstadoCapaDeSuelo subclass: #EstadoCapaDeTierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!EstadoCapaDeTierra methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:18:22'!
serGolpeadaPor: unaPerforadora
	" Do nothing "! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoCapaDeTierra class' category: 'ISW1-2023-1C-Parcial-1'!
EstadoCapaDeTierra class
	instanceVariableNames: ''!

!EstadoCapaDeTierra class methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:01:03'!
canHandle: unaCantidadDeGolpes
	self subclassResponsibility.! !

!EstadoCapaDeTierra class methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:18:38'!
with: unaCantidadDeGolpes
	^(self subclasses detect: [ :anEstadoCapaDeTierraClass | anEstadoCapaDeTierraClass canHandle: unaCantidadDeGolpes ] ifNone: self) new.	! !


!classDefinition: #EstadoCapaDeTierraDosGolpes category: 'ISW1-2023-1C-Parcial-1'!
EstadoCapaDeTierra subclass: #EstadoCapaDeTierraDosGolpes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!EstadoCapaDeTierraDosGolpes methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 19:18:02'!
serGolpeadaPor: unaPerforadora
	^unaPerforadora transformarCapaEnArenoso.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoCapaDeTierraDosGolpes class' category: 'ISW1-2023-1C-Parcial-1'!
EstadoCapaDeTierraDosGolpes class
	instanceVariableNames: ''!

!EstadoCapaDeTierraDosGolpes class methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 18:52:54'!
canHandle: unaCantidadDeGolpes
	^unaCantidadDeGolpes = 2.! !


!classDefinition: #Mecha category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Mecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Mecha methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 17:55:41'!
darGolpePara: unaPerforadora sobre: unSuelo
	self subclassResponsibility.
	
	! !


!classDefinition: #MechaDiamante category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #MechaDiamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaDiamante methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 17:56:49'!
darGolpePara: unaPerforadora sobre: unSuelo
	unSuelo serGolpeadaConMechaDiamantePor: unaPerforadora.! !


!classDefinition: #MechaRota category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #MechaRota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaRota methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 18:07:01'!
darGolpePara: unaPerforadora sobre: unSuelo
	self error: 'No puede perforar'.! !


!classDefinition: #MechaSoft category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #MechaSoft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaSoft methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 17:56:23'!
darGolpePara: unaPerforadora sobre: unSuelo
	unSuelo serGolpeadaConMechaSoftPor: unaPerforadora.! !


!classDefinition: #MechaWidia category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #MechaWidia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaWidia methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 17:56:41'!
darGolpePara: unaPerforadora sobre: unSuelo
	unSuelo serGolpeadaConMechaWidiaPor: unaPerforadora.! !


!classDefinition: #SinMecha category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #SinMecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!SinMecha methodsFor: 'as yet unclassified' stamp: 'FGCL 5/8/2023 17:47:40'!
darGolpePara: unaPerforadora sobre: unSuelo
	self error: 'No puede perforar'.! !


!classDefinition: #Perforadora category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Perforadora
	instanceVariableNames: 'mechaPuesta capasDeSueloDebajo container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Perforadora methodsFor: 'cambiar capa' stamp: 'FGCL 5/8/2023 18:37:46'!
pasarAProximaCapa
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst.
	capasDeSueloDebajo ifEmpty: [^self]. 
	(capasDeSueloDebajo first isKindOf: CapaDeSuelo) ifFalse:[
			container addAll: capasDeSueloDebajo.
		]! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 4/27/2023 20:46:30'!
transformarCapaEnArenoso
	capasDeSueloDebajo :=
			capasDeSueloDebajo allButFirst asOrderedCollection
			addFirst: CapaDeSuelo arenoso;
			yourself! !


!Perforadora methodsFor: 'excavation' stamp: 'FGCL 5/8/2023 18:37:58'!
darGolpeDeTaladro
	^mechaPuesta darGolpePara: self sobre: (self capaDeSueloInmediata).! !

!Perforadora methodsFor: 'excavation' stamp: 'FGCL 5/8/2023 20:18:16'!
darGolpesDeTaladro: n
	n timesRepeat: [ self darGolpeDeTaladro ].! !


!Perforadora methodsFor: 'initialization' stamp: 'FGCL 5/8/2023 20:42:11'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	capasDeSueloDebajo := capasDeSueloAExcavarInicialmente.
	container := OrderedCollection new.
	mechaPuesta := SinMecha new.! !


!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:17:21'!
capaDeSueloInmediata
	^capasDeSueloDebajo first! !

!Perforadora methodsFor: 'accessing' stamp: 'FGCL 5/8/2023 19:58:46'!
conMechaRota

	^mechaPuesta isKindOf: MechaRota.! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:12:20'!
elementsInContainer
	^container asArray! !

!Perforadora methodsFor: 'accessing' stamp: 'FGCL 5/8/2023 17:44:37'!
sinMecha

	^mechaPuesta isMemberOf: SinMecha.! !


!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:17'!
sobreSueloArenoso
	^capasDeSueloDebajo first esArenoso! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:16:14'!
sobreSueloConcreto
	^capasDeSueloDebajo first esConcreto! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:58'!
sobreSueloTierra
	^capasDeSueloDebajo first esTierra! !


!Perforadora methodsFor: 'colocar mecha' stamp: 'FGCL 5/8/2023 17:45:26'!
ponerMechaDeTipo: unTipoDeMecha
	mechaPuesta := unTipoDeMecha new.! !


!Perforadora methodsFor: 'scan' stamp: 'FGCL 5/8/2023 19:47:09'!
calcularProfundidadDelSuelo

	^self calcularProfundidadDelSueloSobre: capasDeSueloDebajo.
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'FGCL 5/8/2023 18:31:34'!
calcularProfundidadDelSueloHasta: tipoDeCapa
	
	| valor acc ix |
	
	valor := tipoDeCapa scan.
	
	acc := 0.
	ix := 1.
	
	[ix <= capasDeSueloDebajo size] whileTrue: [ | capa altura |
		capa := capasDeSueloDebajo at: ix.
		
		valor = capa scan ifTrue: [ ^ acc ].
		
		altura := capa altura.
		altura = nil ifTrue: [ altura := 0 ].
		acc := acc + altura.
		ix := ix + 1.		
	].

	^ acc.
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'FGCL 5/8/2023 19:46:55'!
calcularProfundidadDelSueloSobre: unaColeccionDeCapas

	^((unaColeccionDeCapas collect: [ :unaCapa | unaCapa altura ]) select: [ :unaAltura | unaAltura ~= nil ]) sum.
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'FGCL 5/8/2023 19:34:02'!
contarCapas: tipoDeCapa
	
	"Cuenta las capas de tipo tipoDeCapa. Recordar que para identificar cada capa se utiliza el valor de scan que retorna. Por ej. un capa tipo Arenoso retorna 7 al scan"
	
	^(capasDeSueloDebajo select: [ :unaCapa | unaCapa scan = tipoDeCapa scan]) size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: 'ISW1-2023-1C-Parcial-1'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'FGCL 5/8/2023 21:11:43'!
checkCapasNoContiguas: capasDeSueloAExcavar  
	| onlyCapasCollection |
	
	onlyCapasCollection := capasDeSueloAExcavar select: [ :unaCapa | unaCapa isKindOf: CapaDeSuelo ].
	onlyCapasCollection ifNotEmpty: [ " NOTA: Este if se podria sacar si fold permitira colecciones vacias. Pero como no lo permite, igual esta bien usarlo porque no pertenece al mundo de la Perforadora "
		 onlyCapasCollection fold: [ :capaAnterior :estaCapa |
			capaAnterior checkDifferentClassAs: estaCapa.
			estaCapa
		].
	].! !

!Perforadora class methodsFor: 'instance creation' stamp: 'FGCL 5/8/2023 21:11:53'!
sobreSuelo: capasDeSueloAExcavar  

	| capasCollection |
	
	capasCollection := OrderedCollection newFrom: capasDeSueloAExcavar.
	self checkCapasNoContiguas: capasCollection.
	^self new initializeSobreSuelo: capasCollection.! !

!Perforadora class methodsFor: 'instance creation' stamp: 'FGCL 5/8/2023 20:40:54'!
sobreSuelo: capasDeSueloAExcavar  conMecha: unTipoDeMecha

	^(self sobreSuelo: capasDeSueloAExcavar) ponerMechaDeTipo: unTipoDeMecha! !


!Perforadora class methodsFor: 'errors' stamp: 'FGCL 5/8/2023 20:55:01'!
capasContiguasError
	self error: 'No pueden haber capas contiguas del mismo tipo'.! !

!Perforadora class methodsFor: 'errors' stamp: 'FGCL 5/8/2023 20:41:24'!
capasContiguasErrorMessage
	^'No pueden haber capas contiguas del mismo tipo'.! !

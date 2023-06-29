!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'sr 6/26/2023 21:34:10'!
test01ReceivedValidDataShouldBeImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: session..

	self assertImportedThisAmountOfCustomers: 2.
	self assertImportedThisAmountOfAddresses: 3.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'sr 6/26/2023 21:34:31'!
test02NothingShouldBeImportedAfterReceivingNoData

	CustomerImporter valueFrom: self emptyImportData into: session..
	
	self assertImportedThisAmountOfCustomers: 0.
	self assertImportedThisAmountOfAddresses: 0.
! !

!ImportTest methodsFor: 'tests' stamp: 'sr 6/26/2023 21:51:58'!
test03DataWithWrongTypeShouldntBeImported

	self 
		should: [ CustomerImporter valueFrom: self invalidTypeImportData into: session. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CustomerImporter invalidLineTypeErrorDescription.
			"Se importo lo que queria"
			self assertImportedThisAmountOfCustomers: 1.
			self assertImportedThisAmountOfAddresses: 2.
			self assertPepeSanchezWasImportedCorrecty.			
			"No se importo lo que se rompia"
			self should: [ self assertJuanPerezWasImportedCorrectly ]
				raise: Error
				withExceptionDo: [ :aSetError |
						self assert: aSetError messageText equals: Set emptyCollectionDescription.
					 ]
			 ].
! !

!ImportTest methodsFor: 'tests' stamp: 'sr 6/26/2023 21:55:14'!
test04DataWithEmptyCellsShouldntBeImported

	self 
		should: [ CustomerImporter valueFrom: self emptyCellsImportData into: session. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CustomerImporter emptyCellsTypeErrorDescription. 
			"Se importo lo que queria"
			"No se importo lo que se rompia"
			].
! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'sr 6/26/2023 21:43:16'!
assertImportedThisAmountOfAddresses: aNumberOfAddresses 
	^(session selectAllOfType: Customer) inject: 0 into: [ :sum :customer | sum + (customer addresses size)].! !

!ImportTest methodsFor: 'assertions' stamp: 'sr 6/26/2023 21:35:23'!
assertImportedThisAmountOfCustomers: aNumberOfCustomers

	^ self assert: aNumberOfCustomers equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'sr 6/26/2023 21:53:51'!
emptyCellsImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,,C,23-25666777-9
A,Alem,1122,CABA,1001,'! !

!ImportTest methodsFor: 'test data' stamp: 'sr 6/26/2023 20:40:43'!
emptyImportData

	^ ReadStream on: ''! !

!ImportTest methodsFor: 'test data' stamp: 'sr 6/26/2023 21:00:13'!
invalidTypeImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
X,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream newCustomer newAddress data line'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'testing' stamp: 'sr 6/26/2023 21:58:53'!
checkLineIsValid

	self isCorrectTypeLine. 
	self everyCellIsFilled.
	! !

!CustomerImporter methodsFor: 'testing' stamp: 'sr 6/26/2023 22:00:29'!
everyCellIsFilled
	
	"TODO (chequear que cada campo customerData no sea vacio)..."
	
	! !

!CustomerImporter methodsFor: 'testing' stamp: 'sr 6/26/2023 20:26:05'!
isAddressLine

	^ line beginsWith: 'A'! !

!CustomerImporter methodsFor: 'testing' stamp: 'sr 6/26/2023 21:57:43'!
isCorrectTypeLine

	^ (self isAddressLine or: self isCustomerLine) ifFalse: [ self error: CustomerImporter invalidLineTypeErrorDescription ]! !

!CustomerImporter methodsFor: 'testing' stamp: 'sr 6/26/2023 20:26:25'!
isCustomerLine

	^ line beginsWith: 'C'! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'sr 6/26/2023 19:45:50'!
goToNextLine

	^ line := readStream nextLine! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'sr 6/26/2023 20:29:20'!
importAddressInfoForCostumer
	| addressData |
	
	addressData := self lineParameters.
	
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: addressData second.
	newAddress streetNumber: addressData third asNumber .
	newAddress town: addressData fourth.
	newAddress zipCode: addressData fifth asNumber .
	newAddress province: addressData sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'sr 6/26/2023 20:28:12'!
importAddressLine

	^ self isAddressLine ifTrue: [ self importAddressInfoForCostumer ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'sr 6/26/2023 20:28:02'!
importCustomerLine

	^ self isCustomerLine ifTrue: [			self importWithCustomerInfo ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'sr 6/26/2023 19:51:30'!
importWithCustomerInfo
	
	| customerData |
	
	customerData := self lineParameters.

	newCustomer := Customer new.
	newCustomer firstName: customerData second.
	newCustomer lastName: customerData third.
	newCustomer identificationType: customerData fourth.
	newCustomer identificationNumber: customerData fifth.
	session persist: newCustomer ! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'sr 6/26/2023 19:43:16'!
lineParameters

	^ data := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'sr 6/26/2023 21:08:31'!
value

	self goToNextLine.
	
	[ line notNil ] whileTrue: [		
		self checkLineIsValid.
		self importCustomerLine.
		self importAddressLine.
		self goToNextLine. ].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'error messages' stamp: 'sr 6/26/2023 21:55:00'!
emptyCellsTypeErrorDescription
	'There is one or more cells missing.'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'sr 6/26/2023 21:04:28'!
invalidLineTypeErrorDescription
	'Unknown type!!'! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !

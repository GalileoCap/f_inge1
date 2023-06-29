!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'FGCL 6/29/2023 12:04:46'!
test01Import

	CustomerImporter valueFrom: self validImportData into: session..

	self assertImportedThisNumberOfCustomers: 2 andAddresses: 3.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly.! !

!ImportTest methodsFor: 'tests' stamp: 'FGCL 6/29/2023 12:04:38'!
test02ImportEmpty

	CustomerImporter valueFrom: self emptyImportData into: session.

	self assertImportedThisNumberOfCustomers: 0 andAddresses: 0.! !

!ImportTest methodsFor: 'tests' stamp: 'FGCL 6/29/2023 12:18:48'!
test03ImportLineWithEmptyCells	

	self should: [ CustomerImporter valueFrom: self emptyCellsImportData into: session ]
		raise: Error - MessageNotUnderstood
		withExceptionDo:  [ :anError |
			self assert: CustomerImporter emptyCellsTypeErrorDescription equals: anError messageText. 
			self assertPepeSanchezWasImportedCorrecty.
			self assertImportedThisNumberOfCustomers: 1 andAddresses: 2.
		].! !


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

!ImportTest methodsFor: 'assertions' stamp: 'FGCL 6/29/2023 11:54:17'!
assertImportedThisNumber: expectedNumber of: aType

	(aType = Address) ifTrue: [ " TODO: Sacar esto, debería de andar lo de abajo "
		^(session selectAllOfType: Customer) inject: 0 into: [ :sum :aCustomer | sum + (aCustomer addresses size)].
	].

	^ self assert: expectedNumber equals: (session selectAllOfType: aType) size! !

!ImportTest methodsFor: 'assertions' stamp: 'FGCL 6/29/2023 12:04:28'!
assertImportedThisNumberOfCustomers: numberOfCustomers andAddresses: numberOfAddresses.
	self assertImportedThisNumber: numberOfCustomers of: Customer.
	self assertImportedThisNumber: numberOfAddresses of: Address.! !

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


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'FGCL 6/29/2023 11:53:24'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.! !

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


!ImportTest methodsFor: 'test data' stamp: 'FGCL 6/29/2023 12:24:55'!
emptyCellsImportData

	^ ReadStream on: 
		(self pepeSanchezImportData), 
		'C,Juan,Perez, ,1
		',
		'A,Alem,1122,CABA,1001,CABA
		'.! !

!ImportTest methodsFor: 'test data' stamp: 'FGCL 6/29/2023 11:51:43'!
emptyImportData

	^ ReadStream on: ''.! !

!ImportTest methodsFor: 'test data' stamp: 'FGCL 6/29/2023 12:02:15'!
juanPerezImportData
	^
'C,Juan,Perez,C,23-25666777-9
',
'A,Alem,1122,CABA,1001,CABA
'.! !

!ImportTest methodsFor: 'test data' stamp: 'FGCL 6/29/2023 12:02:18'!
pepeSanchezImportData

	^
'C,Pepe,Sanchez,D,22333444
',
'A,San Martin,3322,Olivos,1636,BsAs
',
'A,Maipu,888,Florida,1122,Buenos Aires
'! !

!ImportTest methodsFor: 'test data' stamp: 'FGCL 6/29/2023 12:01:58'!
validImportData

	^ ReadStream on: self pepeSanchezImportData, self juanPerezImportData.! !


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
	instanceVariableNames: 'session readStream newCustomer line data'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'parsing' stamp: 'FGCL 6/29/2023 11:42:05'!
parseAddress

	| newAddress |
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: data second.
	newAddress streetNumber: data third asNumber .
	newAddress town: data fourth.
	newAddress zipCode: data fifth asNumber .
	newAddress province: data sixth! !

!CustomerImporter methodsFor: 'parsing' stamp: 'FGCL 6/29/2023 11:49:13'!
parseLine

	self readData.
	self isACustomer ifTrue: [  ^self parseNewCustomer ].
	self isAnAddress ifTrue: [ ^self parseAddress ]
	" TODO: Error "! !

!CustomerImporter methodsFor: 'parsing' stamp: 'FGCL 6/29/2023 11:41:18'!
parseNewCustomer

	newCustomer := Customer new.
	newCustomer firstName: data second.
	newCustomer lastName: data third.
	newCustomer identificationType: data fourth.
	newCustomer identificationNumber: data fifth.
	session persist: newCustomer! !


!CustomerImporter methodsFor: 'checks' stamp: 'FGCL 6/29/2023 12:23:45'!
checkAllCellsAreFilled
	data do: [ :aDataPoint | (aDataPoint = ' ') ifTrue: [ self error: CustomerImporter emptyCellsTypeErrorDescription ]].! !

!CustomerImporter methodsFor: 'checks' stamp: 'FGCL 6/29/2023 12:09:30'!
checkDataIsValid

	self checkAllCellsAreFilled.! !


!CustomerImporter methodsFor: 'testing data' stamp: 'FGCL 6/29/2023 11:40:10'!
isACustomer

	^ line beginsWith: 'C'! !

!CustomerImporter methodsFor: 'testing data' stamp: 'FGCL 6/29/2023 11:40:15'!
isAnAddress

	^ line beginsWith: 'A'! !

!CustomerImporter methodsFor: 'testing data' stamp: 'FGCL 6/29/2023 11:40:52'!
isNotFinished

	^ line notNil! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'FGCL 6/29/2023 12:08:26'!
readData
	data := line findTokens: $,.
	self checkDataIsValid.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'FGCL 6/29/2023 12:05:23'!
readLine
	line := readStream nextLine.
! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'FGCL 6/29/2023 11:49:08'!
value

	"
	self importCustomers
	"
	
	self readLine.
	[ self isNotFinished ] whileTrue: [
		self parseLine.
		self readLine.
	].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'errors' stamp: 'FGCL 6/29/2023 12:11:16'!
emptyCellsTypeErrorDescription
	^'Cells cannot be empty'.! !


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

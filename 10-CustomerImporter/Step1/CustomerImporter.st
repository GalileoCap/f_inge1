!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session pepeSanchez juanPerez pepeSanchezAddress1 pepeSanchezAddress2 juanPerezAddress'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'FGCL 6/25/2023 12:48:19'!
assertSessionIncludes: anExpectedCustomer ofType: aType 
	self assert: 1 equals: ((session select: [ :aCustomer | aCustomer = anExpectedCustomer ] ofType: aType) size)! !

!ImportTest methodsFor: 'tests' stamp: 'FGCL 6/25/2023 11:39:10'!
test01FileIsFoundAndRead
	" Revisa que el import lea el archivo, para distinguir de otros errores "! !

!ImportTest methodsFor: 'tests' stamp: 'FGCL 6/25/2023 12:48:13'!
test02ImportsCustomersCorrectly
	self assert: 2 equals: ((session selectAllOfType: Customer) size).
	self assertSessionIncludes: pepeSanchez ofType: Customer.
	self assertSessionIncludes: juanPerez ofType: Customer.! !

!ImportTest methodsFor: 'tests' stamp: 'FGCL 6/25/2023 12:51:01'!
test03ImportsAddressessCorrectly
	self assert: 3 equals: ((session selectAllOfType: Address) size).
	self assertSessionIncludes: pepeSanchezAddress1 ofType: Address.
	self assertSessionIncludes: pepeSanchezAddress2 ofType: Address.
	self assertSessionIncludes: juanPerezAddress ofType: Address.! !


!ImportTest methodsFor: 'setUp and tearDown' stamp: 'FGCL 6/25/2023 12:59:18'!
inputSession

	| inputStream |
	
	inputStream := UniFileStream new open: 'input.txt' forWrite: false.
	session := DataBaseSession for: (Array with: Address with: Customer).
	DataBaseSessionImport new importFrom: inputStream into: session.! !

!ImportTest methodsFor: 'setUp and tearDown' stamp: 'FGCL 6/25/2023 12:53:11'!
setUp

	self inputSession.
	
	pepeSanchezAddress1 := Address withStreetName: 'San Martin' streetNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	pepeSanchezAddress2 := Address withStreetName: 'Maipu' streetNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.
	pepeSanchez := Customer withFirstName: 'Pepe'
					lastName: 'Sanchez'
					identificationType: 'D'
					identificationNumber: '22333444'
					withAddresses: {
						pepeSanchezAddress1.
						pepeSanchezAddress2.
					}.
					
	juanPerezAddress := Address withStreetName: 'Alem' streetNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'.
	juanPerez := Customer withFirstName: 'Juan'
					lastName: 'Perez'
					identificationType: 'C'
					identificationNumber: '23-25666777-9'
					withAddresses: {
						juanPerezAddress.
					}.! !

!ImportTest methodsFor: 'setUp and tearDown' stamp: 'FGCL 6/25/2023 12:50:41'!
tearDown
	session close.! !


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


!Address methodsFor: 'initialization' stamp: 'FGCL 6/25/2023 12:03:11'!
initializeWithStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince.
	self streetName: aStreetName.
	self streetNumber: aStreetNumber.
	self town: aTown.
	self zipCode: aZipCode.
	self province: aProvince.! !


!Address methodsFor: 'equality' stamp: 'FGCL 6/25/2023 12:54:32'!
= anAddress
	^(streetName = anAddress streetName) and: (streetNumber = anAddress streetNumber) and: (town = anAddress town) and: (zipCode = anAddress zipCode) and: (province = anAddress province).! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Address class' category: 'CustomerImporter'!
Address class
	instanceVariableNames: ''!

!Address class methodsFor: 'instance creation' stamp: 'FGCL 6/25/2023 12:02:25'!
withStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince
	^self new initializeWithStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince.! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'FGCL 6/25/2023 11:55:50'!
addAddresses: adresses
	addresses do: [ :anAddress | self addAddress: anAddress ].! !

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


!Customer methodsFor: 'initialization' stamp: 'FGCL 6/25/2023 11:59:55'!
initializeWithFirstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber withAddresses: aListOfAddresses 

	super initialize.
	self firstName: aFirstName.
	self lastName: aLastName.
	self identificationType: anIdentificationType.
	self identificationNumber: anIdentificationNumber.
	addresses := OrderedCollection newFrom: aListOfAddresses.! !


!Customer methodsFor: 'equality' stamp: 'FGCL 6/25/2023 12:46:34'!
= aCustomer
	^(firstName = aCustomer firstName) and: (lastName = aCustomer lastName) and: (identificationType = aCustomer identificationType) and: (identificationNumber = aCustomer identificationNumber).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'FGCL 6/25/2023 11:57:27'!
withFirstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber withAddresses: addresses 
	^self new initializeWithFirstName: aFirstName
			lastName: aLastName
			identificationType: anIdentificationType
			identificationNumber: anIdentificationNumber
			withAddresses: addresses.! !


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


!classDefinition: #DataBaseSessionImport category: 'CustomerImporter'!
Object subclass: #DataBaseSessionImport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSessionImport methodsFor: 'parsing' stamp: 'FGCL 6/25/2023 13:05:00'!
parseAddress: addressData
	^Address withStreetName: addressData second
		streetNumber: addressData third asNumber
		town: addressData fourth
		zipCode: addressData fifth asNumber
		province: addressData sixth.! !

!DataBaseSessionImport methodsFor: 'parsing' stamp: 'FGCL 6/25/2023 13:03:51'!
parseCustomer: customerData
	^Customer withFirstName: customerData second
			lastName: customerData third
			identificationType: customerData fourth
			identificationNumber: customerData fifth
			withAddresses: #().! !


!DataBaseSessionImport methodsFor: 'import' stamp: 'FGCL 6/25/2023 13:06:28'!
importFrom: inputStream into: session
	| newCustomer line |
	
	session beginTransaction.
	line := inputStream nextLine.
	[ line notNil ] whileTrue: [ | data |
		data := line findTokens: $,.
		(line beginsWith: 'C') ifTrue: [
			newCustomer := self parseCustomer: data.
			session persist: newCustomer
		].

		(line beginsWith: 'A') ifTrue: [ | newAddress |
			newAddress := self parseAddress: data.
			newCustomer addAddress: newAddress.
		].

		line := inputStream nextLine.
	].
	session commit.! !

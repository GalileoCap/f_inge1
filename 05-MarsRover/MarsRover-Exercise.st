!classDefinition: #MarsRoverTest category: 'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 22:32:14'!
test01SheBeginsAtTheGivenPosition
	| rover position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionNorth new.
	
	rover := MarsRover at: position pointing: direction.
	
	self assert: position equals: (rover position).
	self assert: direction equals: (rover direction).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 22:32:29'!
test02SheBeginsAtTheGivenPosition
	| rover position direction |
	
	position := Point x: 1 y: 2.
	direction := MarsRoverDirectionSouth new.
	
	rover := MarsRover at: position pointing: direction.
	
	self assert: position equals: (rover position).
	self assert: direction equals: (rover direction).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 22:42:32'!
test03SheDoesntMoveOrRotateWithEmpyCommands
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionNorth new.
	
	self testRoverAt: position pointing: direction receivesCommands: '' andEndsAt: position pointing: direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 22:43:09'!
test04SheMovesForwardPointingNorthOnceButDoesntRotate
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionNorth new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'f' andEndsAt: (Point x: 0 y: 1) pointing: direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:06:52'!
test05SheMovesBackwardsPointingNorthOnceButDoesntRotate
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionNorth new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'b' andEndsAt: (Point x: 0 y: -1) pointing: direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:06:55'!
test06SheMovesForwardPointingSouthOnceButDoesntRotate
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionSouth new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'f' andEndsAt: (Point x: 0 y: -1) pointing: direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:06:59'!
test07SheMovesBackwardsPointingSouthOnceButDoesntRotate
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionSouth new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'b' andEndsAt: (Point x: 0 y: 1) pointing: direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:07:03'!
test08SheMovesForwardPointingEastOnceButDoesntRotate
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionEast new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'f' andEndsAt: (Point x: 1 y: 0) pointing: direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:07:10'!
test09SheMovesBackwardsPointingEastOnceButDoesntRotate
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionEast new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'b' andEndsAt: (Point x: -1 y: 0) pointing: direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:07:14'!
test10SheMovesForwardPointingWestOnceButDoesntRotate
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionWest new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'f' andEndsAt: (Point x: -1 y: 0) pointing: direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:07:17'!
test11SheMovesBackardsPointingWestOnceButDoesntRotate
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionWest new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'b' andEndsAt: (Point x: 1 y: 0) pointing: direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:07:20'!
test12SheRotatesLeftOncePointingNorthAndDoesntMove
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionNorth new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'l' andEndsAt: position pointing: MarsRoverDirectionWest new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:07:29'!
test13SheRotatesRightOncePointingNorthAndDoesntMove
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionNorth new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'r' andEndsAt: position pointing: MarsRoverDirectionEast new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:08:03'!
test14SheRotatesLeftOncePointingSouthAndDoesntMove
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionSouth new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'l' andEndsAt: position pointing: MarsRoverDirectionEast new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:09:43'!
test15SheRotatesRightOncePointingSouthAndDoesntMove
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionSouth new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'r' andEndsAt: position pointing: MarsRoverDirectionWest new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:08:39'!
test16SheRotatesLeftOncePointingEastAndDoesntMove
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionEast new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'l' andEndsAt: position pointing: MarsRoverDirectionNorth new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:08:52'!
test17SheRotatesRightOncePointingEastAndDoesntMove
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionEast new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'r' andEndsAt: position pointing: MarsRoverDirectionSouth new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:09:10'!
test18SheRotatesLeftOncePointingWestAndDoesntMove
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionWest new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'l' andEndsAt: position pointing: MarsRoverDirectionSouth new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:09:21'!
test19SheRotatesRightOncePointingWestAndDoesntMove
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionWest new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'r' andEndsAt: position pointing: MarsRoverDirectionNorth new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:11:23'!
test20SheReceivesManyCommands
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionNorth new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'frbr' andEndsAt: (Point x: -1 y: 1) pointing: MarsRoverDirectionSouth new.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:15:56'!
test21SheIgnoresInvalidCommands
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionNorth new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'E' andRaisesErrorAndEndsAt: position pointing: direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:16:30'!
test22SheStopsAtInvalidCommands
	| position direction |
	
	position := Point x: 0 y: 0.
	direction := MarsRoverDirectionNorth new.
	
	self testRoverAt: position pointing: direction receivesCommands: 'fEb' andRaisesErrorAndEndsAt: (Point x: 0 y: 1) pointing: direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 22:41:00'!
testRoverAt: aStartingPosition pointing: aStartingDirection receivesCommands: aStringOfCommands andEndsAt: anExpectedPosition pointing: anExpectedDirection
	| rover |
	
	rover := MarsRover at: aStartingPosition pointing: aStartingDirection .
	
	rover receiveCommands: aStringOfCommands .
	
	self assert: anExpectedPosition equals: (rover position).
	self assert: anExpectedDirection equals: (rover direction).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FGCL 5/12/2023 23:17:07'!
testRoverAt: aStartingPosition pointing: aStartingDirection receivesCommands: aStringOfCommands andRaisesErrorAndEndsAt: anExpectedPosition pointing: anExpectedDirection
	| rover |
	
	rover := MarsRover at: aStartingPosition pointing: aStartingDirection .
	
	
	
	self should: [ rover receiveCommands: aStringOfCommands ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (MarsRover invalidCommandErrorDescription) equals: (anError messageText).
			self assert: anExpectedPosition equals: (rover position).
			self assert: anExpectedDirection equals: (rover direction).
		].! !


!classDefinition: #MarsRover category: 'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'FGCL 5/12/2023 21:58:21'!
initializeAt: aPosition pointing: aDirection
	position := aPosition.
	direction := aDirection.! !


!MarsRover methodsFor: 'commands' stamp: 'FGCL 5/12/2023 22:55:40'!
moveBackwards
	position := direction moveBackwardsFrom: position.! !

!MarsRover methodsFor: 'commands' stamp: 'FGCL 5/12/2023 22:55:33'!
moveForward
	position := direction moveForwardFrom: position.! !

!MarsRover methodsFor: 'commands' stamp: 'FGCL 5/12/2023 22:09:01'!
receiveCommand: aCommand
	(MarsRoverCommand with: aCommand) executeOver: self.! !

!MarsRover methodsFor: 'commands' stamp: 'FGCL 5/12/2023 22:07:21'!
receiveCommands: aStringOfCommands
	aStringOfCommands do: [ :aCommand |
		self receiveCommand: aCommand
	].! !

!MarsRover methodsFor: 'commands' stamp: 'FGCL 5/12/2023 22:31:52'!
rotateLeft
	direction := direction rotateLeft.! !

!MarsRover methodsFor: 'commands' stamp: 'FGCL 5/12/2023 22:31:57'!
rotateRight
	direction := direction rotateRight.! !


!MarsRover methodsFor: 'accessing' stamp: 'FGCL 5/12/2023 21:58:46'!
direction
	^direction.! !

!MarsRover methodsFor: 'accessing' stamp: 'FGCL 5/12/2023 21:58:43'!
position
	^position.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error' stamp: 'FGCL 5/12/2023 23:17:07'!
invalidCommandErrorDescription
	^'Comando inválido'.! !


!MarsRover class methodsFor: 'instance creation' stamp: 'FGCL 5/12/2023 21:58:13'!
at: aPosition pointing: aDirection
	^self new initializeAt: aPosition pointing: aDirection.! !


!classDefinition: #MarsRoverCommand category: 'MarsRover-Exercise'!
Object subclass: #MarsRoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverCommand methodsFor: 'execute' stamp: 'FGCL 5/12/2023 22:10:33'!
executeOver: aRover
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommand class' category: 'MarsRover-Exercise'!
MarsRoverCommand class
	instanceVariableNames: ''!

!MarsRoverCommand class methodsFor: 'instance creation' stamp: 'FGCL 5/12/2023 22:13:44'!
canHandle: aCommand
	self subclassResponsibility.! !

!MarsRoverCommand class methodsFor: 'instance creation' stamp: 'FGCL 5/12/2023 22:13:23'!
with: aCommand
	^(self subclasses detect: [ :aSubclass | aSubclass canHandle: aCommand ]) new.! !


!classDefinition: #MarsRoverCommandBackwards category: 'MarsRover-Exercise'!
MarsRoverCommand subclass: #MarsRoverCommandBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverCommandBackwards methodsFor: 'execute' stamp: 'FGCL 5/12/2023 22:18:04'!
executeOver: aRover
	aRover moveBackwards.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommandBackwards class' category: 'MarsRover-Exercise'!
MarsRoverCommandBackwards class
	instanceVariableNames: ''!

!MarsRoverCommandBackwards class methodsFor: 'instance creation' stamp: 'FGCL 5/12/2023 22:18:24'!
canHandle: aCommand
	^aCommand = $b.! !


!classDefinition: #MarsRoverCommandError category: 'MarsRover-Exercise'!
MarsRoverCommand subclass: #MarsRoverCommandError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverCommandError methodsFor: 'execute' stamp: 'FGCL 5/12/2023 23:17:07'!
executeOver: aRover
	self error: (MarsRover invalidCommandErrorDescription).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommandError class' category: 'MarsRover-Exercise'!
MarsRoverCommandError class
	instanceVariableNames: ''!

!MarsRoverCommandError class methodsFor: 'instance creation' stamp: 'FGCL 5/12/2023 22:33:15'!
canHandle: aCommand
	^(
		(MarsRoverCommandForward canHandle: aCommand) or:
		(MarsRoverCommandBackwards canHandle: aCommand) or:
		(MarsRoverCommandLeft canHandle: aCommand) or:
		(MarsRoverCommandRight canHandle: aCommand)
	) not.! !


!classDefinition: #MarsRoverCommandForward category: 'MarsRover-Exercise'!
MarsRoverCommand subclass: #MarsRoverCommandForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverCommandForward methodsFor: 'execute' stamp: 'FGCL 5/12/2023 22:11:21'!
executeOver: aRover
	aRover moveForward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommandForward class' category: 'MarsRover-Exercise'!
MarsRoverCommandForward class
	instanceVariableNames: ''!

!MarsRoverCommandForward class methodsFor: 'instance creation' stamp: 'FGCL 5/12/2023 22:15:04'!
canHandle: aCommand
	^aCommand = $f.! !


!classDefinition: #MarsRoverCommandLeft category: 'MarsRover-Exercise'!
MarsRoverCommand subclass: #MarsRoverCommandLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverCommandLeft methodsFor: 'execute' stamp: 'FGCL 5/12/2023 22:22:35'!
executeOver: aRover
	aRover rotateLeft.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommandLeft class' category: 'MarsRover-Exercise'!
MarsRoverCommandLeft class
	instanceVariableNames: ''!

!MarsRoverCommandLeft class methodsFor: 'instance creation' stamp: 'FGCL 5/12/2023 22:22:40'!
canHandle: aCommand
	^aCommand = $l.! !


!classDefinition: #MarsRoverCommandRight category: 'MarsRover-Exercise'!
MarsRoverCommand subclass: #MarsRoverCommandRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverCommandRight methodsFor: 'execute' stamp: 'FGCL 5/12/2023 22:31:38'!
executeOver: aRover
	aRover rotateRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommandRight class' category: 'MarsRover-Exercise'!
MarsRoverCommandRight class
	instanceVariableNames: ''!

!MarsRoverCommandRight class methodsFor: 'instance creation' stamp: 'FGCL 5/12/2023 22:33:04'!
canHandle: aCommand
	^aCommand = $r.! !


!classDefinition: #MarsRoverDirection category: 'MarsRover-Exercise'!
Object subclass: #MarsRoverDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverDirection methodsFor: 'comparing' stamp: 'FGCL 5/12/2023 22:35:46'!
= aDirection
	^self hash = (aDirection hash).! !

!MarsRoverDirection methodsFor: 'comparing' stamp: 'FGCL 5/12/2023 22:34:28'!
hash
	self subclassResponsibility.! !


!MarsRoverDirection methodsFor: 'move' stamp: 'FGCL 5/12/2023 22:54:26'!
moveBackwardsFrom: aPosition
	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'move' stamp: 'FGCL 5/12/2023 22:54:38'!
moveForwardFrom: aPosition
	self subclassResponsibility.! !


!MarsRoverDirection methodsFor: 'changing positions' stamp: 'FGCL 5/12/2023 22:57:25'!
change: aPosition xAxisBy: aDelta
	^Point x: (aPosition x + aDelta) y: (aPosition y).! !

!MarsRoverDirection methodsFor: 'changing positions' stamp: 'FGCL 5/12/2023 22:57:10'!
change: aPosition yAxisBy: aDelta
	^Point x: (aPosition x) y: (aPosition y + aDelta).! !


!MarsRoverDirection methodsFor: 'rotate' stamp: 'FGCL 5/12/2023 22:25:08'!
rotateLeft
	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'rotate' stamp: 'FGCL 5/12/2023 22:25:11'!
rotateRight
	self subclassResponsibility.! !


!classDefinition: #MarsRoverDirectionEast category: 'MarsRover-Exercise'!
MarsRoverDirection subclass: #MarsRoverDirectionEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverDirectionEast methodsFor: 'comparing' stamp: 'FGCL 5/12/2023 22:35:07'!
hash
	^#East.! !


!MarsRoverDirectionEast methodsFor: 'move' stamp: 'FGCL 5/12/2023 23:00:41'!
moveBackwardsFrom: aPosition
	^self change: aPosition xAxisBy: -1.! !

!MarsRoverDirectionEast methodsFor: 'move' stamp: 'FGCL 5/12/2023 23:00:48'!
moveForwardFrom: aPosition
	^self change: aPosition xAxisBy: 1.! !


!MarsRoverDirectionEast methodsFor: 'rotate' stamp: 'FGCL 5/12/2023 22:30:35'!
rotateLeft
	^MarsRoverDirectionNorth new.! !

!MarsRoverDirectionEast methodsFor: 'rotate' stamp: 'FGCL 5/12/2023 22:30:44'!
rotateRight
	^MarsRoverDirectionSouth new.! !


!classDefinition: #MarsRoverDirectionNorth category: 'MarsRover-Exercise'!
MarsRoverDirection subclass: #MarsRoverDirectionNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverDirectionNorth methodsFor: 'comparing' stamp: 'FGCL 5/12/2023 22:35:20'!
hash
	^#North.! !


!MarsRoverDirectionNorth methodsFor: 'move' stamp: 'FGCL 5/12/2023 23:01:25'!
moveBackwardsFrom: aPosition
	^self change: aPosition yAxisBy: -1.! !

!MarsRoverDirectionNorth methodsFor: 'move' stamp: 'FGCL 5/12/2023 22:56:31'!
moveForwardFrom: aPosition
	^self change: aPosition yAxisBy: 1.! !


!MarsRoverDirectionNorth methodsFor: 'rotate' stamp: 'FGCL 5/12/2023 22:30:52'!
rotateLeft
	^MarsRoverDirectionWest new.! !

!MarsRoverDirectionNorth methodsFor: 'rotate' stamp: 'FGCL 5/12/2023 22:30:48'!
rotateRight
	^MarsRoverDirectionEast new.! !


!classDefinition: #MarsRoverDirectionSouth category: 'MarsRover-Exercise'!
MarsRoverDirection subclass: #MarsRoverDirectionSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverDirectionSouth methodsFor: 'comparing' stamp: 'FGCL 5/12/2023 22:35:29'!
hash
	^#South.! !


!MarsRoverDirectionSouth methodsFor: 'move' stamp: 'FGCL 5/12/2023 22:58:11'!
moveBackwardsFrom: aPosition
	^self change: aPosition yAxisBy: 1.! !

!MarsRoverDirectionSouth methodsFor: 'move' stamp: 'FGCL 5/12/2023 22:57:45'!
moveForwardFrom: aPosition
	^self change: aPosition yAxisBy: -1.! !


!MarsRoverDirectionSouth methodsFor: 'rotate' stamp: 'FGCL 5/12/2023 22:30:58'!
rotateLeft
	^MarsRoverDirectionEast new.! !

!MarsRoverDirectionSouth methodsFor: 'rotate' stamp: 'FGCL 5/12/2023 22:31:04'!
rotateRight
	^MarsRoverDirectionWest new.! !


!classDefinition: #MarsRoverDirectionWest category: 'MarsRover-Exercise'!
MarsRoverDirection subclass: #MarsRoverDirectionWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverDirectionWest methodsFor: 'comparing' stamp: 'FGCL 5/12/2023 22:35:38'!
hash
	^#West.! !


!MarsRoverDirectionWest methodsFor: 'move' stamp: 'FGCL 5/12/2023 23:00:54'!
moveBackwardsFrom: aPosition
	^self change: aPosition xAxisBy: 1.! !

!MarsRoverDirectionWest methodsFor: 'move' stamp: 'FGCL 5/12/2023 23:00:51'!
moveForwardFrom: aPosition
	^self change: aPosition xAxisBy: -1.! !


!MarsRoverDirectionWest methodsFor: 'rotate' stamp: 'FGCL 5/12/2023 22:31:18'!
rotateLeft
	^MarsRoverDirectionSouth new.! !

!MarsRoverDirectionWest methodsFor: 'rotate' stamp: 'FGCL 5/12/2023 22:31:12'!
rotateRight
	^MarsRoverDirectionNorth new.! !

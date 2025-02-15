Class {
	#name : #MoonwalkSquare,
	#superclass : #Square,
	#instVars : [
		'steps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
MoonwalkSquare class >> checkAmountOfSteps: anAmountOfSteps [

	(anAmountOfSteps <= 0) ifTrue: [ Error signal: 'Amount of steps cannot be 0 or lower' ]
]

{ #category : #'instance creation' }
MoonwalkSquare class >> with: anAmountOfSteps [
	self checkAmountOfSteps: anAmountOfSteps.
	^ (self new) initializeWith: anAmountOfSteps.
]

{ #category : #effect }
MoonwalkSquare >> effectTo: aTargetShip in: aGameEventManager [

	aGameEventManager applyMoonwalk: (steps negated) to: aTargetShip.
]

{ #category : #initialization }
MoonwalkSquare >> initializeWith: anAmountOfSteps [

	steps := anAmountOfSteps.
]

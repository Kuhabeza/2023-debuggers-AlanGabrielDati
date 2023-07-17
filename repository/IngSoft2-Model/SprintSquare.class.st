Class {
	#name : #SprintSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SprintSquare >> effectTo: aTargetPlayer in: aGameEventManager [ 
	
	aGameEventManager sprintTo: aTargetPlayer.
]

%% does she have a head-ache, is she light headed 

atTime(DateTime,Item) :-
	log(DateTime,Item).

compareVitals(Person,bloodPressure,[SystolicResult,DiastolicResult]) :-
	getCurrentDateTime(Now),
	atTimeQuery(Now,bloodPressure(Person,over(Systolic,Diastolic))),
	checkVital(bloodPressure,[Systolic,Diastolic],[SystolicResult,DiastolicResult]).

compareVitals(Person,heartRate,[]) :-
	getCurrentDateTime(Now),
	atTimeQuery(Now,heartRate(Person,HeartRate)),
	checkVital(heartRate,[HeartRate],[HeartRateResult]).
	
compareVitals(Person,oxygenSaturation,[Result]) :-
	getCurrentDateTime(Now),
	atTimeQuery(Now,oxygenSaturation(Person,OxygenSaturation)),
	checkVital(oxygenSaturation,[OxygenSaturation],[OxygenSaturationResult]).

checkVital(bloodPressure,[Systolic,Diastolic],[SystolicResult,DiastolicResult]) :-
	(   (	Systolic < 120) ->
	    (	SystolicResult = 'Normal Blood Pressure') ;
	    (	(   Systolic < 140) ->
		(   SystolicResult = 'Prehypertension') ;
		(   (	Systolic < 160) ->
		    (	SystolicResult = 'Stage 1 Hypertension') ;
		    (	SystolicResult = 'Stage 2 Hypertension')))),
	(   (	Diastolic < 80) ->
	    (	DiastolicResult = 'Normal Blood Pressure') ;
	    (	(   Diastolic < 90) ->
		(   DiastolicResult = 'Prehypertension') ;
		(   (	Diastolic < 100) ->
		    (	DiastolicResult = 'Stage 1 Hypertension') ;
		    (	DiastolicResult = 'Stage 2 Hypertension')))).

checkVital(heartRate,[HeartRate],[HeartRateResult]) :-
	(   HeartRate > 60, HeartRate < 100) ->
	HeartRateResult = 'normal' ;
	(   (	HeartRate < 0 ) ->
	    HeartRateResult = 'illegal' ; 
	    HeartRateResult = 'abnormal').

checkVital(oxygenSaturation,[OxygenSaturation],[OxygenSaturationResult]) :-
	(   OxygenSaturation > 90, OxygenSaturation < 100) ->
	OxygenSaturationResult = 'normal' ;
	(   (OxygenSaturation < 0) ; (OxygenSaturation < 100)) ->
	OxygenSaturationResult = 'illegal' ; 
	OxygenSaturationResult = 'abnormal'.

%% look online for LSVT

%% tests

testNormalVitalsChecks :- 
	Systolic = 140,
	Diastolic = 90,
	checkVital(bloodPressure,[Systolic,Diastolic],[SystolicResult,DiastolicResult]),
	view([bloodPressure,[Systolic,Diastolic],bloodPressureResult,[SystolicResult,DiastolicResult]]),

	HeartRate = 90,
	checkVital(heartRate,[HeartRate],[HeartRateResult]),
	view([heartRate,HeartRate,heartRateResult,HeartRateResult]),

	OxygenSaturation = 92,
	checkVital(heartRate,[OxygenSaturation],[OxygenSaturationResult]),
	view([oxygenSaturation,OxygenSaturation,oxygenSaturationResult,OxygenSaturationResult]).

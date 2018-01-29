:- dynamic formalizeThisWithNLUMF/1.

launchProgram(Program) :-
	write(Program), (fork(child), exec(Program) ; true).

launchPrograms :-
	log(DateTime1,hasSymptom(Person,'obstructiveSleepApnea')),
	getCurrentDateTime([Y-M-D,H:Mi:S]),
	(H > 19 ; H < 7) ->
	(
	 ensureCommandRunning('/usr/bin/stopwatch'),
	 ensureCommandRunning('/var/lib/myfrdcsa/codebases/internal/akahige/scripts/restart-patient-monitors.sh')
	 %% ensureCommandRunning('/var/lib/myfrdcsa/codebases/internal/akahige/scripts/record-patient-monitors.sh'),
	 ).

ensureCommandRunning(Command) :-
	fixme(ensureCommandRunning).

forwardChaining(akahige) :-
	log(DateTimeStamp,hasSymptom(Agent,Symptom)),
	preferredWorker(Agent,PreferredWorker),
	not(task(_,hasMedicalIssueToInvestigate(PreferredWorker,Symptom),_)),
	newTask('Agent1','Yaswi1',hasMedicalIssueToInvestigate(PreferredWorker,Symptom),critical,TaskID,Result),
	fail.
forwardChaining(akahige).

:- load_all_files_in_subdirectories_with_matching_names('/var/lib/myfrdcsa/codebases/internal/akahige/data/people','\\.pl$').
%% :- load_all_files_in_subdirectories_with_matching_names('/var/lib/myfrdcsa/private/systems/akahige/data-git/people','\\.pl$').

:- forwardChaining(akahige).
:- launchPrograms.


%% any txt file that is a subdir of this must be formalized

%% maybe change its name to scanned/ocred scanned/not-ocred or
%% something

apply_predicate_to_all_files_in_subdirectories_with_matching_names(Dir,Regex,Predicate) :-
	nl,write('APPLYING PREDICATE TO MATCHING FILES IN SUBDIRS RECURSIVELY: '),write(Dir),nl,
	sorted_directory_files_no_hidden(Dir,Files),
	member(File,Files),
	atomic_list_concat([Dir,'/',File],'',FullFile),
	(exists_file(FullFile) ->
	 (string_match_p(FullFile,Regex) -> (tab(4),write('APPLYING PREDICATE TO MATCHING FILE: '),write(FullFile),nl,call(Predicate,FullFile))) ;
	 apply_predicate_to_all_files_in_subdirectories_with_matching_names(FullFile,Regex,Predicate)),
	fail.
apply_predicate_to_all_files_in_subdirectories_with_matching_names(Dir,Regex,Predicate).

assertFormalizeThisWithNLUMF(Item) :-
	not(formalizeThisWithNLUMF(Item)),
	view([item,formalizeThisWithNLUMF(Item)]),
	fassert('Agent1','Yaswi1',formalizeThisWithNLUMF(Item),Result).
assertFormalizeThisWithNLUMF(Item).

%% <REDACTED>

%% queryRef(Agent1,Agent2,List) :-
%% 	tellDoctor(Agent1,Agent2,List).

akahigeNextAppointments(Agent) :-
	true.

akahigeNextAppointmentsWithDoctors(Agent) :-
	true.

%% phoneCall(from(More),to(Agent),queryIf(coming(Agents,to(Appt),at(more))))

makesReminderCalls(familyCounselingServices).
makesReminderCalls(visitingNursesAssociation).

expectEvent(Agent,phoneCallFrom(Provider,phoneNumberFn(PhoneNumber),DayBefore,scheduled(AppointmentID))) :-
	appointment(AppointmentID,Agent,AppointmentSpec),
	deadline(AppointmentID,[Date,Time]),
	consecutiveDates(DayBefore,[Date]),
	term_contains_subterm(Provider,AppointmentSpec),
	makesReminderCalls(Provider),
	(   hasPhoneNumber(Provider,phoneNumberFn(Number) ) -> (PhoneNumber = Number) ; (PhoneNumber = unknownFn(phoneNumber))),
	view(expect(Agent,phoneCallFrom(Provider,phoneNumberFn(PhoneNumber),DayBefore,scheduled(AppointmentID)))).

%% playExerciseMusic :-
%% 	after(beginsAction(momsExercises)).

hasExerciseMusic('<REDACTED>',['<REDACTED>']).

playExerciseMusic :-
	hasExerciseMusic(<REDACTED>,List),
	randomListElement(Elt,List),
	atomic_list_concat(['mplayer ',Elt],Command),
	ensureCommandRunning(Command).

tellDoctor(Agent,Doctor,[Question]) :-
	askDoctorAbout(Agent,Question),
	isa(Doctor,doctor).

%% procedure() :-
%% 	inform(Agent1,Agent2,hasPhoneNumber(Agent3,phoneNumberFn(PhoneNumber))),
%% 	hasHealthWorker(Patient,Agent2),
%% 	give medical people all of our phone numbers. text it to them or have website or something.

%% hasGloss((appointmentWith(A,B),A =..[groupFn|Args]),'$1 have an appointment with $2').
%% hasGloss(appointmentWith(A,B),'$1 has an appointment with $2').

groupMeetingInPerson(Location,DateTime,GroupTerm) :-
	appointment(AppointmentID,Patient,AppointmentSpec),
	deadline(AppointmentID,DateTime),
	List = [groupFn,Patient],
	append(List,Caregivers,GroupList),
	GroupTerm =.. GroupList.


%% findall(P,(predicate_property(user:P,file(_)),clause(P,B,R),C = :-(P,B),P =.. [hasConditions|A]),Terms),write_list(Terms).

%% stayAheadOfSymptoms(Agent) :-
%% 	list_terms_starting_with_predicate(hasConditions,Terms),
%% 	findall(Item,(member(Term,Terms),Term =.. [P,Agent,List],member(Item,List)),Issues),
%% 	findall(Symptom,(member(Issue,Issues),(someSymptomsOfCondition(Issue,Symptoms) ; []),member(Symptom,Symptoms)),AllSymptoms),
%% 	write_list(Symptom).

canTakeWhichMedicationsWithMeds(MedicationsTakenByAgent,TypeOfAdditionalMedicationsDesired,AdditionalMedicationsPermitted) :-
	true.

%% <REDACTED>
%% <REDACTED>

isa(X,Y) :-
	hasProfession(X,Y).

generatePageFor(akahige,UserName,[communications,Communications]) :-
	catalystUserNameResolvesToAgent(UserName,UserActualName),
	findall([UserActualName,Doctor,Communication],ask(oneOf(frdcsaAgentFn(akahige),UserActualName),Doctor,Communication),Communications).

currentMedicationsListPrintout(Agent,Printout) :-
	findall(Medication,hasMedication(Agent,Medication),Medications),
	atomic_list_concat(Medications,'\n',Printout).

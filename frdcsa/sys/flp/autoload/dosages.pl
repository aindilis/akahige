%% ((record caffeine levels and how it affects me)

%%  (caffeine is 599mg per day for 220lb person per https://www.caffeineinformer.com/caffeine-safe-limits)
%%  (single doses of 200mg at one time are fine for those engaging in exercise directly after the dose)

%%  (Up to 400 mg caffeine per day appears to be safe)
%%  (Red Bull (8.2 oz) 80.0 mg caffeine
%%   Mountain Dew (12 oz) 55.0 mg caffeine
%%   Rockstar (16 oz) 160.0 mg caffeine
%%   Mountain Dew Voltage (Code Blue) (12 oz) 55.0 mg caffeine
%%   )
%%  )

hasAmount(sizeFn(redBull,oz(8.2)),caffeine,mg(80)).
hasAmount(sizeFn(mountainDew,oz(12)),caffeine,mg(55)).
hasAmount(sizeFn(rockstar,oz(16)),caffeine,mg(160)).
hasAmount(sizeFn(mountainDewVoltageCodeBlue,oz(12)),caffeine,mg(55)).

default(hasSafeAmount(Person,caffeine,per(day,mg(400)))).
if(hasWeight(Person,220),hasSafeAmount(Person,caffeine,per(day,mg(599)))).

%%  (single doses of 200mg at one time are fine for those engaging in exercise directly after the dose)
%% if(hasWeight(Person,220),hasSafeAmount(Person,caffeine,per(day,mg(599)))).

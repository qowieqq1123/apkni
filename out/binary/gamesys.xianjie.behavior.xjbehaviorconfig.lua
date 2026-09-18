







local config_={

goto_search_cloud={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_gotoSearch},
},
},

search_cloud={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_searchCloud},
},
},

plot_goto={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_plotGoto},
},
},

plot_battle={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_plotBattle},
},
},

plot_retract={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_plotRetract},
},
},

march_goto={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_marchGoto},
},
},

march_battle={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_marchBattle},
},
},

march_single_goto={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_marchSingleGoto},
},
},

respoint_goto={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_respointGoto},
},
},

respoint_battle={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_respointBattle},
},
},

respoint_retract={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_respointRetract},
},
},

mojunbox_goto={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_mojunboxGoto},
},
},

mojunbox_battle={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_mojunboxBattle},
},
},

mojunbox_retract={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_mojunboxRetract},
},
},

caravan_escort_goto={
xjBehaviorNodeType.eSequence,
{

{xjBehaviorJobType.eJob_caravanEscortGoto},
},
},
}

return config_
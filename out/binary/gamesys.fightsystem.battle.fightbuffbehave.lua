def_class("fightBuffBehave",{})

local stopEffect=CS.GameInterface.StopEffect



local buffBehaveTypoMap={
[eFightBuffBehave.scale]=function(args)
local ent,buffInfo,waitTime=args.ent,args.buffInfo,args.waitTime
if buffInfo then
local data=buffInfo.data
local dst=data[1]
if data.layer then
ent:scaleToRate(1+data.layer*dst,buffInfo.duration or 0,0,1,nil)
else
ent:scaleToRate(dst,buffInfo.duration or 0,0,1,nil)
end

else
if ent.guid~=-1 then

ent:scaleToRate(1,waitTime,0,1,nil)
end
ent.lastBuffBehave[eFightBuffBehave.scale]=nil
end
end,
[eFightBuffBehave.color]=function(args)
local ent,buffInfo,waitTime=args.ent,args.buffInfo,args.waitTime
if buffInfo then
local dst=buffInfo.data[1]
local duration=buffInfo.data[2]
if duration then
ent:startFadeToColorLoop(Color.StrToColor(tostring(dst)),duration or 0)
else
ent:fadeToColor(Color.StrToColor(tostring(dst)),buffInfo.duration or 0)
end

else

if ent.guid~=-1 then
ent:stopFadeToColorLoop(waitTime)
end
ent.lastBuffBehave[eFightBuffBehave.color]=nil
end
end,

[eFightBuffBehave.changeModel]=function(args)
local ent,buffInfo,waitTime=args.ent,args.buffInfo,args.waitTime
if buffInfo then
local haveEnter=false
if waitTime>0 then
if buffInfo.data[3]then
haveEnter=true
end
end
local dst=buffInfo.data[1]
ent.newBoby=dst[1]
local components={}
local baseInfo=ent:getbaseInfo()
if baseInfo.weaponID and baseInfo.weaponID>0 and dst[4]==1 then
table.insert(components,cfgHelper.get2(cfg_discipleweaponimageconfig_get,baseInfo.weaponID,'out_side'))
for i,v in ipairs(dst[2]or defaultT)do
table.insert(components,v)
end
else
components=dst[2]or defaultT
end
if haveEnter and not ent.isRunBehavior then
ent:runBehavior(buffInfo.data[3],nil,function()
if ent.newBoby==dst[1]then
ent:changeBody(dst[1],components,dst[3]or ent.scale)
end
end)
else
ent:changeBody(dst[1],components,dst[3]or ent.scale)
end

else

local haveOver=false
local lastBehave=ent.lastBuffBehave[eFightBuffBehave.changeModel]
if lastBehave then
if lastBehave.buffInfo.data[4]then
haveOver=true
end
end
if haveOver and not ent.isRunBehavior then
ent:runBehavior(lastBehave.buffInfo.data[4],nil,function()
if ent.model and ent.model.body then
ent:changeBody(ent.model.body,ent.model.componets or{},ent.scale)
end
end)
else
if ent.model and ent.model.body and ent.bodyID~=ent.model.body then
ent:changeBody(ent.model.body,ent.model.componets or{},ent.scale)
end
end
ent.lastBuffBehave[eFightBuffBehave.changeModel]=nil
end
end,
[eFightBuffBehave.addBody]=function(args)
local ent,buffInfo,waitTime=args.ent,args.buffInfo,args.waitTime
if buffInfo then
local haveEnter=false
if waitTime>0 then
if buffInfo.data[2]then
haveEnter=true
end
end
local dst=buffInfo.data[1]
ent.addBodyId=dst[1]
local components=dst[2]or defaultT
local scale=dst[3]or ent.scale

if ent.addEnt then

fightManager.removeEntity(ent.addEnt.GUID)
ent.addEnt=nil
end

if haveEnter and not ent.isRunBehavior then
ent:runBehavior(buffInfo.data[2],nil,function()
if ent.addBodyId==dst[1]and not ent.addEnt then
local addEnt=fightManager.addEntity(dst[1],components,ent:getPosition(),ent.m_flipX,eAnimationID.stand,scale)
ent.addEnt=addEnt
end
end)
else
local addEnt=fightManager.addEntity(dst[1],components,ent:getPosition(),ent.m_flipX,eAnimationID.stand,scale)
ent.addEnt=addEnt
end
else

if ent.addEnt then
fightManager.removeEntity(ent.addEnt.GUID)
ent.addBodyId=nil
ent.addEnt=nil
end
end
end,
}






function fightBuffBehave.exeBuffBehave(buffBehaveType,args)
local bFunc=buffBehaveTypoMap[buffBehaveType]
if bFunc then
bFunc(args)
end
end
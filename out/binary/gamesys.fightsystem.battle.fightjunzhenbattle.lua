





local getRoundData=function(data)

local round={}
local last=5
local isDead=false
for i,v in ipairs(data)do
if i>2 and i<last then
table.insert(round,{

{},

{

{fightActionType.CLIENT_JUN_ZHEN_ACTION,i-1,v,isDead}
},

{},
{},

{},
})

local left=fightModel:getJunZhenTotalNum(v[1])
local right=fightModel:getJunZhenTotalNum(v[2])
if left==0 or right==0 then
isDead=true
end
end
end

return round
end


function fightBattle:initJunZhenStage()
local mapID=self.stageInfo[stageInfoTag.mapID]
if not self.useReportMapId then
local stageCfg=fightModel:getStage(mapID)
if stageCfg and stageCfg.jzConfig then
mapID=cfgHelper.get(cfg_jzbaseconfig_get,stageCfg.jzConfig,"stage")
else
mapID=cfgHelper.get(cfg_jzbaseconfig_get,1,"stage")
end
end
local stageCfg=fightModel:getStage(mapID)
if stageCfg==nil then
stageCfg=fightModel:getStage(fightStage.defStageID)
end
self.stageCfg=stageCfg
self.stage=stageCfg.assetbundle
self.stageBgm=stageCfg.bgMusic
self.witnessInfo=stageCfg.witness
end

function fightBattle:initJunZhen()
fightModel:initJunModelParam()

self.accMulti=userActorSetting.get("AccMulti",0)
self:initStageCustomInfo()

self.showFightStartFlag=false

self.buffWaitTime=0
local fightInfo=self.fightInfo

local leftEntities=fightInfo[fightReportTag.attack]
local rightEntities=fightInfo[fightReportTag.defend]

local leftPosTypo=self.stageInfo[stageInfoTag.leftTypo]
local rightPosTypo=0

local data=fightInfo[fightReportTag.jzRound]or{}

local startJunZhenBattle=next(data)~=nil

local roundData=getRoundData(data)

if startJunZhenBattle then
self:initJunZhenStage()
local preSelectEntity=self.preSelectEntity or{}
self.entities={}
self.witnessEntities={}

local jzABLookup={}

local isBattleMon=false

local leftNum=0
for i,v in ipairs(leftEntities)do if v[fightEntityTag.typo]>=0 then leftNum=leftNum+1 end end

local rightNum=0
for i,v in ipairs(rightEntities)do
if v[fightEntityTag.typo]>=0 then rightNum=rightNum+1 end
if not isBattleMon and v[fightEntityTag.typo]>0 then
isBattleMon=true
end
end

self.jzLeftTeamNum=leftNum

local teamListLeft,jzMaxLeft=fightModel:getJunZhenTeamList(data[2][1],leftNum)
local jzMaxTeamLeft=math.ceil(jzMaxLeft/leftNum)
local teamListRight,jzMaxRight,jzMaxTeamRight
if isBattleMon then
teamListRight,jzMaxRight=fightModel:getJunZhenTeamList(data[2][2],leftNum)
jzMaxTeamRight=math.ceil(jzMaxRight/leftNum)
else
teamListRight,jzMaxRight=fightModel:getJunZhenTeamList(data[2][2],rightNum)
jzMaxTeamRight=math.ceil(jzMaxRight/leftNum)
end
local jzMaxNum=math.max(jzMaxTeamLeft,jzMaxTeamRight)

for i,v in ipairs(leftEntities)do
local id=i+400
if v[fightEntityTag.typo]>=0 then
local info=fightModel:createJunZhenInfo(teamListLeft,v[fightEntityTag.typo],self.stageInfo[stageInfoTag.mapID])
info.jzMaxNum=jzMaxNum
if info.entModel then
jzABLookup[info.entModel]=1
end

local ent=fightJunZhen(self,leftPosTypo,id,info,true)
self.entities[id]=ent

end
end

if isBattleMon then

self.jzRightTeamNum=leftNum
local typo=0
for i,v in ipairs(rightEntities)do
if v[fightEntityTag.typo]>0 then
typo=v[fightEntityTag.typo]
break
end
end
for i,v in ipairs(leftEntities)do
local id=i+405
if v[fightEntityTag.typo]>=0 and next(teamListRight)then
local info=fightModel:createJunZhenInfo(teamListRight,typo,self.stageInfo[stageInfoTag.mapID])
info.jzMaxNum=jzMaxNum
if info.entModel then
jzABLookup[info.entModel]=1
end
local ent=fightJunZhen(self,rightPosTypo,id,info,true)
self.entities[id]=ent
end
end
else
self.jzRightTeamNum=rightNum

for i,v in ipairs(rightEntities)do
local id=i+405
if v[fightEntityTag.typo]>=0 and next(teamListRight)then
local info=fightModel:createJunZhenInfo(teamListRight,v[fightEntityTag.typo],self.stageInfo[stageInfoTag.mapID])
info.jzMaxNum=jzMaxNum
if info.entModel then
jzABLookup[info.entModel]=1
end
local ent=fightJunZhen(self,rightPosTypo,id,info,true)
self.entities[id]=ent
end
end
end

if preSelectEntity~=nil then
for i,v in pairs(preSelectEntity)do
v:remove()
end
self.preSelectEntity=nil
end

self.jzRoundIndex=jzMaxRight==0 and#roundData or 0
self.jzRoundData=roundData
self.jzTotalRound=#roundData

self.jzRoundObj=fightRound(self)
self.jzMaxNum=jzMaxNum
self.isBattleMon=isBattleMon

self.jzMaxLeft=jzMaxLeft
self.jzMaxRight=jzMaxRight


local list={}
for n,v in pairs(jzABLookup)do
table.insert(list,n)
end
self.jzABList=list
end

return startJunZhenBattle
end


function fightBattle:getJunZhenLog()
local fightInfo=self.fightInfo
local data=fightInfo[fightReportTag.jzRound]or{}

local logReport={}

if not next(data)then
return
end

logReport['初始军阵']={}


for i,v in ipairs(data[2])do
local l={}
local jzData=v
for _,vv in ipairs(jzData)do
local jzLv=vv[1]
local jzNum=vv[2]
local cfg=cfgHelper.get(cfg_jzconfig_get,jzLv)
l[cfg.name]=jzNum
end
logReport['初始军阵'][i]=l
end

logReport['军阵过程']={}

for i=3,4 do
local v=data[i]
local list={}
for i2,v2 in ipairs(v)do
local l={}
for _,vv in ipairs(v2)do
local jzLv=vv[1]
local cfg=cfgHelper.get(cfg_jzconfig_get,jzLv)
l[cfg.name]={["健康兵"]=vv[2],["轻伤兵"]=vv[3],["重伤兵"]=vv[4],["死亡兵"]=vv[5]}
end
list[i2]=l
end

logReport['军阵过程']["第"..(i-2).."轮"]=list
end

logReport['军阵属性转换']={}
local attrList=data[5]
for _,v in ipairs(attrList)do
local idx=v[1]
local attr={}
local fight=0
for i=2,#v do
table.insert(attr,FMT.fmt("{0}:{1}",entityAttrName[v[i][1]]or v[i][1],v[i][2]))







end



logReport['军阵属性转换'][idx]=attr
end

return logReport
end

local longZhouModel=6012
local longZhouPos=
{
[1]={Vector3.New(-70,1.52-100,12.4),3.81},
[2]={Vector3.New(-50,0.97-100,-14.5),2.75},
[3]={Vector3.New(-70,1.52-100,12.4),3.81},
[4]={Vector3.New(50,0.97-100,-14.5),2.75},
}
local longZhouMovePos=
{
[1]=Vector3.New(-55.5,1.52-100,12.4),
[2]=Vector3.New(-37.1,0.97-100,-14.5),
[3]=Vector3.New(55.5,1.52-100,12.4),
[4]=Vector3.New(37.1,0.97-100,-14.5),
}

local longZhouEffectPos=
{
[1]=Vector3.New(-40,1.72-200,19.5),
[2]=Vector3.New(-25.21,1.17-200,-11),
[3]=Vector3.New(40,1.72-200,19.5),
[4]=Vector3.New(25.84,1.17-200,-11),
}

local longZhouOnePos=
{
[1]={Vector3.New(-60,1.52-200,4.4),3},
[4]={Vector3.New(60,1.52-200,4.4),3},
}
local longZhouOneMovePos=
{
[1]=Vector3.New(-44,1.52-200,4.4),
[4]=Vector3.New(44,1.52-200,4.4),
}
function fightBattle:showLongZhou(call)
self.lzEnt=self.lzEnt or{}

local longZhouType=1

local lzPos=longZhouType==1 and longZhouOnePos or longZhouPos
local lzMovePos=longZhouType==1 and longZhouOneMovePos or longZhouMovePos

for i,v in pairs(lzPos)do
if i<=2 or not self.isBattleMon then
local ent=fightManager.addEntity(longZhouModel,{},fightModel:transToBattleWorld(v[1]),i>2,0,v[2])
table.insert(self.lzEnt,ent)
self:exelongZhouBehavior(ent,i,i==1 and call or nil,fightModel:transToBattleWorld(lzMovePos[i]))
end
end

end

function fightBattle:exelongZhouBehavior(ent,index,call,lzMovePos)
ent:MoveTo(lzMovePos,false,1.5,0,function()
if call then call()end
end)
end


function fightBattle:showAllJZEntity(enterAni,delayShow)

fightManager.enableAdjustAspect(false)

fightManager.setCameraAnimation(0,true)

fightManager.genDynamicAltlas(self.jzABList,function(ret)
if ret~=-1 then
self:showLongZhou(function()
for i,ent in pairs(self.entities)do
ent:show()
end
end)
else
logErr("genDynamicAltlas Failed")
end
end)

self.enterDelayTime=2.2

UIManager:showWindow("UIFightEffect",{para=10067})
end



function fightBattle:playJunZhenNextRound()
self.jzRoundIndex=self.jzRoundIndex+1
local data=self.jzRoundData[self.jzRoundIndex]

if data~=nil then
if self.isShowWindow then
UIManager:invokeUIMethod('UIFightMainTop','flushRoundInfo')
end
self.jzRoundObj:play(self.jzRoundIndex,data)
else
self:onCompleteJunZhenBattle(false)
end
end

function fightBattle:onCompleteJunZhenBattle(skip)

if self.isOver then
return
end

self.isOver=true

local cameraTime=3.5
local delayTime=6.3

local jzAfterAttr=self:getJZAfterAttr()
local jzEntity={}
if skip then
delayTime=delayTime-cameraTime
cameraTime=0
for i,ent in pairs(self.entities)do
if i>=401 and i<=410 then
ent:onComplete()
fightManager.setEntityTroops(ent.guid,nil,-1,0,Vector3.zero)
ent:remove()
end
end
else
for i,ent in pairs(self.entities)do
if i>=401 and i<=410 then
jzEntity[i]=ent
if jzAfterAttr[i-400]then
ent:playEffect(20616,Vector3.New(i<406 and-3 or 3,0,0),false,true,Vector3.one)
end
end
end
end



local onEnd=function()

for i,ent in pairs(jzEntity)do
ent:onComplete()
fightManager.setEntityTroops(ent.guid,nil,-1,0,Vector3.zero)
ent:remove()
end


if self.lzEnt then
for i,v in pairs(self.lzEnt)do
fightManager.removeEntity(v.GUID)
end
self.lzEnt=nil
end

fightManager.setState(fightSceneTypo.fight)

UIFullFightControl:showFightMain(self)





self.isShowWindow=true

for i,ent in pairs(self.entities)do
if i>=1 and i<=10 then
ent:showHuD(true)
end
end

self:startTimer(3.4+self.enterDelayTime+self.enterDelayTimeDaZhen)

self.isBeginNextBattle=nil

self.transSceneTimer2=nil

self.isJzTrans=nil
end

self:stopTransJZSceneTimer()
self.transSceneTimer=timer.new()
self.transSceneTimer:start(cameraTime,function()
fightManager.setCameraAnimation(1,true)
if self.isShowWindow then
UIManager:invokeUIMethod('UIFightMainTop','showJunZhen',false)
end

self:initNormal(jzAfterAttr,true)
self:showAllEntity(nil,1.5)
self.transSceneTimer=nil
end,1)


self.transSceneTimer2=timer.new()
self.transSceneTimer2:start(delayTime,onEnd,1)

self.isJzTrans=true

end

function fightBattle:onCloseJunZhen()
if self.jzBattleXiaoRen then
fightManager.removeEntity(self.jzBattleXiaoRen.GUID)
self.jzBattleXiaoRen=nil
end
if self.lzEnt then
for i,v in pairs(self.lzEnt)do
fightManager.removeEntity(v.GUID)
end
self.lzEnt=nil
end
end

function fightBattle:stopTransJZSceneTimer()
if self.transSceneTimer then
self.transSceneTimer:cancel()
self.transSceneTimer=nil
end
if self.transSceneTimer2 then
self.transSceneTimer2:cancel()
self.transSceneTimer2=nil
end
end


function fightBattle:isTransJZSceneTimerPlaying()
return self.transSceneTimer~=nil or self.transSceneTimer2~=nil or self.isJzTrans~=nil
end


function fightBattle:getJZAfterAttr()
local data=self.fightInfo[fightReportTag.jzRound]or{}
if next(data)then
local afterAttr={}
local attrList=data[5]
for _,v in ipairs(attrList)do
local idx=v[1]
local attr={}
for i=2,#v do
attr[v[i][1]]=v[i][2]
end
afterAttr[idx]=attr
end
return afterAttr
end
return{}
end

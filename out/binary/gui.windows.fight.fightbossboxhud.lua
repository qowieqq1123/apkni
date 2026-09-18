






def_class("FightBossBoxHUD",FightBossHUD)

local this

function FightBossBoxHUD:init(mcfg)
FightBossBoxHUD._base.init(mcfg)

this=self
self.speFlag=mcfg.speFlag==1
self.demageBarData=mcfg.demageBar
self.bossName=mcfg.name
self.demageBarType=mcfg.demageBarType or 3
self.currDemageIndex=1
self.hudItemComp=self:getHudItemComp()
self.hudItemComp.levelUpEffect=26
self.hudItemComp.boxCount=27
self.hudItemComp.box=28
self.boxCount=5
self.accuCount=5
self.delayCount=0

self:getPos()


end

function FightBossBoxHUD:initHud()
FightBossBoxHUD._base.initHud(self)
self:initRangeData()

self.abName='ui/windows/emergencies/ruishoulinmen_atlas_pak.ab'
if self.demageBarType==3 then
self.winlua:SetChildText(self.hudItemComp.EntityName,self.bossName)
self.winlua:SetChildActive(self.hudItemComp.headIcon,not self.speFlag)
end

self.ProgressBar.Value=0
self.flickProgressBar.Value=0

local data=self.demageBarData[1]

self.winlua:SetChildText(self.hudItemComp.boxCount,self.boxCount)

self.winlua:SetChildText(self.hudItemComp.demageNum,FMT.fmt('{0}/{1}',0,data[2]-data[1]))
if self.demageBarType==3 then
self.winlua:SetChildActive(self.hudItemComp.pbIcon,true)
self.winlua:SetChildCSImageSprite(self.hudItemComp.pbIcon,self.abName,"icon_ruishoubaoxiang_03")
else
self.winlua:SetChildActive(self.hudItemComp.pbIcon,false)
end
end

function FightBossBoxHUD:playLevelUpEffect()
self.winlua:SetChildShowEffect(self.hudItemComp.levelUpEffect,10490,true)
if self.demageBarType==3 then
self.winlua:SetChildCanvasGroupAlpha(self.hudItemComp.pbIcon,0)
self.winlua:SetChildCanvasGroupDOFade(self.hudItemComp.pbIcon,1,0.6,nil)
self.winlua:SetChildScale(self.hudItemComp.pbIcon,Vector3.New(0.5,0.5,1))
self.winlua:SetChildDOScale(self.hudItemComp.pbIcon,1,0.6,nil)
else
self.winlua:SetChildCanvasGroupAlpha(self.hudItemComp.headIcon,0)
self.winlua:SetChildCanvasGroupDOFade(self.hudItemComp.headIcon,1,0.6,nil)
self.winlua:SetChildScale(self.hudItemComp.headIcon,Vector3.New(0.5,0.5,1))
self.winlua:SetChildDOScale(self.hudItemComp.headIcon,1,0.6,nil)
end
end


function FightBossBoxHUD:initRangeData()
local ent=self.entHUD.entity
local data=self.demageBarData[1]
if not(data~=nil and type(data[1])=='number')then
local lv=ent:getAttribute(entityAttr.level)

if not self.demageBarData[lv]then
local key=next(self.demageBarData)
self.demageBarData=self.demageBarData[key]
loggerUtil.logErrFMT("找不到对应等级{0}的伤害显示",lv)
else
self.demageBarData=self.demageBarData[lv]
end
end
end

function FightBossBoxHUD:setHPEx(demage)
local index
local score=5

self:initRangeData()
local data
for i,v in ipairs(self.demageBarData)do
if demage>=v[1]and demage<=v[2]then
index=i
data=v

if index>1 then
score=self.demageBarData[index-1][3]+5
end
break
end
end

if not index then
index=#self.demageBarData
data=self.demageBarData[index]
score=data[3]+5
end

local levelUp=index>self.currDemageIndex
self.currDemageIndex=index

if levelUp then
if self.demageBarType==3 then
self.winlua:SetChildCSImageSprite(self.hudItemComp.pbIcon,self.abName,"icon_ruishoubaoxiang_03")
end
self:playLevelUpEffect()
self:playAnim(score)





end

if index==#self.demageBarData then
self.scoreFull=true
end

local chp=demage-data[1]
local mhp=data[2]-data[1]
self.winlua:SetChildText(self.hudItemComp.demageNum,FMT.fmt('{0}/{1}',demage,data[2]))
self.winlua:SetChildText(self.hudItemComp.boxCount,FMT.fmt('{0}',score))

local rate=chp/mhp
rate=Mathf.Clamp01(rate)
local targetValue=math.modf(rate*self.ProgressBar.Max)
self.ProgressBar:Animate(targetValue,0.2)
self.flickProgressBar:Animate(targetValue)
end

function FightBossBoxHUD:setHP(hp,maxHP,subMaxhp,rcHP)
if self.speFlag then
self:setHPEx(rcHP)
return
end
FightBossBoxHUD._base.setHP(self,hp,maxHP,subMaxhp,rcHP)
end

function FightBossBoxHUD:getPos()
local endPos
local offestPos=self.ent:getHudOffset()
local uiWorldPos=self.ent:getHudPosition()
offestPos.x=uiWorldPos.x-2
offestPos.y=uiWorldPos.y-offestPos.y-1
endPos=Vector3((uiWorldPos.x+2),(uiWorldPos.y+1.5),uiWorldPos.z)

self.uiWorldPos=uiWorldPos
self.offestPos=offestPos
self.endPos=endPos
end

function FightBossBoxHUD:initPos()
local offestPos=self.offestPos
local uiWorldPos=self.uiWorldPos

local randomPos=
{
[1]=Vector3((uiWorldPos.x+3),(offestPos.y+0.7),uiWorldPos.z),
[2]=Vector3((uiWorldPos.x+1),(offestPos.y-0.3),uiWorldPos.z),
[3]=Vector3((uiWorldPos.x-1),(offestPos.y),uiWorldPos.z),
[4]=Vector3((uiWorldPos.x+2.7),(offestPos.y-0.5),uiWorldPos.z),
[5]=Vector3((uiWorldPos.x-2),(offestPos.y-1),uiWorldPos.z),
[6]=Vector3((uiWorldPos.x-1),(offestPos.y-2),uiWorldPos.z),
[7]=Vector3((uiWorldPos.x),(offestPos.y-1.2),uiWorldPos.z),
[8]=Vector3((uiWorldPos.x+2),(offestPos.y-2),uiWorldPos.z),
}

return randomPos
end

function FightBossBoxHUD:instanceOneBox(score,pos)
local rid

if not self.list then self.list={}end
local parent=self.winlua:GetChildGameObject(self.hudItemComp.box).transform

rid=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIFlyBox,parent,function(iconId)
table.insert(self.list,iconId)
local icon=_InstantiateManager.GetComponent(iconId,'CSGUIWidgetBase')
icon:SetChildCanvasGroupAlpha(0,0)
icon:SetChildPosition(0,self.uiWorldPos)
icon:SetChildCanvasGroupDOFade(0,1,1)
icon:SetChildDOJump(0,pos,1,1,0.5,function()
self:checkClear()
end)
end)
end

function FightBossBoxHUD:checkRemain()
self:delayDo(0.5,function()
if self.delayCount>0 then
self:playAnim(self.delayCount,true)
end
end)
end

function FightBossBoxHUD:checkClear()
if self.accuCount==8 or self.scoreFull then
self:delayDo(1,function()
self:clearBox()
self.list={}
self.accuCount=0
self:checkRemain()
self.randomPos=self:initPos()
self.celarIng=false
end)
end
end

function FightBossBoxHUD:playAnim(score,flag)

local num

if flag then
num=score
self.delayCount=0
else
num=score-self.boxCount
self.boxCount=score
end


if self.accuCount+num>8 then
local curNum=8-self.accuCount
local distance=num-curNum
num=curNum
self.celarIng=true

if flag then
self.delayCount=distance
else
self.delayCount=self.delayCount+distance
end
end

self.accuCount=self.accuCount+num
local posList=self:getRandom(num)

for i=1,num do
local pos=posList[i]
self:instanceOneBox(score,pos)
end
end

function FightBossBoxHUD.onBattleRoundChange(battleId,oldround,newround)

if this.scoreFull then

end
end

function FightBossBoxHUD:clearBox()
if this.list then
for k,iconId in ipairs(this.list)do
local icon=_InstantiateManager.GetComponent(iconId,'CSGUIWidgetBase')
icon:SetChildShowEffect(2,10702,true)
icon:SetChildDOScale(0,0,1,function()
icon:SetChildDOJump(0,this.endPos,1,1,1,function()
_InstantiateManager.RemoveInstance(iconId)
if self.scoreFull then
self:delayDo(0.5,function()
UIManager:invokeUIMethod("UIFightMainTop","onSkipBtn")
end)
end
end
)
end
)
end
end
end

function FightBossBoxHUD:getRandom(num)
local list={}
if not self.randomPos or#self.randomPos==0 then
self.randomPos=self:initPos()
end

for i=1,num do
local len=#self.randomPos
local idx=math.random(1,len)
local temp=self.randomPos[idx]

table.insert(list,temp)
self.randomPos=self:removeRandom(idx)
end

return list
end

function FightBossBoxHUD:removeRandom(idx)
local list={}
for k,v in ipairs(self.randomPos)do
if k~=idx then
table.insert(list,v)
end
end
return list
end
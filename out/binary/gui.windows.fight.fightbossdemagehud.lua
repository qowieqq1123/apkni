






def_class("FightBossDemageHUD",FightBossHUD)

function FightBossDemageHUD:init(mcfg)
FightBossDemageHUD._base.init(mcfg)

self.speFlag=mcfg.speFlag==1
self.demageBarData=mcfg.demageBar

self.demageBarType=mcfg.demageBarType or 1
self.currDemageIndex=1
self.hudItemComp=self:getHudItemComp()
self.hudItemComp.levelUpEffect=26
end

function FightBossDemageHUD:initHud()
FightBossDemageHUD._base.initHud(self)

self:initRangeData()

self.abName='ui/windows/fight/demagehud_atlas_pak.ab'
if self.demageBarType==1 then
self.winlua:SetChildText(self.hudItemComp.EntityName,'伤害评级')
self.winlua:SetChildActive(self.hudItemComp.headIcon,not self.speFlag)
end

self.ProgressBar.Value=0
self.flickProgressBar.Value=0



local data=self.demageBarData[1]


self.winlua:SetChildText(self.hudItemComp.demageNum,FMT.fmt('{0}/{1}',0,data[2]-data[1]))
if self.demageBarType==1 then
self.winlua:SetChildActive(self.hudItemComp.pbIcon,true)
self.winlua:SetChildCSImageSprite(self.hudItemComp.pbIcon,self.abName,data[3])
else
self.winlua:SetChildActive(self.hudItemComp.pbIcon,false)
end

local ent=self.entHUD.entity
if ent then
self:setHPEx(ent.rcHP)
end
end

function FightBossDemageHUD:playLevelUpEffect()
self.winlua:SetChildShowEffect(self.hudItemComp.levelUpEffect,10490,true)
if self.demageBarType==1 then
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


function FightBossDemageHUD:initRangeData()
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

function FightBossDemageHUD:setHPEx(demage)
local index

self:initRangeData()
local data
for i,v in ipairs(self.demageBarData)do
if demage>=v[1]and demage<=v[2]then
index=i
data=v
break
end
end

if not index then
index=#self.demageBarData
data=self.demageBarData[index]
end

local levelUp=index>self.currDemageIndex
self.currDemageIndex=index

if levelUp then
if self.demageBarType==1 then
self.winlua:SetChildCSImageSprite(self.hudItemComp.pbIcon,self.abName,data[3])
end
self:playLevelUpEffect()
end

local chp=demage-data[1]
local mhp=data[2]-data[1]
self.winlua:SetChildText(self.hudItemComp.demageNum,FMT.fmt('{0}/{1}',demage,data[2]))

local rate=chp/mhp
rate=Mathf.Clamp01(rate)
local targetValue=math.modf(rate*self.ProgressBar.Max)
self.ProgressBar:Animate(targetValue,0.2)
self.flickProgressBar:Animate(targetValue)
end

function FightBossDemageHUD:setHP(hp,maxHP,subMaxhp,rcHP)
if self.speFlag then
self:setHPEx(rcHP)
return
end
FightBossDemageHUD._base.setHP(self,hp,maxHP,subMaxhp,rcHP)
end









def_class("UIFightHUD",UICloneObject)





UIFightHUD.abName="ui/windows/fight/uifighthud.ab"

UIFightHUD.assetName="UIFightHUD"


function UIFightHUD:bindComponents()

self.bar=UIProgress.get(self,0)
self.baseInfo=UIObject.get(self,1)
self.BuffRoot=UIScrollView.get(self,2)
self.BuffRoot2=UIObject.get(self,3)
self.CounterATKPointRoot=UIObject.get(self,4)
self.Energy=UIObject.get(self,5)
self.energyBar=UIProgress.get(self,6)
self.EntityName=UIText.get(self,7)
self.fabao=UIImage.get(self,8)
self.fabaoLeft=UIImage.get(self,9)
self.fullEnergyBar=UIProgress.get(self,10)
self.fullHPHuDunbar=UIProgress.get(self,11)
self.fullSubHPMaxbar=UIProgress.get(self,12)
self.huDunbar=UIProgress.get(self,13)
self.Root=UIObject.get(self,14)
self.spRoot=UIGameobjectClone.new(self,15)
self.spRootDown=UIGameobjectClone.new(self,16)

end


function UIFightHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bar);self.bar=nil;
_UIObject_release(self.baseInfo);self.baseInfo=nil;
_UIObject_release(self.BuffRoot);self.BuffRoot=nil;
_UIObject_release(self.BuffRoot2);self.BuffRoot2=nil;
_UIObject_release(self.CounterATKPointRoot);self.CounterATKPointRoot=nil;
_UIObject_release(self.Energy);self.Energy=nil;
_UIObject_release(self.energyBar);self.energyBar=nil;
_UIObject_release(self.EntityName);self.EntityName=nil;
_UIObject_release(self.fabao);self.fabao=nil;
_UIObject_release(self.fabaoLeft);self.fabaoLeft=nil;
_UIObject_release(self.fullEnergyBar);self.fullEnergyBar=nil;
_UIObject_release(self.fullHPHuDunbar);self.fullHPHuDunbar=nil;
_UIObject_release(self.fullSubHPMaxbar);self.fullSubHPMaxbar=nil;
_UIObject_release(self.huDunbar);self.huDunbar=nil;
_UIObject_release(self.Root);self.Root=nil;
self.spRoot:deleteSelf();self.spRoot=nil;
self.spRootDown:deleteSelf();self.spRootDown=nil;
end






local _cmpItemWidgetIdx=
{
cmpIcon=0,
buffCount=1,
buffLayer=2,
buffProtect=3,
}

local fightab="ui/windows/fight/sharedtextures/fight.ab"

local hpImage=
{
[1]="image_zdxietiao_1",
[2]="image_zdxietiao_2",
[3]="image_zdxietiao_3",
}

function UIFightHUD:onLoaded()
self:bindComponents()

end

function UIFightHUD:initUpdateTimer()
self:stopUpdateTimer()
self.updateTimer=self:setTimer(0.1,0,function()self:onUpdate()end)
end

function UIFightHUD:stopUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function UIFightHUD:__delete()
if self.ent~=nil and self.ent.fabaoObjID~=nil then
self.fabaoObjID=self.ent.fabaoObjID
self.ent:stopText(self.ent.fabaoObjID)
self.ent.fabaoObjID=nil
end
if self.fabaoObjID~=nil then
self.ent:stopText(self.fabaoObjID)
self.fabaoObjID=nil
end





self:recycleSpObject()

self.ent=nil
self:stopUpdateTimer()

self.entHUD:setHUDWin(nil)



self:unbindComponents()
end

function UIFightHUD:onShow(args)
self.entHUD=args.entHUD
self.entHUD:setHUDWin(self)
self.ent=self.entHUD.entity
self.fadeFaBao=nil
self.fabaoObjID=nil
local show=args.show
self.isClose=nil
if fightModel:isAssist(self.ent.id)then
show=false
end
self:showRoot(show)
if show then
self.baseInfo:setChildCanvasGroupAlpha(0)
self:fade(0.5,1)
self:flushPosition()
self:initEnt()

self:flushBuff(self.ent:getBuffInfo())
self:flushCounterAtkPoint(self.ent:getATKPoint())

local HPType=fightEntityHPType.left
if self.ent.battle and self.ent.battle.teamHpType then
HPType=self.ent.battle.teamHpType
end
self:setHPSprite(self.ent.posInfo.left and HPType[1]or HPType[2])
end
end

function UIFightHUD:setHPSprite(index)
self.bar:setCSImageSprite(fightab,hpImage[index])
end

function UIFightHUD:onUpdate()
self:flushPosition()
end

function UIFightHUD:flushPosition()
if self.ent and self.Root then
local uiWorldPos=self.ent:getHudPosition()+fBTHelper.posOffset
self:setChildPosition(self.Root:getID(),uiWorldPos)
end
end

function UIFightHUD:initEnt()
local ent=self.ent
self.EntityName:setText('')
self.EntityName:setActive(true)
local subMaxHp=ent:getAttribute(entityAttr.sub_max_hp)

self:setHP(ent:getAttribute(entityAttr.hp),ent:getAttribute(entityAttr.max_hp),subMaxHp)
self:setHuDunValue(ent:getAttribute(entityAttr.hudun),ent:getAttribute(entityAttr.hp),ent:getAttribute(entityAttr.max_hp),subMaxHp)
self:setSubHPMax(subMaxHp,ent:getAttribute(entityAttr.max_hp))
local info=ent:getbaseInfo()

self:initFabao(info.fabao,ent:isLeft())


local diziSpHud=cfgHelper.getdef(cfg_spdiziskillhudconfig,"bindDizi")or defaultT
local diziId=self.ent:getDiZiId()
if diziId and diziSpHud[diziId]then
local spHudId=diziSpHud[diziId]
self.ent:setSPHUDType(spHudId)
end


self:initExtraComponent()
end

function UIFightHUD:initFabao(fabaoInfo,isLeft)

local icon=nil
local itemID=nil
if fabaoInfo~=nil then
self.fabaoInfo=fabaoInfo
itemID=fabaoInfo[1]

if self.ent.fabaoObjID~=nil then
self.fabaoObjID=self.ent.fabaoObjID
end
if self.fabaoObjID~=nil then
self.ent:stopText(self.fabaoObjID)
self.fabaoObjID=nil
end
self.fabaoObjID=self.ent:flowText(flowObjTypo.fabao,{nunPara=fabaoInfo})
self.ent.fabaoObjID=self.fabaoObjID
end

if itemID then
local ent=self.ent
local gemPower=ent:getAttribute(entityAttr.gem_power)
local maxGemPower=ent:getAttribute(entityAttr.max_gem_power)
self:flushGemPower(gemPower,maxGemPower)

self.Energy:setActive(true)
if not isLeft then
self.fabao:setActive(false)
self.fabaoLeft:setActive(true)
self.fabaoLeft:setImageIcon(icon,true)
else
self.fabao:setActive(true)
self.fabaoLeft:setActive(false)
self.fabao:setImageIcon(icon,true)
end
else
self.Energy:setActive(false)
self.fabao:setActive(false)
self.fabaoLeft:setActive(false)
end
end

function UIFightHUD:flushGemPower(gemPower,maxGemPower)
self.energyBar:setProgress(gemPower,maxGemPower)
if gemPower>=maxGemPower then
self.fullEnergyBar:setActive(true)
self.fullEnergyBar:setProgress(gemPower,maxGemPower)
else
self.fullEnergyBar:setActive(false)
end
end

function UIFightHUD:fade(duration,targetVlaue)
if self.ent and self.ent:isBuffHide()then
return
end
if self.fadeTween then
self.fadeTween:Kill(false)
self.fadeTween=nil
end

self.fadeTween=self.baseInfo:setChildCanvasGroupDOFade(targetVlaue,duration)
if targetVlaue==0 then
if self.fabaoObjID then
self.ent:stopText(self.fabaoObjID)
self.fabaoObjID=nil
self.fadeFaBao=true
end
else


if self.fadeFaBao then
if self.fabaoInfo then
self:initFabao(self.fabaoInfo,self.ent:isLeft())
end
self.fadeFaBao=nil
end
end
end

function UIFightHUD:setHP(cur,max,subHPMax)
local huDun=self.ent:getAttribute(entityAttr.hudun)
self:setHuDunValue(huDun,cur,max,subHPMax)
end


function UIFightHUD:setHuDunValue(hdValue,hp,hpmax,subHPMax)
subHPMax=subHPMax or 0

if hp+hdValue>=(subHPMax+hpmax)then
self.bar:setProgress(hp/(subHPMax+hpmax)*10000,10000)
self.huDunbar:setProgress(0,10000)
self.fullHPHuDunbar:setProgress(hdValue/(subHPMax+hpmax)*10000,10000)
else
self.bar:setProgress(hp/(subHPMax+hpmax)*10000,10000)
self.huDunbar:setProgress((hdValue+hp)/(subHPMax+hpmax)*10000,10000)
self.fullHPHuDunbar:setProgress(0,10000)
end
end

function UIFightHUD:setSubHPMax(subHPMax,hpmax)
subHPMax=subHPMax or 0

local cur=self.ent:getAttribute(entityAttr.hp)
local hdValue=self.ent:getAttribute(entityAttr.hudun)

self:setHuDunValue(hdValue,cur,hpmax,subHPMax)
self.fullSubHPMaxbar:setProgress(subHPMax/(subHPMax+hpmax)*10000,10000)
end

function UIFightHUD:showRoot(show)
if show then
self:initUpdateTimer()
else
self:stopUpdateTimer()
end
self.Root:setActive(show)
end

function UIFightHUD:flushBuff(buffData)

local isOver=false
local buffDataList={}
local length
for i,v in pairs(buffData)do
length=#buffDataList
if length==8 then
isOver=true
break
end
if v.cfg.icon~=0 then
buffDataList[length+1]=v
end
end

table.sort(buffDataList,function(a,b)
return a.clientID<b.clientID
end)

if isOver then
buffDataList[8]={cfg={icon=-1},flag=0,round=0,layer=0}
end

self.BuffRoot2:setChildLayoutGroupCreateItems(#buffDataList)
local items=self.BuffRoot2:getChildLayoutGroupGridList()
for i=1,items.Count do
items[i-1]:SetChildPropData(-1,self:fillBuffData(buffDataList[i],i,i))
end
end

function UIFightHUD:fillBuffData(buffInfo,id,index)
local prop={}
prop[PropIndex(DataPropKey.eWidgetIcon,_cmpItemWidgetIdx.cmpIcon)]=buffInfo.flag==1 and iconHelper.getResDispelBuffIcon(buffInfo.cfg.icon)or iconHelper.getBuffIcon(buffInfo.cfg.icon)
local round=(buffInfo.round==-1 or buffInfo.round==0)and""or buffInfo.round
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.buffCount)]=round
local layer=(buffInfo.layer==1 or buffInfo.layer==0)and""or buffInfo.layer
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.buffLayer)]=layer
prop[DataPropKey.eItemID]=id
prop[DataPropKey.eItemSeries]=index
prop[PropIndex(DataPropKey.eWidgetActive,_cmpItemWidgetIdx.buffProtect)]=self.ent:isBuffProtect(buffInfo.guid)or false
return prop
end

function UIFightHUD:getRecyleData()
return
{
[PropIndex(DataPropKey.eWidgetIcon,_cmpItemWidgetIdx.cmpIcon)]='',
[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.buffCount)]='',
[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.buffLayer)]='',
[PropIndex(DataPropKey.eWidgetActive,_cmpItemWidgetIdx.buffProtect)]=false,
[DataPropKey.eItemID]=-1,
[DataPropKey.eItemSeries]=-1,
}
end

function UIFightHUD:flushCounterAtkPoint(pointList)
local buffDataList={}
for i,v in pairs(pointList)do
if v>0 then
local counterConfig=cfgHelper.get1(cfg_skillljconfig_get,i)
if counterConfig and counterConfig.show==1 then
buffDataList[#buffDataList+1]={i,v}
end
end
end

table.sort(buffDataList,function(a,b)
return a[1]<b[1]
end)

self.CounterATKPointRoot:setChildLayoutGroupCreateItems(#buffDataList)
local items=self.CounterATKPointRoot:getChildLayoutGroupGridList()
for i=1,items.Count do
local v=buffDataList[i]
items[i-1]:SetChildPropData(-1,self:fillCounterATKData(v[1],v[2],i))
end
end

function UIFightHUD:fillCounterATKData(id,num,index)
local prop={}
prop[PropIndex(DataPropKey.eWidgetIcon,_cmpItemWidgetIdx.cmpIcon)]=iconHelper.getCounterAtkIcon(id,num)
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.buffCount)]=''
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.buffLayer)]=''
prop[DataPropKey.eItemID]=id
prop[DataPropKey.eItemSeries]=index
return prop
end

function UIFightHUD:initExtraComponent()
local hud=self.ent:getSPHUDType()
if hud then
local spComponent=cfgHelper.get(cfg_spdiziskillhudconfig_get,hud)
if spComponent then
local node=spComponent.node or 1

self.spRootNode=node==1 and self.spRoot or self.spRootDown

self.spComponent=self.spRootNode:createObject(spComponent.hud,self.spRootNode:getID(),0,{parent=self})
end
end
end

function UIFightHUD:createSpObject(hud)
self.spComponent=self.spRootNode:createObject(hud,self.spRootNode:getID(),0,{parent=self})
end

function UIFightHUD:recycleSpObject()
if self.spComponent and self.spRootNode then
self.spRootNode:recycleItemById(self.spComponent)
self.spComponent=nil
end
end

function UIFightHUD:callExtraFunc(func_name,...)
if self.spComponent and self.spRootNode then
self.spRootNode:callChildFunc(self.spComponent,func_name,...)
end
end


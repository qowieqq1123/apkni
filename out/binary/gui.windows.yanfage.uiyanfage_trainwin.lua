







def_class("UIYanFaGe_trainWin",UIWindowBase)









function UIYanFaGe_trainWin:bindComponents()

self.root=UIObject.get(self,0)
self.trainBtn=UIButton.get(self,1)
self.modelGroup=UIObject.get(self,2)
self.helpBtn=UIButton.get(self,3)

self.trainBtn:setButtonClick(function()self:onTrainBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIYanFaGe_trainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.trainBtn);self.trainBtn=nil;
_UIObject_release(self.modelGroup);self.modelGroup=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
end
















local flipPosList={
[2]=true,
[4]=true,
}
local animCd={1,3}
local _this
local hitTimeLookup={
[1000]=0.45,
[1001]=0.48,
[1002]=0.48,
[1003]=0.55,
}




function UIYanFaGe_trainWin:onLoaded(...)
_this=self
self:bindComponents()
self.delayAnimTimerList={}
self.hitAnimTimerList={}
end


function UIYanFaGe_trainWin:__delete()
self:clearDelayAnimTimerList()
self:clearHitAnimTimerList()
_this=nil
self:unbindComponents()
end




function UIYanFaGe_trainWin:onShow(argtable,afterOnloaded)
self.dzList=self:getShowDzList()
self:initAnimationList()
self:refreshModel()
end

function UIYanFaGe_trainWin:onShowArgRecv(argtable,afterOnloaded)
self:refreshModel()
end


function UIYanFaGe_trainWin:onHide()
self:clearDelayAnimTimerList()
self:clearHitAnimTimerList()
end

function UIYanFaGe_trainWin:initAnimationList()

self.animationList={}
for i,v in ipairs(self.dzList)do
local f=false
local animList={}
local dzGuid=v.dzGuid
local dzGuidStr=tostring(dzGuid)
local weaponID=UIDiscipleModel:getDiscipleShowWeaponID(dzGuid,true)
if weaponID>0 then
local equipCfg=itemsConfig.getConfig(weaponID)
if equipCfg then
local attactAction=cfgHelper.get2(cfg_discipleweaponconfig_get,equipCfg.type2,'attactAction')
for i,animId in ipairs(attactAction)do
local hitTime=hitTimeLookup[animId]or 0
local data={animId=animId,hitTime=hitTime}
table.insert(animList,data)
end
f=true
end
end
if not f then
table.insert(animList,{animId=1000,hitTime=hitTimeLookup[1000]or 0})
table.insert(animList,{animId=1001,hitTime=hitTimeLookup[1001]or 0})
end
self.animationList[dzGuidStr]=animList
end
end

function UIYanFaGe_trainWin:getShowDzList()

local allDzList=UIDiscipleModel:getAllDiscipleDataX()
local hasWeaponDzList={}
local notHasWeaponDzList={}
local allDzCount=0
for k,v in pairs(allDzList)do
local netData=v.netData.net
local dzGuid=netData.discipleguid
local equipItem=daobingModel:getEquipByDizi(dzGuid)or equipsModel.getEquipByDizi(dzGuid,EQUIP_TYPE.eWeapon)
if equipItem then
hasWeaponDzList[#hasWeaponDzList+1]=v
else
notHasWeaponDzList[#notHasWeaponDzList+1]=v
end
allDzCount=allDzCount+1
end
local dzList={}
self.dzCount=allDzCount>=4 and 4 or allDzCount
for i=1,self.dzCount do


local rand
local dzData
local hasWeaponDzCount=#hasWeaponDzList
if hasWeaponDzCount>0 then
rand=math.random(1,hasWeaponDzCount)
dzData=hasWeaponDzList[rand]
table.remove(hasWeaponDzList,rand)
else
rand=math.random(1,#notHasWeaponDzList)
dzData=notHasWeaponDzList[rand]
table.remove(notHasWeaponDzList,rand)
end

local netdata=dzData.netData
local net=netdata.net
local dzGuid=net.discipleguid
local isFlip=flipPosList[i]or false
dzList[#dzList+1]={
dzGuid=dzGuid,
flip=isFlip,
posIndex=i,
scale=0.5,
checkChuiWei=false,
}
end
return dzList
end

function UIYanFaGe_trainWin:refreshModel()
self:clearDelayAnimTimerList()
self:clearHitAnimTimerList()
local grids=self.modelGroup:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
widget:SetChildUIModelRemoveTarget(0)
widget:SetChildUIModelRemoveTarget(1)
local dzData=self.dzList[i]

local monsterModelId=410691
local monsterScale=0.21
local monsterIsFlip=not flipPosList[i]
local monsterModelScale=isometricMapSystem:getModelScale(monsterModelId,true)
monsterModelScale=monsterModelScale*monsterScale
widget:SetChildUIModelShowTarget(1,monsterModelId,monsterModelScale,nil,eAnimationID.stand)
widget:SetChildUIModelShowFlipX(1,monsterIsFlip)

if dzData then

local dzguid=dzData.dzGuid
local args={
tmLv=UIDiscipleModel:getTianMingLevel(dzguid),
}
local isFlip=flipPosList[i]
local scale=0.7
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzguid,true,1,args)
widget:SetChildUIModelShowTarget(0,modelParams.body,modelParams.scale*scale,modelParams.componets,modelParams.anim,false,false)
widget:SetChildUIModelShowFlipX(0,isFlip)




local randomCd=math.random(animCd[1],animCd[2])
self.delayAnimTimerList[i]=_this:delayDo(randomCd,function()
if not _this then return end
return _this:setModelAnim(i)
end)
end
end
end

function UIYanFaGe_trainWin:setModelAnim(index)
local widget=self.modelGroup:getChildCommonLayoutGroupWidgetItem(index-1)
local dzData=self.dzList[index]
local dzGuid=dzData.dzGuid
local dzGuidStr=tostring(dzGuid)
local animList=self.animationList[dzGuidStr]
if animList then
local random=math.random(#animList)
local animId=animList[random].animId
local hitTime=animList[random].hitTime
widget:SetChildModelAnimationState(0,animId,1,function()
if not _this then return end
local randomCd=math.random(animCd[1],animCd[2])
_this.delayAnimTimerList[index]=_this:delayDo(randomCd,function()
if not _this then return end
return _this:setModelAnim(index)
end)
end)
if hitTime<=0 then
widget:SetChildModelAnimationState(1,eAnimationID.hit)
else
self.hitAnimTimerList[index]=self:delayDo(hitTime,function()
if not _this then return end
return widget:SetChildModelAnimationState(1,eAnimationID.hit)
end)
end
end
end

function UIYanFaGe_trainWin:clearDelayAnimTimerList()
if self.delayAnimTimerList and next(self.delayAnimTimerList)then
for i,timer in pairs(self.delayAnimTimerList)do
self:stopTimerByID(timer)
self.delayAnimTimerList[i]=nil
end
end
end

function UIYanFaGe_trainWin:clearHitAnimTimerList()
if self.hitAnimTimerList and next(self.hitAnimTimerList)then
for i,timer in pairs(self.hitAnimTimerList)do
self:stopTimerByID(timer)
self.hitAnimTimerList[i]=nil
end
end
end




function UIYanFaGe_trainWin:onTrainBtn()
UIFullYanFaGeControl:showYanFaGeFightPrepare()
end

function UIYanFaGe_trainWin:onHelpBtn()
local d={}
d.mode=3
d.title="说明"
d.name="YanFaGe_help_%d"
d.showBlack=true
self:showWindow('UIRuleWin',d)
end

function UIYanFaGe_trainWin:test_setAnim(index,animId,hitTime)

self:clearDelayAnimTimerList()
self:clearHitAnimTimerList()

local dzData=self.dzList[index]
local dzGuid=dzData.dzGuid
local dzGuidStr=tostring(dzGuid)
local animList={}
table.insert(animList,{animId=animId,hitTime=hitTime})
table.insert(animList,{animId=animId,hitTime=hitTime})
self.animationList[dzGuidStr]=animList

self:setModelAnim(index)
end


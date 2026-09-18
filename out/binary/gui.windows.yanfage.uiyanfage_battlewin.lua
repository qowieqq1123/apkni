







def_class("UIYanFaGe_battleWin",UIWindowBase)









function UIYanFaGe_battleWin:bindComponents()

self.root=UIObject.get(self,0)
self.battleBtn=UIButton.get(self,1)
self.posGridList=UIObject.get(self,2)
self.model=UIObject.get(self,3)
self.dzModelGroup=UIObject.get(self,4)
self.helpBtn=UIButton.get(self,5)

self.battleBtn:setButtonClick(function()self:onBattleBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIYanFaGe_battleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.battleBtn);self.battleBtn=nil;
_UIObject_release(self.posGridList);self.posGridList=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.dzModelGroup);self.dzModelGroup=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
end
















local flipPosList={
[1]=true,
}

local _this
local speakCd={2,4}
local showSpeakTime=3




function UIYanFaGe_battleWin:onLoaded(...)
_this=self
self:bindComponents()
self.speakRefreshTimerList={}
self.speakShowTimerList={}
end


function UIYanFaGe_battleWin:__delete()
self:clearSpeakRefreshTimer()
self:clearSpeakShowTimer()
_this=nil
self:unbindComponents()
end




function UIYanFaGe_battleWin:onShow(argtable,afterOnloaded)

self.model:setChildUIModelShowTarget(6160,1,nil,eAnimationID.stand)

self.spectatorBtList={}
self.canSpeakPosIndexLookup={}
self.speakRandomList={}

local cfg=cfgHelper.get(cfg_yanfageconfig_get,1)
self.speakLib=cfg.spectatorSpeakStr
self.spectatorCount=cfg.spectatorCount
self.maxSpeakCount=cfg.maxSpeakCount
self.dzList=self:getShowDzList()
self:initAnimationList()
self.playAnimIndexList={}
self:refresh()
end

function UIYanFaGe_battleWin:onShowArgRecv(argtable,afterOnloaded)
self.playAnimIndexList={}
self:refresh()
end


function UIYanFaGe_battleWin:onHide()
self:clearSpeakRefreshTimer()
self:clearSpeakShowTimer()
end

function UIYanFaGe_battleWin:refresh()

self:refreshDzModel()


self:refreshSpectator()
end


function UIYanFaGe_battleWin:refreshDzModel()
local grids=self.dzModelGroup:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
widget:SetChildUIModelRemoveTarget(-1)
local dzData=self.dzList[i]

if dzData then

local dzguid=dzData.dzGuid
local args={

}
local isFlip=flipPosList[i]
local scale=0.7
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzguid,true,1,args)


local dzGuidStr=tostring(dzguid)
local animList=self.animationList[dzGuidStr]
local animId=modelParams.anim
if animList then
local animCount=#animList
local animIndex=self.playAnimIndexList[dzGuidStr]
if not animIndex then
animIndex=math.random(animCount)
self.playAnimIndexList[dzGuidStr]=animIndex
end
animId=animList[animIndex].animId
end

widget:SetChildUIModelShowTarget(-1,modelParams.body,modelParams.scale*scale,modelParams.componets,animId,false,false)
widget:SetChildUIModelShowFlipX(-1,isFlip)

self:setModelAnim(i)
end
end
end

function UIYanFaGe_battleWin:setModelAnim(index)
local widget=self.dzModelGroup:getChildCommonLayoutGroupWidgetItem(index-1)
local dzData=self.dzList[index]
local dzGuid=dzData.dzGuid
local dzGuidStr=tostring(dzGuid)
local animList=self.animationList[dzGuidStr]
if animList then
local animCount=#animList
local animIndex=self.playAnimIndexList[dzGuidStr]
if not animIndex then
animIndex=math.random(animCount)
self.playAnimIndexList[dzGuidStr]=animIndex
end
local animId=animList[animIndex].animId
widget:SetChildModelAnimationState(-1,animId,1,function()
if not _this then return end
_this.playAnimIndexList[dzGuidStr]=_this.playAnimIndexList[dzGuidStr]+1
if _this.playAnimIndexList[dzGuidStr]>animCount then
_this.playAnimIndexList[dzGuidStr]=1
end
return _this:setModelAnim(index)
end)
end
end

function UIYanFaGe_battleWin:refreshSpectator()
self:clearSpeakRefreshTimer()
self:clearSpeakShowTimer()
local posGrids=self.posGridList:getChildCommonLayoutGroupWidgetList()

for i=1,posGrids.Count do
local posWidget=posGrids[i-1]
if i<=self.spectatorCount then
posWidget:SetChildActive(-1,true)
posWidget:SetChildActive(1,false)


local randomCd=math.random(speakCd[1],speakCd[2])
self.speakRefreshTimerList[i]=self:delayDo(randomCd,function()
if not _this then return end
return _this:applySpectatorSpeakContent(i)
end)
else
posWidget:SetChildActive(-1,false)
end
end
end

function UIYanFaGe_battleWin:clearSpeakRefreshTimer()
if self.speakRefreshTimerList and next(self.speakRefreshTimerList)then
for i,timer in pairs(self.speakRefreshTimerList)do
self:stopTimerByID(timer)
self.speakRefreshTimerList[i]=nil
end
end
end

function UIYanFaGe_battleWin:clearSpeakShowTimer()
if self.speakShowTimerList and next(self.speakShowTimerList)then
for i,timer in pairs(self.speakShowTimerList)do
self:stopTimerByID(timer)
self.speakShowTimerList[i]=nil
end
end
end

function UIYanFaGe_battleWin:applySpectatorSpeakContent(index)
if not self.canSpeakPosIndexLookup or not next(self.canSpeakPosIndexLookup)then

local indexList={}
for i=1,self.spectatorCount do
indexList[#indexList+1]=i
end

for i=1,self.maxSpeakCount do
local rand=math.random(1,#indexList)
local randIndex=indexList[rand]
table.remove(indexList,rand)
self.canSpeakPosIndexLookup[randIndex]=true
end

end

local widget=self.posGridList:getChildCommonLayoutGroupWidgetItem(index-1)
local refreshFunc=function(isShowCallBack)
if not _this then return end
widget:SetChildActive(1,false)
if isShowCallBack then
_this.canSpeakPosIndexLookup[index]=nil
end
local randomCd=math.random(speakCd[1],speakCd[2])
_this.speakRefreshTimerList[index]=_this:delayDo(randomCd,function()
if not _this then return end
return _this:applySpectatorSpeakContent(index)
end)
end

if self.canSpeakPosIndexLookup[index]then
local speakStr=self:getSpectatorSpeakContent()
widget:SetChildText(0,speakStr)
widget:SetChildActive(1,true)
self.speakShowTimerList[index]=self:delayDo(showSpeakTime,function()
return refreshFunc(true)
end)
else
return refreshFunc()
end
end

function UIYanFaGe_battleWin:releaseSpectatorSpeakContent(index)
self.canSpeakPosIndexLookup[index]=nil
end

function UIYanFaGe_battleWin:getSpectatorSpeakContent()
if not self.speakRandomList or not next(self.speakRandomList)then

for i,str in ipairs(self.speakLib)do
self.speakRandomList[#self.speakRandomList+1]=i
end
end

local rand=math.random(1,#self.speakRandomList)
local randIndex=self.speakRandomList[rand]
table.remove(self.speakRandomList,rand)
local contentStr=self.speakLib[randIndex]
return contentStr
end

function UIYanFaGe_battleWin:getShowDzList()

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
self.dzCount=allDzCount>=2 and 2 or allDzCount
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
dzList[#dzList+1]={
dzGuid=dzGuid,
posIndex=i,
}
end
return dzList
end

function UIYanFaGe_battleWin:initAnimationList()

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
local data={animId=animId}
table.insert(animList,data)
end
f=true
end
end
if not f then
table.insert(animList,{animId=1000})
table.insert(animList,{animId=1001})
end
self.animationList[dzGuidStr]=animList
end
end




function UIYanFaGe_battleWin:onBattleBtn()
local prepareType=2
UIFullYanFaGeControl:showYanFaGeFightPrepare(prepareType)
end

function UIYanFaGe_battleWin:onHelpBtn()
local d={}
d.mode=3
d.title="说明"
d.name="YanFaGe_help_%d"
d.showBlack=true
self:showWindow('UIRuleWin',d)
end
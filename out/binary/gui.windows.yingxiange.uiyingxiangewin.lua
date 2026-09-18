







def_class("UIYingXianGeWin",UIWindowBase)









function UIYingXianGeWin:bindComponents()

self.animLdl=UIObject.get(self,0)
self.animRoot=UIObject.get(self,1)
self.bdLevel=UIText.get(self,2)
self.desc=UIText.get(self,3)
self.dzModels=UIObject.get(self,4)
self.infoDesc=UIText.get(self,5)
self.levelUpBtn=UIButton.get(self,6)
self.levelUpBtnText=UIText.get(self,7)
self.root=UIObject.get(self,8)
self.yuanjunBtn=UIButton.get(self,9)
self.cooperationNumText=UIText.get(self,10)
self.reduceTimeText=UIText.get(self,11)
self.assistNumText=UIText.get(self,12)
self.ylzAccelerateNumText=UIText.get(self,13)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.yuanjunBtn:setButtonClick(function()self:onYuanjunBtn()end)



end


function UIYingXianGeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animLdl);self.animLdl=nil;
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.bdLevel);self.bdLevel=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.dzModels);self.dzModels=nil;
_UIObject_release(self.infoDesc);self.infoDesc=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.yuanjunBtn);self.yuanjunBtn=nil;
_UIObject_release(self.cooperationNumText);self.cooperationNumText=nil;
_UIObject_release(self.reduceTimeText);self.reduceTimeText=nil;
_UIObject_release(self.assistNumText);self.assistNumText=nil;
_UIObject_release(self.ylzAccelerateNumText);self.ylzAccelerateNumText=nil;
end

















local _this
local _format=string.format


function UIYingXianGeWin:onLoaded(...)
self:bindComponents()
_this=self
local const_def=cfg_yingxiangeconfig().const_def
self.currDZList={}
self.aiNpcIdList=const_def.npc_ids
self.npcIndex=math.random(1,#self.aiNpcIdList)

self:addNotify(notifyConfig.building_event,self.on_building_event)
end

function UIYingXianGeWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if not _this or not _this.isVisible then
return
end
if _this.bdData.un_build_id~=bdId then
return
end
if etype==buildingEvent.levelUpComplete
or etype==buildingEvent.levelUpStart then
_this.bdData=zongmenModel:findBuildingByEntityId(_this.entityId)
_this:refresh()
end
end


function UIYingXianGeWin:__delete()
self:unbindComponents()
self:clearAI()
self:stopAllTimer()
_this=nil
end




function UIYingXianGeWin:onShow(argtable,afterOnloaded)
local guid=argtable.entityId
self.entityId=guid
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)

self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
UIManager:callWindowFunc('UIXianJieBottomMaskWin','showModel',6002,{0,-30})

self:initInAI()
self:initOutAI()
self:refresh()
end


function UIYingXianGeWin:onHide()

end

function UIYingXianGeWin:refresh()
self:refreshLevelUpPanel()
self:refreshRightPanel()

if self.bdData.flag==buildingStateType.eUpgrading then
self.animLdl:setActive(true)
self.animLdl:setChildUIModelShowTarget(2002,1,nil,eAnimationID.stand)
self.animLdl:setChildUIModelShowTargetOffset(-20,30)
self.animLdl:setChildModelAnimationState(eAnimationID.stand)
else
self.animLdl:setActive(false)
end
end

function UIYingXianGeWin:refreshLevelUpPanel()
self.bdLevel:setText(_format('%s级%s',self.bdData.level,self.config.name))
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id,true)
if cddata and cddata.complete then
self.levelUpBtnText:setText('完成升级')
return
end
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
self.levelUpBtnText:setText(nextLvCfg~=nil and'建筑升级'or'建筑信息')
end

function UIYingXianGeWin:refreshRightPanel()
self.desc:setText(self.config.desc or"")



local reduceTime,cooperationNum,assistNum,ylzAccelerateNum=YingXianGeModel:getIncreaseAddition()
self.cooperationNumText:setText(FMT.fmt("{0}次",cooperationNum))
self.reduceTimeText:setText(FMT.fmt("{0}秒",reduceTime))
self.assistNumText:setText(FMT.fmt("{0}队",assistNum))
self.ylzAccelerateNumText:setText(ylzAccelerateNum)
end


function UIYingXianGeWin:initInAI()
local const_def=cfg_yingxiangeconfig().const_def
local minTime=const_def.npcDelayTime[1]
local maxTime=const_def.npcDelayTime[2]
local delayTime=math.random(minTime,maxTime)

self:setTimer(delayTime,1,function()
if not _this then return end
_this:createVisitorIn()
_this:initInAI()
end)
end
function UIYingXianGeWin:initOutAI()
local const_def=cfg_yingxiangeconfig().const_def
local minTime=const_def.npcDelayTime[1]
local maxTime=const_def.npcDelayTime[2]
local delayTime=math.random(minTime,maxTime)

self:setTimer(delayTime,1,function()
if not _this then return end
_this:createVisitorOut()
_this:initOutAI()
end)
end

function UIYingXianGeWin:getADisciple()
local count=0
local len=#self.aiNpcIdList
while(count<5)do
local npcId=self.aiNpcIdList[self.npcIndex]
self.npcIndex=self.npcIndex+1
if self.npcIndex>len then
self.npcIndex=1
end
if not self.currDZList[npcId]then
return npcId
end
count=count+1
end
return nil
end

function UIYingXianGeWin:createVisitorIn()
local npcId=self:getADisciple()
self.currDZList[npcId]=true

local tran=self.dzModels:getCommonComponent('Transform')
local pos=Vector3.New(500,0,0)
local initData={
stateId=0,
standPos=0,
initPos={500,0},
toPos={270,0},
jumpPos={220,100},
endPos={10,200},
}

local otherData={
scale=1,
}
uiAIManager:createNPC('UIYingXianGeWin','bt_ui_yxg_dz',npcId,
tran,pos,initData,otherData,function(bt)
end)

end

function UIYingXianGeWin:createVisitorOut()
local npcId=self:getADisciple()
self.currDZList[npcId]=true

local tran=self.dzModels:getCommonComponent('Transform')
local pos=Vector3.New(-10,200,0)
local initData={
stateId=1,
standPos=0,
initPos={-10,200},
toPos={-220,50},
jumpPos={-270,50},
endPos={-500,0},
}

local otherData={
scale=0.75,
}
uiAIManager:createNPC('UIYingXianGeWin','bt_ui_yxg_dz',npcId,
tran,pos,initData,otherData,function(bt)
end)
end

function UIYingXianGeWin:dzLeaveIn(bt)
local npcId=bt:getSharedVar('npcId')
uiAIManager:removeUIInstance(bt)
self.currDZList[npcId]=nil
end

function UIYingXianGeWin:dzLeaveOut(bt)
local npcId=bt:getSharedVar('npcId')
uiAIManager:removeUIInstance(bt)
self.currDZList[npcId]=nil
end

function UIYingXianGeWin:clearAI()
uiAIManager:clearUIWinData('UIYingXianGeWin')
end





function UIYingXianGeWin:onLevelUpBtn()
if buildingCDControl:isComplete(buildingCDType.build,self.bdData.un_build_id)then
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
else
UIManager:showWindow('UIXJBuildingInfoWin',self.bdData)
end
end



function UIYingXianGeWin:onYuanjunBtn()
local actorId=playerModel:getActorID()
YingXianGeController.reqZhiYuan(actorId)
UIManager:showWindow('UIYingXianGeWDYJWin')
end


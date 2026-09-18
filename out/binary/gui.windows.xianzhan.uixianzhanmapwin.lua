







def_class("UIXianZhanMapWin",UIWindowBase)









function UIXianZhanMapWin:bindComponents()

self.rebuildBtn=UIButton.get(self,0)
self.titleBtn=UIButton.get(self,1)
self.tfReward=UIButton.get(self,2)
self.tfRewardTips=UIObject.get(self,3)
self.tfRewardTipsText=UIText.get(self,4)
self.root=UIObject.get(self,5)
self.bdSkinBtn=UIButton.get(self,6)
self.bdSkinReddot=UIObject.get(self,7)
self.jiShiBuffGridGourp=UIObject.get(self,8)
self.keShangPanel=UIObject.get(self,9)
self.keShangList=UIObject.get(self,10)
self.startJiShiBtn=UIButton.get(self,11)
self.startJiShiReddot=UIObject.get(self,12)
self.xyValueText=UIText.get(self,13)

self.rebuildBtn:setButtonClick(function()self:onRebuildBtn()end)

self.titleBtn:setButtonClick(function()self:onTitleBtn()end)

self.tfReward:setButtonClick(function()self:onTfReward()end)

self.bdSkinBtn:setButtonClick(function()self:onBdSkinBtn()end)

self.startJiShiBtn:setButtonClick(function()self:onStartJiShiBtn()end)



end


function UIXianZhanMapWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rebuildBtn);self.rebuildBtn=nil;
_UIObject_release(self.titleBtn);self.titleBtn=nil;
_UIObject_release(self.tfReward);self.tfReward=nil;
_UIObject_release(self.tfRewardTips);self.tfRewardTips=nil;
_UIObject_release(self.tfRewardTipsText);self.tfRewardTipsText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bdSkinBtn);self.bdSkinBtn=nil;
_UIObject_release(self.bdSkinReddot);self.bdSkinReddot=nil;
_UIObject_release(self.jiShiBuffGridGourp);self.jiShiBuffGridGourp=nil;
_UIObject_release(self.keShangPanel);self.keShangPanel=nil;
_UIObject_release(self.keShangList);self.keShangList=nil;
_UIObject_release(self.startJiShiBtn);self.startJiShiBtn=nil;
_UIObject_release(self.startJiShiReddot);self.startJiShiReddot=nil;
_UIObject_release(self.xyValueText);self.xyValueText=nil;
end
















local _this=nil

local keshangItemCmpIndex={
bg=0,
showPanel=1,
notPanel=2,
head=3,
timeText=4,
name=5,
tipsTimeText=6,
clickArea=7,
reddot=8,
leaveTipsText=9,
}
local jishiBuffItemCmpIndex={
buffIcon=0,
buffText=1,
buffName=2,
buffTimeText=3,
}


function UIXianZhanMapWin:onLoaded(...)
self:bindComponents()
_this=self
self.roomModelHudList={}
self.roomNPCTalkHudList={}
self.roomTimerList={}
self.keShangHudList={}
self.keShangTimerList={}

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)

notifySystem:listenNotify(notifyConfig.onXianZhanBuildModelChange,self.onXianZhanBuildModelChange)
notifySystem:listenNotify(notifyConfig.onXianZhanBuildRoomChange,self.onXianZhanBuildRoomChange)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)


xianzhanModel:autoUnlockZX()
end


function UIXianZhanMapWin:__delete()
_this=nil
self:clearRefreshKeShangTimer()
self:clearBuffTimer()
roleAudioController:stopRoleSpeak()
self:unbindComponents()
self:removeAllRoomModelHud()
self:removeRoomNpc()
self:removeZhangGui()
self:removeShopNpc()
self:removeZhiKeHud()
self:removeAllKeShangHud()

xianzhanModel:clearRebuilding()

notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)

notifySystem:removelistener(notifyConfig.onXianZhanBuildModelChange,self.onXianZhanBuildModelChange)
notifySystem:removelistener(notifyConfig.onXianZhanBuildRoomChange,self.onXianZhanBuildRoomChange)
end

function UIXianZhanMapWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if _this==nil then return end
if etype==buildingEvent.replaceDisciple and bdId==_this.un_build_id then
_this:refreshZhangGui(arg1)
end
end

function UIXianZhanMapWin:onTouchUp(fingerIndex,touchCount,screenPoint,guid)
if fingerIndex==0 and touchCount==1 then
local objType=_MapManager.GetObjectType(guid)
if objType==objectType.eRole then
if mathHelper.compareInt64(guid,self.zhanggui)then
self:onSelectZhangGui(2)
elseif mathHelper.compareInt64(guid,self.shopNPC)then
self:onShopBtn()
else
local zkentity=xianzhanController:findXianZhanEnity(xianzhanmanType.eZhiKe)
local ksEntity=xianzhanController:findXianZhanEnity(xianzhanmanType.eKeShang,guid)
if ksEntity~=nil then
if not ksEntity.isMoving then
local npcId=ksEntity.npcId
self:onClickKeShang(npcId)
end
elseif zkentity~=nil then
if zkentity.guid==guid then
self:onClickYingBin()
end
end
end
elseif objType==objectType.eFangKe then
local fkentity=xianzhanController:findXianZhanEnity(xianzhanmanType.eFangKe,guid)
if fkentity~=nil then
local roomId=fkentity.roomId
local data=xianzhanModel:getRoomDataByRoomId(roomId)
if data.ybFlag~=0 then
self:onRoomClick(roomId)
end
end
else
local areaId=_MapManager.GetAreaIDByScreenPoint(mapIdType.xianzhan,screenPoint)
if areaId>0 then
local roomId=xianzhanModel:getRoomIDByArea(areaId)
if roomId~=nil then
self:onRoomClick(roomId)
end
end
end
end
end

function UIXianZhanMapWin.onXianZhanBuildModelChange(flag)
if _this==nil then return end
_this:refreshAllRoomHudSelect()
_this:activeWin(not flag)
if not flag then
if _this.mark_orthographic_size~=nil then
local cur=_MapManager.GetCameraOrthographicSize()
if cur~=_this.mark_orthographic_size then
isometricMapSystem:setCameraOrthoSize(_this.mark_orthographic_size,0.3,nil,nil)
end
_this.mark_orthographic_size=nil
end
end
end

function UIXianZhanMapWin.onXianZhanBuildRoomChange(oldRoomType,roomType)
if _this==nil then return end
_this:refreshAllRoomHudSelect(true)
end

function UIXianZhanMapWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end

if moneyType==eMoneyType.mtXianZhanXinYuZhi then

_this:refreshStartJiShiBtn()
end
end

function UIXianZhanMapWin.onItemListChanged(list)
if list==nil then return end
if not systemModel.isOpen(SYSTEM_DEFINE.eXianZhanKeShang)then return end
if _this==nil then return end
_this:checkKeShangReddot()
end


function UIXianZhanMapWin:onHide()
self:clearRefreshKeShangTimer()
self:clearBuffTimer()
end

function UIXianZhanMapWin:activeWin(active)
local a=active==true and 1 or 0
self.root:setChildCanvasGroupAlpha(a)
end




function UIXianZhanMapWin:onShow(argtable,afterOnloaded)
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXianZhan)
self.bdData=bdDatas[1]
self.un_build_id=self.bdData.un_build_id
self:refreshZhangGui(self.bdData.dizi_id,true,afterOnloaded)
self:refreshTuiFangReward(afterOnloaded)
self:refreshShopNPC(true,afterOnloaded)
self:refreshRoom(true,afterOnloaded)
self:refreshZhiKeHud(true,afterOnloaded)
self:refreshBdSkinBtn()
self:refreshKeShangPanel()
self:initKeShangHud()


if afterOnloaded then
local width=self.rebuildBtn:getChildSizeDeltaX()
local height=self.rebuildBtn:getChildSizeDeltaY()
self.rebuildBtn:setChildSizeDelta(30,height)
local func=function()
if _this==nil then return end
_this.rebuildBtn:setChildDOSizeDelta(Vector2(width,height),0.3,nil)
end
self:delayDo(0.5,func)
end
self:activeWin(true)
end

function UIXianZhanMapWin:reconnetRefresh()
self:onShow()
end



function UIXianZhanMapWin:refreshZhangGui(disguid,inonshow,init)
if inonshow==true and not init then
return
end
self.zhangguiGuid=disguid
local haveZG=tostring(self.zhangguiGuid)~='0'

self:removeZhangGui()
local managerInfo=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'managerInfo')
local bornPos=managerInfo[1]
local pos=_MapManager.ToVector3Int(bornPos[1],bornPos[2],0)
if haveZG then
local info=UIDiscipleModel:getDiscipleImageInfo(disguid)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
local scale=isometricMapSystem:getModelScale(modelParams.body)
scale=scale*3
local offset=nil
if managerInfo[2]then
offset=Vector3(managerInfo[2][1],managerInfo[2][2],0)
end
local guid=isometricMapSystem:createRoleEntity(objectType.eRole,mapIdType.xianzhan,0,
modelParams.body,modelParams.componets,
SortingLayers.ITBuilding,scale,pos,offset)
self.zhanggui=guid
end

local hudoffset=Vector3.zero
local haveZG=tostring(self.zhangguiGuid)~='0'
if haveZG then
hudoffset.y=hudoffset.y+2.5
end
local hudID=hudControl:addHUDWithPosition(INSTANCE_TYPE.eXianZhanZhangGuiHud,mapIdType.xianzhan,pos,
hudoffset,false,true,
function(id)
if _this==nil then return end
local haveZG_=tostring(_this.zhangguiGuid)~='0'
local widget=hudControl:getHUDWidget(id)

local iconname
local abname=globalABLookup.xianzhanIcon

if haveZG_ then
iconname='icon_zhangguijiaohuan_2'

else
iconname='icon_zhangguijiaohuan_1'

end
widget:SetChildCSImageSprite(1,abname,iconname)


widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onSelectZhangGui()
end)
if not haveZG_ then
widget:SetChildRotation(0,0,0,0)
local tweener=widget:SetChildDOPunchRotation(0,Vector3(0,0,15),2,6,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
_this.zhangguiHudData[2]=tweener
end
end)
self.zhangguiHudData={hudID}
end

function UIXianZhanMapWin:removeZhangGui()
if self.zhanggui then
_MapManager.RemoveTilemapObject(self.zhanggui)
self.zhanggui=nil
end
if self.zhangguiHudData~=nil then
local tweener=self.zhangguiHudData[2]
if tweener~=nil then
tweener:Rewind()
tweener:Kill()
end
hudControl:removeHUD(self.zhangguiHudData[1])
self.zhangguiHudData=nil
end
end

function UIXianZhanMapWin:onSelectZhangGui()
if xianzhanModel:isBuildingModel()then return end
UIManager:showWindow('UIXianZhanManagerWin',{mapIdType.zhufeng,self.bdData,self.zhangguiGuid})
end





function UIXianZhanMapWin:refreshTuiFangReward(anim)
local flag=xianzhanModel:checkTuiFangReward()
self.tfReward:setActive(flag)
if flag then
local str='客人已结清房费，退房离去\n新的租金已入账'
self.tfRewardTipsText:setText(str)
end
if anim then
self.tfRewardTips:setLocalPosX(-350)
local func=function()
if _this==nil then return end
_this.tfRewardTips:setChildDOLocalMoveX(0,0.2,nil)
_this:stopTimerByName('tfRewardTimer')
_this.tfRewardTimer=self:setTimer(5,1,function()
if _this==nil then return end
_this.tfRewardTips:setChildDOLocalMoveX(-350,0.2,nil)
end)
end
self:delayDo(0.5,func)
end
end

function UIXianZhanMapWin:onTfReward()
if xianzhanModel:isBuildingModel()then return end
xianzhanController:req_xianzhan_reward()
end





function UIXianZhanMapWin:refreshShopNPC(inonshow,init)
if inonshow==true and not init then
return
end
self:removeShopNpc()

local shopNPCInfo=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'shopNPCInfo')
local modelParams=npcModel:getImageInfoOutSide(shopNPCInfo[1])
local bornPos=shopNPCInfo[3]
local scale=modelParams.scale*shopNPCInfo[2]
local pos=_MapManager.ToVector3Int(bornPos[1],bornPos[2],0)
local offset=nil
if shopNPCInfo[4]then
offset=Vector3(shopNPCInfo[4][1],shopNPCInfo[4][2],0)
end
local npcguid=isometricMapSystem:createRoleEntity(objectType.eRole,mapIdType.xianzhan,0,
modelParams.body,modelParams.componets,SortingLayers.ITBuilding,
scale,pos,offset)
self.shopNPC=npcguid

local hudoffset=_MapManager.GetObjectBottomOffset(npcguid)
hudoffset.y=hudoffset.y+2.5
local hudID=hudControl:addHUD(INSTANCE_TYPE.eXianZhanShopNpcHud,npcguid,hudoffset,false,true,function(id)
if _this==nil then return end
local widget=hudControl:getHUDWidget(id)
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onShopBtn()
end)
end)
self.shopNPCHud=hudID
end

function UIXianZhanMapWin:removeShopNpc()
if self.shopNPC then
_MapManager.RemoveTilemapObject(self.shopNPC)
self.shopNPC=nil
end
if self.shopNPCHud~=nil then
hudControl:removeHUD(self.shopNPCHud)
self.shopNPCHud=nil
end
end

function UIXianZhanMapWin:onShopBtn()
xianzhanController:onCommonShopClick()
end




function UIXianZhanMapWin:refreshRoom(inonshow,init)
if inonshow==true and not init then
return
end
self.roomsData=xianzhanModel:getRoomsData()
for k,v in pairs(self.roomsData)do
local roomId=v.roomId
self:refreshRoomModelHud(roomId)
self:refreshRoomNPC(roomId)
end
end

function UIXianZhanMapWin:refreshAllRoomHudSelect(check)
self.roomsData=xianzhanModel:getRoomsData()
for k,v in pairs(self.roomsData)do
local roomId=v.roomId
local checkpass=true
if check then
checkpass=not xianzhanModel:getRoomRebuilding(roomId)
end
if checkpass then
self:refreshRoomHudSelect(nil,roomId)
end
end
end

function UIXianZhanMapWin:refreshRoomModelHud(roomId)
self:removeRoomModelHud(roomId)

local hudPos=cfgHelper.get2(cfg_xianzhanroomconfig_get,roomId,'hudPos')
local p=_MapManager.ToVector3Int(hudPos[1],hudPos[2],0)
local hudguid=hudControl:addHUDWithPosition(INSTANCE_TYPE.eXianZhanRoomModelHud,mapIdType.xianzhan,p,Vector3(0,3,0),false,true,function(id)
if _this==nil then return end
local widget=hudControl:getHUDWidget(id)
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onRoomClick(roomId)
end)
self:refreshRoomHud(widget,roomId)
end)
self.roomModelHudList[roomId]=hudguid
end

function UIXianZhanMapWin:removeAllRoomModelHud()
for roomId,guid in pairs(self.roomModelHudList)do
hudControl:removeHUD(guid)
end
self.roomModelHudList={}
self:stopAllRoomTimer()
end

function UIXianZhanMapWin:removeRoomModelHud(roomId)
local guid2=self.roomModelHudList[roomId]
if guid2~=nil then
hudControl:removeHUD(guid2)
self.roomModelHudList[roomId]=nil
end
self:stopRoomTimer(roomId)
end

function UIXianZhanMapWin:refreshRoomHud(widget,roomId)
if widget==nil then
local hudguid=self.roomModelHudList[roomId]
if hudguid and not hudControl:isNeedLoad(hudguid)then
widget=hudControl:getHUDWidget(hudguid)
end
end
if widget~=nil then
local data=xianzhanModel:getRoomDataByRoomId(roomId)



widget:SetChildActive(0,false)

self:refreshRoomHudSelect(widget,roomId)
end
end

function UIXianZhanMapWin:refreshRoomHudSelect(widget,roomId)
if widget==nil then
local hudguid=self.roomModelHudList[roomId]
if hudguid and not hudControl:isNeedLoad(hudguid)then
widget=hudControl:getHUDWidget(hudguid)
end
end
if widget~=nil then
local data=xianzhanModel:getRoomDataByRoomId(roomId)
local lock=data.unlockStatus==0

local isReBuilding=xianzhanModel:isBuildingModel()
local roomType=data.zhuangxiuTypeId
local rebuildRoomType=xianzhanModel:getRebbuildRoomType()
local showKuang=not lock and isReBuilding==true
local showArrow=showKuang and rebuildRoomType~=nil and rebuildRoomType~=roomType and data.customerId<=0
showArrow=showArrow and not xianzhanController:isInBuilding(roomId)
widget:SetChildActive(1,showArrow)

local showBuildTips=isReBuilding==true and not xianzhanController:isInBuilding(roomId)
local tipstr=nil
if showBuildTips then
if lock then
tipstr='房间尚未解锁'
elseif data.customerId>0 and data.ybFlag==0 then
tipstr='该房已被预订'
elseif data.customerId>0 and data.ybFlag~=0 then
tipstr='访客入住中'
elseif rebuildRoomType==roomType then
tipstr='同类型房间'
end
end
showBuildTips=showBuildTips and tipstr~=nil
widget:SetChildActive(6,showBuildTips)
if showBuildTips then
widget:SetChildText(7,tipstr)
end

self:refreshRoomHudTime(widget,roomId)
end
end

function UIXianZhanMapWin:refreshRoomHudTime(widget,roomId)
if widget==nil then
local hudguid=self.roomModelHudList[roomId]
if hudguid and not hudControl:isNeedLoad(hudguid)then
widget=hudControl:getHUDWidget(hudguid)
end
end
if widget~=nil then
self:stopRoomTimer(roomId)
local data=xianzhanModel:getRoomDataByRoomId(roomId)
local lock=data.unlockStatus==0
local showTime=false
local pos
local iconName
if not lock then
local customerId=data.customerId
if customerId>0 then












else
if data.ruzhuTime>0 then
pos=Vector2(0,0)
iconName='image_xzsjtskuang_2'
showTime=true
end
end
end
local isReBuilding=xianzhanModel:isBuildingModel()
showTime=showTime and not isReBuilding
widget:SetChildActive(8,showTime)
if showTime then

local func=function()
if _this==nil then return end
_this:refreshRoomHudTimer(widget,roomId)
end
_this.roomTimerList[roomId]=_this:setTimer(1,-1,func)
_this:refreshRoomHudTimer(widget,roomId)

widget:SetChildAnchoredPosition(8,pos)

widget:SetChildCSImageSprite(8,globalABLookup.xianzhanIcon,iconName)
end
end
end

function UIXianZhanMapWin:refreshRoomHudTimer(widget,roomId)
local data=xianzhanModel:getRoomDataByRoomId(roomId)
local curTime=timeHelper.getServerShortTime()
local time_str
if data.customerId>0 then
local lerp=data.leaveTime-curTime
if lerp<0 then
lerp=0
end
if lerp>0 then
time_str=FMT.fmt('{0}后离开',timeHelper.formatSimpleTime(lerp))
else
time_str='访客已离开'
end
else
local lerp=data.ruzhuTime-curTime
if lerp<0 then
lerp=0
end
if lerp>0 then
time_str=FMT.fmt('{0}后到店',timeHelper.formatSimpleTime(lerp))
else
time_str='访客已到店'
end
end
widget:SetChildText(9,time_str)
end

function UIXianZhanMapWin:stopRoomTimer(roomId)
if self.roomTimerList[roomId]then
self:stopTimerByID(self.roomTimerList[roomId])
self.roomTimerList[roomId]=nil
end
end

function UIXianZhanMapWin:stopAllRoomTimer()
for k,v in pairs(self.roomTimerList)do
self:stopRoomTimer(k)
end
end

function UIXianZhanMapWin:refreshRoomBuildHud(widget,roomId,flag)
if widget==nil then
local hudguid=self.roomModelHudList[roomId]
if hudguid and not hudControl:isNeedLoad(hudguid)then
widget=hudControl:getHUDWidget(hudguid)
end
end
if widget~=nil then
widget:SetChildActive(3,flag==true)
if flag then
widget:SetChildAnimationStringID(5,'chuizi')
widget:SetChildAnimationStatus(5,1)
widget:SetChildIconFillAmount(4,0)
widget:SetChildImageDOFillAmount(4,1,xianzhanController.rebuildTime,nil)
end
end
end

function UIXianZhanMapWin:onRoomClick(roomId)

AudioManager.playBtnClick()
xianzhanController:onRoomClick(roomId)
end





function UIXianZhanMapWin:refreshRoomNPC(roomId)
local data=xianzhanModel:getRoomDataByRoomId(roomId)

self:removeRoomNpcEx(roomId)

local entity
local guid
local customerId=data.customerId
local hasman=customerId>0
if hasman then
entity=xianzhanController:getFangKeEntity(roomId)
guid=entity.guid
end

local ybFlag=data.ybFlag
local showTalk=hasman and entity.doingyb==nil
if showTalk then

local offset=_MapManager.GetObjectHeadOffset(guid)
local talkHud=hudControl:addHUD(INSTANCE_TYPE.eXianZhanRoomNpcTalkHud,guid,offset,true,true,function(id)
if _this==nil then return end
local widget=hudControl:getHUDWidget(id)
local showyb=ybFlag==0
local npcid=customerId
local showReward=false
if not showyb then
showReward=npcModel:checkIntimacyReward(npcid)~=nil
end
widget:SetChildActive(0,not showyb and not showReward)
widget:SetChildActive(1,showyb)
widget:SetChildActive(2,showReward)
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onRoomClick(roomId)
end)
widget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onRoomClick(roomId)
end)
end)
self.roomNPCTalkHudList[roomId]=talkHud
end
end

function UIXianZhanMapWin:removeRoomNpc()
for roomId,hudId in pairs(self.roomNPCTalkHudList)do
hudControl:removeHUD(hudId)
end
self.roomNPCTalkHudList={}
end

function UIXianZhanMapWin:removeRoomNpcEx(roomId)
local guid2=self.roomNPCTalkHudList[roomId]
if guid2~=nil then
hudControl:removeHUD(guid2)
self.roomNPCTalkHudList[roomId]=nil
end
end





function UIXianZhanMapWin:refreshZhiKeHud(inonshow,init)
if inonshow==true and not init then
return
end

self:removeZhiKeHud()

local showHud=xianzhanModel:hasYingBinRoom()
if showHud then
local entity=xianzhanController:findXianZhanEnity(xianzhanmanType.eZhiKe)
local guid=entity.guid

local offset=_MapManager.GetObjectHeadOffset(guid)
local hudID=hudControl:addHUD(INSTANCE_TYPE.eXianZhanZhiKeHud,guid,offset,true,true,function(id)
if _this==nil then return end
local widget=hudControl:getHUDWidget(id)
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onClickYingBin()
end)
widget:SetChildRotation(0,0,0,0)
local tweener=widget:SetChildDOPunchRotation(0,Vector3(0,0,15),2,6,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
_this.zhikeHudData[2]=tweener
end)
self.zhikeHudData={hudID}
end
end

function UIXianZhanMapWin:removeZhiKeHud()
if self.zhikeHudData~=nil then
local tweener=self.zhikeHudData[2]
if tweener~=nil then
tweener:Rewind()
tweener:Kill()
end
hudControl:removeHUD(self.zhikeHudData[1])
self.zhikeHudData=nil
end
end

function UIXianZhanMapWin:onClickYingBin()
local ybRoomIDs=xianzhanModel:getYingBinRoomIDs()
if#ybRoomIDs>0 then
xianzhanController:req_yingbin(ybRoomIDs)

end
end




function UIXianZhanMapWin:refreshKeShangPanel()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianZhanKeShang)then
self.keShangPanel:setActive(false)
self.startJiShiBtn:setActive(false)
return
end
self.keShangPanel:setActive(true)
self.startJiShiBtn:setActive(true)


local ksList=xianzhanModel:getKeShangList()or{}
self.sortKsList=self:sortKeShangListByRzTime(ksList)
local ksCount=#self.sortKsList
local nextTime=xianzhanModel:getKeShangNextTime()
local createCount=ksCount
local isShowNext=nextTime and nextTime>0 or false
if isShowNext then
createCount=createCount+1
end

self.keShangList:setChildLayoutGroupCreateItems(createCount)
local grids=self.keShangList:getChildLayoutGroupGridList()
local abName="ui/windows/shop/shangpujishi_atlas_pak.ab"
local nowTime=timeHelper.getServerShortTime()
for i=1,grids.Count do
local widget=grids[i-1]
local ksData=self.sortKsList[i]

widget:SetChildWeakGuideComponentId(-1,FMT.fmt('UIXianZhanMapWin.keShangItem_{0}',i))
if ksData then
widget:SetChildActive(-1,true)
widget:SetChildActive(keshangItemCmpIndex.showPanel,true)
widget:SetChildActive(keshangItemCmpIndex.notPanel,false)
local bgIconNameStr="frame_shagnpuj_0{0}"
local npcId=ksData.npcid
local npcCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,npcId)
if npcCfg then
local npcColor=npcCfg.color or 1
bgIconNameStr=FMT.fmt(bgIconNameStr,npcColor)

widget:SetChildCSImageSprite(keshangItemCmpIndex.bg,abName,bgIconNameStr)


local npcImageId=npcCfg.npcShowId
local imageInfo=npcModel:getImageInfo(npcImageId)
local headCenter=cfgHelper.get2(cfg_dbbodyconfig_get,imageInfo.body,'headCenter')or{}
local head=headCenter[eHeadCenterType.eHead]
imageInfo.headCenter={head[1],head[2]-20,head[3]}
comHelper.setChildModelRawImageEx(keshangItemCmpIndex.head,widget,imageInfo,0)


local name=npcModel:getName(npcImageId)or"未知名称"
widget:SetChildText(keshangItemCmpIndex.name,name)


widget:SetChildButtonClick(keshangItemCmpIndex.clickArea,function()
if not _this then return end
return _this:onClickKeShangPanel(npcId,i)
end)


local leaveTime=ksData.leaveTime
local lerp=leaveTime-nowTime
if lerp<0 then
lerp=0
end

local isShowTimer=self.isShowKsLeaveTime or false
widget:SetChildActive(keshangItemCmpIndex.timeText,isShowTimer)
if isShowTimer then
local timeStr=timeHelper.format_time_stamp11(lerp,true)
widget:SetChildText(keshangItemCmpIndex.timeText,timeStr)
end

local nearLeaveTime=3600*3
local isShowLeaveTipsText=lerp<=nearLeaveTime
widget:SetChildActive(keshangItemCmpIndex.leaveTipsText,isShowLeaveTipsText)
if isShowLeaveTipsText then
widget:SetChildText(keshangItemCmpIndex.leaveTipsText,"即将离开")
end

local reddot=xianzhanModel:checkKeShangOrderReddot(npcId)
widget:SetChildActive(keshangItemCmpIndex.reddot,reddot)
end
elseif isShowNext then
widget:SetChildActive(-1,true)
widget:SetChildActive(keshangItemCmpIndex.showPanel,false)
widget:SetChildActive(keshangItemCmpIndex.notPanel,true)
widget:SetChildCSImageSprite(keshangItemCmpIndex.bg,abName,"frame_shagnpuj_06")

local lerp=nextTime-nowTime
if lerp<0 then
lerp=0
end
local timeStr=timeHelper.format_time_stamp11(lerp,true)
widget:SetChildText(keshangItemCmpIndex.tipsTimeText,FMT.fmt("<color=#aae252>{0}</color>",timeStr))
else
widget:SetChildActive(-1,false)
end
end

if createCount>0 then

self:setRefreshKeShangTimer()
else

self:clearRefreshKeShangTimer()
end


self:refreshStartJiShiBtn()


self:refreshJiShiBuffPanel()
end

function UIXianZhanMapWin:refreshKeShangPanel_onlyTime()
local nextTime=xianzhanModel:getKeShangNextTime()
local isShowNext=nextTime and nextTime>0 or false

local grids=self.keShangList:getChildLayoutGroupGridList()
local nowTime=timeHelper.getServerShortTime()
for i=1,grids.Count do
local widget=grids[i-1]
local ksData=self.sortKsList[i]
if ksData then
widget:SetChildActive(-1,true)

local leaveTime=ksData.leaveTime
local lerp=leaveTime-nowTime
if lerp<=0 then
return self:refreshKeShangPanel()

end

local isShowTimer=self.isShowKsLeaveTime or false
widget:SetChildActive(keshangItemCmpIndex.timeText,isShowTimer)
if isShowTimer then
local timeStr=timeHelper.format_time_stamp11(lerp,true)
widget:SetChildText(keshangItemCmpIndex.timeText,timeStr)
end

local nearLeaveTime=3600*3
local isShowLeaveTipsText=lerp<=nearLeaveTime
widget:SetChildActive(keshangItemCmpIndex.leaveTipsText,isShowLeaveTipsText)
if isShowLeaveTipsText then
widget:SetChildText(keshangItemCmpIndex.leaveTipsText,"即将离开")
end

elseif isShowNext then

local lerp=nextTime-nowTime
if lerp<=0 then

xianzhanController:req_add_new_keshang()

return self:clearRefreshKeShangTimer()
end
local timeStr=timeHelper.format_time_stamp11(lerp,true)
widget:SetChildText(keshangItemCmpIndex.tipsTimeText,FMT.fmt("<color=#aae252>{0}</color>",timeStr))
else
widget:SetChildActive(-1,false)
end
end
end


function UIXianZhanMapWin:test_setShowKeShangLeaveTime(flag)
self.isShowKsLeaveTime=flag
end

function UIXianZhanMapWin:checkKeShangReddot()
if self.sortKsList and next(self.sortKsList)then
local grids=self.keShangList:getChildLayoutGroupGridList()
for i=1,grids.Count do
local widget=grids[i-1]
local ksData=self.sortKsList[i]

if ksData then
local npcId=ksData.npcid
local reddot=xianzhanModel:checkKeShangOrderReddot(npcId)
widget:SetChildActive(keshangItemCmpIndex.reddot,reddot)
else
widget:SetChildActive(keshangItemCmpIndex.reddot,false)
end

end
end
end

function UIXianZhanMapWin:sortKeShangListByRzTime(list)
local sortList={}
for i,v in pairs(list)do
local npcId=v.npcid
local npcCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,npcId)
local rzTime=v.rzTime
local leaveTime=rzTime+npcCfg.ksTime
local data={
npcid=v.npcid,
rzTime=v.rzTime,
leaveTime=leaveTime,
}
sortList[#sortList+1]=data
end

table.sort(sortList,function(a,b)
if a.rzTime==b.rzTime then
return a.npcid<b.npcid
else
return a.rzTime<b.rzTime
end
end)

return sortList
end

function UIXianZhanMapWin:setRefreshKeShangTimer()
self:clearRefreshKeShangTimer()
self.refreshKSTimer=self:setTimer(1,0,function()
if not _this then return end
return _this:refreshKeShangPanel_onlyTime()
end)
end

function UIXianZhanMapWin:clearRefreshKeShangTimer()
if self.refreshKSTimer then
self:stopTimerByID(self.refreshKSTimer)
self.refreshKSTimer=nil
end
end

function UIXianZhanMapWin:refreshStartJiShiBtn()
local baseCfg=cfgHelper.get(cfg_xianzhankeshangbaseconfig_get,1)

local maxXyValue=baseCfg.xyzMax
local nowXyValue=moneyModel.getMoney(eMoneyType.mtXianZhanXinYuZhi)
self.xyValueText:setText(FMT.fmt("{0}/{1}",nowXyValue,maxXyValue))


local onceStartJiShiNeedXy=baseCfg.jsUse
local reddot=nowXyValue>=onceStartJiShiNeedXy
self.startJiShiReddot:setActive(reddot)
end


function UIXianZhanMapWin:onStartJiShiBtn()
self:showWindow("UIXianZhanJiHuiDialouge")
end

function UIXianZhanMapWin:refreshJiShiBuffPanel()
self:clearBuffTimer()
local allBuffList=homeBuffModel.getAllList()
self.showBuffList={}
for i,v in ipairs(allBuffList)do
local guildstateconfig=cfg_guildstateconfig_get(v[1])
if guildstateconfig.show or guildstateconfig.show==nil then
if guildstateconfig.isXianZhanShow then
self.showBuffList[#self.showBuffList+1]=v
end
end
end

local showBuffCount=#self.showBuffList
local isShowBuffPanel=showBuffCount>0
self.jiShiBuffGridGourp:setActive(isShowBuffPanel)
if isShowBuffPanel then
self.jiShiBuffGridGourp:setChildLayoutGroupCreateItems(showBuffCount)
local grids=self.jiShiBuffGridGourp:getChildLayoutGroupGridList()
local isSetTimer=false
for i=1,grids.Count do
local widget=grids[i-1]
local data=self.showBuffList[i]
local id=data[1]
local endStamp=data[2]
local guildstateconfig=cfg_guildstateconfig_get(id)
local showTimeByConfig=guildstateconfig.showtime~=false
local isEveryTime=endStamp<=0
local showTime=not isEveryTime and showTimeByConfig or false
local effects=guildstateconfig.effects
local iconname=iconHelper.getzmStateIcon(guildstateconfig.icon)
local txt=''
local hasHigher=homeBuffModel.hasHigherLevelBuff(id)
for i,v in ipairs(effects)do
local effectid=effects[i]
local desc=homeBuffModel:getBuffDesc(effectid)
desc=string.replaceSpace(desc)
txt=txt~=''and FMT.fmt('{0}\n{1}',txt,desc)or desc
end
if hasHigher then
txt=FMT.cfmt(FONT_COLOR.eRedColor,'已有更高阶效果生效中')
end

widget:SetChildCSImageIcon(jishiBuffItemCmpIndex.buffIcon,iconname,false)
widget:SetChildImageExGray(jishiBuffItemCmpIndex.buffIcon,hasHigher)


widget:SetChildText(jishiBuffItemCmpIndex.buffName,guildstateconfig.name)


widget:SetChildActive(jishiBuffItemCmpIndex.buffTimeText,showTime)
if showTime then
local stamp=timeHelper.getServerShortTime()
local left=endStamp-stamp
local timeStr=""
if left>0 then
timeStr=FMT.fmt("({0})",timeHelper.format_time_stamp13(left))
end
widget:SetChildText(jishiBuffItemCmpIndex.buffTimeText,timeStr)
isSetTimer=true
end


widget:SetChildText(jishiBuffItemCmpIndex.buffText,txt)
end

if isSetTimer then

self:setBuffTimer()
end
end
end

function UIXianZhanMapWin:refreshJiShiBuffPanel_onlyTime()
local showBuffCount=#self.showBuffList
local isShowBuffPanel=showBuffCount>0
self.jiShiBuffGridGourp:setActive(isShowBuffPanel)
if isShowBuffPanel then
self.jiShiBuffGridGourp:setChildLayoutGroupCreateItems(showBuffCount)
local grids=self.jiShiBuffGridGourp:getChildLayoutGroupGridList()
local isSetTimer=false
for i=1,grids.Count do
local widget=grids[i-1]
local data=self.showBuffList[i]
local id=data[1]
local endStamp=data[2]
local guildstateconfig=cfg_guildstateconfig_get(id)
local showTimeByConfig=guildstateconfig.showtime~=false
local isEveryTime=endStamp<=0
local showTime=not isEveryTime and showTimeByConfig or false

widget:SetChildActive(jishiBuffItemCmpIndex.buffTimeText,showTime)
if showTime then
local stamp=timeHelper.getServerShortTime()
local left=endStamp-stamp
local timeStr=""
if left>0 then
timeStr=FMT.fmt("({0})",timeHelper.format_time_stamp13(left))
else

return self:refreshJiShiBuffPanel()
end
widget:SetChildText(jishiBuffItemCmpIndex.buffTimeText,timeStr)
isSetTimer=true
end
end
if not isSetTimer then

return self:clearBuffTimer()
end
else

return self:clearBuffTimer()
end
end

function UIXianZhanMapWin:setBuffTimer()
self:clearBuffTimer()
self.buffTimer=self:setTimer(1,0,function()
if not _this then return end
return _this:refreshJiShiBuffPanel_onlyTime()
end)
end

function UIXianZhanMapWin:clearBuffTimer()
if self.buffTimer then
self:stopTimerByID(self.buffTimer)
self.buffTimer=nil
end
end




function UIXianZhanMapWin:initKeShangHud()
return xianzhanController:checkAllKeShangHud()
end

function UIXianZhanMapWin:refreshKeShangHud(posIndex)
self:removeKeShangHud(posIndex)

local entity=xianzhanController:findXianZhanKeShangEnityByPosIndex(posIndex)
if entity then
local guid=entity.guid
local enterTimeStamp=entity.enterTimeStamp
local leaveTimeStamp=entity.leaveTimeStamp

local offset=_MapManager.GetObjectHeadOffset(guid)
local hudID=hudControl:addHUD(INSTANCE_TYPE.eXianZhanKeShangHud,guid,offset,true,true,function(id)
if _this==nil then return end
local widget=hudControl:getHUDWidget(id)
local npcId=entity.id
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onClickKeShang(npcId)
end)

widget:SetChildUIModelShowTarget(2,5327,1,{},eAnimationID.stand)

local leaveTimerFunc=function()
if _this==nil or widget==nil then return end
local nowTime=timeHelper.getServerShortTime()
local lerp=leaveTimeStamp-nowTime
if lerp>0 then
local allTimeStamp=leaveTimeStamp-enterTimeStamp
local crr=lerp/allTimeStamp

widget:SetChildIconFillAmount(1,crr)
else
widget:SetChildUIModelRemoveTarget(2)

return _this:removeKeShangHud(posIndex)
end
end

self.keShangTimerList[posIndex]=_this:setTimer(1,0,leaveTimerFunc)
leaveTimerFunc()
end)
self.keShangHudList[posIndex]=hudID
end
end

function UIXianZhanMapWin:removeKeShangHud(posIndex)
if self.keShangHudList[posIndex]~=nil then
self:stopKeShangTimer(posIndex)
local hudId=self.keShangHudList[posIndex]
hudControl:removeHUD(hudId)
self.keShangHudList[posIndex]=nil
end
end

function UIXianZhanMapWin:removeAllKeShangHud()
if self.keShangHudList and next(self.keShangHudList)then
for posIndex,hudId in pairs(self.keShangHudList)do
self:removeKeShangHud(posIndex)
end
end
end

function UIXianZhanMapWin:stopKeShangTimer(posIndex)
if self.keShangTimerList[posIndex]then
self:stopTimerByID(self.keShangTimerList[posIndex])
self.keShangTimerList[posIndex]=nil
end
end

function UIXianZhanMapWin:onClickKeShangPanel(npcId,index)
local posIndex=xianzhanController:findKeShangPosIndexByNpcId(npcId)
if posIndex then
local baseCfg=cfgHelper.get(cfg_xianzhankeshangbaseconfig_get,1)
local waitPosList=baseCfg.ksWaitPos
local waitPos=waitPosList[posIndex]
if waitPos then
local temppos=_MapManager.ToVector3Int(waitPos[1],waitPos[2],0)
local pos=_MapManager.GetCellCenterWorld(mapIdType.xianzhan,temppos,mapLayer.Data)
isometricMapSystem:setCameraOrthoSize(6,0.25,function()
return isometricMapSystem:moveCameraToPosition(pos,true,function()
return self:onClickKeShang(npcId,index)
end)
end)
end
end
end

function UIXianZhanMapWin:onClickKeShang(npcId,index)
if xianzhanModel:isBuildingModel()then return end

self:showWindow("UIXianZhanSellWin",{npcId=npcId,index=index})
end




function UIXianZhanMapWin:refreshBdSkinBtn()
local reddot=false
local build_id=self.bdData.build_id
local isShowSkinBtn=self.bdData and buildSkinModel:checkBuildCanChangeSkin(build_id)or false
if isShowSkinBtn then
reddot=buildSkinModel:checkBuildSkinUnLockReddotByBuildId(build_id)
end
self.bdSkinBtn:setActive(isShowSkinBtn)
self.bdSkinReddot:setActive(reddot)
end

function UIXianZhanMapWin:onBdSkinBtn()
if self.bdData then
local build_id=self.bdData.build_id
local un_build_id=self.bdData.un_build_id

buildSkinController:showBuildSkinListWin(build_id,un_build_id)
end
end


function UIXianZhanMapWin:onRebuildBtn()
local sfcfg=cfgHelper.get1(cfg_monijysfconfig_get,mapIdType.xianzhan)
local camera_pos=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'camera_pos')
local cameraPos=_MapManager.GetCameraPosition()
local def_orthographic_size=sfcfg.def_orthographic_size
if webGLHelper:isRunMiniGame()then
def_orthographic_size=sfcfg.def_orthographic_size_webgl
end
self.mark_orthographic_size=_MapManager.GetCameraOrthographicSize()
local movepos=Vector3(camera_pos[1],camera_pos[2],cameraPos.z)
local func=function()
isometricMapSystem:setCameraOrthoSize(def_orthographic_size[3],0.3,nil,nil)
end
isometricMapSystem:moveCameraToPosition(movepos,true,func)
UIManager:showWindow('UIXianZhanReBuildWin')
end

function UIXianZhanMapWin:onTitleBtn()
if xianzhanModel:isBuildingModel()then return end
xianzhanController:leaveXianZhanMap()
end




function UIXianZhanMapWin:rec_kickoutNpc(roomId)
self:refreshRoomNPC(roomId)
self:refreshRoomHudTime(nil,roomId)
end

function UIXianZhanMapWin:rec_updataRoom(roomId)
self:refreshRoomHud(nil,roomId)
self:refreshRoomNPC(roomId)
end


function UIXianZhanMapWin:rec_tuifangReward()
self:refreshTuiFangReward(true)
end


function UIXianZhanMapWin:rec_unlockRoom(roomId)
self:removeRoomNpcEx(roomId)
local func=function()
if _this==nil then return end
_this:refreshRoomModelHud(roomId)
_this:refreshRoomNPC(roomId)
xianzhanController:refreshRoomModel(roomId)
end
xianzhanController:showRoomBuildEffect(roomId,func)
end


function UIXianZhanMapWin:rec_rebuildRoom(roomId)
self:removeRoomNpcEx(roomId)
local func=function()
if _this==nil then return end
_this:refreshRoomModelHud(roomId)
_this:refreshRoomNPC(roomId)
xianzhanController:refreshRoomModel(roomId)
end
xianzhanController:showRoomBuildEffect(roomId,func)


end


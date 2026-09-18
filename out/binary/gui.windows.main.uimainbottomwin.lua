







def_class("UIMainBottomWin",UIWindowBase)









function UIMainBottomWin:bindComponents()

self.UIMainBottomWin=UIWindowLua.new(self,0)
self.btnChange_concise=UIButton.get(self,1)
self.btnChange_normal=UIButton.get(self,2)
self.btnFriend=UIButton.get(self,3)
self.btnHuZhu=UIButton.get(self,4)
self.btnJieYu=UIButton.get(self,5)
self.btnJieYu2=UIButton.get(self,6)
self.btnList=UIObject.get(self,7)
self.btnWorld=UIButton.get(self,8)
self.chatContent=UIObject.get(self,9)
self.chatCreater=UIGameobjectClone.new(self,10)
self.chatReddot=UIObject.get(self,11)
self.chatRedPacket=UIObject.get(self,12)
self.chatScrollView=UIObject.get(self,13)
self.friendReddot=UIImage.get(self,14)
self.huzhuText=UIText.get(self,15)
self.leftArea=UIObject.get(self,16)
self.numText=UIText.get(self,17)
self.rightArea=UIObject.get(self,18)
self.worldActFlagImg=UIImage.get(self,19)

self.btnChange_concise:setButtonClick(function()self:onBtnChange_concise()end)

self.btnChange_normal:setButtonClick(function()self:onBtnChange_normal()end)

self.btnFriend:setButtonClick(function()self:onBtnFriend()end)

self.btnHuZhu:setButtonClick(function()self:onBtnHuZhu()end)

self.btnJieYu:setButtonClick(function()self:onBtnJieYu()end)

self.btnJieYu2:setButtonClick(function()self:onBtnJieYu2()end)

self.btnWorld:setButtonClick(function()self:onBtnWorld()end)
self.btnChange={
["concise"]=self.btnChange_concise,
["normal"]=self.btnChange_normal,
}



end


function UIMainBottomWin:unbindComponents()
local _UIObject_release=UIObject.release
self.UIMainBottomWin:deleteSelf();self.UIMainBottomWin=nil;
_UIObject_release(self.btnChange_concise);self.btnChange_concise=nil;
_UIObject_release(self.btnChange_normal);self.btnChange_normal=nil;
_UIObject_release(self.btnFriend);self.btnFriend=nil;
_UIObject_release(self.btnHuZhu);self.btnHuZhu=nil;
_UIObject_release(self.btnJieYu);self.btnJieYu=nil;
_UIObject_release(self.btnJieYu2);self.btnJieYu2=nil;
_UIObject_release(self.btnList);self.btnList=nil;
_UIObject_release(self.btnWorld);self.btnWorld=nil;
_UIObject_release(self.chatContent);self.chatContent=nil;
self.chatCreater:deleteSelf();self.chatCreater=nil;
_UIObject_release(self.chatReddot);self.chatReddot=nil;
_UIObject_release(self.chatRedPacket);self.chatRedPacket=nil;
_UIObject_release(self.chatScrollView);self.chatScrollView=nil;
_UIObject_release(self.friendReddot);self.friendReddot=nil;
_UIObject_release(self.huzhuText);self.huzhuText=nil;
_UIObject_release(self.leftArea);self.leftArea=nil;
_UIObject_release(self.numText);self.numText=nil;
_UIObject_release(self.rightArea);self.rightArea=nil;
_UIObject_release(self.worldActFlagImg);self.worldActFlagImg=nil;
self.btnChange=nil;
end

















local _this

function UIMainBottomWin:onLoaded(...)
self:bindComponents()
_this=self

myxpcall(function()

self.handler=chatMessageMainHandler.create(self.chatCreater,self.chatContent:getID(),self)
self:registerChatHandle()
self.chatCreater:setRefreshAction(function(...)self:onFinishChatCreatAction(...)end)
chatControl.freshMainMesgPanel(MAIN_HOLD_TYPE.eMain,self.handler)
end)
self.viewHeight=self.winlua:GetChildSizeDeltaY(self.chatScrollView:getID())
self.viewWidth=self.winlua:GetChildSizeDeltaX(self.chatScrollView:getID())


self:addReddotNotify(REDDIT_TYPE.eFriend,function(...)
self:onfreshFriendReddot(...)
end)
self:addReddotNotify(REDDIT_TYPE.eFriendPoint,function(...)
self:onfreshFriendReddot(...)
end)


self.iconLuaObjectLookup={}
self:addNotify(notifyConfig.iconUnlock,function(...)self:onIconUnlock(...)end)
self:addNotify(notifyConfig.onRecvMessage,function(...)self:onRecvMessage(...)end)
self:addNotify(notifyConfig.on_system_open,function(...)self:on_system_open(...)end)
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addNotify(notifyConfig.onZongMengLevelChange,self.onZongMengLevelChange)
self:addNotify(notifyConfig.on_main_btn_state_changed,function(...)
self:onBtnStateChanged(...)
end)
self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
self:addNotify(notifyConfig.onSubActivityOpen,self.onSubActivityOpen)
self:addNotify(notifyConfig.onCSJDGuildDataChange,self.onCSJDGuildDataChange)
self:addNotify(notifyConfig.onXMHBGuildDataChange,self.onXMHBGuildDataChange)
end

function UIMainBottomWin:__delete()
_this=nil

self:endAllReddotPunchRotation()


self:unregisterChatHandle()
self.chatCreater:setRefreshAction(nil)


self:releaseAllButton()


self:unbindComponents()
end

function UIMainBottomWin:onShow(argtable,afterOnloaded)
self.rightArea:setActive(true)
self:freshGroupBtns()
if not afterOnloaded then
self:doCloneMove(0)
end
self:setContentBottom()
self:freshSimpleBtn()
self:freshFriendReddot()
self:refreshWorldEnable()
self:refreshWorldFlag()
self:refreshJieYuBtn()
self:freshHuZhuBtn()

self:initRedPacket()
self:refreshRedPacket()
end

function UIMainBottomWin:onHide()
self.rightArea:setActive(false)
end




function UIMainBottomWin:onReConnection()
self.chatCreater:recycleAll()
chatControl.freshMainMesgPanel(MAIN_HOLD_TYPE.eMain,self.handler)
end

function UIMainBottomWin:onBtnHuZhu()
UIManager:showWindow('UIYingXianGeXMHZWin')
end

function UIMainBottomWin:onBtnFriend()
friendController:showMainUI()
end



function UIMainBottomWin:onBtnChange_concise()
self:changeSimpleMode(false)
end



function UIMainBottomWin:onBtnChange_normal()
self:changeSimpleMode(true)
end

function UIMainBottomWin:onIconUnlock(iconTypes)
local len=#iconTypes
local btnGroupType=MAIN_ICON_GROUP_TYPE.eBottom
local iconTypes=mainConfig.getGroupIconTypeList(btnGroupType)
local flag=table.containsTableValue(iconTypes,iconTypes)
if flag then
self:freshGroupBtns()
self:doCloneMove()
end
end

function UIMainBottomWin:onBtnStateChanged(btnType,oldvis,newvis)
local cfgs=self.btnCfgs
local look=cfgs.look
if look[btnType]==nil then return end
self:freshGroupBtns()
self:doCloneMove()
end

function UIMainBottomWin:onBtnWorld()
if not systemModel.isOpen(SYSTEM_DEFINE.eWorld)then
UIManager.error("神州世界危险重重，请祖师先发展宗门")

return
end
if worldBlockModel:checkWorldEnterLimit(2)then
UIManager:showWindow("UIWorldMapWinEx",{showInfo=true,enter=function(index)
if not mainControl:isWaitSceneChange()then
worldController:enterWorld(index)
end
UIManager:closeWindow("UIWorldMapWinEx")
end})
else
if not mainControl:isWaitSceneChange()then
worldController:enterWorld(1)
end
end
end

function UIMainBottomWin:onBtnJieYu()
local btnList={
MAIN_BTNS_TYPE.eSubMoJie,
MAIN_BTNS_TYPE.eSubWorld,
MAIN_BTNS_TYPE.eSubXianJie,
MAIN_BTNS_TYPE.eSubXianYu,
MAIN_BTNS_TYPE.eSubZM,
}

local posVector2=self.btnJieYu:getChildScreenPointToLocalPointRectangle(-1)
local pos={posVector2.x-70,posVector2.y+115}

UIManager:showWindow("UIMainSubEnterPanelWin",{btnList=btnList,pos=pos,posType=2})
end

function UIMainBottomWin:onBtnJieYu2()
self:onBtnJieYu()
end

function UIMainBottomWin:on_system_open(sysId)
if _this==nil or _this.isClose then return end
if sysId==SYSTEM_DEFINE.eFriend then
self.btnFriend:setActive(true)
end
if sysId==SYSTEM_DEFINE.eWorld then
_this:refreshWorldEnable()
end
_this:freshChatReddot()
end

function UIMainBottomWin.onZongMengLevelChange()
if _this==nil or _this.isClose then return end
_this:freshChatReddot()
_this:refreshWorldFlag()
end

function UIMainBottomWin.onNewDay()
if _this==nil or _this.isClose then return end
_this:freshChatReddot()
_this:refreshWorldFlag()
end


function UIMainBottomWin:changeSimpleMode(flag)
local oldflag=simpleModeControl:isSimple()
if oldflag==flag then return end
simpleModeControl:setSimple(flag)

simpleModeControl:setRightSimple(flag)
UIManager:callWindowFunc('UIMainFuncBtnWin','initRightPanel')

simpleModeControl:setLeftSimple(flag and leftSimpleState.hide or
leftSimpleState.task)
UIManager:callWindowFunc('UIMainXMTaskWin','freshSimple')
UIManager:callWindowFunc('UIMainXMInfoWin','freshSimpleBtn')

self:freshSimpleBtn()
end


function UIMainBottomWin:freshSimpleBtn()
local flag=simpleModeControl:isSimple()
self.btnChange["concise"]:setActive(flag)
self.btnChange["normal"]:setActive(not flag)
end



function UIMainBottomWin:registerChatHandle()
if not self.isHandle then
self.isHandle=true
chatControl.registerMainHandler(MAIN_HOLD_TYPE.eMain,self.handler)
end
end

function UIMainBottomWin:unregisterChatHandle()
if self.isHandle then
self.isHandle=false
chatControl.unregisterMainHandler(MAIN_HOLD_TYPE.eMain,self.handler)
end
end


function UIMainBottomWin:onRecvMessage()
self:freshChatReddot()
end

function UIMainBottomWin:onReadNewestMesg(channel,actorid)
self:freshChatReddot()
end

function UIMainBottomWin:freshChatReddot()
local channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eXianmeng,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.ePrivate}

local num=0
for _,channelId in ipairs(channels)do
if chatControl.hasNewMesgByChannel(channelId)then
num=num+chatControl.getNewestMesgNumByChannel(channelId)
end
end
local reddot=num>0
if num>99 then
num='99+'
elseif num<=0 then
num=''
end
self.chatReddot:setActive(reddot)
self.numText:setText(num)
self.chatReddotIndex=self:doPunchRotation(self.widget,self.chatReddot:getID(),self.chatReddotIndex,reddot)
end


function UIMainBottomWin:setContentBottom(ani)
local height=self.winlua:GetChildSizeDeltaY(self.chatContent:getID())
local viewHeight=self.viewHeight
self.winlua:SetStopChildScrollRect(self.chatScrollView:getID())
self.winlua:SetChildDOAnchorPosY(self.chatContent:getID(),0,ani and 0.2 or 0)
end

function UIMainBottomWin:onFinishChatCreatAction(assetName,guid,luaid,isInit)
if not isInit then
self:setContentBottom(true)
self.chatCreater:callChildFunc(luaid,'playAni')
end
end


function UIMainBottomWin:freshFriendReddot()
local reddot=friendController:hasReddot()
self.friendReddot:setActive(reddot)
self.friendReddotIndex=self:doPunchRotation(self.widget,self.friendReddot:getID(),self.friendReddotIndex,reddot)
end


function UIMainBottomWin:onfreshFriendReddot(class,sub_typo,last_flag,flag)
self.friendReddot:setActive(flag)
self.friendReddotIndex=self:doPunchRotation(self.widget,self.friendReddot:getID(),self.friendReddotIndex,flag)
end


function UIMainBottomWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if webGLHelper:isHidePunchAni()then return end
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UIMainBottomWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end


function UIMainBottomWin:freshGroupBtns()
local iconGroupType=MAIN_ICON_GROUP_TYPE.eBottom
local index=self.btnList:getID()
local list,configs=mainConfig.getBottomGroupConfig()
self.btnCfgs=configs
local indexArray={}
local parentIndexArray={}
local keys={}

for i,v in ipairs(list)do
indexArray[i]=v.UIPrefabIndex
parentIndexArray[i]=i-1
keys[i]=v.key
end
self.winlua:SetCreatChildClonePrefabEx(index,indexArray,parentIndexArray,keys)

self.luaObjectList={}
if not self.iconLuaObjectLookup[iconGroupType]then
self.iconLuaObjectLookup[iconGroupType]={}
end

local lookup=self.iconLuaObjectLookup[iconGroupType]
local temp={}
for k,v in pairs(lookup)do
temp[k]=v
end
for i=1,#list do
local config=list[i]
local key=config.key
local iconType=config.iconType
local luaObjet=lookup[key]
temp[key]=nil
local isFadeIn=iconType and not systemIconFlyControl.isFly(iconType)or false
local widget=self.winlua:GetChildCloneWidget(index,i-1)
local isInit=luaObjet==nil
if isInit then
mainBtnConfig.PreloadCtor(config)
local ctor=config.ctor
luaObjet=ctor(widget,i,config)
lookup[key]=luaObjet
luaObjet:onLoaded()
else
luaObjet:init(widget,i,config)
end
local luaObjectList=self.luaObjectList
luaObjectList[#luaObjectList+1]=luaObjet
luaObjet:onShow(isInit)
luaObjet:setChildCanvasGroupAlpha(-1,isFadeIn and 0 or 1)
local comName=FMT.fmt('{0}.click',keys[i])
luaObjet:setNewBieComponentId(1,comName)
luaObjet:setChildWeakGuideComponentId(1,comName)
end

for key,luaObjet in pairs(temp)do
lookup[key]=nil
if luaObjet and luaObjet.release then
luaObjet:release()
end
end
end


function UIMainBottomWin:releaseAllButton()
for _,lookup in pairs(self.iconLuaObjectLookup)do
for _,luaObjet in pairs(lookup)do
if luaObjet and luaObjet.release then
luaObjet:release()
end
end
end
self.iconLuaObjectLookup={}
end

function UIMainBottomWin:doCloneMove(duration)
local index=self.btnList:getID()
self.winlua:StartChildClonePrefabTween(index,duration or 0.5,DG.Tweening.Ease.InOutBack)
end


function UIMainBottomWin:getWidgetByKey(key)
local btnGroupType=mainConfig.getIconGroupType(key)
if btnGroupType==MAIN_ICON_GROUP_TYPE.eBottom then
local index=self.btnList:getID()
return self.winlua:GetChildCloneWidgetByKey(index,key)
end
end


function UIMainBottomWin:getPositionByKey(key)
local btnGroupType=mainConfig.getIconGroupType(key)
if btnGroupType==MAIN_ICON_GROUP_TYPE.eBottom then
local index=self.btnList:getID()
return self.winlua:GetChildClonePositionByKey(index,key)
end
end

function UIMainBottomWin:getLuaObjectByKey(key)
for _,lookup in pairs(self.iconLuaObjectLookup)do
if lookup[key]then
return lookup[key]
end
end
end


function UIMainBottomWin:doFadeNomal(key)
local luaObjet=self:getLuaObjectByKey(key)
if luaObjet then
luaObjet:setChildCanvasGroupAlpha(-1,1)
end
end

function UIMainBottomWin:refreshWorldFlag()
local actList={}
local lp=limitActivitiesModel.getWorldMapLimitAct()
for lActID,Cfg in pairs(lp)do
local actInfo=limitActivitiesModel:getActInfo(lActID)
if actInfo and actInfo:checkOpen()and actInfo:checkDoing()and Cfg.flagImage then
self.worldActFlagImg:setSprite(globalABLookup.mainwin,Cfg.flagImage)
return
end
end
self.worldActFlagImg:setImageIcon("",false)
end

function UIMainBottomWin.onLimitActStateChange(actID,actState)
local cfg=cfgHelper.get1(cfg_worldmaplimitactivityconfig_get,actID)
if cfg then
_this:refreshWorldFlag()
end
if actID==LIMIT_ACT_TYPE.eMojieSaiJi then
_this:refreshJieYuBtn()
end
end

function UIMainBottomWin:refreshWorldEnable()


end

function UIMainBottomWin:freshHuZhuBtn()
local isOpen=YingXianGeModel:checkOpen()
self.btnHuZhu:setActive(isOpen)
if isOpen then
local _,_,add,max=YingXianGeModel:getReduceTimesData()
local cur=xianmengModel:getXMCooperationEarn()
self.huzhuText:setText(FMT.fmt("{0}/{1}",cur,max))
end
end

function UIMainBottomWin:refreshJieYuBtn()
local hasOpenXianJie=xianjieController:checkXianJieSystemOpen()
local mojieEnterTime=xianjieModel:checkCurrentMoJieEnterTime()
self.btnWorld:setActive(not hasOpenXianJie)
self.btnJieYu:setActive(hasOpenXianJie and not mojieEnterTime)
self.btnJieYu2:setActive(hasOpenXianJie and mojieEnterTime)
end

function UIMainBottomWin:initRedPacket()
local subList=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCaiShenJiaDao)
local list={}
for index,info in ipairs(subList)do

table.insert(list,info)

end
if#list>1 then
table.sort(list,function(a,b)
return a.start_time<b.start_time
end)
end
self.redpacketInfo_CSJD=list[1]

local sub_actList_xmhb=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eXianMengHongBao)
if#sub_actList_xmhb>0 then
self.redpacketInfo_XMHB=sub_actList_xmhb[1]
end
end

function UIMainBottomWin:refreshRedPacket()
if self.redpacketInfo_CSJD or self.redpacketInfo_XMHB then
local count=0
if self.redpacketInfo_CSJD then
local count_csjd=self.redpacketInfo_CSJD:countGuildDataStatus(eCSJDRedPacketStatus.eNormal)
count=count+count_csjd
end
if self.redpacketInfo_XMHB then
local count_xmhb=self.redpacketInfo_XMHB:getGuildDataCanGetRedPacketCount()
count=count+count_xmhb
end

self.chatRedPacket:setActive(count>0)
else
self.chatRedPacket:setActive(false)
end
end

function UIMainBottomWin.onSubActivityStateChange(actId,subType,subId,state)
if subType==SUB_ACTIVITY_TYPE.eCaiShenJiaDao then
_this:initRedPacket()
_this:refreshRedPacket()
end
end

function UIMainBottomWin.onSubActivityOpen(actId,subType,subId,flag)
if subType==SUB_ACTIVITY_TYPE.eCaiShenJiaDao then
_this:initRedPacket()
_this:refreshRedPacket()
end
end

function UIMainBottomWin.onCSJDGuildDataChange(actId,subType,subId,guid,reSort)
if reSort then
_this:refreshRedPacket()
end
end

function UIMainBottomWin.onXMHBGuildDataChange(actId,subType,subId,guid,reSort)
if reSort then
_this:refreshRedPacket()
end
end
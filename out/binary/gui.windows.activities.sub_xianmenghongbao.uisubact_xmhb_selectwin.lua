







def_class("UISubAct_XMHB_selectWin",UIWindowBase)









function UISubAct_XMHB_selectWin:bindComponents()

self.titleText=UIText.get(self,0)
self.hbGroup=UIObject.get(self,1)
self.selectBtn=UIButton.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.bgModel=UIObject.get(self,4)
self.titleIcon=UIImage.get(self,5)
self.sendRewardPanel=UIObject.get(self,6)
self.sendRwScrollView=UIObject.get(self,7)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_XMHB_selectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.hbGroup);self.hbGroup=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.titleIcon);self.titleIcon=nil;
_UIObject_release(self.sendRewardPanel);self.sendRewardPanel=nil;
_UIObject_release(self.sendRwScrollView);self.sendRwScrollView=nil;
end
















local _this



function UISubAct_XMHB_selectWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_XMHB_selectWin:__delete()
_this=nil
self:unbindComponents()
end




function UISubAct_XMHB_selectWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end
self.hbLv=argtable.hbLv
self.selectHbId=argtable.hbId

self.myData=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.sub_actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

self.bgModel:setChildUIModelShowTarget(6523,1,{},eAnimationID.enter)
self:refresh()
end


function UISubAct_XMHB_selectWin:onHide()

end

function UISubAct_XMHB_selectWin:refresh()

local hbAllCfgList=self.config.hongbao_conf
local hbCfgList=hbAllCfgList[self.hbLv]
if not hbCfgList then
logErr(FMT.fmt("找不到活动{0} 子活动{1} 对应的红包档位{2}奖励配置 请检查配置是否正确",self.activityId,self.subId,self.hbLv))
return
end

local originalHBId=self:getOriginalSelectHbId()
local hbShowParamList=self.config.hongbaoShowParam
local hbShowParam=hbShowParamList[self.hbLv]



local hbSkinId=hbShowParam.skinid
local hbSkinCfg=cfgHelper.get(cfg_guildhongbao2skinconfig_get,hbSkinId)
local titleIconName=hbSkinCfg.nameIcon2
local abName="ui/windows/activities/sub_xianmenghongbao/xmhb_icon_atlas_pak.ab"
self.titleIcon:setSprite(abName,titleIconName)

self.hbGroup:setChildLayoutGroupCreateItems(#hbCfgList,function(index)
local widget=self.hbGroup:getChildLayoutGroupGridItem(index-1)
local hbCfg=hbCfgList[index]
if hbCfg then
widget:SetChildActive(-1,true)


local itemWidget=widget:GetChildWidgetBase(1)
local itemId=hbCfg[1]
local itemCount=hbCfg[2]
local countStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end

local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)


local itemName=itemsModel.getName(itemId)
widget:SetChildText(3,itemName)


local itemMaxUseCount=hbCfg[3]
local useCount=self.sub_actInfo:getSendHBCount(self.hbLv,index)
widget:SetChildText(2,FMT.fmt("次数：{0}/{1}",useCount,itemMaxUseCount))


local isSelect=index==self.selectHbId
widget:SetChildActive(5,isSelect)


local isOriginalSelect=originalHBId and index==originalHBId or false
widget:SetChildActive(4,isOriginalSelect)


widget:SetChildButtonClick(0,function()
self:onSelectItem(index)
end,true)
else
widget:SetChildActive(-1,false)
end
end)

self:refreshSendRewardPanel()
end

function UISubAct_XMHB_selectWin:getOriginalSelectHbId()
local _key=FMT.fmt('actid{0}_subtype{1}_subid{2}',self.activityId,self.subType,self.subId)
local localData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianMengHongBaoAct,_key,{})
local originalHBId=localData[tostring(self.hbLv)]
return originalHBId
end


function UISubAct_XMHB_selectWin:refreshSendRewardPanel()

local hbLv=self.hbLv
local hbId=self.selectHbId or nil
local sendRewardList
if hbId then
local hbAllCfgList=self.config.hongbao_conf
local hbCfg=hbAllCfgList[hbLv]and hbAllCfgList[hbLv][hbId]or nil
if hbCfg then
sendRewardList=hbCfg[4]
end
end

local isShowSendRwPanel=sendRewardList and next(sendRewardList)~=nil or false
self.sendRewardPanel:setActive(isShowSendRwPanel)

if isShowSendRwPanel then
local count=#sendRewardList
self.sendRwScrollView:setChildScrollViewCreateGrids(count,count)
local grids=self.sendRwScrollView:getChildScrollViewItemWidgets()
for index=1,grids.Count do
local widget=grids[index-1]
local reward=sendRewardList[index]
if reward then
widget:SetChildActive(-1,true)
local itemWidget=widget:GetChildWidgetBase(1)
local itemId=reward[1]
local itemCount=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
if _this==nil or not _this.isVisible then return end
return self:onClickRewardItem(...)
end)
else
widget:SetChildActive(-1,false)
end
end

self.sendRwScrollView:setChildScrollRectEnable(count>4)
end
end





function UISubAct_XMHB_selectWin:onSelectBtn()
if not self.selectHbId then
UIManager.error("当前未选择红包")
return
end

local _key=FMT.fmt('actid{0}_subtype{1}_subid{2}',self.activityId,self.subType,self.subId)
local localData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianMengHongBaoAct,_key,{})
local originalHBId=localData[tostring(self.hbLv)]
if self.selectHbId==originalHBId then
UIManager.error("当前已选择该道具")
return
end
localData[tostring(self.hbLv)]=self.selectHbId

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianMengHongBaoAct,_key,localData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianMengHongBaoAct)


UIManager:invokeUIMethod("UISubAct_XMHB_mainWin","refreshNowHongBaoItems")


self:onCloseBtn()
end



function UISubAct_XMHB_selectWin:onCloseBtn()
self:closeSelf()
end

function UISubAct_XMHB_selectWin:onSelectItem(index)
if index==self.selectHbId then
return
end

local hbAllCfgList=self.config.hongbao_conf
local hbCfgList=hbAllCfgList[self.hbLv]
local hbCfg=hbCfgList[index]
local itemMaxUseCount=hbCfg[3]
local useCount=self.sub_actInfo:getSendHBCount(self.hbLv,index)
if useCount>=itemMaxUseCount then
return UIManager.error("该红包道具发送次数已达上限")
end

if self.selectHbId then
local oldWidget=self.hbGroup:getChildLayoutGroupGridItem(self.selectHbId-1)
oldWidget:SetChildActive(5,false)
end
local newWidget=self.hbGroup:getChildLayoutGroupGridItem(index-1)
newWidget:SetChildActive(5,true)
self.selectHbId=index
self:refreshSendRewardPanel()
end

function UISubAct_XMHB_selectWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

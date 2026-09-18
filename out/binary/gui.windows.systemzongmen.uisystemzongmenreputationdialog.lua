







def_class("UISystemZongMenReputationDialog",UIWindowBase)









function UISystemZongMenReputationDialog:bindComponents()

self.background=UIButton.get(self,0)
self.tipsBg=UIButton.get(self,1)
self.tipsPanel=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.model=UIObject.get(self,4)
self.dialog=UIObject.get(self,5)
self.progressBar=UIObject.get(self,6)
self.dialogTx=UIText.get(self,7)
self.progressSp=UIObject.get(self,8)
self.itemList=UIObject.get(self,9)
self.reputationIcon=UIImage.get(self,10)
self.reputationName=UIText.get(self,11)
self.reputationValue=UIText.get(self,12)
self.zmName=UIText.get(self,13)
self.descTx=UIText.get(self,14)

self.background:setButtonClick(function()self:onBackground()end)

self.tipsBg:setButtonClick(function()self:onTipsBg()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISystemZongMenReputationDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.tipsBg);self.tipsBg=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.dialog);self.dialog=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.dialogTx);self.dialogTx=nil;
_UIObject_release(self.progressSp);self.progressSp=nil;
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.reputationIcon);self.reputationIcon=nil;
_UIObject_release(self.reputationName);self.reputationName=nil;
_UIObject_release(self.reputationValue);self.reputationValue=nil;
_UIObject_release(self.zmName);self.zmName=nil;
_UIObject_release(self.descTx);self.descTx=nil;
end















local _this=nil
local _itemCmp={
root=-1,
name=0,
icon=1,
num=2,
effect=3,
nameBg=4,
iconBg=5,
}
local _abName="ui/windows/systemzongmen/systemzongmen_atlas_pak.ab"



function UISystemZongMenReputationDialog:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onSystemZMMoneyNumChange,self.onSystemZMMoneyNumChange)
notifySystem:listenNotify(notifyConfig.onSystemZMRenownRewardFlag,self.onSystemZMRenownRewardFlag)
end


function UISystemZongMenReputationDialog:__delete()
notifySystem:removelistener(notifyConfig.onSystemZMRenownRewardFlag,self.onSystemZMRenownRewardFlag)
notifySystem:removelistener(notifyConfig.onSystemZMMoneyNumChange,self.onSystemZMMoneyNumChange)
self:unbindComponents()
_this=nil
if self.dialogTween and self.dialogTween:IsActive()then
self.dialogTween:Kill()
end
if self.tipsTween and self.tipsTween:IsActive()then
self.tipsTween:Kill()
end
end




function UISystemZongMenReputationDialog:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
self.dataInfo=systemZongMenModel:getInfoData(self.serial)
self.detailInfo=systemZongMenModel:getDetailPartInfo(self.serial,systemZongMenDetailDataPart.eBase)

local nameStr=systemZongMenModel:getNameStr(self.dataInfo.id,self.dataInfo.nameIdx)
self.zmName:setText(FMT.fmt("宗门：{0}",nameStr))

local reputationValue=self.dataInfo.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local reputationIndex=systemZongMenModel:getRenownIndex(self.dataInfo.id,reputationValue)
local reputationStr=systemZongMenModel:getRenownName(reputationIndex)
local reputationIconName=systemZongMenModel:getRenownIcon(reputationIndex)
self.reputationValue:setText(FMT.fmt("声望值: {0}",reputationValue))
self.reputationName:setText(reputationStr)
self.reputationIcon:setSprite(_abName,reputationIconName)

local zmImage=UIDiscipleModel.calculationDiscipleImage(self.detailInfo.leader_data,self.detailInfo.leader_image)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(zmImage)
comHelper.setChildInSideModelEx(self.model,modelParams,1,nil,0,0,false,true)

self.dialog:setScale(Vector3.zero)
local dataCfg=cfgHelper.get1(cfg_syssectconfig_get,self.dataInfo.id)
local renownSpeak=dataCfg.renownSpeak or{}
local speakLib=nil
for i=#renownSpeak,1,-1 do
if reputationIndex>=i then
speakLib=renownSpeak[i]
break
end
end
if speakLib then
local speakStr=speakLib[math.random(1,#speakLib)]
self.dialogTx:setChildTrendsTextPlay(speakStr,40,nil)
self.dialogTween=Lua.SequenceProxy.New()
self.dialogTween:AppendInterval(0.2)
local tween1=self.dialog:setChildDOScale(1.2,0.2)
self.dialogTween:Append(tween1)
local tween2=self.dialog:setChildDOScale(1,0.1)
self.dialogTween:Append(tween2)
end

local zmType=dataCfg.type
self.reputationList=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"renown_list",zmType)
local segmentCount=#self.reputationList
local width=self.progressBar:getChildSizeDeltaX()
self.segmentLength=width/segmentCount
local progressCur=0
for i=1,segmentCount do
local v=self.reputationList[i]
if reputationValue>=v then
progressCur=progressCur+self.segmentLength
else
local last=self.reputationList[i-1]or 0
local temp=(reputationValue-last)/(v-last)*self.segmentLength
progressCur=progressCur+temp
break
end
end
self.progressSp:setChildSizeDelta(progressCur,10)

self.descTx:setText(dataCfg.renownDesc)

self.rewardList=cfgHelper.get2(cfg_syssectconfig_get,self.dataInfo.id,"renownRewards")
local iconConfig=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"renown_reward_icon")
local itemCnt=#self.rewardList
self.itemList:setChildLayoutGroupCreateItems(itemCnt,function(index)
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
local rewards=self.rewardList[index]
local reward=rewards[1]
local rewardType=reward[1]

local haveReward=false
for i,v in ipairs(rewards)do
if v[1]==systemZongMenRenownRewardType.eReward then
haveReward=true
break
end
end

local nameStr=systemZongMenModel:getRenownName(index)
item:SetChildText(_itemCmp.name,nameStr)

local iconStr=iconConfig[rewardType]
item:SetChildCSImageSprite(_itemCmp.icon,_abName,iconStr)

local numStr=index>1 and self.reputationList[index-1]or""
item:SetChildText(_itemCmp.num,numStr)

local effectShow=reputationIndex>=index and haveReward and index>self.dataInfo.sw_reward
item:SetChildActive(_itemCmp.effect,effectShow)

item:SetChildAnchoredPos(_itemCmp.root,(index-1)*self.segmentLength,0)
item:SetChildButtonClick(_itemCmp.iconBg,function()
self:onClickItem(index)
end)
item:SetChildButtonClick(_itemCmp.nameBg,function()
self:onClickItem(index)
end)

item:SetChildGraphicGray(_itemCmp.root,reputationIndex<index,true,true)
end)
end


function UISystemZongMenReputationDialog:onHide()

end





function UISystemZongMenReputationDialog:onCloseBtn()
UIFullSystemZongMenControl:closeWindow("UISystemZongMenReputationDialog")
end

function UISystemZongMenReputationDialog:onBackground()
UIFullSystemZongMenControl:closeWindow("UISystemZongMenReputationDialog")
end

function UISystemZongMenReputationDialog:onClickItem(idx)
local check=false
local list=self.rewardList[idx]
for i,v in ipairs(list)do
local type=v[1]
if type==systemZongMenRenownRewardType.eReward then
local reputationValue=self.dataInfo.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local reputationIndex=systemZongMenModel:getRenownIndex(self.dataInfo.id,reputationValue)
if reputationIndex>=idx and idx>self.dataInfo.sw_reward then
check=true
end
end
end

if check then

for index=#self.rewardList,1,-1 do
local list=self.rewardList[index]
for i,v in ipairs(list)do
local type=v[1]
if type==systemZongMenRenownRewardType.eReward then
local reputationValue=self.dataInfo.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local reputationIndex=systemZongMenModel:getRenownIndex(self.dataInfo.id,reputationValue)
if reputationIndex>=index and index>self.dataInfo.sw_reward then
systemZongMenController:req_renown_reward(self.serial,index)
return
end
end
end
end
end

self:showTips(idx)
end

function UISystemZongMenReputationDialog:refreshRenown(reputationValue)
local reputationIndex=systemZongMenModel:getRenownIndex(self.dataInfo.id,reputationValue)
local reputationStr=systemZongMenModel:getRenownName(reputationIndex)
local reputationIconName=systemZongMenModel:getRenownIcon(reputationIndex)
self.reputationValue:setText(FMT.fmt("声望值: {0}",reputationValue))
self.reputationName:setText(reputationStr)
self.reputationIcon:setSprite(_abName,reputationIconName)

local progressCur=0
for i=1,#self.reputationList do
local v=self.reputationList[i]
if reputationValue>=v then
progressCur=progressCur+self.segmentLength
else
local last=self.reputationList[i-1]or 0
local temp=(reputationValue-last)/(v-last)*self.segmentLength
progressCur=progressCur+temp
break
end
end
self.progressSp:setChildSizeDelta(progressCur,10)

local itemList=self.itemList:getChildLayoutGroupGridList()
for index=1,itemList.Count do
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
local rewards=self.rewardList[index]
local haveReward=false
for i,v in ipairs(rewards)do
if v[1]==systemZongMenRenownRewardType.eReward then
haveReward=true
break
end
end
local effectShow=reputationIndex>=index and haveReward and index>self.dataInfo.sw_reward
item:SetChildActive(_itemCmp.effect,effectShow)
item:SetChildGraphicGray(_itemCmp.root,reputationIndex<index,true,true)
end
end

function UISystemZongMenReputationDialog:onTipsBg()
self.tipsBg:setActive(false)
self.tipsPanel:setScale(Vector3.zero)
if self.tipsTween and self.tipsTween:IsActive()then
self.tipsTween:Kill()
end
self.showTipsIndex=nil
end

function UISystemZongMenReputationDialog:showTips(index)
self.showTipsIndex=index
self.tipsBg:setActive(true)
self.tipsTween=self.tipsPanel:setChildDOScale(1,0.1,function()
self.winlua:ForceLayoutRect(self.tipsPanel:getID())
end)
local rewardConfig=self.rewardList[index]
local renownName=systemZongMenModel:getRenownName(index)
self.tipsPanel:setChildAnchoredPos(-435+(index-1)*self.segmentLength,-180)
self.tipsPanel:setChildPivot(Vector2.right*(index==#self.rewardList and 1 or 0))
self.tipsPanel:setChildLayoutGroupCreateItems(#rewardConfig,function(idx)
local tipsItem=self.tipsPanel:getChildLayoutGroupGridItem(idx-1)
local tipsData=rewardConfig[idx]
local tipsType=tipsData[1]
local tipsParam=tipsData[2]
self[FMT.fmt("showTips{0}",tipsType)](self,tipsItem,tipsParam,renownName,index)
tipsItem:SetChildActive(2,idx>1)
tipsItem:ForceLayoutRect(-1)
end)
end

function UISystemZongMenReputationDialog:showTips1(item,list,renownName,index)
item:SetChildText(0,FMT.fmt("声望达到{0}可领取",renownName))
item:SetChildActive(1,true)
local getted=self.dataInfo.sw_reward>=index

item:SetChildLayoutGroupCreateItems(1,#list,function(index)
local sitem=item:GetChildLayoutGroupGridItem(1,index-1)
local itemData=list[index]
local itemId=itemData[1]
local itemNum=itemData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and itemNum or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
sitem:SetChildPropData(0,prop)
sitem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
sitem:SetChildActive(1,getted)
end)
item:ForceLayoutRect(1)
end

function UISystemZongMenReputationDialog:showTips2(item,taskId,renownName,index)
item:SetChildActive(1,false)
local taskName=cfgHelper.get2(cfg_taskconfig_get,taskId,"name")
local desc=FMT.fmt("声望达到{0}可解锁\n<color=#AAE252>委托——{1}</color>",renownName,taskName)
item:SetChildText(0,desc)
end

function UISystemZongMenReputationDialog:showTips3(item,param,renownName,index)
item:SetChildText(0,FMT.fmt("声望达到{0}可解锁\n商店新商品",renownName))
item:SetChildActive(1,true)
local zmCfg=cfgHelper.get1(cfg_syssectconfig_get,self.dataInfo.id)
local shopCfg=cfgHelper.get1(cfg_syssectshopconfig_get,zmCfg.shop)
local list={}
for itemId,config in pairs(shopCfg)do
if config.needSwLv==index then
table.insert(list,{itemId,config.itemNum})
end
end

item:SetChildLayoutGroupCreateItems(1,#list,function(idx)
local sitem=item:GetChildLayoutGroupGridItem(1,idx-1)
local itemData=list[idx]
local itemId=itemData[1]
local itemNum=itemData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and itemNum or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
sitem:SetChildPropData(0,prop)
sitem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
sitem:SetChildActive(1,false)
end)
item:ForceLayoutRect(1)
end

function UISystemZongMenReputationDialog:showTips4(item,percent,renownName,index)
item:SetChildActive(1,false)
local desc=pfwindowslController:convertDiscount_yuenan(FMT.fmt("声望达到{0}可解锁\n贡献商店商品全部<color=#AAE252>{1}折</color>",renownName,percent/1000))
item:SetChildText(0,desc)
end

function UISystemZongMenReputationDialog:refreshItemEffect()
local reputationValue=self.dataInfo.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local reputationIndex=systemZongMenModel:getRenownIndex(self.dataInfo.id,reputationValue)
for index=1,#self.rewardList do
local reward=self.rewardList[index]
for i,v in ipairs(reward)do
if v[1]==systemZongMenRenownRewardType.eReward then
local effectShow=reputationIndex>=index and index>self.dataInfo.sw_reward
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_itemCmp.effect,effectShow)
end
end
end
end

function UISystemZongMenReputationDialog:refreshTipsRewardGetted()
if not self.showTipsIndex then return end
local rewardConfig=self.rewardList[self.showTipsIndex]
for i,v in ipairs(rewardConfig)do
local tipsType=v[1]
if tipsType==systemZongMenRenownRewardType.eReward then
local getted=self.showTipsIndex<=self.dataInfo.sw_reward
local tipsItem=self.tipsPanel:getChildLayoutGroupGridItem(i-1)
local items=tipsItem:GetChildLayoutGroupGridList(1)
for j=1,items.Count do
local sitem=items[j-1]
sitem:SetChildActive(1,getted)
end
end
end
end

function UISystemZongMenReputationDialog.onSystemZMRenownRewardFlag(serial,idx,old)
if mathHelper.compareInt64(_this.serial,serial)then
_this:refreshItemEffect()
_this:refreshTipsRewardGetted()
local config=cfgHelper.get1(cfg_syssectconfig_get,_this.dataInfo.id)
if config.renownRewards then
local prizelist={}
for index=old+1,idx do
for i,v in ipairs(config.renownRewards[index])do
if v[1]==systemZongMenRenownRewardType.eReward then
for j,w in ipairs(v[2])do
table.insert(prizelist,{itemid=w[1],num=w[2]})
end
end
end
end
showPrizeControl.showWindow(prizelist)
end
end
end

function UISystemZongMenReputationDialog.onSystemZMMoneyNumChange(serial,eType,newVal,oldVal)
if _this.serial==serial and eType==systemZongMenInfoMoneyType.eShengWang then
_this:refreshRenown(newVal)
end
end
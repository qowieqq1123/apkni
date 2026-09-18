







def_class("UISubAct_zhaozhitehui_Win",UIWindowBase)









function UISubAct_zhaozhitehui_Win:bindComponents()

self.modelBg=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.timeRoot=UIObject.get(self,2)
self.titleImgae=UIImage.get(self,3)
self.lefttime=UIText.get(self,4)
self.effectBg=UIObject.get(self,5)
self.effectTip=UIText.get(self,6)
self.buyBtn=UIButton.get(self,7)
self.buyBtnTxt=UIText.get(self,8)
self.cnt=UIText.get(self,9)
self.RewardLists=UIObject.get(self,10)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)



end


function UISubAct_zhaozhitehui_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.titleImgae);self.titleImgae=nil;
_UIObject_release(self.lefttime);self.lefttime=nil;
_UIObject_release(self.effectBg);self.effectBg=nil;
_UIObject_release(self.effectTip);self.effectTip=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.buyBtnTxt);self.buyBtnTxt=nil;
_UIObject_release(self.cnt);self.cnt=nil;
_UIObject_release(self.RewardLists);self.RewardLists=nil;
end















local abname="ui/windows/activities/sub_chaozhitehui/chaozhitehui_atlas_pak.ab"
local cmpIndex={
itemSmall=0,
selectItem=1,
addRoot=2,
clickMask=3,
changeBtn=4,
reddot=5,
zxBg=6
}



function UISubAct_zhaozhitehui_Win:onLoaded(...)
self:bindComponents()
self.modelBg:setChildUIModelShowTarget(6262,1,{},0)
end


function UISubAct_zhaozhitehui_Win:__delete()
self:stopCDTick()
self:unbindComponents()
end




function UISubAct_zhaozhitehui_Win:onShow(argtable,afterOnloaded)
self.actID=argtable and argtable.act_id or nil
self.subType=argtable and argtable.sub_act_type or nil
self.subid=argtable and argtable.sub_act_id or nil

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self:init()
self:refresh()
end


function UISubAct_zhaozhitehui_Win:onHide()
self:stopCDTick()
end

function UISubAct_zhaozhitehui_Win:onShowArgRecv(argtable)
self:onShow(argtable)
end


function UISubAct_zhaozhitehui_Win:init()

self.titleImgae:setCSImageSprite(abname,self.config.titleImgae)

self:startCDTick()

end

function UISubAct_zhaozhitehui_Win:refresh()
local rechargeIndex=self:getRechargeIndex()
local buyedTime=self:getBuyCnt()
local buyCfg=self.config.buyCfg
local curBuyCfg=buyCfg[rechargeIndex]

local rechargeId=curBuyCfg[1]
local limtCnt=curBuyCfg[2]
local itemList=curBuyCfg[3]
local effect=curBuyCfg[4]
self.effectTip:setText(FMT.fmt("{0}%收益",effect))
self.cnt:setText(FMT.fmt("限购：{0}",limtCnt-buyedTime))

local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.buyBtnTxt:setText(FMT.fmt("{0}购买",str))

self.RewardLists:setChildLayoutGroupCreateItems(#itemList)
local gridlist=self.RewardLists:getChildLayoutGroupGridList()
local count=gridlist.Count
local sortItemList=table.deepCopy(itemList)
for i,v in ipairs(sortItemList)do
v.itemListIndex=i
local isSelectFlag=#v>1
v.isSelectFlag=isSelectFlag
local sort=isSelectFlag and 100 or 0
v.sort=sort+i
end
table.sort(sortItemList,function(a,b)
return a.sort<b.sort
end)
local lineZxBgFlagList={}
local lineCnt=3
for i=1,count do
local widget=gridlist[i-1]
local data=sortItemList[i]
local isSelectFlag=data.isSelectFlag
local itemListIndex=data.itemListIndex
local selectedIndex=self:getSelectIndex(rechargeIndex,itemListIndex)
local selectIndex=isSelectFlag and selectedIndex or 1
local reward=data[selectIndex]
widget:SetChildActive(cmpIndex.selectItem,true)
widget:SetChildActive(cmpIndex.clickMask,isSelectFlag)
if isSelectFlag then
widget:SetChildButtonClick(cmpIndex.clickMask,function()
self:openSelectWin(itemListIndex)
end)
local line=math.ceil(i/lineCnt)
local lastEndIndex=(line-1)*lineCnt
local curEndIndex=line*lineCnt
if i>lastEndIndex and i<=curEndIndex and not lineZxBgFlagList[line]then
lineZxBgFlagList[line]=true
widget:SetChildActive(cmpIndex.zxBg,true)
if curEndIndex>count then
curEndIndex=count
end
local c=curEndIndex-i+1
local x=c*90+6
widget:SetChildSizeDelta(cmpIndex.zxBg,x,96)
end
end
widget:SetChildActive(cmpIndex.changeBtn,isSelectFlag and reward~=nil)
widget:SetChildActive(cmpIndex.itemSmall,reward~=nil)
widget:SetChildActive(cmpIndex.addRoot,reward==nil)
if reward then
local itemid=reward[1]
local itemCount=reward[2]
local countStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(cmpIndex.itemSmall,prop)
widget:SetBaseItemClickEvent(cmpIndex.itemSmall,function(...)
itemsComponentHelper.onItemClickEx(...)
end)
end
end
end

function UISubAct_zhaozhitehui_Win:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_zhaozhitehui_Win:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_zhaozhitehui_Win:updateCDTick()
local leftTime=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subid)
self.lefttime:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(leftTime)))
end

function UISubAct_zhaozhitehui_Win:openSelectWin(index)
local rechargeIndex=self:getRechargeIndex()
local buyCfg=self.config.buyCfg
local curBuyCfg=buyCfg[rechargeIndex]
local itemList=curBuyCfg[3]
local allSelectList={}
local selectedIndexList={}
local selectIdx
local itemListIndexlookup={}
for itemListIndex,v in ipairs(itemList)do
if#v>1 then
table.insert(allSelectList,v)
local selectedIndex=self:getSelectIndex(rechargeIndex,itemListIndex)
table.insert(selectedIndexList,selectedIndex)
table.insert(itemListIndexlookup,itemListIndex)
if itemListIndex==index then
selectIdx=#allSelectList
end
end
end

local args={}
args.allSelectList=allSelectList
args.selectedIndexList=selectedIndexList
args.selectIdx=selectIdx
args.name=self.config.giftname
args.selectedIndexList=selectedIndexList
args.selectIdx=selectIdx
args.extraParams={rechargeIndex,itemListIndexlookup}
args.submitCallFunc=function(allSelectList,selectedIndexList,extraParams)
if not self or self.isClose then return end
local rechargeIndex=extraParams[1]
local itemListIndexlookup=extraParams[2]
for i,itemListIndex in ipairs(itemListIndexlookup)do
local selectedIndex=selectedIndexList[i]

self.sub_actInfo:setSelectIndex(rechargeIndex,itemListIndex,selectedIndex)
end
self:refresh()
end

self:showWindow("UISelectItemWin",args)

end

function UISubAct_zhaozhitehui_Win:getSelectIndex(rechargeIndex,itemListIndex)
return self.sub_actInfo:getSelectIndex(rechargeIndex,itemListIndex)
end

function UISubAct_zhaozhitehui_Win:getRechargeIndex()

return self.sub_actInfo:getRechargeIndex()
end

function UISubAct_zhaozhitehui_Win:getBuyCnt()
return self.sub_actInfo:getBuyCnt()
end







function UISubAct_zhaozhitehui_Win:onBuyBtn()
local rechargeIndex=self:getRechargeIndex()
local buyedTime=self:getBuyCnt()
local buyCfg=self.config.buyCfg
local curBuyCfg=buyCfg[rechargeIndex]
if not curBuyCfg then
UIManager.error('已售罄')
return
end
local rechargeId=curBuyCfg[1]
local limtCnt=curBuyCfg[2]
local itemList=curBuyCfg[3]
local canBuyCnt=limtCnt-buyedTime
if canBuyCnt<=0 then
UIManager.error('已售罄')
return
end
local info={}
local rewards={}
for itemListIndex,v in ipairs(itemList)do
local selectedIndex=1
if#v>1 then
selectedIndex=self:getSelectIndex(rechargeIndex,itemListIndex)
if not selectedIndex or selectedIndex==0 then
UIManager.error('还未选择道具')
return
end
end
info[itemListIndex]=selectedIndex
rewards[itemListIndex]=v[selectedIndex]
end
local name=self.config.giftname

local rechargeAmount=payControl:getRechargeAmount(rechargeId)
local twoTimeCostNum=rechargeAmount*2
local titemid,voucherCount=payControl.getVoucherId(twoTimeCostNum)
local actID,subType,subid=self.actID,self.subType,self.subid
local params=payControl.getActivityPayParams(actID,subType,subid,info)
local buyFunc=function(count,useItem)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if not sub_actInfo:checkDoing()then
UIManager.error('活动已结束')
return
end
if useItem then
local pram=jsonHelper.encode({rechargeId,params})
bagProtocolControl.req_1_21(titemid,count*rechargeAmount,pram)
else
payControl.reqPay(rechargeId,1,params)
end
end


if canBuyCnt==1 or voucherCount<twoTimeCostNum then
buyFunc(1,false)
else

local args={
rewards=rewards,
name=name,
price={titemid,rechargeAmount},
leftNum=buyedTime,
maxcount=limtCnt,
isCheckMaxSelectCount=true,
callback=function(num)
buyFunc(num,true)
end
}
self:showWindow("UICommonBuyDialogWin",args)
end
end


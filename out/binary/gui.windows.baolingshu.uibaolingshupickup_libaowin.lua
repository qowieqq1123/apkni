







def_class("UIBaoLingShuPickUp_LiBaoWin",UIWindowBase)









function UIBaoLingShuPickUp_LiBaoWin:bindComponents()

self.pickUpTime=UIText.get(self,0)
self.libaoList=UIObject.get(self,1)
self.Content=UIObject.get(self,2)
self.bgModel=UIObject.get(self,3)
self.frontModel=UIObject.get(self,4)



end


function UIBaoLingShuPickUp_LiBaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.pickUpTime);self.pickUpTime=nil;
_UIObject_release(self.libaoList);self.libaoList=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.frontModel);self.frontModel=nil;
end
















local libaoItemIndex={
buyBtn=0,
buyBtnText=1,
buyBtnRedot=2,
limitCountText=3,
sellOutFlag=4,
name=5,
bg=6,
layout1=7,
layout2=8,
}

local libaoBgNameList={
[0]="image_xuyuanlibaoui_1",
[1]="image_xuyuanlibaoui_2",
[2]="image_xuyuanlibaoui_3",
}

local _this



function UIBaoLingShuPickUp_LiBaoWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIBaoLingShuPickUp_LiBaoWin:__delete()
self:clearTimer()
self:unbindComponents()
_this=nil
end




function UIBaoLingShuPickUp_LiBaoWin:onShow(argtable,afterOnloaded)
self.allLiBaoCfg=cfg_baolingtreelibaoconfig()


local isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
if not isInPickUpNow then
UIManager.error("本期许愿礼包已结束")
UIFullBaoLingShuControl:closeBaoLingShuPickUpWindow()
return
end
if afterOnloaded then
if webGLHelper:isRunWebGL()then
local abName=webGLHelper:getReplaceResourceAB('baoLingShuLiBaoBG')
self.bgModel:setSprite(abName[1],abName[2])
else

self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),4856,1,{},eAnimationID.stand)
end

self.winlua:SetChildUIModelShowTarget(self.frontModel:getID(),4857,1,{},eAnimationID.stand)
end

local sTime,eTime,nsTime=baoLingShuModel:getGBPickUpTime()
self.endTime=eTime

self:refresh(afterOnloaded)
end


function UIBaoLingShuPickUp_LiBaoWin:onHide()
self:clearTimer()
self.libaoList:setActive(false)
end

function UIBaoLingShuPickUp_LiBaoWin:refresh(isInit)
if isInit then
self:sortLiBaoCfgList()
end

local count=#self.liBaoCfgSortList
self.libaoList:setChildScrollViewCreateGrids(count,count)

local grids=self.libaoList:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshLiBaoItem(grids[i-1],i)

end
self.libaoList:setActive(true)


self:setRemainingTimeTimer()
end

function UIBaoLingShuPickUp_LiBaoWin:sortLiBaoCfgList()
self.liBaoCfgSortList={}
for i,v in ipairs(self.allLiBaoCfg)do
local isFree=v.buyType==nil
local libaoId=v.id
local buyNum=baoLingShuModel:getBLSPickUpLiBaoBuyNum(libaoId)or 0
local limitCount=v.buyNum
local isSellOut=buyNum>=limitCount
local sortId=v.sortId
local sortWeight=sortId
if isFree then
sortWeight=sortWeight-1000
end

if isSellOut then
sortWeight=sortWeight+10000
end
table.insert(self.liBaoCfgSortList,{id=libaoId,sortWeight=sortWeight,cfg=v})
end
table.sort(self.liBaoCfgSortList,function(a,b)return a.sortWeight<b.sortWeight end)
end


function UIBaoLingShuPickUp_LiBaoWin:refreshLiBaoItem(item,index)
if item==nil then
item=self.libaoList:getChildScrollViewItemWidget(index-1)
end


local libaoData=self.liBaoCfgSortList[index]
if item and libaoData then
local cfg=libaoData.cfg
local libaoId=libaoData.id

local libaoName=cfg.name
item:SetChildText(libaoItemIndex.name,libaoName)


local limitCount=cfg.buyNum
local buyNum=baoLingShuModel:getBLSPickUpLiBaoBuyNum(libaoId)or 0
local isSellOut=buyNum>=limitCount
if isSellOut or not limitCount then

item:SetChildActive(libaoItemIndex.limitCountText,false)
else

item:SetChildActive(libaoItemIndex.limitCountText,true)
local deltaCount=limitCount-buyNum
item:SetChildText(libaoItemIndex.limitCountText,FMT.fmt("限购次数：{0}",deltaCount))
end


item:SetChildActive(libaoItemIndex.buyBtn,not isSellOut)
local isFree=cfg.buyType==nil
local buyType=isFree and 0 or cfg.buyType[1]
if not isSellOut then
item:SetChildButtonClick(libaoItemIndex.buyBtn,function()
_this:onClickBuyBtn(libaoId)
end)
item:SetChildActive(libaoItemIndex.buyBtnRedot,isFree)

local contentStr
if buyType==0 then

contentStr="免费领取"
elseif buyType==1 then

local itemid=cfg.buyType[2]
local itemnum=cfg.buyType[3]
local iconname=iconHelper.getIconName(itemid)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,32)
contentStr=FMT.fmt("  {0}{1}",itemnum,iconStr)
elseif buyType==2 then

local rechargeIdList=cfg.buyType[2]
local singleRechargeId=rechargeIdList[1]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,singleRechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
contentStr=str
end
item:SetChildText(libaoItemIndex.buyBtnText,contentStr)
end


local abName="ui/windows/baolingshu/baolingshu_wish_atlas_pak.ab"
local bgImageName=libaoBgNameList[buyType]
if bgImageName then
item:SetChildCSImageSprite(libaoItemIndex.bg,abName,bgImageName)
end


item:SetChildActive(libaoItemIndex.sellOutFlag,isSellOut)


local rewards=cfg.items
local grids_up=item:GetChildCommonLayoutGroupWidgetList(libaoItemIndex.layout1)
local grids_down=item:GetChildCommonLayoutGroupWidgetList(libaoItemIndex.layout2)
local rewardCount=#rewards
item:SetChildActive(libaoItemIndex.layout2,rewardCount>2)
local gridIdxList=self:getGridIndexList(rewardCount)
local gridCount=grids_up.Count+grids_down.Count
for i=1,gridCount do
local widget
local gridIdx=gridIdxList[i]
if gridIdx<=grids_up.Count then
widget=grids_up[gridIdx-1]
else
widget=grids_down[gridIdx-grids_up.Count-1]
end
local reward=rewards[i]
if reward then
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
widget:SetChildActive(-1,false)
end
end
end
end

function UIBaoLingShuPickUp_LiBaoWin:getGridIndexList(count)
if count==3 then
return{1,2,4,5,3,6}
elseif count==4 then
return{1,2,4,5,3,6}
else
return{1,2,3,4,5,6}
end
end

function UIBaoLingShuPickUp_LiBaoWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=timeHelper.getServerLongTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.pickUpTime:setText(FMT.fmt("重置时间：{0}",timeHelper.format_time_stamp11(lerp,true)))

else
self.pickUpTime:setText("活动已结束")
UIManager.error("本期许愿礼包已结束")
self:clearTimer()

return UIFullBaoLingShuControl:closeBaoLingShuPickUpWindow()
end
end
func()
self.timer=self:setTimer(1,0,func)
end



function UIBaoLingShuPickUp_LiBaoWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UIBaoLingShuPickUp_LiBaoWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end
function UIBaoLingShuPickUp_LiBaoWin:onClickBuyBtn(libaoId)
local cfg=self.allLiBaoCfg[libaoId]
if not cfg then
return
end

local isFree=cfg.buyType==nil
local buyType=isFree and 0 or cfg.buyType[1]
local limitCount=cfg.buyNum
local buyNum=baoLingShuModel:getBLSPickUpLiBaoBuyNum(libaoId)or 0
local maxBuyNum=limitCount-buyNum
local libaoName=cfg.name or"礼包"
if maxBuyNum<0 then
UIManager.error("该礼包已达到获取上限")
return
end
if buyType==0 then

baoLingShuController:req_getOrBuyBLSPickUpLiBaoReward(libaoId,maxBuyNum)
elseif buyType==1 then

local showItem=cfg.items
local buyCostType=cfg.buyType[2]
local buyCostVal=cfg.buyType[3]
UIManager:showWindow("UICommonBuyDialogWin",{rewards=showItem,name=libaoName,price={buyCostType,buyCostVal},leftNum=buyNum,maxcount=limitCount,callback=function(num)
if not baoLingShuModel:checkIsInPickUpNow()then
UIManager.error("本期许愿礼包已结束")
return
end
baoLingShuController:req_getOrBuyBLSPickUpLiBaoReward(libaoId,num)
end})
elseif buyType==2 then

local rechargeIdList=cfg.buyType[2]

if UIBaoLingShuPickUp_LiBaoWin:checkplatform()or pfwindowslController:checkIsGameVersion_yuenan()then
local rechargeId=rechargeIdList[1]
local param=FMT.fmt('{0}-{1}',libaoId,1)
payControl.reqPay(rechargeId,1,param)
else
local batchBuyFixedNum=pfwindowslController:checkPFWinState_ByWinType_DfShow(pfwindowslController.winType.batchBuyFixedNum)
if batchBuyFixedNum then
local buyFunc=function(num)
if not baoLingShuModel:checkIsInPickUpNow()then
UIManager.error("本期许愿礼包已结束")
return
end

local rechargeId=rechargeIdList[num]
local param=FMT.fmt('{0}-{1}',libaoId,num)
payControl.reqPay(rechargeId,1,param)
end
if maxBuyNum>=10 and rechargeIdList[10]then
local refresh=function(num)
local rechargeId=rechargeIdList[num]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
local contentStr=FMT.fmt('是否花费{0}购买该礼包？',str)
return contentStr
end
local args={
name=libaoName,
refreshCallback=refresh,
leftNum=0,
maxcount=2,
numArray={1,10},
isCheckMaxSelectCount=true,
callback=function(num)
buyFunc(num)
end,
}
UIManager:showWindow("UIFBuyFixedNumDialogWin",args)
else
buyFunc(1)
end
else


local refresh=function(num)
local rechargeId=rechargeIdList[num]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
local contentStr=FMT.fmt('是否花费{0}购买该礼包？',str)
return contentStr
end
local showdata=
{
type='UIDialougeBuyCount',
title=libaoName,
refreshcallback=refresh,
canceltext='取消',
oktext='购买',
max=maxBuyNum,
okcallback=function(num)
if not baoLingShuModel:checkIsInPickUpNow()then
UIManager.error("本期许愿礼包已结束")
return
end

local rechargeId=rechargeIdList[num]
local param=FMT.fmt('{0}-{1}',libaoId,num)
payControl.reqPay(rechargeId,1,param)
end,

showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end
end
end


function UIBaoLingShuPickUp_LiBaoWin:checkplatform()

return deviceHelper.isRunIOS()or webGLHelper:isRunMiniGame()
end


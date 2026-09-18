







def_class("UITianmingzengliSysWin",UIWindowBase)









function UITianmingzengliSysWin:bindComponents()

self.libaoScroller=UIObject.get(self,0)
self.timeText=UIText.get(self,1)
self.dzmodel=UIObject.get(self,2)
self.upTianMing=UIButton.get(self,3)
self.TipsWin=UIObject.get(self,4)
self.tipsText=UIImage.get(self,5)
self.tipsRewardScroller=UIObject.get(self,6)
self.BtnGoTo=UIButton.get(self,7)
self.BtnClose=UIButton.get(self,8)
self.dzListScrollView=UIObject.get(self,9)
self.dzListPanel=UIObject.get(self,10)
self.layout=UIObject.get(self,11)

self.upTianMing:setButtonClick(function()self:onUpTianMing()end)

self.BtnGoTo:setButtonClick(function()self:onBtnGoTo()end)

self.BtnClose:setButtonClick(function()self:onBtnClose()end)



end


function UITianmingzengliSysWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.libaoScroller);self.libaoScroller=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.dzmodel);self.dzmodel=nil;
_UIObject_release(self.upTianMing);self.upTianMing=nil;
_UIObject_release(self.TipsWin);self.TipsWin=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.tipsRewardScroller);self.tipsRewardScroller=nil;
_UIObject_release(self.BtnGoTo);self.BtnGoTo=nil;
_UIObject_release(self.BtnClose);self.BtnClose=nil;
_UIObject_release(self.dzListScrollView);self.dzListScrollView=nil;
_UIObject_release(self.dzListPanel);self.dzListPanel=nil;
_UIObject_release(self.layout);self.layout=nil;
end















local dzItemIndex={
head=0,
btnClick=1,
select=2,
reddot=3,
tianmingGrid=4,
tianmingBg=5,
headIcon=6,
}
local libaoItemIndex={
rewards_free=0,
rewards_buy=1,
freeBtn=2,
buyBtn=3,
buyBtnText=4,
limitCountText=5,
gotMask=6,
selloutMask=7,
rebate=8,
rebateText=9,
dzBg=10,
dzHead=11,
dzMask=12,
dzLock=13,
tianmingGrid=14,
freeBtnReddot=15,
limitCountBg=16,
dzPanel=17,
skillPanel=18,
skillIcon=19,
skillLock=20,
}

local abname="ui/windows/recharge/dailytehuisingleday_atlas_pak.ab"



function UITianmingzengliSysWin:onLoaded(...)
self:bindComponents()
end


function UITianmingzengliSysWin:__delete()
tianmingzengliController:tryUpdateListDataAndEnter()
self:unbindComponents()
end




function UITianmingzengliSysWin:onShow(argtable,afterOnloaded)

self.tempDzData={}
self.selectDzId=argtable and argtable.dzId
self.selectPageIndex=1

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
if argtable.extraParams and argtable.extraParams.dzId then
self.selectDzId=argtable.extraParams.dzId
end
end
if not self.selectDzId then

self.selectFristReddotDz=true
end


local winWidth=self.layout:getChildRectWidth()
if winWidth>1624 then
winWidth=1624
end
self.scrollViewMaxSize=winWidth/2-222
self.widget:SetChildScrollViewAutoSizeOption(self.dzListScrollView:getID(),true,self.scrollViewMaxSize)


self:refresh(true)


self:checkShowTipsWin()
end


function UITianmingzengliSysWin:onHide()
self.dzListScrollView:setActive(false)
end

function UITianmingzengliSysWin:checkShowTipsWin()
local dzItemData=self.sortShowItemList[self.selectPageIndex]
local dzId=dzItemData.id
self.gearPos=self:getUnlockPos(dzId)
local flag,pos,txetcfg,rewardCfg=self:judgeIsUnlock()
if flag then
self.gearPos=pos
self:setUnlockPos(pos,dzId)
self:refreshTipsWin(pos,txetcfg)
self:setTipsReward(rewardCfg)
else
self.winlua:SetChildActive(self.TipsWin:getID(),false)
end
end

function UITianmingzengliSysWin:refresh(isInit,dzId)

self:refreshDiZiListPanel(isInit)


local index
if dzId then
index=self:findPageIndexByDzId(dzId)
end
if not dzId or index==self.selectPageIndex then
self:refreshPage()
end
end

function UITianmingzengliSysWin:findPageIndexByDzId(dzId)
if dzId then

for i,v in ipairs(self.sortShowItemList)do
if v.id==dzId then
return i
end
end
end
end

function UITianmingzengliSysWin:refreshPage()

self:refreshDzModel()


self:refreshLibaoList()
end

function UITianmingzengliSysWin:refreshDiZiListPanel(isInit)
local showItemList=tianmingzengliModel:getTMZLShowItemList()or{}
self.sortShowItemList=self:sortShowList(showItemList)
if self.selectFristReddotDz then
self.selectFristReddotDz=false
for i,v in ipairs(self.sortShowItemList)do
local dzId=v.id
local reddot=tianmingzengliModel:getTMZLDzReddot(dzId)
if reddot then
self.selectDzId=dzId
break
end
end
end

local isNeedJump=isInit or false
if self.selectDzId then
local pageIndex=self:findPageIndexByDzId(self.selectDzId)
if pageIndex then
self.selectPageIndex=pageIndex
isNeedJump=true
end
self.selectDzId=nil
elseif isInit then
self.selectPageIndex=#self.sortShowItemList
end

local count=#self.sortShowItemList


local scrollViewSize=count*135+15
local isEnable=true
if scrollViewSize<self.scrollViewMaxSize then
isEnable=false
end
self.dzListScrollView:setActive(true)
self.dzListScrollView:setChildScrollViewCreateGrids(count,count)
local grids=self.dzListScrollView:getChildScrollViewItemWidgets()
for i=1,count do
local itemIndex=i
local widget=grids[itemIndex-1]
local dzItemData=self.sortShowItemList[i]
local dzId=dzItemData.id
local dzData=self:getDiscipleData(dzId)
local discipleguid



local cfg=dzItemData.cfg or{}
if cfg.dzHeadIcon then
local headIconName=cfg.dzHeadIcon[dzData.id]
if not headIconName then
headIconName=cfg.dzHeadIcon[-1]
end

local abName="ui/windows/tianmingzengli/newtianmingzengli_headicon_atlas_pak.ab"
widget:SetChildCSImageSprite(dzItemIndex.headIcon,abName,headIconName)
widget:SetChildActive(dzItemIndex.headIcon,true)
widget:SetChildActive(dzItemIndex.head,false)
else

local modelParams
if dzData.discipleguid then
discipleguid=dzData.discipleguid
modelParams=UIDiscipleModel:getDiscipleInsideModelInfo(discipleguid)
else
modelParams=UIDiscipleModel:getDiscipleInsideModelInfoEx(dzData)
end
modelParams.anim=0
comHelper.setChildModelRawImageEx(dzItemIndex.head,widget,modelParams,eHeadCenterType.eHead)

widget:SetChildActive(dzItemIndex.headIcon,false)
widget:SetChildActive(dzItemIndex.head,true)
end


widget:SetChildButtonClick(dzItemIndex.btnClick,function()
self:selectPage(i)
end)


local isSelect=self.selectPageIndex==i
widget:SetChildActive(dzItemIndex.select,isSelect)


local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)
local dzInfo=dzData.imageInfo
if dzInfo then

local chong=UIDiscipleModel.getTianMingLevelChong(dzNowTmLv)
local floor=UIDiscipleModel.getTianMingLevelFloor(dzNowTmLv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
local createCount=chong
if createCount<1 then
createCount=1
end
widget:SetChildLayoutGroupCreateItems(dzItemIndex.tianmingGrid,createCount)
local tmGrids=widget:GetChildLayoutGroupGridList(dzItemIndex.tianmingGrid)
for i=1,createCount do
local fireItem=tmGrids[i-1]
fireItem:SetChildCSImageSprite(0,abName,iconName)
end
widget:SetChildActive(dzItemIndex.tianmingBg,createCount>0)
end


local reddot=tianmingzengliModel:getTMZLDzReddot(dzId)
widget:SetChildActive(dzItemIndex.reddot,reddot)
end

if isNeedJump then

local jumpIndex=self.selectPageIndex-1
self.dzListScrollView:setChildScrollViewSelectItem(jumpIndex,false,false,true)
end
self.dzListScrollView:setChildScrollRectEnable(isEnable)
end


function UITianmingzengliSysWin:testJump(index)
self.dzListScrollView:setChildScrollViewSelectItem(index,false,false,true)
end

function UITianmingzengliSysWin:selectPage(index)
if self.selectPageIndex==index then
return
end

self.selectPageIndex=index
self:refresh()


self:checkShowTipsWin()
end

function UITianmingzengliSysWin:refreshDzModel()
local cfg=self.sortShowItemList[self.selectPageIndex].cfg
local dzModelParam=cfg.dzModelParam
if not dzModelParam or not next(dzModelParam)then
logErr("天命赠礼找不到弟子展示模型参数数据 请检查配置是否正确")
return
end

local dzId=dzModelParam.dzId
if dzId==self.initDzModelId then

return
end

local modelId=dzModelParam.modelId
local scale=dzModelParam.scale or 1
local offset=dzModelParam.offset or{0,0}
local animId=dzModelParam.animId or eAnimationID.stand

local dzData=self:getDiscipleData(dzId)
if modelId then

self.dzmodel:setChildUIModelShowTarget(modelId,scale,{},animId)
self.dzmodel:setChildUIModelShowTargetOffset(offset[1],offset[2])
end

if not dzData.discipleguid and not dzData.hasFixedImage then

logErr(FMT.fmt("对应的弟子id: {0} 没有配置固定组件库 无法加载形象",dzId))
return
end

local info=dzData.imageInfo
if info then


self.dzmodel:setChildUIModelRemoveTarget()

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info)
self.dzmodel:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,animId)
self.dzmodel:setChildUIModelShowTargetOffset(offset[1],offset[2])
end

self.initDzModelId=dzId
end


function UITianmingzengliSysWin:sortShowList(showList)
local sortList={}
for i,v in ipairs(showList)do
local dzId=v.id
local cfg=cfgHelper.get(cfg_tianmingzengliconfig_get,dzId)
if cfg then
local data={
id=dzId,
data=v.data,
sortId=cfg.sortId,
cfg=cfg,
}
table.insert(sortList,data)
end
end


table.sort(sortList,function(a,b)
return a.sortId<b.sortId
end)

return sortList
end


function UITianmingzengliSysWin:sortLibaoList()
local dzItemData=self.sortShowItemList[self.selectPageIndex]
local cfg=dzItemData.cfg
local dzId=dzItemData.id
local unLockCfg=cfg.unLockLimit
local libaoCfgList=cfg.rewards
self.libaoList_sort={}
for i=1,#libaoCfgList do
local libaoId=i
local libaoCfg=libaoCfgList[libaoId]
local libaoData={}
libaoData.id=libaoId
libaoData.cfg=libaoCfg
libaoData.sortWeight=libaoId

local isGotAndBuyAll=false
local isGot=tianmingzengliModel:checkTMZLFreeLibaoIsGot(dzId,libaoId)
local isSellOut=false
local buyLimitCount=libaoCfg[5]
local nowBuyCount=tianmingzengliModel:getTMZLLibaoBuyCount(dzId,libaoId)
if buyLimitCount and nowBuyCount>=buyLimitCount then
isSellOut=true
end
isGotAndBuyAll=isGot and isSellOut

if isGotAndBuyAll then
libaoData.sortWeight=libaoData.sortWeight+1000
end


if unLockCfg and unLockCfg[i]and unLockCfg[i][1]then
local dzId=dzItemData.id
local index=unLockCfg[i][1]
local targetTianmingLv=libaoCfgList[index][1]
local dzData=self:getDiscipleData(dzId)
local hasDz=dzData.discipleguid~=nil
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)

if hasDz and dzNowTmLv>=targetTianmingLv then
table.insert(self.libaoList_sort,libaoData)
end
else
table.insert(self.libaoList_sort,libaoData)
end
end


table.sort(self.libaoList_sort,function(a,b)
return a.sortWeight<b.sortWeight
end)
end

function UITianmingzengliSysWin:goToNewGear()
self:closeTips()
self.libaoScroller:setChildScrollViewSelectItem(self.gearPos-1)
end

function UITianmingzengliSysWin:refreshTipsWin(pos,text)
self.winlua:SetChildActive(self.TipsWin:getID(),true)
self.winlua:SetChildCSImageSprite(self.tipsText:getID(),abname,text)
end

function UITianmingzengliSysWin:closeTips()
self.winlua:SetChildActive(self.TipsWin:getID(),false)
end

function UITianmingzengliSysWin:setUnlockPos(pos,dzId)
tianmingzengliModel:setTMZLLastUnlockPos(dzId,pos)
end

function UITianmingzengliSysWin:getUnlockPos(dzId)
local pos=tianmingzengliModel:getTMZLLastUnlockPos(dzId)
return pos
end

function UITianmingzengliSysWin:judgeIsUnlock()

local flag=false
local pos=nil
local textCfg=nil
local rewardCfg=nil

local index=self.gearPos
if not index then index=0 end

local dzItemData=self.sortShowItemList[self.selectPageIndex]
local cfg=dzItemData.cfg
local unLockCfg=cfg.unLockLimit
local isShowCfg=cfg.unLockShow

local libaoCfgList=cfg.rewards
local libaoCfg=libaoCfgList[1]
local dzId=dzItemData.id
local dzData=self:getDiscipleData(dzId)
local hasDz=dzData.discipleguid~=nil
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)

if hasDz and unLockCfg then

for k=index+1,#unLockCfg do

if unLockCfg[k][1]then
libaoCfg=libaoCfgList[unLockCfg[k][1]]
local limitLv=libaoCfg[1]

if dzNowTmLv>=limitLv then

if isShowCfg[k][1]then
flag=true
pos=k
textCfg=isShowCfg[k][2]
rewardCfg=isShowCfg[k][3]

end
end
end
end
end
return flag,pos,textCfg,rewardCfg
end

function UITianmingzengliSysWin:refreshLibaoList()

self:sortLibaoList()

local dzItemData=self.sortShowItemList[self.selectPageIndex]
local cfg=dzItemData.cfg
local dzId=dzItemData.id
local libaoList=self.libaoList_sort
local yieldRateCfg=cfg.yieldRate or{}
local count=#libaoList
self.libaoScroller:setChildScrollViewCreateGrids(count,1)
local grids=self.libaoScroller:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local libaoData=libaoList[i]
local libaoId=libaoData.id
if libaoData then
local libaoCfg=libaoData.cfg

local targetTianmingLv=libaoCfg[1]
local freeRewards=libaoCfg[2]
local buyRewards=libaoCfg[3]
local buyLibaoRechargeId=libaoCfg[4]
local buyLimitCount=libaoCfg[5]
local isResetBuyDaily=libaoCfg[6]and libaoCfg[6]==1


local dzData=self:getDiscipleData(dzId)
local dzInfo=dzData.imageInfo
local hasDz=dzData.discipleguid~=nil
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)
local openLibao=hasDz and dzNowTmLv>=targetTianmingLv or false
if dzInfo then

local chong=UIDiscipleModel.getTianMingLevelChong(targetTianmingLv)
local floor=UIDiscipleModel.getTianMingLevelFloor(targetTianmingLv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
local createCount=chong
if createCount<1 then
createCount=1
end
widget:SetChildLayoutGroupCreateItems(libaoItemIndex.tianmingGrid,createCount)
local tmGrids=widget:GetChildLayoutGroupGridList(libaoItemIndex.tianmingGrid)
for i=1,createCount do
local fireItem=tmGrids[i-1]
fireItem:SetChildCSImageSprite(0,abName,iconName)
end

if floor>0 and chong==1 then

widget:SetChildActive(libaoItemIndex.dzPanel,false)
widget:SetChildActive(libaoItemIndex.skillPanel,true)
self:setLiBaoDiziTianMingSkillItem(widget,dzData,openLibao,targetTianmingLv)
else

widget:SetChildActive(libaoItemIndex.dzPanel,true)
widget:SetChildActive(libaoItemIndex.skillPanel,false)
self:setLiBaoDiziHeadItem(widget,dzData,openLibao,targetTianmingLv)
end

end


self:setRewardShow(freeRewards,widget,libaoItemIndex.rewards_free)

local isGot=tianmingzengliModel:checkTMZLFreeLibaoIsGot(dzId,libaoId)
widget:SetChildActive(libaoItemIndex.gotMask,isGot)

widget:SetChildActive(libaoItemIndex.freeBtn,not isGot)
if not isGot then

widget:SetChildButtonClick(libaoItemIndex.freeBtn,function()
self:onLibaoFreeBtn(dzId,libaoId)
end)
end

widget:SetChildActive(libaoItemIndex.freeBtnReddot,openLibao and not isGot)


self:setRewardShow(buyRewards,widget,libaoItemIndex.rewards_buy)

local nowBuyCount=tianmingzengliModel:getTMZLLibaoBuyCount(dzId,libaoId)
local isSellOut=false
if buyLimitCount then
local remainingBuyCount=buyLimitCount-nowBuyCount
if remainingBuyCount<=0 then
remainingBuyCount=0
isSellOut=true
end
widget:SetChildText(libaoItemIndex.limitCountText,FMT.fmt("限:{0}次",remainingBuyCount))
end
widget:SetChildActive(libaoItemIndex.limitCountBg,buyLimitCount~=nil and not isSellOut)


widget:SetChildActive(libaoItemIndex.selloutMask,isSellOut)

widget:SetChildActive(libaoItemIndex.buyBtn,not isSellOut)
if not isSellOut then

widget:SetChildButtonClick(libaoItemIndex.buyBtn,function()
self:onLibaoBuyBtn(dzId,libaoId)
end)


local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,buyLibaoRechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
widget:SetChildText(libaoItemIndex.buyBtnText,str)
end


local rate=yieldRateCfg[libaoId]
if rate then

widget:SetChildText(libaoItemIndex.rebateText,FMT.fmt("{0}%",rate))
widget:SetChildActive(libaoItemIndex.rebate,true)
else

widget:SetChildActive(libaoItemIndex.rebate,false)
end
end
end
end


function UITianmingzengliSysWin:setLiBaoDiziHeadItem(widget,dzData,openLibao,tmLevel)
local dzInfo=dzData.imageInfo
local dzName=dzData.disciplename
local tmLv_str=UIDiscipleModel.getTianMingLevelDesc(tmLevel,1)


local color=dzInfo.color
comHelper.setChildModelHeadIconBGByColor(widget,libaoItemIndex.dzBg,color)


local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoEx(dzData)
local headCenterType=1
local size=1
comHelper.setChildModelRawImageEx(libaoItemIndex.dzHead,widget,modelParams,headCenterType,size)


widget:SetChildActive(libaoItemIndex.dzMask,not openLibao)
widget:SetChildActive(libaoItemIndex.dzLock,not openLibao)
if not openLibao then

widget:SetChildButtonClick(libaoItemIndex.dzMask,function()
local tipsStr=FMT.fmt("弟子“{0}”{1}可解锁",dzName,tmLv_str)
UIManager.error(tipsStr)
end)
end
end


function UITianmingzengliSysWin:setLiBaoDiziTianMingSkillItem(widget,dzData,openLibao,tmLevel)
local dzInfo=dzData.imageInfo
local dzName=dzData.disciplename
local tmLv_str=UIDiscipleModel.getTianMingLevelDesc(tmLevel,1)
local dzJobId=dzInfo.job
local floor=UIDiscipleModel.getTianMingLevelFloor(tmLevel)
local tmId=dzData.tmList[floor+1]
local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmId or 0)
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)


local skillIconId=UIDiscipleModel.getTianMingSkillIconId(tmCfg,dzJobId,dzData)
local skillIconName=iconHelper.getSkillIcon(skillIconId)
widget:SetChildCSImageIcon(libaoItemIndex.skillIcon,skillIconName)
widget:SetChildImageExGray(libaoItemIndex.skillIcon,not openLibao)


widget:SetChildActive(libaoItemIndex.skillLock,not openLibao)

widget:SetChildButtonClick(libaoItemIndex.skillIcon,function()

self:showWindow("UIDiscipleTianMingSkillTipsWin",{
tmId=tmId,
tmState=openLibao,
tmLv=dzNowTmLv,
needFloor=floor,
jobId=dzJobId,
isNotShowButton=true,
})
end)
end

function UITianmingzengliSysWin:setTipsReward(rewards)
local libaoList=rewards
local count=#libaoList
self.tipsRewardScroller:setChildScrollViewCreateGrids(count,1)
local grids=self.tipsRewardScroller:getChildScrollViewItemWidgets()

for i=1,grids.Count do
local widget=grids[i-1]
local itemGrids=widget:GetChildCommonLayoutGroupWidgetList(0)

for i=1,itemGrids.Count do
local itemWidget=itemGrids[i-1]
local rewardData=rewards[i]

if rewardData then
itemWidget:SetChildActive(-1,true)
local itemid=rewardData[1]
local itemcount=rewardData[2]
if not itemcount then
itemcount=0
end
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local colorEffect=rewardData[3]and rewardData[3]==1 or false
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=true,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetChildActive(2,true)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
itemWidget:SetChildActive(-1,false)
itemWidget:SetChildActive(2,false)
end
end
end
end


function UITianmingzengliSysWin:setRewardShow(rewards,widget,index)
if not rewards then
return
end

local itemGrids=widget:GetChildCommonLayoutGroupWidgetList(index)
for i=1,itemGrids.Count do
local itemWidget=itemGrids[i-1]
local rewardData=rewards[i]
if rewardData then
itemWidget:SetChildActive(-1,true)
local itemid=rewardData[1]
local itemcount=rewardData[2]
if not itemcount then
itemcount=0
end
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local colorEffect=rewardData[3]and rewardData[3]==1 or false
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
itemWidget:SetChildActive(-1,false)
end
end
end





function UITianmingzengliSysWin:onUpTianMing()

local cfg=self.sortShowItemList[self.selectPageIndex].cfg
local dzModelParam=cfg.dzModelParam
if not dzModelParam or not next(dzModelParam)then
logErr("找不到弟子展示模型参数数据 请检查配置是否正确")
return
end
local dzId=dzModelParam.dzId
local dzData=self:getDiscipleData(dzId)
local hasDz=dzData.discipleguid~=nil

if hasDz then

local tabType=FULL_TAB_TYPE.eDiscipleTianMing
local jumpBackFunc
if self.activityId~=nil then
local subType=self.subType
local activityId=self.activityId
local subId=self.subId
jumpBackFunc=function()





jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subType,subid=subId,extraParams={dzId=dzId}}},function()
jumpManager:clearJump()
end)
end
else
jumpBackFunc=function()

return UIFullTianMingZengLiController:showMainUI({dzId=dzId})
end
end
UIFullCommonControl:jumpDiscipleMain(dzData.discipleguid,tabType,jumpBackFunc)
else

local dzName=dzData.disciplename
local tipsStr=FMT.fmt("宗门暂未招收弟子“{0}”",dzName)
UIManager.error(tipsStr)

local jumpArgs=cfg.jumpParam
if jumpArgs then

jumpManager:jump(jumpArgs)
else

local cost=UIDiscipleModel:getUpTianMingCost(dzData)
local itemid=cost[1][1]
return gainControl:showGainWin(itemid)
end
end
end



function UITianmingzengliSysWin:onBtnGoTo()
self:goToNewGear()
end



function UITianmingzengliSysWin:onBtnClose()
self:closeTips()
end


function UITianmingzengliSysWin:getDiscipleData(diziId)
if not diziId then
return
end
if not self.tempDzData then
self.tempDzData={}
end

if self.tempDzData[diziId]then
return self.tempDzData[diziId]
end


local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziId)
if dzData then
self.tempDzData[diziId]=dzData
else

self.tempDzData[diziId]=UIDiscipleModel:getDiscipleDataByDiziId(diziId)
end

return self.tempDzData[diziId]
end


function UITianmingzengliSysWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UITianmingzengliSysWin:onLibaoFreeBtn(dzId,libaoId)
local isGot=tianmingzengliModel:checkTMZLFreeLibaoIsGot(dzId,libaoId)
if isGot then

return
end


local cfg=self.sortShowItemList[self.selectPageIndex].cfg
local libaoCfgList=cfg.rewards
local libaoCfg=libaoCfgList[libaoId]
local targetTianmingLv=libaoCfg[1]
local dzData=self:getDiscipleData(dzId)
local hasDz=dzData.discipleguid~=nil
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)
local openLibao=hasDz and dzNowTmLv>=targetTianmingLv or false

if openLibao then

tianmingzengliController:reqTianMingZengLiGetFreeLibao(dzId,libaoId)
else

local dzName=dzData.disciplename
local tmLv_str=UIDiscipleModel.getTianMingLevelDesc(targetTianmingLv,1)
local tipsStr=FMT.fmt("弟子“{0}”{1}可领取",dzName,tmLv_str)
UIManager.error(tipsStr)
end
end


function UITianmingzengliSysWin:onLibaoBuyBtn(dzId,libaoId)

local cfg=self.sortShowItemList[self.selectPageIndex].cfg
local libaoCfgList=cfg.rewards
local libaoCfg=libaoCfgList[libaoId]
local targetTianmingLv=libaoCfg[1]
local buyLibaoRechargeId=libaoCfg[4]
local buyLimitCount=libaoCfg[5]

local nowBuyCount=tianmingzengliModel:getTMZLLibaoBuyCount(dzId,libaoId)
if buyLimitCount and nowBuyCount>=buyLimitCount then

return
end

local dzData=self:getDiscipleData(dzId)
local hasDz=dzData.discipleguid~=nil
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)
local openLibao=hasDz and dzNowTmLv>=targetTianmingLv or false

if openLibao then

tianmingzengliController:reqTianMingZengLiBuyLibao(buyLibaoRechargeId,dzId,libaoId)
else

local dzName=dzData.disciplename
local tmLv_str=UIDiscipleModel.getTianMingLevelDesc(targetTianmingLv,1)
local tipsStr=FMT.fmt("弟子“{0}”{1}可购买",dzName,tmLv_str)
UIManager.error(tipsStr)
end
end
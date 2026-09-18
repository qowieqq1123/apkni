







def_class("UIXianJie_LeyLineInfoWin",UIWindowBase)









function UIXianJie_LeyLineInfoWin:bindComponents()

self.costList=UIObject.get(self,0)
self.detailBtn=UIButton.get(self,1)
self.effectList=UIObject.get(self,2)
self.limitTx=UIText.get(self,3)
self.mask=UIButton.get(self,4)
self.model=UIObject.get(self,5)
self.nameTx=UIText.get(self,6)
self.posTxt=UIText.get(self,7)
self.progressBar=UIProgress.get(self,8)
self.recordBtn=UIButton.get(self,9)
self.repairCnt=UIText.get(self,10)
self.repaired=UIObject.get(self,11)
self.repairtBtn=UIButton.get(self,12)
self.root=UIObject.get(self,13)
self.ruleBtn=UIButton.get(self,14)
self.shareBtn=UIButton.get(self,15)
self.stageList=UIObject.get(self,16)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.repairtBtn:setButtonClick(function()self:onRepairtBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)



end


function UIXianJie_LeyLineInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costList);self.costList=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.effectList);self.effectList=nil;
_UIObject_release(self.limitTx);self.limitTx=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.repairCnt);self.repairCnt=nil;
_UIObject_release(self.repaired);self.repaired=nil;
_UIObject_release(self.repairtBtn);self.repairtBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.stageList);self.stageList=nil;
end















local _this=nil



function UIXianJie_LeyLineInfoWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
self:addNotify(notifyConfig.onClickXianJiePlane,self.onClickXianJiePlane)
self:addNotify(notifyConfig.onXianJieWaiPaiChange,self.onXianJieWaiPaiChange)

self:addProNotify(39,1,self.on_39_1)
self:addProNotify(39,4,self.on_39_4)

self:addProNotify(35,91,self.on_35_91)
self:addProNotify(35,92,self.on_35_92)
self:addProNotify(35,4,self.on_35_4)
end


function UIXianJie_LeyLineInfoWin:__delete()
self:unbindComponents()
_this=nil

xianjieController:closeWin2(self.__name)
end




function UIXianJie_LeyLineInfoWin:onShow(argtable,afterOnloaded)
local open,lockNames=xianjieModel:checkLeyLineSeasonStageOpen()
local haveData=xianjieModel:getLeyLineRepairData()~=nil
if open and not haveData then
xianjieController:checkReqLeyLineRepiarData()
end

self.entityData=xianjieModel:getLeyLineData()
self:refreshView()
end


function UIXianJie_LeyLineInfoWin:onHide()

end




function UIXianJie_LeyLineInfoWin:onDetailBtn()
local args={
parentWin=self,
}
self:showWindow("UIXianJie_LeyLineRepairDetailWin",args)
end


function UIXianJie_LeyLineInfoWin:onMask()
self:onCloseClick()
end


function UIXianJie_LeyLineInfoWin:onRecordBtn()

end


function UIXianJie_LeyLineInfoWin:onRepairtBtn()
local check,tips=xianjieModel:checkLeyLineRepairCount()
if not check then
if tips then
UIManager.info(tips)
end
return
end

local data=xianjieModel:getLeyLineRepairData()
if data then
local args={
parentWin=self
}
self:showWindow("UIXianJie_LeyLineRepairWin",args)
else
loggerUtil.logErrFMT("没有灵脉建筑数据")
end
end


function UIXianJie_LeyLineInfoWin:onRuleBtn()
local ruleLangIdList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ruleLangIdList')
local ruleType=xjRuleTipsType.eLeyLine
local langId=ruleLangIdList and ruleLangIdList[ruleType]or''








local screenPos=self.ruleBtn:getChildUIScreenPos(false)
screenPos.x=screenPos.x-50
local winParams={
parentWin=self,
lang=langId,
num=nil,
screenPos=screenPos,
}
self:showWindow("UIXianJie_commonRuleWin",winParams)
end


function UIXianJie_LeyLineInfoWin:onShareBtn()
local cfg=self.entityData:getCfg()
local nameStr=cfg.name or"灵脉"
local _sceneType=xianjieModel:getScenceType()
local data=
{
x=self.sharex,
y=self.sharez,
icon1="icon_sjgdbiaoshi_1",
msgName=nameStr,
shareType=xianjie_Point_Share.lingmai,
scenceType=_sceneType,
name=nameStr,
shareName=nameStr,
}
local str=xianjieController:getShareStr(data)
str=chatLinkHelper.clearLink(str)
local sceneidx=xianjieModel:getSceneIndex(_sceneType)
local jsonStr=jsonHelper.encode({data.shareType,data.shareName,sceneidx,data.x,data.y})
local args={
channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.eXianmeng},
counterType=gameCounterType.eXianjiePointShareNum,
regexType=CHAT_REGEX_TYPE.csFairyLand,
descStr=str,
jsonStr=jsonStr,
title='坐标分享',
shareName=data.msgName,
sharePosStr=FMT.fmt('X <color=#171311>{0},</color> Y <color=#171311>{1}</color>',data.x,data.y)
}
UIManager:showWindow("UICommonShareTwoWin",args)
end

function UIXianJie_LeyLineInfoWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIXianJie_LeyLineInfoWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIXianJie_LeyLineInfoWin.onClickXianJiePlane()
if _this==nil or not _this.isVisible then return end
_this:onCloseClick()
end

function UIXianJie_LeyLineInfoWin.onXianJieWaiPaiChange(changeType,teamHandle)
if _this==nil or not _this.isVisible then return end
if(changeType==CHANGE_TYPE.eChanged or changeType==CHANGE_TYPE.eAdd)and teamHandle.teamType==xjTeamHandleType.eCarryRepair then
local marchData=teamHandle.teamData
if marchData.marchtype==xjServerMarchType.eCarry and mathHelper.int64_to_number(marchData.tarcbid)==xjClientBuildType.flcbXianYuLingMai then
_this:refreshRepairCnt()
end
end
end

function UIXianJie_LeyLineInfoWin.on_39_1()
_this:refreshRepairBtn()
end

function UIXianJie_LeyLineInfoWin.on_39_4(season_id,chapter_idx)
if xianjieModel:isLeyLineSeasonStage(season_id,chapter_idx)then
_this:refreshRepairBtn()
end
end

function UIXianJie_LeyLineInfoWin.on_35_91()
_this:refreshView()
end

function UIXianJie_LeyLineInfoWin.on_35_4()
if _this==nil or not _this.isVisible then return end
_this:refreshRepairCnt()
end

function UIXianJie_LeyLineInfoWin.on_35_92(fairylandFixBuild)
if fairylandFixBuild.fix_build_id==xjClientBuildType.flcbXianYuLingMai then
_this:refreshView()
end
end

function UIXianJie_LeyLineInfoWin:onCloseClick(atOnce)
xianjieController:closeWin(self.__name,atOnce)
end

function UIXianJie_LeyLineInfoWin:refreshView()
local cfg=self.entityData:getCfg()

local gridX_c,gridZ_c=self.entityData:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
self.sharex=gridX_c
self.sharez=gridZ_c

self.nameTx:setText(cfg.name)

local modelParams=cfg.clientParam.model
local modelEx1=cfg.clientParam.modelEx1
local scale=modelEx1 and modelEx1[1]or 1
local offset=modelEx1 and modelEx1[2]or{0,0}
self.model:setChildUIModelShowTarget(modelParams[1],scale,modelParams[2]or{},eAnimationID.stand,false,false,0)
self.model:setChildUIModelShowTargetOffset(offset[1],offset[2])

local descs=cfg.clientParam.effectStr
self.effectList:setChildLayoutGroupCreateItems(#descs,function(index)
local item=self.effectList:getChildLayoutGroupGridItem(index-1)
item:SetChildText(-1,descs[index])
end)
self.winlua:ForceLayoutRect(self.effectList:getID())

self:refreshProgress()
self:refreshStage()
self:refreshCostList()
self:refreshRepairBtn()
end

function UIXianJie_LeyLineInfoWin:refreshProgress()
local cfg=self.entityData:getCfg()
local fixed_build_conf=cfg.param.fixed_build_conf
local stage=math.max(xianjieModel:getLeyLineRepairStage(),1)
local curValue=xianjieModel:getLeyLineRepairScore()
local maxValue=fixed_build_conf[stage][1]
self.progressBar:setProgressValue(curValue,maxValue)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",curValue,maxValue))
end

function UIXianJie_LeyLineInfoWin:refreshStage()
local cfg=self.entityData:getCfg()
local max=#cfg.param.fixed_build_conf
local stage=xianjieModel:getLeyLineRepairStage()
local cur=xianjieModel:isLeyLineRepairFinish()and max or math.max(stage-1,0)
self.stageList:setChildLayoutGroupCreateItems(max,function(index)
local item=self.stageList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(0,cur>=index)
item:SetChildActive(1,index>1)
end)
end

function UIXianJie_LeyLineInfoWin:refreshCostList()
local cfg=self.entityData:getCfg()
local fixed_build_conf=cfg.param.fixed_build_conf
local stage=math.max(xianjieModel:getLeyLineRepairStage(),1)
self.costConfigs=fixed_build_conf[stage][2]
self.costList:setChildLayoutGroupCreateItems(#self.costConfigs,function(index)
local item=self.costList:getChildLayoutGroupGridItem(index-1)
local costData=self.costConfigs[index]
local itemId=costData[1]
local curValue=xianjieModel:getLeyLineRepairItemCount(index)
local maxValue=costData[5]
local conf={itemid=itemId,itemcount="",showname=false,showCountBG=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
item:SetChildProgressValue(1,curValue,maxValue)
item:SetChildProgressText(1,FMT.fmt("{0}/{1}",curValue,maxValue))
end)
end

function UIXianJie_LeyLineInfoWin:refreshCostProgress()
for i=1,#self.costConfigs do
self:refreshCostProgressItem(i)
end
end

function UIXianJie_LeyLineInfoWin:refreshCostProgressItem(index)
local costData=self.costConfigs[index]
local curValue=xianjieModel:getLeyLineRepairItemCount(index)
local maxValue=costData[5]
local item=self.costList:getChildLayoutGroupGridItem(index-1)
item:SetChildProgressValue(1,curValue,maxValue)
item:SetChildProgressText(1,FMT.fmt("{0}/{1}",curValue,maxValue))
end

function UIXianJie_LeyLineInfoWin:refreshRepairBtn()
local finish=xianjieModel:isLeyLineRepairFinish()
local open,lockNames=xianjieModel:checkLeyLineSeasonStageOpen()
local haveData=xianjieModel:getLeyLineRepairData()~=nil
self.repairtBtn:setActive(not finish and open)
self.repaired:setActive(finish)
self.detailBtn:setActive(open and haveData)
local limitStr=""
local countStr=""
if not finish then
if not open then
local nameStr=nil
for i,v in ipairs(lockNames)do
local temp=FMT.fmt("【{0}-{1}】",v[1],v[2])
nameStr=nameStr and FMT.fmt("{0}或{1}",nameStr,temp)or temp
end
limitStr=nameStr and FMT.fmt("解锁{0}章节后开启",nameStr)or"未开启"
else
local max=cfgHelper.get3(cfg_fairylandclientbuildconfig_get,xjClientBuildType.flcbXianYuLingMai,"param","day_cnt")
local cur=xianjieModel:getLeyLineRepairCount()
countStr=FMT.fmt("今日成功派遣：{0}/{1}",cur,max)
end
end
self.limitTx:setText(limitStr)
self.repairCnt:setText(countStr)
end

function UIXianJie_LeyLineInfoWin:refreshRepairCnt()
local open,lockNames=xianjieModel:checkLeyLineSeasonStageOpen()
local countStr=""
if open then
local max=cfgHelper.get3(cfg_fairylandclientbuildconfig_get,xjClientBuildType.flcbXianYuLingMai,"param","day_cnt")
local cur=xianjieModel:getLeyLineRepairCount()
countStr=FMT.fmt("今日成功派遣：{0}/{1}",cur,max)
end
self.repairCnt:setText(countStr)
end
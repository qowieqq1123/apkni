







def_class("UIProsprity_MainWin",UIWindowBase)









function UIProsprity_MainWin:bindComponents()

self.Root=UIObject.get(self,0)
self.bgSpine=UIObject.get(self,1)
self.uiRoot=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.propressTxt=UIText.get(self,4)
self.rewardPreviewScrollview=UIObject.get(self,5)
self.uplevelReddot=UIObject.get(self,6)
self.liantidzname=UIText.get(self,7)
self.liantidizimodel=UIObject.get(self,8)
self.jingjiedizi=UIText.get(self,9)
self.jingjiedizicnt=UIText.get(self,10)
self.jingjiedzname=UIText.get(self,11)
self.jingjiedizimodel=UIObject.get(self,12)
self.prosperityLevel=UIText.get(self,13)
self.prosperityValue=UIText.get(self,14)
self.lvProgressBar=UIProgressBarAni.get(self,15)
self.recentInfomationBtn=UIButton.get(self,16)
self.playInfomationBtn=UIButton.get(self,17)
self.addProsprityBtn=UIButton.get(self,18)
self.lvRewardPreviewBtn=UIButton.get(self,19)
self.rewardPreviewRoot=UIObject.get(self,20)
self.receiveLvRewardBtn=UIButton.get(self,21)
self.productionInfoList=UIObject.get(self,22)
self.jingjie=UIImage.get(self,23)
self.jingjiestage=UIImage.get(self,24)
self.lianti=UIImage.get(self,25)
self.liantistage=UIImage.get(self,26)
self.liantimaxdzinfo=UIBaseItem.get(self,27)
self.diziCntRoot=UIObject.get(self,28)
self.jingjiemaxdzinfo=UIBaseItem.get(self,29)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.recentInfomationBtn:setButtonClick(function()self:onRecentInfomationBtn()end)

self.playInfomationBtn:setButtonClick(function()self:onPlayInfomationBtn()end)

self.addProsprityBtn:setButtonClick(function()self:onAddProsprityBtn()end)

self.lvRewardPreviewBtn:setButtonClick(function()self:onLvRewardPreviewBtn()end)

self.receiveLvRewardBtn:setButtonClick(function()self:onReceiveLvRewardBtn()end)



end


function UIProsprity_MainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.propressTxt);self.propressTxt=nil;
_UIObject_release(self.rewardPreviewScrollview);self.rewardPreviewScrollview=nil;
_UIObject_release(self.uplevelReddot);self.uplevelReddot=nil;
_UIObject_release(self.liantidzname);self.liantidzname=nil;
_UIObject_release(self.liantidizimodel);self.liantidizimodel=nil;
_UIObject_release(self.jingjiedizi);self.jingjiedizi=nil;
_UIObject_release(self.jingjiedizicnt);self.jingjiedizicnt=nil;
_UIObject_release(self.jingjiedzname);self.jingjiedzname=nil;
_UIObject_release(self.jingjiedizimodel);self.jingjiedizimodel=nil;
_UIObject_release(self.prosperityLevel);self.prosperityLevel=nil;
_UIObject_release(self.prosperityValue);self.prosperityValue=nil;
_UIObject_release(self.lvProgressBar);self.lvProgressBar=nil;
_UIObject_release(self.recentInfomationBtn);self.recentInfomationBtn=nil;
_UIObject_release(self.playInfomationBtn);self.playInfomationBtn=nil;
_UIObject_release(self.addProsprityBtn);self.addProsprityBtn=nil;
_UIObject_release(self.lvRewardPreviewBtn);self.lvRewardPreviewBtn=nil;
_UIObject_release(self.rewardPreviewRoot);self.rewardPreviewRoot=nil;
_UIObject_release(self.receiveLvRewardBtn);self.receiveLvRewardBtn=nil;
_UIObject_release(self.productionInfoList);self.productionInfoList=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.jingjiestage);self.jingjiestage=nil;
_UIObject_release(self.lianti);self.lianti=nil;
_UIObject_release(self.liantistage);self.liantistage=nil;
_UIObject_release(self.liantimaxdzinfo);self.liantimaxdzinfo=nil;
_UIObject_release(self.diziCntRoot);self.diziCntRoot=nil;
_UIObject_release(self.jingjiemaxdzinfo);self.jingjiemaxdzinfo=nil;
end
















local _bgSpineID=2016
local _levelRewardEnableScrollMaxNum=6

local _this

local CmpProductionInfoItemIndex={
icon=0,
rateInfo=1,
rateValue=2,
productionInfo=3,
productionNumLink=4,
numInfo=5,
}




function UIProsprity_MainWin:onLoaded(...)
self:bindComponents()

_this=self

self:addNotify(notifyConfig.onProsperityLevelChange,function(...)self:onProsperityLevelChange(...)end)
end


function UIProsprity_MainWin:__delete()
self:unbindComponents()

_this=nil
end




function UIProsprity_MainWin:onShow(argtable,afterOnloaded)


self:initUI()


if afterOnloaded then
self.uiRoot:setChildCanvasGroupAlpha(0)
self.bgSpine:setChildUIModelShowTarget(_bgSpineID,1,{},eAnimationID.enter,false,false,0,function()
self.uiRoot:setChildCanvasGroupDOFade(1,0.2,nil)
end)
end
end


function UIProsprity_MainWin:onHide()

end

function UIProsprity_MainWin:initUI()
self:refreshTopArea()

self:refreshRecentInfo()
end



function UIProsprity_MainWin:refreshTopArea()

local totalLv=prosperityModel:getTotalLevel()


local prosprityLevel=prosperityModel:getProsperityLevel()
self.prosperityLevel:setText(FMT.fmt('{0}级',prosprityLevel))


local totalProsperityValue=prosperityModel:getTotalFRValue()
self.prosperityValue:setText(totalProsperityValue)


local expLv=Mathf.Min(totalLv,prosprityLevel+1)
local maxExp=cfgHelper.get2(cfg_guildabundancelvconfig_get,expLv,'exp')

local subExp,mainExp=prosperityModel:getSelfAdaptionExp()
self.lvProgressBar:animateThreeParams(subExp,mainExp,0.2)
self.propressTxt:setText(FMT.fmt("{0}/{1}",subExp,mainExp))


self.addProsprityBtn:setActive(maxExp>totalProsperityValue)
self.receiveLvRewardBtn:setActive(totalProsperityValue>=maxExp and prosperityModel:isCanUpLevel())
self.uplevelReddot:setActive(totalProsperityValue>=maxExp and prosperityModel:isCanUpLevel())


local rewards=cfgHelper.get2(cfg_guildabundancelvconfig_get,expLv,'rewards')
local propDataList={}
for k,itemData in ipairs(rewards)do
local itemId=itemData[1]
local itemNum=itemData[2]

local conf={showname=true,showcount=itemNum>1,showCountBG=itemNum>1,itemcount=itemNum,nomalname=true,showStageBg=true}
local item={itemid=itemId,itemcount=itemNum}
local prop=itemsComponentHelper.getCommonFillData(item,conf)

table.insert(propDataList,prop)
end

local rlen=#propDataList
self.rewardPreviewScrollview:setChildScrollViewCreateGrids(rlen,rlen)
local grids=self.rewardPreviewScrollview:getChildScrollViewItemWidgets()
local count=grids.Count

for i=1,count do
local item=grids[i-1]
local prop=propDataList[i]

item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end
self.rewardPreviewScrollview:setChildScrollRectEnable(count>5)
end



function UIProsprity_MainWin:refreshRecentInfo()

self:refreshDiscipleRecentInfo()


self:refreshProductionRecentInfo()
end


function UIProsprity_MainWin:refreshDiscipleRecentInfo()
self:refreshJingJieMaxDiscipleRecentInfo()

self:refreshLianTiMaxDiscipleRecentInfo()

self:refreshZMMaxJJDiscipleCntRecentInfo()
end



function UIProsprity_MainWin:refreshJingJieMaxDiscipleRecentInfo()

local dzData,pIndex=prosperityModel:getZongMenJingJieMaxInfo()

local jjFloor=UIDiscipleModel:getJJFloor(dzData.jingjielv)

local jjFloorIconName=prosperityModel:getJJFloorIconName(jjFloor)
local sufficIconName=prosperityModel:getJJSuffixIconName(pIndex)

self.jingjie:setCSImageSprite(globalABLookup.prosperity,jjFloorIconName)
self.jingjiestage:setActive(pIndex>0)
self.jingjiestage:setCSImageSprite(globalABLookup.prosperity,sufficIconName)


local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzData.discipleguid,true,nil,nil)
self.jingjiedizimodel:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,0,false,false,0,nil)



self.jingjiedzname:setText(dzData.disciplename)

local wb=self.jingjiemaxdzinfo:getWidgetBase()
wb:SetBaseItemClickEvent(-1,function()
UIFullCommonControl:jumpDiscipleMain(dzData.discipleguid,FULL_TAB_TYPE.eDiscipleInfo,nil)
end)
end



function UIProsprity_MainWin:refreshLianTiMaxDiscipleRecentInfo()

local dzData,pIndex=prosperityModel:getZongMenLianTiMaxInfo()

local ltFloor=UIDiscipleModel:getJJFloor(dzData.liantilv)

local jjFloorIconName=prosperityModel:getLTFloorIconName(ltFloor)
local sufficIconName=prosperityModel:getLTSuffixIconName(pIndex)

self.lianti:setCSImageSprite(globalABLookup.prosperity,jjFloorIconName)
self.liantistage:setActive(pIndex>0)
self.liantistage:setCSImageSprite(globalABLookup.prosperity,sufficIconName)


local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzData.discipleguid,true,nil,nil)
self.liantidizimodel:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,0,false,false,0,nil)



self.liantidzname:setText(dzData.disciplename)

local wb=self.liantimaxdzinfo:getWidgetBase()
wb:SetBaseItemClickEvent(-1,function()
UIFullCommonControl:jumpDiscipleMain(dzData.discipleguid,FULL_TAB_TYPE.eDiscipleInfo,nil)
end)
end



function UIProsprity_MainWin:refreshZMMaxJJDiscipleCntRecentInfo()

local jjName,dzCnt=prosperityModel:getZongMenJingJieCntInfo()

self.jingjiedizi:setText(FMT.fmt("{0}弟子",jjName))
self.jingjiedizicnt:setText(FMT.fmt("{0}名",dzCnt))
end

function UIProsprity_MainWin:refreshProductionRecentInfo()
local recentInfoList=prosperityModel:getProductionRecentDataList()

self.productionInfoList:setChildLayoutGroupCreateItems(#recentInfoList,function(index)
self:refreshProductionInfoItem(index,recentInfoList)
end)
end

function UIProsprity_MainWin:refreshProductionInfoItem(index,recent_info_list)
local data=recent_info_list[index]
local item=self.productionInfoList:getChildLayoutGroupGridItem(index-1)


local bdIcon=data.icon
item:SetChildIcon(CmpProductionInfoItemIndex.icon,bdIcon,true)

item:SetChildActive(-1,data~=nil)
if data then


local rateValue=FMT.fmt("{0}%",data.rate)
item:SetChildText(CmpProductionInfoItemIndex.rateValue,rateValue)

if data.hasProductionPlane then
local buildName=data.name
local rateInfo=FMT.fmt("{0}总生产效率",buildName)
item:SetChildText(CmpProductionInfoItemIndex.rateInfo,rateInfo)

local numInfo=FMT.fmt("{0}数量：<color=#CA631D>{1}</color>",buildName,data.buildNum)
item:SetChildText(CmpProductionInfoItemIndex.numInfo,numInfo)











item:SetChildActive(CmpProductionInfoItemIndex.rateInfo,true)



item:SetBaseItemClickEvent(-1,function()

end)
else
local itemCfg=itemsConfig.getConfig(data.productionItemId)
local itemName=itemCfg.name

local buildName=data.name
local rateInfo=FMT.fmt("{0}{1}获取效率",buildName,itemName)
item:SetChildText(CmpProductionInfoItemIndex.rateInfo,rateInfo)

item:SetChildActive(CmpProductionInfoItemIndex.rateInfo,true)


local numInfo=FMT.fmt("{0}数量：<color=#CA631D>{1}</color>",buildName,data.buildNum)
item:SetChildText(CmpProductionInfoItemIndex.numInfo,numInfo)
end

item:SetBaseItemClickEvent(-1,function()
UIFullProsperityController:showWindow("UIProsperity_TypeDetailsInfoWin",{typeList={data.type}})
end)
end
end

function UIProsprity_MainWin:onProsperityLevelChange()
self:refreshTopArea()
end





function UIProsprity_MainWin:onLvRewardPreviewBtn()
self:showWindow('UIProsperity_TaskWin')
end



function UIProsprity_MainWin:onAddProsprityBtn()

local totalValue=prosperityModel:getTotalFRValue()
gainControl:showGainWin(eMoneyType.mtFanRongDu,nil,{goodNum=totalValue})
end



function UIProsprity_MainWin:onPlayInfomationBtn()
local d={}

d.title='提示'
d.mode=3
d.name='prosperity_rule_help_%d'

self:showWindow('UIRuleWin',d)
end



function UIProsprity_MainWin:onRecentInfomationBtn()
self:showWindow('UIProsperity_DetailsInfoWin')
end

function UIProsprity_MainWin:onReceiveLvRewardBtn()
prosperityController:send_6_105()
end

function UIProsprity_MainWin:onCloseBtn()

UIFullProsperityController:closeUI(true)
end

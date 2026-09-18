







def_class("UIYunJiaYing_reviewWin",UIWindowBase)









function UIYunJiaYing_reviewWin:bindComponents()

self.mask=UIButton.get(self,0)
self.soldierFightText=UIText.get(self,1)
self.allSoldierCountText=UIText.get(self,2)
self.healthyCountText=UIText.get(self,3)
self.injuryCountText=UIText.get(self,4)
self.soldierScrollView=UIObject.get(self,5)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIYunJiaYing_reviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.soldierFightText);self.soldierFightText=nil;
_UIObject_release(self.allSoldierCountText);self.allSoldierCountText=nil;
_UIObject_release(self.healthyCountText);self.healthyCountText=nil;
_UIObject_release(self.injuryCountText);self.injuryCountText=nil;
_UIObject_release(self.soldierScrollView);self.soldierScrollView=nil;
end



















function UIYunJiaYing_reviewWin:onLoaded(...)
self:bindComponents()
end


function UIYunJiaYing_reviewWin:__delete()
self:unbindComponents()
end




function UIYunJiaYing_reviewWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UIYunJiaYing_reviewWin:onHide()

end

function UIYunJiaYing_reviewWin:refresh()
local soldierList={}
local soldierList_lookup={}
local soldierCfgList=cfg_fairylandsoldierconfig()
local allHealthyCount=0
local allInjuryCount=0
for soldierId,soldierCfg in ipairs(soldierCfgList)do
local soldierMoneyIdList=soldierCfg.money or{}
local list={}
local isInsert=false
for hurtType,moneyId in ipairs(soldierMoneyIdList)do
local hasCount=itemsModel.getCount(moneyId)
if hasCount>0 and hurtType~=xjSoldierHurtType.eSlightInjury then
isInsert=true
list[hurtType]=hasCount
if hurtType==xjSoldierHurtType.eHealthy then
allHealthyCount=allHealthyCount+hasCount
if soldierList_lookup[soldierId]then
soldierList_lookup[soldierId]=soldierList_lookup[soldierId]+hasCount
else
soldierList_lookup[soldierId]=hasCount
end
elseif hurtType==xjSoldierHurtType.eSeriousInjury then
allInjuryCount=allInjuryCount+hasCount
end
end
end

if isInsert then
soldierList[#soldierList+1]={
soldierId=soldierId,
list=list,
}
end
end

table.sort(soldierList,function(a,b)
return a.soldierId>b.soldierId
end)


local fightValue=xianjieModel:getXJYZTeamFightValue(nil,soldierList_lookup)
self.soldierFightText:setText(FMT.fmt("修士战力：{0}",mathHelper.formatNumber3(fightValue)))


local waiPaiSoldierList,waiPaiAllSoldierCount=yunjiayingModel:getXJWaiPaiTeamSoldierCountAndList()
local breakingSoldierCount=yunjiayingModel:getBreakingSoldierCount()
local allSoldierCount=allHealthyCount+allInjuryCount+waiPaiAllSoldierCount+breakingSoldierCount
self.allSoldierCountText:setText(allSoldierCount)


self.healthyCountText:setText(allHealthyCount)


self.injuryCountText:setText(FMT.cfmt(FONT_COLOR.eRedColor,allInjuryCount))


self.soldierScrollView:setChildScrollViewCreateGrids(#soldierList,1)
local grids=self.soldierScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local soldierData=soldierList[i]
if soldierData then
widget:SetChildActive(-1,true)
local soldierId=soldierData.soldierId
local numList=soldierData.list or{}
local healthyCount=numList[xjSoldierHurtType.eHealthy]or 0
local injuryCount=numList[xjSoldierHurtType.eSeriousInjury]or 0


local soldierCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,soldierId)
local bgIconName=soldierCfg.bgIcon
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
widget:SetChildCSImageSprite(0,iconAb,bgIconName)
local levelIconName=soldierCfg.nameIcon
widget:SetChildCSImageSprite(1,iconAb,levelIconName)


widget:SetChildText(2,healthyCount)


widget:SetChildText(3,FMT.cfmt(FONT_COLOR.eRedColor,injuryCount))

else
widget:SetChildActive(-1,false)
end
end
end





function UIYunJiaYing_reviewWin:onMask()
end


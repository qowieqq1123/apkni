







def_class("UIYFGBattleVictoryWin",UIWindowBase)









function UIYFGBattleVictoryWin:bindComponents()

self.Pool=UIGameobjectClone.new(self,0)
self.Middle=UIObject.get(self,1)
self.centerTipsTx=UIText.get(self,2)
self.TipsTx=UIText.get(self,3)
self.progressBar=UIProgress.get(self,4)
self.TextNum=UIText.get(self,5)
self.TitleIcon=UIImage.get(self,6)
self.TitleTx=UIText.get(self,7)
self.headGroup=UIObject.get(self,8)



end


function UIYFGBattleVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
self.Pool:deleteSelf();self.Pool=nil;
_UIObject_release(self.Middle);self.Middle=nil;
_UIObject_release(self.centerTipsTx);self.centerTipsTx=nil;
_UIObject_release(self.TipsTx);self.TipsTx=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.TextNum);self.TextNum=nil;
_UIObject_release(self.TitleIcon);self.TitleIcon=nil;
_UIObject_release(self.TitleTx);self.TitleTx=nil;
_UIObject_release(self.headGroup);self.headGroup=nil;
end
















local this
local _divTime=0.1




function UIYFGBattleVictoryWin:onLoaded(...)
this=self
self:bindComponents()
end


function UIYFGBattleVictoryWin:__delete()
this=nil
self:unbindComponents()
end




function UIYFGBattleVictoryWin:onShow(argtable,afterOnloaded)
self.argtable=argtable or{}
self.battleId=self.argtable.battleId
self.fightDataList=argtable.fightData
self.fightData=self.fightDataList[1]
self.param=argtable.param

















local dataLeft=
{
childlist=table.weakCopy(self.fightData.left),
}
dataLeft.totalAttack_all=self.getAllValue(dataLeft.childlist,'totalAttack')



local dataRight=
{
childlist=table.weakCopy(self.fightData.right),
}
dataRight.totalAttack_all=self.getAllValue(dataRight.childlist,'totalAttack')


local fightFlag=self.param[1].fight_flag
local isBattle=fightFlag==1
local winSide=argtable.winSide
local showDzList
local showDMG
local showSettlementStr
local roundCount=self.fightData.round
if isBattle then

showDzList=winSide==0 and dataLeft.childlist or dataRight.childlist
showSettlementStr=self:getShowSettlementStr(roundCount)or"战斗<color=#549327>{0}回合</color>，{1}队伍获胜"
else

showDzList=dataLeft.childlist
showDMG=dataLeft.totalAttack_all
end



local tipsStr
if showDMG then
tipsStr=FMT.fmt("本次战斗造成伤害：<color=#549327>{0}</color>",mathHelper.formatNumber(showDMG))
elseif showSettlementStr then
local teamName=winSide==0 and"进攻"or"防守"
tipsStr=FMT.fmt(showSettlementStr,roundCount,teamName)
end
self.centerTipsTx:setText(tipsStr or"")


local len=#showDzList
self.headGroup:setChildLayoutGroupCreateItems(len,function(index)
local dzItem=self.headGroup:getChildLayoutGroupGridItem(index-1)
local childData=showDzList[index]
local has=childData~=nil






dzItem:SetChildActive(-1,has)
local dzHeadItemWidget=dzItem:GetChildWidgetBase(0)
if has then
local image=childData.image

comHelper.setChildModelHeadIconBGByColor(dzHeadItemWidget,0,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,dzHeadItemWidget,modelParams,eHeadCenterType.eHead,nil,false)

local discipleguid=childData.dis_guid
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
UIDiscipleModel:setDiscipleXianMoHeadImage(dzHeadItemWidget,8,netData)
end
end)
end


function UIYFGBattleVictoryWin:onHide()

end


function UIYFGBattleVictoryWin.getAllValue(res,key)
local allValue=0
for _,v in ipairs(res)do
if v[key]then
allValue=allValue+v[key]
end
end
return allValue
end


function UIYFGBattleVictoryWin:checkIsDzTeam(childlist)
for i,childData in pairs(childlist)do
local enityType=childData.enityType
if enityType==fightEntityType.diZi then
return true
end
end

return false
end

function UIYFGBattleVictoryWin:getShowSettlementStr(roundCount)
local cfg=cfgHelper.get(cfg_yanfageconfig_get,1)
local strList=cfg.settlementStr
if strList then
for _,v in ipairs(strList)do
local minRound=v[1]
local maxRound=v[2]
local str=v[3]
if roundCount>=minRound and roundCount<=maxRound then
return str
end
end
end
return nil
end




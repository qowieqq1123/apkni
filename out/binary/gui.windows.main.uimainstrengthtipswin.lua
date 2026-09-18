







def_class("UIMainStrengthTipsWin",UIWindowBase)









function UIMainStrengthTipsWin:bindComponents()

self.descListPanel=UIObject.get(self,0)
self.fightListPanel=UIObject.get(self,1)
self.titleText=UIText.get(self,2)



end


function UIMainStrengthTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.fightListPanel);self.fightListPanel=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end



















function UIMainStrengthTipsWin:onLoaded(...)
self:bindComponents()
end


function UIMainStrengthTipsWin:__delete()
self:unbindComponents()
end




function UIMainStrengthTipsWin:onShow(argtable,afterOnloaded)
local fight_top5=playerModel:getActorFightValue()
local fight_top15=playerModel:getActorTop15FightValue()
local allFight=0
local discipleList=UIDiscipleModel:getAllDiscipleData()
for i,v in pairs(discipleList)do
local netData=v.netData.net
local fight=UIDiscipleModel:getDiscipleFightValueEx(netData)
allFight=allFight+fight
end

local list={}
local allFight_str=FMT.fmt("总实力：<color=#ca631d>{0}</color>",mathHelper.formatNumber3(allFight))
local allFight_value_str=FMT.fmt("详细实力：<color=#ca631d>{0}</color>",allFight)
local fight_top5_str=FMT.fmt("最强五人：<color=#ca631d>{0}</color>",mathHelper.formatNumber3(fight_top5))
local fight_top5_value_str=FMT.fmt("详细实力：<color=#ca631d>{0}</color>",fight_top5)
list[#list+1]={str1=allFight_str,str2=allFight_value_str,desc="总实力：全部弟子的实力总和(仅供参考)"}
list[#list+1]={str1=fight_top5_str,str2=fight_top5_value_str,desc="最强五人：实力排行前五名弟子的实力和"}
if systemModel.isOpen(SYSTEM_DEFINE.eTopThreeTeams)then
local fight_top15_str=FMT.fmt("巅峰实力：<color=#ca631d>{0}</color>",mathHelper.formatNumber3(fight_top15))
local fight_top15_value_str=FMT.fmt("详细实力：<color=#ca631d>{0}</color>",fight_top15)
list[#list+1]={str1=fight_top15_str,str2=fight_top15_value_str,desc="巅峰实力：实力排行前十五名弟子的实力和"}
end
if mountainControl:isOpen(mapIdType.fort)then
local fight_frot=zongmenModel:getFortFightValue()
local fight_frot_str=FMT.fmt("堡垒实力：<color=#ca631d>{0}</color>",mathHelper.formatNumber3(fight_frot))
local fight_frot_value_str=FMT.fmt("详细实力：<color=#ca631d>{0}</color>",fight_frot)
list[#list+1]={str1=fight_frot_str,str2=fight_frot_value_str,desc="堡垒实力：仙界堡垒建筑、科技、云舟和修士的实力和"}
end

local len=#list
self.fightListPanel:setChildLayoutGroupCreateItems(len,function(index)
local item=self.fightListPanel:getChildLayoutGroupGridItem(index-1)
local data=list[index]
item:SetChildText(0,data.str1)
item:SetChildText(1,data.str2)
end)
self.descListPanel:setChildLayoutGroupCreateItems(len,function(index)
local item=self.descListPanel:getChildLayoutGroupGridItem(index-1)
local data=list[index]
item:SetChildText(0,data.desc)
end)
end


function UIMainStrengthTipsWin:onHide()

end



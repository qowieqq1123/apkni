







def_class("UIWorldMonsterHurtTeamCompletedWin",UIWindowBase)









function UIWorldMonsterHurtTeamCompletedWin:bindComponents()

self.bg=UIButton.get(self,0)
self.tips=UILinkImageText.get(self,1)
self.effect=UIObject.get(self,2)
self.worldName=UIText.get(self,3)
self.goodGridPanel=UIObject.get(self,4)

self.bg:setButtonClick(function()self:onBg()end)



end


function UIWorldMonsterHurtTeamCompletedWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.worldName);self.worldName=nil;
_UIObject_release(self.goodGridPanel);self.goodGridPanel=nil;
end















local _this=nil



function UIWorldMonsterHurtTeamCompletedWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIWorldMonsterHurtTeamCompletedWin:__delete()
self:unbindComponents()
_this=nil
self:stopItemTimer()
end




function UIWorldMonsterHurtTeamCompletedWin:onShow(argtable,afterOnloaded)
self.data=argtable
local cur=#self.data.victory
local max=#self.data.monsters
local str=FMT.fmt('本次狩猎击杀妖怪：{0}/{1}',cur,max)
self.tips:setText(str)
local worldNameStr=cfgHelper.get2(cfg_worldconfig_get,self.data.world,"name")
self.worldName:setText(FMT.fmt("猎妖队-{0}",worldNameStr))

self.sortRewards={}
for i,v in ipairs(self.data.rewardList)do
table.insert(self.sortRewards,{itemsConfig.getItemColor(v.itemid),v.itemid,v.num,guid=v.itemguid})
end
table.sort(self.sortRewards,self.sortItemTemp)
self.goodGridPanel:setChildLayoutGroupCreateItems(1,function(index)
local item=self.goodGridPanel:getChildLayoutGroupGridItem(index-1)
local sortData=self.sortRewards[index]

local itemid=sortData[2]
local num=sortData[3]
local itemguid=sortData.guid
local showCountBG=num>1
local countStr=showCountBG and num or""
local conf={itemid=itemid,itemcount=countStr,itemguid=itemguid,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
item:SetChildShowEffect(1,10078,true)
end)
if#self.sortRewards>1 then
self:stopItemTimer()
self.showItemTimer=self:setTimer(0.25,#self.sortRewards-1,function(timerID,time,least)
local index=#self.sortRewards-least+1
self.goodGridPanel:setChildLayoutGroupAddItem()
self:refreshItem(index)
end)
end

AudioManager.playAudio(407)
end


function UIWorldMonsterHurtTeamCompletedWin:onHide()

end



function UIWorldMonsterHurtTeamCompletedWin:onBg()
huntMonsterTeamController:cancelTeamData(self.data)
self:closeSelf()
end

function UIWorldMonsterHurtTeamCompletedWin:refreshItem(index)
local item=self.goodGridPanel:getChildLayoutGroupGridItem(index-1)
local sortData=self.sortRewards[index]
local itemid=sortData[2]
local num=sortData[3]
local itemguid=sortData.guid
local showCountBG=num>1
local countStr=showCountBG and num or""
local conf={itemid=itemid,itemcount=countStr,itemguid=itemguid,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
item:SetChildShowEffect(1,10078,true)
end

function UIWorldMonsterHurtTeamCompletedWin:stopItemTimer()
if self.showItemTimer then
self:stopTimerByID(self.showItemTimer)
self.showItemTimer=nil
end
end

function UIWorldMonsterHurtTeamCompletedWin.sortItemTemp(a,b)
for i=1,#a do
local A=a[i]
local B=b[i]
if A~=B then
return A>B
end
end
return false
end

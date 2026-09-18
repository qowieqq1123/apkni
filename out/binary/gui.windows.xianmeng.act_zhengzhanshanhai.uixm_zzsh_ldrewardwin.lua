







def_class("UIXM_ZZSH_ldRewardWin",UIWindowBase)









function UIXM_ZZSH_ldRewardWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.reward1Panel=UIObject.get(self,1)
self.reward2Panel=UIObject.get(self,2)
self.reward3Panel=UIObject.get(self,3)
self.commitBtn=UIButton.get(self,4)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)



end


function UIXM_ZZSH_ldRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.reward1Panel);self.reward1Panel=nil;
_UIObject_release(self.reward2Panel);self.reward2Panel=nil;
_UIObject_release(self.reward3Panel);self.reward3Panel=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
end
















local _this=nil


function UIXM_ZZSH_ldRewardWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_ZZSH_ldRewardWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_ldRewardWin:onHide()

end




function UIXM_ZZSH_ldRewardWin:onShow(argtable,afterOnloaded)
self.cfgID=argtable.cfgID
local cfg=zhengzhanshanhaiModel:getLingDiCfg(self.cfgID)
local zmlv=zongmenModel:getLevel()

self.titleTxt:setText(cfg.name)
local rewardID,rewards,rnum,grids

rewardID=cfg.daily[GUILD_POST_TYPE.gpCivilian]
if rewardID then
rewards=zongmenControl:getRewardConfigData(rewardID,zmlv)or{}
else
rewards={}
end
rnum=#rewards
self.reward1Panel:setChildLayoutGroupCreateItems(rnum)
grids=self.reward1Panel:getChildLayoutGroupGridList()
for i=1,rnum do
local rwItem=grids[i-1]
local itemid=rewards[i][1]
local itemnum=rewards[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildPropData(0,prop)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local showSign=itemnum<=0
rwItem:SetChildActive(1,showSign)
end

rewardID=cfg.daily[GUILD_POST_TYPE.gpAllyLeader]
if rewardID then
rewards=zongmenControl:getRewardConfigData(rewardID,zmlv)or{}
else
rewards={}
end
rnum=#rewards
self.reward2Panel:setChildLayoutGroupCreateItems(rnum)
grids=self.reward2Panel:getChildLayoutGroupGridList()
for i=1,rnum do
local rwItem=grids[i-1]
local itemid=rewards[i][1]
local itemnum=rewards[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildPropData(0,prop)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local showSign=itemnum<=0
rwItem:SetChildActive(1,showSign)
end

rewardID=cfg.daily[GUILD_POST_TYPE.gpViceLeader]
if rewardID then
rewards=zongmenControl:getRewardConfigData(rewardID,zmlv)or{}
else
rewards={}
end
rnum=#rewards
self.reward3Panel:setChildLayoutGroupCreateItems(rnum)
grids=self.reward3Panel:getChildLayoutGroupGridList()
for i=1,rnum do
local rwItem=grids[i-1]
local itemid=rewards[i][1]
local itemnum=rewards[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildPropData(0,prop)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local showSign=itemnum<=0
rwItem:SetChildActive(1,showSign)
end
end

function UIXM_ZZSH_ldRewardWin:checkClickLock()
if self.clickLockTime~=nil and gameUtilityModel.getServerShortTime()-self.clickLockTime<zhengzhanshanhaiModel.clickBtnCoolTime then
return false
end
self.clickLockTime=gameUtilityModel.getServerShortTime()
return true
end

function UIXM_ZZSH_ldRewardWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXM_ZZSH_ldRewardWin:onCommitBtn()
if not self:checkClickLock()then
return
end






end

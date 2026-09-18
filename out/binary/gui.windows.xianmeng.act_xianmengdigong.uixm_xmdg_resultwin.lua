







def_class("UIXM_XMDG_resultWin",UIWindowBase)









function UIXM_XMDG_resultWin:bindComponents()

self.rewardPanel=UIObject.get(self,0)
self.descTxt=UIText.get(self,1)



end


function UIXM_XMDG_resultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
end
















local _this=nil


function UIXM_XMDG_resultWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_XMDG_resultWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_XMDG_resultWin:onHide()

end




function UIXM_XMDG_resultWin:onShow(argtable,afterOnloaded)
local data=argtable.data

local room=xianmengdigongModel:getRoom2(data.x,data.y)
local yscfg=cfgHelper.get1(cfg_guilddigongyaoshouconfig_get,room.ysConfId)
local monsterType=yscfg.gwtype
local isboss=monsterType==MONSTER_TYPE.eShouLing
local desc
if isboss then
desc=FMT.fmt("本次战斗造成伤害量：<color=#39ba28>{0}%</color>",data.bossHurt/100)
else
desc=''
end
self.descTxt:setText(desc)

local rewards=limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eXianMengDiGong,'getRewardList')
local rewardlist={}
if#rewards>0 then
for i,v in ipairs(rewards)do
local itemConfig=itemsConfig.getConfig(v.itemid)
table.insert(rewardlist,{v.itemid,v.num,itemConfig.color,v.itemguid})
end
end
local num=#rewardlist
if num>1 then
table.sort(rewardlist,function(a,b)
return a[3]>b[3]
end)
end

self.rewardPanel:setChildLayoutGroupCreateItems(num)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]
local reward=rewardlist[i]
local itemid=reward[1]
local itemNum=reward[2]
local itemguid=reward[4]
local itemcount,showCountBG
if itemNum>1 then
itemcount=tostring(itemNum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,itemguid=itemguid,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end

function UIXM_XMDG_resultWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end








def_class("UIXM_ZZSH_monsterRewardShowWin",UIWindowBase)









function UIXM_ZZSH_monsterRewardShowWin:bindComponents()

self.root=UIObject.get(self,0)
self.info2Panel=UIObject.get(self,1)
self.reward1Panel=UIObject.get(self,2)
self.info3DescTxt=UIText.get(self,3)
self.reward3Panel=UIObject.get(self,4)
self.reward2Panel=UIObject.get(self,5)



end


function UIXM_ZZSH_monsterRewardShowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.info2Panel);self.info2Panel=nil;
_UIObject_release(self.reward1Panel);self.reward1Panel=nil;
_UIObject_release(self.info3DescTxt);self.info3DescTxt=nil;
_UIObject_release(self.reward3Panel);self.reward3Panel=nil;
_UIObject_release(self.reward2Panel);self.reward2Panel=nil;
end
















local _this


function UIXM_ZZSH_monsterRewardShowWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_ZZSH_monsterRewardShowWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_monsterRewardShowWin:onHide()

end




function UIXM_ZZSH_monsterRewardShowWin:onShow(argtable,afterOnloaded)
self.qbGuid=argtable.qbGuid
self:refreshInfo()
end

function UIXM_ZZSH_monsterRewardShowWin:refreshInfo()
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
local cfg=qbData:getCfg()
local isBoss=cfg.stage>=5

local rewards1=zongmenControl:getRewardConfigData(cfg.drop[1],zongmenModel:getLevel())or{}
local rnum1=#rewards1
self.reward1Panel:setChildLayoutGroupCreateItems(rnum1)
local grids1=self.reward1Panel:getChildLayoutGroupGridList()
for i=1,rnum1 do
local rwItem=grids1[i-1]
local itemid=rewards1[i][1]
local itemnum=rewards1[i][2]
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

local show2=cfg.drop[2]~=nil
self.info2Panel:setActive(show2)
if show2 then
local rewards2=zongmenControl:getRewardConfigData(cfg.drop[2],zongmenModel:getLevel())or{}
local rnum2=#rewards2
self.reward2Panel:setChildLayoutGroupCreateItems(rnum2)
local grids2=self.reward2Panel:getChildLayoutGroupGridList()
for i=1,rnum2 do
local rwItem=grids2[i-1]
local itemid=rewards2[i][1]
local itemnum=rewards2[i][2]
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

local bxcfg=zhengzhanshanhaiController:getZZSHCfg_box(cfg.stage)
local desc3=FMT.fmt('山海{0}奖励',bxcfg.item_name)
if isBoss then
desc3='根据首领伤害排行榜仙盟成员获得'
else
desc3='击杀异兽的仙盟所有成员获得'
end
self.info3DescTxt:setText(desc3)
local bx_drop=bxcfg.drop
local rewards3=zongmenControl:getRewardConfigData(bx_drop,zongmenModel:getLevel())or{}
local rnum3=#rewards3
self.reward3Panel:setChildLayoutGroupCreateItems(rnum3)
local grids3=self.reward3Panel:getChildLayoutGroupGridList()
for i=1,rnum3 do
local rwItem=grids3[i-1]
local itemid=rewards3[i][1]
local itemnum=rewards3[i][2]
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

function UIXM_ZZSH_monsterRewardShowWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end
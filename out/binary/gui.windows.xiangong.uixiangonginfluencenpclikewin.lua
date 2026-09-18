







def_class("UIXianGongInfluenceNPCLikeWin",UIWindowBase)









function UIXianGongInfluenceNPCLikeWin:bindComponents()

self.background=UIButton.get(self,0)
self.likeList=UIObject.get(self,1)
self.mask=UIObject.get(self,2)
self.overList=UIObject.get(self,3)
self.panel=UIObject.get(self,4)
self.view_1=UIObject.get(self,5)
self.view_2=UIObject.get(self,6)

self.background:setButtonClick(function()self:onBackground()end)
self.view={
self.view_1,
self.view_2,
}



end


function UIXianGongInfluenceNPCLikeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.likeList);self.likeList=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.overList);self.overList=nil;
_UIObject_release(self.panel);self.panel=nil;
_UIObject_release(self.view_1);self.view_1=nil;
_UIObject_release(self.view_2);self.view_2=nil;
self.view=nil;
end















local _this=nil
local _viewWidth=312
local _maskMaxHeight=468
local _view1BottomPadding=20



function UIXianGongInfluenceNPCLikeWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianGongInfluenceNPCLikeWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianGongInfluenceNPCLikeWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.npcID=argtable.npc

local flag=xjFactionNPCModel:getNPCFlag(self.npcID)
local cfg=cfg_xianjieshilijiaohufeellevelconfig()
local npcCfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,self.npcID)
local list={}
local lookup={}
local finish=true
for i,v in ipairs(cfg)do
local rewards=npcCfg.reward[i]
if rewards and#rewards>0 then
table.insert(list,i)
local check=flag>=i
lookup[i]=check
finish=finish and check
end
end

self.view_1:setActive(not finish)
self.view_2:setActive(finish)
if finish then
self.overList:setChildLayoutGroupCreateItems(#npcCfg.loop_reward,function(index)
local item=self.overList:getChildLayoutGroupGridItem(index-1)
local data=npcCfg.loop_reward[index]
local itemId=data[1]
local itemNum=data[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(-1,itemProp)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
else
self.likeList:setChildLayoutGroupCreateItems(#list,function(index)
local item=self.likeList:getChildLayoutGroupGridItem(index-1)
local level=list[index]
local rewards=npcCfg.reward[level]
local nameStr=cfg[level].name
local nameColor=cfg[level].name_color
item:SetChildText(0,FMT.cfmt3(nameColor,nameStr))
item:SetChildLayoutGroupCreateItems(1,#rewards,function(_index)
local _item=item:GetChildLayoutGroupGridItem(1,_index-1)
local rewardItem=rewards[_index]
local itemId=rewardItem[1]
local itemNum=rewardItem[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
_item:SetChildPropData(0,itemProp)
_item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
_item:SetChildActive(1,lookup[level])
end)
item:ForceLayoutRect(-1)
end)
self.winlua:ForceLayoutRect(self.likeList:getID())

local height=self.likeList:getChildSizeDeltaY()
local maskHeight=math.min(_maskMaxHeight,height)
self.mask:setChildSizeDelta(_viewWidth,maskHeight)
self.view_1:setChildSizeDelta(_viewWidth,maskHeight+_view1BottomPadding)
self.view_1:setChildScrollRectEnable(height>_maskMaxHeight)
end
self.winlua:ForceLayoutRect(self.panel:getID())
end


function UIXianGongInfluenceNPCLikeWin:onHide()

end




function UIXianGongInfluenceNPCLikeWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


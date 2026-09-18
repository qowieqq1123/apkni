







def_class("UISubAct_CrossRankingUpWin",UIWindowBase)









function UISubAct_CrossRankingUpWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.Root=UIObject.get(self,1)
self.tip=UIText.get(self,2)
self.title=UIText.get(self,3)
self.uiRoot=UIObject.get(self,4)
self.wayScrollView=UIScrollView.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_CrossRankingUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.wayScrollView);self.wayScrollView=nil;
end
















local _this

local CmpWayItemIndex={
lock=0,
name=1,
goBtn=2,
gray=3,
bgClick=4,
}




function UISubAct_CrossRankingUpWin:onLoaded(...)
self:bindComponents()

_this=self

self.wayScrollView:bindScrollWidget(function(...)self:bindWayItem(...)end)
end


function UISubAct_CrossRankingUpWin:__delete()
self:unbindComponents()
end




function UISubAct_CrossRankingUpWin:onShow(argtable,afterOnloaded)
if argtable then
self.argtable=argtable.argtable
self.rankType=argtable.rankType
if self.argtable.act_id then
self.activityId=self.argtable.act_id
end
if self.argtable.sub_act_type then
self.subType=self.argtable.sub_act_type
end
if self.argtable.sub_act_id then
self.subId=self.argtable.sub_act_id
end
if self.argtable.parentWin then
self.parentWin=self.argtable.parentWin
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self:refresh()
end


function UISubAct_CrossRankingUpWin:onHide()

end

function UISubAct_CrossRankingUpWin:refresh()
local wayList
if self.rankType==1 then
wayList=self.config.up_ranking_way_list
elseif self.rankType==2 then
wayList=self.config.up_ranking_way_list2
end

local tipsInfo=FMT.fmt(self.config.get_info_fmt,toColorString(FONT_COLOR.eOrangeDescColor,self.config.rank_val_name))
self.tip:setText(tipsInfo)

if wayList then
self.showList=gainControl:getGainSortList(wayList)
self.wayScrollView:freshGridsNum(#self.showList,#self.showList,1)
end
end

function UISubAct_CrossRankingUpWin:bindWayItem(index,item)
local info=self.showList[index]
local jump=info.jump
local buy=info.buy
local hecheng=info.hecheng
local shopBuy=info.shopBuy
local hasJump=jump~=nil
local hasBuy=buy~=nil
local hasHeCheng=hecheng~=nil
local hasShopBuy=shopBuy~=nil
local unLock,errArgs=gainControl:isUnlock(info)
local isGray,tips=self:isGray(info)
local canJump=hasJump and unLock or false
local canBuy=hasBuy and unLock or false
local canHeCheng=hasHeCheng and unLock or false
local canShopBuy=hasShopBuy and unLock or false

local active=(canJump or canBuy or canHeCheng or canShopBuy)and not isGray


local desc,state=gainControl:getJumpDesc(info,unLock,isGray)
item:SetChildText(CmpWayItemIndex.name,desc)

item:SetChildActive(CmpWayItemIndex.lock,not unLock)
item:SetChildActive(CmpWayItemIndex.gray,unLock and isGray)
local showArrow=gainControl:checkShowArrow(jump,active,state)
item:SetChildActive(CmpWayItemIndex.goBtn,not hasHeCheng and not hasShopBuy and showArrow)
local clickBgFun=function(...)
if _this==nil then return end
if active then
if canJump then
gainControl:handleJump(jump,self.jumpCB)






end
else
if not unLock then
gainControl:showTips(errArgs)
elseif isGray then
UIManager.error(tips)
else


end
end
end

item:SetBaseItemClickEvent(-1,clickBgFun)
item:SetChildButtonClick(CmpWayItemIndex.bgClick,function()
clickBgFun()
end,true)









end

function UISubAct_CrossRankingUpWin:isUnlock(info)
local sysid=info.sysid
local lv=info.lv
local jumpId=info.jump and info.jump.id or nil
if sysid then
if not systemModel.isOpen(sysid)then
return false
end
end
if lv then
if playerModel:getActorLevel()<lv then
return false
end
end
local ret=true
local args



if ret==nil then return true end
return ret,args
end

function UISubAct_CrossRankingUpWin:isGray(v)
















return false
end


function UISubAct_CrossRankingUpWin:onCloseBtn()
UIManager:invokeUIMethod("UISubAct_CrossRankingMainWin","refresh")
self:closeSelf()
end

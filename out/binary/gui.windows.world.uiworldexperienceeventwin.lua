







def_class("UIWorldExperienceEventWin",UIWindowBase)







local imageAB=""

local itemKid={
nameTx=0,
iconImg=1,
bgBtn=2,
itemList=3,
}

local _this=nil

function UIWorldExperienceEventWin:bindComponents()

self.TextTitlle=UIText.get(self,0)
self.TextContent=UIText.get(self,1)
self.ImagePicture=UIImage.get(self,2)
self.ItemList=UIScrollView.get(self,3)



end


function UIWorldExperienceEventWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.TextTitlle);self.TextTitlle=nil;
_UIObject_release(self.TextContent);self.TextContent=nil;
_UIObject_release(self.ImagePicture);self.ImagePicture=nil;
_UIObject_release(self.ItemList);self.ItemList=nil;
end



















function UIWorldExperienceEventWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIWorldExperienceEventWin:__delete()
self:unbindComponents()
_this=nil
end




function UIWorldExperienceEventWin:onShow(argtable,afterOnloaded)
self.cfg=cfgHelper.get1(cfg_experienceeventconfig_get,argtable[1])
self.group=argtable[2]
self.experience=argtable[3]
self.progress=argtable[4]
self.task=argtable[5]

self.TextTitlle:setText(self.cfg.name)
self.TextContent:setText(self.cfg.content)
if self.cfg.background then
self.ImagePicture:setSprite(imageAB,self.cfg.background)
end
local itemCnt=#self.cfg.items
local showCnt=itemCnt+1
self.ItemList:freshGridsNum(showCnt,showCnt,1,false)
for i=1,itemCnt do
local itemData=self.cfg.items[i]
local item=self.ItemList:getGridObjectByindex(i-1)
item:SetChildText(itemKid.nameTx,itemData.name)
if itemData.icon then
item:SetChildIcon(itemKid.iconImg,itemData.icon,false)
end
item:SetChildButtonClickWithID(itemKid.bgBtn,self.onClickItem,i)
end

local item=self.ItemList:getGridObjectByindex(showCnt-1)
item:SetChildText(itemKid.nameTx,"离开")
item:SetChildButtonClick(itemKid.bgBtn,function()self:onClickClose()end)

local record=worldExperienceModel:getEventSelection(self.experience)

if record then
self.ItemList:setActive(false)
local itemData=self.cfg.items[record]
UIManager:showWindow("UIWorldExperienceEventRewardWin",
{itemData.id,self.group,self.experience,self.progress,self.task})
end
end


function UIWorldExperienceEventWin:onHide()

end



function UIWorldExperienceEventWin:onClickClose()
self:closeSelf()
end

function UIWorldExperienceEventWin.onClickItem(i)
local itemData=_this.cfg.items[i]





worldExperienceModel:setEventSelection(_this.experience,i)
worldExperienceController:saveExperienceEventDataToServer()
_this.ItemList:setActive(false)
worldExperienceController:send_5_6(_this.group,_this.progress,itemData.id)
end









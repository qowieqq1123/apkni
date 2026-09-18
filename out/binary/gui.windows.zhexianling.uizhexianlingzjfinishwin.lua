







def_class("UIZheXianLingZJFinishWin",UIWindowBase)









function UIZheXianLingZJFinishWin:bindComponents()

self.spine=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.nameChapter=UIText.get(self,2)
self.name=UIText.get(self,3)
self.itemsRoot=UIObject.get(self,4)
self.wanfaItem1=UIObject.get(self,5)
self.wanfaItem2=UIObject.get(self,6)
self.item1=UIObject.get(self,7)
self.item2=UIObject.get(self,8)



end


function UIZheXianLingZJFinishWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.nameChapter);self.nameChapter=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.itemsRoot);self.itemsRoot=nil;
_UIObject_release(self.wanfaItem1);self.wanfaItem1=nil;
_UIObject_release(self.wanfaItem2);self.wanfaItem2=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
end


















function UIZheXianLingZJFinishWin:onLoaded(...)
self:bindComponents()
self.wanfalist={}
local wanfalist=self.wanfalist
wanfalist[#wanfalist+1]=self.wanfaItem1
wanfalist[#wanfalist+1]=self.wanfaItem2

self.itemslist={}
local itemslist=self.itemslist
itemslist[#itemslist+1]=self.item1
itemslist[#itemslist+1]=self.item2
itemslist[#itemslist+1]=self.item3
itemslist[#itemslist+1]=self.item4

self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),0)
self.winlua:SetChildSpineAnimation(self.spine:getID(),2053,1,function()



end)
self:delayDo(0.5,function()
if self and not self.isClose then
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.3)
end
end)
end

function UIZheXianLingZJFinishWin:__delete()
self:unbindComponents()
end

function UIZheXianLingZJFinishWin:onShow(argtable,afterOnloaded)
local book_id=argtable.bookid
local chapter_id=argtable.chapterid
local index=argtable.index

local chapterCfg=zheXianLingConfig.getChapterconfig(chapter_id)
local name=chapterCfg.name
local unlockCfgs=chapterCfg.unlock
self.name:setText(name)
local bookid,index=zheXianLingConfig.getChapterIndex(chapter_id)
local chapterStr=mathHelper.numberToChinese(index)
self.nameChapter:setText(FMT.fmt('第{0}章',chapterStr))

for i,v in ipairs(self.wanfalist)do
local wanfaitem=v
local widget=wanfaitem:getWidgetBase()
local cfg=unlockCfgs[i]
local hasCfg=cfg~=nil
widget:SetChildActive(-1,hasCfg)
if hasCfg then
local args=cfg[2]
local iconName=args[1]
local desc=args[2]
local weakGuide=args[3]
local name=args[4]
widget:SetChildIcon(0,iconName,false)
widget:SetChildText(1,desc)
widget:SetChildActive(2,true)
widget:SetChildActive(3,true)
widget:SetChildText(4,name)
widget:SetChildButtonClick(3,function()
UIFullZheXianControl:closeUI()
weakGuideController:beginGuide(weakGuide)
self:closeSelf()
end,true)
end
end

local rewards=chapterCfg.rewards
local temp={}
for i,v in ipairs(rewards)do
local t=cfgHelper.get(cfg_awardconfig_get,v).showItems
temp=table.concatTableXX(temp,t)
end
for i=1,2 do
local reward=temp[i]
local hasReward=reward~=nil
local itemSlot=self.itemslist[i]
itemSlot:setActive(hasReward)
if hasReward then
local widget=itemSlot:getWidgetBase()
local itemid=reward[1]
local num=reward[2]
local conf={itemid=itemid,itemcount=num>1 and num or'',range=reward.range}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
local widget1=widget:GetChildWidgetBase(0)
widget1:SetPropData(propData)
widget1:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)
end
end
end

function UIZheXianLingZJFinishWin:onHide()

end




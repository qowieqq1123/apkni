







def_class("UITianMoJieFightResultWin",UIWindowBase)









function UITianMoJieFightResultWin:bindComponents()

self.contentTx=UIText.get(self,0)
self.infos=UIObject.get(self,1)
self.itemList=UIObject.get(self,2)
self.progressBar=UIProgressBarAni.get(self,3)
self.progressTips=UIText.get(self,4)
self.progressTx=UIText.get(self,5)
self.scrollView=UIObject.get(self,6)



end


function UITianMoJieFightResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.contentTx);self.contentTx=nil;
_UIObject_release(self.infos);self.infos=nil;
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressTips);self.progressTips=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
end















local _this=nil



function UITianMoJieFightResultWin:onLoaded(...)
self:bindComponents()
_this=self
self.winlua:SetProgressBarAniUpdateAction(self.progressBar:getID(),function(...)
self:onUpdateProgress(...)
end)
self.winlua:SetProgressBarAniFinishAction(self.progressBar:getID(),function(...)
self:onFinishProgress(...)
end)
end


function UITianMoJieFightResultWin:__delete()
self:unbindComponents()
_this=nil
end




function UITianMoJieFightResultWin:onShow(argtable,afterOnloaded)

self.argtable=argtable
self:refreshView()
self:delayDo(1.3,function()
local progressData=self.argtable.progressData
if progressData and progressData.oldVal~=progressData.newVal then
self.progressing=true
self.winlua:SetProgressBarAniWithFiveParams(self.progressBar:getID(),progressData.oldVal,progressData.newVal,10000,1,progressData.oldVal>progressData.newVal)
end
end)
end


function UITianMoJieFightResultWin:onHide()

end



function UITianMoJieFightResultWin:onUpdateProgress(progress,deltaTime)
if self.progressing then
local percent=progress*10000
if percent>9999 and percent<10000 then
percent=9999
end
percent=math.ceil(percent)
if percent==self.newVal then
self:onFinishProgress()
return
end
if percent>0 then
percent=string.format("%.2f%%",percent/100)
else
percent="0%"
end
self.progressTx:setText(percent)
end
end

function UITianMoJieFightResultWin:onFinishProgress()
self.progressing=nil
self.progressTx:setText(FMT.fmt("{0}%",math.max(self.newVal/100,0)))
end

function UITianMoJieFightResultWin:refreshView()
self.contentTx:setActive(self.argtable.contentTx~=nil)
self.scrollView:setActive(self.argtable.rewardList~=nil)
self.progressBar:setActive(self.argtable.progressData~=nil)

if self.argtable.contentTx then
self.contentTx:setText(self.argtable.contentTx)
end
if self.argtable.rewardList then
self.itemList:setChildLayoutGroupCreateItems(#self.argtable.rewardList,function(index)
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
local rewardData=self.argtable.rewardList[index]
local itemId=rewardData.itemid
local itemNum=rewardData.num
local showCountBG=itemNum>1
local countStr=showCountBG and itemNum or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
end
if self.argtable.progressData then
self.newVal=self.argtable.progressData.newVal
self.progressTx:setText(FMT.fmt("{0}%",self.argtable.progressData.oldVal/100))
self.winlua:SetProgressBarAniWithThreeParams(self.progressBar:getID(),self.argtable.progressData.oldVal,10000,0)
self.progressTips:setText(self.argtable.progressData.tips or"")
end

self.winlua:ForceLayoutRect(self.infos:getID())
end
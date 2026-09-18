







def_class("UICJXYChapterRankScoreWayWin",UIWindowBase)









function UICJXYChapterRankScoreWayWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.jumpList=UIObject.get(self,2)
self.jumpView=UIObject.get(self,3)
self.tips=UIText.get(self,4)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UICJXYChapterRankScoreWayWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.jumpList);self.jumpList=nil;
_UIObject_release(self.jumpView);self.jumpView=nil;
_UIObject_release(self.tips);self.tips=nil;
end















local _this=nil
local _jumpCmp={
name=0,
bg=1,
}



function UICJXYChapterRankScoreWayWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UICJXYChapterRankScoreWayWin:__delete()
self:unbindComponents()
_this=nil
end




function UICJXYChapterRankScoreWayWin:onShow(argtable,afterOnloaded)
self.scoreName=argtable.scoreName
self.jumps=argtable.jumps
self.parentWin=argtable.parentWin
self.tips:setText(FMT.fmt("通过以下途径获取{0}，提升排名",self.scoreName))
self:refreshJumpView()
end


function UICJXYChapterRankScoreWayWin:onHide()

end




function UICJXYChapterRankScoreWayWin:onBackground()
self:onCloseBtn()
end


function UICJXYChapterRankScoreWayWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UICJXYChapterRankScoreWayWin:refreshJumpView()
self.jumpList:setChildLayoutGroupCreateItems(#self.jumps,function(index)
local item=self.jumpList:getChildLayoutGroupGridItem(index-1)
local jumpData=self.jumps[index]
item:SetChildText(_jumpCmp.name,jumpData[1])
item:SetChildButtonClick(_jumpCmp.bg,function()
if jumpData[2]then
jumpManager:jump(jumpData[2])
end
end)
end)
end
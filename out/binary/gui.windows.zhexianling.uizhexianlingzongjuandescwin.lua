







def_class("UIZheXianLingZongJuanDescWin",UIWindowBase)









function UIZheXianLingZongJuanDescWin:bindComponents()

self.name=UIText.get(self,0)
self.wanfaIcon=UIObject.get(self,1)
self.wanfaDesc=UIText.get(self,2)
self.btnGo=UIButton.get(self,3)
self.nameChapter=UIText.get(self,4)
self.wanfaName=UIText.get(self,5)
self.spine=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.btnBlight=UIButton.get(self,8)
self.title=UIText.get(self,9)

self.btnGo:setButtonClick(function()self:onBtnGo()end)

self.btnBlight:setButtonClick(function()self:onBtnBlight()end)



end


function UIZheXianLingZongJuanDescWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.wanfaIcon);self.wanfaIcon=nil;
_UIObject_release(self.wanfaDesc);self.wanfaDesc=nil;
_UIObject_release(self.btnGo);self.btnGo=nil;
_UIObject_release(self.nameChapter);self.nameChapter=nil;
_UIObject_release(self.wanfaName);self.wanfaName=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.btnBlight);self.btnBlight=nil;
_UIObject_release(self.title);self.title=nil;
end


















function UIZheXianLingZongJuanDescWin:onLoaded(...)
self:bindComponents()
self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),0)
self.winlua:SetChildSpineAnimation(self.spine:getID(),2053,1,function()



end)
self:delayDo(0.5,function()
if self and not self.isClose then
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.3)
end
end)
end

function UIZheXianLingZongJuanDescWin:__delete()
self:unbindComponents()
end

function UIZheXianLingZongJuanDescWin:onShow(argtable,afterOnloaded)
local book_id=argtable.bookid
local chapter_id=argtable.chapterid
self.book_id=book_id
self.chapter_id=chapter_id
local bookid,index=zheXianLingConfig.getChapterIndex(chapter_id)
local chapterStr=mathHelper.numberToChinese(index)
local bookCfg=zheXianLingConfig.getBookconfig(book_id)
local book_id_str=mathHelper.numberToChinese(book_id)
local wanfamodel=bookCfg.wanfamodel
local offsetX=wanfamodel[3]or 0
local offsetY=wanfamodel[4]or 0
local name=bookCfg.name
local isFinish=zheXianLingModel:isFinishCurrentBook()
self.name:setText(name)
self.wanfaDesc:setText(bookCfg.wanfadesc)
self.wanfaIcon:setChildUIModelShowTarget(wanfamodel[1],wanfamodel[2],nil,eAnimationID.idle)
if offsetX~=0 or offsetY~=0 then
self.wanfaIcon:setLocalPos(offsetX,offsetY,0)
end
self.nameChapter:setText(FMT.fmt('卷{0}',book_id_str))
self.wanfaName:setText(bookCfg.wanfatitle)
self.btnBlight:setActive(isFinish)
self.btnGo:setActive(not isFinish)
self.title:setActive(not isFinish)
end

function UIZheXianLingZongJuanDescWin:onHide()

end





function UIZheXianLingZongJuanDescWin:onBtnGo()
zheXianLingController:freshMainWindow('onBtnZJ')
UIManager:closeWindow('UIZheXianLingZongJuanDescWin')
end

function UIZheXianLingZongJuanDescWin:onBtnBlight()
if not zheXianLingModel:isRewardCurrentBook()then
local data=zheXianLingModel:getData()
local book_id=data.book_id
socketManager:send_27_3(1,book_id)
UIFullZheXianControl:closeUI(true,true)
self:closeSelf()
end
end

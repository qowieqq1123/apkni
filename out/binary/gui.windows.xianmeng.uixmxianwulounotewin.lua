







def_class("UIXMXianWuLouNoteWin",UIWindowBase)









function UIXMXianWuLouNoteWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.noNoteSign=UIObject.get(self,1)
self.noteListGrid=UIObject.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXMXianWuLouNoteWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.noNoteSign);self.noNoteSign=nil;
_UIObject_release(self.noteListGrid);self.noteListGrid=nil;
end
















local _this=nil


function UIXMXianWuLouNoteWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXMXianWuLouNoteWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXMXianWuLouNoteWin:onHide()

end




function UIXMXianWuLouNoteWin:onShow(argtable,afterOnloaded)
self:refreshView()
end

function UIXMXianWuLouNoteWin:refreshView()
self.noteslist=xianmengModel:getXWLNotes()
local num=#self.noteslist
local has=num>0
self.noNoteSign:setActive(not has)
if has then
local callback=function(idx)
if _this==nil then
return
end
_this:refreshItem(nil,idx)
end
self.noteListGrid:setChildLayoutGroupCreateItems(num,callback)
end
end

function UIXMXianWuLouNoteWin:refreshItem(item,idx)
if item==nil then
item=self.noteListGrid:getChildLayoutGroupGridItem(idx-1)
end

local noteData=self.noteslist[idx]
item:SetChildText(0,self.getNoteDesc(noteData))
end

function UIXMXianWuLouNoteWin:onCloseBtn()
self:closeSelf()
end

function UIXMXianWuLouNoteWin.getNoteDesc(noteData)
local name=chatLinkHelper.getItemText2(noteData.itemId)
return FMT.fmt('<color=#ca631d>{0}</color>开启{1}阶宝箱获得{2}',noteData.playerName,noteData.boxLevel,name)
end








def_class("UIXM_LXWJ_notesWin",UIWindowBase)









function UIXM_LXWJ_notesWin:bindComponents()

self.root=UIObject.get(self,0)
self.notesScrollView=UIObject.get(self,1)
self.noItemTips=UIText.get(self,2)
self.notesGridPanel=UIObject.get(self,3)



end


function UIXM_LXWJ_notesWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.notesScrollView);self.notesScrollView=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.notesGridPanel);self.notesGridPanel=nil;
end
















local _this=nil


function UIXM_LXWJ_notesWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_notesWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_notesWin:onHide()

end




function UIXM_LXWJ_notesWin:onShow(argtable,afterOnloaded)
local needRefresh=lingxuwenjianModel:checkRefreshNotes()
if not needRefresh then
self:refreshView()
else
self.root:setActive(false)
end
end

function UIXM_LXWJ_notesWin:refreshView()
self.root:setActive(true)
self.notesList=lingxuwenjianModel:getNotesList()
local num=#self.notesList
local isShow=num>0
self.notesScrollView:setActive(isShow)
self.noItemTips:setActive(not isShow)
if isShow then
local func=function(i)
if _this==nil then return end
local item=_this.notesGridPanel:getChildLayoutGroupGridItem(i-1)
local data=_this.notesList[i]
local note_str=lingxuwenjianModel:getNoteDesc(data)
item:SetChildText(0,note_str)
end
self.notesGridPanel:setChildLayoutGroupCreateItems(num,func)
else
self.noItemTips:setText('暂无战报')
end
end

function UIXM_LXWJ_notesWin:rec_noteslist()
self:refreshView()
end








def_class("UIXM_XMDG_NoteWin",UIWindowBase)









function UIXM_XMDG_NoteWin:bindComponents()

self.root=UIObject.get(self,0)
self.noItemTips=UIText.get(self,1)
self.allToggle=UIToggleButton.get(self,2)
self.canToggle=UIToggleButton.get(self,3)
self.itemGridPanel=UIObject.get(self,4)



end


function UIXM_XMDG_NoteWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.allToggle);self.allToggle=nil;
_UIObject_release(self.canToggle);self.canToggle=nil;
_UIObject_release(self.itemGridPanel);self.itemGridPanel=nil;
end
















local _this=nil


function UIXM_XMDG_NoteWin:onLoaded(...)
_this=self
self:bindComponents()
self.toggleType=1
self.allToggle:setToggleChange(function(name,isOn)
self:onToggleChange(1,isOn)
end)
self.canToggle:setToggleChange(function(name,isOn)
self:onToggleChange(2,isOn)
end)
end

function UIXM_XMDG_NoteWin:onToggleChange(idx,isOn)
if isOn==true then
if self.toggleType==idx then
return
end
self.toggleType=idx
self:refrshNotes()
end
end


function UIXM_XMDG_NoteWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_XMDG_NoteWin:onHide()

end




function UIXM_XMDG_NoteWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
local needNew=xianmengdigongModel:checkOpenNote()
local isshow=needNew==false

if isshow then
self:refreshView()
else
self.root:setActive(false)
self.noItemTips:setActive(false)
end
end

function UIXM_XMDG_NoteWin:refreshView()
self.notesList=xianmengdigongModel:getDGNotes()
self.can_notesList={}
local c=#self.notesList
if c>0 then
for i,note in ipairs(self.notesList)do
if note:canGo()then
table.insert(self.can_notesList,note)
end
end
end
local isshow=c>0
self.root:setActive(true)
self.noItemTips:setActive(not isshow)
self:refrshNotes()
end

function UIXM_XMDG_NoteWin:refrshNotes()
if self.toggleType==1 then
self.curNotesList=self.notesList
else
self.curNotesList=self.can_notesList
end
local c=#self.curNotesList
self.itemGridPanel:setChildLayoutGroupCreateItems(c,function(idx)
if _this==nil then return end
_this:initGridItem(nil,idx)
end)
local isshow=c>0
self.noItemTips:setActive(not isshow)
end

function UIXM_XMDG_NoteWin:initGridItem(item,idx)
if item==nil then
item=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)
end

local note=self.curNotesList[idx]

local iconname
if note.icon==2 then
iconname='icon_xmjdxiangxiui_2'
else
iconname='icon_xmjdxiangxiui_1'
end
item:SetChildCSImageSprite(0,globalABLookup.xmdgmainicons,iconname)

local desc=note.desc
item:SetChildText(1,desc)

local showgo=note:canGo()
item:SetChildActive(2,showgo)
if showgo then
item:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onGoBtnClick(idx)
end)
end
item:SetChildActive(4,xianmengdigongModel:getDGNoteReddot(note))

local showfinish=not showgo and note.showgo
item:SetChildActive(3,showfinish)
end

function UIXM_XMDG_NoteWin:onClickClose()
UIManager:invokeUIMethod(self.parentWin,'onClickClose')
end

function UIXM_XMDG_NoteWin:onGoBtnClick(idx)
local note=self.curNotesList[idx]

local flag=note:jump()
if flag then
if _this==nil then return end
_this:onClickClose()
end
end

function UIXM_XMDG_NoteWin:rec_notes()
self:refreshView()
end

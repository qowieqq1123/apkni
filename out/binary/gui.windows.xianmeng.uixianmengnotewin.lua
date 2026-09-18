







def_class("UIXianMengNoteWin",UIWindowBase)









function UIXianMengNoteWin:bindComponents()

self.noteListPanel=UIObject.get(self,0)



end


function UIXianMengNoteWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.noteListPanel);self.noteListPanel=nil;
end

















function UIXianMengNoteWin:onLoaded(...)
self:bindComponents()
end


function UIXianMengNoteWin:__delete()
self:unbindComponents()

AudioManager.playBtnClick()
end


function UIXianMengNoteWin:onHide()

end




function UIXianMengNoteWin:onShow(argtable,afterOnloaded)
self:refreshView()
end

function UIXianMengNoteWin:refreshView()
local list=xianmengModel:getXMNotes()
local temp={}
for i,v in ipairs(list)do
table.insert(temp,v)
end
if#temp>1 then
table.sort(temp,function(a,b)
return a.timesec>b.timesec
end)
end
self.noteDataList=temp

local c=#self.noteDataList
self.noteListPanel:setChildScrollViewCreateGrids(c,1)

local grids=self.noteListPanel:getChildScrollViewItemWidgets()
for i=1,c do
self:refreshItem(grids[i-1],i)
end
end

function UIXianMengNoteWin:refreshItem(item,index)
if item==nil then
item=self.noteListPanel:getChildScrollViewItemWidget(index-1)
end

local noteData=self.noteDataList[index]

local logstr,timestr=xianmengModel:getXMNoteDesc(noteData)
item:SetChildText(0,logstr)
item:SetChildText(1,timestr)
end
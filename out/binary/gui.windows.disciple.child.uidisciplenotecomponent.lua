







def_class("UIDiscipleNoteComponent",UIWindowBase)









function UIDiscipleNoteComponent:bindComponents()

self.notelist=UIObject.get(self,0)
self.button1=UIButton.get(self,1)
self.button2=UIButton.get(self,2)
self.selected1=UIObject.get(self,3)
self.selected2=UIObject.get(self,4)

self.button1:setButtonClick(function()self:onButton1()end)

self.button2:setButtonClick(function()self:onButton2()end)



end


function UIDiscipleNoteComponent:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.notelist);self.notelist=nil;
_UIObject_release(self.button1);self.button1=nil;
_UIObject_release(self.button2);self.button2=nil;
_UIObject_release(self.selected1);self.selected1=nil;
_UIObject_release(self.selected2);self.selected2=nil;
end



















function UIDiscipleNoteComponent:onLoaded(...)
self:bindComponents()
end


function UIDiscipleNoteComponent:__delete()
self:unbindComponents()
self.disciple_guid=nil
self.selected=nil
end




function UIDiscipleNoteComponent:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.selected=nil
self:onButton1()












end


function UIDiscipleNoteComponent:onHide()

end



function UIDiscipleNoteComponent:onButton1()
self:onSelect(1)
end

function UIDiscipleNoteComponent:onButton2()
self:onSelect(2)
end

function UIDiscipleNoteComponent:onSelect(index)
if index~=self.selected then
if self.selected then
self:onSelectShow(self.selected,false)
end
self.selected=index
self:onSelectShow(self.selected,true)
self:onViewChange(self.selected)
end
end

function UIDiscipleNoteComponent:onSelectShow(index,show)
local selectImageName=FMT.fmt("selected{0}",index)
self[selectImageName]:setActive(show)
end

function UIDiscipleNoteComponent:onViewChange(index)
local dataList=self:getViewData(index)
local num=#dataList
self.notelist:setChildLayoutGroupCreateItems(num)
local gridlist=self.notelist:getChildLayoutGroupGridList()
if num>0 then
for i=1,num do
local item=gridlist[i-1]
local notedata=dataList[i]
local desc_str=discipleNoteModel.getNoteDesc(self.disciple_guid,notedata)
item:SetChildText(0,desc_str)
end
end
end

function UIDiscipleNoteComponent:getViewData(index)
local dataFuncName=FMT.fmt("getViewData{0}",index)
return self[dataFuncName](self)
end

function UIDiscipleNoteComponent:getViewData1()
return discipleNoteDataSet:getNoteList(self.disciple_guid)
end

function UIDiscipleNoteComponent:getViewData2()
return discipleNoteDataSet:getSPNoteList(self.disciple_guid)
end








def_class("discipleNoteView",UICloneObject)





discipleNoteView.abName="ui/windows/disciple/child/disciplenoteview.ab"

discipleNoteView.assetName="discipleNoteView"


function discipleNoteView:bindComponents()

self.notelist=UIObject.get(self,0)

end


function discipleNoteView:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.notelist);self.notelist=nil;
end









function discipleNoteView:onLoaded(...)
self:bindComponents()
end


function discipleNoteView:__delete()
self:unbindComponents()
self.disciple_guid=nil
end




function discipleNoteView:onShow(argtable,afterOnloaded)
if argtable.force or self.disciple_guid~=argtable.guid then
self.disciple_guid=argtable.guid
self.listData=discipleNoteDataSet:getNoteList(self.disciple_guid)
local num=#self.listData
self.notelist:setChildLayoutGroupCreateItems(num)
local gridlist=self.notelist:getChildLayoutGroupGridList()
if num>0 then
for i=1,num do
local item=gridlist[i-1]
local notedata=self.listData[i]
local desc_str=discipleNoteModel.getNoteDesc(self.disciple_guid,notedata)
item:SetChildText(0,desc_str)
end
end
end
end


function discipleNoteView:onHide()

end



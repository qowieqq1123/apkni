







def_class("UIDiscipleGUIDCopylWin",UIWindowBase)









function UIDiscipleGUIDCopylWin:bindComponents()

self.discipleListPanel=UIObject.get(self,0)



end


function UIDiscipleGUIDCopylWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.discipleListPanel);self.discipleListPanel=nil;
end
















local WriteInCopyBuffer=CS.UIHelper.WriteInCopyBuffer


function UIDiscipleGUIDCopylWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleGUIDCopylWin:__delete()
self:unbindComponents()
end




function UIDiscipleGUIDCopylWin:onShow(argtable,afterOnloaded)
self.sortType=argtable.sortType
self.sortCondition=argtable.sortCondition
self.sortOrder=argtable.sortOrder
self:getNetDataList()
self:initListPanel()
end


function UIDiscipleGUIDCopylWin:OnEnable()

end


function UIDiscipleGUIDCopylWin:OnDisable()

end

function UIDiscipleGUIDCopylWin:getNetDataList()
local list=discipleLookup:getSortDiscipleList(self.sortType,self.sortCondition,self.sortOrder)
self.disciplesList=list
end

function UIDiscipleGUIDCopylWin:initListPanel()
local dataNum=#self.disciplesList
self.discipleListPanel:setChildLayoutGroupCreateItems(dataNum)
local grids=self.discipleListPanel:getChildLayoutGroupGridList()
for i=1,dataNum do
local item=grids[i-1]
local netData=self.disciplesList[i].netData.net
item:SetChildText(0,FMT.fmt('{0}:{1}',netData.disciplename,tostring(netData.discipleguid)))
item:SetChildButtonClick(1,function()
self:onCopyBtnClick(i)
end)
end
end

function UIDiscipleGUIDCopylWin:onCopyBtnClick(idx)
local netData=self.disciplesList[idx].netData.net
WriteInCopyBuffer(tostring(netData.discipleguid))
end
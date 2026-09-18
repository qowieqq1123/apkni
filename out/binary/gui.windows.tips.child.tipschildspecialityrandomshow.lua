







def_class("tipsChildSpecialityRandomShow",UICloneObject)





tipsChildSpecialityRandomShow.abName="ui/windows/tips/child/tipschildspecialityrandomshow.ab"

tipsChildSpecialityRandomShow.assetName="tipsChildSpecialityRandomShow"


function tipsChildSpecialityRandomShow:bindComponents()

self.pageGrid=UIObject.get(self,0)

end


function tipsChildSpecialityRandomShow:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.pageGrid);self.pageGrid=nil;
end







function tipsChildSpecialityRandomShow:onLoaded(...)
self:bindComponents()
end


function tipsChildSpecialityRandomShow:__delete()
self:unbindComponents()
end


function tipsChildSpecialityRandomShow:onHide()

end




function tipsChildSpecialityRandomShow:onShow(argtable,afterOnloaded)
local argData=argtable.argtable
local itemid=argData.itemid
local itemguid=argData.itemguid
local attach=argData.attach
local move=argData.move
local pos=TIPS_MOVE_POS:getShowPos(move)

local speRandomShowList=attach.speRandomShowList


local num=#speRandomShowList
self.pageGrid:setChildLayoutGroupCreateItems(num)
local pages=self.pageGrid:getChildLayoutGroupGridList()
for i=1,num do
local pageItem=pages[i-1]
local data=speRandomShowList[i]
local speType=data.speType
local speIDList=data.speIDList

local name_str=UIDiscipleModel:getSpecialityTypeName(speType)
name_str=FMT.fmt('{0}预览',name_str)
pageItem:SetChildText(0,name_str)

local n=#speIDList
pageItem:SetChildLayoutGroupCreateItems(1,n)
local spes=pageItem:GetChildLayoutGroupGridList(1)
for i2=1,n do
local speItem=spes[i2-1]
local speID=speIDList[i2]
local cfg=UIDiscipleModel:getSpecialityConfig(speType,speID)
speItem:SetChildActive(-1,true)
UIDiscipleModel.refreshSpecialityItem(speItem,cfg,function()
UIManager:showWindow('UISpecialityTwoWin',{pos=pos,config=cfg})
end)
end
end
end

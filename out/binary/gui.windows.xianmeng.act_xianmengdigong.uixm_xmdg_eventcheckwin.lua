







def_class("UIXM_XMDG_eventCheckWin",UIWindowBase)









function UIXM_XMDG_eventCheckWin:bindComponents()

self.noItemTips=UIText.get(self,0)
self.rolePanel=UIObject.get(self,1)



end


function UIXM_XMDG_eventCheckWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.rolePanel);self.rolePanel=nil;
end
















local _this=nil


function UIXM_XMDG_eventCheckWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_XMDG_eventCheckWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_XMDG_eventCheckWin:onHide()

end




function UIXM_XMDG_eventCheckWin:onShow(argtable,afterOnloaded)
self.roomid=argtable.roomid
self.eventPos=argtable.eventPos
self.m_room=xianmengdigongModel:getRoom(self.roomid)
self.m_event=self.m_room:getEvent(self.eventPos)

self:refreshView()
end

function UIXM_XMDG_eventCheckWin:initManList()
local m_event=self.m_event
self.manlist={}
if m_event.dzList then
for i,man in ipairs(m_event.dzList)do
table.insert(self.manlist,man)
end
end
end

function UIXM_XMDG_eventCheckWin:refreshView()
self:initManList()
local c=#self.manlist
self.rolePanel:setChildLayoutGroupCreateItems(c,function(idx)
if _this==nil then return end
_this:initRoleItem(nil,idx)
end)
self.noItemTips:setActive(c<=0)
end

function UIXM_XMDG_eventCheckWin:initRoleItem(item,idx)
if item==nil then
item=self.rolePanel:getChildLayoutGroupGridItem(idx-1)
end

local data=self.manlist[idx]

local image=UIDiscipleModel.calculationDiscipleImageBase(data)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelHeadIconBGByColor(item,0,image.color)
comHelper.setChildModelRawImageEx(1,item,modelParams,eHeadCenterType.eHead,1,false)

item:SetChildText(3,data.playerName)

local ismy=UIDiscipleModel:getMyDiscipleData(data.dzGuid)~=nil
item:SetChildActive(2,ismy)
end

function UIXM_XMDG_eventCheckWin:rec_event(room,event)
if self.m_room:compare(room)and self.m_event.eventPos==event.eventPos then
self:refreshView()
end
end
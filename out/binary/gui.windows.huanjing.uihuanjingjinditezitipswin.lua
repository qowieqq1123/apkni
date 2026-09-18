







def_class("UIHuanJingJinDiTeZiTipsWin",UIWindowBase)









function UIHuanJingJinDiTeZiTipsWin:bindComponents()

self.ButtonClose=UIButton.get(self,0)
self.descListPanel=UIObject.get(self,1)
self.DescTx=UIText.get(self,2)
self.NoteTx=UIText.get(self,3)
self.Root=UIObject.get(self,4)
self.ScrollView2=UIObject.get(self,5)
self.TitleTx=UIText.get(self,6)

self.ButtonClose:setButtonClick(function()self:onButtonClose()end)



end


function UIHuanJingJinDiTeZiTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ButtonClose);self.ButtonClose=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.DescTx);self.DescTx=nil;
_UIObject_release(self.NoteTx);self.NoteTx=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.ScrollView2);self.ScrollView2=nil;
_UIObject_release(self.TitleTx);self.TitleTx=nil;
end



















function UIHuanJingJinDiTeZiTipsWin:onLoaded(...)
self:bindComponents()
end


function UIHuanJingJinDiTeZiTipsWin:__delete()
self:unbindComponents()
end




function UIHuanJingJinDiTeZiTipsWin:onShow(argtable,afterOnloaded)
local id=argtable.id
local name=argtable.name
local desc=argtable.desc
local list=argtable.list
local note=argtable.note
self.desclist=list

self.TitleTx:setText(name)
self.DescTx:setText(desc)
if note then
self.ScrollView2:setActive(true)
self.NoteTx:setText(note)
else
self.ScrollView2:setActive(false)
end
local dataNum=#self.desclist
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local specialityType=self.desclist[i][1]
local sID=self.desclist[i][2]
local cfg=UIDiscipleModel:getSpecialityConfig(specialityType,sID)

local item=gridlist[i-1]
item:SetChildActive(-1,true)
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
self:onDescSlotClick(i)
end)
end
end
end


function UIHuanJingJinDiTeZiTipsWin:onHide()

end

function UIHuanJingJinDiTeZiTipsWin:onDescSlotClick(idx)
local specialityType=self.desclist[idx][1]
local sID=self.desclist[idx][2]
local cfg=UIDiscipleModel:getSpecialityConfig(specialityType,sID)
local item=self.descListPanel:getChildLayoutGroupGridItem(idx-1)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)

if idx>8 then
UIManager:showWindow('UISpecialityWin',{item=item,node='top',config=cfg,pivot=Vector2(0.5,0)})
else
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',config=cfg})
end
end

function UIHuanJingJinDiTeZiTipsWin:onClickClose()
self:closeSelf()
end





function UIHuanJingJinDiTeZiTipsWin:onButtonClose()
self:closeSelf()
end


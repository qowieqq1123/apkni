







def_class("UIXianJieArenaAct_dzListPanelWin",UIWindowBase)









function UIXianJieArenaAct_dzListPanelWin:bindComponents()

self.mask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.dzGridGroup=UIObject.get(self,2)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIXianJieArenaAct_dzListPanelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.dzGridGroup);self.dzGridGroup=nil;
end



















function UIXianJieArenaAct_dzListPanelWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieArenaAct_dzListPanelWin:__delete()
self:unbindComponents()
end




function UIXianJieArenaAct_dzListPanelWin:onShow(argtable,afterOnloaded)
self.dzList=argtable and argtable.dzList or{}
self.pos=argtable and argtable.pos or{0,0}
self.closeCallback=argtable and argtable.closeCallback
self:refresh()
end


function UIXianJieArenaAct_dzListPanelWin:onHide()

end

function UIXianJieArenaAct_dzListPanelWin:refresh()

self:setRootPos()


self:setDzGroup()
end


function UIXianJieArenaAct_dzListPanelWin:setRootPos()
if self.pos then
local pos_x=self.pos[1]or 0
local pos_y=self.pos[2]or 0
local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local dzCount=#self.dzList
local itemWidth=dzCount*(70+5)-5+20
local itemHeight=70
local halfItemWidth=itemWidth/2
local halfItemHeight=itemHeight/2
local halfWidth=UnityEngine.Screen.width/scaleFactor.x/2
local halfHeight=UnityEngine.Screen.height/scaleFactor.y/2
if pos_x-halfItemWidth<-halfWidth then
pos_x=-halfWidth+halfItemWidth
end
if pos_x+halfItemWidth>halfWidth then
pos_x=halfWidth-halfItemWidth
end

if pos_y-halfItemHeight<-halfHeight then
pos_y=-halfHeight+halfItemHeight
end
if pos_y+halfItemHeight>halfHeight then
pos_y=halfHeight-halfItemHeight
end

self.root:setChildAnchoredPos(pos_x,pos_y)
end
end


function UIXianJieArenaAct_dzListPanelWin:setDzGroup()
local dznum=#self.dzList
self.dzGridGroup:setChildLayoutGroupCreateItems(dznum,function(index)
local dzItem=self.dzGridGroup:getChildLayoutGroupGridItem(index-1)
local netData=self.dzList[index]

local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzItem,0,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,dzItem,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzItem:SetChildCSImageSprite(2,globalABLookup.global,jobicon)
end)
end




function UIXianJieArenaAct_dzListPanelWin:onMask()
if self.closeCallback then
local cb=self.closeCallback
cb()
end

self:closeSelf()
end


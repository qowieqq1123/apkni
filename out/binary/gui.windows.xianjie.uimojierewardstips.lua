







def_class("UIMoJieRewardsTips",UIWindowBase)









function UIMoJieRewardsTips:bindComponents()

self.Root=UIObject.get(self,0)
self.uiRoot=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.arr=UIObject.get(self,3)
self.title=UIText.get(self,4)
self.rewardView=UIObject.get(self,5)
self.rewardPanel=UIObject.get(self,6)



end


function UIMoJieRewardsTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.arr);self.arr=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
end
















local _this



function UIMoJieRewardsTips:onLoaded(...)
self:bindComponents()
_this=self
end


function UIMoJieRewardsTips:__delete()
self:unbindComponents()
local cb=self.callback
if cb then
cb()
end
_this=nil
end




function UIMoJieRewardsTips:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
local pos=nil
if argtable.posItem then
pos=argtable.posItem:getChildScreenPointToLocalPointRectangle()
elseif argtable.posWidget then
local posWidgetIndex=argtable.posWidgetIndex or-1
pos=argtable.posWidget:GetChildScreenPointToLocalPointRectangle(posWidgetIndex)
end
if pos then
local p=argtable.pos or{x=0,y=0}
pos.x=pos.x+p.x
pos.y=pos.y+p.y
else
pos=argtable.pos or Vector2.zero
end

self.pos=pos
local exparem=argtable.exparem

local root=self.root
if exparem then
root:setChildLocalPosition(Vector3.New(exparem[1][1],exparem[1][2],exparem[1][3]))
self.arr:setChildLocalPosition(Vector3.New(exparem[2][1],exparem[2][2],exparem[2][3]))
self.arr:setRotation(exparem[3][1],exparem[3][2],exparem[3][3])
else
root:setChildLocalPosition(Vector3.New(self.pos.x,self.pos.y,0))
end
root:setChildCanvasGroupAlpha(0)
root:setChildCanvasGroupDOFade(1,0.6,nil)
root:setScale(Vector3.New(1,1,1))


local title=argtable.title or''
local rewardlist=argtable.rewardlist or{}

self.title:setText(title)

self:freahrewards(rewardlist)
end


function UIMoJieRewardsTips:onHide()

end


function UIMoJieRewardsTips:freahrewards(rewards)
local rnum=#rewards
if rnum>0 then
self.rewardPanel:setChildLayoutGroupCreateItems(rnum)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,rnum do
local rwItem=grids[i-1]
local itemData=rewards[i]
local itemid=itemData[1]
local itemnum=itemData[2]
local percent=itemData[4]
local isxmkf=itemData.isxmkf or false
local itemcount,showCountBG
local isShowPercent=percent~=nil
local range
if percent then
showCountBG=false
itemcount=""
else
range=itemData.range
if itemnum>1 or itemData.range~=nil then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false,range=range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildPropData(0,prop)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then
return
end
_this:onClickItem(...)
end)

local showSign=itemnum<=0 and itemData.range==nil and percent==nil
rwItem:SetChildActive(1,showSign)
rwItem:SetChildActive(2,isShowPercent)
if isShowPercent then
rwItem:SetChildText(3,FMT.fmt("{0}%",percent))
end
rwItem:SetChildActive(4,isxmkf)
end
self.rewardView:setChildScrollRectEnable(rnum>=5)
end
end
function UIMoJieRewardsTips:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end
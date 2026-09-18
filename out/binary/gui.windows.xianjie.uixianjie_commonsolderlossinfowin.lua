







def_class("UIXianJie_commonSolderLossInfoWin",UIWindowBase)









function UIXianJie_commonSolderLossInfoWin:bindComponents()

self.mask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.qsAllNumText=UIText.get(self,2)
self.zsAllNumText=UIText.get(self,3)
self.swAllNumText=UIText.get(self,4)
self.showAllLvBtn=UIButton.get(self,5)
self.unSelectBg=UIObject.get(self,6)
self.selectBg=UIObject.get(self,7)
self.extraList=UIObject.get(self,8)

self.mask:setButtonClick(function()self:onMask()end)

self.showAllLvBtn:setButtonClick(function()self:onShowAllLvBtn()end)



end


function UIXianJie_commonSolderLossInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.qsAllNumText);self.qsAllNumText=nil;
_UIObject_release(self.zsAllNumText);self.zsAllNumText=nil;
_UIObject_release(self.swAllNumText);self.swAllNumText=nil;
_UIObject_release(self.showAllLvBtn);self.showAllLvBtn=nil;
_UIObject_release(self.unSelectBg);self.unSelectBg=nil;
_UIObject_release(self.selectBg);self.selectBg=nil;
_UIObject_release(self.extraList);self.extraList=nil;
end



















function UIXianJie_commonSolderLossInfoWin:onLoaded(...)
self:bindComponents()
end


function UIXianJie_commonSolderLossInfoWin:__delete()
self:unbindComponents()
end




function UIXianJie_commonSolderLossInfoWin:onShow(argtable,afterOnloaded)
self.soldierList=argtable and argtable.soldierList or{}
self.pos=argtable and argtable.pos or{0,0}
self.closeCallback=argtable and argtable.closeCallback
self.isShowExtraList=false
self:initSoldierData()
self:refresh()
end


function UIXianJie_commonSolderLossInfoWin:onHide()

end

function UIXianJie_commonSolderLossInfoWin:initSoldierData()
local qsAllNum=0
local zsAllNum=0
local swAllNum=0
self.deadSoldierList={}
for i,v in ipairs(self.soldierList)do
local soldierId=v.id
local qsNum=v.qsNum
local zsNum=v.zsNum
local swNum=v.swNum
if swNum>0 then
self.deadSoldierList[#self.deadSoldierList+1]={soldierId,swNum}
end
qsAllNum=qsAllNum+qsNum
zsAllNum=zsAllNum+zsNum
swAllNum=swAllNum+swNum
end

self.baseData={
qsAllNum=qsAllNum,
zsAllNum=zsAllNum,
swAllNum=swAllNum,
}


table.sort(self.deadSoldierList,function(a,b)
return a[1]<b[1]
end)
end

function UIXianJie_commonSolderLossInfoWin:refresh()

self:setRootPos()

local qsAllNum=self.baseData.qsAllNum
local zsAllNum=self.baseData.zsAllNum
local swAllNum=self.baseData.swAllNum


self.qsAllNumText:setText(FMT.fmt("轻伤修士：{0}",mathHelper.formatNumber4(qsAllNum,1)))


self.zsAllNumText:setText(FMT.fmt("重伤修士：{0}",mathHelper.formatNumber4(zsAllNum,1)))


self.swAllNumText:setText(FMT.fmt("战陨修士：{0}",mathHelper.formatNumber4(swAllNum,1)))


local isShowBtn=#self.deadSoldierList>0
self.showAllLvBtn:setActive(isShowBtn)
if isShowBtn then
self.unSelectBg:setActive(not self.isShowExtraList)
self.selectBg:setActive(self.isShowExtraList)
end


self.extraList:setActive(self.isShowExtraList)
if self.isShowExtraList then
self.extraList:setChildLayoutGroupCreateItems(#self.deadSoldierList,function(index)
local widget=self.extraList:getChildLayoutGroupGridItem(index-1)
local data=self.deadSoldierList[index]
if data then
widget:SetChildActive(-1,true)
local soldierId=data[1]
local num=data[2]
local cfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,soldierId)
local soldierName=FMT.fmt("{0}修士",cfg and cfg.name or"未知")
local str=FMT.fmt("{0}：{1}",soldierName,mathHelper.formatNumber4(num,1))
widget:SetChildText(-1,str)
else
widget:SetChildActive(-1,false)
end
end)
end
end


function UIXianJie_commonSolderLossInfoWin:setRootPos()
if self.pos then
local pos_x=self.pos[1]or 0
local pos_y=self.pos[2]or 0
local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local soldierTypeCount=#self.deadSoldierList
local itemWidth=310
local extraListHeight=soldierTypeCount*(26+14)-14+18
local itemHeight=210
if self.isShowExtraList then
itemHeight=itemHeight+extraListHeight
end
local halfItemWidth=itemWidth/2

local halfWidth=UnityEngine.Screen.width/scaleFactor.x/2
local halfHeight=UnityEngine.Screen.height/scaleFactor.y/2
if pos_x-halfItemWidth<-halfWidth then
pos_x=-halfWidth+halfItemWidth
end
if pos_x+halfItemWidth>halfWidth then
pos_x=halfWidth-halfItemWidth
end

if pos_y-itemHeight<-halfHeight then
pos_y=-halfHeight+itemHeight
end
if pos_y>halfHeight then
pos_y=halfHeight
end

self.root:setChildAnchoredPos(pos_x,pos_y)
end
end

function UIXianJie_commonSolderLossInfoWin:changeExtraListShow()
self.isShowExtraList=not self.isShowExtraList
self:refresh()
end




function UIXianJie_commonSolderLossInfoWin:onMask()
if self.closeCallback then
local cb=self.closeCallback
cb()
end

self:closeSelf()
end



function UIXianJie_commonSolderLossInfoWin:onShowAllLvBtn()
self:changeExtraListShow()
end


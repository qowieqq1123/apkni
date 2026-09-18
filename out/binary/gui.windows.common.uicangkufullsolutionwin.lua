







def_class("UICangKuFullSolutionWin",UIWindowBase)









function UICangKuFullSolutionWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeTips=UIButton.get(self,1)
self.titleTxt=UIText.get(self,2)
self.solutionCreator=UIObject.get(self,3)

self.closeTips:setButtonClick(function()self:onCloseTips()end)



end


function UICangKuFullSolutionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.solutionCreator);self.solutionCreator=nil;
end
















local _this
local solutionCmpIndex={
icon=0,
name=1,
click=2,
tuijian=3,
}




function UICangKuFullSolutionWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UICangKuFullSolutionWin:__delete()
self:unbindComponents()
_this=nil
end




function UICangKuFullSolutionWin:onShow(argtable,afterOnloaded)
self.itemId=argtable.itemId
self.solutionTypeList=argtable.solutionTypeList
self.desc=argtable.desc
self:refresh(afterOnloaded)
end


function UICangKuFullSolutionWin:onHide()

end

function UICangKuFullSolutionWin:refresh(isInit)

local itemName=itemsModel.getName(self.itemId)
if not self.desc then
local tipsStr=FMT.fmt("仓库<color=#ca631d>{0}</color>容量已满，领取失败",itemName)
self.titleTxt:setText(tipsStr)
else
local tipsStr=FMT.fmt(self.desc,itemName)
self.titleTxt:setText(tipsStr)
end



local solutionTypeCount=#self.solutionTypeList
self.solutionCreator:setChildLayoutGroupCreateItems(solutionTypeCount)
local grids=self.solutionCreator:getChildLayoutGroupGridList()
for i=1,grids.Count do
local item=grids[i-1]
local solutionType=self.solutionTypeList[i]
local cfg=cfgHelper.get1(cfg_cangkufullsolutiontypeconfig_get,solutionType)
item:SetChildIcon(solutionCmpIndex.icon,FMT.fmt('icon_sjtp_{0}',cfg.icon),true)
item:SetChildText(solutionCmpIndex.name,cfg.name)
item:SetChildButtonClickWithID(solutionCmpIndex.click,self.onClickStrengthenItem,i,true)
local isTuiJian=i==1
item:SetChildActive(solutionCmpIndex.tuijian,isTuiJian)
end

if isInit then
self:delayDo(0.5,function(...)
self.solutionCreator:setChildCanvasGroupDOFade(1,0.5,nil)
local comp=self.solutionCreator:getCommonComponent('UITransitionMonoBehaviour')
comp.enabled=true
end)
end
end





function UICangKuFullSolutionWin:onCloseTips()
self:closeSelf()
end

function UICangKuFullSolutionWin.onClickStrengthenItem(index)
local solutionType=_this.solutionTypeList[index]
return cangkuFullSolutionController:JumpToSolutionShow(solutionType)
end
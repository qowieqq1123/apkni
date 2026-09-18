







def_class("UIAirGameFilterDiscipleWin",UIWindowBase)









function UIAirGameFilterDiscipleWin:bindComponents()

self.centerpanel=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.voclist=UIObject.get(self,2)



end


function UIAirGameFilterDiscipleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerpanel);self.centerpanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.voclist);self.voclist=nil;
end
















local CmpToggleItemIndex={
blackimg=0,
checkMark=1,
icon=2,
btn=3,
lable=4,
}




function UIAirGameFilterDiscipleWin:onLoaded(...)
self:bindComponents()
end


function UIAirGameFilterDiscipleWin:__delete()
self:unbindComponents()
end




function UIAirGameFilterDiscipleWin:onShow(argtable,afterOnloaded)
local vocList=airGameEnterConfig.getOpenVocCfgList()

local vocListLen=#vocList+1
local selectIndex
local createFunc=function(index)
local vocItem=self.voclist:getChildLayoutGroupGridItem(index-1)
local vocCfg

if index==1 then
vocCfg={id=0,name="全部"}
else
vocCfg=vocList[index-1]
end

vocItem:SetChildActive(CmpToggleItemIndex.icon,false)
vocItem:SetChildActive(CmpToggleItemIndex.lable,true)

local isShowMark=airGameEnterModel:checkFilterVocId(vocCfg.id)
vocItem:SetChildActive(CmpToggleItemIndex.checkMark,isShowMark)
if isShowMark then
selectIndex=index
end


vocItem:SetChildText(CmpToggleItemIndex.lable,vocCfg.name)





local clickFunc1=function()

isShowMark=not isShowMark
vocItem:SetChildActive(CmpToggleItemIndex.checkMark,isShowMark)


local flag=isShowMark and 1 or 0
airGameEnterModel:setVocFilterInfo(vocCfg.id,flag)
end

local clickFunc2=function()
local preVocItem=self.voclist:getChildLayoutGroupGridItem(selectIndex-1)
preVocItem:SetChildActive(CmpToggleItemIndex.checkMark,false)

selectIndex=index
vocItem:SetChildActive(CmpToggleItemIndex.checkMark,true)
airGameEnterModel:setFilterVocId(vocCfg.id)
end
vocItem:SetChildButtonClick(CmpToggleItemIndex.btn,clickFunc2,true)
end
self.voclist:setChildLayoutGroupCreateItems(vocListLen,createFunc)
end


function UIAirGameFilterDiscipleWin:onHide()

end




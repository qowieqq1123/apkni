







def_class("UISubAct_ChiSeJinDi_CopyDiscipleLevelUpWin",UIWindowBase)









function UISubAct_ChiSeJinDi_CopyDiscipleLevelUpWin:bindComponents()

self.attrList=UIObject.get(self,0)
self.background=UIButton.get(self,1)
self.head_1=UIObject.get(self,2)
self.head_2=UIObject.get(self,3)
self.headBg_1=UIImage.get(self,4)
self.headBg_2=UIImage.get(self,5)
self.headColor_1=UIImage.get(self,6)
self.headColor_2=UIImage.get(self,7)
self.nameTx=UIText.get(self,8)
self.starList_1=UIObject.get(self,9)
self.starList_2=UIObject.get(self,10)

self.background:setButtonClick(function()self:onBackground()end)
self.head={
self.head_1,
self.head_2,
}
self.headBg={
self.headBg_1,
self.headBg_2,
}
self.headColor={
self.headColor_1,
self.headColor_2,
}
self.starList={
self.starList_1,
self.starList_2,
}



end


function UISubAct_ChiSeJinDi_CopyDiscipleLevelUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrList);self.attrList=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.head_1);self.head_1=nil;
_UIObject_release(self.head_2);self.head_2=nil;
_UIObject_release(self.headBg_1);self.headBg_1=nil;
_UIObject_release(self.headBg_2);self.headBg_2=nil;
_UIObject_release(self.headColor_1);self.headColor_1=nil;
_UIObject_release(self.headColor_2);self.headColor_2=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.starList_1);self.starList_1=nil;
_UIObject_release(self.starList_2);self.starList_2=nil;
self.head=nil;
self.headBg=nil;
self.headColor=nil;
self.starList=nil;
end















local _this=nil
local _itemCmp={
old=0,
new=1,
root=2,
}
local _abName="ui/windows/activities/sub_chisejindi/chisejindi_atlas_pak.ab"



function UISubAct_ChiSeJinDi_CopyDiscipleLevelUpWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_ChiSeJinDi_CopyDiscipleLevelUpWin:__delete()
self:unbindComponents()
_this=nil

if self.sequence and self.sequence:IsActive()then
self.sequence:Kill()
end
end




function UISubAct_ChiSeJinDi_CopyDiscipleLevelUpWin:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.oldID=argtable.oldID
self.newID=argtable.newID
self.parentWin=argtable.parentWin
self.callback=argtable.callback
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self:refreshView()
end


function UISubAct_ChiSeJinDi_CopyDiscipleLevelUpWin:onHide()

end




function UISubAct_ChiSeJinDi_CopyDiscipleLevelUpWin:onBackground()
if self.callback then
self.callback()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
UIManager:closeWindow(self.__name)
end
end

function UISubAct_ChiSeJinDi_CopyDiscipleLevelUpWin:refreshView()
local oldServer=self.config.disciple[self.oldID]
local oldColor=oldServer[5]
local oldInside=self.config.discipleInside[self.oldID]
local oldAttrs=self.config.discipleAttr[self.oldID]
local oldStar=self.info:getCopyItemStar(self.oldID)
local oldModelParams={
body=oldInside[1],
componets=oldInside[2]or{},
}
comHelper.setChildModelHeadIconBGByColor(self.winlua,self.headBg_1:getID(),oldColor)
comHelper.setChildModelRawImageEx(self.head_1:getID(),self.winlua,oldModelParams,eHeadCenterType.eHead)
self.headColor_1:setSprite(_abName,FMT.fmt("image_chiseshilian_pz{0}",oldColor))
self.starList_1:setChildLayoutGroupCreateItems(oldStar)

local newServer=self.config.disciple[self.newID]
local newColor=newServer[5]
local newInside=self.config.discipleInside[self.newID]
local newAttrs=self.config.discipleAttr[self.newID]
local newStar=self.info:getCopyItemStar(self.newID)
local newModelParams={
body=newInside[1],
componets=newInside[2]or{},
}
comHelper.setChildModelHeadIconBGByColor(self.winlua,self.headBg_2:getID(),newColor)
comHelper.setChildModelRawImageEx(self.head_2:getID(),self.winlua,newModelParams,eHeadCenterType.eHead)
self.headColor_2:setSprite(_abName,FMT.fmt("image_chiseshilian_pz{0}",newColor))
self.starList_2:setChildLayoutGroupCreateItems(newStar)

local deltaAttrs={}
local oldAttrLookup=attrListHelper.tramsformToLookup(oldAttrs)
for i,v in ipairs(newAttrs)do
local attrType=v[1]
local nAttrValue=v[2]
local oAttrValue=oldAttrLookup[attrType]or 0
if nAttrValue>oAttrValue then
table.insert(deltaAttrs,v)
end
end
local deltaList=attrListHelper.sortByList(deltaAttrs)
self.attrList:setChildLayoutGroupCreateItems(#deltaList,function(index)
local item=self.attrList:getChildLayoutGroupGridItem(index-1)
local attrData=deltaList[index]
local attrType=attrData[1]
local nAttrValue=attrData[2]
local oAttrValue=oldAttrLookup[attrType]or 0
local attrName=helper.getAttributeName(attrType)
item:SetChildText(_itemCmp.old,FMT.fmt("{0}:   {1}",attrName,oAttrValue))
item:SetChildText(_itemCmp.new,FMT.fmt("{0}:   {1}",attrName,nAttrValue))
end)

if self.sequence and self.sequence:IsActive()then
self.sequence:Kill()
end
self.headBg_1:setChildCanvasGroupAlpha(1)
self.headBg_2:setChildCanvasGroupAlpha(0)
self.sequence=Lua.SequenceProxy.New()
local tweener1=self.headBg_1:setChildCanvasGroupDOFade(0,0.5)
local tweener2=self.headBg_2:setChildCanvasGroupDOFade(1,0.5)
self.sequence:Join(tweener1)
self.sequence:Join(tweener2)
end


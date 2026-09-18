







def_class("UIDiscipleLinggen_SelectMiBaoFuSelectWin",UIWindowBase)









function UIDiscipleLinggen_SelectMiBaoFuSelectWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.itemlist=UIScrollView.get(self,1)
self.mibaofuSelectPanel=UIObject.get(self,2)
self.Root=UIObject.get(self,3)
self.uiRoot=UIObject.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIDiscipleLinggen_SelectMiBaoFuSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemlist);self.itemlist=nil;
_UIObject_release(self.mibaofuSelectPanel);self.mibaofuSelectPanel=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIDiscipleLinggen_SelectMiBaoFuSelectWin:onLoaded(...)
self:bindComponents()

self.itemlist:bindScrollWidget(function(...)self:bindUseItem(...)end)
self.itemlist:setClickAction(function(...)self:onClickUseItem(...)end)
end


function UIDiscipleLinggen_SelectMiBaoFuSelectWin:__delete()
self:unbindComponents()
end




function UIDiscipleLinggen_SelectMiBaoFuSelectWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.disciple_guid
self.boardPosData=argtable.boardPosData
self.useItemData=argtable.useItemData


self.lglist,self.lglist_lookup,self.lglist_len=UIDiscipleModel:getDiscipleLingGenData(self.disciple_guid)
self.varySrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)

self.parentWin=argtable.parentWin
self.closeCallBack=argtable.closeCallBack

self:refeshView()
end


function UIDiscipleLinggen_SelectMiBaoFuSelectWin:onHide()

end





function UIDiscipleLinggen_SelectMiBaoFuSelectWin:onCloseBtn()
if self.closeCallBack then
self.closeCallBack()
end
self:closeSelf()
end


function UIDiscipleLinggen_SelectMiBaoFuSelectWin:refeshView()
self.itemDataList=UIDiscipleModel:getUseItemList(self.disciple_guid,self.boardPosData.pos)

self.itemlist:freshGridsNum(#self.itemDataList,#self.itemDataList,1,false)
end


function UIDiscipleLinggen_SelectMiBaoFuSelectWin:bindUseItem(index,item)
local data=self.itemDataList[index]

item:SetChildActive(-1,data~=nil)
if data then
local itemid=data.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local desc=itemCfg.funcparam and itemCfg.funcparam.desc or''

item:SetChildText(1,itemCfg.name)
item:SetChildText(2,desc)
item:SetChildActive(3,self.useItemData and self.useItemData.itemid==itemid)
local conf={
itemid=data.itemid,
itemcount=data.itemcount>1 and data.itemcount or'',
showCountBG=data.itemcount>1,
showname=false,
gray=data.isCanUse and 0 or 1,
}
local porpData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,porpData)
end
end

function UIDiscipleLinggen_SelectMiBaoFuSelectWin:onClickUseItem(id,index,guid,attch)
if not self.itemDataList[index].isCanUse then
local itemId=self.itemDataList[index].itemid
local itemName=itemsConfig.getItemName(itemId)

local errParams=self.itemDataList[index].errParams
if errParams then
local errorType=errParams.errorType
if errorType==1 then

local varyFlag=errParams.varyFlag
if varyFlag==1 then

UIManager.error(FMT.fmt("非变异秘藏暂不支持使用{0}",itemName))
else

UIManager.error(FMT.fmt("变异秘藏暂不支持使用{0}",itemName))
end
elseif errorType==2 then

local srid=errParams.srid
local lgCfg=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,srid)
local srName=lgCfg.name
UIManager.error(FMT.fmt("弟子无{0}，无法使用{1}",srName,itemName))
elseif errorType==3 then

local srid=errParams.srid
local srlv=errParams.srlv
local str="灵根总等级不足"
if srid then
local lgCfg=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,srid)
local srName=lgCfg.name
str=FMT.fmt("{0}等级不足",srName)
end
UIManager.error(FMT.fmt("{0}，无法使用{1}",str,itemName))
end
end
return
end

if self.useItemData~=nil then
local preindex
for k,v in ipairs(self.itemDataList)do
if v.itemid==self.useItemData.itemid then
preindex=k
end
end
if preindex then
local preitem=self.itemlist:getGridObjectByindex(preindex-1)
preitem:SetChildActive(3,false)
end

if preindex~=index then
local item=self.itemlist:getGridObjectByindex(index-1)
item:SetChildActive(3,true)

self.useItemIndex=index
self.useItemData=self.itemDataList[index]
else
self.useItemIndex=nil
self.useItemData=nil

end

else
local item=self.itemlist:getGridObjectByindex(index-1)
item:SetChildActive(3,true)

self.useItemIndex=index
self.useItemData=self.itemDataList[index]
end

if self.parentWin then
if self.parentWin['setUseItemData']then
self.parentWin:setUseItemData(self.useItemData)
self:onCloseBtn()
end
end
end

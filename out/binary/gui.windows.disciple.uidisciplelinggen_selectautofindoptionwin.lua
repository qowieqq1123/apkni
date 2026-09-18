







def_class("UIDiscipleLinggen_SelectAutoFindOptionWin",UIWindowBase)









function UIDiscipleLinggen_SelectAutoFindOptionWin:bindComponents()

self.cancelBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.confirmBtn=UIButton.get(self,2)
self.Content=UIObject.get(self,3)
self.Root=UIObject.get(self,4)
self.uiRoot=UIObject.get(self,5)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)



end


function UIDiscipleLinggen_SelectAutoFindOptionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _CmpbriedSlotItemIndex={
bg=0,
dikuang=1,
icon=2,
name=3,
select=4,
dikuang2=5,
}

local _modeType={
normal=1,
vary=2,
}

local _stageType={
gongfa=1,
commonHiddenSkill=2,
varyGongFa=3,
varyCommonHiddenSkill=4,
}

local _modelShowList={
[_modeType.normal]={_stageType.gongfa,_stageType.commonHiddenSkill},
[_modeType.vary]={_stageType.varyGongFa,_stageType.varyCommonHiddenSkill}
}

local optionBgResList={
[1]={ab=globalABLookup.varylinggensprite,icon='image_linggen_70'},
[2]={ab=globalABLookup.varylinggensprite,icon='image_linggen_68'}
}

local _freshItemFuncs={
[_stageType.gongfa]={
title="弟子已修炼功法(长按秘藏可展示对应最高品质秘藏)",
getData=function(self)
local list={}

local gfList=UIDiscipleModel:getDiscipleAllGFData(self.discipleGuid)
local mcList_gf=UIDiscipleModel:get_hiddenSkillLookup_Common_GF()
local elemntlist=UIDiscipleModel:getDiscipleCanFindHiddenSkill_Element_List(self.discipleGuid)


if#gfList>0 then
local hasMc,gfid,limitLv,gcCfg,itemElement
for index,data in pairs(gfList)do
gfid=data.param_1
hasMc=mcList_gf[gfid]~=nil
gcCfg=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfid)
limitLv=table.containsTableValue(elemntlist,gcCfg.element)
itemElement=true
if self.useItemData and self.useItemData.condition.element then
itemElement=table.containsValue(gcCfg.element,self.useItemData.condition.element)
end
list[#list+1]={gfdata=data,isHasMc=hasMc and 1 or 0,isOkLv=limitLv and 1 or 0,isOkItem=itemElement and 1 or 0}
end
end

table.sort(list,function(a,b)
if a.isHasMc==b.isHasMc then
if a.isOkItem==b.isOkItem then
return a.gfdata.param_1<b.gfdata.param_1
else
return a.isOkItem>b.isOkItem
end
else
return a.isHasMc>b.isHasMc
end
end)

return list
end,
frsehItem=function(self,index,item,data)
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,data.gfdata.param_1)

item:SetChildText(_CmpbriedSlotItemIndex.name,cfg.name)
local gfIcon=iconHelper.getGongFaIcon(cfg.icon)
item:SetChildIcon(_CmpbriedSlotItemIndex.icon,gfIcon,false)

item:SetChildGray(_CmpbriedSlotItemIndex.icon,data.isHasMc==0 or data.isOkLv==0 or data.isOkItem==0)
end,
checkSelect=function(self,data,type)
for index,sdata in ipairs(self.optionList)do
if sdata[1]==data.gfdata.param_1 and type==sdata[2]then
return true,index
end
end
return false
end,
addOption=function(self,data)
self.optionList[#self.optionList+1]={data.gfdata.param_1,_stageType.gongfa}
end,
showTips=function(self,data)
if data.isHasMc==0 then UIManager.error("还未发现此功法的秘藏，敬请期待")return end
UIManager:showWindow("UIDiscipleLinggen_LookGFHideSkillWin",{gfID=data.gfdata.param_1,disciple_guid=self.discipleGuid,varyVal=1})
end,
checkCanSelect=function(self,data)

if data.isHasMc==0 then
UIManager.error("还未发现此功法的秘藏，敬请期待")
return false
end

if data.isOkLv==0 then
UIManager.error("弟子灵根等级不足4级，无法搜寻此属性秘藏")
return false
end

if data.isOkItem==0 then
UIManager.error("当前功法与明灵符互斥无法选择")
return false
end

return true
end,
getTip=function()
return"<color=#c82c2c>该弟子还未修炼任何功法</color>"
end,
},
[_stageType.commonHiddenSkill]={
title="御属性秘藏(通用秘藏包含5种御属性秘藏)",
getData=function(self)
local list={{id=-1,icon='25604',name="御属性秘藏"}}

return list
end,
frsehItem=function(self,index,item,data)
item:SetChildText(_CmpbriedSlotItemIndex.name,data.name)
local iconName=iconHelper.getSkillIcon(data.icon)
item:SetChildIcon(_CmpbriedSlotItemIndex.icon,iconName,false)

local isGray=false
if self.useItemData and self.useItemData.condition.element then
isGray=true
end
item:SetChildGray(_CmpbriedSlotItemIndex.icon,isGray)
end,
checkSelect=function(self,data,type)
for index,sdata in ipairs(self.optionList)do
if sdata[1]==data.id and type==sdata[2]then
return true,index
end
end
return false
end,
addOption=function(self,data)
self.optionList[#self.optionList+1]={data.id,_stageType.commonHiddenSkill,icon='25604',name="御属性秘藏"}
end,
showTips=function(self,data)
local boardList={}

local commonList=UIDiscipleModel:get_hiddenSkillLookup_Common()

for groupId,group in pairs(commonList)do
if groupId~=0 then
boardList[#boardList+1]=group[1]
end
end

table.sort(boardList,function(a,b)
return a.id<b.id
end)

self:showWindow("UIDiscipleLinggen_LookHideSkillListWin",{
mcList=boardList,
index=1
})
end,
checkCanSelect=function(self,data)
if self.useItemData and self.useItemData.condition.element then
UIManager.error("明灵符无法对御属性秘藏使用")
return false
end

return true
end,
getTip=function()

end,
},
[_stageType.varyGongFa]={
title="变异功法秘藏(长按秘藏可展示对应最高品质秘藏)",
getData=function(self)
local list={}

local gfList=UIDiscipleModel:getDiscipleAllGFData(self.discipleGuid)
local mcList_gf=UIDiscipleModel:get_hiddenSkillLookup_Vary_GF()
local varyElement=UIDiscipleModel:getDiscipleLinggenVaryElement(self.discipleGuid)

if#gfList>0 then
local hasMc,gfid,isTVary
for index,data in pairs(gfList)do
gfid=data.param_1
hasMc=mcList_gf[gfid]~=nil
isTVary=false
if hasMc then
isTVary=table.findValue(mcList_gf[gfid][1].element,varyElement)~=nil
end
list[#list+1]={gfdata=data,isHasMc=hasMc and 1 or 0,isVary=isTVary and 1 or 0}
end
end

table.sort(list,function(a,b)
if a.isHasMc==b.isHasMc then
if a.isVary==b.isVary then
return a.isVary<b.isVary
else
return a.gfdata.param_1<b.gfdata.param_1
end

else
return a.isHasMc>b.isHasMc
end
end)

return list
end,
frsehItem=function(self,index,item,data)
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,data.gfdata.param_1)

item:SetChildText(_CmpbriedSlotItemIndex.name,cfg.name)
local gfIcon=iconHelper.getGongFaIcon(cfg.icon)
item:SetChildIcon(_CmpbriedSlotItemIndex.icon,gfIcon,false)

item:SetChildGray(_CmpbriedSlotItemIndex.icon,data.isHasMc==0 or data.isVary==0)
end,
checkSelect=function(self,data,type)
for index,sdata in ipairs(self.optionList)do
if sdata[1]==data.gfdata.param_1 and type==sdata[2]then
return true,index
end
end
return false
end,
addOption=function(self,data)
self.optionList[#self.optionList+1]={data.gfdata.param_1,_stageType.varyGongFa}
end,
showTips=function(self,data)
if data.isHasMc==0 then UIManager.error("还未发现此功法的秘藏，敬请期待")return end
UIManager:showWindow("UIDiscipleLinggen_LookGFHideSkillWin",{gfID=data.gfdata.param_1,disciple_guid=self.discipleGuid,varyVal=2})
end,
checkCanSelect=function(self,data)
if data.isHasMc==0 then
UIManager.error("还未发现此功法的秘藏，敬请期待")
return false
end

if data.isVary==0 then
UIManager.error("只能搜寻当前变异灵根同属性的秘藏")
return false
end

return true
end,
getTip=function()
return"<color=#c82c2c>该弟子还未修炼任何功法</color>"
end,
},
[_stageType.varyCommonHiddenSkill]={
title="变异秘藏(变异秘藏包含2种灵根秘藏)",
getData=function(self)
local list={{id=-1,icon='37011',name="灵根秘藏"}}

return list
end,
frsehItem=function(self,index,item,data)
item:SetChildText(_CmpbriedSlotItemIndex.name,data.name)
local iconName=iconHelper.getSkillIcon(data.icon)
item:SetChildIcon(_CmpbriedSlotItemIndex.icon,iconName,false)
end,
checkSelect=function(self,data,type)
for index,sdata in ipairs(self.optionList)do
if sdata[1]==data.id and type==sdata[2]then
return true,index
end
end
return false
end,
addOption=function(self,data)
self.optionList[#self.optionList+1]={data.id,_stageType.varyCommonHiddenSkill,icon='37011',name="灵根秘藏"}
end,
showTips=function(self,data)
local boardList={}

local varyList=UIDiscipleModel:get_Vary_Common_HiddenSkillLookUp_Color(self.discipleGuid)

for groupId,group in pairs(varyList)do
boardList[#boardList+1]=group[1]
end

table.sort(boardList,function(a,b)
return a.id<b.id
end)

self:showWindow("UIDiscipleLinggen_LookHideSkillListWin",{
mcList=boardList,
index=1
})
end,
checkCanSelect=function(self,data)
return true
end,
getTip=function()

end,
},
}




function UIDiscipleLinggen_SelectAutoFindOptionWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleLinggen_SelectAutoFindOptionWin:__delete()
self:unbindComponents()
end




function UIDiscipleLinggen_SelectAutoFindOptionWin:onShow(argtable,afterOnloaded)
self.discipleGuid=argtable.discipleGuid
self.modeType=argtable.modeType
self.parentWin=argtable.parentWin
self.useItemData=argtable.useItemData


self.optionList=argtable.optionDataList or{}

self:freshAll()
end


function UIDiscipleLinggen_SelectAutoFindOptionWin:onHide()

end





function UIDiscipleLinggen_SelectAutoFindOptionWin:onConfirmBtn()
if#self.optionList<=0 then
if self.modeType==1 then
UIManager.error("请先选择功法秘藏或通用秘藏")
else
UIManager.error("请先选择变异秘藏")
end
return
end

UIManager:invokeUIMethod("UIDiscipleLinggen_AutoFindOptionWin",'freshOptionData',self.optionList)

self:onCloseBtn()
end



function UIDiscipleLinggen_SelectAutoFindOptionWin:onCloseBtn()
self.parentWin:onCloseClick()
end

function UIDiscipleLinggen_SelectAutoFindOptionWin:onCancelBtn()
self:onCloseBtn()
end


function UIDiscipleLinggen_SelectAutoFindOptionWin:freshAll()
self:freshInfos()
end

function UIDiscipleLinggen_SelectAutoFindOptionWin:freshInfos()
local stageList=_modelShowList[self.modeType]

local len=#stageList
self.Content:setChildLayoutGroupCreateItems(len)
local grids=self.Content:getChildLayoutGroupGridList()

local grid
for index=1,grids.Count do
grid=grids[index-1]

self:freshStage(index,grid,stageList[index])
end
end

function UIDiscipleLinggen_SelectAutoFindOptionWin:freshStage(index,grid,type)

local funcs=_freshItemFuncs[type]

grid:SetChildText(1,funcs.title)

local data=funcs.getData(self)

local len=#data

local isShow=len>0

grid:SetChildActive(2,isShow)
grid:SetChildActive(3,not isShow)

if isShow then
grid:SetChildLayoutGroupCreateItems(2,len)
local grids=grid:GetChildLayoutGroupGridList(2)

for sindex=1,grids.Count do
local sgrid=grids[sindex-1]
local sdata=data[sindex]

local isSelect=funcs.checkSelect(self,sdata,type)
sgrid:SetChildActive(_CmpbriedSlotItemIndex.select,isSelect)

funcs.frsehItem(self,sindex,sgrid,sdata)

sgrid:SetChildActive(_CmpbriedSlotItemIndex.dikuang,self.modeType==1)
sgrid:SetChildActive(_CmpbriedSlotItemIndex.dikuang2,self.modeType==2)

sgrid:SetBaseItemClickEvent(-1,function()
if not funcs.checkCanSelect(self,sdata,type)then
return
end

local isSelect,selectIndex=funcs.checkSelect(self,sdata,type)

if isSelect then
table.remove(self.optionList,selectIndex)
sgrid:SetChildActive(_CmpbriedSlotItemIndex.select,false)
else
if#self.optionList==3 then
UIManager.error("已选择3个")
return
else
funcs.addOption(self,sdata)
sgrid:SetChildActive(_CmpbriedSlotItemIndex.select,true)
end
end


end)

sgrid:SetBaseItemLongTouchEvent(-1,function()
funcs.showTips(self,sdata)
end)
end
else
local tips=funcs.getTip()or""
grid:SetChildText(3,tips)
end
grid:ForceLayoutRect(-1)
end

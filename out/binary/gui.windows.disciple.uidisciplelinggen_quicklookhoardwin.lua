







def_class("UIDiscipleLinggen_QuickLookHoardWin",UIWindowBase)









function UIDiscipleLinggen_QuickLookHoardWin:bindComponents()

self.bg_1=UIObject.get(self,0)
self.bg_2=UIObject.get(self,1)
self.hiddenPreviewBtn=UIButton.get(self,2)
self.layout=UIObject.get(self,3)
self.mcinfo=UIBaseItem.get(self,4)
self.mcInfoList=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.title=UIText.get(self,7)
self.typeList=UIObject.get(self,8)
self.varyLockTips=UIText.get(self,9)

self.hiddenPreviewBtn:setButtonClick(function()self:onHiddenPreviewBtn()end)
self.bg={
self.bg_1,
self.bg_2,
}



end


function UIDiscipleLinggen_QuickLookHoardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg_1);self.bg_1=nil;
_UIObject_release(self.bg_2);self.bg_2=nil;
_UIObject_release(self.hiddenPreviewBtn);self.hiddenPreviewBtn=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.mcinfo);self.mcinfo=nil;
_UIObject_release(self.mcInfoList);self.mcInfoList=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.typeList);self.typeList=nil;
_UIObject_release(self.varyLockTips);self.varyLockTips=nil;
self.bg=nil;
end
















local _this

local CmpHoardRecordItemIndex={
root=0,
name=1,
icon=2,
typeicon=3,
attrs=4,
desc=5,
activebtn=6,
changebtn=7,
skilleffectBtn=8,
select=9,
quality=10,
standEffect=11,
expondEffect=12,
}

local _houndding=50
local _contentWidthList={475,700,912}




function UIDiscipleLinggen_QuickLookHoardWin:onLoaded(...)
self:bindComponents()

_this=self

self.selectTypeIdx=1

local _recv_2_203=function()
_this.selectMCIndex=1
_this:refreshAll()
end
self:addProNotify(2,203,_recv_2_203)
end


function UIDiscipleLinggen_QuickLookHoardWin:__delete()
_this=nil

self:unbindComponents()
end




function UIDiscipleLinggen_QuickLookHoardWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.disciple_guid
self.pos=argtable.pos
self.isVary=self.pos<0
self.attench=argtable.attench
self.closeCallBack=argtable.closeCallBack
self.parentWin=argtable.parentWin
self.hoardData=argtable.data


self.selectMCIndex=1

self.isUnlock=UIDiscipleModel:checkHoardLockState(self.disciple_guid,self.pos)


self:refreshAll(afterOnloaded)
end


function UIDiscipleLinggen_QuickLookHoardWin:onHide()

end





function UIDiscipleLinggen_QuickLookHoardWin:onHiddenPreviewBtn()
end


function UIDiscipleLinggen_QuickLookHoardWin:refreshTitle()
local title
local pos=self.pos
if pos>0 then
title=FMT.fmt("{0}号普通秘藏",pos)
else
local type=-pos
local varyCfg=UIDiscipleModel:getLinggenSpecialCfg(type,true)
local elementName=varyCfg.elementname
title=FMT.fmt("变异秘藏·{0}",elementName)
end
self.title:setText(title)
end

function UIDiscipleLinggen_QuickLookHoardWin:refreshBg()
local num=mzbkModel:getMZBKPosMaxSaveCount(self.pos)
local width=_contentWidthList[num]
self.mcInfoList:setChildSizeDelta(width,434.06)

local bgWidth=width+_houndding
self.layout:setChildSizeDelta(bgWidth,523.436)
local sbgWidth=bgWidth/2
self.bg_1:setChildSizeDelta(sbgWidth,523.436)
self.bg_2:setChildSizeDelta(sbgWidth,523.436)
end

function UIDiscipleLinggen_QuickLookHoardWin:refreshAll(afterOnloaded)
self:refreshBg()

self.hiddenPreviewBtn:setActive(self.isVary)
if self.isVary then
self:refreshTypeList(afterOnloaded)
end

self:refreshTitle()

self:refreshHoards()

self.varyLockTips:setActive(self.isVary and not _this.isUnlock)
end

function UIDiscipleLinggen_QuickLookHoardWin:refreshTypeList(afterOnloaded)
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleLingGenData(self.disciple_guid)
self.varyTypeList=UIDiscipleModel:getDiscipleVaryTypeList(self.disciple_guid)
local varysid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)

if afterOnloaded then
for index,type in ipairs(self.varyTypeList)do
if varysid==-type then
_this.selectTypeIdx=index
break
end
end
end


self.typeList:setChildLayoutGroupCreateItems(#self.varyTypeList,function(index)
local item=self.typeList:getChildLayoutGroupGridItem(index-1)
local type=-self.varyTypeList[index]

item:SetChildActive(-1,type~=nil)
local cfg=cfgHelper.get1(cfg_disciplespiritroottypeconfig_get,type)
local element=cfg.element
local typeIconName,ab=ELEMENT_TYPE.getVaryIcon({element})
item:SetChildCSImageSprite(0,ab,typeIconName)

item:SetBaseItemClickEvent(-1,function()
if _this.selectTypeIdx==index then return end

_this.pos=-type
_this.isUnlock=UIDiscipleModel:checkHoardLockState(_this.disciple_guid,_this.pos)
_this.selectTypeIdx=index
_this.selectMCIndex=varysid==type and 1 or 0
_this:refreshTitle()
_this:refreshHoards()
_this.varyLockTips:setActive(self.isVary and not _this.isUnlock)
end)
end)

end


function UIDiscipleLinggen_QuickLookHoardWin:getHoards()
local hoardList=UIDiscipleModel:getDiscipleHoard(self.disciple_guid)

local list={}

local equipHoardData=hoardList[self.pos]
list[1]=equipHoardData.activeList[1]

if not mzbkModel:checkActiveTeQuan()then return list end

local mzbkList=mzbkModel:getDiscipleMZBKInfoByPos(tostring(self.disciple_guid),self.pos)
if mzbkList and mzbkList.len>0 then
for index=1,mzbkList.len do
local data=mzbkList.mzList[index]
list[#list+1]=data
end
end

return list
end

function UIDiscipleLinggen_QuickLookHoardWin:refreshHoards()
self.hoards=self:getHoards()

local item=self.mcinfo:getWidgetBase()
self:refreshHoardInfo(1,item)

local num=mzbkModel:getMZBKPosMaxSaveCount(self.pos)
self.mcInfoList:setChildLayoutGroupCreateItems(num,function(index)
local item=self.mcInfoList:getChildLayoutGroupGridItem(index-1)
self:refreshHoardInfo(index+1,item)
end)
end

local _hoardInfoItemCmp={
hoardItem=0,
randBtn=1,
transformBtn=2,
hoardRoot=3,
gary=4,
empty=5,
tipPart=6,
tipsbg=7,
tips=8,
equipFlag=9,
transFlag=10,
}

local _selectScale=1.1

function UIDiscipleLinggen_QuickLookHoardWin:refreshHoardInfo(index,item)
local hoard=self.hoards[index]
local isShow=hoard~=nil

item:SetChildActive(_hoardInfoItemCmp.empty,not isShow)
item:SetChildActive(_hoardInfoItemCmp.hoardItem,isShow)

if not isShow then
item:SetChildActive(_hoardInfoItemCmp.hoardItem,false)
item:SetChildActive(_hoardInfoItemCmp.randBtn,false)
item:SetChildActive(_hoardInfoItemCmp.transformBtn,false)
item:SetChildActive(_hoardInfoItemCmp.tipsbg,false)
item:SetChildActive(_hoardInfoItemCmp.equipFlag,false)
item:SetChildActive(_hoardInfoItemCmp.transFlag,false)
item:SetChildActive(_hoardInfoItemCmp.tipPart,true)

return
end

local hoardItem=item:GetChildWidgetBase(_hoardInfoItemCmp.hoardItem)

self:refreshHoard(index,hoardItem,hoard)

local isSelect=index==self.selectMCIndex

item:SetChildActive(_hoardInfoItemCmp.equipFlag,index==1)

local isShowBtns=isSelect and self.isUnlock
local isShowRandBtn=index==1 and self.isUnlock
local isShowTransformBtn=index~=1 and self.isUnlock

item:SetChildActive(_hoardInfoItemCmp.randBtn,isShowBtns and isShowRandBtn)
item:SetChildActive(_hoardInfoItemCmp.transformBtn,isShowBtns and isShowTransformBtn)
item:SetChildActive(_hoardInfoItemCmp.tipPart,not isSelect)

local isShowTips=false

local isLimitLevel=false
if index>1 then
isLimitLevel=not UIDiscipleModel:checkHoardCanUse(self.disciple_guid,hoard.hoardid,self.isVary)
item:SetChildActive(_hoardInfoItemCmp.gary,isLimitLevel)
isShowTips=isLimitLevel
if isLimitLevel then
local boardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,hoard.hoardid)
local qulaityName,qab=UIDiscipleModel:getHoardRecordQualityIcon(boardCfg.color)
item:SetChildCSImageSprite(_hoardInfoItemCmp.gary,qab,qulaityName)
end
end





item:SetChildActive(_hoardInfoItemCmp.tipsbg,isShowTips)
item:SetChildActive(_hoardInfoItemCmp.transFlag,isShowTransformBtn)

if isShowRandBtn then
item:SetChildButtonClick(_hoardInfoItemCmp.randBtn,function()
local closeCallBack=_this.attench and _this.attench.closeCallBack
_this.parentWin:showWindow("UIDiscipleLinggen_HiddenSkillSelectWin",{
disciple_guid=_this.disciple_guid,
boardPosData=_this.hoardData,
closeCallBack=closeCallBack
})
if _this.closeCallBack then
_this.closeCallBack()
end
_this:closeSelf()
end,true)
end

if isShowTransformBtn then
item:SetChildButtonClick(_hoardInfoItemCmp.transformBtn,function()
local show_data={
type='UIDialouge',
title='提示',
content="是否切换装备秘藏",
oktext='确定',
canceltext='取消',
okcallback=function()
mzbkController.checkSwitchMC(_this.disciple_guid,_this.pos,index-1)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end,true)
end

item:SetBaseItemClickEvent(_hoardInfoItemCmp.hoardItem,function()
if not _this.isUnlock then

return
end

if isLimitLevel then
UIManager.info("等级不足无法切换")
return
end

if index==_this.selectMCIndex then return end

local preItem
if _this.selectMCIndex==1 then
preItem=_this.mcinfo:getWidgetBase()
else
preItem=_this.mcInfoList:getChildLayoutGroupGridItem(_this.selectMCIndex-2)
end

preItem:SetChildActive(_hoardInfoItemCmp.randBtn,false)
preItem:SetChildActive(_hoardInfoItemCmp.transformBtn,false)
preItem:SetChildActive(_hoardInfoItemCmp.tipPart,true)

_this.selectMCIndex=index


item:SetChildActive(_hoardInfoItemCmp.randBtn,isShowRandBtn)
item:SetChildActive(_hoardInfoItemCmp.transformBtn,isShowTransformBtn)
item:SetChildActive(_hoardInfoItemCmp.tipPart,false)
end)
end

function UIDiscipleLinggen_QuickLookHoardWin:refreshHoard(index,item,data)
local boardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,data.hoardid)
local desc=UIDiscipleModel:getDiscipleHoardDesc(data)
local skillIconName=iconHelper.getSkillIcon(boardCfg.icon)

local typeIconName,ab=ELEMENT_TYPE.getVaryIcon(boardCfg.element)

item:SetChildText(CmpHoardRecordItemIndex.name,boardCfg.name)
item:SetChildIcon(CmpHoardRecordItemIndex.icon,skillIconName,false)
item:SetChildCSImageSprite(CmpHoardRecordItemIndex.typeicon,ab,typeIconName)
item:SetChildLayoutGroupCreateItems(CmpHoardRecordItemIndex.attrs,data.len1,function(index)
local aitem=item:GetChildLayoutGroupGridItem(4,index-1)
local data=data.list1[index]
aitem:SetChildActive(-1,data~=nil)
if data then
local str=helper.getAttributeStr(data.param_1,data.param_2,nil,"{0}+{1}")
aitem:SetChildText(1,str)
end
end)
item:SetChildText(CmpHoardRecordItemIndex.desc,desc)

item:SetChildActive(CmpHoardRecordItemIndex.activebtn,false)
item:SetChildActive(CmpHoardRecordItemIndex.changebtn,false)


local qulaityName,qab=UIDiscipleModel:getHoardRecordQualityIcon(boardCfg.color)
item:SetChildCSImageSprite(CmpHoardRecordItemIndex.quality,qab,qulaityName)

item:SetChildShowEffect(CmpHoardRecordItemIndex.expondEffect,0,false)

item:SetChildActive(CmpHoardRecordItemIndex.skilleffectBtn,boardCfg.additionskillid~=nil)
item:SetChildButtonClick(CmpHoardRecordItemIndex.skilleffectBtn,function()
local hiddenCfg=boardCfg
local skillid,gfUpValue=next(hiddenCfg.gongfa or{})
if skillid and gfUpValue then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
skillid=skillid,
addSkillLv=gfUpValue,
gfID=hiddenCfg.gongfaid,

offset=Vector2(0,0),

})
elseif hiddenCfg.skillid then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
gfID=hiddenCfg.gongfaid,

offset=Vector2(0,0),

})
end
end)
end


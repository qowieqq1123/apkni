







def_class("UIDiscipleLinggen_MZBKTransformHideSkillWin",UIWindowBase)








function UIDiscipleLinggen_MZBKTransformHideSkillWin:bindComponents()

self.deleteBtn=UIButton.get(self,0)
self.item=UIBaseItem.get(self,1)
self.nextBtn=UIButton.get(self,2)
self.preBtn=UIButton.get(self,3)
self.root=UIObject.get(self,4)
self.tips=UIText.get(self,5)
self.tipsPart=UIText.get(self,6)
self.transformBtn=UIButton.get(self,7)

self.deleteBtn:setButtonClick(function()self:onDeleteBtn()end)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)

self.preBtn:setButtonClick(function()self:onPreBtn()end)

self.transformBtn:setButtonClick(function()self:onTransformBtn()end)



end


function UIDiscipleLinggen_MZBKTransformHideSkillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.deleteBtn);self.deleteBtn=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.preBtn);self.preBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsPart);self.tipsPart=nil;
_UIObject_release(self.transformBtn);self.transformBtn=nil;
end
















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




function UIDiscipleLinggen_MZBKTransformHideSkillWin:onLoaded(...)
self:bindComponents()

local _recv_2_203=function()
self:closeSelf()
end
self:addProNotify(2,203,_recv_2_203)
end


function UIDiscipleLinggen_MZBKTransformHideSkillWin:__delete()
self:unbindComponents()
end




function UIDiscipleLinggen_MZBKTransformHideSkillWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.disciple_guid
self.boardList=argtable.boardList
self.index=argtable.index
self.pos=argtable.pos
self.title=argtable.title

self:refresh()
end


function UIDiscipleLinggen_MZBKTransformHideSkillWin:onHide()

end

function UIDiscipleLinggen_MZBKTransformHideSkillWin:refresh()
self:freshBtn()
self:refreshMain()
end

function UIDiscipleLinggen_MZBKTransformHideSkillWin:refreshMain()
self:freshRecordItem()
end

function UIDiscipleLinggen_MZBKTransformHideSkillWin:freshRecordItem()
local item=self.item:getWidgetBase()
local data=self.boardList[self.index]
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

item:SetChildActive(CmpHoardRecordItemIndex.skilleffectBtn,false)
item:SetChildButtonClick(CmpHoardRecordItemIndex.skilleffectBtn,function()
self:onClickEffect()
end)
self:onClickEffect()

local isUnlockSlot=false
if self.pos>0 then
isUnlockSlot=UIDiscipleModel:checkHiddenSkillSlotUnlock(self.disciple_guid,self.pos)
else
isUnlockSlot=UIDiscipleModel:checkDiscipleAssertVary(self.disciple_guid)
end

local isUnLockHoard=UIDiscipleModel:checkHoardCanUse(self.disciple_guid,data.hoardid,self.pos<0)
self.transformBtn:setActive(isUnlockSlot and isUnLockHoard)
local isShowTips=false
if not isUnlockSlot then
isShowTips=true
local str=FMT.fmt("{0}未解锁\n暂时不可装备",self.title)
self.tips:setText(str)
elseif not isUnLockHoard then
isShowTips=true
local str="秘藏未解锁\n暂时不可装备"
self.tips:setText(str)
end
self.tipsPart:setActive(isShowTips)
end


function UIDiscipleLinggen_MZBKTransformHideSkillWin:freshBtn()
self.preBtn:setActive(self.index~=1)
self.nextBtn:setActive(self.index~=#self.boardList)


end

function UIDiscipleLinggen_MZBKTransformHideSkillWin:onClickEffect()
local data=self.boardList[self.index]
local item=self.item:getWidgetBase()
local hiddenCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,data.hoardid)
if hiddenCfg.additionskillid==nil then return end
local skillid,gfUpValue=next(hiddenCfg.gongfa or{})
if skillid and gfUpValue then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
skillid=skillid,
addSkillLv=gfUpValue,
gfID=hiddenCfg.gongfaid,
item=item,
offset=Vector2(0,0),
isAdapter=true,
isHasBackNumber=0,
directionType=eDirectionType.eLeft,
})
elseif hiddenCfg.skillid then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
gfID=hiddenCfg.gongfaid,
item=item,
offset=Vector2(0,0),
isAdapter=true,
isHasBackNumber=0,
directionType=eDirectionType.eLeft,
})
else
self:closeWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin")
end
end





function UIDiscipleLinggen_MZBKTransformHideSkillWin:onPreBtn()
self.index=self.index-1
self:refresh()
end



function UIDiscipleLinggen_MZBKTransformHideSkillWin:onNextBtn()
self.index=self.index+1
self:refresh()
end

function UIDiscipleLinggen_MZBKTransformHideSkillWin:onTransformBtn()
local args={}

args.disciple_guid=self.disciple_guid
args.sourceData=self.boardList[self.index]

local hoardDataList=UIDiscipleModel:getDiscipleHoard(self.disciple_guid)
local posHoardData=hoardDataList[self.pos]

args.destData=posHoardData
args.idx=self.index


self:showWindow("UIDiscipleLinggen_TransformEquipHoardWin",args)
end

function UIDiscipleLinggen_MZBKTransformHideSkillWin:onDeleteBtn()


local hoardData=self.hoardDataList[self.index]
local cfg=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,hoardData.hoardid)
local name=toColorString(cfg.color,cfg.name)
local posName=self.pos>0 and FMT.fmt("{0}号",self.pos)or"变异"
local content=FMT.fmt("是否删除{0}秘藏栏中的{1}秘藏",posName,name)

local _delFunc=function()
mzbkController.req_disciple_delete_mz(self.disciple_guid,self.pos,self.index,name)
end

local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=_delFunc,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end


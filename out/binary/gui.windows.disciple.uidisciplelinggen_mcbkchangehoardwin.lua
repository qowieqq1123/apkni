







def_class("UIDiscipleLinggen_MCBKChangeHoardWin",UIWindowBase)








function UIDiscipleLinggen_MCBKChangeHoardWin:bindComponents()

self.cancelBtn=UIButton.get(self,0)
self.destItem=UIBaseItem.get(self,1)
self.okBtn=UIButton.get(self,2)
self.root=UIObject.get(self,3)
self.sourceItem=UIBaseItem.get(self,4)
self.tip=UIText.get(self,5)
self.title=UIText.get(self,6)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.okBtn:setButtonClick(function()self:onOkBtn()end)



end


function UIDiscipleLinggen_MCBKChangeHoardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.destItem);self.destItem=nil;
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sourceItem);self.sourceItem=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.title);self.title=nil;
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




function UIDiscipleLinggen_MCBKChangeHoardWin:onLoaded(...)
self:bindComponents()

local _recv_2_200=function()
self:closeSelf()
end
self:addProNotify(2,200,_recv_2_200)
end


function UIDiscipleLinggen_MCBKChangeHoardWin:__delete()
self:unbindComponents()
end




function UIDiscipleLinggen_MCBKChangeHoardWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.disciple_guid
self.sourceData=argtable.sourceData
self.destData=argtable.destData
self.replaceIdx=argtable.replaceIdx
self.pos=argtable.pos
self.dpos=argtable.dpos
self.randIdx=argtable.randIdx
self.tiptxt=argtable.tip

self.okCallBack=argtable.okCallBack
self.cancelCallBack=argtable.cancelCallBack
self.callBack=argtable.callback

self:refresh()
end


function UIDiscipleLinggen_MCBKChangeHoardWin:onHide()

end

function UIDiscipleLinggen_MCBKChangeHoardWin:refresh()


local sourceItem=self.sourceItem:getWidgetBase()
self:refreshHoardItem(self.sourceData,sourceItem)


local activeData=self.destData
local destItem=self.destItem:getWidgetBase()
self:refreshHoardItem(activeData,destItem)

self.tip:setText(self.tiptxt)
end

function UIDiscipleLinggen_MCBKChangeHoardWin:refreshHoardItem(data,item)
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

item:SetChildButtonClick(CmpHoardRecordItemIndex.skilleffectBtn,function()
local hiddenCfg=boardCfg
local skillid,gfUpValue=next(hiddenCfg.gongfa or{})
if skillid and gfUpValue then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
skillid=skillid,
addSkillLv=gfUpValue,
gfID=hiddenCfg.gongfaid,
item=item,
offset=Vector2(0,0),
isAdapter=true
})
elseif hiddenCfg.skillid then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
gfID=hiddenCfg.gongfaid,
item=item,
offset=Vector2(0,0),
isAdapter=true
})
end
end)

end




function UIDiscipleLinggen_MCBKChangeHoardWin:onCancelBtn()


if self.cancelCallBack then
self.cancelCallBack()
end

if self.callBack then
self.callBack()
end

self:closeSelf()
end



function UIDiscipleLinggen_MCBKChangeHoardWin:onOkBtn()
if self.okCallBack then
self.okCallBack()
end
if self.callBack then
self.callBack()
end
self:closeSelf()
end


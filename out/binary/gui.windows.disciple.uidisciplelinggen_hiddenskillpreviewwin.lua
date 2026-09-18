







def_class("UIDiscipleLinggen_HiddenSkillPreViewWin",UIWindowBase)









function UIDiscipleLinggen_HiddenSkillPreViewWin:bindComponents()

self.root=UIObject.get(self,0)
self.recordList=UIScrollView.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.title=UIText.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIDiscipleLinggen_HiddenSkillPreViewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.recordList);self.recordList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _this





function UIDiscipleLinggen_HiddenSkillPreViewWin:onLoaded(...)
self:bindComponents()
_this=self

self.recordList:bindScrollWidget(function(...)self:bindRecordItem(...)end)
self.recordList:setClickAction(function(...)self:onClickRecord(...)end)

self.recordDataList={}
end


function UIDiscipleLinggen_HiddenSkillPreViewWin:__delete()
self:unbindComponents()
_this=nil

end




function UIDiscipleLinggen_HiddenSkillPreViewWin:onShow(argtable,afterOnloaded)
self.data=argtable.data
self.disciple_guid=argtable.disciple_guid

self:refresh()
end


function UIDiscipleLinggen_HiddenSkillPreViewWin:onHide()

end

function UIDiscipleLinggen_HiddenSkillPreViewWin:refresh()
self:initRecordList()
self:refreshRecordList()

self.title:setText(self.titleName)
end

function UIDiscipleLinggen_HiddenSkillPreViewWin:refreshRecordList()
local len=#self.recordDataList
self.recordList:freshGridsNum(len,Mathf.Ceil(len/5),5,false)
end

local CmpRecordItemIndex={
name=0,
type=1,
icon=2,
showAttrBtn=3,
desc=4,
quality=5,
}

function UIDiscipleLinggen_HiddenSkillPreViewWin:bindRecordItem(index,item)
local data=self.recordDataList[index]
item:SetChildActive(-1,data~=nil)
if data then
local skillIconName=iconHelper.getSkillIcon(data.icon)
local desc=data.mz_desc or''

local elementIconName,ab=ELEMENT_TYPE.getVaryIcon(data.element)


item:SetChildText(CmpRecordItemIndex.name,data.name)
item:SetChildCSImageSprite(CmpRecordItemIndex.type,ab,elementIconName)
item:SetChildIcon(CmpRecordItemIndex.icon,skillIconName,false)
item:SetChildText(CmpRecordItemIndex.desc,desc)

local qualityName,qab=UIDiscipleModel:getHoardRecordQualityIcon(data.color)
item:SetChildCSImageSprite(CmpRecordItemIndex.quality,qab,qualityName)
end
end

function UIDiscipleLinggen_HiddenSkillPreViewWin:onClickRecord(id,index,guid,attach)
self:showWindow("UIDiscipleLinggen_LookHideSkillWin",{
boardList=self.recordDataList,
index=index
})
end


function UIDiscipleLinggen_HiddenSkillPreViewWin:initRecordList()
local boardcfg=cfg_disciplespiritroothoardconfig()
local lgCfg=UIDiscipleModel:getLinggenSpecialCfg(self.data.type,true)

for k,v in pairs(boardcfg)do
local pfcfg=pfwindowsModel:getVersionAndPfCfg_2(v.hide and v.hide or{})
if not pfcfg then
if table.containsValue(v.element,lgCfg.element)then
table.insert(self.recordDataList,v)
end
end
end

table.sort(self.recordDataList,function(ad,bd)
if ad.color==bd.color then
return ad.id>bd.id
else
return ad.color>bd.color
end
end)

self.titleName=FMT.fmt("{0}秘藏",lgCfg.name)
end





function UIDiscipleLinggen_HiddenSkillPreViewWin:onCloseBtn()
self:closeSelf()
end


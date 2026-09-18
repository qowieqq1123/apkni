







def_class("UIDiscipleLinggen_HiddenSkillSelectQualityWin",UIWindowBase)









function UIDiscipleLinggen_HiddenSkillSelectQualityWin:bindComponents()

self.root=UIObject.get(self,0)
self.tablist=UIScrollView.get(self,1)
self.recordList=UIScrollView.get(self,2)
self.closeBtn=UIButton.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIDiscipleLinggen_HiddenSkillSelectQualityWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tablist);self.tablist=nil;
_UIObject_release(self.recordList);self.recordList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end




















function UIDiscipleLinggen_HiddenSkillSelectQualityWin:onLoaded(...)
self:bindComponents()

self.tablist:bindScrollWidget(function(...)self:bindTabItem(...)end)
self.recordList:bindScrollWidget(function(...)self:bindRecordItem(...)end)

self.tablist:setClickAction(function(...)self:onClickTab(...)end)
self.recordList:setClickAction(function(...)self:onClickRecord(...)end)

self.recordDataList={}
self.boardList_lookup={}
end


function UIDiscipleLinggen_HiddenSkillSelectQualityWin:__delete()
self:unbindComponents()
end




function UIDiscipleLinggen_HiddenSkillSelectQualityWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.disciple_guid
self.typeDatalist=argtable.typeDatalist
self.varySrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
self.lglist,self.lglist_lookup,self.lglist_len=UIDiscipleModel:getDiscipleLingGenData(self.disciple_guid)
self.isShowVary=argtable.isShowVary
self.tabindex=1

self:refresh()

end


function UIDiscipleLinggen_HiddenSkillSelectQualityWin:onHide()

end

function UIDiscipleLinggen_HiddenSkillSelectQualityWin:initLookupBoard()


self.typelist,self.boardList_lookup=UIDiscipleModel:getPreViewHoardList(self.disciple_guid,true,self.isShowVary)

for k,list in pairs(self.boardList_lookup)do
table.sort(list,function(ad,bd)
if ad.color==bd.color then
return ad.id>bd.id
else
return ad.color>bd.color
end
end)
end

end

function UIDiscipleLinggen_HiddenSkillSelectQualityWin:refresh()
self:initLookupBoard()
self:refreshAttrTab()
self:refreshRecordList()
end

function UIDiscipleLinggen_HiddenSkillSelectQualityWin:refreshAttrTab()
local data=self.typelist
self.tablist:freshGridsNum(#data,1,#data,self.tablistzero)
self.tablistzero=true
end

function UIDiscipleLinggen_HiddenSkillSelectQualityWin:refreshRecordList()
local typedata=self.typelist[self.tabindex]
self.recordDataList=self.boardList_lookup[typedata.type]
local len=#self.recordDataList
self.recordList:clearItems()
self.recordList:freshGridsNum(len,Mathf.Ceil(len/5),5,true)
end



function UIDiscipleLinggen_HiddenSkillSelectQualityWin:bindTabItem(index,item)
local typedata=self.typelist[index]

local isAll=typedata.type==0

item:SetChildActive(-1,true)
item:SetChildActive(0,isAll)
item:SetChildActive(1,not isAll)
item:SetChildActive(2,not isAll)
item:SetChildActive(3,index==self.tabindex)
if not isAll then

local element=typedata.type
if typedata.showVary==1 then
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local cfg=UIDiscipleModel:getSpecialityConfigEx(netData,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,self.lglist_lookup[typedata.type].source)
element=cfg.element
end
local typeIconName,ab=ELEMENT_TYPE.getVaryIcon({element})
item:SetChildCSImageSprite(1,ab,typeIconName)

local name
if element==16 then
name='御'
else
name=ELEMENT_TYPE.getName(element)
end
item:SetChildText(2,FMT.fmt("{0}属性",name))
end
end

function UIDiscipleLinggen_HiddenSkillSelectQualityWin:onClickTab(id,index,guid,attach)

if self.tabindex==index then return end

local preItem=self.tablist:getGridObjectByindex(self.tabindex-1)
preItem:SetChildActive(3,false)

self.tabindex=index
local item=self.tablist:getGridObjectByindex(index-1)
item:SetChildActive(3,true)

self:refreshRecordList()
end

local CmpRecordItemIndex={
name=0,
type=1,
icon=2,
showAttrBtn=3,
desc=4,
quality=5,
}

function UIDiscipleLinggen_HiddenSkillSelectQualityWin:bindRecordItem(index,item)
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

function UIDiscipleLinggen_HiddenSkillSelectQualityWin:onClickRecord(id,index,guid,attach)
self:showWindow("UIDiscipleLinggen_LookHideSkillWin",{
boardList=self.recordDataList,
index=index
})
end





function UIDiscipleLinggen_HiddenSkillSelectQualityWin:onCloseBtn()
self:closeSelf()
end


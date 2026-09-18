







def_class("UIDiscipleLinggen_HiddenSkillRecordWin",UIWindowBase)









function UIDiscipleLinggen_HiddenSkillRecordWin:bindComponents()

self.root=UIObject.get(self,0)
self.tablist=UIScrollView.get(self,1)
self.recordList=UIScrollView.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.typeTabList=UIObject.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIDiscipleLinggen_HiddenSkillRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tablist);self.tablist=nil;
_UIObject_release(self.recordList);self.recordList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.typeTabList);self.typeTabList=nil;
end
















local _this

local typeList={1,2,3,4,5,11,12,13,14,15,16}

local cfgData={
[1]={
type=1,
name='普通\n秘藏',
tablen=6,
tablist={0,1,2,3,4,5}
},
[2]={
type=2,
name='变异\n秘藏',
tablen=6,
tablist={0,11,12,13,14,15}
},
[3]={
type=3,
name='通用\n秘藏',
tablen=2,
tablist={0,16}
},
}




function UIDiscipleLinggen_HiddenSkillRecordWin:onLoaded(...)
self:bindComponents()
_this=self

self.tablist:bindScrollWidget(function(...)self:bindTabItem(...)end)
self.recordList:bindScrollWidget(function(...)self:bindRecordItem(...)end)

self.tablist:setClickAction(function(...)self:onClickTab(...)end)
self.recordList:setClickAction(function(...)self:onClickRecord(...)end)

self.recordDataList={}
self.boardList_lookup={}
end


function UIDiscipleLinggen_HiddenSkillRecordWin:__delete()
self:unbindComponents()
end




function UIDiscipleLinggen_HiddenSkillRecordWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self:initLookupBoard()
end

self.typeIndex=1
self.tabindex=1

self:refresh()
end


function UIDiscipleLinggen_HiddenSkillRecordWin:onHide()

end

function UIDiscipleLinggen_HiddenSkillRecordWin:initLookupBoard()
local boardcfg=cfg_disciplespiritroothoardconfig()
for k,v in pairs(typeList)do
self.boardList_lookup[v]={}
end

for k,v in pairs(boardcfg)do
local pfcfg=pfwindowsModel:getVersionAndPfCfg_2(v.hide and v.hide or{})
if not pfcfg then
local element=#v.element>1 and 16 or v.element[1]

table.insert(self.boardList_lookup[element],v)

end
end


for k,v in pairs(self.boardList_lookup)do
if#v>1 then
table.sort(v,function(ad,bd)

if ad.color==bd.color then
return ad.id>bd.id
else
return ad.color>bd.color
end
end)
end
end
end

function UIDiscipleLinggen_HiddenSkillRecordWin:refresh()
self:refreshTypeTab()
self:refreshAttrTab()
self:refreshRecordList()
end

function UIDiscipleLinggen_HiddenSkillRecordWin:refreshTypeTab()
local len=#cfgData
self.typeTabList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.typeTabList:getChildLayoutGroupGridItem(index-1)
local data=cfgData[index]

item:SetChildActive(-1,true)
item:SetChildText(1,data.name)
item:SetChildActive(0,index==self.typeIndex)

item:SetBaseItemClickEvent(-1,function()
if index~=self.typeIndex then
local preitem=self.typeTabList:getChildLayoutGroupGridItem(self.typeIndex-1)
preitem:SetChildActive(0,false)

self.typeIndex=index
self.tabindex=1
item:SetChildActive(0,true)
self:refreshAttrTab()
self:refreshRecordList()
end
end)
end)
end

function UIDiscipleLinggen_HiddenSkillRecordWin:refreshAttrTab()
local data=cfgData[self.typeIndex]
self.tablist:freshGridsNum(data.tablen,1,data.tablen,true)
end

function UIDiscipleLinggen_HiddenSkillRecordWin:refreshRecordList()
local typedata=cfgData[self.typeIndex]
local type=typedata.tablist[self.tabindex]
local isALl=type==0
self.recordDataList={}
if isALl then
for k,v in pairs(typedata.tablist)do
self.recordDataList=table.concatTableX(self.recordDataList,self.boardList_lookup[v])
end
table.sort(self.recordDataList,function(ad,bd)
local element_a=ad.element[1]
local element_b=bd.element[1]
if ad.color==bd.color then
if element_a==element_b then
if(ad.gongfaid or 0)==(bd.gongfaid or 0)then
return ad.id>bd.id
else
return(ad.gongfaid or 0)>(bd.gongfaid or 0)
end
else
return element_a<element_b
end
else
return ad.color>bd.color
end
end)
else
self.recordDataList=self.boardList_lookup[type]
table.sort(self.recordDataList,function(ad,bd)
if(ad.gongfaid or 0)==(bd.gongfaid or 0)then
return ad.color>bd.color
else
return(ad.gongfaid or 0)>(bd.gongfaid or 0)
end
end)
end
local len=#self.recordDataList
self.recordList:freshGridsNum(len,Mathf.Ceil(len/5),5,true)
end


function UIDiscipleLinggen_HiddenSkillRecordWin:bindTabItem(index,item)
local typedata=cfgData[self.typeIndex]
local type=typedata.tablist[index]

item:SetChildActive(-1,type~=nil)
if type~=nil then
local isAll=type==0

item:SetChildActive(0,isAll)
item:SetChildActive(1,not isAll)
item:SetChildActive(2,not isAll)
item:SetChildActive(3,index==self.tabindex)
if not isAll then

local typeIconName,ab=ELEMENT_TYPE.getVaryIcon({type})
item:SetChildCSImageSprite(1,ab,typeIconName)

local name
if type==16 then
name='御'
else
name=ELEMENT_TYPE.getName(type)
end

item:SetChildText(2,FMT.fmt("{0}属性",name))
end
end
end

function UIDiscipleLinggen_HiddenSkillRecordWin:onClickTab(id,index,guid,attach)

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
function UIDiscipleLinggen_HiddenSkillRecordWin:bindRecordItem(index,item)
local data=self.recordDataList[index]

item:SetChildActive(-1,data~=nil)
if data then
local skillIconName=iconHelper.getSkillIcon(data.icon)
local desc=data.mz_desc or''

local elementIconName,ab=ELEMENT_TYPE.getVaryIcon(data.element)


local nameColor=UIDiscipleModel:getHoardNameColor(data.color)
item:SetChildText(CmpRecordItemIndex.name,toColorStringX(nameColor,data.name))
item:SetChildCSImageSprite(CmpRecordItemIndex.type,ab,elementIconName)
item:SetChildIcon(CmpRecordItemIndex.icon,skillIconName,false)
item:SetChildText(CmpRecordItemIndex.desc,desc)

local qualityName,qab=UIDiscipleModel:getHoardRecordQualityIcon(data.color)
item:SetChildCSImageSprite(CmpRecordItemIndex.quality,qab,qualityName)

end
end

function UIDiscipleLinggen_HiddenSkillRecordWin:onClickRecord(id,index,guid,attach)
self:showWindow("UIDiscipleLinggen_LookHideSkillWin",{
boardList=self.recordDataList,
index=index
})
end





function UIDiscipleLinggen_HiddenSkillRecordWin:onCloseBtn()
self:closeSelf()
end










def_class("UIDiscipleLinggen_HiddenSkillTipsWn",UIWindowBase)









function UIDiscipleLinggen_HiddenSkillTipsWn:bindComponents()

self.hiddenlist=UIObject.get(self,0)
self.hiddenSkillRecordItem=UIBaseItem.get(self,1)
self.jumpBtn=UIButton.get(self,2)
self.root=UIObject.get(self,3)
self.tip=UIText.get(self,4)
self.title=UIText.get(self,5)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UIDiscipleLinggen_HiddenSkillTipsWn:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.hiddenlist);self.hiddenlist=nil;
_UIObject_release(self.hiddenSkillRecordItem);self.hiddenSkillRecordItem=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _this




function UIDiscipleLinggen_HiddenSkillTipsWn:onLoaded(...)
self:bindComponents()

_this=self
end


function UIDiscipleLinggen_HiddenSkillTipsWn:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleLinggen_HiddenSkillTipsWn:onShow(argtable,afterOnloaded)
local item=argtable.item
self.data=argtable.data
self.parentWin=argtable.parentWin
self.disciple_guid=argtable.disciple_guid

self.attench=argtable.attench
self.closeCallBack=argtable.closeCallBack


self:showPosition(item)

self:refreshMain()
self:refreshHiddenHoardList()

end


function UIDiscipleLinggen_HiddenSkillTipsWn:onHide()

end

function UIDiscipleLinggen_HiddenSkillTipsWn:refreshMain()
self.title:setText(self.data.pos>0 and'秘藏'or'变异秘藏')
local item=self.hiddenSkillRecordItem:getWidgetBase()
local data=self.data.activeList[1]
local boardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,data.hoardid)
local desc=UIDiscipleModel:getDiscipleHoardDesc(data)
local skillIconName=iconHelper.getSkillIcon(boardCfg.icon)

local typeIconName,ab=ELEMENT_TYPE.getVaryIcon(boardCfg.element)


item:SetChildText(1,boardCfg.name)
item:SetChildIcon(2,skillIconName,false)
item:SetChildCSImageSprite(3,ab,typeIconName)
item:SetChildLayoutGroupCreateItems(4,data.len1,function(index)
local aitem=item:GetChildLayoutGroupGridItem(4,index-1)
local data=data.list1[index]
aitem:SetChildActive(-1,data~=nil)
if data then
local str=helper.getAttributeStr(data.param_1,data.param_2,nil,"{0}+{1}")
aitem:SetChildText(1,str)
end
end)
item:SetChildText(5,desc)

item:SetChildActive(6,boardCfg.additionskillid~=nil)
item:SetChildButtonClick(6,function()
_this:onGfEffectBtn()
end)

local qualityName,qab=UIDiscipleModel:getHoardRecordQualityIcon(boardCfg.color)
item:SetChildCSImageSprite(7,qab,qualityName)

local varySrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)
self.tip:setActive(self.data.pos<0 and-self.data.pos~=varySrid)
self.jumpBtn:setActive(-self.data.pos==varySrid or self.data.pos>0)
end


function UIDiscipleLinggen_HiddenSkillTipsWn:refreshHiddenHoardList()
local hoardDatas=UIDiscipleModel:getDiscipleHoard(self.disciple_guid)
local varyHoardList={}
for k,v in pairs(hoardDatas)do
if v.pos<0 and v.activelistlen>0 then
table.insert(varyHoardList,v)
end
end

local isShow=self.data.pos<0 and#varyHoardList>1

self.hiddenlist:setActive(isShow)
if isShow then


local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleLingGenData(self.disciple_guid)
self.hiddenlist:setChildLayoutGroupCreateItems(#varyHoardList,function(index)
local item=_this.hiddenlist:getChildLayoutGroupGridItem(index-1)
local data=varyHoardList[index]

item:SetChildActive(0,_this.data.pos==data.pos)
if _this.data.pos==data.pos then
_this.selectIndex=index
end

local sdata=lglist_lookup[-data.pos]
local cfg=UIDiscipleModel:getLinggenSpecialCfg(sdata.type,true)
local elementIconName,ab=ELEMENT_TYPE.getVaryIcon({cfg.element})
item:SetChildCSImageSprite(1,ab,elementIconName)

item:SetBaseItemClickEvent(-1,function()
if _this.selectIndex~=index then
local preItem=_this.hiddenlist:getChildLayoutGroupGridItem(_this.selectIndex-1)
preItem:SetChildActive(0,false)

_this.selectIndex=index
item:SetChildActive(0,true)
_this.data=data
_this:refreshMain()
end
end)
end)
end
end





function UIDiscipleLinggen_HiddenSkillTipsWn:onJumpBtn()
local closeCallBack=self.attench and self.attench.closeCallBack
self.parentWin:showWindow("UIDiscipleLinggen_HiddenSkillSelectWin",{
disciple_guid=self.disciple_guid,
boardPosData=self.data,
closeCallBack=closeCallBack
})
if self.closeCallBack then
self.closeCallBack()
end
self:closeSelf()
end

function UIDiscipleLinggen_HiddenSkillTipsWn:onGfEffectBtn()
local hiddenCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,self.data.activeList[1].hoardid)
local skillid,gfUpValue=next(hiddenCfg.gongfa or{})
if skillid and gfUpValue then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
skillid=skillid,
addSkillLv=gfUpValue,
gfID=hiddenCfg.gongfaid,
item=self.root:getWidgetBase(),
offset=Vector2(0,0),
isAdapter=true
})
elseif hiddenCfg.skillid then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
gfID=hiddenCfg.gongfaid,
item=self.root:getWidgetBase(),
offset=Vector2(0,0),
isAdapter=true
})
end
end

function UIDiscipleLinggen_HiddenSkillTipsWn:showPosition(item)
local screenPoint=item:GetChildScreenPointToLocalPointRectangle(-1)
local itemTrans=item.transform
local itemSize=itemTrans.sizeDelta
local itemPivot=itemTrans.pivot

local rootPosX=screenPoint.x
local rootPosY=screenPoint.y+itemSize.y/2+30

self.winlua:SetChildLocalPosition(self.root:getID(),Vector3(rootPosX,rootPosY,0))
end


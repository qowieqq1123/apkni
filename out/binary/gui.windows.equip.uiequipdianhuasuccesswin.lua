







def_class("UIEquipDianHuaSuccessWin",UIWindowBase)









function UIEquipDianHuaSuccessWin:bindComponents()

self.targetItem=UIBaseItem.get(self,0)
self.rangeAttrRoot=UIObject.get(self,1)
self.baseAttrRoot=UIObject.get(self,2)
self.effect=UIObject.get(self,3)
self.tips=UIText.get(self,4)
self.titleBack=UIObject.get(self,5)
self.baseAttrTitle=UIObject.get(self,6)
self.baseAttr_1=UIObject.get(self,7)
self.baseAttr_2=UIObject.get(self,8)
self.baseAttr_3=UIObject.get(self,9)
self.baseAttr_5=UIObject.get(self,10)
self.baseAttr_6=UIObject.get(self,11)
self.baseAttr_4=UIObject.get(self,12)
self.rangeAttr_4=UIObject.get(self,13)
self.rangeAttrTitle=UIObject.get(self,14)
self.rangeAttr_1=UIObject.get(self,15)
self.rangeAttr_2=UIObject.get(self,16)
self.rangeAttr_3=UIObject.get(self,17)
self.baseAttr={
self.baseAttr_1,
self.baseAttr_2,
self.baseAttr_3,
self.baseAttr_4,
self.baseAttr_5,
self.baseAttr_6,
}
self.rangeAttr={
self.rangeAttr_1,
self.rangeAttr_2,
self.rangeAttr_3,
self.rangeAttr_4,
}



end


function UIEquipDianHuaSuccessWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.targetItem);self.targetItem=nil;
_UIObject_release(self.rangeAttrRoot);self.rangeAttrRoot=nil;
_UIObject_release(self.baseAttrRoot);self.baseAttrRoot=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.baseAttrTitle);self.baseAttrTitle=nil;
_UIObject_release(self.baseAttr_1);self.baseAttr_1=nil;
_UIObject_release(self.baseAttr_2);self.baseAttr_2=nil;
_UIObject_release(self.baseAttr_3);self.baseAttr_3=nil;
_UIObject_release(self.baseAttr_5);self.baseAttr_5=nil;
_UIObject_release(self.baseAttr_6);self.baseAttr_6=nil;
_UIObject_release(self.baseAttr_4);self.baseAttr_4=nil;
_UIObject_release(self.rangeAttr_4);self.rangeAttr_4=nil;
_UIObject_release(self.rangeAttrTitle);self.rangeAttrTitle=nil;
_UIObject_release(self.rangeAttr_1);self.rangeAttr_1=nil;
_UIObject_release(self.rangeAttr_2);self.rangeAttr_2=nil;
_UIObject_release(self.rangeAttr_3);self.rangeAttr_3=nil;
self.baseAttr=nil;
self.rangeAttr=nil;
end

















local _posY={
[1]=-15,
[2]=-45,
[3]=-75,
[4]=-105,
[4]=-135,
[6]=-165,
}

function UIEquipDianHuaSuccessWin:onLoaded(...)
self:bindComponents()
self.stamp=os.time()
self.closeTag=false

self.targetItem:setBaseItemClickEvent(function(...)
if self and not self.isClose then
self:onClickTargetItem(...)
end
end)
end

function UIEquipDianHuaSuccessWin:__delete()
self:unbindComponents()
end

function UIEquipDianHuaSuccessWin:onShow(argtable,afterOnloaded)
self:stopAllTimer()
local itemguid=argtable[1]
self.itemguid=itemguid
local oldcnt=argtable[2]
local newcnt=argtable[3]
local equip=equipsHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)

self.effect:setChildShowEffect(10010,true)

AudioManager.playAudio(643)

self:freshTargetItem()
self.targetItem:setChildCanvasGroupAlpha(0)

local baseAttr=equipsHelper.getBaseAttrsList(itemCfg)
local extraAttr=equipsHelper.getExtraAttrsList(itemCfg)or{}
local rangeAttr=equipsHelper.getRandomAttrList(equip)
local extraAttrLookup=attrListHelper.tramsformToLookup(extraAttr)or{}

local reveal_attr=itemCfg.reveal_attr[oldcnt]
local total_baseAttr=reveal_attr and reveal_attr[1]
local total_baseAttrLookup=total_baseAttr and attrListHelper.tramsformToLookup(total_baseAttr)or{}
local total_extraAttr=reveal_attr and reveal_attr[2]
local total_extraAttrLookup=total_extraAttr and attrListHelper.tramsformToLookup(total_extraAttr)or{}
local add_rangeAttr=reveal_attr and reveal_attr[3]or{}

local next_reveal_attr=itemCfg.reveal_attr[newcnt]
local total_nextbaseAttr=next_reveal_attr[1]
local total_nextbaseAttrLookup=total_nextbaseAttr and attrListHelper.tramsformToLookup(total_nextbaseAttr)or{}
local total_nextextraAttr=next_reveal_attr[2]
local total_nextextraAttrLookup=total_nextextraAttr and attrListHelper.tramsformToLookup(total_nextextraAttr)or{}
local add_nextrangeAttr=next_reveal_attr and next_reveal_attr[3]or{}


local len=#baseAttr
local len1=#extraAttr
local tlen=len+len1
self.baseAttrlen=tlen
for i,v in ipairs(self.baseAttr)do
local widget=v:getWidgetBase()
if i<=len then
local attr=baseAttr[i]
local attrType=attr[1]
local val=attr[2]
local oldAdd=total_baseAttrLookup[attrType]or 0
local cur=val+oldAdd
local newAdd=total_nextbaseAttrLookup[attrType]or 0
local next=val+newAdd
self:fillAttr(widget,attrType,cur,next)
elseif i<=tlen then
local attr=extraAttr[i-len]
local attrType=attr[1]
local val=attr[2]
local oldAdd=total_extraAttrLookup[attrType]or 0
local cur=val+oldAdd
local newAdd=total_nextextraAttrLookup[attrType]or 0
local next=val+newAdd
self:fillAttr(widget,attrType,cur,next)
else
widget:SetChildActive(-1,false)
end
end

self.baseAttrRoot:setActive(false)

local len=#rangeAttr
self.rangeAttrlen=len
for i,v in ipairs(self.rangeAttr)do
local widget=v:getWidgetBase()
local attr=rangeAttr[i]
if attr then
local attrType=attr[1]
local val=attr[2]
local cnt=attr[3]or 0
local addTable=add_rangeAttr[attrType]
local add=addTable and(addTable[1]+addTable[2]*cnt)or 0
local cur=val+add
local addnextTable=add_nextrangeAttr[attrType]
local nextadd=addnextTable and(addnextTable[1]+addnextTable[2]*cnt)or 0
local next=val+nextadd
self:fillAttr(widget,attrType,attr[2],next)
else
widget:SetChildActive(-1,false)
end
end
self.rangeAttrRoot:setLocalPosY(_posY[tlen])
self.rangeAttrRoot:setActive(false)

self.titleBack:setScale(Vector3.zero)

self:doMyAnim()
end

function UIEquipDianHuaSuccessWin:onHide()

end



function UIEquipDianHuaSuccessWin:doMyAnim()
local delay=0
self.titleBack:setScale(Vector3(2,2,2))
self.titleBack:setChildDOScale(1,0.15)


self.targetItem:setChildCanvasGroupAlpha(0)
self.targetItem:setChildCanvasGroupDOFade(1,0.2)
delay=delay+0.2


self.baseAttrRoot:setActive(true)

for i,v in ipairs(self.baseAttr)do
if i<=self.baseAttrlen then
local widget=v:getWidgetBase()
widget:SetChildActive(-1,false)
local pos=widget:GetChildLocalPosition(-1)
widget:SetChildLocalPosY(-1,pos.y-200)
self:delayDo(delay,function()
widget:SetChildActive(-1,true)
widget:SetChildDOLocalMoveY(-1,pos.y,0.2)
end)
delay=delay+0.1
end
end

delay=delay+0.2


self.rangeAttrRoot:setActive(true)

for i,v in ipairs(self.rangeAttr)do
if i<=self.rangeAttrlen then
local widget=v:getWidgetBase()
widget:SetChildActive(-1,false)
local pos=widget:GetChildLocalPosition(-1)
widget:SetChildLocalPosY(-1,pos.y-200)
self:delayDo(delay,function()
widget:SetChildActive(-1,true)
widget:SetChildDOLocalMoveY(-1,pos.y,0.2)
end)
delay=delay+0.1
end
end

self.tips:setActive(false)
self:delayDo(delay,function()
self.tips:setActive(true)
self.closeTag=true
end)
end

function UIEquipDianHuaSuccessWin:fillAttr(widget,attrType,attrValue,next)
local name,valstr=equipsHelper.getAttr(attrType,attrValue)
local attrStr=FMT.fmt('{0}：{1}',name,valstr)
widget:SetChildText(1,attrStr)
widget:SetChildActive(1,true)
local name,valstr=equipsHelper.getAttr(attrType,next)
widget:SetChildText(3,valstr)
end

function UIEquipDianHuaSuccessWin:freshTargetItem()
local itemguid=self.itemguid
local equip=equipsHelper.getEquip(itemguid)
local itemid=equip.itemid
local widget=self.targetItem:getWidgetBase()
self:fillItem(widget,itemid,itemguid)
end

function UIEquipDianHuaSuccessWin:fillItem(widget,itemid,itemguid)
if itemid then
local itemCfg=itemsConfig.getConfig(itemid)
local equip=equipsHelper.getEquip(itemguid)
local color=itemCfg.color
local iconName=itemsModel.getIconName(equip)
local stageStr=FMT.fmt('{0}阶',itemCfg.stage)
local jllv=equip.itemData.jinglianlv or 0
local jlStr=jllv>0 and jllv or''

widget:SetChildActive(2,true)
widgetHelper.setItemQulaity(widget,itemid,2,color)
widget:SetChildIcon(3,iconName,false)
widget:SetChildText(6,stageStr)
widget:SetChildText(7,itemsModel.getNameByItem(equip))
widget:SetChildActive(8,true)
widget:SetChildActive(9,false)
widget:SetChildText(10,'')
widget:SetChildIcon(11,equipsHelper.getEquipSuitIcon(equip),false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
else
widget:SetChildActive(2,false)
widget:SetChildIcon(3,'',false)
widget:SetChildText(6,'')
widget:SetChildText(7,'')
widget:SetChildActive(8,false)
widget:SetChildActive(9,true)
widget:SetChildText(10,'')
widget:SetChildIcon(11,'',false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end
function UIEquipDianHuaSuccessWin:onClose()
local stamp=os.time()
local left=stamp-self.stamp
if self.closeTag or left>=2 then
self:closeSelf()
end
end

function UIEquipDianHuaSuccessWin:onClickTargetItem(itemid,index,itemguid,attach)
tipsManager.showTips({formType=TIPS_FORM_TYPE.eClearBtn,
itemid=itemid,
itemguid=itemguid})
end
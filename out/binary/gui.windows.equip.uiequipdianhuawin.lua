







def_class("UIEquipDianHuaWin",UIWindowBase)









function UIEquipDianHuaWin:bindComponents()

self.attrPanel=UIObject.get(self,0)
self.attrRoot=UIObject.get(self,1)
self.baseAttrCreator=UIObject.get(self,2)
self.blockRaycast=UIObject.get(self,3)
self.btnDianHua=UIButton.get(self,4)
self.btnPut=UIObject.get(self,5)
self.costitem_1=UIBaseItem.get(self,6)
self.costitem_2=UIBaseItem.get(self,7)
self.dhItem=UIBaseItem.get(self,8)
self.effect=UIObject.get(self,9)
self.equipType=UIText.get(self,10)
self.helpBtn=UIButton.get(self,11)
self.modelAttrBg=UIObject.get(self,12)
self.modelBg=UIObject.get(self,13)
self.needJingJie=UIText.get(self,14)
self.npcModel=UIObject.get(self,15)
self.npcRoot=UIObject.get(self,16)
self.npcTalkBg=UIObject.get(self,17)
self.npcTalkTxt=UIText.get(self,18)
self.progress=UIObject.get(self,19)
self.progressBar=UIProgressBarAni.get(self,20)
self.rangeAttrCreator=UIObject.get(self,21)
self.root=UIObject.get(self,22)
self.targetItem=UIBaseItem.get(self,23)
self.targetItem2=UIBaseItem.get(self,24)
self.targetName=UIText.get(self,25)

self.btnDianHua:setButtonClick(function()self:onBtnDianHua()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)
self.costitem={
self.costitem_1,
self.costitem_2,
}



end


function UIEquipDianHuaWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.attrRoot);self.attrRoot=nil;
_UIObject_release(self.baseAttrCreator);self.baseAttrCreator=nil;
_UIObject_release(self.blockRaycast);self.blockRaycast=nil;
_UIObject_release(self.btnDianHua);self.btnDianHua=nil;
_UIObject_release(self.btnPut);self.btnPut=nil;
_UIObject_release(self.costitem_1);self.costitem_1=nil;
_UIObject_release(self.costitem_2);self.costitem_2=nil;
_UIObject_release(self.dhItem);self.dhItem=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.equipType);self.equipType=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.modelAttrBg);self.modelAttrBg=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.needJingJie);self.needJingJie=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.npcRoot);self.npcRoot=nil;
_UIObject_release(self.npcTalkBg);self.npcTalkBg=nil;
_UIObject_release(self.npcTalkTxt);self.npcTalkTxt=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.rangeAttrCreator);self.rangeAttrCreator=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.targetItem);self.targetItem=nil;
_UIObject_release(self.targetItem2);self.targetItem2=nil;
_UIObject_release(self.targetName);self.targetName=nil;
self.costitem=nil;
end
















local _getIconName=function(color)
return FMT.fmt('icon_jingliantp_{0}',color-1)
end

local _getBgName=function(color)
return FMT.fmt('image_jinglianbg_{0}',color-1)
end

local _getDHCountBgName=function(color)
return FMT.fmt('image_gwtouxiangdjk_{0}',color)
end

local _getAttrColor=function(attrId,val,itemsStage)
local const_def=cfg_discipleequipjinglianconfig().const_def
local attrcolor=const_def.attrcolor
local attrColortable=attrcolor[attrId][itemsStage]
local flag=cfg_attributesconfig_get(attrId).flag
if flag==2 then
val=val/100
elseif flag==3 then
val=val*100
end
for k,v in pairs(attrColortable)do
if val>=v[1]and(v[2]==nil or val<v[2])then
return k
elseif k>=#attrColortable then
return k
end
end
loggerUtil.logErrFMT('属性{0}阶数{1}没有找到值{2}对应的颜色',attrId,itemsStage,val)
end


local _fixtime=3.5

function UIEquipDianHuaWin:onLoaded(...)
self:bindComponents()

self.dhItem:setBaseItemClickEvent(function(...)
if self and not self.isClose then
self:onClickDHItem(...)
end
end)












self.modelBg:setChildUIModelShowTarget(5213,1,nil,eAnimationID.stand)

self.islianzhi=false
self.lzstamp=0
self.blockRaycast:setActive(false)
end

function UIEquipDianHuaWin:__delete()
self:unbindComponents()
end

function UIEquipDianHuaWin:onShow(argtable,afterOnloaded)
if argtable then
local guid=argtable.entityId
self.entityId=guid
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)
zongmenModel:countManufacturePercent(self.bdData)
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.bdType=self.config.id
local build_id=self.bdData.build_id
self.ubdId=self.bdData.un_build_id
self.buildConfig=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
self.bdDatas=zongmenModel:getBuildingDataByBdId(self.sfId,build_id)
if argtable.itemguid then
local itemguid=argtable.itemguid
self.itemguid=itemguid
local equip=equipsHelper.getEquip(itemguid)
if equip then
self.itemid=equip.itemid
end
end
end
self:freshInfo()
self:freshNpcRoot()
end

function UIEquipDianHuaWin:onShowArgRecv(argtable)
local oldId=self.entityId
local newId=argtable.entityId
if newId~=oldId then
self:__delete()
self:onLoaded()
self:onShow(argtable)
end
end

function UIEquipDianHuaWin:onHide()

end





function UIEquipDianHuaWin:onRightArrow()
end



function UIEquipDianHuaWin:onLeftArrow()
end



function UIEquipDianHuaWin:onBtnDianHua()
if not self:hasPutDHItem()then
UIManager.error('请注入装备')
return
end
local ret,args=self:hasEnoughCostItem(self.itemid)
if not ret then
local itemid=args[1]
local need=args[2]
local name=itemsModel.getName(itemid)
UIManager.error(FMT.fmt('{0}不足',name))
gainControl:showGainWin(itemid)
return
end
equipsProtocolControl.req_equip_2_138(self.itemguid)
end



function UIEquipDianHuaWin:onBtnPut()

end

function UIEquipDianHuaWin:onHelpBtn()
local d={}
d.title='【规则说明】'
d.mode=3
d.name='equip_dianhua_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIEquipDianHuaWin:freshInfo()
self:stopAllTimer()
self:freshdhItem()
self:freshTargetItem()
self:freshCostItem()
self:freshBtns()
self:freshAttrPanel()
self:freshProgress()
end

function UIEquipDianHuaWin:freshdhItem()
local itemid=self.itemid
local itemguid=self.itemguid
local widget=self.dhItem:getWidgetBase()
self:fillItem(widget,itemid,itemguid)
widget:SetChildActive(12,itemguid~=nil)
end

function UIEquipDianHuaWin:freshTargetItem()
local itemid=self.itemid
local itemguid=self.itemguid
local widget=self.targetItem:getWidgetBase()
if itemid then
widget:SetChildActive(-1,true)
self:fillItem(widget,itemid,itemguid,true)
else
widget:SetChildActive(-1,false)
self:fillItem(widget)
end
end

function UIEquipDianHuaWin:freshTargetItem2()
local itemid=self.itemid
local itemguid=self.itemguid
local widget=self.targetItem2:getWidgetBase()
if itemid then
widget:SetChildActive(-1,true)
self:fillItem(widget,itemid,itemguid)
else
widget:SetChildActive(-1,false)
self:fillItem(widget)
end
end

function UIEquipDianHuaWin:fillItem(widget,itemid,itemguid,isdh)
if itemid then
local equip=equipsHelper.getEquip(itemguid)
local itemCfg=itemsConfig.getConfig(itemid)
local color=itemCfg.color
local iconName=isdh and iconHelper.getItemIconName(itemCfg.dhicon[1])or
iconHelper.getIconName(itemid)
local stageStr=FMT.fmt('{0}阶',itemCfg.stage)
local jllv=equip.itemData.jinglianlv or 0
local jlStr=jllv>0 and jllv or''

widget:SetChildActive(2,true)
widgetHelper.setItemQulaity(widget,itemid,2,color)
widget:SetChildIcon(3,iconName,false)
widget:SetChildText(6,stageStr)
widget:SetChildText(7,'')
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

function UIEquipDianHuaWin:freshCostItem()
local hasPutDHItem=self:hasPutDHItem()
local dhCfg=self.itemid and equipsConfig.getEquipDianHuaCfg(self.itemid)or nil
local cost=dhCfg and dhCfg.costs or nil
for i,v in ipairs(self.costitem)do
local widget=v:getWidgetBase()
if hasPutDHItem and cost and cost[i]then
widget:SetChildActive(-1,true)
local itemid=cost[i][1]
local need=cost[i][2]
local has=itemsModel.getCount(itemid)
local enough=has>=need
local itemCfg=itemsConfig.getConfig(itemid)
local color=itemCfg.color
local iconName=iconHelper.getIconName(itemid)
local stageStr=itemCfg.stage and FMT.fmt('{0}阶',itemCfg.stage)or''
local needStr=mathHelper.formatNumber(need,true)
local hasStr=mathHelper.formatNumber(has,true)
local isMoney=itemsConfig.isMoney(itemid)
local countStr=enough and FMT.fmt('{0}/{1}',hasStr,needStr)or
FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',hasStr,needStr)
if isMoney then
if enough then
countStr=needStr
else
countStr=FMT.cfmt(FONT_COLOR.eRedColor,needStr)
end
end
widget:SetChildActive(1,true)
widgetHelper.setItemQulaity(widget,itemid,1,color)
widget:SetChildIcon(2,iconName,false)
widget:SetChildText(3,countStr)
widget:SetChildActive(4,not enough or need>1 and true or false)
widget:SetChildText(5,stageStr)
widget:SetChildActive(7,stageStr~='')
widget:SetChildText(6,itemCfg.name)
widget:SetChildActive(8,false)
widget:SetChildActive(9,false)
elseif hasPutDHItem and cost[i]==nil then
widget:SetChildActive(1,false)
widget:SetChildIcon(2,'',false)
widget:SetChildText(3,'')
widget:SetChildActive(4,false)
widget:SetChildText(5,'')
widget:SetChildText(6,'点化材料')
widget:SetChildActive(7,false)
widget:SetChildActive(8,false)
widget:SetChildActive(9,true)
else
widget:SetChildActive(1,false)
widget:SetChildIcon(2,'',false)
widget:SetChildText(3,'')
widget:SetChildActive(4,false)
widget:SetChildText(5,'')
widget:SetChildText(6,'点化材料')
widget:SetChildActive(7,false)
widget:SetChildActive(8,hasPutDHItem)
widget:SetChildActive(9,not hasPutDHItem)
end
if cost and cost[i]then
widget:SetBaseItemClickEvent(-1,function()
self:onClickCostItem(cost[i][1],cost[i][2])
end)
else
widget:SetBaseItemClickEvent(-1,nil)
end
end
end

function UIEquipDianHuaWin:freshBtns()
local showPut=not self:hasPutDHItem()and not self.islianzhi
local showDianHua=self:hasPutDHItem()and not self.islianzhi
self.btnPut:setActive(showPut)
self.winlua:SetChildImageExGray(self.btnPut:getID(),true)
self.btnDianHua:setActive(showDianHua)
end

function UIEquipDianHuaWin:freshAttrPanel()
local vis=self:hasPutDHItem()
self.attrPanel:setActive(vis)
if not vis then return end
self.modelAttrBg:setChildUIModelShowTarget(5214,1,nil,eAnimationID.stand)
local itemguid=self.itemguid
local itemid=self.itemid
local equipType=equipsConfig.getEquipType(itemid)
local isWeapon=equipType==EQUIP_TYPE.eWeapon
local itemCfg=itemsConfig.getConfig(itemid)
local stage=itemCfg.stage
local type2=itemCfg.type2
local weaponType=isWeapon and equipsConfig.getWeaponConfig(type2).name or''
local typeName=isWeapon and FMT.fmt('武器（{0}）',weaponType)or
equipsConfig.getEquipName(equipType)
local needjingjielv=equipsConfig.getDressJingjielv(itemCfg.stage)
local jingjieName=UIDiscipleModel:getJJNameX(needjingjielv)
jingjieName=FMT.fmt('{0}期',jingjieName)
local fight=equipsHelper.getEquipFightX(itemid,itemguid)

self.targetName:setText(itemsConfig.getColorName(itemid))
self:freshTargetItem2()
self.equipType:setText(FMT.fmt('类型：<color=#171311>{0}</color>',typeName))
self.needJingJie:setText(FMT.fmt('境界：<color=#171311>{0}</color>',jingjieName))

local equip=equipsHelper.getEquip(itemguid)
local dhcnt=equipsModel:getDianHuaCnt(equip)
local olddhcnt=dhcnt
local newdhcnt=dhcnt+1
local baseAttr=equipsHelper.getBaseAttrsList(itemCfg)
local extraAttr=equipsHelper.getExtraAttrsList(itemCfg)or{}
local rangeAttr=equipsHelper.getRandomAttrList(equip)
local extraAttrLookup=attrListHelper.tramsformToLookup(extraAttr)or{}


local old_reveal_attr=itemCfg.reveal_attr[olddhcnt]
local total_baseAttr=old_reveal_attr and old_reveal_attr[1]
local total_baseAttrLookup=total_baseAttr and attrListHelper.tramsformToLookup(total_baseAttr)or{}
local total_extraAttr=old_reveal_attr and old_reveal_attr[2]
local total_extraAttrLookup=total_extraAttr and attrListHelper.tramsformToLookup(total_extraAttr)or{}
local add_rangeAttr=old_reveal_attr and old_reveal_attr[3]or{}

local next_reveal_attr=itemCfg.reveal_attr[newdhcnt]or old_reveal_attr
local total_nextbaseAttr=next_reveal_attr[1]
local total_nextbaseAttrLookup=total_nextbaseAttr and attrListHelper.tramsformToLookup(total_nextbaseAttr)or{}
local total_nextextraAttr=next_reveal_attr[2]
local total_nextextraAttrLookup=total_nextextraAttr and attrListHelper.tramsformToLookup(total_nextextraAttr)or{}
local add_nextrangeAttr=next_reveal_attr and next_reveal_attr[3]or{}

local len=#baseAttr
local len1=#extraAttr
local tlen=len+len1
self.baseAttrCreator:setChildLayoutGroupCreateItems(tlen)
local grids=self.baseAttrCreator:getChildLayoutGroupGridList()
for i=1,tlen do
local widget=grids[i-1]
if i<=len then
local attr=i<=len and baseAttr[i]
local attrType=attr[1]
local oldAdd=total_baseAttrLookup[attrType]or 0
local cur=attr[2]+oldAdd
local newAdd=total_nextbaseAttrLookup[attrType]or 0
local next=attr[2]+newAdd
self:fillAttr(widget,attrType,cur,next-cur)
else
local attr=extraAttr[i-len]
local attrType=attr[1]
local val=attr[2]
local extraVal=total_extraAttrLookup[attrType]or 0
local cur=val+extraVal
local curExtra=total_nextextraAttrLookup[attrType]or 0
local next=val+curExtra
self:fillAttr(widget,attrType,cur,next-cur)
end
end

local len=#rangeAttr
self.rangeAttrCreator:setChildLayoutGroupCreateItems(len)
local grids=self.rangeAttrCreator:getChildLayoutGroupGridList()
for i=1,len do
local widget=grids[i-1]
local attr=rangeAttr[i]
local attrType=attr[1]
local cnt=attr[3]or 0
local val=attr[2]or 0
local addTable=add_rangeAttr[attrType]
local add=addTable and(addTable[1]+addTable[2]*cnt)or 0
local cur=val+add
local addnextTable=add_nextrangeAttr[attrType]
local nextadd=addnextTable and(addnextTable[1]+addnextTable[2]*cnt)or 0
local next=val+nextadd
self:fillRandomAttr(widget,attrType,cur,next-cur,stage,cnt)
end
end

function UIEquipDianHuaWin:freshProgress()
self.progress:setActive(self.islianzhi)
if self.dhTimer then
self:stopTimerByID(self.dhTimer)
self.dhTimer=nil
end
if not self.islianzhi then return end
local fixtime=_fixtime-0.5
local lzstamp=self.lzstamp
local stamp=timeHelper.getServerShortTime()
local cost=stamp-lzstamp
local left=fixtime-cost
if left<0 then left=0 end
if cost>fixtime then cost=fixtime end
self.progressBar:animateFiveParams(cost,fixtime,fixtime,left)
if left>0 then
self.dhTimer=self:delayDo(left,function()
self.islianzhi=false
self.itemid=nil
self.itemguid=nil
self.blockRaycast:setActive(false)
if self.dhTimer then
self:stopTimerByID(self.dhTimer)
self.dhTimer=nil
end
end)
end
end

function UIEquipDianHuaWin:fillAttr(widget,attrType,attrValue,add)
local name,valstr=equipsHelper.getAttr(attrType,attrValue)
local attrStr=FMT.fmt('{0}:<color=#171311>{1}</color>',name,valstr)
widget:SetChildText(0,attrStr)
widget:SetChildActive(1,add>0)
if add>0 then
local name,valstr=equipsHelper.getAttr(attrType,add)
widget:SetChildText(3,valstr)
end
end

function UIEquipDianHuaWin:fillRandomAttr(widget,attrType,attrValue,add,stage,cnt)
local name,valstr=equipsHelper.getAttr(attrType,attrValue)
local attrStr=FMT.fmt('{0}:<color=#171311>{1}</color>',name,valstr)
widget:SetChildText(0,attrStr)
widget:SetChildActive(1,add>0)
if add>0 then
local name,valstr=equipsHelper.getAttr(attrType,add)
widget:SetChildText(3,valstr)
end

local attrColor=_getAttrColor(attrType,attrValue,stage)
widget:SetChildCSImageSprite(4,globalABLookup.equipJinglian,_getBgName(attrColor))

local isShowCount=cnt>0
widget:SetChildActive(5,not isShowCount)
widget:SetChildActive(6,isShowCount)

if isShowCount then
widget:SetChildCSImageSprite(6,globalABLookup.global,_getDHCountBgName(attrColor))
widget:SetChildText(7,string.format('x%d',cnt))
else
widget:SetChildCSImageSprite(5,globalABLookup.equipJinglian,_getIconName(attrColor))
end
end

function UIEquipDianHuaWin:showSelectWin(itemguid)
local equips=self:getAllDianHuaEquips()
if#equips==0 then
UIManager.error('没有可点化的装备')
return
end

local args={}
args.titleName="选择装备"
args.pos=6
args.extraWin='UIEquipDHSelectWin'
local extraParams={}
extraParams.itemguid=itemguid
extraParams.selectCB=function(itemguid)
if not self or self.isClose then return end
self:putEquip(itemguid)
UIManager:closeWindow('UICommonPageWin')
end
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIEquipDianHuaWin:onClickItem(itemid,index,itemguid,attach)
tipsManager.showTips({formType=TIPS_FORM_TYPE.eDianHua,itemid=itemid,itemguid=itemguid})
end

function UIEquipDianHuaWin:onClickCostItem(itemid,need)
local has=itemsModel.getCount(itemid)
if has>=need then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eClearBtn,itemid=itemid})
else
gainControl:showGainWin(itemid)
end
end

function UIEquipDianHuaWin:onClickDHItem(itemid,index,itemguid,attach)
self:showSelectWin(itemguid)
end

function UIEquipDianHuaWin:hasPutDHItem()
return self.itemguid~=nil and self.itemid~=nil
end

function UIEquipDianHuaWin:hasEnoughCostItem(itemid)
local dhCfg=equipsConfig.getEquipDianHuaCfg(itemid)
local cost=dhCfg.costs
for i,v in ipairs(cost)do
local itemid=v[1]
local need=v[2]
local has=itemsModel.getCount(itemid)
if has<need then
return false,{itemid,need}
end
end
return true
end

function UIEquipDianHuaWin:putEquip(itemguid)
if tostring(itemguid)==tostring(self.itemguid)then return end
local old=self.itemguid
self.itemguid=itemguid
local equip=equipsHelper.getEquip(itemguid)
if equip==nil then
self.itemguid=old
return
end
self.itemid=equip.itemid
self:freshInfo()
end


function UIEquipDianHuaWin:onDianHua(itemguid,old,reveal_times)
if tostring(itemguid)~=tostring(self.itemguid)then return end
self.islianzhi=true
self.lzstamp=timeHelper.getServerShortTime()
self.effect:setChildShowEffect(10497,true)

AudioManager.playAudio(642)
self:freshProgress()
self:freshBtns()
self.blockRaycast:setActive(true)
self:delayDo(_fixtime-0.6,function()

AudioManager.playAudio(650)
end)
self.dhAniTimer=self:delayDo(_fixtime,function()
self.blockRaycast:setActive(false)
UIManager:showWindow('UIEquipDianHuaSuccessWin',{itemguid,old,reveal_times})
self:delayDo(0.2,function()
self:freshInfo()
end)
end)
end

function UIEquipDianHuaWin:getAllDianHuaEquips()
local cfg=equipsConfig.getEquipDianHuaDefCfg()
local minStage=cfg.min_equip_stage
local minColor=cfg.min_equip_color
local filter={}
filter[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eGreaterEquals,minStage}
filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eGreaterEquals,minColor}
local equips=equipsModel.getEquipByFilter(filter)
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eEquipBag,filter)
local temp={}
for i,v in ipairs(equips)do
if equipsHelper.isCanDianHua(v.itemguid)then
temp[#temp+1]=v
end
end

for i,v in ipairs(baglist)do
if equipsHelper.isCanDianHua(v.itemguid)then
temp[#temp+1]=v
end
end
return temp
end

function UIEquipDianHuaWin:freshNpcRoot()
self.npcModel:setChildUIModelShowTarget(1113004,1,{},eAnimationID.stand,false,false,0.5)
self.npcModel:setChildUIModelShowFlipX(true)
end
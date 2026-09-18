







def_class("UILingShouSkillUpWin",UIWindowBase)









function UILingShouSkillUpWin:bindComponents()

self.blackImg=UIObject.get(self,0)
self.changeroot=UIObject.get(self,1)
self.costLayout=UIObject.get(self,2)
self.effectCloseBtn=UIButton.get(self,3)
self.effectDescLayout=UIObject.get(self,4)
self.effectList=UIObject.get(self,5)
self.effectPreviewLayout=UIObject.get(self,6)
self.effectScrollView=UIScrollView.get(self,7)
self.ftitle2=UIText.get(self,8)
self.fullImg=UIObject.get(self,9)
self.line1=UIObject.get(self,10)
self.line2=UIObject.get(self,11)
self.opLayout=UIObject.get(self,12)
self.previewEffectBtn=UIButton.get(self,13)
self.root=UIObject.get(self,14)
self.skilDesc=UIObject.get(self,15)
self.skillItem=UIObject.get(self,16)
self.succesEffect=UIObject.get(self,17)
self.title1=UIObject.get(self,18)
self.title2=UIObject.get(self,19)
self.upBtn=UIButton.get(self,20)
self.upCondition=UIText.get(self,21)

self.effectCloseBtn:setButtonClick(function()self:onEffectCloseBtn()end)

self.previewEffectBtn:setButtonClick(function()self:onPreviewEffectBtn()end)

self.upBtn:setButtonClick(function()self:onUpBtn()end)



end


function UILingShouSkillUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.changeroot);self.changeroot=nil;
_UIObject_release(self.costLayout);self.costLayout=nil;
_UIObject_release(self.effectCloseBtn);self.effectCloseBtn=nil;
_UIObject_release(self.effectDescLayout);self.effectDescLayout=nil;
_UIObject_release(self.effectList);self.effectList=nil;
_UIObject_release(self.effectPreviewLayout);self.effectPreviewLayout=nil;
_UIObject_release(self.effectScrollView);self.effectScrollView=nil;
_UIObject_release(self.ftitle2);self.ftitle2=nil;
_UIObject_release(self.fullImg);self.fullImg=nil;
_UIObject_release(self.line1);self.line1=nil;
_UIObject_release(self.line2);self.line2=nil;
_UIObject_release(self.opLayout);self.opLayout=nil;
_UIObject_release(self.previewEffectBtn);self.previewEffectBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skilDesc);self.skilDesc=nil;
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.succesEffect);self.succesEffect=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.upBtn);self.upBtn=nil;
_UIObject_release(self.upCondition);self.upCondition=nil;
end
















local _this




function UILingShouSkillUpWin:onLoaded(...)
self:bindComponents()

_this=self

self.previewEffectLayoutShowFlag=false

self.effectDescItemList=self.effectDescLayout:getChildCommonLayoutGroupWidgetList()
self.costItemList=self.costLayout:getChildCommonLayoutGroupWidgetList()

local _bindWidgetFunc=function(index,item)
if _this==nil then return end
_this:bindEffectItem(index,item)
end
self.effectScrollView:bindScrollWidget(_bindWidgetFunc)

self.skill_open_sys_id=cfgHelper.get(cfg_lingshoubasicconfig_get,1,'skill_open_sys_id')

local _recv_19_14=function(guid,lv)
if _this==nil then return end
_this:recv_19_14(guid,lv)
end
self:addProNotify(19,14,_recv_19_14)

local _on_system_open=function(sysid)
if _this==nil then return end
if _this.skill_open_sys_id==sysid then
_this:refreshAll()
end
end
self:addNotify(notifyConfig.on_system_open,_on_system_open)

local _on_item_list_changed=function(argslist,lookup_guidStr,lookup_itemid)
if _this==nil then return end
for index,itemID in ipairs(_this.showMoneyLookupList)do
if lookup_itemid[itemID]then
_this:refreshOptionPart()
break
end
end
end
self:addNotify(notifyConfig.on_item_list_changed,_on_item_list_changed)

local _on_item_list_changed=function(mType)
if _this==nil then return end
for index,itemID in ipairs(_this.showMoneyLookupList)do
if itemID==mType then
_this:refreshOptionPart()
break
end
end
end
self:addNotify(notifyConfig.on_money_changed,_on_item_list_changed)

self.effectPreviewLayout:setActive(false)


self.previewEffectBtn:setActive(false)
end


function UILingShouSkillUpWin:__delete()
_this=nil


self:unbindComponents()
end




function UILingShouSkillUpWin:onShow(argtable,afterOnloaded)
self.lsGuid=argtable.lsGuid
self.skillID=argtable.skillID

self.lsSkillCfg=cfgHelper.get(cfg_lingshouskillconfig_get,self.skillID)











self:refreshAll()
end


function UILingShouSkillUpWin:onHide()

end



function UILingShouSkillUpWin:recv_19_14(guid)
if not mathHelper.compareInt64(self.lsGuid,guid)then return end
_this.succesEffect:setChildShowEffect(10060,true)
self:refreshAll()
end





function UILingShouSkillUpWin:onUpBtn()
local isPassCost,noPassArgs=lingshouModel:checkSkillCanUpLevelCostEnough(self.lsGuid,self.skillID,self.skillLV)
if not isPassCost then
gainControl:showGainWin(noPassArgs[1],noPassArgs[2])
return
end


lingshouController:reqUpMainSKill(self.lsGuid)
end

function UILingShouSkillUpWin:onPreviewEffectBtn()
self:changeShowPreviewEffect(true)
end

function UILingShouSkillUpWin:onEffectCloseBtn()
self:changeShowPreviewEffect(false)
end



function UILingShouSkillUpWin:freshData()
self.isOpen=systemModel.isOpen(self.skill_open_sys_id)
self.lsData=lingshouModel:getLingShouData2(self.lsGuid)
self.skillLV=self.lsData.skill_level
self.fSkillLv=lingshouModel.getLingShouPropertyVal(self.lsData,lingshouPropertyType.MAIN_SKILL_LEVEL)
self.isMaxLevel=lingshouModel:checkSkillLevelMax(self.skillID,self.skillLV)
end

function UILingShouSkillUpWin:refreshAll()
self:freshData()

self:refreshSkillHeadPart()

self:refreshSkillDescPart()

self:refreshUpLevelEffectListPart()

self:refreshOptionPart()



self:refreshChangeRoot()
end

function UILingShouSkillUpWin:refreshSkillHeadPart()
local skillWidget=self.skillItem:getChildWidgetBase()
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,self.skillID)
local isbd=skillModel.isSkillBD(skillCfg.skillType)

local name_str=skillCfg.name
local strTable=string.toTable(name_str)
local newStrTable={}

if pfwindowslController:checkIsGameVersion_yuenan()then
if#strTable>32 then
name_str=FMT.fmt("{0}...",utf8.sub(name_str,1,32))
end
else
if#strTable>5 then
for i=1,4 do
newStrTable[i]=strTable[i]
end
name_str=table.concat(newStrTable,"")
name_str=FMT.fmt("{0}...",name_str)
end
end

if not self.isShowSkill then
if self.skillDesc then
skillWidget:SetChildText(4,self.skillDesc)
else
skillWidget:SetChildText(4,skillModel:getSkillLvStr(self.fSkillLv))
end
else
skillWidget:SetChildText(4,'')
end
skillWidget:SetChildText(0,FMT.fmt(FONT_COLOR_FMT[FONT_COLOR.eTitle2Color],name_str))
skillWidget:SetChildIcon(1,iconHelper.getSkillIcon(skillCfg.icon),false)
skillWidget:SetChildActive(2,isbd)

local faction=skillCfg.skillFaction or FACTION_TYPE.eNone
local showfaction=faction~=FACTION_TYPE.eNone
skillWidget:SetChildActive(3,showfaction)
if showfaction then
local faction_icon=UIGongFaModel:getGFFactionIcon(faction)
skillWidget:SetChildCSImageSprite(3,globalABLookup.global,faction_icon)
end
end

function UILingShouSkillUpWin:refreshSkillDescPart()
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,self.skillID)

local skillDescWidget=self.skilDesc:getChildWidgetBase()
skillDescWidget:SetChildText(0,skillModel:getSkillDesc(self.skillID,self.fSkillLv))

local descExList=skillModel:getSkillDescEx(self.skillID,self.fSkillLv)
local descExNum=0
if descExList~=nil then
descExNum=#descExList
end
local showDescEx=descExNum>0

skillDescWidget:SetChildActive(1,false)

if false then
skillDescWidget:SetChildLayoutGroupCreateItems(1,descExNum)
local descExGrid=skillDescWidget:GetChildLayoutGroupGridList(1)
for i=1,descExNum do
local descItem=descExGrid[i-1]
local txt=descExList[i]
descItem:SetChildText(0,txt)
end
end

local coolDown=skillModel:getSkillCooldownTime(self.skillID,self.fSkillLv)
if self.dis_guid~=nil and UIDiscipleModel:isMyActorDZ(self.dis_guid)then
coolDown=UIDiscipleModel:getSkillCoolDown(self.dis_guid,self.skillID,coolDown)
end
local isCoolDown=coolDown>0
skillDescWidget:SetChildActive(2,isCoolDown)
if isCoolDown then
local cooldown_str=FMT.fmt('冷却：{0}回合',coolDown)
skillDescWidget:SetChildText(3,cooldown_str)
end

local maxGemPower=skillCfg.maxGemPower
local showGemPower=maxGemPower~=nil and maxGemPower>0
skillDescWidget:SetChildActive(4,showGemPower)
if showGemPower then
local gemPower_str=FMT.fmt('神通蓄力值：{0}',maxGemPower)
skillDescWidget:SetChildText(5,gemPower_str)
end

local skillYuanSu=skillCfg.skillYuanSu
local showYuanSu=skillYuanSu~=nil
skillDescWidget:SetChildActive(6,showYuanSu)
if showYuanSu then
local yuansu_str=FMT.fmt('五行系别：{0}',ELEMENT_TYPE.getName(skillYuanSu))
local attrType=elementAttrLookup[skillYuanSu][1]
local attrValue=self:getLSAttrValue(attrType)
local yuansu_str2=''
if attrValue~=nil and attrValue>0 then
local str=elementAttrLookup.getDesc2(skillYuanSu)
local str2=helper.getAttributeStrEx(attrType,attrValue)
yuansu_str2=FMT.fmt('({0}+{1})',str,str2)
end
skillDescWidget:SetChildText(7,yuansu_str)
skillDescWidget:SetChildText(8,yuansu_str2)
skillDescWidget:SetChildActive(8,not skillCfg.hideElementAttr)
end

local hurtType=skillCfg.hurtType
local showHurt=hurtType~=nil
skillDescWidget:SetChildActive(9,showHurt)
if showHurt then
local hurt_str=FMT.fmt('伤害类型：{0}',eSkillHurtLookup[hurtType].name)
local hurt_str2=''
if hurtType~=eSkillHurtType.eNone then
local attrType=eSkillHurtLookup[hurtType].attr[1]
local attrValue=self:getLSAttrValue(attrType)
if attrValue~=nil and attrValue>0 then
local str=eSkillHurtLookup[hurtType].desc
local str2=helper.getAttributeStrEx(attrType,attrValue)
hurt_str2=FMT.fmt('({0}+{1})',str,str2)
end
end
skillDescWidget:SetChildText(10,hurt_str)
skillDescWidget:SetChildText(11,hurt_str2)
end
end

function UILingShouSkillUpWin:refreshUpLevelEffectListPart()



































local max=self.isMaxLevel and self.fSkillLv or self.fSkillLv+1
local str=skillModel:getSkillupgradeDesc(self.skillID,max)
local descStrList=string.split(str,',')

for index=1,self.effectDescItemList.Count do
local item=self.effectDescItemList[index-1]
local descStr=descStrList[index]
local isShow=descStr~=nil
item:SetChildActive(-1,isShow)
if isShow then
item:SetChildText(0,descStr)
end
end

self.winlua:ForceLayoutVertical(self.effectDescLayout:getID())
end

function UILingShouSkillUpWin:refreshChangeRoot()


local changeStateList=skillModel:getSkillGiveStateList(self.skillID,self.skillLV)
if self.dis_guid then
local boradStateList=UIDiscipleModel:getDiscipleHoardEffectBySkillId(self.dis_guid,self.skillID)
changeStateList=table.concatTable(changeStateList,boradStateList)
end
local isHasFT=changeStateList~=nil and#(changeStateList or{})>0 and(not self.notShowBuffDescRoot)
self.isHasFT=isHasFT
self.changeroot:setActive(isHasFT)
if not self.customPos then
self.root:setChildAnchoredPos(isHasFT and-200 or 0,324)
end
if isHasFT then
self.changeroot:setChildLayoutGroupCreateItems(#changeStateList,function(index)
local item=self.changeroot:getChildLayoutGroupGridItem(index-1)
local data=changeStateList[index]
local stateIcon=data.stateType==1 and"icon_zengyi"or"icon_jianyi"
item:SetChildText(1,data.stateName)
item:SetChildIcon(0,iconHelper.getBuffIcon(data.stateIconId),false)
item:SetChildText(3,data.desc)
item:SetChildCSImageSprite(2,globalABLookup.global,stateIcon)

item:SetChildActive(4,data.gongFaTypeIcon~=nil)
if data.gongFaTypeIcon then
item:SetChildIcon(4,string.format('icon_gong_fa_type_%d',data.gongFaTypeIcon),true)
end
end)
end
end

function UILingShouSkillUpWin:refreshOptionPart()
local isShowCost=not self.isMaxLevel
self.costLayout:setActive(isShowCost)

local showMoneyList={}
self.showMoneyLookupList={}
if isShowCost then
local cost=self.lsSkillCfg.up_level_conf[self.skillLV]
for index=1,self.costItemList.Count do
local item=self.costItemList[index-1]
local data=cost[index]
local isShow=data~=nil
item:SetChildActive(-1,isShow)
if isShow then
local itemID=data[1]
local itemCount=data[2]
local hasCount=itemsModel.getCount(itemID)
local isEnough=hasCount>=itemCount
local color=isEnough and'#aae252'or'#f36666'

local countInfo
if itemsConfig.isMoney(itemID)then
countInfo=toColorStringX(color,string.format("%s",mathHelper.formatNumber4(itemCount,2)))
else
countInfo=toColorStringX(color,string.format("%s/%s",hasCount,itemCount))
end

local conf={itemid=itemID,itemcount="",showCountBG=false,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,propData)

item:SetChildText(1,countInfo)

item:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(itemID)
end)

showMoneyList[#showMoneyList+1]={itemID}
self.showMoneyLookupList[#self.showMoneyLookupList+1]=itemID
end
end

end

local isPassCondition,noPassArgs

local isPassCondition,noPassArgs=lingshouModel:checkUpSkillLevelCondition(self.lsGuid,self.skillID,self.skillLV)

local isShowUpCondition=isShowCost and not isPassCondition
self.upCondition:setActive(isShowUpCondition)
self.upBtn:setActive(isShowCost and isPassCondition)
self.fullImg:setActive(self.isMaxLevel)
if isShowUpCondition then
local noPassDesc=lingshouModel:getUpLevelConditionNoPassDesc(noPassArgs)
self.upCondition:setText(noPassDesc)
end


self:showWindow("UITopMoneyHighWin",showMoneyList)

end

function UILingShouSkillUpWin:refreshPreviewEffectListPart()

local len=#self.previewEffectList
self.effectScrollView:freshGridsNum(len,len,1,false)

end

function UILingShouSkillUpWin:bindEffectItem(index,item)
local data=self.previewEffectList[index]
local isShow=data~=nil
item:SetChildActive(-1,isShow)
if isShow then
local needLv=data[1]
local effect=data[2]
local isActive=self.skillLV>=needLv
local tcolor=isActive and FONT_COLOR.eNomalBlackColor or FONT_COLOR.eNomalGrayColor


local bsdesc=isActive and'已激活'or FMT.fmt("{0}级可激活",needLv)
local sdesc=bsdesc
local desc=effect

item:SetChildText(0,desc)
item:SetChildText(1,sdesc)
end
end






function UILingShouSkillUpWin:getLSAttrValue(attrType)
if self.lsGuid~=nil then
if self.lsAttrLookup==nil then
self.lsAttrLookup=lingshouModel:getAllAttrLookup(self.lsGuid)
end
return self.lsAttrLookup[attrType]
end
return nil
end



function UILingShouSkillUpWin:changeShowPreviewEffect(state)

if state then
local ePos=self.isHasFT and-400 or-200
local rPos=self.isHasFT and 50 or 235
self.effectPreviewLayout:setChildCanvasGroupAlpha(0)
self.effectPreviewLayout:setActive(true)
self.root:setChildAnchoredPos(rPos,324)
self.effectPreviewLayout:setChildAnchoredPos(ePos,342)
self.effectPreviewLayout:setChildCanvasGroupDOFade(1,0.2)
self.previewEffectBtn:setActive(false)
self:jumpPreViewEffectItem()
else
local rPos=self.isHasFT and-200 or 0
self.effectPreviewLayout:setChildCanvasGroupAlpha(0)
self.effectPreviewLayout:setActive(false)
self.root:setChildAnchoredPos(rPos,324)
self.previewEffectBtn:setActive(true)
end

self.previewEffectLayoutShowFlag=state
end

function UILingShouSkillUpWin:jumpPreViewEffectItem()
local jumpIndex=1
for index,data in ipairs(self.previewEffectList)do
local needLv=data[1]
local isActive=self.skillLV>=needLv
jumpIndex=index
if not isActive then
break
end
end

self.effectScrollView:jumpToLockX(jumpIndex-1)
end

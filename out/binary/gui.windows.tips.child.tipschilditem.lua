







def_class("tipsChildItem",UICloneObject)





tipsChildItem.abName="ui/windows/tips/child/tipschilditem.ab"

tipsChildItem.assetName="tipsChildItem"


function tipsChildItem:bindComponents()

self.title1=UIText.get(self,0)
self.title2=UIText.get(self,1)
self.title3=UIText.get(self,2)
self.name=UIText.get(self,3)
self.Icon=UIImage.get(self,4)
self.tips=UIText.get(self,5)
self.displayBtn=UIButton.get(self,6)
self.displayTx=UIText.get(self,7)
self.liandon=UIObject.get(self,8)
self.liandonBtn=UIButton.get(self,9)

self.displayBtn:setButtonClick(function()self:onDisplayBtn()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)

end


function tipsChildItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.title3);self.title3=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.displayBtn);self.displayBtn=nil;
_UIObject_release(self.displayTx);self.displayTx=nil;
_UIObject_release(self.liandon);self.liandon=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
end






local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemCount=2,
cmpItemTxtStageBg=3,
cmpItemTxtStage=4,
}

local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end

local _descRedFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eRedColor,desc))
end

local _descGreenFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGreenColor,desc))
end

function tipsChildItem:onLoaded()
self:bindComponents()
end

function tipsChildItem:__delete()
self:unbindComponents()
end

function tipsChildItem:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach

self.itemConfig=itemsConfig.getConfig(itemid)
self.showStage=false
self:fillInfo(itemid,itemguid,self.itemConfig,attach)

end


















function tipsChildItem:fillInfo(itemid,itemguid,itemConfig,attach)
if attach.nameReplace then
self.name:setText(attach.nameReplace)
else
local tips=attach.nameAttach
local nameStr=FMT.fmt("{0}{1}",itemConfig.name,tips or"")
self.name:setText(nameStr)

end
self.Icon:setImageIcon(iconHelper.getIconName(itemid),false)
itemsComponentHelper.setUIBaseItemSmallSignCommon(self.widget,self.Icon:getID(),itemid,false)

local idx=1
self.title1:setText(_descFun('类型：',itemConfig.typename))
for i=2,3 do
self[FMT.fmt('title{0}',i)]:setActive(false)
end

if itemConfig.level then
idx=idx+1
local zmLevel=zongmenModel:getLevel()
local str=FMT.fmt('宗门{0}级',itemConfig.level)
local txt=_descFun('使用等级：',str)
if zmLevel<itemConfig.level then
txt=_descFun('使用等级：',FMT.cfmt(FONT_COLOR.eRedColor,str))
end
self[FMT.fmt('title{0}',idx)]:setText(txt)
self[FMT.fmt('title{0}',idx)]:setActive(true)
elseif itemConfig.stage then
idx=idx+1
local stageTitile,isPin=itemsConfig.getStageName(itemid)
local title=isPin and'品阶：'or'阶数：'
local txt=_descFun(title,pfwindowslController:getStageStr(itemid,stageTitile))
self[FMT.fmt('title{0}',idx)]:setText(txt)
self[FMT.fmt('title{0}',idx)]:setActive(true)
self.showStage=true
end


if idx<3 and not self.showStage and itemConfig.stage and itemConfig.showTipsStage then
idx=idx+1
local stageTitile,isPin=itemsConfig.getStageName(itemid)
local title=isPin and'品阶：'or'阶数：'
local txt=_descFun(title,pfwindowslController:getStageStr(itemid,stageTitile))
self[FMT.fmt('title{0}',idx)]:setText(txt)
self[FMT.fmt('title{0}',idx)]:setActive(true)
self.showStage=true
end

if idx<3 and itemConfig.element then
idx=idx+1
local elementName=ELEMENT_TYPE.getName(itemConfig.element)
local txt=_descFun('五行属性：',elementName)
self[FMT.fmt('title{0}',idx)]:setText(txt)
self[FMT.fmt('title{0}',idx)]:setActive(true)
end


local funcparam=itemConfig.funcparam
if idx<3 and funcparam and funcparam.condition then
idx=idx+1
local condition=funcparam.condition
local title='使用限制：'
local jingjie=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eJingjieLv,condition)
local lianti=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eLiantiLv,condition)
if jingjie then
local minJJLv=jingjie[1]
local title3Str=''
local jjName=UIDiscipleModel:getJJName(minJJLv)
title3Str=FMT.fmt('{0}期',jjName)
self[FMT.fmt('title{0}',idx)]:setText(_descFun(title,title3Str))
self[FMT.fmt('title{0}',idx)]:setActive(true)
elseif lianti then
local minltLv=lianti[1]
local title3Str=''
local ltName=UIDiscipleModel:getLTName(minltLv)
title3Str=FMT.fmt('{0}期',ltName)
self[FMT.fmt('title{0}',idx)]:setText(_descFun(title,title3Str))
self[FMT.fmt('title{0}',idx)]:setActive(true)
end
end


local id=wanLingTaModel:good2ZMBW(itemid)
if idx<3 and id then
idx=idx+1
local tjData=wanLingTaModel:getTuJianData(id)
local isActive=tjData.level>0
local title='须弥塔收集：'
local title3Str=isActive and"已收集"or"未收集"
self[FMT.fmt('title{0}',idx)]:setText(isActive and _descGreenFun(title,title3Str)or _descRedFun(title,title3Str))
self[FMT.fmt('title{0}',idx)]:setActive(true)
end

local displayInfo=itemConfig.display
local showDisplay=api_Available_SetChildFightRenderToImage()and fightModel:haveBattleShow()==nil and displayInfo~=nil
self.displayBtn:setActive(showDisplay)
if showDisplay then
local eType=displayInfo[3]
local str=reportDisplayConfig:getHandleName(eType)
self.displayTx:setText(str)
end


local isLD=liandonModel:getLianDonLinkageIdByItemId(itemid)>0
self.liandon:setActive(isLD)
end


function tipsChildItem:onItemClick(id,index,guid,attach)

end

function tipsChildItem:onDisplayBtn()
local reportCfg=self.itemConfig.display
reportDisplayController:displayReport(reportCfg[3],reportCfg[1],reportCfg[2],nil,reportCfg[4])
end

function tipsChildItem:onLiandonBtn()
local linkageId=liandonModel:getLianDonLinkageIdByItemId(self.itemConfig.id)
UIManager:showWindow('UITipLianDonWin',{linkageId=linkageId})
end

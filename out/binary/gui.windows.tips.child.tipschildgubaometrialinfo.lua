







def_class("tipsChildGuBaoMetrialInfo",UICloneObject)





tipsChildGuBaoMetrialInfo.abName="ui/windows/tips/child/tipschildgubaometrialinfo.ab"

tipsChildGuBaoMetrialInfo.assetName="tipsChildGuBaoMetrialInfo"


function tipsChildGuBaoMetrialInfo:bindComponents()

self.title1=UIText.get(self,0)
self.title2=UIText.get(self,1)
self.title3=UIText.get(self,2)
self.name=UIText.get(self,3)
self.Icon=UIImage.get(self,4)
self.sign=UIObject.get(self,5)
self.tips=UIText.get(self,6)

end


function tipsChildGuBaoMetrialInfo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.title3);self.title3=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.sign);self.sign=nil;
_UIObject_release(self.tips);self.tips=nil;
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

function tipsChildGuBaoMetrialInfo:onLoaded()
self:bindComponents()
end

function tipsChildGuBaoMetrialInfo:__delete()
self:unbindComponents()
end

function tipsChildGuBaoMetrialInfo:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach

local itemConfig=itemsConfig.getConfig(itemid)
self.showStage=false
self:fillInfo(itemid,itemguid,itemConfig,attach.nameAttach)
end


function tipsChildGuBaoMetrialInfo:fillInfo(itemid,itemguid,itemConfig,tips)
local nameStr=FMT.fmt("{0}{1}",itemConfig.name,tips or"")
self.name:setText(nameStr)

local iconname

local gbid=gubaoLookup:good2GuBao(itemid)
local isSpe=gbid==nil
local width
if not isSpe then
local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbid)
iconname=gubaoModel:getGuBaoIconName(gbCfg.icon)
width=96
else
iconname=iconHelper.getIconName(itemid)
width=70
end
self.Icon:setImageIcon(iconname,false)
self.Icon:setChildSizeDelta(width,width)
local callback=function(widget_)
if not isSpe then
widget_:SetChildLocalPos(-1,10,10,0)
end
end
itemsComponentHelper.setUIBaseItemSmallSignCommon(self.widget,self.Icon:getID(),itemid,false,callback)


local isSpe2=gbid~=nil and gubaoModel:isSpecial(gbid)
self.sign:setActive(isSpe2)

self.title1:setText(_descFun('类型：',itemConfig.typename))
for i=2,3 do
self[FMT.fmt('title{0}',i)]:setActive(false)
end
local idx=2
if itemConfig.level then
local txt=_descFun('使用等级：',FMT.fmt('宗门{0}级',itemConfig.level))
self.title2:setText(txt)
self.title2:setActive(true)
idx=idx+1
elseif itemConfig.stage then
local stageTitile,isPin=itemsConfig.getStageName(itemid)
local title=isPin and'品阶：'or'阶数：'
local txt=_descFun(title,pfwindowslController:getStageStr(itemid,stageTitile))
self.title2:setText(txt)
self.title2:setActive(true)
self.showStage=true
idx=idx+1
end

if itemConfig.element then
local elementName=ELEMENT_TYPE.getName(itemConfig.element)
local txt=_descFun('五行属性：',elementName)
self[FMT.fmt('title{0}',idx)]:setText(txt)
self[FMT.fmt('title{0}',idx)]:setActive(true)
idx=idx+1
end


local funcparam=itemConfig.funcparam
if idx<=3 and funcparam and funcparam.condition then
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
end


function tipsChildGuBaoMetrialInfo:onItemClick(id,index,guid,attach)

end

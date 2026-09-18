







def_class("tipsChildGuBaoInfo",UICloneObject)





tipsChildGuBaoInfo.abName="ui/windows/tips/child/tipschildgubaoinfo.ab"

tipsChildGuBaoInfo.assetName="tipsChildGuBaoInfo"


function tipsChildGuBaoInfo:bindComponents()

self.starGrid=UIObject.get(self,0)
self.name=UIText.get(self,1)
self.typename=UIText.get(self,2)
self.fight=UIText.get(self,3)
self.Icon=UIImage.get(self,4)
self.sign=UIObject.get(self,5)

end


function tipsChildGuBaoInfo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.starGrid);self.starGrid=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.typename);self.typename=nil;
_UIObject_release(self.fight);self.fight=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.sign);self.sign=nil;
end



local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end



local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
}


function tipsChildGuBaoInfo:onLoaded(...)
self:bindComponents()
end


function tipsChildGuBaoInfo:__delete()
self:unbindComponents()
end


function tipsChildGuBaoInfo:onHide()

end

function tipsChildGuBaoInfo:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local gbid=data.itemid
local attach=data.attach

local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbid)
if data.formType==TIPS_FORM_TYPE.eGubaoWin or data.formType==TIPS_FORM_TYPE.eGubaoCheck then
self:fillGuBaoInfo1(gbid,gbCfg)
else
self:fillGuBaoInfo2(gbid,gbCfg)
end

local creater=self:getCreater()
creater:callWinFunc('setColorFrameByType',TIPS_COLOR_TYPE.eGubao,gbCfg.color)
end



function tipsChildGuBaoInfo:fillGuBaoInfo1(gbid,gbCfg)
local iconname=gubaoModel:getGuBaoIconName(gbCfg.icon)
self.Icon:setImageIcon(iconname,false)
self.Icon:setChildSizeDelta(96,96)
local isActive=gubaoModel:checkActive(gbid)
local isAwake=gubaoModel:checkAwake(gbid)

local awake_str=isAwake and'[觉醒]'or''

local addStr=''
local lianhualv=gubaoModel:getLianHuaLv(gbid)
if lianhualv>0 then
addStr=FMT.fmt('+{0}',lianhualv)
else

local gbData=gubaoModel:getDataByID(gbid)
if gbData and gbData.gubaoskilllv>0 then
addStr=FMT.fmt("+{0}",gbData.gubaoskilllv)
end
end
local name_str=FMT.fmt('{0}{1}{2}',awake_str,gbCfg.name,addStr)
self.name:setText(name_str)

local tname_str2=_descFun('类型：','古宝')
self.typename:setText(tname_str2)

local fightnum=0
if isActive then
fightnum=gubaoModel:getBaseFightEx(gbid)
else
fightnum=gubaoModel:getBaseFight(gbid)
end
self.fight:setText(_descFun("战力：",fightnum))

local isSpe=gubaoModel:isSpecial(gbid)
self.sign:setActive(isSpe)

local starlv=gubaoModel:getStar(gbid)
local starWidget=self.starGrid:getChildWidgetBase()
for i=1,5 do
starWidget:SetChildActive(i-1,i<=starlv)
end
end

function tipsChildGuBaoInfo:fillGuBaoInfo2(gbid,gbCfg)
local iconname=gubaoModel:getGuBaoIconName(gbCfg.icon)
self.Icon:setImageIcon(iconname,true)

self.name:setText(gbCfg.name)

local tname_str2=_descFun('类型：','古宝')
self.typename:setText(tname_str2)

local fightnum=gubaoModel:getBaseFight(gbid)
self.fight:setText(_descFun("战力：",fightnum))

local isSpe=gubaoModel:isSpecial(gbid)
self.sign:setActive(isSpe)

local starWidget=self.starGrid:getChildWidgetBase()
for i=1,5 do
starWidget:SetChildActive(i-1,false)
end
end
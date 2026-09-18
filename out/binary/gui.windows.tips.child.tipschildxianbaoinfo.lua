







def_class("tipsChildXianBaoInfo",UICloneObject)





tipsChildXianBaoInfo.abName="ui/windows/tips/child/tipschildxianbaoinfo.ab"

tipsChildXianBaoInfo.assetName="tipsChildXianBaoInfo"


function tipsChildXianBaoInfo:bindComponents()

self.starGrid=UIObject.get(self,0)
self.name=UIText.get(self,1)
self.typename=UIText.get(self,2)
self.fight=UIText.get(self,3)
self.Icon=UIImage.get(self,4)
self.sign=UIObject.get(self,5)

end


function tipsChildXianBaoInfo:unbindComponents()
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


function tipsChildXianBaoInfo:onLoaded(...)
self:bindComponents()
end


function tipsChildXianBaoInfo:__delete()
self:unbindComponents()
end




function tipsChildXianBaoInfo:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local xbid=data.itemid
self.attach=data.attach
self.formType=data.formType
local xbCfg=itemsConfig.getConfig(xbid,data.cfgType)
self:fillXianBaoInfo(xbid,xbCfg,data)
local creater=self:getCreater()
creater:callWinFunc('setColorFrameByType',TIPS_COLOR_TYPE.eXianBao,xbCfg.color)
end


function tipsChildXianBaoInfo:onHide()

end

function tipsChildXianBaoInfo:fillXianBaoInfo(xbid,xbCfg,data)
local xbType=data.xbtype or XianBaoTypeEnum.eXianBao
local iconname=xianbaoConfig.getTypeFuncResult(xbType,'getIcon',xbid)
self.Icon:setImageIcon(iconname,true)

local name=xianbaoConfig.getTypeFuncResult(xbType,'getName',xbid)
if xianbaoModel:CheckDianfengXianbao(xbid)then
local dflevel=DianFengLevelModel:getLevel()
name=FMT.fmt("{0}+{1}",name,dflevel)
self.typename:setLocalPosY(-18)
self.fight:setLocalPosY(-45)
end
self.name:setText(name)

local tname_str2=_descFun('类型：','仙宝')
self.typename:setText(tname_str2)

local fightnum=xianbaoConfig.getTypeFuncResult(xbType,'getBaseFight',xbid)
self.fight:setText(_descFun("战力：",fightnum))

local isSpe=false
self.sign:setActive(isSpe)

local UpFlag=xianbaoConfig.getTypeFuncResult(xbType,'checkCanUpStar',xbid)
self.starGrid:setActive(UpFlag)
if UpFlag then
local starlv=xianbaoModel:checkActive(xbid)and xianbaoModel:getXbStart(xbid)or(self.attach.starlv or 0)
if self.formType==TIPS_FORM_TYPE.eXianBaoBag or self.formType==TIPS_FORM_TYPE.eXianBaoMaterial then
starlv=self.attach.starlv or 0
end
local maxStar=xianbaoConfig.getXBMaxStar(xbid)
self.starGrid:setChildLayoutGroupCreateItems(maxStar,function(index)
local starWidget=self.starGrid:getChildLayoutGroupGridItem(index-1)
starWidget:SetChildActive(0,index<=starlv)
end)
end
end



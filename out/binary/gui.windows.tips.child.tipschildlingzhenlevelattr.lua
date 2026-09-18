







def_class("tipsChildLingZhenLevelAttr",UICloneObject)





tipsChildLingZhenLevelAttr.abName="ui/windows/tips/child/tipschildlingzhenlevelattr.ab"

tipsChildLingZhenLevelAttr.assetName="tipsChildLingZhenLevelAttr"


function tipsChildLingZhenLevelAttr:bindComponents()

self.scrollview=UIObject.get(self,0)
self.questionBtn=UIButton.get(self,1)
self.title=UIText.get(self,2)

self.questionBtn:setButtonClick(function()self:onQuestionBtn()end)

end


function tipsChildLingZhenLevelAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.questionBtn);self.questionBtn=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildLingZhenLevelAttr:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0,true,nil,nil)
end


function tipsChildLingZhenLevelAttr:__delete()
self:unbindComponents()
end




function tipsChildLingZhenLevelAttr:onShow(argtable,afterOnloaded)
local argData=argtable.argtable
local itemid=argData.itemid
local itemguid=argData.itemguid
local attach=argData.attach

local yfguid=attach.yfguid
local kongIndex=attach.kongIndex

local cfg=itemsConfig.getConfig(itemid)

if cfg.type1~=6 then
self:recycleSelf()
return
end

self.title:setText('等级属性')
local isEquiped=false
local level=UIYuFuLingZhenControl:getItemLevel(itemid)
local itemData=lingzhenBagModel:getItem(itemguid)
if not itemData then
itemData=UIYuFuLingZhenControl:getXianQianData(yfguid,kongIndex)
isEquiped=true
end

if itemData then
local randAttrIdList=nil
if isEquiped then
randAttrIdList=itemData.randAttrIdList
else
randAttrIdList=itemData.itemData.randAttrIdList
end

table.sort(randAttrIdList,function(a,b)
local xcLevelA=cfgHelper.get(cfg_yufuzhenturandattrconfig_get,a,"xcLevel")or 0
local xcLevelB=cfgHelper.get(cfg_yufuzhenturandattrconfig_get,b,"xcLevel")or 0
return xcLevelA<xcLevelB
end)
self.scrollview:setChildLayoutGroupCreateItems(#randAttrIdList)
local grids=self.scrollview:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local str=''
local attrId=randAttrIdList[i]

local attrCfg=cfgHelper.get1(cfg_yufuzhenturandattrconfig_get,attrId)
local attrs=attrCfg.attr or{}
local diziAttrs=UIYuFuLingZhenControl:getDzAttrDesc(attrCfg)
local unlockLv=attrCfg.xcLevel or 1













if diziAttrs then
str=FMT.fmt('{0}{1}',str,diziAttrs)
end

if str==''then
item:SetChildActive(-1,false)
else
item:SetChildActive(2,false)
item:SetChildActive(0,true)
item:SetChildText(0,str)
item:SetChildGray(0,unlockLv>level)
item:SetChildText(1,FMT.fmt(' {0}级：',unlockLv))
item:SetChildGray(1,unlockLv>level)
local color=Color.StrToColor(unlockLv>level and FONT_COLOR_VAL[FONT_COLOR.eGrayColor]or FONT_COLOR_VAL[FONT_COLOR.eWhiteColor])
item:SetChildColor(0,color)
item:SetChildColor(1,color)
end
end
self.questionBtn:setActive(false)
else
local attrCfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"randomattrpreview")
self.scrollview:setChildLayoutGroupCreateItems(#attrCfg)
local grids=self.scrollview:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local attr=attrCfg[i]
item:SetChildActive(0,false)
item:SetChildActive(2,true)
item:SetChildText(3,attr)
item:SetChildText(1,'')
end
self.questionBtn:setActive(true)
end
end


function tipsChildLingZhenLevelAttr:onHide()

end

function tipsChildLingZhenLevelAttr:onQuestionBtn()
local args={}
args.titleName='等级属性'
args.pos=4
args.showBG=false
args.showClose=false
args.extraWin='UILingZhenLevelAttrDetailWin'
UIManager:showWindow('UICommonPageWin',args)
end


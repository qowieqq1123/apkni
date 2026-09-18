







def_class("UILZGMTipsWin",UIWindowBase)









function UILZGMTipsWin:bindComponents()

self.blackImg=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.ScrollView=UIObject.get(self,2)
self.skilDesc=UIObject.get(self,3)
self.title1=UIObject.get(self,4)
self.skillitem=UIObject.get(self,5)
self.tipsbtn=UIButton.get(self,6)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)



end


function UILZGMTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.skilDesc);self.skilDesc=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.skillitem);self.skillitem=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
end

















local _this
local itemheight=30
local exheight=15
local guididx=
{
titletxt=0,
gou=1,
cha=2,
bline=3,
gline=4
}
local skillidx=
{
skillitem=0,
skilltitle=1,
skillname=2,
skillicon=3,
skilldesc=4
}
local abName="ui/windows/yufulingzhen/yufulingzhen_atlas_pak.ab"



function UILZGMTipsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UILZGMTipsWin:__delete()
self:unbindComponents()
_this=nil
end




function UILZGMTipsWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.3,nil)
self.skillitem:setChildCanvasGroupAlpha(0)
self.skillitem:setChildCanvasGroupDOFade(1,0.3,nil)
if argtable then
self.cur=argtable[1]
self.max=argtable[2]
self.level=argtable[3]
self.lzData=argtable[4]
local cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,self.lzData.zhentuId)
local clientone=cfg.lzgmjhAttr2
local gmdjdata=cfg.lzgmdjAttr2
local skillcfg=cfg.lzgmSkill2

local showLen=#gmdjdata+1

self.skilDesc:setChildLayoutGroupCreateItems(showLen,function(index)
local item=self.skilDesc:getChildLayoutGroupGridItem(index-1)
if index==1 then
local tlecolor="#F1CE78"
local deecolor="#aae252"
if self.cur<self.max then
tlecolor="#8e8c87"
deecolor="#8e8c87"
item:SetChildActive(guididx.cha,true)
else
item:SetChildActive(guididx.gou,true)
local dj=gmdjdata[1][1]
if dj<=self.level then
item:SetChildActive(guididx.gline,true)
end
end
local titlestr=FMT.fmt("<color={0}>激活共鸣属性({1}/{2})</color>",tlecolor,self.cur,self.max)
item:SetChildText(guididx.titletxt,titlestr)

item:SetChildActive(guididx.bline,true)
item:SetChildSizeDelta(guididx.bline,14,#clientone*itemheight+exheight)
item:SetChildSizeDelta(guididx.gline,8,#clientone*itemheight+exheight)

local jhnum=#clientone
item:SetChildLayoutGroupCreateItems(5,jhnum,function(Index)
local deItem=item:GetChildLayoutGroupGridItem(5,Index-1)
deItem:SetChildText(0,FMT.fmt('<color={0}>{1}</color>',deecolor,clientone[Index]))
end)
else

local dj=gmdjdata[index-1][1]
local djjcdata=gmdjdata[index-1][2]
local djjcnum=math.ceil(#djjcdata/2)
local _idx=0
local jdtlecolor="#F1CE78"
if dj<=self.level and self.cur>=self.max then
item:SetChildActive(guididx.gou,true)
if gmdjdata[index]and gmdjdata[index][1]<=self.level then
item:SetChildActive(guididx.gline,true)
end
else
jdtlecolor="#8e8c87"
item:SetChildActive(guididx.cha,true)
end
local jdtitlestr=FMT.fmt("<color={0}>普通灵阵总等级达到{1}级 ({2}/{3})</color>",jdtlecolor,dj,self.level,dj)
item:SetChildText(guididx.titletxt,jdtitlestr)
if index<#gmdjdata+1 then
item:SetChildActive(guididx.bline,true)
item:SetChildSizeDelta(guididx.bline,14,djjcnum*itemheight+exheight)
item:SetChildSizeDelta(guididx.gline,8,djjcnum*itemheight+exheight)
end
item:SetChildLayoutGroupCreateItems(5,djjcnum,function(Index)
local jcItem=item:GetChildLayoutGroupGridItem(5,Index-1)
for k=1,2 do
_idx=_idx+1
if djjcdata[_idx]then
local name,valStr=equipsHelper.getAttr(djjcdata[_idx][1],djjcdata[_idx][2])
local djarrstr=FMT.fmt('{0} <color=#aae252>{1}</color>',name,valStr)
if dj>self.level or self.cur<self.max then
djarrstr=FMT.fmt('<color=#8e8c87>{0} {1}</color>',name,valStr)
end
jcItem:SetChildText(k-1,djarrstr)
end
end
end)
end
end)


local skillwidget=self.skillitem:getWidgetBase()
local maxlevel=gmdjdata[#gmdjdata][1]
local sstr=FMT.fmt("激活灵阵共鸣全部属性即可解锁 ({0}/{1})",self.level,maxlevel)
skillwidget:SetChildText(skillidx.skilltitle,sstr)
local sname=FMT.fmt("{0} <color=#aae252>(已激活)</color>",skillcfg[1])
if self.cur<self.max or self.level<maxlevel then
sname=FMT.fmt("{0} <color=#8e8c87>(未激活)</color>",skillcfg[1])
end
skillwidget:SetChildText(skillidx.skillname,sname)
skillwidget:SetChildText(skillidx.skilldesc,skillcfg[3])
skillwidget:SetChildCSImageSprite(skillidx.skillicon,abName,"icon_skill_67056")
end
end


function UILZGMTipsWin:onHide()

end


function UILZGMTipsWin:onTipsbtn()
local d={}
d.title='规则说明'
d.mode=3
d.name='UILZGMTipsWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleTenWin',d)
end









def_class("tipsChildGuBaoSuit",UICloneObject)





tipsChildGuBaoSuit.abName="ui/windows/tips/child/tipschildgubaosuit.ab"

tipsChildGuBaoSuit.assetName="tipsChildGuBaoSuit"


function tipsChildGuBaoSuit:bindComponents()

self.desRoot=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.extraRoot1=UIObject.get(self,2)
self.extraRoot2=UIObject.get(self,3)
self.extraRoot3=UIObject.get(self,4)
self.extraRoot4=UIObject.get(self,5)
self.extra1=UIText.get(self,6)
self.extra2=UIText.get(self,7)
self.extra3=UIText.get(self,8)
self.extra4=UIText.get(self,9)

end


function tipsChildGuBaoSuit:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desRoot);self.desRoot=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.extraRoot1);self.extraRoot1=nil;
_UIObject_release(self.extraRoot2);self.extraRoot2=nil;
_UIObject_release(self.extraRoot3);self.extraRoot3=nil;
_UIObject_release(self.extraRoot4);self.extraRoot4=nil;
_UIObject_release(self.extra1);self.extra1=nil;
_UIObject_release(self.extra2);self.extra2=nil;
_UIObject_release(self.extra3);self.extra3=nil;
_UIObject_release(self.extra4);self.extra4=nil;
end







function tipsChildGuBaoSuit:onLoaded(...)
self:bindComponents()
end


function tipsChildGuBaoSuit:__delete()
self:unbindComponents()
end


function tipsChildGuBaoSuit:onHide()

end

function tipsChildGuBaoSuit:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local gbid
if data.tipsType==TIPS_TYPE.eCommonGubao then
gbid=data.itemid
else
gbid=gubaoLookup:good2GuBao(data.itemid)
end
local attach=data.attach
local guanlian_id=data.guanlian_id

local suitlist=gubaoLookup:getSuitList(gbid)
if guanlian_id then
local glid,main=liandonModel:CheckGB_Guanlian(gbid)
if main==2 then

suitlist=gubaoLookup:getSuitList(glid)
else
suitlist=gubaoLookup:getSuitList(gbid)
end
end

if suitlist~=nil and suitlist[1]then
local suitid=suitlist[1]
self.widget:SetChildActive(2,true)
self.title:setText('套装效果')
local suitcfg=cfgHelper.get(cfg_gubaosuitconfig_get,suitid)
local list=suitcfg.list
local temp={}
local num=0
local str=''
local firstFMT='{0}'
local spaceFMT=' {0}'
local nextFMT='\n{0}'
for i,v in ipairs(list)do
local name=cfgHelper.get2(cfg_gubaoconfig_get,v,'name')
num=num+1
local isFrist=str==''
local nextline=num>3
if nextline then num=1 end

local activeflag=gubaoModel:checkActive(v)
local glid,main=liandonModel:CheckGB_Guanlian(v)
if glid and not activeflag then
activeflag=gubaoModel:checkActive(glid)
if activeflag then

name=cfgHelper.get2(cfg_gubaoconfig_get,glid,'name')
end
end

local s=isFrist and FMT.fmt(firstFMT,name)or
nextline and FMT.fmt(nextFMT,name)or
FMT.fmt(spaceFMT,name)
s=activeflag and FMT.cfmt(FONT_COLOR.ePurpleActiveColor,'{0}',s)or
FMT.cfmt(FONT_COLOR.eGrayColor,'{0}',s)
str=FMT.fmt('{0}{1}',str,s)
end
temp[#temp+1]=str


if suitcfg.skill0 and suitcfg.skilldesc0 then
local title='[套装] '
local desc=gubaoModel:getEffectDesc(suitcfg.skill0,suitcfg.skilldesc0)
desc=gubaoModel:checkSuitActive1(suitid)and FMT.cfmt(FONT_COLOR.ePurpleActiveColor,'{0}{1}',title,desc)or
FMT.cfmt(FONT_COLOR.eGrayColor,'{0}{1}',title,desc)
temp[#temp+1]=desc
end


if next(suitcfg.skill3)and next(suitcfg.skilldesc3)then
local title='[3星套装] '
local desc=gubaoModel:getEffectDesc(suitcfg.skill3,suitcfg.skilldesc3)
desc=gubaoModel:checkSuitActive2(suitid)and FMT.cfmt(FONT_COLOR.ePurpleActiveColor,'{0}{1}',title,desc)or
FMT.cfmt(FONT_COLOR.eGrayColor,'{0}{1}',title,desc)
temp[#temp+1]=desc
end


if suitcfg.skill_1 and suitcfg.skilldesc_1 then
if next(suitcfg.skill_1)and next(suitcfg.skilldesc_1)then
local title='[觉醒套装] '
local desc=gubaoModel:getEffectDesc(suitcfg.skill_1,suitcfg.skilldesc_1)
desc=gubaoModel:checkSuitActive3(suitid)and FMT.cfmt(FONT_COLOR.ePurpleActiveColor,'{0}{1}',title,desc)or
FMT.cfmt(FONT_COLOR.eGrayColor,'{0}{1}',title,desc)
temp[#temp+1]=desc
end
end

for i=1,4 do
local rootCmpStr=FMT.fmt('extraRoot{0}',i)
local txtCmpStr=FMT.fmt('extra{0}',i)
local desc=temp[i]
self[rootCmpStr]:setActive(desc~=nil)
if desc then
self[txtCmpStr]:setText(desc)
end
end
else
self:recycleSelf()
end
end


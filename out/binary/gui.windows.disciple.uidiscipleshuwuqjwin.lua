







def_class("UIDiscipleShuWuQJWin",UIWindowBase)









function UIDiscipleShuWuQJWin:bindComponents()

self.root=UIObject.get(self,0)
self.skillScrollView=UIObject.get(self,1)
self.descSlot=UIObject.get(self,2)
self.tipsType=UIText.get(self,3)
self.tipsDesc=UIText.get(self,4)
self.pdImg=UIImage.get(self,5)
self.pdVal=UIText.get(self,6)



end


function UIDiscipleShuWuQJWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skillScrollView);self.skillScrollView=nil;
_UIObject_release(self.descSlot);self.descSlot=nil;
_UIObject_release(self.tipsType);self.tipsType=nil;
_UIObject_release(self.tipsDesc);self.tipsDesc=nil;
_UIObject_release(self.pdImg);self.pdImg=nil;
_UIObject_release(self.pdVal);self.pdVal=nil;
end



















function UIDiscipleShuWuQJWin:onLoaded(...)
self:bindComponents()

self.skillScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIDiscipleShuWuQJWin:__delete()
self:unbindComponents()
end




function UIDiscipleShuWuQJWin:onShow(argtable,afterOnloaded)
local config=argtable.config
self.dzData=argtable.dzData

local speItem=self.descSlot:getChildWidgetBase()
UIDiscipleModel.refreshSpecialityItem(speItem,config,nil)

self:setSkillList()
self:setPDInfo()
end


function UIDiscipleShuWuQJWin:onHide()

end

function UIDiscipleShuWuQJWin:setSkillList()
local cfg=UIDiscipleModel:getShuWuDZConfig(self.dzData.id)
local swList=self.dzData.swList or{0,0,0}
local len=#cfg.skill
self.skillScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.skillScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local skillId=cfg.skill[i]
local level=swList[i]
local isActive=level>0
local skillCfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,skillId,level)
local infoCfg=cfgHelper.get1(cfg_discipleshuwuskillinfoconfig_get,skillId)
local icon=iconHelper.getSkillIcon(infoCfg.icon)
item:SetChildIcon(0,icon,true)
item:SetChildText(1,FMT.fmt('【{0}】',infoCfg.name))
item:SetChildGraphicGray(-1,not isActive,true)
if isActive then
item:SetChildText(2,FMT.fmt('({0}级)',level))
local desc=UIDiscipleModel:getShuWuSkillDesc(skillCfg.bonus[1],self.dzData.id)
item:SetChildText(3,desc)
else
item:SetChildText(2,'(未激活)')
skillCfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,skillId,1)
local desc=UIDiscipleModel:getShuWuSkillDesc(skillCfg.bonus[1],self.dzData.id)
item:SetChildText(3,desc)
end
end
end

function UIDiscipleShuWuQJWin:setPDInfo()
local val,ptype=UIDiscipleModel:countShuWUDZSelfPDAddValue(self.dzData)
self.pdImg:setSprite(globalABLookup.shuwusprite,shuWuPDImage[ptype])
self.pdVal:setText(FMT.fmt('+{0}%',val))
end

function UIDiscipleShuWuQJWin:countSkillAddPDValue()
local cfg=UIDiscipleModel:getShuWuDZConfig(self.dzData.id)
local count=0
for i,v in ipairs(cfg.skill)do
local level=self.dzData.swList[i]
local isActive=level>0
if isActive then
local skillCfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,v,level)
for ii,vv in ipairs(skillCfg.bonus)do
count=count+self:getPDAddValue(vv,self.dzData.attrList)
end
end
end
return count
end

function UIDiscipleShuWuQJWin:getPDAddValue(args,attr6)
local htype=args[1]
local val
if htype==1 then
val=args[3]
elseif htype==2 then
val=args[3]
elseif htype==3 then
val=attr6[args[3]]*args[4]*0.01
elseif htype==4 then
val=0
elseif htype==5 then
val=0
end
return val
end




function UIDiscipleShuWuQJWin:onCloseClick()
self:closeSelf()
end
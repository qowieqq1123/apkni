







def_class("UIYunZhouZhenTuSkillWin",UIWindowBase)









function UIYunZhouZhenTuSkillWin:bindComponents()

self.root=UIObject.get(self,0)
self.scrollview=UIObject.get(self,1)
self.skilllist=UIObject.get(self,2)
self.btnClose=UIButton.get(self,3)
self.ztItem=UIObject.get(self,4)
self.ztItem1=UIObject.get(self,5)
self.ztItem2=UIObject.get(self,6)
self.ztItem3=UIObject.get(self,7)
self.ztItem4=UIObject.get(self,8)
self.ztItem5=UIObject.get(self,9)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIYunZhouZhenTuSkillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.skilllist);self.skilllist=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.ztItem);self.ztItem=nil;
_UIObject_release(self.ztItem1);self.ztItem1=nil;
_UIObject_release(self.ztItem2);self.ztItem2=nil;
_UIObject_release(self.ztItem3);self.ztItem3=nil;
_UIObject_release(self.ztItem4);self.ztItem4=nil;
_UIObject_release(self.ztItem5);self.ztItem5=nil;
end
















local abname='ui/windows/xianyungang/yunzhouzhentu_atlas_pak.ab'
local _this
local ztitemidx=
{
selfitem=0,
icon=1,
name=2,
btn=3,
select=4,
lock=5,
}
local skillitemidx=
{
selfitem=0,
bg=1,
icon=2,
name=3,
desc=4,
sbgone=5,
sbgtwo=6,
simgone=7,
simgtwo=8,
bg2=9,
lvl=10,
}



function UIYunZhouZhenTuSkillWin:onLoaded(...)
self:bindComponents()
_this=self
self.ztlist={self.ztItem,self.ztItem1,self.ztItem2,self.ztItem3,self.ztItem4,self.ztItem5}
self.selectZTid=1
end


function UIYunZhouZhenTuSkillWin:__delete()
self:unbindComponents()
_this=nil
UIManager:invokeUIMethod("UIYunZhouZhenTuMainWin","ShowEnableDrag")
end



function UIYunZhouZhenTuSkillWin:onZhenTuClick(ztid)
if self.selectZTid==ztid then
return
end
local old_idx=self.selectZTid
self.selectZTid=ztid

if old_idx>0 then
local old_item=self.ztlist[old_idx]:getWidgetBase()
if old_item then
old_item:SetChildActive(ztitemidx.select,false)
end
end
local item=self.ztlist[self.selectZTid]:getWidgetBase()
if item then
item:SetChildActive(ztitemidx.select,true)
end

self:freshZTSkillList()
end





function UIYunZhouZhenTuSkillWin:onShow(argtable,afterOnloaded)
if argtable then
self.selectZTid=argtable.ztid or 1
end
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)

self:freshZTList()
self:freshZTSkillList()
end


function UIYunZhouZhenTuSkillWin:onHide()

end

function UIYunZhouZhenTuSkillWin:onBtnClose()
self:closeSelf()
end


function UIYunZhouZhenTuSkillWin:freshZTList()
for ztid,v in ipairs(self.ztlist)do
local widget=v:getWidgetBase()
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(ztid)
local ztcfg=cfg_yunzhouzhentuconfig_get(ztid)
local ZhenTuMaxlvl=ztcfg.ZhenTuMaxlvl

local isActive=false
local level=0
local effectLevel=0
if yzztData then
isActive=true
level=yzztData.level
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
effectLevel=cfg.effectLevel
end


local str=ztcfg.name
widget:SetChildText(ztitemidx.name,str)


widget:SetChildCSImageSprite(ztitemidx.icon,abname,ztcfg.icon)
if isActive then
widget:SetChildActive(ztitemidx.lock,false)
widget:SetChildGray(ztitemidx.icon,false)
else
widget:SetChildActive(ztitemidx.lock,true)
widget:SetChildGray(ztitemidx.icon,true)
end


widget:SetChildActive(ztitemidx.select,self.selectZTid==ztid)


widget:SetChildButtonClick(ztitemidx.btn,function()
if _this==nil then return end
self:onZhenTuClick(ztid)
end)
end
end


function UIYunZhouZhenTuSkillWin:freshZTSkillList()

local ztcfg=cfg_yunzhouzhentuconfig_get(self.selectZTid)
local MaxSkilllvl=ztcfg.MaxSkilllvl
local len=#MaxSkilllvl

local yzztData=YunZhouZhenTuModel:getYZZTDataByID(self.selectZTid)
local isActive=false
local level=0
local effectLevel=0
if yzztData then
isActive=true
level=yzztData.level
local cfg=cfg_yunzhouzhentulevelconfig_get(self.selectZTid)[level]
effectLevel=cfg.effectLevel
end

self.skilllist:setChildLayoutGroupCreateItems(len,function(index)
local widget=self.skilllist:getChildLayoutGroupGridItem(index-1)


widget:SetChildCSImageSprite(skillitemidx.icon,abname,ztcfg.skillicon)


local skill_lvl=index
local descs=ztcfg.Upskilldesc
local parmdescs=ztcfg.Upskilldesc2
local desc=self:getSkillZTDesc(self.selectZTid,descs,parmdescs,skill_lvl)
widget:SetChildText(skillitemidx.desc,desc)



if effectLevel>=skill_lvl then
widget:SetChildCSImageSprite(skillitemidx.bg,abname,'image_yzzt_ck_6')
widget:SetChildCSImageSprite(skillitemidx.bg2,abname,'image_yzzt_ck_8')


local name=FMT.fmt('{0}  <color=#549327>{1}级</color>',ztcfg.skillname,skill_lvl)
widget:SetChildText(skillitemidx.name,name)
widget:SetChildGray(skillitemidx.icon,false)
else
widget:SetChildCSImageSprite(skillitemidx.bg,abname,'image_yzzt_ck_7')
widget:SetChildCSImageSprite(skillitemidx.bg2,abname,'image_yzzt_ck_9')


local name=FMT.fmt('<color=#65615f>{0}  {1}级</color>',ztcfg.skillname,skill_lvl)
widget:SetChildText(skillitemidx.name,name)
widget:SetChildText(skillitemidx.desc,FMT.fmt('<color=#65615f>{0}</color>',desc))
widget:SetChildGray(skillitemidx.icon,true)
end


widget:SetChildText(skillitemidx.lvl,FMT.fmt('{0}级',MaxSkilllvl[index]))


if index==len then
widget:SetChildActive(skillitemidx.sbgone,false)
widget:SetChildActive(skillitemidx.sbgtwo,false)
widget:SetChildLocalPosX(skillitemidx.bg,55)
else
local jdnum=0
local _now=MaxSkilllvl[index]or 0
if level>=_now then
local _next=MaxSkilllvl[index+1]or 0
if level>=_next then
jdnum=1
else
local cha1=_next-_now
local cha2=level-_now
jdnum=cha2/cha1

end
end

widget:SetChildIconFillAmount(skillitemidx.simgtwo,0)
widget:SetChildIconFillAmount(skillitemidx.simgone,0)
if(index%2)==0 then
widget:SetChildActive(skillitemidx.sbgone,false)
widget:SetChildActive(skillitemidx.sbgtwo,true)
widget:SetChildLocalPosX(skillitemidx.bg,55)
widget:SetChildIconFillAmount(skillitemidx.simgtwo,jdnum)
else
widget:SetChildActive(skillitemidx.sbgone,true)
widget:SetChildActive(skillitemidx.sbgtwo,false)
widget:SetChildLocalPosX(skillitemidx.bg,25)
widget:SetChildIconFillAmount(skillitemidx.simgone,jdnum)
end
end
end)

end

function UIYunZhouZhenTuSkillWin:getSkillZTDesc(ztid,descs,parmdescs,effectLevel)
local desc=''









desc=FMT.fmt(descs,unpack(parmdescs[effectLevel]))
return desc
end

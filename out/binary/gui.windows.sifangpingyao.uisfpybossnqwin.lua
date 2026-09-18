







def_class("UISFPYBossNQWin",UIWindowBase)









function UISFPYBossNQWin:bindComponents()

self.closebutton=UIButton.get(self,0)
self.ywicon=UIImage.get(self,1)
self.ywname=UIText.get(self,2)
self.jdSkillInfo=UIObject.get(self,3)
self.jdExpProgressbar=UIProgressBarAni.get(self,4)
self.jdr=UIText.get(self,5)
self.jul=UIText.get(self,6)
self.shuxingtxt=UIText.get(self,7)
self.shuxingtxt1=UIText.get(self,8)
self.shuxingtxt2=UIText.get(self,9)
self.shuxingtxt3=UIText.get(self,10)
self.txtpanel=UIObject.get(self,11)
self.modelbg=UIObject.get(self,12)
self.model=UIObject.get(self,13)
self.root=UIObject.get(self,14)
self.firemodel=UIObject.get(self,15)
self.topmodel=UIObject.get(self,16)

self.closebutton:setButtonClick(function()self:onClosebutton()end)



end


function UISFPYBossNQWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closebutton);self.closebutton=nil;
_UIObject_release(self.ywicon);self.ywicon=nil;
_UIObject_release(self.ywname);self.ywname=nil;
_UIObject_release(self.jdSkillInfo);self.jdSkillInfo=nil;
_UIObject_release(self.jdExpProgressbar);self.jdExpProgressbar=nil;
_UIObject_release(self.jdr);self.jdr=nil;
_UIObject_release(self.jul);self.jul=nil;
_UIObject_release(self.shuxingtxt);self.shuxingtxt=nil;
_UIObject_release(self.shuxingtxt1);self.shuxingtxt1=nil;
_UIObject_release(self.shuxingtxt2);self.shuxingtxt2=nil;
_UIObject_release(self.shuxingtxt3);self.shuxingtxt3=nil;
_UIObject_release(self.txtpanel);self.txtpanel=nil;
_UIObject_release(self.modelbg);self.modelbg=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.firemodel);self.firemodel=nil;
_UIObject_release(self.topmodel);self.topmodel=nil;
end
















local _this



function UISFPYBossNQWin:onLoaded(...)
self:bindComponents()
self.txtArry={self.shuxingtxt,self.shuxingtxt1,self.shuxingtxt2,self.shuxingtxt3}
_this=self
end


function UISFPYBossNQWin:__delete()
self:unbindComponents()
end




function UISFPYBossNQWin:onShow(argtable,afterOnloaded)


local demons_id=SiFangPingYaoModel:getMapIdex()

local ywzjcfg=cfg_foursideskilldemonschapterconfig_get(demons_id)[3]
local ygcfg=cfg_foursideskilldemonsconfig_get(demons_id)
local max_value=ygcfg.max_value
local ywbossid=ywzjcfg.bossid
local nuqizhi=SiFangPingYaoModel:getbossanger()

if nuqizhi>100 then
nuqizhi=100
end
if nuqizhi<-100 then
nuqizhi=-100
end

if argtable then
self.old=argtable.old
self.new=argtable.new
end




local actionid=5
if nuqizhi>0 then
actionid=5
elseif nuqizhi<0 then
actionid=2045
elseif nuqizhi==0 then
actionid=5
end

self.modelbg:setChildUIModelShowTarget(5435,1,{},2305,false,false,0,function()
self:delayDo(0.4,function()
self.root:setChildCanvasGroupDOFade(1,0.4)
end)
if nuqizhi~=0 then
self.topmodel:setChildUIModelShowTarget(5441,1,{},actionid,false,false,0,nil)
end
end)

local modelParams=comHelper.getMonsterGroupModelParams(ywbossid)
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,20)
self.model:setChildUIModelShowTarget(modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,0,nil)
self.model:setChildUIModelShowTargetOffset(scaleParam[2],scaleParam[3])

local mCfg=cfgHelper.get1(cfg_monstergroup_get,ywbossid)
self.ywname:setText(mCfg.name or"")

local qh=0
local nq=0
if nuqizhi>0 then
qh=nuqizhi
elseif nuqizhi<0 then
nq=-nuqizhi
end
self.jul:setText(FMT.fmt('怒气值: <color=#f36666>{0}</color>',nq))
self.jdr:setText(FMT.fmt('亲和值: <color=#aae252>{0}</color>',qh))


local all_value=max_value*2
nuqizhi=-nuqizhi
local curexp=max_value+nuqizhi
if-nuqizhi==max_value then
curexp=1
elseif nuqizhi==max_value then
curexp=199
end
self.jdExpProgressbar:animateFourParams(curexp,all_value,0,false)


local arry=nil
if qh>0 then
local affine_boss_attrs=ygcfg.affine_boss_attrs
for k,v in ipairs(affine_boss_attrs)do
if qh>=v[1]then
arry=v
end
end
end

if qh==0 and nq==0 then
local affine_boss_attrs=ygcfg.affine_boss_attrs
for k,v in ipairs(affine_boss_attrs)do
if qh>=v[1]then
arry=v
end
end
end

if nq>0 then
local angry_boss_attrs=ygcfg.angry_boss_attrs
for k,v in ipairs(angry_boss_attrs)do
if nq>=v[1]then
arry=v
end
end
end


if arry then
self.txtpanel:setActive(true)
local txtdata=arry[3]
for k,v in ipairs(self.txtArry)do
if txtdata[k]then
v:setActive(true)
v:setText(txtdata[k]or"")
else
v:setActive(false)
end
end
else
self.txtpanel:setActive(false)
end

self.firemodel:setChildUIModelShowTarget(5433,1,{},eAnimationID.stand,false,false,0.5)
local num=math.abs(nuqizhi)*3
local posx=0
if nuqizhi<0 then
posx=-(num-20)
elseif nuqizhi>0 then
posx=num+10
end
if posx<-259 then
posx=-259
end
if posx>259 then
posx=259
end

self.winlua:SetChildLocalPosX(self.firemodel:getID(),posx)
end


function UISFPYBossNQWin:onHide()

end


function UISFPYBossNQWin:testttt(actionid)
_this.modelbg:setChildUIModelShowTarget(5435,1,{},actionid,false,false,0)
end






function UISFPYBossNQWin:onClosebutton()
UIManager:closeWindow("UISFPYBossNQWin")
end


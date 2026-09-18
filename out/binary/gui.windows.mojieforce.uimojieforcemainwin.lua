







def_class("UIMoJieForceMainWin",UIWindowBase)









function UIMoJieForceMainWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.bgModel=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.titlebg=UIObject.get(self,4)
self.leftBtn=UIButton.get(self,5)
self.rightBtn=UIButton.get(self,6)
self.btnpanel=UIObject.get(self,7)
self.slitem=UIObject.get(self,8)
self.slitem2=UIObject.get(self,9)
self.slitem3=UIObject.get(self,10)
self.skillitem=UIObject.get(self,11)
self.jrbtn=UIButton.get(self,12)
self.tip=UIText.get(self,13)
self.changebtn=UIButton.get(self,14)
self.tipsbtn=UIButton.get(self,15)
self.tipbg=UIObject.get(self,16)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.jrbtn:setButtonClick(function()self:onJrbtn()end)

self.changebtn:setButtonClick(function()self:onChangebtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)



end


function UIMoJieForceMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titlebg);self.titlebg=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.btnpanel);self.btnpanel=nil;
_UIObject_release(self.slitem);self.slitem=nil;
_UIObject_release(self.slitem2);self.slitem2=nil;
_UIObject_release(self.slitem3);self.slitem3=nil;
_UIObject_release(self.skillitem);self.skillitem=nil;
_UIObject_release(self.jrbtn);self.jrbtn=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.changebtn);self.changebtn=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.tipbg);self.tipbg=nil;
end
















local _this
local abname='ui/windows/mojieforce/mojieforce_atlas_pak.ab'
local itemidx=
{
selfitem=0,
icon=1,
choose=2,
root=3,
yixuan=4,
}
local skillitemidx=
{
selfitem=0,
icon=1,
name=2,
desc=3,
skillbtn=4,
}
local forceColor=
{
[1]='6833c0',
[2]='549327',
[3]='ca631d',
}



function UIMoJieForceMainWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self.selectidx=1
self.selectforceid=0
self.yixuanid=0
self.slitems={self.slitem,self.slitem2,self.slitem3}
self.isgetbtn=false
self.sllist={}
end


function UIMoJieForceMainWin:__delete()
self:unbindComponents()
self.isgetbtnTimer=nil
_this=nil
end


function UIMoJieForceMainWin.onSeasonChange()







end

function UIMoJieForceMainWin:onLeftBtn()
end

function UIMoJieForceMainWin:onRightBtn()
end


function UIMoJieForceMainWin:onTipsbtn()
local d={}
d.title='规则'
d.mode=3
d.name='ui_UIMoJieForceMainWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIMoJieForceMainWin:onJrbtn()
local nowforce=xianjieController:getForce()
if nowforce==self.selectforceid then
return
end
local state=xianjieController:ForceState()
if state==MJForceState.firstchoose then

local cfg=cfg_devildomforceconfig_get(self.selectidx)
local _Chapteridx=xianjieController:getForceChapteridx()
local _chapteridx=self.chapteridx
local _fun=function()
local change=xianjieController:getForceChangetimes()
if nowforce>0 then
if _chapteridx and _Chapteridx~=_chapteridx then
change=0
end
end
change=change+1
xianjieController:send_35_222(self.selectforceid,change)
end
local change_force=self.selectforceid

local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt("是否确认加入<color=#{0}>【{1}】</color>势力\n（每章开始时可以更换1次势力）",forceColor[change_force],cfg.name),
oktext='确认',
canceltext='取消',
allowclickBG='false',
okcallback=_fun,
showclosebtn=true,
}
local comfirmDialog3=UIDialogManager.newDialog(showdata)
comfirmDialog3:show()
end
end

function UIMoJieForceMainWin:onChangebtn()
local nowforce=xianjieController:getForce()
if nowforce==self.selectforceid then
UIManager.info('您已是当前势力')
return
end
local state=xianjieController:ForceState()
if state==MJForceState.changeforce then
local cfg=cfg_devildomforceconfig_get(self.selectidx)
local _Chapteridx=xianjieController:getForceChapteridx()
local _chapteridx=self.chapteridx
local _fun=function()
local change=xianjieController:getForceChangetimes()
if nowforce>0 then
if _chapteridx and _Chapteridx~=_chapteridx then
change=0
end
end
change=change+1
xianjieController:send_35_222(self.selectforceid,change)
end

local old_force=nowforce
local change_force=self.selectforceid
local old_cfg=cfg_devildomforceconfig_get(old_force)

local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt("是否要从<color=#{0}>【{1}】</color>势力转为<color=#{2}>【{3}】</color>势力？\n（每章开始时可以更换1次势力）",forceColor[old_force],old_cfg.name,forceColor[change_force],cfg.name),
oktext='确认',
canceltext='取消',
allowclickBG='false',
okcallback=_fun,
showclosebtn=true,
}
local comfirmDialog3=UIDialogManager.newDialog(showdata)
comfirmDialog3:show()
end
end

function UIMoJieForceMainWin:onChooseItemClick(index)
if not self.isgetbtn then
if self.selectidx==index then
return
end
local oldidx=self.selectidx
self.selectidx=index
self.selectforceid=self.sllist[self.selectidx]

if self.slitems[oldidx]then
local oldwidget=self.slitems[oldidx]:getWidgetBase()
self:chooseAnmate(oldwidget,false,false)
end
if self.slitems[self.selectidx]then
local widget=self.slitems[self.selectidx]:getWidgetBase()
self:chooseAnmate(widget,true,false)
end
self:freshskill()
self.isgetbtn=true
end

if not self.isgetbtnTimer and self.isgetbtn==true then
self.isgetbtnTimer=self:delayDo(0.3,function()
if _this==nil then return end
self.isgetbtnTimer=nil
self.isgetbtn=false
end)
end
end

function UIMoJieForceMainWin:onItemSkillClick(skillcfg)
if skillcfg and skillcfg.ruleLangId then
local str=FMT.fmt('技能：{0}',skillcfg.name)
local d={}
d.title=str
d.mode=3
d.name=skillcfg.ruleLangId
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end
end





function UIMoJieForceMainWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(6261,1,nil,eAnimationID.enter)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
self.saijiid=xianjieController:getMoJieSaiJiID()
self.chapteridx=xianjieController:getMoJieSaiJiChapteridx()or 1
self.sllist=self:getlist()
self.selectforceid=self.sllist[self.selectidx]
self.handle=seasonModel:getHandleByType(eSeasonType.eMJMB)
local force=xianjieController:getForce()
if force>0 then
self.yixuanid=force
self.selectforceid=force
for k,v in ipairs(self.sllist)do
if force==v then
self.selectidx=k
end
end
end
self:freshlist()
self:freshskill()
self:freshbtnpanel()


local Chapteridx=userActorSetting.get('changeMJSLForceReddot',0)
local chapteridx=xianjieController:getMoJieSaiJiChapteridx()
if chapteridx and Chapteridx~=chapteridx then
userActorSetting.set('changeMJSLForceReddot',chapteridx)
userActorSetting.flush()

UIManager:invokeUIMethod("UIYuJingMainMJWin","freshMJSLForceReddot")
UIManager:invokeUIMethod("UIPengLaiMainMJWin","freshMJSLForceReddot")
UIManager:invokeUIMethod("UIJiuYuanMainMJWin","freshMJSLForceReddot")
end
end


function UIMoJieForceMainWin:onHide()

end

function UIMoJieForceMainWin:onClickMask()
self:onCloseClick()
end
function UIMoJieForceMainWin:onCloseBtn()
self:onCloseClick()
end

function UIMoJieForceMainWin:onCloseClick(atOnce)

_this:closeSelf()
end

function UIMoJieForceMainWin:serverfresh()
_this.yixuanid=xianjieController:getForce()
_this:freshbtnpanel()
_this:setChoosed()
end


function UIMoJieForceMainWin:getlist()
local list={}
local cfg=cfg_devildomforceconfig()
for k,v in ipairs(cfg)do
table.insert(list,v.id)
end
return list
end

function UIMoJieForceMainWin:chooseAnmate(widget,flag,init)
if init then
widget:SetChildActive(itemidx.choose,flag)
else

if flag then
widget:SetChildActive(itemidx.choose,true)
widget:SetChildDOScale(itemidx.root,1.05,0.2)
else
widget:SetChildActive(itemidx.choose,false)
widget:SetChildScale(itemidx.root,Vector3.New(1,1,1))
end
end
end

function UIMoJieForceMainWin:setChoosed()
local list=self.sllist
for k,v in ipairs(self.slitems)do
local widget=v:getWidgetBase()
local slid=list[k]
if slid then
local cfg=cfg_devildomforceconfig_get(slid)
if self.yixuanid==cfg.id then
widget:SetChildActive(itemidx.yixuan,true)
else
widget:SetChildActive(itemidx.yixuan,false)
end
end
end
end

function UIMoJieForceMainWin:freshlist()
local list=self.sllist
for k,v in ipairs(self.slitems)do
local widget=v:getWidgetBase()
local slid=list[k]
if slid then
widget:SetChildActive(itemidx.selfitem,true)
local cfg=cfg_devildomforceconfig_get(slid)

widget:SetChildCSImageSprite(itemidx.icon,abname,cfg.icon)

if self.selectidx==k then
self:chooseAnmate(widget,true,true)
else
self:chooseAnmate(widget,false,true)
end

if self.yixuanid==cfg.id then
widget:SetChildActive(itemidx.yixuan,true)
else
widget:SetChildActive(itemidx.yixuan,false)
end

widget:SetChildButtonClick(itemidx.icon,function()
if _this==nil then return end
self:onChooseItemClick(k)
end)
else
widget:SetChildActive(itemidx.selfitem,false)
end
end
end

function UIMoJieForceMainWin:freshskill()
local skillwidget=self.skillitem:getWidgetBase()
local forceid=self.selectforceid
local idx=xianjieController:getForceCfg()
if forceid==nil then
self.skillitem:setActive(false)
return
end
if idx==nil then
self.skillitem:setActive(false)
logErr(FMT.fmt('获取技能势力配置为nil,查看魔界赛季配置表,赛季id={0}',self.saijiid))
return
end
local skillcfg=xianjieController:getForceSkillCfg(forceid,idx)



local iconName=iconHelper.getSkillIcon(skillcfg.skillicon)
skillwidget:SetChildCSImageIcon(skillitemidx.icon,iconName,false)
skillwidget:SetChildText(skillitemidx.name,skillcfg.name)
local desc=self:checklengthover(skillcfg.skilldesc,33)
skillwidget:SetChildText(skillitemidx.desc,desc)


if skillcfg.ruleLangId then
skillwidget:SetChildActive(skillitemidx.skillbtn,true)
skillwidget:SetChildButtonClick(skillitemidx.skillbtn,function()
if _this==nil then return end
self:onItemSkillClick(skillcfg)
end)
else
skillwidget:SetChildActive(skillitemidx.skillbtn,false)
end
end

function UIMoJieForceMainWin:freshbtnpanel()
local state=xianjieController:ForceState()
if state==MJForceState.firstchoose then
self.jrbtn:setActive(true)
self.changebtn:setActive(false)
self.tipbg:setActive(false)

elseif state==MJForceState.changeforce then
self.jrbtn:setActive(false)
self.changebtn:setActive(true)
self.tipbg:setActive(false)

elseif state==MJForceState.nochoose then
self.jrbtn:setActive(false)
self.changebtn:setActive(false)
self.tipbg:setActive(true)

local _chapteridx=self.chapteridx
local stageCfgs=self.handle:getConfig("chapter_list")
if _chapteridx>=#stageCfgs then
local num_str='最终阶段无法变更势力'
self.tip:setText(num_str)
else
local nextidx=_chapteridx+1
local num_str=FMT.fmt('第{0}阶段才可重新选择势力',mathHelper.numberToChinese(nextidx))
self.tip:setText(num_str)
end
end
end


function UIMoJieForceMainWin:checklengthover(str,limitnum)
if not str then return''end
if limitnum==33 then
local c=string.toTable(str)
local newstr=''
if c and#c>=limitnum then
newstr=string.format("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s...",c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12],c[13],c[14],c[15],c[16],c[17],c[18],c[19],c[20],c[21],c[22],c[23],c[24],c[25],c[26],c[27],c[28],c[29],c[30],c[31],c[32],c[33])
return newstr or str
else
return str
end
end
return str
end
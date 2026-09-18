







def_class("UIMoJieForceSkillWin",UIWindowBase)









function UIMoJieForceSkillWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.bgModel=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.titleName=UIObject.get(self,4)
self.lskillitem=UIObject.get(self,5)
self.rskillitem=UIObject.get(self,6)
self.skilldesc=UIText.get(self,7)
self.costitem=UIObject.get(self,8)
self.upbtn=UIButton.get(self,9)
self.costtxt=UIText.get(self,10)
self.costicon=UIObject.get(self,11)
self.costpanel=UIObject.get(self,12)
self.mjtxt=UIText.get(self,13)
self.arrow=UIObject.get(self,14)
self.ltxt=UIText.get(self,15)
self.rtxt=UIText.get(self,16)
self.ctxt=UIText.get(self,17)
self.upimg=UIObject.get(self,18)
self.skilleffect=UIObject.get(self,19)
self.skilldesc2=UIText.get(self,20)
self.upimg2=UIObject.get(self,21)
self.skilldesc3=UIText.get(self,22)
self.upimg3=UIObject.get(self,23)
self.upreddot=UIObject.get(self,24)
self.rulebtn=UIButton.get(self,25)
self.expanel=UIObject.get(self,26)
self.extxt=UIText.get(self,27)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.upbtn:setButtonClick(function()self:onUpbtn()end)

self.rulebtn:setButtonClick(function()self:onRulebtn()end)



end


function UIMoJieForceSkillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.lskillitem);self.lskillitem=nil;
_UIObject_release(self.rskillitem);self.rskillitem=nil;
_UIObject_release(self.skilldesc);self.skilldesc=nil;
_UIObject_release(self.costitem);self.costitem=nil;
_UIObject_release(self.upbtn);self.upbtn=nil;
_UIObject_release(self.costtxt);self.costtxt=nil;
_UIObject_release(self.costicon);self.costicon=nil;
_UIObject_release(self.costpanel);self.costpanel=nil;
_UIObject_release(self.mjtxt);self.mjtxt=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.ltxt);self.ltxt=nil;
_UIObject_release(self.rtxt);self.rtxt=nil;
_UIObject_release(self.ctxt);self.ctxt=nil;
_UIObject_release(self.upimg);self.upimg=nil;
_UIObject_release(self.skilleffect);self.skilleffect=nil;
_UIObject_release(self.skilldesc2);self.skilldesc2=nil;
_UIObject_release(self.upimg2);self.upimg2=nil;
_UIObject_release(self.skilldesc3);self.skilldesc3=nil;
_UIObject_release(self.upimg3);self.upimg3=nil;
_UIObject_release(self.upreddot);self.upreddot=nil;
_UIObject_release(self.rulebtn);self.rulebtn=nil;
_UIObject_release(self.expanel);self.expanel=nil;
_UIObject_release(self.extxt);self.extxt=nil;
end
















local _this
local abname='ui/windows/mojieforce/mojieforce_atlas_pak.ab'
local skillitemidx=
{
selfitem=0,
icon=1,
name=2,
}



function UIMoJieForceSkillWin:onLoaded(...)
self:bindComponents()
_this=self
self.skillitems={self.skilldesc,self.skilldesc2,self.skilldesc3}
self.skillupimgs={self.upimg,self.upimg2,self.upimg3}
end


function UIMoJieForceSkillWin:__delete()
self:unbindComponents()
_this=nil
end

function UIMoJieForceSkillWin:onRulebtn()
local args={
ruleGroupID=ruleTipsImageGroup.eMoJieForceSkill,
}
self:showWindow("UIRuleTipsImage2Win",args)
end


function UIMoJieForceSkillWin:onUpbtn()
if self.cost and self.r_skill_data then
for k,v in ipairs(self.cost)do
local costdata=v
local itemid=costdata[1]
local itemnum=costdata[2]
local bagnum=0
if moneyConfig.isMoney(itemid)then
bagnum=moneyModel.getMoney(itemid)
else
bagnum=bagModel.getItemCountById(itemid)
end
if bagnum<itemnum then
gainControl:showGainWin(itemid)
return
end
end

if self.l_skill_data then
local exCondition=self.l_skill_data[4]
if exCondition and exCondition[1]then
local MoneyType=exCondition[1][2]
local Moneycost=exCondition[1][3]
local hasCount=0

local MoneyList=xianjieController:getForceMoneyList()
if MoneyList then
for k,v in ipairs(MoneyList)do
if v.param_1 and v.param_1==MoneyType then
hasCount=v.param_2 and mathHelper.int64_to_number(v.param_2)or 0
end
end
end
if hasCount<Moneycost then
gainControl:showGainWin(MoneyType)
return
end
end
end

xianjieController:send_35_223()


















end
end





function UIMoJieForceSkillWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(6258,1,nil,eAnimationID.enter)
self:delayDo(0.8,function()
if _this==nil then return end
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
end)
self.saijiid=xianjieController:getMoJieSaiJiID()
self.chapteridx=xianjieController:getMoJieSaiJiChapteridx()or 1
self.forceid=xianjieController:getForce()
self.Skillidx,self.Taskidx=xianjieController:getForceCfg()
if self.forceid==nil then
self.forceid=1
self.upbtn:setActive(false)
end
if self.Skillidx==nil then
self.Skillidx=1
self.upbtn:setActive(false)
logErr(FMT.fmt('获取势力配置为nil,查看魔界赛季配置表的force字段,赛季id={0}',self.saijiid))
end
if self.forceid==0 then
self.forceid=1
self.upbtn:setActive(false)
logErr(FMT.fmt('获取势力为0，还未选择势力，不应打开技能界面,赛季id={0}',self.saijiid))
end
self:freshpanel()

if self.cost then
local money={}
for k,v in ipairs(self.cost)do
money[#money+1]={v[1]}
end
self:showWindow("UITopMoneyWin2",{moneys=money,offsetX=0,offsetY=-25})
end

if argtable and argtable.showtips then
self:delayDo(0.8,function()
if _this==nil then return end
self:onRulebtn()
end)
end
end


function UIMoJieForceSkillWin:onHide()

end
function UIMoJieForceSkillWin:onClickMask()
self:onCloseClick()
end
function UIMoJieForceSkillWin:onCloseBtn()
self:onCloseClick()
end

function UIMoJieForceSkillWin:onCloseClick(atOnce)

self:closeSelf()
end

function UIMoJieForceSkillWin:serverfresh()
_this:freshpanel()
_this:onShowEffect()
end

function UIMoJieForceSkillWin:freshpanel()
local forceid=self.forceid
local Skillidx=self.Skillidx

local skillcfg=xianjieController:getForceSkillCfg(forceid,Skillidx)
local skilldata=skillcfg.skill
local lvl=xianjieController:getForceSkilllv()
local l_skill_data=skilldata[lvl]
local r_skill_data=skilldata[lvl+1]


local cost
if l_skill_data then
cost=l_skill_data[1]
end
local nextlvl=lvl
if r_skill_data then
nextlvl=lvl+1
end


self.cost=cost
self.r_skill_data=r_skill_data
self.l_skill_data=l_skill_data


local lskillitem=self.lskillitem:getWidgetBase()
lskillitem:SetChildText(skillitemidx.name,skillcfg.name)
local iconName=iconHelper.getSkillIcon(skillcfg.skillicon)
lskillitem:SetChildCSImageIcon(skillitemidx.icon,iconName,false)


if r_skill_data then
self.arrow:setActive(true)
self.ltxt:setText(FMT.fmt("{0}级",lvl))
self.rtxt:setText(FMT.fmt("{0}级",nextlvl))
self.ctxt:setText('')
else
self.arrow:setActive(false)
self.ctxt:setText(FMT.fmt("{0}级",lvl))
end




































local descs=skillcfg.Upskilldesc
local parmdescs=skillcfg.Upskilldesc2
local desc=''
xpcall(function()
desc=FMT.fmt(descs,unpack(parmdescs[lvl]))
end,function(err)
logErr(FMT.fmt('技能描述参数报错,当前技能等级{0}',lvl))
end)
self.skilldesc:setText(desc)


if r_skill_data then
self.mjtxt:setActive(false)
self.costpanel:setActive(true)
self.upbtn:setActive(true)
self.expanel:setActive(false)
self:refreshXMBtn(l_skill_data,r_skill_data,cost)


if l_skill_data then
local exCondition=l_skill_data[4]
if exCondition and exCondition[1]then
local MoneyType=exCondition[1][2]
local Moneycost=exCondition[1][3]
local hasCount=0

local MoneyList=xianjieController:getForceMoneyList()
if MoneyList then
for k,v in ipairs(MoneyList)do
if v.param_1 and v.param_1==MoneyType then
hasCount=v.param_2 and mathHelper.int64_to_number(v.param_2)or 0
end
end
end

local MoneyName=moneyModel.getMoneyName(MoneyType)
local exstr=''
if hasCount>=Moneycost then

self.expanel:setActive(false)
self.upbtn:setActive(true)
else
exstr=FMT.fmt('{0}达到<color=#c82c2c>（{1}/{2}）</color>',MoneyName,hasCount,Moneycost)
self.expanel:setActive(true)
self.extxt:setText(exstr)
self.upbtn:setActive(false)
end
end
end
else
self.mjtxt:setActive(true)
self.costpanel:setActive(false)
self.upbtn:setActive(false)
self.expanel:setActive(false)
end

end

function UIMoJieForceSkillWin:refreshXMBtn(l_skill_data,r_skill_data,cost)

if r_skill_data and cost then

local isup=true
local isup2=true

























self.costtxt:setActive(false)

if cost then
local costWidget=self.costitem:getWidgetBase()
for k,v in ipairs(cost)do
costWidget:SetChildActive(k-1,true)
local costdata=v
local itemid=costdata[1]
local itemnum=costdata[2]
local havecount=0
local itemcount=""
local graynum=0
if moneyConfig.isMoney(itemid)then
havecount=moneyModel.getMoney(itemid)
else
havecount=bagModel.getItemCountById(itemid)
end
if havecount>=itemnum then

itemcount=FMT.fmt('{0}',mathHelper.formatNumber9(itemnum,1))
else

itemcount=FMT.fmt('<color=#f36666>{0}</color>',mathHelper.formatNumber9(itemnum,1))
graynum=0
isup2=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=true,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
costWidget:SetChildPropData(k-1,prop)
costWidget:SetBaseItemClickEvent(k-1,function(...)
if _this==nil then return end
self:onClickItem(...)
end)
end
end

self.upreddot:setActive(isup and isup2)
end
end

function UIMoJieForceSkillWin:onShowEffect()
_this.skilleffect:setChildShowEffect(10060,true)
end

function UIMoJieForceSkillWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end


function UIMoJieForceSkillWin:testtt1()
_this.bgModel:setChildUIModelShowTarget(6097,1,nil,eAnimationID.stand)
end


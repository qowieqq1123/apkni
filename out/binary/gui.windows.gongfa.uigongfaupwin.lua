







def_class("UIGongFaUpWin",UIWindowBase)









function UIGongFaUpWin:bindComponents()

self.titleText=UIText.get(self,0)
self.descText=UIText.get(self,1)
self.costText=UIText.get(self,2)
self.costNumText=UIText.get(self,3)
self.costIcon=UIImage.get(self,4)
self.okButtonIcon=UIObject.get(self,5)
self.tipsObj=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.okReddot=UIObject.get(self,8)



end


function UIGongFaUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.costText);self.costText=nil;
_UIObject_release(self.costNumText);self.costNumText=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.okButtonIcon);self.okButtonIcon=nil;
_UIObject_release(self.tipsObj);self.tipsObj=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.okReddot);self.okReddot=nil;
end
















local _this=nil


function UIGongFaUpWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)

self.on_money_changed=function(mtype,last,curr)
if mtype==eMoneyType.mtChuanDao then
self:refreshView()
end
end

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIGongFaUpWin:__delete()
self:unbindComponents()
_this=nil
self:clearDalayTimer()
UIManager:closeWindow('UITopMoneyHighWin')

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIGongFaUpWin:onHide()

end




function UIGongFaUpWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.gfID=argtable.gfID

self.discipleGFNetData=UIDiscipleModel:getDiscipleGFData(self.disciple_guid,self.gfID)
self:refreshView()
self:initSkilllv()

self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.5,nil)
local moneytypes={{eMoneyType.mtChuanDao},}
UIManager:showWindow('UITopMoneyHighWin',moneytypes)
end

function UIGongFaUpWin:refreshView()
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)

self.titleText:setText(cfgHelper.getlang('cangjingge_uptips_1'))

self.descText:setText(cfgHelper.getlang('cangjingge_uptips_2'))

self.costText:setText(cfgHelper.getlang('cangjingge_uptips_3'))
local gfLv=self.discipleGFNetData.param_2
local gfMaxLv=UIGongFaModel:getGFMaxLevel(self.gfID)
self.isFull=false
if gfLv>=gfMaxLv then
self.isFull=true
end
local curExp=self.discipleGFNetData.param_3
local maxExp=UIGongFaModel:getUpGFExp(self.gfID,gfLv)
if maxExp==nil then
curExp=1
maxExp=1
end
self.needmoney=maxExp-curExp
if self.needmoney<0 then self.needmoney=0 end
if self.needmoney>0 then
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
self.needmoney_discount=UIGongFaModel:getUpGFExpDiscount(netData,self.gfID,self.needmoney)
else
self.needmoney_discount=0
end
local money_str=''
self.canup=moneyModel.checkEnoughMoney(eMoneyType.mtChuanDao,self.needmoney_discount)
if self.isFull then
money_str='已满'
elseif self.canup then
money_str=tostring(self.needmoney_discount)
else
money_str=FMT.fmt('<color=#c82c2c>{0}</color>',self.needmoney_discount)
end
self.costNumText:setText(money_str)
self.costIcon:setImageIcon(moneyModel.getIconNameEx(eMoneyType.mtChuanDao),true)

self.okButtonIcon:setGray(self.isFull or not self.canup)

self.okReddot:setActive(not self.isFull and self.canup)
end


function UIGongFaUpWin:onOkButton()
if self.isFull then

UIManager.error(cfgHelper.getlang('cangjingge_uptips_4'))
return
end

if not self.canup then
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(eMoneyType.mtChuanDao)))
gainControl:showGainWin(eMoneyType.mtChuanDao)
return
end

UIDiscipleController:requireDiscipleUpGFExp(self.disciple_guid,self.gfID,self.needmoney)
end

function UIGongFaUpWin:onBackClick()


self:closeSelf()
end

function UIGongFaUpWin:onRuleClick()
local d={}
d.title='功法升级介绍'
d.mode=3
d.name='cangjingge_rule_%d'
d.closeCB=function()
if _this==nil then return end
end
UIManager:showWindow('UIRuleWin',d)
end

function UIGongFaUpWin:rec_upGF(gfID,oldlv,newlv)
if gfID==self.gfID then
self:refreshView()
self:showTips(newlv)
self:showGfUpTips(oldlv,newlv)
self:initSkilllv()
end
end





function UIGongFaUpWin:initSkilllv()
local gfLv=UIDiscipleModel:getDiscipleGFLevel(self.disciple_guid,self.gfID)
self.skilldatas=self:getSkillData(self.gfID,gfLv)
end

function UIGongFaUpWin:getSkillData(gfID,gfLv)
local list={}
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
local skils=cfg.skill
for i=1,2 do
local skillID=skils[i]
if skillID~=nil then
local skillLv=UIGongFaModel:getSkillLvInGongFa(gfID,gfLv,skillID)
local d={skillID,skillLv}
table.insert(list,d)
end
end
return list
end

function UIGongFaUpWin:showTips(gfLv)
local temp=self:getSkillData(self.gfID,gfLv)
self.tipsObj:setActive(true)
local wigetlist=self.tipsObj:getChildCommonLayoutGroupWidgetList()
for i=1,2 do
local item=wigetlist[i-1]
local data_n=temp[i]
local data_o=self.skilldatas[i]
local skillLv_n
local skillLv_o
local isshow=data_n~=nil
if isshow then
skillLv_n=data_n[2]
skillLv_o=data_o[2]
if skillLv_n<=0 then
isshow=false
end
end
item:SetChildActive(0,isshow)
if isshow then
local skillID=data_n[1]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
item:SetChildIcon(1,iconHelper.getSkillIcon(skillCfg.icon),false)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(6,is_bd)
item:SetChildText(2,skillCfg.name)


item:SetChildText(5,FMT.fmt('等级{0}',skillLv_n))

local lv_str=''
local is_lock=true
if skillLv_o>0 then
lv_str=FMT.fmt('技能等级{0}',skillLv_o)
is_lock=false
end
item:SetChildText(3,lv_str)
item:SetChildActive(4,is_lock)
end
end


self.tipsObj:setChildCanvasGroupAlpha(0)
self.tipsObj:setChildCanvasGroupDOFade(1,1,nil)
local func=function()
self.tipsObj:setChildCanvasGroupDOFade(0,1,nil)
end
self:setDelayTimer(5,func)
end

function UIGongFaUpWin:showGfUpTips(oldlv,newlv)
local oldTemp=self:getSkillData(self.gfID,oldlv)
local newTemp=self:getSkillData(self.gfID,newlv)
for i=1,2 do
local oldSkillLv=oldTemp[i]and oldTemp[i][2]or 0
local newSkillLv=newTemp[i]and newTemp[i][2]or 0
if oldSkillLv==0 and newSkillLv==1 then
local ages={
diziGuid=self.disciple_guid,
gfID=self.gfID,
skillID=newTemp[i][1],
}
UIManager:showWindow('UIGongFaSkillUpWin',ages)
end
end
end

function UIGongFaUpWin:setDelayTimer(delay,func)
self:clearDalayTimer()
local func1=function()
func()
self.delayTimer=nil
end
self.delayTimer=self:setTimer(delay,1,func1)
end

function UIGongFaUpWin:clearDalayTimer()
if self.delayTimer~=nil then
self:stopTimerByID(self.delayTimer)
self.delayTimer=nil
end
end

function UIGongFaUpWin:onMoneyChanged(moneyType)
if moneyType==eMoneyType.mtChuanDao then
self:refreshView()
end
end
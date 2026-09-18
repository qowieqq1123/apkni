







def_class("UIXianMengMouLueSetWin",UIWindowBase)









function UIXianMengMouLueSetWin:bindComponents()

self.moneyBtn_2=UIButton.get(self,0)
self.moneyBtn_1=UIButton.get(self,1)
self.moneyBtn_3=UIButton.get(self,2)
self.ruleBtn=UIButton.get(self,3)
self.postTx=UIText.get(self,4)
self.moneyRoot_1=UIObject.get(self,5)
self.moneyRoot_2=UIObject.get(self,6)
self.moneyRoot_3=UIObject.get(self,7)
self.mouline=UIObject.get(self,8)
self.wuline=UIObject.get(self,9)
self.moulue=UIObject.get(self,10)
self.wulue=UIObject.get(self,11)
self.wuItem=UIObject.get(self,12)
self.mouItem=UIObject.get(self,13)
self.goalTypeScrollView=UIObject.get(self,14)
self.skill55=UIButton.get(self,15)
self.skill11=UIButton.get(self,16)
self.skill22=UIButton.get(self,17)
self.skill33=UIButton.get(self,18)
self.skill44=UIButton.get(self,19)
self.skill66=UIButton.get(self,20)
self.skill77=UIButton.get(self,21)
self.skill88=UIButton.get(self,22)
self.skill1=UIButton.get(self,23)
self.skill2=UIButton.get(self,24)
self.skill3=UIButton.get(self,25)
self.skill7=UIButton.get(self,26)
self.skill4=UIButton.get(self,27)
self.skill6=UIButton.get(self,28)
self.skill8=UIButton.get(self,29)
self.skill5=UIButton.get(self,30)
self.mouItembg=UIButton.get(self,31)
self.wuItembg=UIButton.get(self,32)
self.line1=UIObject.get(self,33)
self.line2=UIObject.get(self,34)
self.line3=UIObject.get(self,35)
self.line4=UIObject.get(self,36)
self.line8=UIObject.get(self,37)
self.line7=UIObject.get(self,38)
self.line6=UIObject.get(self,39)
self.line5=UIObject.get(self,40)
self.line77=UIObject.get(self,41)
self.line55=UIObject.get(self,42)
self.line66=UIObject.get(self,43)
self.line88=UIObject.get(self,44)
self.line44=UIObject.get(self,45)
self.line22=UIObject.get(self,46)
self.line33=UIObject.get(self,47)
self.line11=UIObject.get(self,48)
self.upBtn=UIButton.get(self,49)
self.feiqi=UIObject.get(self,50)
self.feiqi2=UIObject.get(self,51)
self.yetMax=UIText.get(self,52)
self.yanjiutxtbg=UIObject.get(self,53)
self.skillname=UIText.get(self,54)
self.tiaojian1=UIText.get(self,55)
self.tiaojian2=UIText.get(self,56)
self.skilltxt=UIText.get(self,57)
self.txtbg=UIObject.get(self,58)
self.UpSkilltxt=UIText.get(self,59)
self.m=UIButton.get(self,60)
self.m2=UIButton.get(self,61)
self.moneyRoot_need2=UIBaseItem.get(self,62)
self.moneyRoot_need1=UIBaseItem.get(self,63)
self.moneyRoot_need3=UIBaseItem.get(self,64)
self.gou1=UIObject.get(self,65)
self.gou2=UIObject.get(self,66)
self.Content=UIObject.get(self,67)
self.needhide=UIText.get(self,68)

self.moneyBtn_2:setButtonClick(function()self:onMoneyBtn_2()end)

self.moneyBtn_1:setButtonClick(function()self:onMoneyBtn_1()end)

self.moneyBtn_3:setButtonClick(function()self:onMoneyBtn_3()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.skill55:setButtonClick(function()self:onSkill55()end)

self.skill11:setButtonClick(function()self:onSkill11()end)

self.skill22:setButtonClick(function()self:onSkill22()end)

self.skill33:setButtonClick(function()self:onSkill33()end)

self.skill44:setButtonClick(function()self:onSkill44()end)

self.skill66:setButtonClick(function()self:onSkill66()end)

self.skill77:setButtonClick(function()self:onSkill77()end)

self.skill88:setButtonClick(function()self:onSkill88()end)

self.skill1:setButtonClick(function()self:onSkill1()end)

self.skill2:setButtonClick(function()self:onSkill2()end)

self.skill3:setButtonClick(function()self:onSkill3()end)

self.skill7:setButtonClick(function()self:onSkill7()end)

self.skill4:setButtonClick(function()self:onSkill4()end)

self.skill6:setButtonClick(function()self:onSkill6()end)

self.skill8:setButtonClick(function()self:onSkill8()end)

self.skill5:setButtonClick(function()self:onSkill5()end)

self.mouItembg:setButtonClick(function()self:onMouItembg()end)

self.wuItembg:setButtonClick(function()self:onWuItembg()end)

self.upBtn:setButtonClick(function()self:onUpBtn()end)

self.m:setButtonClick(function()self:onM()end)

self.m2:setButtonClick(function()self:onM2()end)
self.moneyBtn={
self.moneyBtn_1,
self.moneyBtn_2,
self.moneyBtn_3,
}
self.moneyRoot={
self.moneyRoot_1,
self.moneyRoot_2,
self.moneyRoot_3,
}
self.moneyRoot={
["need2"]=self.moneyRoot_need2,
["need1"]=self.moneyRoot_need1,
["need3"]=self.moneyRoot_need3,
}



end


function UIXianMengMouLueSetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.moneyBtn_2);self.moneyBtn_2=nil;
_UIObject_release(self.moneyBtn_1);self.moneyBtn_1=nil;
_UIObject_release(self.moneyBtn_3);self.moneyBtn_3=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.postTx);self.postTx=nil;
_UIObject_release(self.moneyRoot_1);self.moneyRoot_1=nil;
_UIObject_release(self.moneyRoot_2);self.moneyRoot_2=nil;
_UIObject_release(self.moneyRoot_3);self.moneyRoot_3=nil;
_UIObject_release(self.mouline);self.mouline=nil;
_UIObject_release(self.wuline);self.wuline=nil;
_UIObject_release(self.moulue);self.moulue=nil;
_UIObject_release(self.wulue);self.wulue=nil;
_UIObject_release(self.wuItem);self.wuItem=nil;
_UIObject_release(self.mouItem);self.mouItem=nil;
_UIObject_release(self.goalTypeScrollView);self.goalTypeScrollView=nil;
_UIObject_release(self.skill55);self.skill55=nil;
_UIObject_release(self.skill11);self.skill11=nil;
_UIObject_release(self.skill22);self.skill22=nil;
_UIObject_release(self.skill33);self.skill33=nil;
_UIObject_release(self.skill44);self.skill44=nil;
_UIObject_release(self.skill66);self.skill66=nil;
_UIObject_release(self.skill77);self.skill77=nil;
_UIObject_release(self.skill88);self.skill88=nil;
_UIObject_release(self.skill1);self.skill1=nil;
_UIObject_release(self.skill2);self.skill2=nil;
_UIObject_release(self.skill3);self.skill3=nil;
_UIObject_release(self.skill7);self.skill7=nil;
_UIObject_release(self.skill4);self.skill4=nil;
_UIObject_release(self.skill6);self.skill6=nil;
_UIObject_release(self.skill8);self.skill8=nil;
_UIObject_release(self.skill5);self.skill5=nil;
_UIObject_release(self.mouItembg);self.mouItembg=nil;
_UIObject_release(self.wuItembg);self.wuItembg=nil;
_UIObject_release(self.line1);self.line1=nil;
_UIObject_release(self.line2);self.line2=nil;
_UIObject_release(self.line3);self.line3=nil;
_UIObject_release(self.line4);self.line4=nil;
_UIObject_release(self.line8);self.line8=nil;
_UIObject_release(self.line7);self.line7=nil;
_UIObject_release(self.line6);self.line6=nil;
_UIObject_release(self.line5);self.line5=nil;
_UIObject_release(self.line77);self.line77=nil;
_UIObject_release(self.line55);self.line55=nil;
_UIObject_release(self.line66);self.line66=nil;
_UIObject_release(self.line88);self.line88=nil;
_UIObject_release(self.line44);self.line44=nil;
_UIObject_release(self.line22);self.line22=nil;
_UIObject_release(self.line33);self.line33=nil;
_UIObject_release(self.line11);self.line11=nil;
_UIObject_release(self.upBtn);self.upBtn=nil;
_UIObject_release(self.feiqi);self.feiqi=nil;
_UIObject_release(self.feiqi2);self.feiqi2=nil;
_UIObject_release(self.yetMax);self.yetMax=nil;
_UIObject_release(self.yanjiutxtbg);self.yanjiutxtbg=nil;
_UIObject_release(self.skillname);self.skillname=nil;
_UIObject_release(self.tiaojian1);self.tiaojian1=nil;
_UIObject_release(self.tiaojian2);self.tiaojian2=nil;
_UIObject_release(self.skilltxt);self.skilltxt=nil;
_UIObject_release(self.txtbg);self.txtbg=nil;
_UIObject_release(self.UpSkilltxt);self.UpSkilltxt=nil;
_UIObject_release(self.m);self.m=nil;
_UIObject_release(self.m2);self.m2=nil;
_UIObject_release(self.moneyRoot_need2);self.moneyRoot_need2=nil;
_UIObject_release(self.moneyRoot_need1);self.moneyRoot_need1=nil;
_UIObject_release(self.moneyRoot_need3);self.moneyRoot_need3=nil;
_UIObject_release(self.gou1);self.gou1=nil;
_UIObject_release(self.gou2);self.gou2=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.needhide);self.needhide=nil;
self.moneyBtn=nil;
self.moneyRoot=nil;
self.moneyRoot=nil;
end



















local typecmp=
{
name=1,
}

local _this=nil

function UIXianMengMouLueSetWin:onLoaded(...)
_this=self
self:bindComponents()




self._onMoneyChange=function(...)self:onMoneyChange(...)end
self._onItemChange=function(...)self:onItemChange(...)end
notifySystem:listenNotify(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:listenNotify(notifyConfig.on_item_changed,self._onItemChange)
end


function UIXianMengMouLueSetWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:removelistener(notifyConfig.on_item_changed,self._onItemChange)
_this=nil
end




function UIXianMengMouLueSetWin:onShow(argtable,afterOnloaded)


self.gtSelectIndex=1

self.skillIndex=1
self:refreshWindow()

end


function UIXianMengMouLueSetWin:onHide()
if _this.effectTimer then
_this.effectTimer:cancel()
_this.effectTimer=nil
end
end





function UIXianMengMouLueSetWin:onRuleBtn()
end


function UIXianMengMouLueSetWin:refreshWindow()
local widget1=self.winlua:GetChildWidgetBase(self.mouItem:getID())
local widget2=self.winlua:GetChildWidgetBase(self.wuItem:getID())
widget1:SetChildActive(2,true)
widget2:SetChildActive(2,false)


local typeCount=2
local nametable={"谋算","武略"}










self:judeQuanXian()
self:ChangeMainType()

self:initMoneyShow_1()
self:initMoneyShow_2()
self:initMoneyShow_3()



end


function UIXianMengMouLueSetWin:judeQuanXian()

local posid=xianmengModel:getXMMemberPost(playerModel:getActorID())

self.QXflag=xianmengModel.checkPostPrivile(posid,GUILD_PRIVILE_TYPE.gptRuse)




end


function UIXianMengMouLueSetWin:Onfresh(index)

self:judeQuanXian()
self:RefreshMoney_1()
self:RefreshMoney_2()
self:RefreshMoney_3()

self:refreshSkillShow()
self:refreshSkillTxt(index)
self:SkillCost(index)

end


function UIXianMengMouLueSetWin:judeIs_CanClick()

end


function UIXianMengMouLueSetWin:initMoneyShow_1()


local havenum=moneyModel.getMoney(eMoneyType.mtXMLingShi)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot_1:getID())
local moneyStr=mathHelper.formatNumber(tonumber(tostring(havenum)),true)
widget:SetChildIcon(0,iconHelper.getIconName(eMoneyType.mtXMLingShi),false)
widget:SetChildText(1,moneyStr)

end

function UIXianMengMouLueSetWin:initMoneyShow_2()


local havenum=moneyModel.getMoney(eMoneyType.mtXMXuKongJing)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot_2:getID())
local moneyStr=mathHelper.formatNumber(tonumber(tostring(havenum)),true)
widget:SetChildIcon(0,iconHelper.getIconName(eMoneyType.mtXMXuKongJing),false)
widget:SetChildText(1,moneyStr)
end

function UIXianMengMouLueSetWin:initMoneyShow_3()


local havenum=moneyModel.getMoney(eMoneyType.mtXMJieShi)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot_3:getID())
local moneyStr=mathHelper.formatNumber(tonumber(tostring(havenum)),true)
widget:SetChildIcon(0,iconHelper.getIconName(eMoneyType.mtXMJieShi),false)
widget:SetChildText(1,moneyStr)
end

function UIXianMengMouLueSetWin:onMoneyChange(moneyType,lastVal,val)


end

function UIXianMengMouLueSetWin:onItemChange(changeType,itemguid,itemid,lastcount,itemcount)

end

function UIXianMengMouLueSetWin:RefreshMoneyAll()
self:RefreshMoney_1()
self:RefreshMoney_2()
self:RefreshMoney_3()
self:SkillCost(self.skillIndex)
end


function UIXianMengMouLueSetWin:RefreshMoney_1()


local havenum=moneyModel.getMoney(eMoneyType.mtXMLingShi)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot_1:getID())
local moneyStr=mathHelper.formatNumber(tonumber(tostring(havenum)),true)
widget:SetChildText(1,moneyStr)
end

function UIXianMengMouLueSetWin:RefreshMoney_2()


local havenum=moneyModel.getMoney(eMoneyType.mtXMXuKongJing)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot_2:getID())
local moneyStr=mathHelper.formatNumber(tonumber(tostring(havenum)),true)
widget:SetChildText(1,moneyStr)
end

function UIXianMengMouLueSetWin:RefreshMoney_3()


local havenum=moneyModel.getMoney(eMoneyType.mtXMJieShi)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot_3:getID())
local moneyStr=mathHelper.formatNumber(havenum,true)
widget:SetChildText(1,moneyStr)
end




function UIXianMengMouLueSetWin:onMouItembg()
if self.gtSelectIndex==1 then
return
end
self.gtSelectIndex=1
self:ChangeMainType()
local widget1=self.winlua:GetChildWidgetBase(self.mouItem:getID())
local widget2=self.winlua:GetChildWidgetBase(self.wuItem:getID())
widget1:SetChildActive(2,true)
widget2:SetChildActive(2,false)
end

function UIXianMengMouLueSetWin:onWuItembg()



if self.gtSelectIndex==2 then
return
end
self.gtSelectIndex=2
self:ChangeMainType()
local widget1=self.winlua:GetChildWidgetBase(self.mouItem:getID())
local widget2=self.winlua:GetChildWidgetBase(self.wuItem:getID())
widget1:SetChildActive(2,false)
widget2:SetChildActive(2,true)
end

function UIXianMengMouLueSetWin:ChangeMainType()

self:refreshSkillShow()

self:on_skill_click(1)
end

function UIXianMengMouLueSetWin:refreshSkillShow()
local skilllv=xianmengModel:GetSkillLv(self.gtSelectIndex,1)
if self.gtSelectIndex==1 then
self.wulue:setActive(false)
self.moulue:setActive(true)
self.mouline:setActive(true)
self.wuline:setActive(false)

local grids=self.moulue:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
widget:SetChildButtonClick(0,function(...)
_this:on_skill_click(i)
end)
local skilllv=xianmengModel:GetSkillLv(self.gtSelectIndex,i)

local icon=cfgHelper.get3(cfg_guildstrategyconfig_get,i,skilllv==0 and skilllv+1 or skilllv,'study_icon')
local iconname=FMT.fmt("icon_skill_{0}",icon)
widget:SetChildIcon(0,iconname,false)
local study_condition=cfgHelper.get3(cfg_guildstrategyconfig_get,i,skilllv==0 and skilllv+1 or skilllv,'study_condition')

local flag=true
if study_condition then
flag=self:judeIsup_condition(study_condition)
end

widget:SetChildActive(3,skilllv==0 and not flag)
if skilllv==0 then
widget:SetChildImageExGray(0,true)
end

widget:SetChildActive(4,skilllv>0)
widget:SetChildActive(1,self.skillIndex==i)
widget:SetChildText(2,skilllv)
end

local grids2=self.mouline:getChildCommonLayoutGroupWidgetList()
for i=1,grids2.Count do
local widget=grids2[i-1]
if i==1 or i==2 then
local skilllv=xianmengModel:GetSkillLv(self.gtSelectIndex,1)
widget:SetChildActive(0,skilllv~=0)
else

local skilllv=xianmengModel:GetSkillLv(self.gtSelectIndex,i-1)
widget:SetChildActive(0,skilllv~=0)
end
end

elseif self.gtSelectIndex==2 then
self.wulue:setActive(true)
self.moulue:setActive(false)
self.mouline:setActive(false)
self.wuline:setActive(true)

local grids=self.wulue:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
widget:SetChildButtonClick(0,function(...)
_this:on_skill_click(i)
end)
local skilllv=xianmengModel:GetSkillLv(self.gtSelectIndex,i)
local w_cfg=cfgHelper.get1(cfg_guildmilitaryconfig_get,i)

local jia_skilllv=skilllv
if skilllv==0 then
jia_skilllv=1
end
if w_cfg and w_cfg[jia_skilllv]then

widget:SetChildActive(0,true)
local iconname=FMT.fmt("icon_skill_{0}",w_cfg[jia_skilllv].study_icon)
widget:SetChildIcon(0,iconname,false)
local flag=true
if w_cfg[jia_skilllv].study_condition then
flag=self:judeIsup_condition(w_cfg[jia_skilllv].study_condition)
end

widget:SetChildActive(3,(skilllv==0)and(not flag))
if skilllv==0 then
widget:SetChildImageExGray(0,true)
end
widget:SetChildText(2,skilllv)
widget:SetChildActive(4,skilllv>0)
widget:SetChildActive(1,self.skillIndex==i)

else
widget:SetChildActive(0,false)
end

end
local grids2=self.wuline:getChildCommonLayoutGroupWidgetList()
for i=1,grids2.Count do
local widget=grids2[i-1]
if i==1 or i==2 then
local skilllv=xianmengModel:GetSkillLv(self.gtSelectIndex,1)
widget:SetChildActive(0,skilllv~=0)
else

local skilllv=xianmengModel:GetSkillLv(self.gtSelectIndex,i-1)
widget:SetChildActive(0,skilllv~=0)
end
end
end


end

function UIXianMengMouLueSetWin:on_skill_click(index)
local grids=nil
if self.gtSelectIndex==1 then
grids=self.moulue:getChildCommonLayoutGroupWidgetList()
else
grids=self.wulue:getChildCommonLayoutGroupWidgetList()
end


local widget1=grids[self.skillIndex-1]
widget1:SetChildActive(1,false)

self.skillIndex=index
local widget2=grids[index-1]
widget2:SetChildActive(1,true)

self:refreshSkillTxt(index)
self:SkillCost(index)
end


function UIXianMengMouLueSetWin:refreshSkillTxt(index)
self.Content:setChildLocalPosition(Vector3.zero)
local skilllv=xianmengModel:GetSkillLv(self.gtSelectIndex,index)
local nextSkillLv=0
nextSkillLv=skilllv+1

if skilllv==0 then
skilllv=skilllv+1

end
local nowCfg=nil
local nextCfg=nil
local name=nil
if self.gtSelectIndex==1 then
nowCfg=cfgHelper.get2(cfg_guildstrategyconfig_get,index,skilllv)
nextCfg=cfgHelper.get2(cfg_guildstrategyconfig_get,index,nextSkillLv)
name=nowCfg.strategy_name
elseif self.gtSelectIndex==2 then
nowCfg=cfgHelper.get2(cfg_guildmilitaryconfig_get,index,skilllv)
nextCfg=cfgHelper.get2(cfg_guildmilitaryconfig_get,index,nextSkillLv)
name=nowCfg.military_name
end
self.skillname:setText(name)
if nowCfg.is_faze then

local effect_tb=self:GetEffect_val(nowCfg)
local fazeid=effect_tb[1]

local faze_valtb=cfgHelper.get2(cfg_sslawruleconfig_get,fazeid,'descparm')
local faze_desc=cfgHelper.get2(cfg_sslawruleconfig_get,fazeid,'desc')

local faze_val=faze_valtb[1]
if faze_val then
local str=string.format(faze_desc,unpack(faze_val))
self.skilltxt:setText(FMT.fmt("<color=#7d3b17>等级:{0}</color>{1}",skilllv,str))
else
self.skilltxt:setText(FMT.fmt("<color=#7d3b17>等级:{0}</color>{1}",skilllv,faze_desc))
end

if nextCfg then
local effect_tb=self:GetEffect_val(nextCfg)
local fazeid=effect_tb[1]

local faze_valtb=cfgHelper.get2(cfg_sslawruleconfig_get,fazeid,'descparm')
local faze_desc=cfgHelper.get2(cfg_sslawruleconfig_get,fazeid,'desc')
self.txtbg:setActive(true)
self.UpSkilltxt:setActive(true)
local faze_val=faze_valtb[1]
if faze_val then
self.UpSkilltxt:setText(string.format(faze_desc,unpack(faze_val)))
end

else
self.txtbg:setActive(false)
self.UpSkilltxt:setActive(false)
end
else
local effect_tb=self:GetEffect_val(nowCfg)
if nextCfg then

self.txtbg:setActive(true)
self.UpSkilltxt:setActive(true)
local effect_tb2=self:GetEffect_val(nextCfg)

if not next(effect_tb2)then
if nextSkillLv==1 then
self.UpSkilltxt:setText(nowCfg.study_txt)
else
self.UpSkilltxt:setText(nowCfg.nextstudy_txt)
end

else
if nextSkillLv==1 then
self.UpSkilltxt:setText(FMT.fmt(nowCfg.study_txt,unpack(effect_tb)))
else
self.UpSkilltxt:setText(FMT.fmt(nowCfg.nextstudy_txt,unpack(effect_tb2)))
end
end


else
self.UpSkilltxt:setActive(false)
self.txtbg:setActive(false)
end
local str=FMT.fmt(nowCfg.study_txt,unpack(effect_tb))
self.skilltxt:setText(FMT.fmt("<color=#7d3b17>等级{0}：</color>{1}",skilllv,str))
end
end


function UIXianMengMouLueSetWin:GetEffect_val(skillCfg)

local effect_tb=skillCfg.study_effect[1]
if effect_tb[1]~=12 and effect_tb[1]~=2 then
local tb=table.deepCopy(effect_tb)
table.remove(tb,1)
return tb
elseif effect_tb[1]==2 then

local tb=table.deepCopy(effect_tb)
table.remove(tb,1)
local itemid=tb[1]
if moneyConfig.isMoney(itemid)then
tb[1]=moneyModel.getMoneyName(itemid)
else
tb[1]=itemsConfig.getItemName(itemid)
end
return tb
elseif effect_tb[1]==12 then
local tb={}
for k,v in ipairs(skillCfg.study_effect)do
for k1,v1 in ipairs(v)do

if k1==2 then
tb[#tb+1]=moneyModel.getMoneyName(v1)
elseif k1==3 then
tb[#tb+1]=v1
end
end
end
return tb
end
end

function UIXianMengMouLueSetWin:splitStr(str)
str=string.sub(str,2,-2)
local parts={}

for part in string.gmatch(str,"[^\",%s]+")do
table.insert(parts,part)
end
return parts
end


function UIXianMengMouLueSetWin:Not_studyTxt(skillcfg)

local study_condition=skillcfg.study_condition

local num=0
local str1=nil
local str2=nil
for k,v in ipairs(study_condition)do
if v[1]==1 then
if num==0 then
num=num+1
str1=FMT.fmt("仙盟等级需要达到{0}级",v[2])
else
num=num+1
str2=FMT.fmt("仙盟等级需要达到{0}级",v[2])
end
break
elseif v[1]==2 then
local name=nil
if self.gtSelectIndex==1 then
name=cfgHelper.get3(cfg_guildstrategyconfig_get,v[2],1,"strategy_name")
elseif self.gtSelectIndex==2 then
name=cfgHelper.get3(cfg_guildmilitaryconfig_get,v[2],1,"military_name")
end
if num==0 then
num=num+1
local skilllv=xianmengModel:GetSkillLv(self.gtSelectIndex,v[2])

if skilllv<=0 then
str1=FMT.fmt("<color=#c82c2c>需要解锁韬略<{0}></color>",name)
self.gou1:setActive(false)
else
str1=FMT.fmt("<color=#549327>需要解锁韬略<{0}></color>",name)
self.gou1:setActive(true)
end
else
num=num+1
local skilllv=xianmengModel:GetSkillLv(self.gtSelectIndex,v[2])

if skilllv<=0 then
str2=FMT.fmt("<color=#c82c2c>需要解锁韬略<{0}></color>",name)
self.gou2:setActive(false)
else
str2=FMT.fmt("<color=#549327>需要解锁韬略<{0}></color>",name)
self.gou2:setActive(true)
end
end
end
end
if str1 then
self.tiaojian1:setActive(true)


self.tiaojian1:setText(str1)
self.moneyRoot_need1:setActive(false)
self.moneyRoot_need2:setActive(false)
self.moneyRoot_need3:setActive(false)
self.upBtn:setActive(false)
end
if str2 then
self.tiaojian2:setActive(true)

self.tiaojian2:setText(str2)
self.moneyRoot_need1:setActive(false)
self.moneyRoot_need2:setActive(false)
self.moneyRoot_need3:setActive(false)
self.upBtn:setActive(false)
end

end


function UIXianMengMouLueSetWin:SkillCost(index)
local skilllv=xianmengModel:GetSkillLv(self.gtSelectIndex,index)


if self.gtSelectIndex==2 then
local w_cfg2=cfgHelper.get2(cfg_guildmilitaryconfig_get,index,1)
if w_cfg2.need_hide then
self.yetMax:setActive(false)
self.needhide:setActive(true)
self.tiaojian1:setActive(false)
self.tiaojian2:setActive(false)
self.upBtn:setActive(false)
self.moneyRoot_need1:setActive(false)
self.moneyRoot_need2:setActive(false)
self.moneyRoot_need3:setActive(false)
return
end
end

self.needhide:setActive(false)

self.tiaojian1:setActive(false)
self.tiaojian2:setActive(false)
self.upBtn:setActive(true)
if skilllv then
if self.gtSelectIndex==1 then
local m_cfg2=cfgHelper.get2(cfg_guildstrategyconfig_get,index,skilllv+1)
self.yanjiutxtbg:setActive(true)
self.yetMax:setActive(false)
if not m_cfg2 then

self.upBtn:setActive(false)
self.moneyRoot_need1:setActive(false)
self.moneyRoot_need2:setActive(false)
self.moneyRoot_need3:setActive(false)
self.yanjiutxtbg:setActive(false)
self.yetMax:setActive(true)
return
end

local study_condition=m_cfg2.study_condition
if study_condition then
local flag=self:judeIsup_condition(study_condition)
if not flag then
self:Not_studyTxt(m_cfg2)
return
end
end

elseif self.gtSelectIndex==2 then
local w_cfg2=cfgHelper.get2(cfg_guildmilitaryconfig_get,index,skilllv+1)
self.yanjiutxtbg:setActive(true)
self.yetMax:setActive(false)
if not w_cfg2 then

self.upBtn:setActive(false)
self.moneyRoot_need1:setActive(false)
self.moneyRoot_need2:setActive(false)
self.moneyRoot_need3:setActive(false)
self.yanjiutxtbg:setActive(false)
self.yetMax:setActive(true)
return
end
local study_condition=w_cfg2.study_condition
if study_condition then
local flag=self:judeIsup_condition(study_condition)
if not flag then
self:Not_studyTxt(w_cfg2)
return
end
end
end
end


local study_cost=nil
if self.gtSelectIndex==1 then
local m_cfg=cfgHelper.get1(cfg_guildstrategyconfig_get,index)
if m_cfg and m_cfg[skilllv+1]then
study_cost=m_cfg[skilllv+1].study_cost
end
elseif self.gtSelectIndex==2 then
local w_cfg=cfgHelper.get1(cfg_guildmilitaryconfig_get,index)
if w_cfg and w_cfg[skilllv+1]then
study_cost=w_cfg[skilllv+1].study_cost
end
end

for i=1,3 do
local widget=nil
if i==1 then
self.moneyRoot_need1:setActive(true)
widget=self.winlua:GetChildWidgetBase(self.moneyRoot_need1:getID())

elseif i==2 then
self.moneyRoot_need2:setActive(true)
widget=self.winlua:GetChildWidgetBase(self.moneyRoot_need2:getID())

elseif i==3 then
self.moneyRoot_need3:setActive(true)
widget=self.winlua:GetChildWidgetBase(self.moneyRoot_need3:getID())

end

if study_cost and study_cost[i]then
local itemConfig=itemsConfig.getConfig(study_cost[i][1])
local color=itemConfig.color
widget:SetChildIcon(1,iconHelper.getIconName(study_cost[i][1]),false)
local moneyStr=mathHelper.formatNumber(study_cost[i][2],false)
local havenum=moneyModel.getMoney(study_cost[i][1])
if havenum<study_cost[i][2]then
moneyStr=FMT.fmt("<color={0}>{1}</color>",FONT_COLOR_VAL[FONT_COLOR.eRedColor],moneyStr)
end

widget:SetChildText(2,moneyStr)
widget:SetChildActive(9,true)
widget:SetChildQulaity(0,color)
widget:SetChildButtonClick(1,function(...)
itemsComponentHelper.onItemClickEx(study_cost[i][1])
end)
else
if i==1 then
self.moneyRoot_need1:setActive(false)
elseif i==2 then
self.moneyRoot_need2:setActive(false)
elseif i==3 then
self.moneyRoot_need3:setActive(false)
end
end
end
end

function UIXianMengMouLueSetWin:ClickItem(itemid)
gainControl:showCommonGainWin_item(itemid)
end

function UIXianMengMouLueSetWin:onUpBtn()
if not self.QXflag then
UIManager.error("盟主或副盟主才可下令研究")
return
end

local lv=xianmengModel:GetSkillLv(self.gtSelectIndex,self.skillIndex)





self:onUPSkillBtn(lv)



end



function UIXianMengMouLueSetWin:onUPSkillBtn(lv)
local type=self.gtSelectIndex
local skillindex=self.skillIndex
local study_condition=nil
local maxlv=xianmengModel:GetSkilMaxLv(type,skillindex)
if maxlv<lv+1 then

return
end
local costflag=false
if type==1 then

study_condition=cfgHelper.get3(cfg_guildstrategyconfig_get,skillindex,lv+1,'study_condition')
local study_cost=cfgHelper.get3(cfg_guildstrategyconfig_get,skillindex,lv+1,'study_cost')
costflag=UIXianMengMouLueSetWin:judeIsup_money(study_cost)
elseif type==2 then

study_condition=cfgHelper.get3(cfg_guildmilitaryconfig_get,skillindex,lv+1,'study_condition')

local study_cost=cfgHelper.get3(cfg_guildmilitaryconfig_get,skillindex,lv+1,'study_cost')
costflag=UIXianMengMouLueSetWin:judeIsup_money(study_cost)
end
local studyflag=true

if study_condition then
studyflag=self:judeIsup_condition(study_condition)
end


if studyflag and costflag then
xianmengController:send_learnBtn(type,skillindex)

end
end
function UIXianMengMouLueSetWin:play_effect()
local grids=nil
if _this==nil then
return
end
if _this.gtSelectIndex==1 then
grids=_this.moulue:getChildCommonLayoutGroupWidgetList()
elseif _this.gtSelectIndex==2 then
grids=_this.wulue:getChildCommonLayoutGroupWidgetList()
end
local widget=grids[_this.skillIndex-1]


widget:SetChildShowEffect(5,10460,true)

local func=function()
if _this==nil then
return
end
if _this.gtSelectIndex==1 then
UIManager.info("谋算等级提升")
widget:SetChildImageExGray(0,false)
elseif _this.gtSelectIndex==2 then
UIManager.info("武略等级提升")
widget:SetChildImageExGray(0,false)
end
end
if _this.effectTimer then
_this.effectTimer:cancel()
_this.effectTimer=nil
end

_this.effectTimer=timer.new()
_this.effectTimer:start(1.1,func,1)
end


function UIXianMengMouLueSetWin:judeIsup_condition(study_condition)
for k,v in ipairs(study_condition)do
if v[1]==1 then

local xmlv=xianmengModel:getXMLevel()
if xmlv<v[2]then

return false
end
elseif v[1]==2 then

local skilllv=xianmengModel:GetSkillLv(self.gtSelectIndex,v[2])


if skilllv<=0 then

return false
end
end
end
return true
end


function UIXianMengMouLueSetWin:judeIsup_money(study_cost)
for k,v in ipairs(study_cost)do
local itemid=v[1]
local neednum=v[2]

local havenum=0

havenum=moneyModel.getMoney(itemid)
havenum=tonumber(tostring(havenum))







if havenum<neednum then
gainControl:showCommonGainWin_item(itemid)

return false
end
end
return true
end

function UIXianMengMouLueSetWin:onMoneyBtn_1()
if not UIFullXianMengXianWuLouControl:check_showWindowKuFang()then
UIManager.error("仙盟库房未开启")
return
end
jumpManager:jump({id=JUMP_TYPE.eXianMengJuanXian})
end

function UIXianMengMouLueSetWin:onMoneyBtn_2()
if not UIFullXianMengXianWuLouControl:check_showWindowKuFang()then
UIManager.error("仙盟库房未开启")
return
end
jumpManager:jump({id=JUMP_TYPE.eXianMengJuanXian})
end

function UIXianMengMouLueSetWin:onMoneyBtn_3()
if not UIFullXianMengXianWuLouControl:check_showWindowKuFang()then
UIManager.error("仙盟库房未开启")
return
end
jumpManager:jump({id=JUMP_TYPE.eXianMengJuanXian})
end

function UIXianMengMouLueSetWin:onMoneyExClick(idx,moneyType)

local moneyWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eMoney)
local item=moneyWidget:GetChildWidgetBase(idx-1)
local desc=FMT.fmt('{0}：{1}',moneyModel.getMoneyName(moneyType),moneyModel.getMoney(moneyType))
UIManager:showWindow('UIConditionTipsOne',{showType=3,str=desc,posWidget=item,pos={x=0,y=-20}})
end

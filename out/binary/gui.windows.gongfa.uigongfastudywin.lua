







def_class("UIGongFaStudyWin",UIWindowBase)









function UIGongFaStudyWin:bindComponents()

self.animRoot=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.attrGrid=UIObject.get(self,2)
self.effectGrid=UIObject.get(self,3)
self.nextCostObj=UIObject.get(self,4)
self.nextlevelObj=UIObject.get(self,5)
self.nextlevelText=UIText.get(self,6)
self.levelTxt=UIText.get(self,7)
self.fullTipsTxt=UIText.get(self,8)
self.studyBtn=UIButton.get(self,9)
self.resetBtn=UIButton.get(self,10)
self.resetBtnIcon=UIObject.get(self,11)
self.resetfullBtn=UIButton.get(self,12)
self.resetfullBtnIcon=UIObject.get(self,13)

self.studyBtn:setButtonClick(function()self:onStudyBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)

self.resetfullBtn:setButtonClick(function()self:onResetfullBtn()end)



end


function UIGongFaStudyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.effectGrid);self.effectGrid=nil;
_UIObject_release(self.nextCostObj);self.nextCostObj=nil;
_UIObject_release(self.nextlevelObj);self.nextlevelObj=nil;
_UIObject_release(self.nextlevelText);self.nextlevelText=nil;
_UIObject_release(self.levelTxt);self.levelTxt=nil;
_UIObject_release(self.fullTipsTxt);self.fullTipsTxt=nil;
_UIObject_release(self.studyBtn);self.studyBtn=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.resetBtnIcon);self.resetBtnIcon=nil;
_UIObject_release(self.resetfullBtn);self.resetfullBtn=nil;
_UIObject_release(self.resetfullBtnIcon);self.resetfullBtnIcon=nil;
end















local _this

function UIGongFaStudyWin:onLoaded(...)
self:bindComponents()
_this=self
local costWidget=self.nextCostObj:getWidgetBase()
local func=function(name,isOn)
self:onUseGoodToggleChange(isOn)
end
costWidget:SetChildToggleChange(6,func,nil)
end


function UIGongFaStudyWin:__delete()
self:unbindComponents()
end


function UIGongFaStudyWin:onHide()

end




function UIGongFaStudyWin:onShow(argtable,afterOnloaded)
self.gfID=argtable.gfID

self:refreshView()

local func=function()
self:fadeOutView()
end
self:delayDo(0.1,func)
self:fadeOutView(true)
self:refreshResetBtn(self.gfID)
end

function UIGongFaStudyWin:fadeOutView(init)
local rootWidget=self.root:getChildWidgetBase()
local delay=0
local step=0.05
for i=0,12 do
local idx=i
if init then
rootWidget:SetChildCanvasGroupAlpha(idx,0)
else
if delay>0 then
local func=function(...)
rootWidget:SetChildCanvasGroupDOFade(idx,1,0.2,nil)
end
self:delayDo(delay,func)
else
rootWidget:SetChildCanvasGroupDOFade(idx,1,0.2,nil)
end
delay=delay+step
end
end
end

function UIGongFaStudyWin:refreshView()
local gfID=self.gfID
local cfg=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID)
local study=cfg.study
self.studylevel=UIGongFaModel:getStudyLevel(gfID)
local nextlevel=self.studylevel+1
self.isfull=UIGongFaModel:checkFullStudy(gfID)

local lv_str=FMT.fmt('研习等级+{0}',self.studylevel)
self.levelTxt:setText(lv_str)

local show_next=not self.isfull
self.nextlevelObj:setActive(show_next)
if show_next then
self.nextlevelText:setText(FMT.fmt('+{0}',nextlevel))
end

local attrGridList=self.attrGrid:getChildCommonLayoutGroupWidgetList()
local attrs=study[self.studylevel][3]
local next_attrs
if show_next then
next_attrs=study[nextlevel][3]
end
for i=1,3 do
local attrData=attrs[i]
local attrItem=attrGridList[i-1]
local show_attr=attrData~=nil
attrItem:SetChildActive(-1,show_attr)
if show_attr then

local attr_str=helper.getAttributeStr(attrData[1],attrData[2],1,'{0}+{1}')
attrItem:SetChildText(0,attr_str)

attrItem:SetChildActive(1,show_next)
if show_next then
attrItem:SetChildText(2,FMT.fmt('+{0}',next_attrs[i][2]))
end
end
end

local effectGridList=self.effectGrid:getChildCommonLayoutGroupWidgetList()
local studyDescDatas=cfg.studyDesc
for i=1,4 do
local descData=studyDescDatas[i]
local descItem=effectGridList[i-1]
local show_desc=descData~=nil
descItem:SetChildActive(-1,show_desc)
if show_desc then
local active_lv=descData[1]
local desc_1=descData[2]
local isActive=self.studylevel>=active_lv
local desc_2=FMT.fmt('（研习+{0}激活）',active_lv)
if isActive then
desc_1=FMT.fmt('<color=#76d81e>{0}</color>',desc_1)
desc_2=FMT.fmt('<color=#76d81e>{0}</color>',desc_2)
end

descItem:SetChildText(0,desc_1)

descItem:SetChildText(1,desc_2)
end
end

self.nextCostObj:setActive(not self.isfull)
self.fullTipsTxt:setActive(self.isfull)
if self.isfull then
self:refreshfullResetBtn(gfID)
end

if not self.isfull then
_this.resetfullBtn:setActive(false)
self:refreshCostView()
end
end

function UIGongFaStudyWin:refreshCostView()
local costWidget=self.nextCostObj:getWidgetBase()
local gfID=self.gfID
local cfg=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID)
local study=cfg.study
local color=cfg.color


local speItemID=cfgHelper.getdef(cfg_disciplegongfaconfig,'speitemids',color)
local speNum=bagModel.getItemCountById(speItemID)
local showSpe=speNum>0
costWidget:SetChildActive(6,showSpe)
self.usespe=false
if showSpe then
self.usespe=costWidget:GetChildToggle(6)
costWidget:SetChildText(7,FMT.fmt('使用无字天书（<color=#76d81e>现有{0}</color>）',speNum))
end

local cost=study[self.studylevel][1]
local goodlist=cost[1][1]
local neednum=cost[1][2]
local hadnum=0

if self.usespe then
hadnum=hadnum+speNum
end
for i,v in ipairs(goodlist)do
hadnum=hadnum+bagModel.getItemCountById(v)

if liandonModel:CheckGongFa_Guanlian(gfID)then
local itemid=liandonModel:CheckGongFa_Guanlian_item(v)
if itemid then
hadnum=hadnum+bagModel.getItemCountById(itemid)
end
end
end

local enough_item=hadnum>=neednum

local itemID=goodlist[1]
costWidget:SetChildCSImageIcon(0,iconHelper.getIconName(itemID),true)
local has_item_str=FMT.fmt('现有{0}',hadnum)
if not enough_item then
has_item_str=FMT.fmt('<color=#c82c2c>{0}</color>',has_item_str)
end
local cost_item_str=FMT.fmt('{0}篇章  合计{1}卷（{2}）',cfg.name,neednum,has_item_str)
costWidget:SetChildText(1,cost_item_str)

local money=cost[2]
local needmoney=money[2]
local hasmoney=moneyModel.getMoney(money[1])
local enough_money=hasmoney>=needmoney
local cost_money_str=tostring(needmoney)
if not enough_money then
cost_money_str=FMT.fmt('<color=#c82c2c>{0}</color>',cost_money_str)
end
costWidget:SetChildText(3,cost_money_str)
costWidget:SetChildCSImageIcon(2,iconHelper.getIconName(money[1]),true)

local is_reddot=enough_item and enough_money
costWidget:SetChildActive(5,is_reddot)

costWidget:SetChildImageExGray(4,not is_reddot)
end

function UIGongFaStudyWin:onUseGoodToggleChange(flag)
self:refreshCostView()
end

function UIGongFaStudyWin:onRuleBtn()
local d={}
d.title='功法研习规则介绍'
d.mode=3
d.name='gongfastudy_rule_%d'
d.moveSortOrder=2
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIGongFaStudyWin:onStudyBtn()
local flag,GLtable=UIGongFaModel:checkStudyCanUp(self.gfID,self.usespe,true)
if not flag then
return
end
local gllist={}

for k,v in pairs(GLtable)do
if v[3]>0 then
if v[3]>v[2]then
v[3]=v[2]
end
if k and v[1]then
gllist[#gllist+1]={liandongZY.gongfa,k,v[1],v[3]}
end

end
end
if#gllist>0 then
liandonController:send_254_96(#gllist,gllist)
end

UIGongFaController:reqGongFaStudy(self.gfID,self.usespe==true and 1 or 0)
end

function UIGongFaStudyWin:rec_study(gfID)
if self.gfID==gfID then
self:refreshView()
end
end


function UIGongFaStudyWin:refreshResetBtn(_gfID)
local gfID=_gfID
local cfg=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID)
local gfcolor=cfg.color
local studylevel=UIGongFaModel:getStudyLevel(gfID)
if studylevel>0 then
_this.studyBtn:setActive(true)
_this.resetBtn:setActive(true)
_this.winlua:SetChildLocalPosX(_this.studyBtn:getID(),-90)
_this.winlua:SetChildLocalPosX(_this.resetBtn:getID(),100)


local recordNum=gameUtilityModel:getData_counter(gameCounterType.eGongFaResetNum)
local reset=cfgHelper.getdef(cfg_disciplegongfaconfig,'reset')
local reset_num=reset[1]
local reset_arry=reset[2]
local ishasNum=reset_num>recordNum

local costid=eMoneyType.mtLingYu
local costNum=0
if reset_arry[gfcolor]then
if reset_arry[gfcolor][studylevel]then
local cost=reset_arry[gfcolor][studylevel][1]
costid=cost[1]
costNum=cost[2]
end
end
local isEnough=moneyModel.checkEnoughMoney(costid,costNum)
if not isEnough and costid==eMoneyType.mtLingYu then
local hasLingYuCount=moneyModel.getMoney(costid)
local needXianYuCount=costNum-hasLingYuCount
isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
end



if not ishasNum or not isEnough then
_this.winlua:SetChildGray(_this.resetBtnIcon:getID(),true)
end
else
_this.studyBtn:setActive(true)
_this.resetBtn:setActive(false)
_this.winlua:SetChildLocalPosX(_this.studyBtn:getID(),19)
end
end

function UIGongFaStudyWin:onResetBtn()
UIManager:showWindow('UIGongFaResetWin',{gfID=_this.gfID})
end

function UIGongFaStudyWin:refreshfullResetBtn(_gfID)
local gfID=_gfID
local cfg=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID)
local gfcolor=cfg.color
local studylevel=UIGongFaModel:getStudyLevel(gfID)
if studylevel>0 then
_this.resetfullBtn:setActive(true)

local recordNum=gameUtilityModel:getData_counter(gameCounterType.eGongFaResetNum)
local reset=cfgHelper.getdef(cfg_disciplegongfaconfig,'reset')
local reset_num=reset[1]
local reset_arry=reset[2]
local ishasNum=reset_num>recordNum

local costid=eMoneyType.mtLingYu
local costNum=0
if reset_arry[gfcolor]then
if reset_arry[gfcolor][studylevel]then
local cost=reset_arry[gfcolor][studylevel][1]
costid=cost[1]
costNum=cost[2]
end
end
local isEnough=moneyModel.checkEnoughMoney(costid,costNum)
if not isEnough and costid==eMoneyType.mtLingYu then
local hasLingYuCount=moneyModel.getMoney(costid)
local needXianYuCount=costNum-hasLingYuCount
isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
end



if not ishasNum or not isEnough then
_this.winlua:SetChildGray(_this.resetfullBtnIcon:getID(),true)
end
else
_this.resetfullBtn:setActive(false)
end
end
function UIGongFaStudyWin:onResetfullBtn()
UIManager:showWindow('UIGongFaResetWin',{gfID=_this.gfID})
end
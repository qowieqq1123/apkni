







def_class("UILingShouCZWin",UIWindowBase)









function UILingShouCZWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.tipsbtn=UIButton.get(self,1)
self.lsname=UIText.get(self,2)
self.btnitem=UIObject.get(self,3)
self.btnitem2=UIObject.get(self,4)
self.btnitem3=UIObject.get(self,5)
self.btnitem4=UIObject.get(self,6)
self.nonetxt=UIText.get(self,7)
self.line1=UIObject.get(self,8)
self.line2=UIObject.get(self,9)
self.line3=UIObject.get(self,10)
self.nopanel=UIObject.get(self,11)
self.ScrollView=UIObject.get(self,12)
self.costtxt=UIText.get(self,13)
self.costicon=UIImage.get(self,14)
self.czbtn=UIButton.get(self,15)
self.root=UIObject.get(self,16)
self.txtpanel=UIObject.get(self,17)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)

self.czbtn:setButtonClick(function()self:onCzbtn()end)



end


function UILingShouCZWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.lsname);self.lsname=nil;
_UIObject_release(self.btnitem);self.btnitem=nil;
_UIObject_release(self.btnitem2);self.btnitem2=nil;
_UIObject_release(self.btnitem3);self.btnitem3=nil;
_UIObject_release(self.btnitem4);self.btnitem4=nil;
_UIObject_release(self.nonetxt);self.nonetxt=nil;
_UIObject_release(self.line1);self.line1=nil;
_UIObject_release(self.line2);self.line2=nil;
_UIObject_release(self.line3);self.line3=nil;
_UIObject_release(self.nopanel);self.nopanel=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.costtxt);self.costtxt=nil;
_UIObject_release(self.costicon);self.costicon=nil;
_UIObject_release(self.czbtn);self.czbtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.txtpanel);self.txtpanel=nil;
end
















local _this
local btnindex=
{
itemself=0,
nochoose=1,
choose=2,
name=3,
btn=4,
}
local lineindex=
{
itemself=0,
name=1,
arrow=2,
value=3,
}
local xuemaiName=
{
[0]='凡品',
[1]='灵品',
[2]='玄品',
[3]='地品',
[4]='天品',
[5]='仙品',
}



function UILingShouCZWin:onLoaded(...)
self:bindComponents()
_this=self
self.btnlsit={self.btnitem,self.btnitem2,self.btnitem3}
self.lineitems={self.line1,self.line2,self.line3}
self.chooselist=
{
{isopen=false,name='潜力重置',flag=0},
{isopen=false,name='血脉重置',flag=0},
{isopen=false,name='主动技能重置',flag=0},
}
self.allchoose=false
self.isnone=false
end


function UILingShouCZWin:__delete()
self:unbindComponents()
_this=nil
end

function UILingShouCZWin:onTipsbtn()
local d={}
d.title='规则'
d.mode=3
d.name='ui_UILingShouCZWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end


function UILingShouCZWin:onAllBtnClick()
self.allchoose=not self.allchoose
local allwidget=self.btnitem4:getWidgetBase()
allwidget:SetChildActive(btnindex.nochoose,not self.allchoose)
allwidget:SetChildActive(btnindex.choose,self.allchoose)

for i=1,#self.btnlsit do
local widget=self.btnlsit[i]:getWidgetBase()
if self.allchoose and self.chooselist[i].isopen then
self.chooselist[i].flag=1
widget:SetChildActive(btnindex.nochoose,false)
widget:SetChildActive(btnindex.choose,true)
else
self.chooselist[i].flag=0
widget:SetChildActive(btnindex.nochoose,true)
widget:SetChildActive(btnindex.choose,false)
end
end


self:freshpanel()

self:freshcost()
end

function UILingShouCZWin:onBtnClick(index)
local btndata=self.chooselist[index]
if not btndata.isopen then
local str=''
if index==1 then
str='潜力'
elseif index==2 then
str='血脉'
elseif index==3 then
str='技能'
end
UIManager.info(FMT.fmt("灵兽{0}尚未培养过，无法重置",str))
return
end

local widget=self.btnlsit[index]:getWidgetBase()
if btndata.flag==0 then
btndata.flag=1
elseif btndata.flag==1 then
btndata.flag=0
end


local flag=btndata.flag==1
widget:SetChildActive(btnindex.nochoose,not flag)
widget:SetChildActive(btnindex.choose,flag)


self:freshpanel()

self:freshcost()
end


function UILingShouCZWin:onCzbtn()
if self.isnone then
UIManager.info('请先勾选')
return
end
local moneyType=eMoneyType.mtLingYu
local cost=self.cost or 0






local isEnough=moneyModel.checkEnoughMoney(moneyType,self.cost)
if not isEnough and moneyType==eMoneyType.mtLingYu then

local hasLingYuCount=moneyModel.getMoney(moneyType)
local needXianYuCount=self.cost-hasLingYuCount
isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
end
if not isEnough then
local MoneyName=moneyModel.getMoneyName(moneyType)
UIManager.error(FMT.fmt("{0}不足",MoneyName))
gainControl:showGainWin(moneyType)
return
end

local lsName=self.lsData.name or self.lsData.cfg.name
local desc=''
local idx=0
for i,v in ipairs(self.chooselist)do
if v.isopen and v.flag==1 then
idx=idx+1
if i==1 then
desc='潜力'
elseif i==2 then
if idx>1 then
desc=desc..'、血脉'
else
desc='血脉'
end
elseif i==3 then
if idx>1 then
desc=desc..'、主动技能'
else
desc='主动技能'
end
end
end
end

local qlReset=self.chooselist[1].flag
local xmReset=self.chooselist[2].flag
local zdjnReset=self.chooselist[3].flag
local cb=function(...)
lingshouController:send_19_108(self.lsGuid,qlReset,xmReset,zdjnReset)
self:closeSelf()
end

local moneyIconName=iconHelper.getIconName(moneyType)
local contentStr=FMT.fmt("是否花费quad-icon={1}-quad x<color=#ca631d>{0}</color> 将<color=#ca631d>{2}</color>的<color=#ca631d>{3}</color>重置为初始值？",cost,moneyIconName,lsName,desc)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)


moneySystem:useMoney(moneyType,self.cost,cb,WARNING_TYPE.eWarning)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end





function UILingShouCZWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
self.lsGuid=argtable.lsGuid
if not self.lsGuid then
logErr('传入的灵兽guid为nil')
return
end
self.lsData=lingshouModel:getLingShouData(self.lsGuid)

if not self.lsData then
logErr('传入的灵兽数据为nil')
return
end

self:showWindow('UITopMoneyWin',{{eMoneyType.mtXianYu},{eMoneyType.mtLingYu}})
self.level=self.lsData.xuemai_val
self.stage=lingshouModel:switchLevelToStageAndIdx_XueMai(self.level)


local lsName=self.lsData.name or self.lsData.cfg.name
self.lsname:setText(lsName)


self:initBtnList()

self:freshpanel()

self:freshcost()
end


function UILingShouCZWin:onHide()

end
function UILingShouCZWin:onCloseBtn()
self:closeSelf()
end

function UILingShouCZWin:checkTypeIsOpen(i)
if i==1 then

local qianli_init=self.lsData.qianli_init or 0
local qianli=self.lsData.qianli or 0
return qianli_init~=qianli
elseif i==2 then

local xuemai=self.lsData.cfg.xuemai
local xuemai_val_init=xuemai and xuemai[2]or 1
local xuemai_val=self.lsData.xuemai_val or 1
local xuemai_dianshu=self.lsData.xuemai_dianshu or 0
return xuemai_dianshu>0 or xuemai_val~=xuemai_val_init
elseif i==3 then

local skill_level=self.lsData.skill_level or 0
local skill_level_init=self.lsData.skill_level_init or 0
return skill_level~=skill_level_init
end
return false
end


function UILingShouCZWin:initBtnList()

for i,v in ipairs(self.chooselist)do
local isopen=self:checkTypeIsOpen(i)
v.isopen=isopen
end


local allwidget=self.btnitem4:getWidgetBase()
allwidget:SetChildActive(btnindex.nochoose,not self.allchoose)
allwidget:SetChildActive(btnindex.choose,self.allchoose)
allwidget:SetChildButtonClick(btnindex.btn,function()
if _this==nil then return end
self:onAllBtnClick()
end)


for i=1,#self.btnlsit do
local widget=self.btnlsit[i]:getWidgetBase()
local btndata=self.chooselist[i]

local flag=btndata.flag==1
widget:SetChildActive(btnindex.nochoose,not flag)
widget:SetChildActive(btnindex.choose,flag)

if btndata.isopen then
widget:SetChildText(btnindex.name,btndata.name)
else
widget:SetChildText(btnindex.name,FMT.fmt("<color=#65615f>{0}</color>",btndata.name))
end


widget:SetChildButtonClick(btnindex.btn,function()
if _this==nil then return end
self:onBtnClick(i)
end)
end
end

function UILingShouCZWin:freshpanel()
self.isnone=true
for i,v in ipairs(self.chooselist)do
local lineitem=self.lineitems[i]:getWidgetBase()
lineitem:SetChildActive(lineindex.itemself,false)
if v.isopen and v.flag==1 then
self.isnone=false
if i==1 then
local qianli_init=self.lsData.qianli_init or 0
local qianli=self.lsData.qianli or 0
lineitem:SetChildActive(lineindex.itemself,true)
lineitem:SetChildText(lineindex.name,FMT.fmt("潜力：{0}",qianli))
lineitem:SetChildText(lineindex.value,qianli_init)
elseif i==2 then
local xuemai_val=self.lsData.xuemai_val or 0
local xuemai=self.lsData.cfg.xuemai
local xuemai_val_init=xuemai and xuemai[2]or 1
local sindex,lidx=lingshouModel:switchLevelToStageAndIdx_XueMai(xuemai_val)
lineitem:SetChildActive(lineindex.itemself,true)
if lidx>0 then
lineitem:SetChildText(lineindex.name,FMT.fmt("血脉：{0}+{1}",xuemaiName[sindex],lidx))
else
lineitem:SetChildText(lineindex.name,FMT.fmt("血脉：{0}",xuemaiName[sindex]))
end
local sindex2,lidx2=lingshouModel:switchLevelToStageAndIdx_XueMai(xuemai_val_init)
lineitem:SetChildText(lineindex.value,FMT.fmt("{0}",xuemaiName[sindex2]))
elseif i==3 then
local skill_level=self.lsData.skill_level or 0
local skill_level_init=self.lsData.skill_level_init or 0
local skillid=self.lsData.cfg.skill
local msLevelAllConfig=cfgHelper.get1(cfg_skillconfig_get,skillid)
lineitem:SetChildActive(lineindex.itemself,true)
lineitem:SetChildText(lineindex.name,FMT.fmt("技能：{0}级{1}",skill_level,msLevelAllConfig.name))
lineitem:SetChildText(lineindex.value,FMT.fmt("{0}级{1}",skill_level_init,msLevelAllConfig.name))
end
end
end
if self.isnone then
self.nonetxt:setActive(true)
self.txtpanel:setActive(false)
self.nopanel:setActive(true)
self.ScrollView:setActive(false)
else
self.nonetxt:setActive(false)
self.txtpanel:setActive(true)
self.nopanel:setActive(false)
self.ScrollView:setActive(true)

self:refreshRewardPanel()
end
end

function UILingShouCZWin:refreshRewardPanel()
local list=self:getRewards()

local len=#list
if len>0 then
self.nopanel:setActive(false)
self.ScrollView:setActive(true)
self.ScrollView:setChildScrollViewCreateGrids(len,5)
self.grids=self.ScrollView:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local costData=list[i]
if costData then
item:SetChildActive(-1,true)




















local isSpe=costData[1]<0
item:SetChildActive(0,not isSpe)
item:SetChildActive(1,isSpe)
if isSpe then
if costData[1]==-1 then
self:refreshCostItem_Spe1(item,costData)
elseif costData[1]==-2 then
self:refreshCostItem_Spe2(item,costData)
elseif costData[1]==-3 then
self:refreshCostItem_Spe1(item,costData)
elseif costData[1]==-4 then
self:refreshCostItem_Spe1(item,costData)
elseif costData[1]==-5 then
self:refreshCostItem_Spe1(item,costData)
end
else
self:refreshCostItem(item,costData)
end
else
item:SetChildActive(-1,false)
end
end
else
self.nopanel:setActive(true)
self.ScrollView:setActive(false)
end
end

function UILingShouCZWin:getRewards()
local xmResetReturnLookup={}
local msResetReturnLookup={}
local qlResetReturnLookup={}
for i,v in ipairs(self.chooselist)do
if v.isopen and v.flag==1 then
if i==1 then
qlResetReturnLookup=lingshouModel:calculateResetReturnItemLookup_QianLi(self.lsGuid)or defaultT
elseif i==2 then
xmResetReturnLookup=lingshouModel:calculateResetReturnItemLookup_XueMai(self.lsGuid)or defaultT
elseif i==3 then
msResetReturnLookup=lingshouModel:calculateResetReturnItemLookup_MainSkill(self.lsGuid)or defaultT
end
end
end

local xmPercent=cfgHelper.get(cfg_lingshouchuangongbaseconfig_get,1,'xmPercent')
for itemid,itemval in pairs(xmResetReturnLookup)do
if xmPercent[itemid]then
xmResetReturnLookup[itemid]=mathHelper.safe_floor(xmResetReturnLookup[itemid]*xmPercent[itemid])
end
end
local skillPercent=cfgHelper.get(cfg_lingshouchuangongbaseconfig_get,1,'skillPercent')
for itemid,itemval in pairs(msResetReturnLookup)do
if skillPercent[itemid]then
msResetReturnLookup[itemid]=mathHelper.safe_floor(msResetReturnLookup[itemid]*skillPercent[itemid])
end
end
local lookup={}
for itemId,itemVal in pairs(xmResetReturnLookup)do
lookup[itemId]=(lookup[itemId]or 0)+itemVal
end
for itemId,itemVal in pairs(msResetReturnLookup)do
lookup[itemId]=(lookup[itemId]or 0)+itemVal
end
for itemId,itemVal in pairs(qlResetReturnLookup)do
lookup[itemId]=(lookup[itemId]or 0)+itemVal
end

local list={}
for itemId,itemVal in pairs(lookup)do
if itemVal>0 then
list[#list+1]={itemId,itemVal}
end
end
return list

end

function UILingShouCZWin:refreshCostItem(item,costData)
local itemId=costData[1]
local itemNum=costData[2]



local countStr=mathHelper.formatNumber(itemNum)
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(itemId)
end)
end
function UILingShouCZWin:refreshCostItem_Spe1(item,costData)
local subItem=item:GetChildWidgetBase(1)

local idx=costData[1]
local needCount=costData[2]



local countStr=needCount
subItem:SetChildActive(0,true)
subItem:SetChildText(2,countStr)
local cost_ls=self.lsData.cfg.xuemai_cost_ls[self.level]
if cost_ls==nil then logErr("血脉消耗灵兽配置品阶缺少",self.stage)end
local id=next(cost_ls)
local color=-idx
subItem:SetChildQulaity(3,color)
subItem:SetChildActive(4,false)
item:SetBaseItemClickEvent(1,function(...)

end)
end
function UILingShouCZWin:refreshCostItem_Spe2(item,costData)
local subItem=item:GetChildWidgetBase(1)

local idx=costData[1]
local needCount=costData[2]



local countStr=needCount
subItem:SetChildActive(0,true)
subItem:SetChildText(2,countStr)
local cost_ls=self.lsData.cfg.xuemai_cost_ls[self.level]
local id=next(cost_ls)
local color=-idx
subItem:SetChildQulaity(3,color)
subItem:SetChildActive(4,false)
item:SetBaseItemClickEvent(1,function(...)

end)
end


function UILingShouCZWin:freshcost()
self.costicon:setChildIcon(iconHelper.getIconName(2),false)
self.cost=self:countCost()
local have=moneyModel.getMoney(2)
if have>=self.cost then
self.costtxt:setText(self.cost)
self.winlua:SetChildGray(self.czbtn:getID(),false)
else
local col=FONT_COLOR_VAL[FONT_COLOR.eRedColor]
self.costtxt:setText(FMT.fmt('<color={0}>{1}</color>',col,self.cost))
self.winlua:SetChildGray(self.czbtn:getID(),true)
end
end

function UILingShouCZWin:countCost()
local count=0
local lsDataA=self.lsData
local cgCfg=cfgHelper.get(cfg_lingshouchuangongbaseconfig_get,1)
for i,v in ipairs(self.chooselist)do
if v.isopen and v.flag==1 then
if i==1 then
if lsDataA.qianli>0 then
local val=lsDataA.qianli-lsDataA.qianli_init
if val>=0 then
local aqc=cgCfg.qlvItems[val]
if aqc then
count=count+aqc[2]

else
logErr("灵兽传功 灵兽潜力 消耗 缺少配置",val)
end
end
end
elseif i==2 then
if lsDataA.xuemai_val>1 then
local axmc=cgCfg.xmlvItems[lsDataA.xuemai_val]
if axmc then
count=count+axmc[2]

else
logErr("灵兽传功 灵兽血脉 消耗 缺少配置",lsDataA.xuemai_val)
end
end
elseif i==3 then
if lsDataA.skill_level>1 then
local amsc=cgCfg.skillItems[lsDataA.skill_level]
if amsc then
count=count+amsc[2]

else
logErr("灵兽传功 灵兽技能 消耗 缺少配置",lsDataA.skill_level)
end
end
end
end
end
return count
end



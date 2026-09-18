







def_class("UIDianFengZhiBaoWin",UIWindowBase)









function UIDianFengZhiBaoWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.expInfo=UIText.get(self,1)
self.fulllvlImg=UIObject.get(self,2)
self.level=UIText.get(self,3)
self.model=UIObject.get(self,4)
self.name=UIObject.get(self,5)
self.reddot=UIObject.get(self,6)
self.Root=UIObject.get(self,7)
self.uiRoot=UIObject.get(self,8)
self.upLvlBar=UIObject.get(self,9)
self.uplvlBtn=UIButton.get(self,10)
self.uplvlProgress=UIObject.get(self,11)
self.panel1=UIObject.get(self,12)
self.temp=UIObject.get(self,13)
self.temp2=UIObject.get(self,14)
self.temp3=UIObject.get(self,15)
self.xgitem=UIObject.get(self,16)
self.panel2=UIObject.get(self,17)
self.tipsbtn=UIButton.get(self,18)
self.tddesc=UIText.get(self,19)
self.czbtn=UIButton.get(self,20)
self.cznum=UIText.get(self,21)
self.dhitem=UIObject.get(self,22)
self.dhitem2=UIObject.get(self,23)
self.dhitem3=UIObject.get(self,24)
self.rwScrollView=UIObject.get(self,25)
self.page=UIObject.get(self,26)
self.bgModel=UIObject.get(self,27)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.uplvlBtn:setButtonClick(function()self:onUplvlBtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)

self.czbtn:setButtonClick(function()self:onCzbtn()end)



end


function UIDianFengZhiBaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.expInfo);self.expInfo=nil;
_UIObject_release(self.fulllvlImg);self.fulllvlImg=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.upLvlBar);self.upLvlBar=nil;
_UIObject_release(self.uplvlBtn);self.uplvlBtn=nil;
_UIObject_release(self.uplvlProgress);self.uplvlProgress=nil;
_UIObject_release(self.panel1);self.panel1=nil;
_UIObject_release(self.temp);self.temp=nil;
_UIObject_release(self.temp2);self.temp2=nil;
_UIObject_release(self.temp3);self.temp3=nil;
_UIObject_release(self.xgitem);self.xgitem=nil;
_UIObject_release(self.panel2);self.panel2=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.tddesc);self.tddesc=nil;
_UIObject_release(self.czbtn);self.czbtn=nil;
_UIObject_release(self.cznum);self.cznum=nil;
_UIObject_release(self.dhitem);self.dhitem=nil;
_UIObject_release(self.dhitem2);self.dhitem2=nil;
_UIObject_release(self.dhitem3);self.dhitem3=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.page);self.page=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local CmpBaseAttrSlotIndex={
name=0,
val=1,
upImg=2,
addVal=3,
}
local _this
local dhitemidx=
{
bg=0,
name=1,
btn=2,
selfitem=3,
reddot=4,
}
local lefttype=
{
shengji=1,
dianhua=2
}
local abname='ui/windows/dianfengzhibao/dianfengzhibao_atlas_pak.ab'
local dhwidgidx=
{
selfitem=0,
icon=1,
desc=2,
num=3,
btn=4,
effect=5,
}




function UIDianFengZhiBaoWin:onLoaded(...)
self:bindComponents()
self.oldEffectId=0
_this=self

self.dhitems={self.dhitem,self.dhitem2,self.dhitem3}
self.temps={self.temp,self.temp2,self.temp3}
self.leftflag=1
self.dhselectid=1
self.dhlist={}
end


function UIDianFengZhiBaoWin:__delete()
self:unbindComponents()
_this=nil
end

function UIDianFengZhiBaoWin:onHide()

end

function UIDianFengZhiBaoWin:onCloseBtn()
self:closeSelf()
end

function UIDianFengZhiBaoWin:onTipsbtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='UISiFangPingYaoMapWin_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIDianFengZhiBaoWin:onSelectLeftBtn(index)
if index==self.leftflag then
return
end
local oldIndex=self.leftflag
self.leftflag=index

local widget=self.page:getChildWidgetBase()
if widget then
widget:SetChildCSImageSprite(index-1,abname,"button_dfdj_yeqian_2")
if oldIndex then
widget:SetChildCSImageSprite(oldIndex-1,abname,"button_dfdj_yeqian_1")
end
end


self:showChangeWin()
end

function UIDianFengZhiBaoWin:onSelectDHBtn(index)
if index==self.dhselectid then
return
end
local oldIndex=self.dhselectid
self.dhselectid=index

local widget=self.dhitems[index]:getChildWidgetBase()
if widget then
widget:SetChildCSImageSprite(dhitemidx.bg,abname,"image_ddfdj_yeqian_2")
end
if oldIndex then
local oldwidget=self.dhitems[oldIndex]:getChildWidgetBase()
if oldwidget then
oldwidget:SetChildCSImageSprite(dhitemidx.bg,abname,"image_dfdj_yeqian_1")
end
end

self:freshDianHuaPerfab()
end

function UIDianFengZhiBaoWin:onCzbtn()

local resetNum=DianFengLevelModel:getresetNum()
local Maxreset=self.cfgs.resetLimit
if resetNum>=Maxreset then
UIManager.info("本周重置次数已达上限")
return
end
local usepoint=DianFengLevelModel:getaddPointNum()
if usepoint<=0 then
UIManager.info("无需重置")
return
end

local cost=self.cfgs.resetCost
local moneyType=cost[1][1]
local need=cost[1][2]
local have=moneyModel.getMoney(moneyType)

local colorStr=have>=need and"549327"or"FF0000"
local iconStr=iconHelper.getIconName(moneyType)
local costStr=FMT.fmt("quad-icon={2}-quad<color=#{0}>{1}</color>",colorStr,need,iconStr)
local num_str
local cur=Maxreset-resetNum
if cur>0 then
num_str=tostring(cur)
else
num_str=FMT.fmt('<color=#549327>{0}</color>',cur)
end
local contentStr=FMT.fmt("是否消耗{0}重置天道感悟点数？",costStr)
local _tips1=FMT.fmt("每周次数：{0}/{1}",num_str,Maxreset)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
Str=contentStr,
tips1=_tips1,
oktext='确定',
canceltext='取消',
okcallback=function(...)
if _this==nil then return end
if cur<=0 then
UIManager.error('本周重置次数已用完')
return
end
if not moneyModel.checkEnoughMoney(moneyType,need)then
local str=FMT.fmt('{0}不足',moneyModel.getMoneyName(moneyType))
UIManager.error(str)
gainControl:showGainWin(moneyType)
return
end
DianFengLevelController:send_16_44()
end,
showclosebtn=true,
}


UIManager:showWindow('UIDialougeDFZBtips',showdata)
end

function UIDianFengZhiBaoWin:onUpDHBtn(dscfg,xgid)
local limit=dscfg.limit
local pointnum=DianFengLevelModel:getPointListByid(xgid)
local isgray=false
if limit then
if pointnum>=limit then
isgray=true
end
end
if isgray then
UIManager.info("已达上限")
return
end

local dflevel=DianFengLevelModel:getLevel()
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local maxpoint=cfglvl.point
local usepoint=DianFengLevelModel:getaddPointNum()
if usepoint>=maxpoint then
UIManager.info("天道感悟不足")
return
end

DianFengLevelController:send_16_43(xgid)

end

function UIDianFengZhiBaoWin:onUplvlBtn()
local dflevel=DianFengLevelModel:getLevel()
local nextcfglvl=cfg_dianfenglevelconfig_get(dflevel+1)
if nextcfglvl then
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local maxexp=cfglvl.exp
local exp=DianFengLevelModel:getExp()
if exp>=maxexp then

DianFengLevelController:send_16_42()
else
UIManager.info('名声值不足')
local moneytype=eMoneyType.mtExp
gainControl:showGainWin(moneytype)
return
end
else
UIManager.info('当前已满级')
return
end
end





function UIDianFengZhiBaoWin:onShow(argtable,afterOnloaded)
self.uiRoot:setChildCanvasGroupAlpha(0)
self.uiRoot:setChildCanvasGroupDOFade(1,0.6,nil)
self.bgModel:setChildUIModelShowTarget(6161,1,{},eAnimationID.enter)
local effectid=12007
self.model:setChildShowEffect(effectid,true)
self.leftflag=argtable.flag or 1
self.cfgs=cfg_dianfenglevelbaseconfig_get(1)
self.dhlist=self:setDianHuaList()


local widgetleft=self.page:getChildWidgetBase()
for i=1,2 do
if self.leftflag==i then
widgetleft:SetChildCSImageSprite(i-1,abname,"button_dfdj_yeqian_2")
else
widgetleft:SetChildCSImageSprite(i-1,abname,"button_dfdj_yeqian_1")
end

widgetleft:SetChildButtonClick(i-1,function()
if _this==nil then return end
self:onSelectLeftBtn(i)
end)
end


local cfgsjbtns=self.cfgs.sjbtns
for k,v in ipairs(self.dhitems)do
local widget=v:getChildWidgetBase()
if cfgsjbtns[k]then
v:setActive(true)
if self.dhselectid==k then
widget:SetChildCSImageSprite(dhitemidx.bg,abname,"image_ddfdj_yeqian_2")
else
widget:SetChildCSImageSprite(dhitemidx.bg,abname,"image_dfdj_yeqian_1")
end
widget:SetChildText(dhitemidx.name,cfgsjbtns[k])
widget:SetChildButtonClick(dhitemidx.btn,function()
if _this==nil then return end
self:onSelectDHBtn(k)
end)
else
v:setActive(false)
end
end


self:showChangeWin()
self:checkShengJiRed()
self:checkDianHuaRed()

end

function UIDianFengZhiBaoWin:showChangeWin(dhred)
if self.leftflag==lefttype.shengji then
self:freshShengJi(true)
elseif self.leftflag==lefttype.dianhua then
self:freshDianHua(true,dhred)
end
end

function UIDianFengZhiBaoWin:setDianHuaList()
local cfg=cfg_dianfengleveleffectconfig()
local temp={}
local cfgsjbtns=self.cfgs.sjbtns
for k,v in ipairs(cfgsjbtns)do
temp[k]={}
end
for k,v in pairs(cfg)do
local page=v.page
if temp[page]then
table.insert(temp[page],v.id)
end
end
return temp
end


function UIDianFengZhiBaoWin:freshDianHua(change,freshred)
if change then
self.panel1:setActive(false)
self.panel2:setActive(true)
end
self:freshDianHuaDesc()
self:freshDianHuaPerfab()
if freshred then
self:checkDianHuaRed()
end
end

function UIDianFengZhiBaoWin:setdianhuaicon(item,icons)
local value=icons[2]
if icons[1]==1 then
item:SetChildIcon(dhwidgidx.icon,iconHelper.getIconName(value),false)
item:SetChildRotation(dhwidgidx.icon,0,0,-20)
else
item:SetChildCSImageSprite(dhwidgidx.icon,abname,value)
item:SetChildRotation(dhwidgidx.icon,0,0,0)
end
end

function UIDianFengZhiBaoWin:setdianhuajc(item,pointnum,dscfg)
local desc=dscfg.desc
local descValue=dscfg.descValue
local allvalue=0
for k,v in ipairs(descValue)do
local min=v[1]
local max=v[2]
if max<=pointnum then
for i=min,max do
allvalue=allvalue+v[3]
end
else
for i=min,pointnum do
allvalue=allvalue+v[3]
end
end
end
local str=FMT.fmt(desc,allvalue)
item:SetChildText(dhwidgidx.desc,str)
end

function UIDianFengZhiBaoWin:freshDianHuaDesc()
local dflevel=DianFengLevelModel:getLevel()
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local maxpoint=cfglvl.point
local usepoint=DianFengLevelModel:getaddPointNum()
local num=maxpoint-usepoint
if num<0 then num=0 end
local str=string.format("天道感悟：%d/%d",num,maxpoint)
self.tddesc:setText(str)

local resetNum=DianFengLevelModel:getresetNum()
local Maxreset=self.cfgs.resetLimit
local cur=Maxreset-resetNum
local str2=string.format("每周次数：%d/%d",cur,Maxreset)
self.cznum:setText(str2)
end

function UIDianFengZhiBaoWin:freshDianHuaPerfab()
local _list=self.dhlist[self.dhselectid]
if _list then
local len=#_list
self.rwScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local xgid=_list[i]
local dscfg=cfg_dianfengleveleffectconfig_get(xgid)

local icons=dscfg.icons
self:setdianhuaicon(item,icons)


local limit=dscfg.limit
local pointnum=DianFengLevelModel:getPointListByid(xgid)
local str=''
local isgray=false
if limit then
str=string.format("(%d/%d)",pointnum,limit)
if pointnum>=limit then
isgray=true
end
else
str=string.format("(%d)",pointnum)
end
item:SetChildText(dhwidgidx.num,str)
item:SetChildGray(dhwidgidx.btn,isgray)
item:SetChildShowEffect(dhwidgidx.effect,0,false)


self:setdianhuajc(item,pointnum,dscfg)

item:SetChildButtonClick(dhwidgidx.btn,function()
if _this==nil then return end
self:onUpDHBtn(dscfg,xgid)
end)
end
end
end

function UIDianFengZhiBaoWin:checkDianHuaRed()
local dflevel=DianFengLevelModel:getLevel()
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local maxpoint=cfglvl.point
local usepoint=DianFengLevelModel:getaddPointNum()
local allred=usepoint<maxpoint
if self.dhlist then
for i,dlist in ipairs(self.dhlist)do
local singlered=false
if allred then
for k,xgid in ipairs(dlist)do
local dscfg=cfg_dianfengleveleffectconfig_get(xgid)
local limit=dscfg.limit
local pointnum=DianFengLevelModel:getPointListByid(xgid)
if limit then
if pointnum<limit then
singlered=true
break
end
else
singlered=true
break
end
end
end
if self.dhitems[i]then
local item=self.dhitems[i]:getChildWidgetBase()
item:SetChildActive(dhitemidx.reddot,singlered)
end
end
end

local widget=self.page:getChildWidgetBase()
widget:SetChildActive(3,allred)
end

function UIDianFengZhiBaoWin:setDianHuaEffect(xgid)
if xgid then
local _list=self.dhlist[self.dhselectid]
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
for i,_xgid in ipairs(_list)do
if xgid==_xgid then
local item=grids[i-1]
item:SetChildShowEffect(dhwidgidx.effect,10503,true)
end
end
end
end

function UIDianFengZhiBaoWin:ResetDianHuaEffect()

local _list=self.dhlist[self.dhselectid]
if _list then
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
for i,_xgid in ipairs(_list)do
local item=grids[i-1]
item:SetChildShowEffect(dhwidgidx.effect,10503,true)
end
end
end


function UIDianFengZhiBaoWin:freshShengJi(change)
if change then
self.panel1:setActive(true)
self.panel2:setActive(false)
end

local dflevel=DianFengLevelModel:getLevel()
self.level:setText(FMT.fmt("巅峰等级：{0}级",dflevel))
local nextcfglvl=cfg_dianfenglevelconfig_get(dflevel+1)


local attrInfoList=self:getAttrInfoList(dflevel)
for k,v in ipairs(self.temps)do
local widget=v:getChildWidgetBase()
if attrInfoList[k]then
v:setActive(true)
local data=attrInfoList[k]
local name=helper.getAttributeName(data.attrId)
local sVal=helper.getAttributeStrEx(data.attrId,data.attrVal)
widget:SetChildText(CmpBaseAttrSlotIndex.name,name)
widget:SetChildText(CmpBaseAttrSlotIndex.val,sVal)
widget:SetChildActive(CmpBaseAttrSlotIndex.upImg,data.isAdd)
widget:SetChildActive(CmpBaseAttrSlotIndex.addVal,data.isAdd)
if data.isAdd then
local addVal=helper.getAttributeStrEx(data.attrId,data.addVal)
widget:SetChildText(CmpBaseAttrSlotIndex.addVal,addVal)
end

if not nextcfglvl then
widget:SetChildLocalPosX(CmpBaseAttrSlotIndex.name,-70)
widget:SetChildLocalPosX(CmpBaseAttrSlotIndex.val,70)
end
else
v:setActive(false)
end
end


local xgwidget=self.xgitem:getChildWidgetBase()
xgwidget:SetChildActive(2,false)
xgwidget:SetChildActive(3,false)
local itemcfg=itemsConfig.getConfig(29400)
xgwidget:SetChildIcon(0,iconHelper.getItemIconName(itemcfg.icon),false)
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local point=cfglvl.point
xgwidget:SetChildText(1,string.format("%d点",point))
if nextcfglvl then
xgwidget:SetChildText(4,'天道感悟点数：')
local nextpoint=nextcfglvl.point
if nextpoint>point then
xgwidget:SetChildActive(2,true)
xgwidget:SetChildActive(3,true)
xgwidget:SetChildText(3,string.format("%d点",nextpoint))
end
else

xgwidget:SetChildText(1,'')
xgwidget:SetChildText(4,string.format("天道感悟点数：<color=#171311>%d点(满级)</color>",point))
xgwidget:SetChildLocalPosX(4,-41)
xgwidget:SetChildLocalPosY(4,-2)
end


local lred=false
local maxexp=cfglvl.exp
local exp=DianFengLevelModel:getExp()


if nextcfglvl then
self.uplvlBtn:setActive(true)
self.fulllvlImg:setActive(false)
if exp>=maxexp then
lred=true
end
self.reddot:setActive(lred)
local info=FMT.fmt("{0}/{1}",exp,maxexp)
self.expInfo:setText(info)
self.upLvlBar:setChildIconFillAmount(exp/maxexp)
else
self.uplvlBtn:setActive(false)
self.fulllvlImg:setActive(true)
exp=maxexp
local info=FMT.fmt("{0}/{1}",exp,maxexp)
self.expInfo:setText(info)
self.upLvlBar:setChildIconFillAmount(exp/maxexp)
end


local widget=self.page:getChildWidgetBase()
widget:SetChildActive(2,lred)
end

function UIDianFengZhiBaoWin:getAttrInfoList(dflevel)
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local attrs=cfglvl.attrs
local attrLookup={}
local attrTypeList={}
for index,attrInfo in ipairs(attrs)do
attrLookup[attrInfo[1]]=attrInfo[2]
attrTypeList[#attrTypeList+1]=attrInfo[1]
end
local curSkillInfo=attrs
local nextSkillInfo
local nextcfglvl=cfg_dianfenglevelconfig_get(dflevel+1)
if nextcfglvl then
nextSkillInfo=nextcfglvl.attrs
end
local transTable=function(list)
local temp={}
if list then
for index,data in ipairs(list)do
temp[data[1]]=data[2]
end
end
return temp
end
local attrInfoList={}
local curAttrLookup=transTable(curSkillInfo)
local nextAttrLookup=transTable(nextSkillInfo or curSkillInfo)
for index,atype in ipairs(attrTypeList)do
local temp={}
temp.attrId=atype
temp.attrVal=attrLookup[atype]
temp.isAdd=nextAttrLookup[atype]~=nil
if temp.isAdd then
temp.addVal=nextAttrLookup[atype]-curAttrLookup[atype]
end
if temp.addVal==0 then
temp.isAdd=false
end
attrInfoList[index]=temp
end
return attrInfoList
end

function UIDianFengZhiBaoWin:checkShengJiRed()
local dflevel=DianFengLevelModel:getLevel()
local nextcfglvl=cfg_dianfenglevelconfig_get(dflevel+1)
if nextcfglvl then
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local maxexp=cfglvl.exp
local exp=DianFengLevelModel:getExp()
if exp>=maxexp then
local widget=self.page:getChildWidgetBase()
widget:SetChildActive(2,true)
end
end
end


function UIDianFengZhiBaoWin:severfreshsj()
_this:freshShengJi()
_this:checkDianHuaRed()
end
function UIDianFengZhiBaoWin:severfreshdh(xgid)
_this:freshDianHua(false,true)
_this:setDianHuaEffect(xgid)
end
function UIDianFengZhiBaoWin:Resetseverfreshdh()
_this:ResetDianHuaEffect()
end


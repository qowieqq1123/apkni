







def_class("UIYuFuLingZhenWin",UIWindowBase)









function UIYuFuLingZhenWin:bindComponents()

self.gengHuanText=UIText.get(self,0)
self.jihuoText=UIText.get(self,1)
self.jiHuoActive=UIObject.get(self,2)
self.ctScrollViewA=UIObject.get(self,3)
self.ctScrollViewB=UIObject.get(self,4)
self.tzScrollView=UIObject.get(self,5)
self.yanJiuBtn=UIButton.get(self,6)
self.jiHuoBtn=UIButton.get(self,7)
self.gengHuanBtn=UIButton.get(self,8)
self.costScrollView=UIObject.get(self,9)
self.allAttrBtn=UIButton.get(self,10)
self.combineBtn=UIButton.get(self,11)
self.oneKeyXQBtn=UIButton.get(self,12)
self.oneKeyXXBtn=UIButton.get(self,13)
self.oneKeyHCBtn=UIButton.get(self,14)
self.attrScrollView=UIObject.get(self,15)
self.changeBtn=UIButton.get(self,16)
self.emptyAttr=UIText.get(self,17)
self.normal=UIObject.get(self,18)
self.unlock=UIObject.get(self,19)
self.yigenghuan=UIText.get(self,20)
self.attrPanel=UIObject.get(self,21)
self.btnPanel=UIObject.get(self,22)
self.lzbg=UIImage.get(self,23)
self.lzmodel=UIObject.get(self,24)
self.lzbgmask=UIImage.get(self,25)
self.title=UIText.get(self,26)
self.effect=UIObject.get(self,27)
self.lingzhen_2=UIObject.get(self,28)
self.lingzhen_3=UIObject.get(self,29)
self.lingzhen_4=UIObject.get(self,30)
self.lingzhen_5=UIObject.get(self,31)
self.lingzhen_6=UIObject.get(self,32)
self.lingzhen_1=UIObject.get(self,33)
self.diziAttr=UIObject.get(self,34)
self.attrGrid=UIObject.get(self,35)
self.hcreddot=UIObject.get(self,36)
self.lzgmbtn=UIButton.get(self,37)
self.gmline=UIObject.get(self,38)
self.gmqiu=UIObject.get(self,39)
self.gmtxt=UIText.get(self,40)
self.btnspine=UIObject.get(self,41)

self.yanJiuBtn:setButtonClick(function()self:onYanJiuBtn()end)

self.jiHuoBtn:setButtonClick(function()self:onJiHuoBtn()end)

self.gengHuanBtn:setButtonClick(function()self:onGengHuanBtn()end)

self.allAttrBtn:setButtonClick(function()self:onAllAttrBtn()end)

self.combineBtn:setButtonClick(function()self:onCombineBtn()end)

self.oneKeyXQBtn:setButtonClick(function()self:onOneKeyXQBtn()end)

self.oneKeyXXBtn:setButtonClick(function()self:onOneKeyXXBtn()end)

self.oneKeyHCBtn:setButtonClick(function()self:onOneKeyHCBtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.lzgmbtn:setButtonClick(function()self:onLzgmbtn()end)
self.lingzhen={
self.lingzhen_1,
self.lingzhen_2,
self.lingzhen_3,
self.lingzhen_4,
self.lingzhen_5,
self.lingzhen_6,
}



end


function UIYuFuLingZhenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gengHuanText);self.gengHuanText=nil;
_UIObject_release(self.jihuoText);self.jihuoText=nil;
_UIObject_release(self.jiHuoActive);self.jiHuoActive=nil;
_UIObject_release(self.ctScrollViewA);self.ctScrollViewA=nil;
_UIObject_release(self.ctScrollViewB);self.ctScrollViewB=nil;
_UIObject_release(self.tzScrollView);self.tzScrollView=nil;
_UIObject_release(self.yanJiuBtn);self.yanJiuBtn=nil;
_UIObject_release(self.jiHuoBtn);self.jiHuoBtn=nil;
_UIObject_release(self.gengHuanBtn);self.gengHuanBtn=nil;
_UIObject_release(self.costScrollView);self.costScrollView=nil;
_UIObject_release(self.allAttrBtn);self.allAttrBtn=nil;
_UIObject_release(self.combineBtn);self.combineBtn=nil;
_UIObject_release(self.oneKeyXQBtn);self.oneKeyXQBtn=nil;
_UIObject_release(self.oneKeyXXBtn);self.oneKeyXXBtn=nil;
_UIObject_release(self.oneKeyHCBtn);self.oneKeyHCBtn=nil;
_UIObject_release(self.attrScrollView);self.attrScrollView=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.emptyAttr);self.emptyAttr=nil;
_UIObject_release(self.normal);self.normal=nil;
_UIObject_release(self.unlock);self.unlock=nil;
_UIObject_release(self.yigenghuan);self.yigenghuan=nil;
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.btnPanel);self.btnPanel=nil;
_UIObject_release(self.lzbg);self.lzbg=nil;
_UIObject_release(self.lzmodel);self.lzmodel=nil;
_UIObject_release(self.lzbgmask);self.lzbgmask=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.lingzhen_2);self.lingzhen_2=nil;
_UIObject_release(self.lingzhen_3);self.lingzhen_3=nil;
_UIObject_release(self.lingzhen_4);self.lingzhen_4=nil;
_UIObject_release(self.lingzhen_5);self.lingzhen_5=nil;
_UIObject_release(self.lingzhen_6);self.lingzhen_6=nil;
_UIObject_release(self.lingzhen_1);self.lingzhen_1=nil;
_UIObject_release(self.diziAttr);self.diziAttr=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.hcreddot);self.hcreddot=nil;
_UIObject_release(self.lzgmbtn);self.lzgmbtn=nil;
_UIObject_release(self.gmline);self.gmline=nil;
_UIObject_release(self.gmqiu);self.gmqiu=nil;
_UIObject_release(self.gmtxt);self.gmtxt=nil;
_UIObject_release(self.btnspine);self.btnspine=nil;
self.lingzhen=nil;
end
















local _zt_attr_index={
icon=0,
title=1,
lock=2,
lock_tips=3,
attrs1={4,6,5,7},
attrs2={4,5,6,7},
fill=8,
pass=9,
}

local _lz_xq_index={
click=0,
add_icon=1,
icon=2,
suo=3,
tips=4,
pingzhi=5,
reddot=6,
lv=7,
lvText=8,
}




function UIYuFuLingZhenWin:onLoaded(...)
self:bindComponents()

self.colorTexts={'绿品','蓝品','紫品','橙品','红品'}
self.unlockTexts={'绿品解锁','蓝品解锁','紫品解锁','橙品解锁','红品解锁'}
self.alphaWidget={}
self.tzScrollView:setChildScrollViewInit(0.5,true,function(...)self:onZhenTuSelect(...)end,nil)
self.ctScrollViewA:setChildScrollViewInit(0.5,true,nil,nil)
self.ctScrollViewB:setChildScrollViewInit(0.5,true,nil,nil)
self.costScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.attrScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end

function UIYuFuLingZhenWin:onZhenTuSelect(num,index)
if self.selectIndex then
local widget=self.tzScrollView:getChildScrollViewItemWidget(self.selectIndex)
widget:SetChildActive(3,false)
end

self.selectIndex=index

local widget=self.tzScrollView:getChildScrollViewItemWidget(self.selectIndex)
widget:SetChildActive(3,true)

self:showUnlockAttr()
self:setLingzhen()
end


function UIYuFuLingZhenWin:__delete()
self:unbindComponents()
if self.hideMoney then
UIManager:showWindow("UITopMoneyWin")
end
end




function UIYuFuLingZhenWin:onShow(argtable,afterOnloaded)
if argtable then
self.firstOpen=true
end
self.yfId=argtable.itemId
self.yfGuid=argtable.itemGuid
self.lzData=UIYuFuLingZhenControl:getLingZhenData(self.yfGuid)

local moneyBar=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"moneyBar")
if moneyBar then

self:showWindow('UITopMoneyWin5',moneyBar)
if UIManager:isActive("UITopMoneyWin")then
UIManager:hideWindow("UITopMoneyWin")
self.hideMoney=true
end
end

self:refresh()
local yfcfg=itemsConfig.getConfig(self.yfId)
self.title:setText(FMT.fmt('<color={2}>{0}·{1}</color>',self.colorTexts[yfcfg.color],yfcfg.name,FONT_COLOR_VAL[yfcfg.color]))
end

function UIYuFuLingZhenWin:refresh(anim)

if self.lzData and self.lzData.zhentuId>0 then
self:showNormalPanel(anim)
else
self:showUnlockPanel()
end
end

function UIYuFuLingZhenWin:refreshlzData()
self.lzData=UIYuFuLingZhenControl:getLingZhenData(self.yfGuid)

end

function UIYuFuLingZhenWin:setlzDataConvert(kongIndex,dstItemId)
self.lzData=UIYuFuLingZhenControl:getLingZhenData(self.yfGuid)
if kongIndex>0 and kongIndex<6 then
self.lzData.kongList[kongIndex]["itemId"]=dstItemId
end
end


function UIYuFuLingZhenWin:activeLzData()
self.effect:setChildShowEffect(20200,true)
self:refreshlzData()
self:refresh(true)
end

function UIYuFuLingZhenWin:showNormalPanel(anim)
self.page=1
self.normal:setActive(true)
self.unlock:setActive(false)
self:showCurrAttr()
self:setLingzhen(self.lzData.zhentuId,anim)
self:showTotalAttrList()

self.attrPanel:setActive(true)
self.btnPanel:setActive(false)
self.yigenghuan:setActive(false)

end

function UIYuFuLingZhenWin:showUnlockPanel()
self.page=2
self.normal:setActive(false)
self.unlock:setActive(true)
self:showUnlockPage()
self:onZhenTuSelect(0,0)

self.attrPanel:setActive(false)
self.btnPanel:setActive(true)



end


function UIYuFuLingZhenWin:onHide()

end

function UIYuFuLingZhenWin:setAttrItem(item,data,yfcfg)
local unlock=yfcfg.color>=data[1]
item:SetChildActive(_zt_attr_index.lock,not unlock)
if unlock then
item:SetChildText(_zt_attr_index.lock_tips,'')
else
item:SetChildText(_zt_attr_index.lock_tips,self.unlockTexts[data[1]])
end


local attrList=data[4]
local widgetIdx={{4,5},{6,7}}
local len=#attrList

for i,attr in ipairs(attrList)do
local stype=attr[1]
if stype==2 then
self:setAttrText(item,widgetIdx[i][1],stype,attr[2][1])
self:setAttrText(item,widgetIdx[i][2],stype,attr[2][2])
if len==1 and i==1 then
self:setAttrText(item,widgetIdx[i+1][1],stype,attr[2][3])
self:setAttrText(item,widgetIdx[i+1][2],stype,attr[2][4])
end
elseif stype==1 then
self:setAttrText(item,widgetIdx[i][1],stype,attr)
self:setAttrText(item,widgetIdx[i][2],stype,nil)
end
end
















end

function UIYuFuLingZhenWin:showCurrAttr()
local cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,self.lzData.zhentuId)
local yfcfg=itemsConfig.getConfig(self.yfId)
local typeLevelDatas=UIYuFuLingZhenControl:countTypeLevels(self.lzData)
local attrs=cfg.attr
local len=#attrs
self.ctScrollViewA:setChildScrollViewCreateGrids(len,0)
local grids=self.ctScrollViewA:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=attrs[i]
self:setAttrItem(item,data,yfcfg)
local curr=typeLevelDatas[data[2]]or 0
local max=data[3]
local unlock=yfcfg.color>=data[1]
local fill=unlock and curr/max or 0
item:SetChildIconFillAmount(_zt_attr_index.fill,fill)
item:SetChildActive(_zt_attr_index.pass,false)

local pr=UIYuFuLingZhenControl:getPrefixName(data[2])
if not unlock then
local tips=self.unlockTexts[data[1]]
item:SetChildText(_zt_attr_index.title,FMT.fmt('{0}灵阵总等级{1}级激活(<color=#c82c2c>{2}</color>)',pr,data[3],tips))
else
if curr>=max then
local title=FMT.fmt('{0}灵阵总等级{1}级激活（<color=#bf723c>{2}/{3}</color>）',pr,data[3],curr,max)
item:SetChildText(_zt_attr_index.title,title)
else
local title=FMT.fmt('{0}灵阵总等级{1}级激活（{2}/{3}）',pr,data[3],curr,max)
item:SetChildText(_zt_attr_index.title,title)
end
end



local icon=UIYuFuLingZhenControl:getZYIconName(data[2])
item:SetChildCSImageSprite(_zt_attr_index.icon,globalABLookup.yufulingzhen,icon)
end

self:refreshgmNum()
end

function UIYuFuLingZhenWin:showUnlockPage()
local cfgs=cfg_yufuzhentuconfig()
local zhentuList=itemsConfig.getConfig(self.yfId).zhentuList
local t={}
for i,v in ipairs(zhentuList)do
table.insert(t,cfgs[v])
end
self.unlockDatas=t
local len=#t

self.tzScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.tzScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local cfg=t[i]
local isActive=UIYuFuLingZhenControl:isZhenTuActive(cfg.id)
local abName,imgName=UIYuFuLingZhenControl:getImageName(cfg.id,isActive)
item:SetChildCSImageSprite(1,abName,imgName)

item:SetChildText(2,cfg.name)
item:SetChildActive(3,false)


item:SetChildActive(4,UIYuFuLingZhenControl:isZhenTuCanActive(cfg.id))
end
end

function UIYuFuLingZhenWin:showUnlockAttr()
local cfg=self.unlockDatas[self.selectIndex+1]
local yfcfg=itemsConfig.getConfig(self.yfId)
local attrs=cfg.attr
local len=#attrs
self.ctScrollViewB:setChildScrollViewCreateGrids(len,0)
local grids=self.ctScrollViewB:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=attrs[i]
local pr=UIYuFuLingZhenControl:getPrefixName(data[2])
local unlock=yfcfg.color>=data[1]
local title
if unlock then
title=FMT.fmt('{0}灵阵总等级{1}级激活',pr,data[3])
else
local tips=self.unlockTexts[data[1]]
title=FMT.fmt('{0}灵阵总等级{1}级激活(<color=#c82c2c>{2}</color>)',pr,data[3],tips)
end
item:SetChildText(_zt_attr_index.title,title)
local icon=UIYuFuLingZhenControl:getZYIconName(data[2])
item:SetChildCSImageSprite(_zt_attr_index.icon,globalABLookup.yufulingzhen,icon)
item:SetChildIconFillAmount(_zt_attr_index.fill,0)
self:setAttrItem(item,data,yfcfg)
end

local checkR=UIYuFuLingZhenControl:isZhenTuResearched(cfg.id)
local isActive=UIYuFuLingZhenControl:isZhenTuActive(cfg.id)
local check1=(not isActive)
local isUse=(self.lzData~=nil and self.lzData.zhentuId==cfg.id)
local text=(self.lzData~=nil and self.lzData.zhentuId~=nil)and"更换阵图"or"激活阵图"
self.jihuoText:setText(text)
self.gengHuanText:setText(text)

local check2=isActive and not isUse
local check3=check1 or check2 or not checkR
self.yigenghuan:setActive(isUse)

self.btnPanel:setActive(check3)
if check3 then
if checkR then
self.yanJiuBtn:setActive(false)
self.jiHuoBtn:setActive(check1)
self.jiHuoActive:setActive(UIYuFuLingZhenControl:isZhenTuCanActive(cfg.id)and not check2)
if check1 then
self:setCost(cfg.jhItems)
end
self.gengHuanBtn:setActive(check2)
if check2 then
self:setCost(cfg.ghItems)
end

else
self.yanJiuBtn:setActive(true)
self.jiHuoBtn:setActive(false)
self.gengHuanBtn:setActive(false)
end
end
end

function UIYuFuLingZhenWin:setAttrText(item,index,stype,attr)
if attr then
item:SetChildActive(index,true)













if stype==2 then
local name,str=equipsHelper.getAttr(attr[1],attr[2])
item:SetChildText(index,FMT.fmt('{0}+{1}',name,str))
elseif stype==1 then
item:SetChildText(index,FMT.fmt('该阵图中{0}灵阵的总属性+{1}%',attr[2]==0 and'所有'or UIYuFuLingZhenControl:getPrefixName(attr[2]),attr[3]*100))
end
else
item:SetChildActive(index,false)
end
end

function UIYuFuLingZhenWin:setCost(costList)
local len=#costList
self.costScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.costScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=costList[i]
widgetHelper.setNormalRewardItem(item,0,{data[1],data[2],checkAmount=true})
end
end

function UIYuFuLingZhenWin:isLingZhenEnough()
if self.lzData and self.lzData.kongList then
for i=1,5 do
if not self.lzData.kongList[i]then
return false
end
end
return true
end
return false
end

function UIYuFuLingZhenWin:isLingZhenEmpty()
if self.lzData and self.lzData.kongList then
for i=1,5 do
if self.lzData.kongList[i]then
return false
end
end
return true
end
return true
end

local effectList=
{
[1]={20228,20229},[2]={20230,20231},[3]={20232,20233},[4]={20226,20227},[5]={20234,20235},[6]={20223,20224,20225},
}
function UIYuFuLingZhenWin:setLingzhen(lzId,anim)
local cfg
if lzId then
cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,lzId)
else
local index=self.selectIndex+1
cfg=self.unlockDatas[index]
end
local isActive=UIYuFuLingZhenControl:isZhenTuActive(cfg.id)
local isEnough1=self:isLingZhenEnough()

local heChengList=UIYuFuLingZhenControl:getEquipHeChengSlot(self.yfGuid)
local attr=cfg.attr
local tuijianIdx=attr[1][2]

if anim then
if isActive then
self.lzmodel:setActive(false)
self.lzbg:setActive(true)
local abName,imgName=UIYuFuLingZhenControl:getImageName(cfg.id,false)
self.lzbg:setSprite(abName,imgName)
abName,imgName=UIYuFuLingZhenControl:getImageName(cfg.id,false)
self.lzbgmask:setSprite(abName,imgName)
self.winid:SetDissolveFactor(self.lzbgmask:getID(),0)
self.tweenerVal=0
self.tweeners=_DOTweenProxy.DoValueTo(
function()
return self.tweenerVal or 0
end,
function(val)
self.tweenerVal=val
self.winid:SetDissolveFactor(self.lzbgmask:getID(),val)
end,
1,1)
self:delayDo(1,function()
if isEnough1 then
self.lzmodel:setActive(true)
self.lzbg:setActive(false)
local sp=UIYuFuLingZhenControl:getSpine(cfg.id)
self.lzmodel:setChildUIModelShowTarget(sp[1],sp[2],{},eAnimationID.stand,false,false,0,nil)
end
end)
else
self.lzmodel:setActive(isActive and isEnough1)
self.lzbg:setActive((not isActive)or(not isEnough1))
local abName,imgName=UIYuFuLingZhenControl:getImageName(cfg.id,false)
self.lzbg:setSprite(abName,imgName)
self.lzbgmask:setSprite(abName,imgName)
self.winid:SetDissolveFactor(self.lzbgmask:getID(),1)
end
else
self.lzmodel:setActive(isActive and isEnough1)
self.lzbg:setActive((not isActive)or(not isEnough1))
if isActive and isEnough1 then
local sp=UIYuFuLingZhenControl:getSpine(cfg.id)
self.lzmodel:setChildUIModelShowTarget(sp[1],sp[2],{},eAnimationID.stand,false,false,0,nil)
else
local abName,imgName=UIYuFuLingZhenControl:getImageName(cfg.id,false)
self.lzbg:setSprite(abName,imgName)
self.lzbgmask:setSprite(abName,imgName)
self.winid:SetDissolveFactor(self.lzbgmask:getID(),1)
end
end


local posList=cfg.poslist
local normalState=self.page==1
local isUse=self.lzData~=nil and self.lzData.zhentuId==cfg.id
local yfcfg=itemsConfig.getConfig(self.yfId)
local isEnough=nil
if self.firstOpen then
isEnough=isEnough1
end

for i,v in ipairs(self.lingzhen)do
local widget=v:getWidgetBase()
local pos=posList[i]
widget:SetChildLocalPos(-1,pos[1],pos[2],0)
local check=cfg.unlock[i]
local unlock=true

if check then
if i==6 then
local level=self.lzData and UIYuFuLingZhenControl:countTotalLevel(self.lzData)or 0
unlock=level>=check
else
unlock=yfcfg.color>=check
end

end

if unlock then
if isUse then
local kdata=self.lzData and self.lzData.kongList[i]
local shwoIcon=kdata~=nil
widget:SetChildActive(_lz_xq_index.pingzhi,shwoIcon)
widget:SetChildActive(_lz_xq_index.add_icon,normalState and not shwoIcon)
widget:SetChildActive(_lz_xq_index.icon,shwoIcon)
widget:SetChildActive(_lz_xq_index.suo,false)
widget:SetChildActive(_lz_xq_index.lv,shwoIcon)

if shwoIcon then
local itemCfg=itemsConfig.getConfig(kdata.itemId)
local color=UIYuFuLingZhenControl:getItemColorById(kdata.itemId,kdata.itemguid)
local pz=UIYuFuLingZhenControl:getPZIconName(color)
widget:SetChildCSImageSprite(_lz_xq_index.pingzhi,globalABLookup.yufulingzhen,pz)
local icon=UIYuFuLingZhenControl:getLZIconName(itemCfg)

widget:SetChildIcon(_lz_xq_index.icon,icon,true)

local lv=UIYuFuLingZhenControl:getItemLevel(kdata.itemId)
widget:SetChildText(_lz_xq_index.lvText,lv)

local convertCfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"convert")
local lv_limit=convertCfg[2]
if itemCfg.type1<6 and lv>=lv_limit then
widget:SetChildActive(_lz_xq_index.reddot,UIYuFuLingZhenControl:checkZhuanHuanLZReddot()or(self.page==1 and heChengList[i]~=nil))
end
if itemCfg.type1==6 then
if lv<=3 then
widget:SetChildShowEffect(10,effectList[6][1],true)
elseif lv>=7 then
widget:SetChildShowEffect(10,effectList[6][3],true)
else
widget:SetChildShowEffect(10,effectList[6][2],true)
end
else
if lv<=5 then
widget:SetChildShowEffect(10,effectList[itemCfg.type1][1],true)
else
widget:SetChildShowEffect(10,effectList[itemCfg.type1][2],true)
end
end

else
widget:SetChildText(_lz_xq_index.tips,'')

widget:SetChildShowEffect(10,0,false)
end

if isEnough then



end



else
widget:SetChildActive(_lz_xq_index.pingzhi,false)
widget:SetChildActive(_lz_xq_index.add_icon,false)
widget:SetChildActive(_lz_xq_index.icon,false)
widget:SetChildActive(_lz_xq_index.suo,false)
widget:SetChildText(_lz_xq_index.tips,'')
widget:SetChildActive(_lz_xq_index.lv,false)
widget:SetChildShowEffect(10,0,false)
end
widget:SetChildButtonClick(_lz_xq_index.click,function()





if normalState then
local kdata=self.lzData and self.lzData.kongList[i]
if kdata then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eYFLZMain,itemid=kdata.itemId,itemguid=kdata.itemguid,move=TIPS_MOVE_POS.eRight,attach={yfguid=self.yfGuid,kongIndex=i}})
else

UIManager:showWindow('UIYFLZSelectWin',{index=i,yfGuid=self.yfGuid,tuijianIdx=tuijianIdx})
end


end
end)


else
widget:SetChildShowEffect(10,0,false)
widget:SetChildActive(_lz_xq_index.pingzhi,false)
widget:SetChildActive(_lz_xq_index.add_icon,false)
widget:SetChildActive(_lz_xq_index.icon,false)
widget:SetChildActive(_lz_xq_index.suo,true)
widget:SetChildActive(_lz_xq_index.lv,false)
local txt
if i==6 then
txt=FMT.fmt('灵阵总级{0}级',check)
else
txt=FMT.fmt('<color={0}>{1}</color>',FONT_COLOR_VAL[check],self.unlockTexts[check])
end
widget:SetChildText(_lz_xq_index.tips,txt)
widget:SetChildButtonClick(_lz_xq_index.click,function()
if i==6 then
UIManager.info(FMT.fmt('灵阵总级{0}级开启',check))
else
UIManager.info(FMT.fmt('玉符{0}品质开启',eQualityColorName[check]))
end

end)
end
end

self.hcreddot:setActive(next(heChengList)~=nil)

local empty=self:isLingZhenEmpty()
self.oneKeyXQBtn:setActive(empty)
self.oneKeyXXBtn:setActive(not empty)

self.firstOpen=nil
end

function UIYuFuLingZhenWin:playSlotEffect(indexList)
for i,v in ipairs(self.lingzhen)do
local widget=v:getWidgetBase()
if indexList[i]then
widget:SetChildShowEffect(9,10219,true)
end
end
end

function UIYuFuLingZhenWin:showTotalAttrList()
local attrDatas,diziAttrList=UIYuFuLingZhenControl:countAllAttr(self.yfId,self.yfGuid)
local list={}
for k,v in pairs(attrDatas)do
table.insert(list,{k,v})
end

local len=#list
self.attrGrid:setChildLayoutGroupCreateItems(len)
local grids=self.attrGrid:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local attr=list[i]

if i<=len then
local name,str=equipsHelper.getAttr(attr[1],attr[2])
item:SetChildText(0,name)
item:SetChildText(1,str)
end
end

self.emptyAttr:setActive(len==0)
self.isEmptyAttr=len==0








end




function UIYuFuLingZhenWin:onYanJiuBtn()
local cfg=self.unlockDatas[self.selectIndex+1]
jumpManager:jump({id=1001,args={type=SLG_SYSTEM_TYPE.eTianGongGe,args={tzId=cfg.id},tabType=FULL_TAB_TYPE.eZhenTuYanJiu}})
end

function UIYuFuLingZhenWin:onJiHuoBtn()

local dzId=UIFuLuFangModel:getDzGuidByItemGuid(self.yfGuid)
local cfg=self.unlockDatas[self.selectIndex+1]
if cfg.jhItems then
for i,v in ipairs(cfg.jhItems)do
local have=itemsModel.getCount(v[1])
if have<v[2]then
local err=FMT.fmt('{0}不足',itemsConfig.getItemName(v[1]))
UIManager.error(err)
gainControl:showGainWin(v[1])
return
end
end
end

local time=timeHelper.getServerShortTime()
if self.jiHuoStamp then
if time-self.jiHuoStamp<=3 then
return
end
end
self.jiHuoStamp=time

UIYuFuLingZhenControl:reqActiveZhenTU(dzId,self.yfGuid,cfg.id)

end

function UIYuFuLingZhenWin:onGengHuanBtn()
local cfg=self.unlockDatas[self.selectIndex+1]
if cfg.ghItems then
for i,v in ipairs(cfg.ghItems)do
local have=itemsModel.getCount(v[1])
if have<v[2]then
local err=FMT.fmt('{0}不足',itemsConfig.getItemName(v[1]))
UIManager.error(err)
gainControl:showGainWin(v[1])
return
end
end
end

local dzId=UIFuLuFangModel:getDzGuidByItemGuid(self.yfGuid)
local cfg=self.unlockDatas[self.selectIndex+1]

local time=timeHelper.getServerShortTime()
if self.jiHuoStamp then
if time-self.jiHuoStamp<=3 then
return
end
end
self.jiHuoStamp=time

UIYuFuLingZhenControl:reqReplaceZhenTU(dzId,self.yfGuid,cfg.id)
end

function UIYuFuLingZhenWin:onCombineBtn()
UIYuFuLingZhenControl:showCombineWin()
end

function UIYuFuLingZhenWin:onChangeBtn()
self.needBack=true
self:showUnlockPanel()
self:showUnlockAttr()
end

function UIYuFuLingZhenWin:onCombineBtn()
UIManager:showWindow('UIYFLZCombineWin',{itemId=self.yfId,itemGuid=self.yfGuid})
end

function UIYuFuLingZhenWin:onOneKeyXQBtn()
local now=timeHelper.getServerShortTime()
if self.reqXQStamp and now<self.reqXQStamp+1 then
UIManager.error("您点击的太快了")
return
end

local ztId=self.lzData.zhentuId
local cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,ztId)
local yfcfg=itemsConfig.getConfig(self.yfId)
local nlist={}
for i,v in ipairs(cfg.attr)do
if yfcfg.color>=v[1]then
nlist[v[2]]=v[3]
end
end
local unlock=cfg.unlock
local needXC=not self.lzData.kongList[6]

local level=self.lzData and UIYuFuLingZhenControl:countTotalLevel(self.lzData)or 0






local clist={}
local items=lingzhenBagModel:getBagItems()
for i,v in ipairs(items)do
local itemcfg=itemsConfig.getConfig(v.itemid)
if(itemcfg.type1==6 and needXC)or itemcfg.type1~=6 then
table.insert(clist,{item=v,config=itemcfg,isP=nlist[itemcfg.type1]~=nil and 1 or 0,})

end
end
table.sort(clist,function(a,b)
if a.isP>b.isP then
return true
elseif a.isP<b.isP then
return false
end
return UIYuFuLingZhenControl:getItemLevel(a.item.itemid)>UIYuFuLingZhenControl:getItemLevel(b.item.itemid)
end)


local kwlist={}
for i=1,5 do
if(not unlock[i]or yfcfg.color>=unlock[i])and not self.lzData.kongList[i]then
kwlist[i]=true
end
end
local fcheck=false
local xqlist={}
local typelevelDatas=UIYuFuLingZhenControl:countTypeLevels(self.lzData)

for i,v in ipairs(clist)do
local item=v.item
local itemcfg=v.config
local ztype=itemcfg.type1

if ztype==6 then
if needXC then
xqlist[6]=item
needXC=false
end
else
local count=item.itemcount

for ii=1,count do
local k,w=next(kwlist)
if k then
xqlist[k]=item
kwlist[k]=nil
else
fcheck=true
end
end

end
if fcheck and not needXC then
break
end
end

local total=0

local slist={}
for k,v in pairs(xqlist)do
if k~=6 then
total=total+UIYuFuLingZhenControl:getItemLevel(v.itemid)
table.insert(slist,{v.itemguid,k})
end

end

if xqlist[6]and total+level>=unlock[6]then
table.insert(slist,{xqlist[6].itemguid,6})
end

if#slist==0 then
return
end
local dzId=UIFuLuFangModel:getDzGuidByItemGuid(self.yfGuid)
UIYuFuLingZhenControl:reqLZXiangQian(dzId,self.yfGuid,#slist,slist)

self.reqXQStamp=timeHelper.getServerShortTime()
end

function UIYuFuLingZhenWin:onOneKeyXXBtn()
local now=timeHelper.getServerShortTime()
if self.reqXQStamp and now<self.reqXQStamp+1 then
UIManager.error("您点击的太快了")
return
end

local dzId=UIFuLuFangModel:getDzGuidByItemGuid(self.yfGuid)
local list={}
for k,v in pairs(self.lzData.kongList)do
table.insert(list,v.index)
end
UIYuFuLingZhenControl:reqLZXieXia(dzId,self.yfGuid,#list,list)
self.reqXQStamp=timeHelper.getServerShortTime()
end

function UIYuFuLingZhenWin:onBackBtn()
if self.needBack then
self:showNormalPanel()
self.needBack=false
else
self:onCloseClick()
end
end

function UIYuFuLingZhenWin:onCloseClick()
self:closeSelf()
end

function UIYuFuLingZhenWin:onAllAttrBtn()
if self.isEmptyAttr then
UIManager.error("未布置阵图")
return
end
local args={}
args.titleName='详细属性'
args.pos=1
args.extraWin='UILingZhenAttrDetailWin'
local extraParams={yfGuid=self.yfGuid,yfId=self.yfId}
args.extraParams=extraParams
self:showWindow('UICommonPageWin',args)

end

function UIYuFuLingZhenWin:onOneKeyHCBtn()
UIYuFuLingZhenControl.req_2_108(self.yfGuid,nil,true)
end




function UIYuFuLingZhenWin:onLzgmbtn()
local cur,max=LingZhenChongZhuModel:getjihuonum(self.lzData,self.yfId)
local yfcfg=itemsConfig.getConfig(self.yfId)
local cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,self.lzData.zhentuId)
local alllevel=0
for i=1,5 do
local unlock=true
local check=cfg.unlock[i]
if check then
unlock=yfcfg.color>=check
end
if check and i==6 then
local level=self.lzData and UIYuFuLingZhenControl:countTotalLevel(self.lzData)or 0
unlock=check<level
end
local isUse=self.lzData~=nil and self.lzData.zhentuId==cfg.id
if unlock then
if isUse then
local kdata=self.lzData.kongList[i]
if kdata then
alllevel=alllevel+UIYuFuLingZhenControl:getItemLevel(kdata.itemId)
end
end
end
end
UIManager:showWindow("UILZGMTipsWin",{cur,max,alllevel,self.lzData})
end

function UIYuFuLingZhenWin:refreshgmNum()
local cur,max=LingZhenChongZhuModel:getjihuonum(self.lzData,self.yfId)
self.gmtxt:setText(FMT.fmt("{0}/{1}",cur,max))


local starnum=0
for i=1,5 do




if i<=cur then




starnum=starnum+1
end
end
local actionid=eAnimationID.stand
if starnum>0 and actionid<=5 then
actionid=2907+starnum
end
self.btnspine:setChildUIModelShowTarget(5705,1,nil,actionid)
end

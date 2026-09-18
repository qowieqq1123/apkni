







def_class("UIGuBaoLianHuaWin",UIWindowBase)









function UIGuBaoLianHuaWin:bindComponents()

self.gbIcon=UIImage.get(self,0)
self.gbName=UIText.get(self,1)
self.costIcon=UIImage.get(self,2)
self.costNum=UIText.get(self,3)
self.levelTxt=UIText.get(self,4)
self.addexpTxt=UIText.get(self,5)
self.levelProgress=UIObject.get(self,6)
self.attrGrid=UIObject.get(self,7)
self.selectGrid=UIObject.get(self,8)
self.colorDropdown=UIDropdown.get(self,9)
self.elementDropdown=UIDropdown.get(self,10)
self.tipstxt=UIText.get(self,11)
self.btnsObj=UIObject.get(self,12)
self.tipsNextTxt=UIText.get(self,13)
self.levelProgressText=UIText.get(self,14)
self.effectRoot=UIObject.get(self,15)
self.effect1=UIObject.get(self,16)
self.effect2=UIObject.get(self,17)
self.effect3=UIObject.get(self,18)
self.effect4=UIObject.get(self,19)
self.effect5=UIObject.get(self,20)
self.effect0=UIObject.get(self,21)
self.effect=UIObject.get(self,22)
self.levelProgressGreen=UIObject.get(self,23)
self.leftBtn=UIButton.get(self,24)
self.rightBtn=UIButton.get(self,25)
self.root=UIObject.get(self,26)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)



end


function UIGuBaoLianHuaWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gbIcon);self.gbIcon=nil;
_UIObject_release(self.gbName);self.gbName=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.levelTxt);self.levelTxt=nil;
_UIObject_release(self.addexpTxt);self.addexpTxt=nil;
_UIObject_release(self.levelProgress);self.levelProgress=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.selectGrid);self.selectGrid=nil;
_UIObject_release(self.colorDropdown);self.colorDropdown=nil;
_UIObject_release(self.elementDropdown);self.elementDropdown=nil;
_UIObject_release(self.tipstxt);self.tipstxt=nil;
_UIObject_release(self.btnsObj);self.btnsObj=nil;
_UIObject_release(self.tipsNextTxt);self.tipsNextTxt=nil;
_UIObject_release(self.levelProgressText);self.levelProgressText=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.effect4);self.effect4=nil;
_UIObject_release(self.effect5);self.effect5=nil;
_UIObject_release(self.effect0);self.effect0=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.levelProgressGreen);self.levelProgressGreen=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this=nil
local colorSavaKey='gubaolianhuaColor1'
local elementSavaKey='gubaolianhuaElement1'
local goodMax=5
local delayClick=0.5
local isCanClick=true


function UIGuBaoLianHuaWin:onLoaded(...)
self:bindComponents()
_this=self

self.colorSortTypeName={}
self.colorSortTypeName[1]='炼化道具'
for i=1,5 do
if i==1 then
table.insert(self.colorSortTypeName,FMT.fmt('{0}品材料',i))
else
table.insert(self.colorSortTypeName,FMT.fmt('{0}品以下材料',i))
end
end
self.elementSortTypeName={}
self.elementSortTypeName[1]='所有'
local elementlist=ELEMENT_TYPE:getFive()
for i,v in ipairs(elementlist)do
table.insert(self.elementSortTypeName,ELEMENT_TYPE.getName5(v))
end
self.colorDropdown:setChangeAction(function(...)self:onColorChange(...)end)
self.elementDropdown:setChangeAction(function(...)self:onElementChange(...)end)
end


function UIGuBaoLianHuaWin:__delete()
_this=nil
self:unbindComponents()
self:stopBehavior()
end


function UIGuBaoLianHuaWin:onHide()

end




function UIGuBaoLianHuaWin:onShow(argtable,afterOnloaded)
if argtable and argtable.gbid then
self.gbid=argtable.gbid
end
self.gubaoList=gubaoModel:getYetActiveList()
self.gbIndex=self:getIndexByGbid(self.gbid)

if gubaoModel:getYetGubaoIndex()>0 then
self.gbIndex=gubaoModel:getYetGubaoIndex()
self.gbid=self.gubaoList[self.gbIndex]
end






if#self.gubaoList>1 then
self:refreshCliskBtns(true)
else
self:refreshCliskBtns(false)
end

self.oldaddExp=0
self.addExp=0
self.colorSortType=userActorSetting.get(colorSavaKey,1)
self.colorDropdown:setOption(self.colorSortTypeName)
self.colorDropdown:setValue(self.colorSortType-1)
self.elementSortType=userActorSetting.get(elementSavaKey,1)
self.elementDropdown:setOption(self.elementSortTypeName)
self.elementDropdown:setValue(self.elementSortType-1)

self.goodlist={}

self:initView()
self:refreshView(true)
self:initItemList()
end

function UIGuBaoLianHuaWin:initView()
local gbid=self.gbid
local cfg=cfgHelper.get(cfg_gubaoconfig_get,gbid)


self.gbIcon:setImageIcon(gubaoModel:getGuBaoIconName(cfg.icon),true)


local name_str=cfg.name
self.gbName:setText(name_str)

local cost=gubaoModel:getLianHuaCostMoney()
self.costIcon:setImageIcon(moneyModel.getIconNameEx(cost[1]),true)

self:refreshBtns()
end

function UIGuBaoLianHuaWin:refreshCliskBtns(flag)
self.winlua:SetChildActive(self.leftBtn:getID(),flag)
self.winlua:SetChildActive(self.rightBtn:getID(),flag)
end

function UIGuBaoLianHuaWin:refreshData()
self.gubaoList=gubaoModel:getYetActiveList()
self.gbIndex=self:getIndexByGbid(self.gbid)
end

function UIGuBaoLianHuaWin:getIndexByGbid(gbid)
for k,v in ipairs(self.gubaoList)do
if v==gbid then
return k
end
end
return 0
end

function UIGuBaoLianHuaWin:onLeftBtn()
if _this.lockClick then return end
local index
if self.gbIndex-1<=0 then
index=#self.gubaoList
else
index=self.gbIndex-1
end

self.gbIndex=index
self.gbid=self.gubaoList[index]

self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),0,0.2)
self.winlua:SetChildDOLocalMoveX(self.root:getID(),100,0.2,function()
self.winlua:SetChildActive(self.root:getID(),false)
self.winlua:SetChildDOLocalMoveX(self.root:getID(),-100,0.1,function()
self.winlua:SetChildActive(self.root:getID(),true)
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.2)
self.winlua:SetChildDOLocalMoveX(self.root:getID(),0,0.2)
end)
end)

gubaoModel:setYetGubaoIndex(index)
self.oldaddExp=0
self.addExp=0
self.goodlist={}
self:initView()
self:refreshView(true)
self:initItemList()

oneTabScreenController:openUI(SEC_FULL_TYPE.gubaoSecondary,{gbid=self.gbid})
end

function UIGuBaoLianHuaWin:onRightBtn()
if _this.lockClick then return end
local index
if self.gbIndex+1>#self.gubaoList then
index=1
else
index=self.gbIndex+1
end

self.gbIndex=index
self.gbid=self.gubaoList[index]

self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),0,0.2)
self.winlua:SetChildDOLocalMoveX(self.root:getID(),-100,0.2,function()
self.winlua:SetChildActive(self.root:getID(),false)
self.winlua:SetChildDOLocalMoveX(self.root:getID(),100,0.1,function()
self.winlua:SetChildActive(self.root:getID(),true)
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.2)
self.winlua:SetChildDOLocalMoveX(self.root:getID(),0,0.2)
end)
end)

gubaoModel:setYetGubaoIndex(index)
self.oldaddExp=0
self.addExp=0
self.goodlist={}
self:initView()
self:refreshView(true)
self:initItemList()
oneTabScreenController:openUI(SEC_FULL_TYPE.gubaoSecondary,{gbid=self.gbid})
end

function UIGuBaoLianHuaWin:refreshBtns()
local gbid=self.gbid

local f=gubaoModel:checkFullLianHua(gbid)
local showBtns=not f
self.btnsObj:setActive(showBtns)
local nextTips=''
if not showBtns then
if not gubaoModel:checkFullLianHuaEx(gbid)then

local star=gubaoModel:getStar(gbid)
star=star+1
nextTips=FMT.fmt(cfgHelper.getlang('gubao_tips_2'),star)
end
end
self.tipsNextTxt:setText(nextTips)
end

function UIGuBaoLianHuaWin:refreshView(isInit)
local gbid=self.gbid

local cost=gubaoModel:getLianHuaCostMoney()
local need=math.ceil(self.addExp/cost[2])
local money_str=tostring(need)
self.needMoney={cost[1],need}
self.costNum:setText(money_str)

local addexp_str=''
if self.addExp>0 then
addexp_str='+'..self.addExp
end
self.addexpTxt:setText(addexp_str)


local gbData=gubaoModel:getDataByID(gbid)
local curlv=gbData.gubaolhlv
local curexp=gbData.gubaolhexp
local maxlv=gubaoModel:getLianHuaMax(gbid)
self.isfull=curlv>=maxlv
self.oldTempfull=self.tempfull
self.tempfull=self.isfull
self.curlv=curlv
self.curexp=curexp
local changlv=curlv
local changeexp=0
local add_lv=0
local add_rate=0
self.outexp=0
if self.addExp>0 then

changlv,changeexp=gubaoModel:changeAddExp(gbid,self.addExp)
add_lv=changlv-curlv
self.tempfull=changlv>=maxlv
if self.tempfull then
self.outexp=changeexp
add_rate=1
else
local maxexp=gubaoModel:getLianHuaUpExp(gbid,changlv)
add_rate=changeexp/maxexp
if add_rate>1 then add_rate=1 end
end
end
self.old_addlv=self.addlv or 0
self.addlv=add_lv
self.addRate=add_rate


local lv_str=FMT.fmt('当前：{0}级',curlv)
if add_lv>0 then
lv_str=FMT.fmt('{0}<color=#549327>(+{1})</color>',lv_str,add_lv)
end
self.levelTxt:setText(lv_str)

local progressStr
if self.isfull then
progressStr='已满级'
else
local cur,max
if self.addExp>0 then
cur=changeexp
max=gubaoModel:getLianHuaUpExp(gbid,changlv)
if self.tempfull then
max=gubaoModel:getLianHuaUpExp(gbid,changlv-1)
cur=cur+max
end
else
cur=curexp
max=gubaoModel:getLianHuaUpExp(gbid,curlv)
end
progressStr=FMT.fmt('{0}/{1}',cur,max)
end
self.levelProgressText:setText(progressStr)

local rate=1
if not self.isfull then
local maxexp=gubaoModel:getLianHuaUpExp(gbid,curlv)
rate=curexp/maxexp
if rate>1 then rate=1 end
end
self.curRate=rate
self.levelProgress:setChildIconFillAmount(rate)
if add_lv>0 then
self.levelProgress:setActive(false)
else
self.levelProgress:setActive(true)
end

self.tipstxt:setText(FMT.fmt(cfgHelper.getlang('gubao_tips_1'),maxlv))


local attrlist=gubaoModel:getBaseAttrList(gbid)
local attrnum=#attrlist
if isInit==true then
self.attrGrid:setChildLayoutGroupCreateItems(attrnum)
end
if add_lv>0 then

local changeAttrlist=gubaoModel:getBaseAttrListEx(gbid,changlv,gbData.gubaostar,gbData.gubaojxlv)
for i,v in ipairs(attrlist)do
local lerp=changeAttrlist[i][2]-v[2]
if lerp>0 then v[3]=lerp end
end
end
local attrGridList=self.attrGrid:getChildLayoutGroupGridList()
for i=1,attrnum do
local item=attrGridList[i-1]
local attr=attrlist[i]
local str=helper.getAttributeStr(attr[1],attr[2],nil,'<color=#7D3B17>{0}</color>：{1}')
item:SetChildText(0,str)
local showAdd=attr[3]~=nil
item:SetChildActive(1,showAdd)
if showAdd then
item:SetChildText(1,helper.getAttributeStrEx(attr[1],attr[3]))
end
end


self.levelProgressGreen:setActive(true)
if self.addExp>0 then
if self.oldaddExp<=0 then
self.levelProgressGreen:setChildIconFillAmount(rate)
end
local chang_addlv=self.addlv-self.old_addlv
self:refreshLevelProgressGreen(self.addRate,chang_addlv)
elseif self.oldaddExp>0 then
self:refreshLevelProgressGreen(rate,0-self.old_addlv)
else
self.levelProgressGreen:setChildIconFillAmount(rate)
end
end

function UIGuBaoLianHuaWin:refreshLevelProgressGreen(rate,chang_addlv)
local bFunc=function()
if _this==nil then return end
_this.lockClick=true
end
local eFunc=function()
if _this==nil then return end
_this.lockClick=nil
end
if self.tempfull==true then
if chang_addlv>0 then
chang_addlv=0
end
elseif self.oldTempfull==true then
if chang_addlv<0 then
chang_addlv=0
end
end
helper.playProgressAnim(self.levelProgressGreen,rate,chang_addlv,bFunc,eFunc,nil,0.8)
end

function UIGuBaoLianHuaWin:doLevelProgress(func)
if self.addExp>0 then
self.levelProgress:setActive(true)
self.levelProgressGreen:setActive(false)
local addlv=self.addlv
local rate=self.addRate
local bFunc=function()
if _this==nil then return end
_this.lockClick=true
end
local eFunc=function()
if _this==nil then return end
_this.lockClick=nil
if func then
func()
end
end
helper.playProgressAnim(self.levelProgress,rate,addlv,bFunc,eFunc,nil,0.8)
end
end

function UIGuBaoLianHuaWin:initItemList()
local selectGridList=self.selectGrid:getChildCommonLayoutGroupWidgetList()
for i=1,goodMax do
local item=selectGridList[i-1]
self:refreshItemView(item,i)
item:SetChildButtonClick(1,function()
local itemData=self.goodlist[i]
local hasGood=itemData~=nil
if hasGood then
self:onItemSubtract_all(i)
else
self:onItemAdd(i)
end
end)
item:SetChildButtonClick(2,function()
self:onItemSubtract(i)
end)
end
end

function UIGuBaoLianHuaWin:refreshItemView(item,idx)
local itemData=self.goodlist[idx]
local hasGood=itemData~=nil
item:SetChildActive(0,hasGood)
item:SetChildActive(1,not hasGood)
item:SetChildActive(2,hasGood)
if hasGood then
local itemid=itemData.item.itemid
local num_str=tostring(itemData.cnt)
local conf={itemid=itemid,itemcount=num_str,showname=false,itemIndex=idx,showCountBG=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local itemWidget=item:GetChildWidgetBase(0)
itemsComponentHelper.setUIBaseItemSmallSign(itemWidget,conf)
item:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
item:SetBaseItemLongTouchEvent(0,function(...)
self:onItemLongClick(...)
end)
end
end

function UIGuBaoLianHuaWin:onColorChange(idx)

idx=idx+1
self.colorSortType=idx
userActorSetting.flushVal(colorSavaKey,idx)
end

function UIGuBaoLianHuaWin:onElementChange(idx)

idx=idx+1
self.elementSortType=idx
userActorSetting.flushVal(elementSavaKey,idx)
end

function UIGuBaoLianHuaWin:onItemClick(itemid,index,guid,attach)
if self.lockClick then return end
self:onItemSubtract_all(index)

end

function UIGuBaoLianHuaWin:onItemLongClick(itemid,index,guid,attach)
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end

function UIGuBaoLianHuaWin:onGBClick()
tipsManager.showTipsGB({formType=TIPS_FORM_TYPE.eGubaoCheck,tipsType=TIPS_TYPE.eCommonGubao,itemid=self.gbid,bg=false})
end

function UIGuBaoLianHuaWin:onItemAdd(idx)
if self.lockClick then return end
self:openSelectWin()
end

function UIGuBaoLianHuaWin:openSelectWin()
local args={}
args.titleName='材料选择'
args.pos=1
args.extraWin='UIGuBaoLianHuaSelectWin'
local needexp=self:GetMaxLvNeedExp()
local extraParams={goodlist=self.goodlist,onAddBack=self.onAddBack_2,onSubtractBack=self.onSubtractBack,needExp=needexp}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIGuBaoLianHuaWin:onItemSubtract(idx)
if self.lockClick then return end
local itemData=self.goodlist[idx]
local cnt=itemData.cnt
cnt=cnt-1
itemData.cnt=cnt
if cnt>0 then
local item=self.selectGrid:getChildCommonLayoutGroupWidgetItem(idx-1)
self:refreshItemView(item,idx)
else
table.remove(self.goodlist,idx)
self:initItemList()
end
self.oldaddExp=self.addExp
self.addExp=gubaoModel:calculationLianHuaExp(self.goodlist)
self:refreshView()
end

function UIGuBaoLianHuaWin:onItemSubtract_all(idx)
if self.lockClick then return end
local itemData=self.goodlist[idx]
local cnt=itemData.cnt
cnt=0
itemData.cnt=cnt
if cnt>0 then
local item=self.selectGrid:getChildCommonLayoutGroupWidgetItem(idx-1)
self:refreshItemView(item,idx)
else
table.remove(self.goodlist,idx)
self:initItemList()
end
self.oldaddExp=self.addExp
self.addExp=gubaoModel:calculationLianHuaExp(self.goodlist)
self:refreshView()
end

function UIGuBaoLianHuaWin.onAddBack(idx,goodData,isNew)
if _this==nil then return nil end
if _this.lockClick then return end
if _this.tempfull then

UIManager.error(cfgHelper.getlang('gubao_tips_4'))
return false
end
if isNew then
if idx>=goodMax then

UIManager.error(cfgHelper.getlang('gubao_tips_6'))
return false
end
idx=idx+1
_this.goodlist[idx]={item=goodData,cnt=1}
else
local itemData=_this.goodlist[idx]
itemData.cnt=itemData.cnt+1
end
local item=_this.selectGrid:getChildCommonLayoutGroupWidgetItem(idx-1)
_this:refreshItemView(item,idx)

_this.addExp=gubaoModel:calculationLianHuaExp(_this.goodlist)

_this:refreshView()

return true
end

function UIGuBaoLianHuaWin.onAddBack_2(idx,goodData,isNew,num)
if _this==nil then return nil end
if _this.lockClick then return end
if _this.tempfull then

UIManager.error(cfgHelper.getlang('gubao_tips_4'))
return false
end
if isNew then
if idx>=goodMax then

UIManager.error(cfgHelper.getlang('gubao_tips_6'))
return false
end
idx=idx+1
_this.goodlist[idx]={item=goodData,cnt=num}
else
local itemData=_this.goodlist[idx]
itemData.cnt=num
end
local item=_this.selectGrid:getChildCommonLayoutGroupWidgetItem(idx-1)
_this:refreshItemView(item,idx)

_this.addExp=gubaoModel:calculationLianHuaExp(_this.goodlist)

_this:refreshView()

return true
end


function UIGuBaoLianHuaWin.onSubtractBack(idx)
if _this==nil then return nil end
if _this.lockClick then return end
_this:onItemSubtract(idx)
return true
end

function UIGuBaoLianHuaWin:onOneKeyBtn()
local gbid=self.gbid
local tempfull=self.isfull
if tempfull then

UIManager.error(cfgHelper.getlang('gubao_tips_4'))
return
end

local tempGoodlist,typo=self:calculationOneKey()
if typo==1 then
local cost=gubaoModel:getLianHuaCostMoney()
UIManager.error(FMT.fmt('{0}不足，不可炼化',moneyModel.getMoneyName(cost[1])))
gainControl:showGainWin(self.needMoney[1])
return
end
if#tempGoodlist<=0 then
local tipstr
if self.colorSortType==1 then

tipstr='暂无可放入的炼化道具'
else

tipstr='暂无可放入的炼化材料'
end
UIManager.error(tipstr)
return
end

self.goodlist=tempGoodlist
self.oldaddExp=self.addExp
self.addExp=gubaoModel:calculationLianHuaExp(self.goodlist)
self:initItemList()
self:refreshView()
end

function UIGuBaoLianHuaWin:calculationOneKey()
local tempGoodlist={}
local gbid=self.gbid
local gbData=gubaoModel:getDataByID(gbid)
local curlv=gbData.gubaolhlv
local curexp=gbData.gubaolhexp
local maxlv=gubaoModel:getLianHuaMax(gbid)
local sumexp=0

for lv=curlv,maxlv-1 do
local upexp=gubaoModel:getLianHuaUpExp(gbid,lv)
if upexp~=nil and upexp>0 then
sumexp=sumexp+upexp
end
end
if sumexp>0 then
sumexp=sumexp-curexp
end
local sumexp_res=sumexp
local fullCost=false

local cost=gubaoModel:getLianHuaCostMoney()
local curmoney=moneyModel.getMoney(cost[1])
if sumexp>0 then
local maxexp=math.ceil(curmoney*cost[2])
if sumexp>maxexp then
sumexp=maxexp
fullCost=true
end
end
local tempSelects={}
local tempSelectsLookup={}
local tempBags={}
local tempBags2={}

local baglist=gubaoLookup:getGoodsSortList2(self.colorSortType,1,self.elementSortType)
if#baglist>0 then
for i,v in ipairs(baglist)do
local itemData=v.item
local itemid=itemData.itemid
local itemcount=itemData.itemcount
local itemguid=itemData.itemguid
local cfg=itemsConfig.getConfig(itemid)
local score=cfg.gubaolianhua
local sum=score*itemcount
local itemguidStr=tostring(itemData.itemguid)
local d={item=itemData,score=score,use=itemcount,sum=sum,itemguidStr=itemguidStr}
table.insert(tempBags,d)
table.insert(tempBags2,d)
end
if#tempBags>1 then
table.sort(tempBags,function(a,b)
return a.sum<b.sum
end)
table.sort(tempBags2,function(a,b)
return a.score<b.score
end)
end
end
local sumexp_=sumexp
local idx=0

while sumexp>0 and#tempBags>0 do
local temp
for i=#tempBags,1,-1 do
local d=tempBags[i]
if d.use>0 then
if d.score<=sumexp then
local cnt
if d.sum<=sumexp then
cnt=d.use
else
cnt=math.floor(sumexp/d.score)
end
d.use=d.use-cnt
temp={item=d.item,itemguidStr=d.itemguidStr,cnt=cnt,score=d.score}
break
end
end
end
if temp~=nil then
idx=idx+1
sumexp=sumexp-temp.cnt*temp.score
table.insert(tempSelects,temp)
tempSelectsLookup[temp.itemguidStr]=temp
if idx>=goodMax then
break
end
else
break
end
end

if idx<goodMax and sumexp>0 and#tempBags2>0 and not fullCost then
for i=1,#tempBags2 do
local d=tempBags2[i]
if d.use>0 then
local addExp=sumexp_-sumexp+d.score
local needMoney=math.ceil(addExp/cost[2])
if needMoney<=curmoney then
local temp=tempSelectsLookup[d.itemguidStr]
if temp~=nil then
temp.cnt=temp.cnt+1
else
temp={item=d.item,itemguidStr=d.itemguidStr,cnt=1,score=d.score}
table.insert(tempSelects,temp)
tempSelectsLookup[temp.itemguidStr]=temp
end
end
break
end
end
end

if#tempSelects>0 then
for i,d in ipairs(tempSelects)do
tempGoodlist[i]={item=d.item,cnt=d.cnt}
end
end
local typo

if sumexp_res>0 and#baglist>0 and#tempGoodlist<=0 then
typo=1
end
return tempGoodlist,typo
end

function UIGuBaoLianHuaWin:onCommitBtn()
if self.isfull then

UIManager.error(cfgHelper.getlang('gubao_tips_4'))
return
end
if#self.goodlist<=0 then

UIManager.error(cfgHelper.getlang('gubao_tips_5'))
return
end

if not moneyModel.checkEnoughMoney(self.needMoney[1],self.needMoney[2])then
UIManager.error(FMT.fmt('{0}不足，不可炼化',moneyModel.getMoneyName(self.needMoney[1])))
gainControl:showGainWin(self.needMoney[1])
return
end

local list={}
for i,v in ipairs(self.goodlist)do
list[i]=v
end











gubaoController:reqLianHua(self.gbid,list)
end

function UIGuBaoLianHuaWin:rec_lianhua(gbid,oldlv,gubaolhlv)
if self.gbid~=gbid then return end

local str=FMT.fmt('经验+{0}',self.addExp)
commonTipsHelper.addThrowOutAndSliderTips(1,str)

local func=function()
if _this==nil then return end
_this:lianhuaRefresh()
end
self:doLevelProgress(func)

if oldlv~=gubaolhlv and self.outexp>0 then
self.winlua:SetChildShowEffect(self.effect:getID(),10060,true)
end
self.outexp=0
self:startBehavior()
self.goodlist={}
self:initItemList()
end

function UIGuBaoLianHuaWin:lianhuaRefresh()

self.oldaddExp=self.addExp
self.addExp=0
self.addlv=0
self:refreshBtns()
self:refreshView(true)

end


function UIGuBaoLianHuaWin:GetMaxLvNeedExp()
local gbid=self.gbid
local gbData=gubaoModel:getDataByID(gbid)
local curlv=gbData.gubaolhlv
local curexp=gbData.gubaolhexp
local maxlv=gubaoModel:getLianHuaMax(gbid)
local sumexp=0

for lv=curlv,maxlv-1 do
local upexp=gubaoModel:getLianHuaUpExp(gbid,lv)
if upexp~=nil and upexp>0 then
sumexp=sumexp+upexp
end
end
if sumexp>0 then
sumexp=sumexp-curexp
end
return sumexp
end



function UIGuBaoLianHuaWin:startBehavior()
local flag=0
for i=1,goodMax do
local info=self.goodlist[i]
if info then
flag=flag+math.pow(2,i-1)
end
end
local target0=self.effect0:getID()
local target1=self.effect1:getID()
local target2=self.effect2:getID()
local target3=self.effect3:getID()
local target4=self.effect4:getID()
local target5=self.effect5:getID()

local parent=self.effectRoot:getID()
local pos=self.winlua:GetChildPosition(target0)
local initData=
{
stateId=flag,
widget=self.winlua,
target0=target0,
target1=target1,
target2=target2,
target3=target3,
target4=target4,
target5=target5,
parent=parent,
pos=pos,
duration1=1,
duration2=1.1,
duration3=1.2,
duration4=1.3,
duration5=1.4,


eSlider1=Vector2.New(0.3,0.4),
oSlider1=Vector2.New(0.3,0.4),

eSlider2=Vector2.New(0.1,0.2),
oSlider2=Vector2.New(0.1,0.2),

eSlider3=Vector2.New(0,0),
oSlider3=Vector2.New(0,0),

eSlider4=Vector2.New(-0.1,-0.2),
oSlider4=Vector2.New(-0.1,-0.2),

eSlider5=Vector2.New(-0.3,-0.4),
oSlider5=Vector2.New(-0.3,-0.4),
}
self:stopBehavior()
self.bt=behaviorManager:addBehaviorTree('bt_ui_equip_jinglian_fly',nil,true,initData)

end

function UIGuBaoLianHuaWin:stopBehavior()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end



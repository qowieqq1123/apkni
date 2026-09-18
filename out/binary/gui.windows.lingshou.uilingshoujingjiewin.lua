







def_class("UILingShouJingJieWin",UIWindowBase)









function UILingShouJingJieWin:bindComponents()

self.root=UIObject.get(self,0)
self.jingjieTxt=UIText.get(self,1)
self.ntjingjieTxt=UIText.get(self,2)
self.zizhiTxt=UIText.get(self,3)
self.levelProgressText=UIText.get(self,4)
self.attrGrid=UIObject.get(self,5)
self.costTitle=UIObject.get(self,6)
self.brokeObj=UIObject.get(self,7)
self.tipsTxt=UIText.get(self,8)
self.costTitleTxt=UIText.get(self,9)
self.levelProgressGreen=UIObject.get(self,10)
self.levelProgress=UIObject.get(self,11)
self.lianHuaBrokeEffect=UIObject.get(self,12)
self.goodlist=UIObject.get(self,13)
self.gainWayPanel=UIObject.get(self,14)
self.gainWayList=UIObject.get(self,15)
self.listUnline=UIObject.get(self,16)
self.jumpBtnPanel=UIObject.get(self,17)
self.jumpBtn=UIButton.get(self,18)
self.jumpBtnText=UIText.get(self,19)
self.costLayout=UIObject.get(self,20)
self.noGoodTips=UIText.get(self,21)
self.talkObj=UIObject.get(self,22)
self.quickBtn=UIButton.get(self,23)
self.quickPanel=UIObject.get(self,24)
self.closeQuick=UIButton.get(self,25)
self.quickProgressBarGreen=UIProgress.get(self,26)
self.quickProgressBarYellow=UIProgress.get(self,27)
self.quickSlider=UIObject.get(self,28)
self.quickSubBtn=UIButton.get(self,29)
self.quickAddBtn=UIButton.get(self,30)
self.quickSliderHandle=UIObject.get(self,31)
self.quickSliderGroup=UIObject.get(self,32)
self.quickBegin=UIText.get(self,33)
self.quickArrow=UIObject.get(self,34)
self.quickEnd=UIText.get(self,35)
self.quickBroke=UIText.get(self,36)
self.quickCostView=UIObject.get(self,37)
self.quickCostList=UIObject.get(self,38)
self.quickCostOther=UIObject.get(self,39)
self.quickResetBtn=UIButton.get(self,40)
self.quickUseBtn=UIButton.get(self,41)
self.quickCostEmpty=UIObject.get(self,42)
self.quickBg=UIObject.get(self,43)
self.quickRoot=UIObject.get(self,44)
self.quickMask=UIButton.get(self,45)
self.cndTipsText=UIText.get(self,46)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.quickBtn:setButtonClick(function()self:onQuickBtn()end)

self.closeQuick:setButtonClick(function()self:onCloseQuick()end)

self.quickSubBtn:setButtonClick(function()self:onQuickSubBtn()end)

self.quickAddBtn:setButtonClick(function()self:onQuickAddBtn()end)

self.quickResetBtn:setButtonClick(function()self:onQuickResetBtn()end)

self.quickUseBtn:setButtonClick(function()self:onQuickUseBtn()end)

self.quickMask:setButtonClick(function()self:onQuickMask()end)



end


function UILingShouJingJieWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.jingjieTxt);self.jingjieTxt=nil;
_UIObject_release(self.ntjingjieTxt);self.ntjingjieTxt=nil;
_UIObject_release(self.zizhiTxt);self.zizhiTxt=nil;
_UIObject_release(self.levelProgressText);self.levelProgressText=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.costTitle);self.costTitle=nil;
_UIObject_release(self.brokeObj);self.brokeObj=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.costTitleTxt);self.costTitleTxt=nil;
_UIObject_release(self.levelProgressGreen);self.levelProgressGreen=nil;
_UIObject_release(self.levelProgress);self.levelProgress=nil;
_UIObject_release(self.lianHuaBrokeEffect);self.lianHuaBrokeEffect=nil;
_UIObject_release(self.goodlist);self.goodlist=nil;
_UIObject_release(self.gainWayPanel);self.gainWayPanel=nil;
_UIObject_release(self.gainWayList);self.gainWayList=nil;
_UIObject_release(self.listUnline);self.listUnline=nil;
_UIObject_release(self.jumpBtnPanel);self.jumpBtnPanel=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.jumpBtnText);self.jumpBtnText=nil;
_UIObject_release(self.costLayout);self.costLayout=nil;
_UIObject_release(self.noGoodTips);self.noGoodTips=nil;
_UIObject_release(self.talkObj);self.talkObj=nil;
_UIObject_release(self.quickBtn);self.quickBtn=nil;
_UIObject_release(self.quickPanel);self.quickPanel=nil;
_UIObject_release(self.closeQuick);self.closeQuick=nil;
_UIObject_release(self.quickProgressBarGreen);self.quickProgressBarGreen=nil;
_UIObject_release(self.quickProgressBarYellow);self.quickProgressBarYellow=nil;
_UIObject_release(self.quickSlider);self.quickSlider=nil;
_UIObject_release(self.quickSubBtn);self.quickSubBtn=nil;
_UIObject_release(self.quickAddBtn);self.quickAddBtn=nil;
_UIObject_release(self.quickSliderHandle);self.quickSliderHandle=nil;
_UIObject_release(self.quickSliderGroup);self.quickSliderGroup=nil;
_UIObject_release(self.quickBegin);self.quickBegin=nil;
_UIObject_release(self.quickArrow);self.quickArrow=nil;
_UIObject_release(self.quickEnd);self.quickEnd=nil;
_UIObject_release(self.quickBroke);self.quickBroke=nil;
_UIObject_release(self.quickCostView);self.quickCostView=nil;
_UIObject_release(self.quickCostList);self.quickCostList=nil;
_UIObject_release(self.quickCostOther);self.quickCostOther=nil;
_UIObject_release(self.quickResetBtn);self.quickResetBtn=nil;
_UIObject_release(self.quickUseBtn);self.quickUseBtn=nil;
_UIObject_release(self.quickCostEmpty);self.quickCostEmpty=nil;
_UIObject_release(self.quickBg);self.quickBg=nil;
_UIObject_release(self.quickRoot);self.quickRoot=nil;
_UIObject_release(self.quickMask);self.quickMask=nil;
_UIObject_release(self.cndTipsText);self.cndTipsText=nil;
end
















local _this
local listChange
local listChangeNum
local tipsShowTime=5
local _quickUseUnit=20000


function UILingShouJingJieWin:onLoaded(...)
_this=self
self:bindComponents()
listChange=true
listChangeNum=false
self.goodlist:setChildScrollViewInit(0.5,true,nil,nil)


self:addNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
self:addNotify(notifyConfig.onLingShouJJChange,self.onLingShouJJChange)
self:addProNotify(1,28,self.on_1_28)
self:addNotify(notifyConfig.onZongMengLevelChange,self.onZongMengLevelChange)
self.gainTable={}
end


function UILingShouJingJieWin:__delete()
self.lianHuaBrokeEffect:setChildShowEffect(0,false)
_this=nil
self:unbindComponents()
end

function UILingShouJingJieWin.onLingShouUseItemList(list)
if _this==nil then return end
local hasSelfLsUse=false
local refreshItemLookup={}
for i,v in ipairs(list)do
local ls_guid=v.param_1
local itemid=v.param_2
if mathHelper.compareInt64(ls_guid,_this.ls_guid)then
hasSelfLsUse=true
refreshItemLookup[itemid]=true
end
end

if hasSelfLsUse then
_this:refresh()
for itemid,_ in pairs(refreshItemLookup)do

local change=false
local isNew=_this.items_lookup_new and _this.items_lookup_new[itemid]or false
local change_idx=_this.items_lookup and _this.items_lookup[itemid]or nil
local check=isNew==true or change_idx~=nil
change=check
local hasItemCount=itemsModel.getCount(itemid)
if isNew==true or(check and hasItemCount==0)then
listChange=true
elseif change_idx~=nil then
listChangeNum=true
end

if change then

local idx=_this.items_lookup[itemid]
if idx then
_this:refreshCostListItem(nil,idx,true)
end
end
end
end
end

function UILingShouJingJieWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
local change=false
local isNew=_this.items_lookup_new and _this.items_lookup_new[itemid]or false
local change_idx=_this.items_lookup and _this.items_lookup[itemid]or nil
local check=isNew==true or change_idx~=nil
local isChangeNum=change_idx~=nil and oldcount~=newcount
change=check
if isNew==true or(check and newcount==0)then
listChange=true
elseif isChangeNum then
listChangeNum=true
end

_this:refresh()
if change then

local idx=_this.items_lookup[itemid]
local showEffect=oldcount>newcount and _this.quickData==nil
if idx then
_this:refreshCostListItem(nil,idx,showEffect)
end
end
end

function UILingShouJingJieWin.on_item_list_changed(args)
if _this==nil then return end

local change=false
local changeList={}
for _,v in ipairs(args)do
local itemid=v[3]
local oldcount=v[4]
local newcount=v[5]
local isNew=_this.items_lookup_new and _this.items_lookup_new[itemid]or false
local change_idx=_this.items_lookup and _this.items_lookup[itemid]or nil
local isChangeNum=change_idx~=nil and oldcount~=newcount
local check=isNew==true or change_idx~=nil
if check then
change=check
table.insert(changeList,{itemid=itemid,oldcount=oldcount,newcount=newcount})
end
if isNew==true or(check and newcount==0)then
listChange=true
elseif isChangeNum then
listChangeNum=true
end
end

_this:refresh()
if change then

for i,v in ipairs(changeList)do
local itemid=v.itemid
local oldcount=v.oldcount
local newcount=v.newcount
local idx=_this.items_lookup[itemid]
local showEffect=oldcount>newcount and _this.quickData==nil
if idx then
_this:refreshCostListItem(nil,idx,showEffect)
end
end
end
end

function UILingShouJingJieWin.onLingShouJJChange(guid,old_lv,jj_lvl,old_exp,jj_exp)
if _this==nil then return end
if not mathHelper.compareInt64(guid,_this.ls_guid)then
return
end

if jj_lvl>=old_lv then

local addExp
if old_lv==jj_lvl then
addExp=jj_exp-old_exp
else
local lvCfg=cfg_lingshoujingjieconfig()
addExp=0
for i=old_lv,jj_lvl-1 do
local cfg=lvCfg[i]
local lvUpExp=cfg.xiuwei
addExp=addExp+lvUpExp
end
addExp=addExp-old_exp+jj_exp
end

if addExp>0 then
local str=FMT.fmt('+{0}修为',addExp)
commonTipsHelper.addThrowOutAndSliderTips(3,str)
end
end

if old_lv~=jj_lvl then

listChange=true
end

_this:refresh()
end

function UILingShouJingJieWin.on_1_28(len,array)
local waitQuickProto=_this.waitQuickProto
if waitQuickProto then
for idx=1,len do
local data=array[idx]
local guid=data.param_1
if mathHelper.compareInt64(guid,_this.ls_guid)then
local itemid=data.param_2
local num=data.param_3
local key=FMT.fmt("{0}_{1}",itemid,num)
waitQuickProto.items[key]=nil
end
end
_this:checkWaitQuickProto()
end
end

function UILingShouJingJieWin.onZongMengLevelChange(zmLv,exp)

listChange=true
_this:refresh()
end


function UILingShouJingJieWin:onHide()

end




function UILingShouJingJieWin:onShow(argtable,afterOnloaded)
self.ls_guid=argtable.ls_guid
self.progressLock=0




self:refresh()
end

function UILingShouJingJieWin:onChangeLingShou(guid)
listChange=true
self:onShow({ls_guid=guid})
end

function UILingShouJingJieWin:refresh(isInit)

self:refreshData()


self:refreshProgressPanel()


self:refreshAttrPanel()


self:refreshCostPanel(isInit)
end

function UILingShouJingJieWin:refreshData()
local guid=self.ls_guid
local lsData=lingshouModel:getLingShouData(guid)
local curlv=lsData.jj_lvl
local curexp=lsData.jj_exp
local isfull=lingshouModel:checkJJFull(guid)
local needBroke,brokeCost=lingshouModel:checkJJNeedBroke(guid)

self.isfull=isfull
self.curlv=curlv
self.curexp=curexp
self.needBroke=needBroke
self.brokeCost=brokeCost
end

function UILingShouJingJieWin:refreshProgressPanel()
local guid=self.ls_guid
local curlv=self.curlv
local curexp=self.curexp
local isfull=self.isfull
local needBroke=self.needBroke


local jj_str=lingshouModel:getJJName(guid,2)
self.jingjieTxt:setText(jj_str)

local pageState=0
if isfull then

self.ntjingjieTxt:setActive(false)

self.levelProgress:setChildIconFillAmount(1)
self.levelProgressText:setText('满级')
else
pageState=needBroke and 1 or 2
if needBroke then
local nextlv=curlv+1

self.ntjingjieTxt:setActive(true)
self.ntjingjieTxt:setText(lingshouModel.getJJNameEx(nextlv,2))
else

self.ntjingjieTxt:setActive(false)
end

local maxexp=cfgHelper.get2(cfg_lingshoujingjieconfig_get,curlv,'xiuwei')
local rate=curexp/maxexp
if rate>1 then rate=1 end
self.levelProgress:setChildIconFillAmount(rate)
self.levelProgressText:setText(FMT.fmt('{0}/{1}',curexp,maxexp))
end

self.levelProgressGreen:setActive(false)











end

function UILingShouJingJieWin:refreshAttrPanel()
local guid=self.ls_guid
local lsData=lingshouModel:getLingShouData(guid)
local curlv=lsData.jj_lvl
local lscfg=lsData.cfg
local attrs=lingshouModel.getJJAttrList(curlv,lscfg.race)
local attrs_new=nil
local isfull=self.isfull
if not isfull then
attrs_new=lingshouModel.getJJAttrList(curlv+1,lscfg.race)
end
self:refreshAttrGrid(attrs,attrs_new)
end

function UILingShouJingJieWin:refreshCostPanel(isInit)
local guid=self.ls_guid
local isfull=self.isfull
local needBroke=self.needBroke
local brokeCost=self.brokeCost

local showCostObj=not isfull and not needBroke
local showBrokeObj=not isfull and needBroke


local fullTipsStr=isfull==true and'境界已达最大等级'or''
self.tipsTxt:setText(fullTipsStr)

local showCostTitle=not isfull
self.costTitle:setActive(showCostTitle)
if showCostTitle then
local titleStr=needBroke==true and'突破消耗'or'消耗材料'
self.costTitleTxt:setText(titleStr)
end

self.costLayout:setActive(showCostObj)
self.brokeObj:setActive(showBrokeObj)

if showCostObj then
self:refreshCostLayout(isInit)
elseif showBrokeObj then
self.noGoodTips:setActive(false)
self:refreshBrokePanel()
end

if isfull or showBrokeObj then

self:onGoodUpBtnClick_fn()
end


self.quickBtn:setActive(showCostObj)


local cndTipsStr=''
local isShowCndTips=false
local isPass,needZmLv=self:checkJJZmLevelCnd()
if not isPass then
cndTipsStr=FMT.fmt('宗门等级需达到{0}级',needZmLv)
isShowCndTips=true
end


self.cndTipsText:setActive(isShowCndTips)
self.cndTipsText:setText(cndTipsStr)
end

function UILingShouJingJieWin:checkShowBroke()
local isfull=self.isfull
local needBroke=self.needBroke
local showBrokeObj=not isfull and needBroke
return showBrokeObj
end

function UILingShouJingJieWin:checkJJZmLevelCnd()
local isfull=self.isfull
if isfull then

return true
end

local curlv=self.curlv
local curexp=self.curexp
local nowJJCfg=cfgHelper.get1(cfg_lingshoujingjieconfig_get,curlv)
local nextJJexp=nowJJCfg.xiuwei
local zmLv=zongmenModel:getLevel()
if curexp>=nextJJexp then

local nextLv=curlv+1
local nextJJCfg=cfgHelper.get1(cfg_lingshoujingjieconfig_get,nextLv)
local nextNeedLvSectlv=nextJJCfg.guild_lvl
if nextNeedLvSectlv and zmLv<nextNeedLvSectlv then
return false,nextNeedLvSectlv
end
else

local nowNeedLvSectlv=nowJJCfg.guild_lvl
if nowNeedLvSectlv and zmLv<nowNeedLvSectlv then
return false,nowNeedLvSectlv
end
end

return true
end

function UILingShouJingJieWin:refreshCostLayout(isInit)
local hasCanUse
if listChange then
listChange=false
listChangeNum=false
hasCanUse=false
self:getCostList()
local dataNum=#self.costlist
self.goodlist:setChildScrollViewCreateGrids(dataNum,1)
self.noGoodTips:setActive(dataNum<=0)

local goodGrid=self.goodlist:getChildScrollViewItemWidgets()
for i=1,dataNum do
local item=goodGrid[i-1]
self:refreshCostListItem(item,i,nil,isInit)
local data=self.costlist[i]
local fix=data.fix
if fix then
hasCanUse=true
end
end
elseif listChangeNum then
listChangeNum=false
self:refreshCostListItemNum()
end








end

function UILingShouJingJieWin:refreshCostListItem(item,index,showEffect,isInit)
if item==nil then
item=self.goodlist:getChildScrollViewItemWidget(index-1)
end
local data=self.costlist[index]
local itemId=data.itemid
local itemNum=bagModel.getItemCountById(itemId)
local conf={itemid=itemId,itemcount=itemNum,showname=false,showCountBG=true,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)

item:SetChildText(1,itemsConfig.getItemName(itemId))

local cfg=itemsConfig.getConfig(itemId)
local funcparam=cfg.funcparam
local addexp=data.xiuwei
local desc_str=FMT.fmt('修为+{0}',addexp)
if funcparam and funcparam.attr6~=nil then
desc_str=FMT.fmt('{0}\n{1}+{2}',desc_str,UIDiscipleModel:getDiscipleBaseAttrName(funcparam.attr6[1][1]),funcparam.attr6[1][2])
end
item:SetChildText(2,desc_str)

local repeatType=REPEAT_TYPE.eUseExpByAbsorbExp
local clickCount=0
local cb=function(idx)
clickCount=clickCount+1
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eLogin,repeatType)
if flag then
clickCount=0
else
if clickCount>1 then return end
end

clickCount=0
if not self or self.isClose then return end
self:onGoodUpBtnClick(idx,itemId)
end

local fncb=function(idx)
self:onGoodUpBtnClick_fn(idx,itemId)
end
item:SetChildLongPress(3,index,cb,fncb)

local fix=data.fix
local is_gray=not fix
item:SetChildImageExGray(3,is_gray)

item:SetChildActive(4,is_gray)

item:SetChildNewBieComponentId(5,FMT.fmt('UILingShouJingJieWin.GoodItem_{0}.newBieButton',index))







if showEffect then
item:SetChildShowEffect(6,10088,true)
elseif isInit then
item:SetChildShowEffect(6,0,false)
end
end
function UILingShouJingJieWin:refreshBrokePanel()
local brokeCost=self.brokeCost
local brokeWidget=self.brokeObj:getChildWidgetBase()
local costNum=#brokeCost
brokeWidget:SetChildLayoutGroupCreateItems(0,costNum)
local gridlist=brokeWidget:GetChildLayoutGroupGridList(0)
for i=1,costNum do
local item=gridlist[i-1]
local cost=brokeCost[i]
local itemid=cost[1]
local itemnum=cost[2]
self.gainTable[itemid]=itemnum
local hasnum
local num_str
if itemsConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
num_str=tostring(itemnum)
else
hasnum=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
num_str=string.format('%d/%d',hasnum,itemnum)
end
local grayNum=0
if hasnum<itemnum then
grayNum=mathHelper.setbit(grayNum,eGrayType.eMaskGray-1)
end
if grayNum~=0 then
num_str=FMT.fmt('<color=red>{0}</color>',num_str)
end
local conf={itemid=itemid,itemcount=num_str,showname=false,itemIndex=i,gray=grayNum,showStage=true,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onBrokeItemClick(...)
end)
end
end

function UILingShouJingJieWin:getCostList()
local list={}
self.items_lookup={}
self.items_lookup_new={}
self.quickGoods={}
self.quickGoods_lookup={}
local lsGuid=self.ls_guid
local temp=itemsLookup:get_function_items(item_funtion_type.lingshou)
local isPassCnd,needZmLv=self:checkJJZmLevelCnd()

for i,v in ipairs(temp)do
local itemid=v.id
local cnt=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if cnt>0 then
local funcparam=v.funcparam
local extra=funcparam and funcparam.extra
local cfgAddExp=0
if extra then
for _,params in ipairs(extra)do
local cnd=params[1]
local eff=params[2]
if eff and eff[8]then
cfgAddExp=eff[8]
break
end
end
end

local needReconfirmWeight=v.reconfirmText and 1000 or 0
local addExp=lingshouModel:calculationJJMedicineGrow(lsGuid,cfgAddExp,itemid)
local fix=isPassCnd and itemsLookup:checkLingShouUseItemCondition(lsGuid,itemid)
local fixWeight=fix and 1000 or 0
table.insert(list,{itemid=itemid,cnt=cnt,color=v.color,xiuwei=addExp,needReconfirmWeight=needReconfirmWeight,fix=fix,fixWeight=fixWeight})

if fix then
local addexp=addExp
local data={v,cfgAddExp,cnt,addexp}
table.insert(self.quickGoods,data)
end
else
self.items_lookup_new[v.id]=true
end
end
if#list>0 then
if#list>1 then
table.sort(list,function(a,b)
if a.fixWeight==b.fixWeight then
if a.needReconfirmWeight==b.needReconfirmWeight then
if a.xiuwei==b.xiuwei then
return a.itemid<b.itemid
else
return a.xiuwei>b.xiuwei
end
else
return a.needReconfirmWeight<b.needReconfirmWeight
end
else
return a.fixWeight>b.fixWeight
end

end)
end

for i,v in ipairs(list)do
self.items_lookup[v.itemid]=i
end
end
self.costlist=list


if#self.quickGoods>0 then
if#self.quickGoods>1 then
table.sort(self.quickGoods,function(a,b)
if a[4]==b[4]then
return a[1].id<b[1].id
else
return a[4]>b[4]
end
end)
end

for i,v in ipairs(self.quickGoods)do
self.quickGoods_lookup[v[1].id]=i
end
end
end


function UILingShouJingJieWin:refreshCostListItemNum()
for i,v in ipairs(self.quickGoods)do
local item=v[1]
local itemid=item.id
local nowItemCount=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
v[3]=nowItemCount
end

for i,v in ipairs(self.costlist)do
local itemid=v.itemid
local nowItemCount=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
v.cnt=nowItemCount
end
end

function UILingShouJingJieWin:initSelectData()
self.selectCostItemIndex=nil
self.selectCostItemID=nil
self.selectCostNum=nil
self.selectCostMaxNum=nil
self.addexp=0
end

function UILingShouJingJieWin:refreshSelectData()
if#self.costlist>0 then
local idx=1
local num=self.selectCostNum or 1
if self.selectCostItemIndex~=nil then
local f=nil
for i,v in ipairs(self.costlist)do
if v.itemid==self.selectCostItemID then
f=i
end
end
if f~=nil then
idx=f
else
num=1
end
end
local selectItem=self.costlist[idx]
self.selectCostItemIndex=idx
self.selectCostItemID=selectItem.itemid
local max=1
for i=1,selectItem.cnt do
max=i
if selectItem.xiuwei*i>=self.addmaxexp then
break
end
end
if num>max then num=max end
self.selectCostNum=num
self.selectCostMaxNum=max
self:refreshSelectExp(selectItem)
else
self:initSelectData()
end
end

function UILingShouJingJieWin:showLianHuaItemEffect()
local item=self.costWidget:GetChildLayoutGroupGridItem(0,self.selectCostItemIndex-1)
if item then
item:SetChildShowEffect(2,10088,true)
end
end

function UILingShouJingJieWin:refreshView(init)
local guid=self.ls_guid
local lsData=lingshouModel:getLingShouData(guid)
local lscfg=lsData.cfg
local curlv=lsData.jj_lvl
local curexp=lsData.jj_exp
local isfull=lingshouModel:checkJJFull(guid)
self.isfull=isfull
self.curlv=curlv
self.curexp=curexp
local needBroke,brokeCost=lingshouModel:checkJJNeedBroke(guid)


self.zizhiTxt:setText(FMT.fmt('资质：<color=#000000>{0}</color>',lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.ZIZHI)))

local jj_str=lingshouModel:getJJName(guid,2)
self.jingjieTxt:setText(jj_str)

local attrs=lingshouModel.getJJAttrList(curlv,lscfg.race)
local attrs_new=nil
if not isfull then
attrs_new=lingshouModel.getJJAttrList(curlv+1,lscfg.race)
end
self:refreshAttrGrid(attrs,attrs_new)

local fullTipsStr=isfull==true and'境界已达最大等级'or''
self.tipsTxt:setText(fullTipsStr)

local showCostTitle=not isfull
self.costTitle:setActive(showCostTitle)
if showCostTitle then
local titleStr=needBroke==true and'突破消耗'or'消耗材料'
self.costTitleTxt:setText(titleStr)
end

self.gainTable={}
local showCostObj=not isfull and not needBroke
self.costObj:setActive(showCostObj)
if showCostObj then
if self.costWidget==nil then
self.costWidget=self.costObj:getChildWidgetBase()
end
if init then

self.addmaxexp=lingshouModel.getJJUpMaxExp(curlv,curexp)
self:getCostList()

local goodNum=#self.costlist
local showCostWidget=goodNum>0
self.costWidget:SetChildActive(4,showCostWidget)
self.costWidget:SetChildActive(5,not showCostWidget)
if showCostWidget then
self.costWidget:SetChildLayoutGroupCreateItems(0,goodNum)
local gridlist=self.costWidget:GetChildLayoutGroupGridList(0)
for i=1,goodNum do
local item=gridlist[i-1]
local good=self.costlist[i]
local itemid=good.itemid
local itemnum=good.cnt
self.gainTable[itemid]=itemnum
local conf={itemid=itemid,itemcount=tostring(itemnum),showname=false,itemIndex=i,showStage=true,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onCostItemClick(...)
end)
item:SetBaseItemLongTouchEvent(0,function(...)
self:onCostItemLongClick(...)
end)

local isselect=i==self.selectCostItemIndex
item:SetChildActive(1,isselect)
end

self:initSliderCost()
end
end
end

local showBrokeObj=not isfull and needBroke
self.brokeObj:setActive(showBrokeObj)
if showBrokeObj then

local brokeWidget=self.brokeObj:getChildWidgetBase()
local costNum=#brokeCost
brokeWidget:SetChildLayoutGroupCreateItems(0,costNum)
local gridlist=brokeWidget:GetChildLayoutGroupGridList(0)
for i=1,costNum do
local item=gridlist[i-1]
local cost=brokeCost[i]
local itemid=cost[1]
local itemnum=cost[2]
self.gainTable[itemid]=itemnum
local hasnum
local num_str
if itemsConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
num_str=tostring(itemnum)
else
hasnum=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
num_str=string.format('%d/%d',hasnum,itemnum)
end
local grayNum=0
if hasnum<itemnum then
grayNum=mathHelper.setbit(grayNum,eGrayType.eMaskGray-1)
end
if grayNum~=0 then
num_str=FMT.fmt('<color=red>{0}</color>',num_str)
end
local conf={itemid=itemid,itemcount=num_str,showname=false,itemIndex=i,gray=grayNum,showStage=true,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onBrokeItemClick(...)
end)
end
end

local pageState=0
if isfull then

self.ntjingjieTxt:setActive(false)

self.levelProgress:setChildIconFillAmount(1)
self.levelProgressText:setText('满级')
else
pageState=needBroke and 1 or 2
if needBroke then
local nextlv=curlv+1

self.ntjingjieTxt:setActive(true)
self.ntjingjieTxt:setText(lingshouModel.getJJNameEx(nextlv,2))
else

self.ntjingjieTxt:setActive(false)
end

local maxexp=cfgHelper.get2(cfg_lingshoujingjieconfig_get,curlv,'xiuwei')
local rate=curexp/maxexp
if rate>1 then rate=1 end
self.levelProgress:setChildIconFillAmount(rate)
self.levelProgressText:setText(FMT.fmt('{0}/{1}',curexp,maxexp))
end

self.levelProgressGreen:setActive(false)

self.addlv=nil
self.addRate=nil
self.tempfull=nil
if pageState==2 then
if self.addexp>0 then
self:refreshLevelProgress()
end
end
end

function UILingShouJingJieWin:refreshLevelProgress()
if self.addexp==0 then return end

local curlv=self.curlv
local curexp=self.curexp
local changlv,changeexp=lingshouModel:jjChangeAddExp(curlv,curexp,self.addexp)
local addlv=changlv-curlv
local guid=self.ls_guid
local lsData=lingshouModel:getLingShouData(guid)
self.tempfull=lingshouModel.checkJJFullEx(changlv,lsData.generation)
local maxexp
local rate
if self.tempfull then
maxexp=cfgHelper.get2(cfg_lingshoujingjieconfig_get,changlv-1,'xiuwei')
rate=1
else
maxexp=cfgHelper.get2(cfg_lingshoujingjieconfig_get,changlv,'xiuwei')
rate=changeexp/maxexp
if rate>1 then rate=1 end
end
self.addlv=addlv
self.addRate=rate


self.ntjingjieTxt:setActive(addlv>0)
if addlv>0 then
self.ntjingjieTxt:setText(lingshouModel.getJJNameEx(changlv,2))
end

local mexp=cfgHelper.get2(cfg_lingshoujingjieconfig_get,curlv,'xiuwei')
local progress_str=FMT.fmt('{0}<color=#549327>(+{1})</color>/{2}',curexp,self.addexp,mexp)
self.levelProgressText:setText(progress_str)


self.levelProgressGreen:setActive(true)
local r=rate
if addlv>0 then r=1 end
local bFunc=function()
if _this==nil then return end
_this.progressLock=mathHelper.setbit(_this.progressLock,1)
_this:enableSlider()
end
local eFunc=function()
if _this==nil then return end
_this.progressLock=mathHelper.clrbit(_this.progressLock,1)
_this:enableSlider()
end
helper.playProgressAnim(self.levelProgressGreen,r,0,bFunc,eFunc,nil,1.0)
end

function UILingShouJingJieWin:doLevelProgress()
if self.addexp>0 then

local str=FMT.fmt('增加{0}修为',self.addexp)
commonTipsHelper.addThrowOutAndSliderTips(1,str)

self.levelProgressGreen:setActive(false)
self.levelProgressGreen:setChildIconFillAmount(0)
local addlv=self.addlv
local rate=self.addRate
local bFunc=function()
if _this==nil then return end
_this.progressLock=mathHelper.setbit(_this.progressLock,0)
_this:enableSlider()
end
local eFunc=function()
if _this==nil then return end
_this.progressLock=mathHelper.clrbit(_this.progressLock,0)

_this:refreshView(true)
end
helper.playProgressAnim(self.levelProgress,rate,addlv,bFunc,eFunc,nil,1.0)
end
end

function UILingShouJingJieWin:initSliderCost()
local noSlider=self.selectCostMaxNum==nil or self.selectCostMaxNum<=1
if noSlider then
self.costWidget:SetChildSlider(1,1,0,1,function(b_num)
self:onSliderRefresh(b_num)
end)
else
self.costWidget:SetChildSlider(1,self.selectCostNum,1,self.selectCostMaxNum,function(b_num)
self:onSliderRefresh(b_num)
end)
end
self:enableSlider()
self.costWidget:SetChildCanvasGroupRaycast(1,not self.lockSlider)
self:refreshSliderCostNum()
end

function UILingShouJingJieWin:enableSlider()
local noSlider=self.selectCostMaxNum==nil or self.selectCostMaxNum<=1
self.lockSlider=noSlider or self.progressLock~=0
self.costWidget:SetChildCanvasGroupRaycast(1,not self.lockSlider)
end

function UILingShouJingJieWin:refreshSliderCostNum()
local isshow=self.selectCostNum~=nil
self.costWidget:SetChildActive(2,isshow)
if isshow then
self.costWidget:SetChildText(3,tostring(self.selectCostNum))
end
end

function UILingShouJingJieWin:refreshAttrGrid(attrs,attrs_new)
attrs_new=attrs_new or defaultT
attrs=attrs or defaultT
local num=#attrs
self.attrGrid:setChildLayoutGroupCreateItems(num)
local gridlist=self.attrGrid:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]
local attr=attrs[i]
local attr_n=attrs_new[i]

local str=helper.getAttributeStr(attr[1],attr[2],nil,'{0}：<color=#000000>{1}</color>')
item:SetChildText(0,str)

local addnum=0
if attr_n~=nil then
addnum=attr_n[2]-attr[2]
end
local isadd=addnum>0
item:SetChildActive(1,isadd)
if isadd then


item:SetChildText(1,tostring(addnum))
end
end
end

function UILingShouJingJieWin:onBrokeItemClick(itemid,index,guid,attach)
if itemid==-1 then return end
local need=self.gainTable[itemid]or 0
if gainControl:showGainWin(itemid,need)then return end
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end

function UILingShouJingJieWin:onCostItemClick(itemid,index,guid,attach)
if index==self.selectCostItemIndex then return end

if self.selectCostItemIndex then
local item=self.costWidget:GetChildLayoutGroupGridItem(0,self.selectCostItemIndex-1)
item:SetChildActive(1,false)
end
local item_n=self.costWidget:GetChildLayoutGroupGridItem(0,index-1)
item_n:SetChildActive(1,true)

local selectItem=self.costlist[index]
self.selectCostItemIndex=index
self.selectCostItemID=selectItem.itemid
local max=selectItem.cnt
self.selectCostNum=1
self:refreshSelectData()
self:initSliderCost()
self:refreshView()
end

function UILingShouJingJieWin:refreshSelectExp(selectItem)
if selectItem==nil then
selectItem=self.costlist[self.selectCostItemIndex]
end
self.addexp=selectItem.xiuwei*self.selectCostNum
end

function UILingShouJingJieWin:checkGoodUpUseCondition(idx,itemID)
local guid=self.ls_guid
local itemNum=bagModel.getItemCountById(itemID)
if itemNum<=0 then
UIManager.error('道具不足')
gainControl:showGainWin(itemID)
return false
end

local isfull=lingshouModel:checkJJFull(guid)

if isfull then
UIManager.error('境界已满')
return false
end


local isPassCnd,needZmLv=self:checkJJZmLevelCnd()
if not isPassCnd then
UIManager.info(FMT.fmt('宗门等级需达到{0}级',needZmLv))
return
end


local fix,cond=itemsLookup:checkLingShouUseItemCondition(guid,itemID)
if not fix then
if cond then
local item=self.goodlist:getChildScrollViewItemWidget(idx-1)
local pos=Vector2.New(-190,30)
local cond_str=lingshouModel:getUseGoodStr(cond)
UIManager:showWindow('UIConditionTipsOne',{str=cond_str,posWidget=item,pos=pos})
end
return false
end

return true
end

function UILingShouJingJieWin:stopItemLongPress(idx)
local item=self.goodlist:getChildScrollViewItemWidget(idx-1)
if item then
item:SetChildLongPressStop(3)
item:SetChildShowEffect(6,0,false)
end
end

function UILingShouJingJieWin:recordClickCount()
if self.clickTime==nil or(Time.realtimeSinceStartup-self.clickTime<0.5)then
self.clickCount=self.clickCount==nil and 1 or(self.clickCount+1)
else
self.clickCount=0
end
if self.clickCount>=5 then
self.clickCount=0


self:showTalk('长按可批量使用物品')
end
self.clickTime=Time.realtimeSinceStartup
end

function UILingShouJingJieWin:showTalk(talkStr)
self:clearTalk()

self.talkObj:setActive(true)
local talkWidget=self.talkObj:getChildWidgetBase()
talkWidget:SetChildText(0,talkStr)
self.talkObj:setChildCanvasGroupAlpha(0)
self.talkObj:setChildCanvasGroupDOFade(1,0.1,nil)
self.talkObj:setScale(Vector3.New(0,0,0))
self.talkObj:setChildDOScale(1,0.2,nil)

local func=function()
self:clearTalk()
end
self.talkTimer=self:delayDo(tipsShowTime,func)
end

function UILingShouJingJieWin:clearTalk()
if self.talkTimer~=nil then
self.talkObj:setActive(false)
self:stopTimerByID(self.talkTimer)
self.talkTimer=nil
end
end

function UILingShouJingJieWin:getCostListCanAddMax()
local canAddMax=0
for i,v in ipairs(self.quickGoods)do
local cfg=v[1]
local exp=v[2]
local num=v[3]
local addexp=v[4]
canAddMax=canAddMax+addexp*num
end
return canAddMax
end

function UILingShouJingJieWin:getQuickData(canAddMax)
if canAddMax==nil then
canAddMax=self:getCostListCanAddMax()
end
local guid=self.ls_guid
local lsData=lingshouModel:getLingShouData(guid)

local curlv=lsData.jj_lvl
local curexp=lsData.jj_exp
local curGen=lsData.generation
local data={}
data.sExp=curexp
data.sLv=curlv
data.aExp=0
data.aLv=0
data.oAddLv=0
data.costList={}
data.dExpList={}
data.aExpMax=canAddMax

local lvCfg=cfg_lingshoujingjieconfig()
local cLvCfg=lvCfg[data.sLv]
local progressMax=cLvCfg.xiuwei
local progressValue=data.sExp
local deltaExp=cLvCfg.xiuwei-data.sExp
table.insert(data.dExpList,deltaExp)

local zmLv=zongmenModel:getLevel()
local sectlv=cLvCfg.guild_lvl
local generation=cLvCfg.generation
for i=data.sLv-1,0,-1 do
local tempCfg=lvCfg[i]
sectlv=sectlv or tempCfg.guild_lvl
if tempCfg.floor==cLvCfg.floor then
progressMax=progressMax+tempCfg.xiuwei
progressValue=progressValue+tempCfg.xiuwei
else
break
end
end

local checkSectLv=sectlv==nil or zmLv>=sectlv
local checkGen=generation==nil or curGen>=generation
local tempLv=0
local tempExp=data.aExpMax
if tempExp>=deltaExp and(deltaExp>0 or checkSectLv)then
tempLv=1
end
tempExp=tempExp-deltaExp
if checkSectLv and checkGen then
local lastLv=sectlv
local lastGen=generation
for i=data.sLv+1,#lvCfg do
local tempCfg=lvCfg[i]

local isfull=lingshouModel.checkJJFullEx(i,curGen)
if not isfull and tempCfg.xiuwei>0 and tempCfg.floor==cLvCfg.floor and(lastLv==nil or zmLv>=lastLv)and(lastGen==nil or curGen>=lastGen)then
progressMax=progressMax+tempCfg.xiuwei
table.insert(data.dExpList,tempCfg.xiuwei)
if tempExp>=tempCfg.xiuwei then
tempLv=tempLv+1
end
tempExp=tempExp-tempCfg.xiuwei
lastLv=tempCfg.guild_lvl or lastLv
lastGen=tempCfg.generation or lastGen
else
break
end
end
end

data.progressMax=progressMax
data.progressValue=math.min(progressValue,progressMax)
data.aLvMax=tempLv

self.quickData=data
end

function UILingShouJingJieWin:initQuickPanel(noAnim)
local data=self.quickData

if self:checkShowBroke()then
self:onCloseQuick()
return false
end

if data.aLvMax==0 then
self:onCloseQuick()
return false
end



local valueY=math.floor(data.progressValue/data.progressMax*10000)
local valueG=math.floor((data.progressValue+data.aExp)/data.progressMax*10000)
self.quickProgressBarYellow:setProgressValue(valueY,10000)
self.quickProgressBarGreen:setProgressValue(valueG,10000)
local curStr=data.aExp>0 and FMT.fmt("<color=#76d81e>{0}</color>",data.progressValue+data.aExp)or data.progressValue
local str=FMT.fmt("{0}/{1}",curStr,data.progressMax)
self.quickProgressBarYellow:setChildProgressText(str)

local guid=self.ls_guid
local lsData=lingshouModel:getLingShouData(guid)
local full=lingshouModel.checkJJFullEx(data.sLv,lsData.generation)
self.quickBroke:setActive(self.needBroke or full)
self.quickUseBtn:setActive(not self.needBroke and not full)
self.quickResetBtn:setActive(not self.needBroke and not full)
self.quickCostOther:setActive(not self.needBroke and not full)
self.quickSlider:setActive(not self.needBroke and not full)

self.quickCostView:setActive(false)

if self.quickCostEmptyTween and self.quickCostEmptyTween:IsActive()then
self.quickCostEmptyTween:Kill()
self.quickCostEmptyTween=nil
end

if noAnim then
self.quickCostEmpty:setChildCanvasGroupAlpha(1)
else
self.quickCostEmpty:setChildCanvasGroupAlpha(0)
if not self.needBroke and not full then
self.quickCostEmptyTween=self.quickCostEmpty:setChildCanvasGroupDOFade(1,0.2)
end
end

self.quickCostList:setChildLayoutGroupCreateItems(0)
self.quickCostList:setChildAnchoredPos(0,0)

if not self.needBroke and not full then
local noneCost=#data.costList<=0
self.quickUseBtn:setChildGraphicGray(noneCost)
self.quickResetBtn:setChildGraphicGray(noneCost)
self.quickBegin:setText(lingshouModel.getJJNameEx(data.sLv,2))
self.quickEnd:setText("????")
self.quickSlider:setChildSliderInit(data.aLv,0,data.aLvMax,function(value)
self:onQuickSliderValueChange(value)
end)
self.winlua:ForceLayoutRect(self.quickSliderGroup:getID())
else
self.quickBroke:setText(full and"已满级"or"需要突破境界")
end
return true
end

function UILingShouJingJieWin:onQuickSliderValueChange(value)
if self.quickSliderValue==value and not self.quickSliderChange then return end
local down=value<(self.quickSliderValue or 0)
self.quickSliderValue=value
self.quickSliderChange=nil

if self.quickSliderStop then
self.quickSliderStop=nil
return
end

local data=self.quickData
local oAddExp=data.aExp
data.oAddLv=data.aLv
data.aLv=value
data.aExp=0
local temp=0
for i=1,value do
local dExp=data.dExpList[i]
temp=temp+dExp
end
table.clear(data.costList)
for i,v in ipairs(self.quickGoods)do
local cfg=v[1]
local exp=v[2]
local num=v[3]
local addExp=v[4]
local expNum=math.ceil(temp/addExp)
local useNum=math.min(num,expNum)
if useNum>0 then
data.aExp=data.aExp+addExp*useNum
temp=temp-addExp*useNum
local sort={
cfg.stage or 0,
cfg.color,
-cfg.id,
}
table.insert(data.costList,{cfg,useNum,addExp,sort})
end
end
table.sort(data.costList,function(a,b)
local sortA=a[4]
local sortB=b[4]
for i=1,3 do
local tempA=sortA[i]
local tempB=sortB[i]
if tempA~=tempB then
return tempA>tempB
end
end
return true
end)

local haveAdd=value>0
self.quickCostView:setActive(haveAdd)
if oAddExp<=0 and data.aExp>0 then
self.quickCostEmpty:setChildCanvasGroupAlpha(0)
elseif oAddExp>0 and data.aExp<=0 then
if self.quickCostEmptyTween and self.quickCostEmptyTween:IsActive()then
self.quickCostEmptyTween:Kill()
self.quickCostEmptyTween=nil
end
self.quickCostEmpty:setChildCanvasGroupAlpha(0)
self.quickCostEmptyTween=self.quickCostEmpty:setChildCanvasGroupDOFade(1,0.2)
end

self.quickUseBtn:setChildGraphicGray(not haveAdd)
self.quickResetBtn:setChildGraphicGray(not haveAdd)

local endStr="????"
if haveAdd then
local tLv=data.sLv+data.aLv
local sFloor=lingshouModel.getJJFloor(data.sLv)
local tFloor=lingshouModel.getJJFloor(tLv)
if sFloor~=tFloor then
endStr=FMT.fmt("{0}圆满",lingshouModel:getJJFloorName(sFloor))
else
endStr=lingshouModel.getJJNameEx(tLv,2)
end
local costCnt=#data.costList
self.quickCostList:setChildLayoutGroupCreateItems(costCnt,function(index)
self:initQuickCostItem(index)
end)

end
self.quickEnd:setText(endStr)
self.winlua:ForceLayoutRect(self.quickSliderGroup:getID())
local valueG=math.floor((data.progressValue+data.aExp)/data.progressMax*10000)
local curStr=data.aExp>0 and FMT.fmt("<color=#76d81e>{0}</color>",data.progressValue+data.aExp)or data.progressValue
local str=FMT.fmt("{0}/{1}",curStr,data.progressMax)
self.quickProgressBarGreen:setProgressValue(valueG,10000)
self.quickProgressBarYellow:setChildProgressText(str)


end

function UILingShouJingJieWin:initQuickCostItem(index)
local quickData=self.quickData
local item=self.quickCostList:getChildLayoutGroupGridItem(index-1)
local data=quickData.costList[index]
local cfg=data[1]
local num=data[2]
local conf={itemid=cfg.id,itemcount=num,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)



item:SetChildLongPress(1,0,function(id)
self:onClickQuickCostItemDeletePressCallback(index)
end,function()
self:onClickQuickCostItemDeletePressFinish()
end)
end

function UILingShouJingJieWin:onClickQuickCostItemDeletePressCallback(index)
local num=1
if self.quickCostItemDeletePress~=nil then
local cur=Time.realtimeSinceStartup
local lerp=cur-self.quickCostItemDeletePress
if lerp>=10 then
num=100
elseif lerp>=6 then
num=50
elseif lerp>=3 then

num=10
elseif lerp>=2 then

num=5
end
else
self.quickCostItemDeletePress=Time.realtimeSinceStartup
end
self:onClickQuickCostItemDelete(index,num)
end

function UILingShouJingJieWin:onClickQuickCostItemDeletePressFinish()
self.quickCostItemDeletePress=nil
end

function UILingShouJingJieWin:onClickQuickCostItemDelete(index,minus)
local quickData=self.quickData
local data=quickData.costList[index]
local num=data[2]
num=math.max(num-minus,0)
local _num=data[2]-num
data[2]=num
local tempExp=quickData.aExp-data[3]*_num
local tempLv=0
local oldLv=quickData.aLv
local oAddExp=quickData.aExp
quickData.aExp=tempExp
for i,v in ipairs(quickData.dExpList)do
if tempExp>=v then
tempLv=i
tempExp=tempExp-v
else
break
end
end
quickData.oAddLv=quickData.aLv
quickData.aLv=tempLv

if num<=0 then
table.remove(quickData.costList,index)
self.quickCostList:setChildLayoutGroupCreateItems(#quickData.costList,function(index)
self:initQuickCostItem(index)
end)
else
local item=self.quickCostList:getChildLayoutGroupGridItem(index-1)
local prop={}
prop[PropIndex(DataPropKey.eWidgetText,3)]=tostring(num)
item:SetChildPropData(0,prop)
end

local costCnt=#quickData.costList
local haveCost=costCnt>0
self.quickCostView:setActive(haveCost)

if oAddExp<=0 and quickData.aExp>0 then
self.quickCostEmpty:setChildCanvasGroupAlpha(0)
elseif oAddExp>0 and quickData.aExp<=0 then
if self.quickCostEmptyTween and self.quickCostEmptyTween:IsActive()then
self.quickCostEmptyTween:Kill()
self.quickCostEmptyTween=nil
end
self.quickCostEmpty:setChildCanvasGroupAlpha(0)
self.quickCostEmptyTween=self.quickCostEmpty:setChildCanvasGroupDOFade(1,0.2)
end

self.quickUseBtn:setChildGraphicGray(not haveCost)
self.quickResetBtn:setChildGraphicGray(not haveCost)

if oldLv~=tempLv then
local tLv=quickData.sLv+quickData.aLv
local sFloor=lingshouModel.getJJFloor(quickData.sLv)
local tFloor=lingshouModel.getJJFloor(tLv)
local endStr=""
if haveCost then
if sFloor~=tFloor then
endStr=FMT.fmt("{0}圆满",lingshouModel:getJJFloorName(tFloor))
else
endStr=lingshouModel.getJJNameEx(tLv,2)
end
end
self.quickEnd:setText(endStr)
self.winlua:ForceLayoutRect(self.quickSliderGroup:getID())
self.quickSliderStop=true
self.quickSliderChange=true
self.quickSlider:setChildSliderValue(quickData.aLv)
end

local valueG=math.floor((quickData.progressValue+quickData.aExp)/quickData.progressMax*10000)
local curStr=quickData.aExp>0 and FMT.fmt("<color=#76d81e>{0}</color>",quickData.progressValue+quickData.aExp)or quickData.progressValue
local str=FMT.fmt("{0}/{1}",curStr,quickData.progressMax)
self.quickProgressBarGreen:setProgressValue(valueG,10000)
self.quickProgressBarYellow:setChildProgressText(str)


end

function UILingShouJingJieWin:doQuickEnterAnim()
self.quickRoot:setChildCanvasGroupAlpha(0)
local cb=function()
if not _this or not _this.isVisible then return end
self.quickLoad=true
self:delayDo(0.3,function()
if not _this or not _this.isVisible then return end
self.quickRoot:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
if self.quickLoad then
self.winlua:SetChildModelAnimationStop(self.quickBg:getID(),eAnimationID.bd_stand,0)
self.quickBg:setChildModelAnimationState(eAnimationID.bd_stand,1)
cb()
else
self.quickBg:setChildUIModelShowTarget(3037,1,{},eAnimationID.bd_stand,false,false,0,cb)
end
end

function UILingShouJingJieWin:onQuickAddBtn()
local curSlinder=self.quickSliderValue or 0
local data=self.quickData
local max=data.aLvMax
if curSlinder<max then
self.quickSlider:setChildSliderValue(curSlinder+1)
end
end

function UILingShouJingJieWin:doQuickUse()
local sendList={}
local quickData=self.quickData
local total=0
for i,v in ipairs(quickData.costList)do
total=total+v[2]
end

local tLv=quickData.sLv+quickData.aLv
local sFloor=lingshouModel.getJJFloor(quickData.sLv)
local tFloor=lingshouModel.getJJFloor(tLv)
local sameFloor=sFloor==tFloor
local addShowLv=sameFloor and quickData.aLv or(quickData.aLv-1)
local showLv=sameFloor and tLv or(tLv-1)

local cosume={1,0}
local upBroke={1,0}
for i=0,total,_quickUseUnit do
local sum=math.min(total-i,_quickUseUnit)
local sendUnit={}
while sum>0 do
local since=cosume[2]
local index=cosume[1]
local costData=quickData.costList[index]
local least=costData[2]-since
if sum>=least then
cosume[1]=index+1
cosume[2]=0
table.insert(sendUnit,{costData[1].id,least})
else
cosume[2]=cosume[2]+sum
table.insert(sendUnit,{costData[1].id,sum})
end
sum=sum-least
end

table.insert(sendList,sendUnit)
end

self.waitQuickUse={
list=sendList,

auto=false
}

local count=#sendList
local reqFunc=function(index)
local list=sendList[index]
local array={}
local temp={}
for i,v in ipairs(list)do
table.insert(array,{self.ls_guid,v[1],v[2]})
temp[FMT.fmt("{0}_{1}",v[1],v[2])]=true
end

bagProtocolControl.req_lingshou_use_item_list(#array,array)


if self.waitQuickUse.auto and index==#sendList then



end
self.waitQuickProto={
items=temp,
auto=self.waitQuickUse.auto,
}
end
if count>0 then
local completeFunc=function()
self:closeWindow("UICommonLoadingWinEx")
self:getQuickData()
self:onCloseQuick()





self.waitQuickUse=nil
self.waitQuickProto=nil

end
local overFunc=function()
self.waitQuickUse=nil
self.waitQuickProto=nil

self:closeWindow("UICommonLoadingWinEx")
self:onCloseQuick()
UIManager.info("升级处理超时中断")
end
local checkFunc=function()
return self.waitQuickProto==nil
end
local args={
title="正在升级",
count=count,
onSeg=reqFunc,
onComplete=completeFunc,
onOver=overFunc,
onCheck=checkFunc,
effect=20456,
}
self:showWindow("UICommonLoadingWinEx",args)

end
end

function UILingShouJingJieWin:onQuickSubBtn()
local curSlinder=self.quickSliderValue or 0
if curSlinder>0 then
self.quickSlider:setChildSliderValue(curSlinder-1)
elseif#self.quickData.costList>0 then
self.quickSliderValue=nil
self.quickSlider:setChildSliderValue(0)
end
end

function UILingShouJingJieWin:onCloseQuick()
self.quickData=nil
self.quickPanel:setActive(false)
self.quickMask:setActive(false)
self.curlv=nil
self:refresh(true)
end

function UILingShouJingJieWin:onQuickResetBtn()
if self.quickData and self.quickData.aExp>0 then
self:getQuickData()
self:initQuickPanel()
end
end

function UILingShouJingJieWin:onQuickMask()
return self:onCloseQuick()
end

function UILingShouJingJieWin:onQuickUseBtn()

if self.needBroke then
UIManager.info("需要先突破境界")
return
end

local quickData=self.quickData
if quickData then
if quickData.aExp>0 then
local callback=function()
self:doQuickUse()
end

if dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eDiscipleQuickUseDanYao)then
callback()
else
local tLv=quickData.sLv+quickData.aLv
local sFloor=lingshouModel.getJJFloor(quickData.sLv)
local tFloor=lingshouModel.getJJFloor(tLv)
local sameFloor=sFloor==tFloor
local beforeTx=lingshouModel.getJJNameEx(quickData.sLv,2)
local afterTx=sameFloor and lingshouModel.getJJNameEx(tLv,2)or FMT.fmt("{0}圆满",UIDiscipleModel:getJJFloorName(sFloor))
local show_data={
type='UIDialougeLevelUp',
title='提示',
content="是否消耗大量丹药进行修为快速升级",
beforeTx=beforeTx,
afterTx=afterTx,
oktext='确定',
canceltext='取消',
okcallback=callback,
choosetext="今日不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eDiscipleQuickUseDanYao,flag)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
else
UIManager.info("请先选择境界")
end
end
end

function UILingShouJingJieWin:checkWaitQuickProto()
if self.waitQuickProto and next(self.waitQuickProto.items)==nil and not self.waitQuickProto.auto then
self.waitQuickProto=nil
end
end

function UILingShouJingJieWin:onCostItemLongClick(itemid,index,guid,attach)
if itemid==-1 then return end
local need=self.gainTable[itemid]or 0
if gainControl:showGainWin(itemid,need)then return end
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end

function UILingShouJingJieWin:onSliderRefresh(b_num)
if self.selectCostNum==nil then return end
local num=math.floor(b_num)
local temp=num+0.5
if b_num>=temp then
num=num+1
end
if num==self.selectCostNum then return end
self.selectCostNum=num
self:refreshSelectExp()
self:refreshSliderCostNum()
self:refreshView()
end

function UILingShouJingJieWin:onSliderLeftBtn()
if self.lockSlider then return end
if self.selectCostNum==nil then return end
local num=self.selectCostNum
if num<=1 then return end
num=num-1
self.selectCostNum=num
self.costWidget:SetChildSliderRefresh(1,num)
self:refreshSelectExp()
self:refreshSliderCostNum()
self:refreshView()
end

function UILingShouJingJieWin:onSliderRightBtn()
if self.lockSlider then return end
if self.selectCostNum==nil then return end
local num=self.selectCostNum
if num>=self.selectCostMaxNum then return end
num=num+1
self.selectCostNum=num
self.costWidget:SetChildSliderRefresh(1,num)
self:refreshSelectExp()
self:refreshSliderCostNum()
self:refreshView()
end






function UILingShouJingJieWin:onUpBtn()
self:showLianHuaItemEffect()
bagProtocolControl.req_lingshou_use_item(self.ls_guid,self.selectCostItemID,self.selectCostNum)
end

function UILingShouJingJieWin:onBrokeBtn()
local guid=self.ls_guid
local lsData=lingshouModel:getLingShouData(guid)
local lscfg=lsData.cfg

if not lingshouModel:checkJJBrokeCondition(lsData.jj_lvl,lsData.generation,true)then
return
end


if not lingshouModel:checkJJEnoughBroke(lsData.jj_lvl,true)then
return
end
lingshouController:reqJJBroke(guid)
end

function UILingShouJingJieWin:rec_broke(guid)
self.lianHuaBrokeEffect:setChildShowEffect(10060,true)

self:refresh(true)
end

function UILingShouJingJieWin:rec_awake(guid)
self:onShow({ls_guid=guid})
end


function UILingShouJingJieWin:onGoodUpBtnClick(idx,itemID)
if lingshouModel:checkNoOptState(self.ls_guid)then return end
if not self:checkGoodUpUseCondition(idx,itemID)then
self:stopItemLongPress(idx)
return
end
local num=1
if self.useGoodTime~=nil then
local cur=Time.realtimeSinceStartup
local lerp=cur-self.useGoodTime
if lerp>=10 then
num=100
elseif lerp>=6 then
num=50
elseif lerp>=3 then

num=10
elseif lerp>=2 then

num=5
end
else
self.useGoodTime=Time.realtimeSinceStartup
end
local max=bagModel.getItemCountById(itemID)
if num>max then
num=max
end
self.useItemID=itemID

bagProtocolControl.req_lingshou_use_item(self.ls_guid,itemID,num)
end

function UILingShouJingJieWin:onGoodUpBtnClick_fn(idx,itemID)
self.useGoodTime=nil
self:recordClickCount()
end

function UILingShouJingJieWin:onJumpBtn()
local goFunc=function()
local jumpParam={type=0,id=502,args={page=4}}
local flag=jumpManager:jump(jumpParam)
return flag
end
UIFullCommonControl:showWindow_BackLingShouMain(goFunc,self.ls_guid)
end

function UILingShouJingJieWin:onQuickBtn()
if lingshouModel:checkNoOptState(self.ls_guid)then return end

local curlv=self.curlv
local curexp=self.curexp
local jjCfg=cfgHelper.get1(cfg_lingshoujingjieconfig_get,curlv)
local nxjjexp=jjCfg.xiuwei
local isPassCnd,needZmLv=self:checkJJZmLevelCnd()
if not isPassCnd then
UIManager.info(FMT.fmt('宗门等级需达到{0}级',needZmLv))
return
end


if self.needBroke then
UIManager.info("需要先突破境界")
return
end

if self.quickGoods==nil then
self:getCostList()
end
local canAddMax=self:getCostListCanAddMax()
local deltaExp=nxjjexp-curexp
if canAddMax<deltaExp then
UIManager.info("当前丹药不足以提升一级")
return
end

self.quickPanel:setActive(true)
self.quickMask:setActive(true)
self:getQuickData(canAddMax)
self:initQuickPanel()

self:doQuickEnterAnim()

end

function UILingShouJingJieWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=TIPS_MOVE_POS.eLeft})
end
end



function UILingShouJingJieWin:doLianHuaAnim()

end

function UILingShouJingJieWin:startBehavior()
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

function UILingShouJingJieWin:stopBehavior()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end


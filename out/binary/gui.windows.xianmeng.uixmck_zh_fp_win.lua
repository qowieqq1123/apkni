







def_class("UIXMCK_ZH_FP_Win",UIWindowBase)









function UIXMCK_ZH_FP_Win:bindComponents()

self.tab_1=UIObject.get(self,0)
self.tab_2=UIObject.get(self,1)
self.title=UIText.get(self,2)
self.ZHRoot=UIObject.get(self,3)
self.ZHItemScrollView=UIObject.get(self,4)
self.ZHItemPanel=UIObject.get(self,5)
self.costItemScrollView=UIObject.get(self,6)
self.costItemContent=UIObject.get(self,7)
self.targetItem=UIBaseItem.get(self,8)
self.selectCntSlider=UIObject.get(self,9)
self.handleImg=UIObject.get(self,10)
self.handleImgCenter=UIObject.get(self,11)
self.selectCntText=UIText.get(self,12)
self.subBtn=UIButton.get(self,13)
self.addBtn=UIButton.get(self,14)
self.maxBtn=UIButton.get(self,15)
self.zhBtn=UIButton.get(self,16)
self.FPRoot=UIObject.get(self,17)
self.Tips=UIText.get(self,18)
self.kfkcItemScrollView=UILoopListView.new(self,19)
self.kfkcItemPanel=UIObject.get(self,20)
self.noSelectRoot=UIObject.get(self,21)
self.selectFPBtn=UIButton.get(self,22)
self.hasSelectRoot=UIObject.get(self,23)
self.zsImage=UIImage.get(self,24)
self.zsName=UIText.get(self,25)
self.zsFight=UIText.get(self,26)
self.changeFPBtn=UIButton.get(self,27)
self.fpBtn=UIButton.get(self,28)
self.selectItem_1=UIObject.get(self,29)
self.selectItem_2=UIObject.get(self,30)
self.selectItem_3=UIObject.get(self,31)
self.selectItem_4=UIObject.get(self,32)
self.selectItem_5=UIObject.get(self,33)
self.discipleModel=UIObject.get(self,34)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.maxBtn:setButtonClick(function()self:onMaxBtn()end)

self.zhBtn:setButtonClick(function()self:onZhBtn()end)

self.kfkcItemScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.selectFPBtn:setButtonClick(function()self:onSelectFPBtn()end)

self.changeFPBtn:setButtonClick(function()self:onChangeFPBtn()end)

self.fpBtn:setButtonClick(function()self:onFpBtn()end)
self.tab={
self.tab_1,
self.tab_2,
}
self.selectItem={
self.selectItem_1,
self.selectItem_2,
self.selectItem_3,
self.selectItem_4,
self.selectItem_5,
}



end


function UIXMCK_ZH_FP_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tab_1);self.tab_1=nil;
_UIObject_release(self.tab_2);self.tab_2=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.ZHRoot);self.ZHRoot=nil;
_UIObject_release(self.ZHItemScrollView);self.ZHItemScrollView=nil;
_UIObject_release(self.ZHItemPanel);self.ZHItemPanel=nil;
_UIObject_release(self.costItemScrollView);self.costItemScrollView=nil;
_UIObject_release(self.costItemContent);self.costItemContent=nil;
_UIObject_release(self.targetItem);self.targetItem=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.handleImgCenter);self.handleImgCenter=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.maxBtn);self.maxBtn=nil;
_UIObject_release(self.zhBtn);self.zhBtn=nil;
_UIObject_release(self.FPRoot);self.FPRoot=nil;
_UIObject_release(self.Tips);self.Tips=nil;
self.kfkcItemScrollView:deleteSelf();self.kfkcItemScrollView=nil;
_UIObject_release(self.kfkcItemPanel);self.kfkcItemPanel=nil;
_UIObject_release(self.noSelectRoot);self.noSelectRoot=nil;
_UIObject_release(self.selectFPBtn);self.selectFPBtn=nil;
_UIObject_release(self.hasSelectRoot);self.hasSelectRoot=nil;
_UIObject_release(self.zsImage);self.zsImage=nil;
_UIObject_release(self.zsName);self.zsName=nil;
_UIObject_release(self.zsFight);self.zsFight=nil;
_UIObject_release(self.changeFPBtn);self.changeFPBtn=nil;
_UIObject_release(self.fpBtn);self.fpBtn=nil;
_UIObject_release(self.selectItem_1);self.selectItem_1=nil;
_UIObject_release(self.selectItem_2);self.selectItem_2=nil;
_UIObject_release(self.selectItem_3);self.selectItem_3=nil;
_UIObject_release(self.selectItem_4);self.selectItem_4=nil;
_UIObject_release(self.selectItem_5);self.selectItem_5=nil;
_UIObject_release(self.discipleModel);self.discipleModel=nil;
self.tab=nil;
self.selectItem=nil;
end


















local _menu_slot_name='button_dytab'
local tabCfg={
{
name="转化",
showFun=function(win)
win.FPRoot:setActive(false)
win.ZHRoot:setActive(true)
win:refreshZH()
end,
closeFun=function(win)
win.ZHRoot:setActive(false)
end,
refreshFun=function(win)
win:refreshZH()
end,
reddotfun=function()
return false
end,

openfunc=function()
return true
end,
titleName="库房转化",
},
{
name="分配",
showFun=function(win)
win.ZHRoot:setActive(false)
win.FPRoot:setActive(true)
win:initScrollView()
win:refreshFP()
end,
closeFun=function(win)
win.FPRoot:setActive(false)
end,
refreshFun=function(win)
win:refreshFP()
end,
reddotfun=function()
return false
end,

openfunc=function()
local memberData=xianmengModel:getXMMemberData(playerModel:getActorID())
local pos=memberData.pos
return systemModel.isOpen(SYSTEM_DEFINE.eXMKFkuCunFenPei)and xianmengModel.checkPostPrivile(pos,GUILD_PRIVILE_TYPE.gptDistribute)
end,
titleName="库房分配",
},
}

local tabCmp={
model=0,
name=1,
reddot=2,
click=3,
}
local zhItemCmp={
baseItem=0,
select=1,
lockTips=2,
bg=3,
}

local col=4
local maxCount=500


function UIXMCK_ZH_FP_Win:onLoaded(...)
self:bindComponents()
local longPressFunc=function(...)
self:onLongPressBtn(...)
end
self.winlua:SetChildLongPress(self.subBtn:getID(),1,longPressFunc,nil)
self.winlua:SetChildLongPress(self.addBtn:getID(),2,longPressFunc,nil)

local memberData=xianmengModel:getXMMemberData(playerModel:getActorID())
local pos=memberData.pos
local flag=xianmengModel.checkPostPrivile(pos,GUILD_PRIVILE_TYPE.gptDistribute)
self.zhPrivileFlag=flag
self.zhBtn:setActive(flag)
self.Tips:setActive(not flag)
self:initTabs()
self:initZHList()
self.selectFPItemList={}
self.selectFPItemlookup={}
for i,v in ipairs(self.selectItem)do
local widget=v:getWidgetBase()
self.selectFPItemList[i]={widget=widget}
widget:SetChildButtonClick(1,function()
self:onSelectItemAddClick(i)
end)
widget:SetBaseItemClickEvent(0,function()
self:onSelectItemClick(i)
end)
end
end


function UIXMCK_ZH_FP_Win:__delete()
self:unbindComponents()
end




function UIXMCK_ZH_FP_Win:onShow(argtable,afterOnloaded)

if argtable and argtable.tabIndex then
self:onSelectTab(argtable.tabIndex)
else
self:onSelectTab(self.tabIndex or 1)
end
end


function UIXMCK_ZH_FP_Win:onHide()

end

function UIXMCK_ZH_FP_Win:initTabs()
for i,v in ipairs(self.tab)do
if tabCfg[i]and tabCfg[i].openfunc()then
v:setActive(true)
local widget=v:getChildWidgetBase()
local func=function()
widget:SetChildUIModelShowSlotAttachment(0,_menu_slot_name,self.tabIndex==i and'button_dytab_2'or'button_dytab_1')
end
widget:SetChildUIModelShowTarget(tabCmp.model,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
widget:SetChildText(tabCmp.name,tabCfg[i].name)
widget:SetChildActive(tabCmp.reddot,tabCfg[i].reddotfun())
widget:SetChildButtonClick(tabCmp.click,function()
self:onSelectTab(i)
end,true)
else
v:setActive(false)
end
end
end


function UIXMCK_ZH_FP_Win:onSelectTab(tabIndex)
if tabIndex==self.tabIndex then return end
if self.tabIndex then
local oldTab=self.tab[self.tabIndex]
local oldWidget=oldTab:getChildWidgetBase()
oldWidget:SetChildUIModelShowSlotAttachment(0,_menu_slot_name,'button_dytab_1')
tabCfg[self.tabIndex].closeFun(self)
end
self.tabIndex=tabIndex
local curTab=self.tab[tabIndex]
local curWidget=curTab:getChildWidgetBase()
curWidget:SetChildModelAnimationState(0,eAnimationID.common_window_dianji)
curWidget:SetChildUIModelShowSlotAttachment(0,_menu_slot_name,'button_dytab_2')
self.title:setText(tabCfg[tabIndex].titleName)
tabCfg[self.tabIndex].showFun(self)
end

function UIXMCK_ZH_FP_Win:initZHList()
self.ZHList=xianmengController.getZHItemList()
self.ZHWidgetList={}
self.ZHItemPanel:setChildLayoutGroupCreateItems(#self.ZHList,function(index)
local widget=self.ZHItemPanel:getChildLayoutGroupGridItem(index-1)
self.ZHWidgetList[index]=widget
local data=self.ZHList[index]
local itemId=data.itemId
local conf={itemid=itemId,itemcount="",showCountBG=false,showname=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(zhItemCmp.baseItem,prop)
widget:SetBaseItemClickEvent(zhItemCmp.baseItem,function()
itemsComponentHelper.onItemClickEx(itemId)
end)
widget:SetChildButtonClick(zhItemCmp.bg,function()
self:ZHItemClick(index)
end)
widget:SetChildActive(zhItemCmp.select,self.zhSelectIdex==index)
widget:SetChildActive(zhItemCmp.lockTips,data.lockFlag)
if data.lockFlag then
widget:SetChildText(zhItemCmp.lockTips,data.lockTip)
end
widget:SetChildGray(zhItemCmp.bg,data.lockFlag)
widget:SetChildGray(zhItemCmp.baseItem,data.lockFlag)
end)
end

function UIXMCK_ZH_FP_Win:refreshZH()
self:ZHItemClick(self.zhSelectIdex or 1)
end

function UIXMCK_ZH_FP_Win:ZHItemClick(index)
if index==self.zhSelectIdex then
return
end
if self.zhSelectIdex then
local oldwidget=self.ZHItemPanel:getChildLayoutGroupGridItem(self.zhSelectIdex-1)
oldwidget:SetChildActive(zhItemCmp.select,false)
end
self.zhSelectIdex=index
local curwidget=self.ZHItemPanel:getChildLayoutGroupGridItem(self.zhSelectIdex-1)
curwidget:SetChildActive(zhItemCmp.select,true)
self:refreshZH_Right()
end

function UIXMCK_ZH_FP_Win:refreshZH_Right()
local data=self.ZHList[self.zhSelectIdex]
if self.zhPrivileFlag then
if data.lockFlag then
self.zhBtn:setActive(false)
self.Tips:setActive(true)
self.Tips:setText(data.lockTip)
else
self.zhBtn:setActive(true)
self.Tips:setActive(false)
end
end
local costList=data.costList
local maxCnt,isCan=self:getMaxChangeCnt(costList)
self.maxSelectCnt=maxCnt
self.selectCnt=1
self.samllBaseItemList={}
self.costItemContent:setChildLayoutGroupCreateItems(#costList,function(index)
local widget=self.costItemContent:getChildLayoutGroupGridItem(index-1)
local baseItem=widget:GetChildWidgetBase(0)

local itemCfg=costList[index]
local itemId=itemCfg[1]
local baseCostCount=itemCfg[2]
table.insert(self.samllBaseItemList,{baseItem,baseCostCount,itemId})
local cntStr=itemsModel.checkItemEnough(itemId,baseCostCount)and mathHelper.formatNumber(baseCostCount)or FMT.fmt("<color=#C82C2C>{0}</color>",mathHelper.formatNumber(baseCostCount))
local conf={itemid=itemId,itemcount=cntStr,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClickEx(itemId)
end)
end)

local targetItemId=data.itemId
local baseCreateCnt=data.createCnt
local curCnt=baseCreateCnt*self.selectCnt
local conf={itemid=targetItemId,itemcount=curCnt>1 and mathHelper.formatNumber(curCnt)or"",showCountBG=curCnt>1,showname=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.targetItem:setChildPropData(prop)
self.targetItem:setBaseItemClickEvent(function()
itemsComponentHelper.onItemClickEx(targetItemId)
end)
local baseItem=self.targetItem:getWidgetBase()
table.insert(self.samllBaseItemList,{baseItem,baseCreateCnt})
self:initSlider()
end

function UIXMCK_ZH_FP_Win:initSlider()
local maxCnt=self.maxSelectCnt
local minCount=maxCnt==1 and 0 or 1
local curSeclet=self.selectCnt

if curSeclet<minCount then
curSeclet=minCount
self.selectCnt=minCount
end
if curSeclet>maxCnt then
curSeclet=maxCnt
self.selectCnt=maxCnt
end

self.winlua:SetChildImageRaycast(self.handleImg:getID(),maxCnt>1)
self.winlua:SetChildImageRaycast(self.handleImgCenter:getID(),maxCnt>1)
self.winlua:SetChildImageRaycast(self.subBtn:getID(),maxCnt>1)
self.winlua:SetChildImageRaycast(self.maxBtn:getID(),maxCnt>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),curSeclet,minCount,maxCnt,function(value)
self.selectCnt=value
self.selectCntText:setText(value)
for i,v in ipairs(self.samllBaseItemList)do
local baseItem=v[1]
local baseCnt=v[2]
local curCnt=baseCnt*value
baseItem:SetChildActive(2,curCnt>1)

if i==#self.samllBaseItemList then
baseItem:SetChildText(3,curCnt>1 and mathHelper.formatNumber(curCnt)or"")
else
local itemId=v[3]
local cntStr=itemsModel.checkItemEnough(itemId,curCnt)and mathHelper.formatNumber(curCnt)or FMT.fmt("<color=#C82C2C>{0}</color>",mathHelper.formatNumber(curCnt))
baseItem:SetChildText(3,cntStr)
end

end
end)

end

function UIXMCK_ZH_FP_Win:refreshFP()
if not self.selectFPActor then
self.noSelectRoot:setActive(true)
self.hasSelectRoot:setActive(false)
return
end
self.noSelectRoot:setActive(false)
self.hasSelectRoot:setActive(true)
local actorData=self.selectFPActor
playerController:setImage(self.widget,self.discipleModel:getID(),actorData.sex,actorData.iconInfo,true)
self.zsName:setText(actorData.actorname)
local fightnum=tonumber(tostring(actorData.fight))
local fight_str=FMT.fmt('实力：{0}',mathHelper.formatNumber3(fightnum))
self.zsFight:setText(fight_str)
self:setSelectList()
end

function UIXMCK_ZH_FP_Win:restSelectList()
self.selectFPItemlookup={}
for i,v in ipairs(self.selectFPItemList)do
v.itemData=nil
local widget=v.widget
widget:SetChildActive(0,false)
widget:SetChildActive(1,true)
end
end

function UIXMCK_ZH_FP_Win:setSelectList()
for i,v in ipairs(self.selectFPItemList)do
local widget=v.widget
local itemData=v.itemData
if itemData then
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
local conf={itemid=itemData[1],itemcount=itemData[2],showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
else
widget:SetChildActive(0,false)
widget:SetChildActive(1,true)
end
end
end

function UIXMCK_ZH_FP_Win:refreshSelectList(itemid,cnt)
local index=self.selectFPItemlookup[itemid]
if index then
if cnt>0 then
self.selectFPItemList[index].itemData={itemid,cnt}
else
self.selectFPItemList[index].itemData=nil
self.selectFPItemlookup[itemid]=nil
end
else
if cnt<=0 then
return
end
for i,v in ipairs(self.selectFPItemList)do
if not v.itemData then
index=i
break
end
end
if index then
self.selectFPItemlookup[itemid]=index
self.selectFPItemList[index].itemData={itemid,cnt}
else
UIManager.error("列表已满")
return false
end
end
local tartgetData=self.selectFPItemList[index]
local widget=tartgetData.widget
local itemData=tartgetData.itemData
if itemData then
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
local conf={itemid=itemData[1],itemcount=itemData[2],showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
else
widget:SetChildActive(0,false)
widget:SetChildActive(1,true)
end
return true
end

function UIXMCK_ZH_FP_Win:initScrollView()
if self.tabIndex~=2 then
return
end
local bagList=xianmengModel:getkufangBag()
table.sort(bagList,function(a,b)
if self:checkFPFlag(a[1])then
return true
else
return false
end
end)
local row=math.ceil(maxCount/col)
local tempList={}
for i=1,row do
tempList[i]={}
for ii=(i-1)*col+1,i*col do
table.insert(tempList[i],bagList[ii])
end
end
self.subwidgetList={}
self.kfkcItemScrollView:initData("kfkcItemitem",tempList)
end

function UIXMCK_ZH_FP_Win:onFreshAction(index,widget,data)
for i=0,col-1 do
local subwidget=widget:GetChildWidgetBase(i)
local itemCfg=data[i+1]
if itemCfg then
local itemid=itemCfg[1]
local hasSelect=self.selectFPItemlookup[itemid]
local cnt=itemCfg[2]
local cntStr=hasSelect and FMT.fmt("{0}/{1}",cnt)or cnt
self.subwidgetList[itemid]={subwidget,cnt}
if hasSelect then
local tartgetData=self.selectFPItemList[hasSelect]
local selectItemData=tartgetData.itemData
local selectCnt=selectItemData[2]
cntStr=FMT.fmt("{0}/{1}",selectCnt,cnt)
end
local fpFlag=self:checkFPFlag(itemid)
local isShowFPPanel=false
local itemsCfg=itemsConfig.getConfig(itemid)
local tipsType=itemsCfg and itemsCfg.tipsid
if tipsType==TIPS_TYPE.eCommonItem then
isShowFPPanel=true
end
local grayNum=(fpFlag and isShowFPPanel)and 0 or 1
local conf={itemid=itemid,itemcount=cntStr,showCountBG=true,showname=false,gray=grayNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetActive,7)]=false
subwidget:SetChildActive(0,true)

subwidget:SetChildPropData(0,prop)
subwidget:SetBaseItemClickEvent(0,function()
self:ItemClick(itemCfg[1],cnt,subwidget)
end)
subwidget:SetChildActive(1,hasSelect~=nil)
subwidget:SetChildButtonClick(1,function()
self:delItemClick(itemCfg[1],cnt,subwidget)
end)
else
subwidget:SetChildActive(1,false)
subwidget:SetChildActive(0,false)
end
end
end


function UIXMCK_ZH_FP_Win:onStartAction()

end

function UIXMCK_ZH_FP_Win:delItemClick(itemid,maxCnt,subwidget)
if self.selectFPActor then
local hasSelect=self.selectFPItemlookup[itemid]
if hasSelect then
local tartgetData=self.selectFPItemList[hasSelect]
local selectItemData=tartgetData.itemData
local selectCnt=selectItemData[2]
local targetCnt=selectCnt-1
if self:refreshSelectList(itemid,targetCnt)then
local cntStr=targetCnt>0 and FMT.fmt("{0}/{1}",targetCnt,maxCnt)or maxCnt
subwidget:SetChildText(2,cntStr)
subwidget:SetChildActive(1,targetCnt>0)
end
end
else
itemsComponentHelper.onItemClickEx(itemid)
end
end

function UIXMCK_ZH_FP_Win:ItemClick(itemid,maxCnt,subwidget)
if self.selectFPActor then
local hasSelect=self.selectFPItemlookup[itemid]
local targetCnt=1
if hasSelect then
local tartgetData=self.selectFPItemList[hasSelect]
local selectItemData=tartgetData.itemData
local selectCnt=selectItemData[2]

tipsManager.showTips({formType=TIPS_FORM_TYPE.eXMKCFPWin,itemid=itemid,attach={cutCnt=selectCnt}})
else
tipsManager.showTips({formType=TIPS_FORM_TYPE.eXMKCFPWin,itemid=itemid,attach={cutCnt=0}})
end









else
itemsComponentHelper.onItemClickEx(itemid)
end
end

function UIXMCK_ZH_FP_Win:getMaxChangeCnt(costList)
local maxCnt=999
local itemId
for i,v in ipairs(costList)do
local itemid=v[1]
local needCount=v[2]
local hasCount=moneyModel.getMoney(itemid)
local canCnt=math.floor(hasCount/needCount)
if canCnt<=0 and not itemId then
itemId=itemid
end
maxCnt=canCnt<maxCnt and canCnt or maxCnt
end
maxCnt=999<maxCnt and 999 or maxCnt
local isCan=maxCnt~=0
maxCnt=isCan and maxCnt or 1
return maxCnt,isCan,itemId
end




function UIXMCK_ZH_FP_Win:onSelectItemAddClick(index)
UIManager.info("点击左边库房中道具放入")
end

function UIXMCK_ZH_FP_Win:onSelectItemClick(index)
local tartgetData=self.selectFPItemList[index]
if tartgetData and tartgetData.itemData then
local selectItemData=tartgetData.itemData
local itemid=selectItemData[1]
local selectCnt=selectItemData[2]
tipsManager.showTips({formType=TIPS_FORM_TYPE.eXMKCFPWin,itemid=itemid,attach={cutCnt=selectCnt}})
end
end


function UIXMCK_ZH_FP_Win:selectActor(actorData)
self.selectFPActor=actorData
self:restSelectList()
self:initScrollView()
self:refreshFP()
end

function UIXMCK_ZH_FP_Win:onLongPressBtn(id)
if id==1 then
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
else
if self.selectCnt>=self.maxSelectCnt then
return
end
self.selectCnt=self.selectCnt+1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIXMCK_ZH_FP_Win:onSubBtn()

end

function UIXMCK_ZH_FP_Win:onAddBtn()

end

function UIXMCK_ZH_FP_Win:onMaxBtn()
self.selectCnt=self.maxSelectCnt
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end


function UIXMCK_ZH_FP_Win:onZhBtn()
local memberData=xianmengModel:getXMMemberData(playerModel:getActorID())
local pos=memberData.pos
local flag=xianmengModel.checkPostPrivile(pos,GUILD_PRIVILE_TYPE.gptDistribute)
if not flag then
UIManager.error("只有仙盟盟主、副盟主可转化")
return
end
local data=self.ZHList[self.zhSelectIdex]
if data.lockFlag then
UIManager.error("未解锁")
return
end
local costList=data.costList
local maxCnt,isCan,itemid=self:getMaxChangeCnt(costList)
if isCan then
local contentStr="是否消耗仙盟库房以下资源转化为\n{0}？"
local itemConfig=itemsConfig.getConfig(data.itemId)
local color=itemConfig.color
local onestr=FMT.fmt("{0}*{1}",itemConfig.name,self.selectCnt)
local item_name=FMT.cfmt(color,onestr)
contentStr=FMT.fmt(contentStr,item_name)
local itemList={}
for i,v in ipairs(costList)do
itemList[i]={v[1],v[2]*self.selectCnt}
end
local callback=function()
xianmengController:reqItemZH(data.itemId,self.selectCnt)
end
local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content=contentStr,
itemList=itemList,
okcb=callback,
})
dialog:show()

else
UIManager.error(FMT.fmt("仙盟库房{0}不足",itemsConfig.getItemName(itemid)))
gainControl:showGainWin(itemid)
end
end

function UIXMCK_ZH_FP_Win:onSelectFPBtn()
UIManager:showWindow("UIXMFenpeiSelectWin")
end

function UIXMCK_ZH_FP_Win:onChangeFPBtn()
UIManager:showWindow("UIXMFenpeiSelectWin")
end

function UIXMCK_ZH_FP_Win:onFpBtn()
if self.selectFPActor then
local tempList={}
for i,v in ipairs(self.selectFPItemList)do
if v.itemData then
table.insert(tempList,v.itemData)
end
end
if#tempList>0 then

local contentStr="是否将仙盟库房以下资源分配给仙盟成员\n<color=#CA631D>【{0}】</color>？"
local tagetName=self.selectFPActor.actorname
contentStr=FMT.fmt(contentStr,tagetName)
local callback=function()
xianmengController:reqFPItem(self.selectFPActor.actorid,#tempList,tempList)
self:restSelectList()
end
local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content=contentStr,
itemList=tempList,
okcb=callback,
})
dialog:show()

else
UIManager.error("请先放入分配道具")
end
else
UIManager.info("请先选择分配的盟友")
end

end

function UIXMCK_ZH_FP_Win:putItem(itemid,attach)
local fpFlag,tips=self:checkFPFlag(itemid)
if not fpFlag then
UIManager.info(tips)
return
end

if self:refreshSelectList(itemid,attach.selectCnt)then
if self.subwidgetList[itemid]then
local subwidget=self.subwidgetList[itemid][1]
local maxCnt=self.subwidgetList[itemid][2]
local hasSelect=self.selectFPItemlookup[itemid]
if hasSelect then
local tartgetData=self.selectFPItemList[hasSelect]
local selectItemData=tartgetData.itemData
local selectCnt=selectItemData[2]
local cntStr=FMT.fmt("{0}/{1}",selectCnt,maxCnt)
subwidget:SetChildText(2,cntStr)
subwidget:SetChildActive(1,true)
else
subwidget:SetChildText(2,maxCnt)
subwidget:SetChildActive(1,false)
end
end
end

end


function UIXMCK_ZH_FP_Win:checkFPFlag(itemid)
local cfg=cfg_guildconversionconfig_get(itemid)
if not cfg then
return true
end
if cfg.distribution_week_max then
local maxCnt=cfg.distribution_week_max
local curCnt=xianmengModel:getkfZHFPData_FPCnt(itemid)
if curCnt>=maxCnt then
return false,"道具本周已分配数量达到上限，请下周一零点后再尝试"
end
end
if cfg.distri_condition then
for i,v in ipairs(cfg.distri_condition)do
local cdnType=v[1]
local cdnVal=v[2]
if cdnType==1 then
if self.selectFPActor then
if xianmengModel:chexkFSTIsFinsh(self.selectFPActor.actorid)then
return false,"对象祖师已完成飞升台修建，不需要该道具"
end
end
end
end
end
return true
end






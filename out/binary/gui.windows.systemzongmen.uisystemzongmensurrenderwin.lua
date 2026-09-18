







def_class("UISystemZongMenSurrenderWin",UIWindowBase)









function UISystemZongMenSurrenderWin:bindComponents()

self.background=UIButton.get(self,0)
self.infoPanel=UIObject.get(self,1)
self.tModel_7=UIObject.get(self,2)
self.tModel_3=UIObject.get(self,3)
self.tModel_4=UIObject.get(self,4)
self.tModel_1=UIObject.get(self,5)
self.tModel_5=UIObject.get(self,6)
self.tModel_6=UIObject.get(self,7)
self.tModel_2=UIObject.get(self,8)
self.sModel_1=UIObject.get(self,9)
self.sModel_2=UIObject.get(self,10)
self.dealBg=UIObject.get(self,11)
self.sModel_3=UIObject.get(self,12)
self.panel_2=UIObject.get(self,13)
self.closeBtn=UIButton.get(self,14)
self.panel_1=UIObject.get(self,15)
self.titleBg=UIObject.get(self,16)
self.tabList=UIObject.get(self,17)
self.view_3=UIScrollViewSlow.get(self,18)
self.view_2=UIScrollViewSlow.get(self,19)
self.view_1=UIScrollViewSlow.get(self,20)
self.infoTips=UIText.get(self,21)
self.dealTx=UIText.get(self,22)
self.title=UIText.get(self,23)
self.button_2=UIButton.get(self,24)
self.returnBtn_2=UIButton.get(self,25)
self.funcBtn_2=UIButton.get(self,26)
self.button_1=UIButton.get(self,27)
self.returnBtn_1=UIButton.get(self,28)
self.funcBtn_1=UIButton.get(self,29)
self.tab_2=UIButton.get(self,30)
self.tab_1=UIButton.get(self,31)
self.tab_3=UIButton.get(self,32)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.button_2:setButtonClick(function()self:onButton_2()end)

self.returnBtn_2:setButtonClick(function()self:onReturnBtn_2()end)

self.funcBtn_2:setButtonClick(function()self:onFuncBtn_2()end)

self.button_1:setButtonClick(function()self:onButton_1()end)

self.returnBtn_1:setButtonClick(function()self:onReturnBtn_1()end)

self.funcBtn_1:setButtonClick(function()self:onFuncBtn_1()end)

self.tab_2:setButtonClick(function()self:onTab_2()end)

self.tab_1:setButtonClick(function()self:onTab_1()end)

self.tab_3:setButtonClick(function()self:onTab_3()end)
self.tModel={
self.tModel_1,
self.tModel_2,
self.tModel_3,
self.tModel_4,
self.tModel_5,
self.tModel_6,
self.tModel_7,
}
self.sModel={
self.sModel_1,
self.sModel_2,
self.sModel_3,
}
self.panel={
self.panel_1,
self.panel_2,
}
self.view={
self.view_1,
self.view_2,
self.view_3,
}
self.button={
self.button_1,
self.button_2,
}
self.returnBtn={
self.returnBtn_1,
self.returnBtn_2,
}
self.funcBtn={
self.funcBtn_1,
self.funcBtn_2,
}
self.tab={
self.tab_1,
self.tab_2,
self.tab_3,
}



end


function UISystemZongMenSurrenderWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.tModel_7);self.tModel_7=nil;
_UIObject_release(self.tModel_3);self.tModel_3=nil;
_UIObject_release(self.tModel_4);self.tModel_4=nil;
_UIObject_release(self.tModel_1);self.tModel_1=nil;
_UIObject_release(self.tModel_5);self.tModel_5=nil;
_UIObject_release(self.tModel_6);self.tModel_6=nil;
_UIObject_release(self.tModel_2);self.tModel_2=nil;
_UIObject_release(self.sModel_1);self.sModel_1=nil;
_UIObject_release(self.sModel_2);self.sModel_2=nil;
_UIObject_release(self.dealBg);self.dealBg=nil;
_UIObject_release(self.sModel_3);self.sModel_3=nil;
_UIObject_release(self.panel_2);self.panel_2=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.panel_1);self.panel_1=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.view_3);self.view_3=nil;
_UIObject_release(self.view_2);self.view_2=nil;
_UIObject_release(self.view_1);self.view_1=nil;
_UIObject_release(self.infoTips);self.infoTips=nil;
_UIObject_release(self.dealTx);self.dealTx=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.button_2);self.button_2=nil;
_UIObject_release(self.returnBtn_2);self.returnBtn_2=nil;
_UIObject_release(self.funcBtn_2);self.funcBtn_2=nil;
_UIObject_release(self.button_1);self.button_1=nil;
_UIObject_release(self.returnBtn_1);self.returnBtn_1=nil;
_UIObject_release(self.funcBtn_1);self.funcBtn_1=nil;
_UIObject_release(self.tab_2);self.tab_2=nil;
_UIObject_release(self.tab_1);self.tab_1=nil;
_UIObject_release(self.tab_3);self.tab_3=nil;
self.tModel=nil;
self.sModel=nil;
self.panel=nil;
self.view=nil;
self.button=nil;
self.returnBtn=nil;
self.funcBtn=nil;
self.tab=nil;
end















local _this=nil
local _postList={eZongMenPostType.eZhangMen,eZongMenPostType.eJielu,eZongMenPostType.eJieYin}
local _scrList={discipleSrcType.ePlot1,discipleSrcType.ePlot2,discipleSrcType.ePlot3}
local _selfScale={0.9,0.9,0.9}
local _aiList={
"bt_ui_systemzm_surrender_wait",
"bt_ui_systemzm_surrender_expel",
"bt_ui_systemzm_surrender_vassal",
}
local _tabHandle={
{
type=systemZongMenDetailDataPart.eBag,
tips="随机获得宗门<color=#CA631D>【库房】</color>里的道具",
refreshData="refreshData1",
refreshItem="refreshItem1",
viewColNum=4,
dataList=nil,
},
{
type=systemZongMenDetailDataPart.eCangJingGe,
tips="随机获得<color=#CA631D>【藏经阁】</color>里的功法",
refreshData="refreshData2",
refreshItem="refreshItem2",
viewColNum=3,
dataList=nil,
},
{
type=systemZongMenDetailDataPart.eDZList,
tips="以下弟子有概率加入宗门",
refreshData="refreshData3",
refreshItem="refreshItem3",
viewColNum=2,
dataList=nil,
},
}
local _tabCmp={
select=0,
}
local _itemCmp1={
item=0,
gailv=1,
}
local _itemCmp2={
root=-1,
icon=0,
element=1,
name=2,
}
local _itemCmp3={
root=0,
back=1,
dis_name=2,
rawImage=3,
dis_job=4,
dis_desc=5,
lv_Obj=6,
dis_level=7,
}



function UISystemZongMenSurrenderWin:onLoaded(...)
self:bindComponents()
_this=self
for i,v in ipairs(_tabHandle)do
self.view[i]:bindSlowWidget(function(...)
self[v.refreshItem](self,v,...)
end)
self.view[i]:setActive(false)
end
self:addNotify(notifyConfig.onSystemZMSurrenderHanlde,self.onSystemZMSurrenderHanlde)
self:addNotify(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)

self:initPanelList()

self:triggerAnimatorState(0)
end


function UISystemZongMenSurrenderWin:__delete()
self:unbindComponents()
_this=nil
self:removeSelfSpeak()
systemZongMenModel:clearDetailInfo(self.serial)
self:stopTargetAI()
end




function UISystemZongMenSurrenderWin:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
self.infoData=systemZongMenModel:getInfoData(self.serial)
self.infoName=systemZongMenModel:getNameStr(self.infoData.id,self.infoData.nameIdx)
self.title:setText(FMT.fmt("宗门《{0}》",self.infoName))
self:initSelfDisciples()

if systemZongMenModel:checkDetailPartInfo(self.serial,systemZongMenDetailDataPart.eDZList)then
self:initSystemZongMenDisciples()
end
end


function UISystemZongMenSurrenderWin:onHide()

end



function UISystemZongMenSurrenderWin:onBackground()
self:onCloseBtn()
end

function UISystemZongMenSurrenderWin:onCloseBtn()
UIFullSystemZongMenControl:closeWindow(self.__name)
end

function UISystemZongMenSurrenderWin:onReturnBtn_1()
if self:canClickAnyButton()then
self:triggerAnimatorState(12)
end
end

function UISystemZongMenSurrenderWin:onReturnBtn_2()
if self:canClickAnyButton()then
self:triggerAnimatorState(22)
end
end

function UISystemZongMenSurrenderWin:onFuncBtn_1()
if self:canClickAnyButton()then
UIDialogManager.getCommonDialog(nil,FMT.fmt("确认让<color=#CF7843><{0}></color>成为附庸宗门？",self.infoName),function()
systemZongMenController:req_deal_surrender(self.serial,1)
end)
end
end

function UISystemZongMenSurrenderWin:onFuncBtn_2()
if self:canClickAnyButton()then
local _func=function()
UIDialogManager.getCommonDialog(nil,FMT.fmt("确认永久驱逐<color=#CF7843><{0}></color>？\n<color=#FF0000>（被驱逐的宗门将永远消失）</color>",self.infoName),function()
systemZongMenController:req_deal_surrender(self.serial,2)
end)
end

local taskid=XianjieXuanShangModel:getXJXStaskidbyGuid(self.serial)
if taskid then
local xbtaskcfg=cfg_xianjiexuanshangtaskconfig_get(taskid)
local str=FMT.fmt("<color=#CF7843>【{0}】</color>正在执行<color=#CF7843>【{1}】</color>任务，若驱逐此宗门将自动放弃任务，无法领取奖励，是否驱逐？",self.infoName,xbtaskcfg.name)
local showdata=
{
type='UIDialouge',
title='提示',
content=str,
oktext='确定',
canceltext='取消',
allowclickBG='false',
showclosebtn=true,
okcallback=_func,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
_func()
end
end
end

function UISystemZongMenSurrenderWin:onButton_1()
if self:canClickAnyButton()then
self.tab_3:setActive(false)
self:triggerAnimatorState(11)
end
end

function UISystemZongMenSurrenderWin:onButton_2()
if self:canClickAnyButton()then
self.tab_3:setActive(true)
self:triggerAnimatorState(21)
end
end

function UISystemZongMenSurrenderWin:onTab_1()
if self:canClickAnyButton()then
self:onTab(1)
end
end

function UISystemZongMenSurrenderWin:onTab_2()
if self:canClickAnyButton()then
self:onTab(2)
end
end

function UISystemZongMenSurrenderWin:onTab_3()
if self:canClickAnyButton()then
self:onTab(3)
end
end

function UISystemZongMenSurrenderWin:triggerAnimatorState(id)
self.stateId=id
self.winlua:SetChildAnimatorParameter(-1,"tState","int",tostring(id))
self.winlua:SetChildAnimatorParameter(-1,"tTrigger","trigger","")
end

function UISystemZongMenSurrenderWin:onAnimatorStateBegin()

end

function UISystemZongMenSurrenderWin:onAnimatorStateEnd()
local stateType=self.stateId%10
if stateType==1 then
self:onTab(1)
elseif stateType==2 then
self:onTab()
elseif stateType==3 then
if self.handleSelectd then
self:startHandleBt(self.handleSelectd)
end
end
self.stateId=nil
end

function UISystemZongMenSurrenderWin:canClickAnyButton()
return self.stateId==nil and(self.btType==nil or self.btType==1)
end

function UISystemZongMenSurrenderWin:onTab(index)
if self.tabSelect then
local widget=self.tab[self.tabSelect]:getChildWidgetBase()
widget:SetChildActive(_tabCmp.select,false)
self.view[self.tabSelect]:setActive(false)
end

self.tabSelect=index

if self.tabSelect then
local widget=self.tab[self.tabSelect]:getChildWidgetBase()
widget:SetChildActive(_tabCmp.select,true)
self.view[self.tabSelect]:setActive(true)

local handle=_tabHandle[self.tabSelect]
self.infoTips:setText(handle.tips)

if systemZongMenModel:checkDetailPartInfo(self.serial,handle.type)then
self:refreshView()
else
systemZongMenController:req_detailInfo(handle.type,self.serial)
end
end
end

function UISystemZongMenSurrenderWin:refreshView()
local handle=_tabHandle[self.tabSelect]
self[handle.refreshData](self,handle)
local view=self.view[self.tabSelect]
local count=#handle.dataList
view:freshSlowGrids(count,math.ceil(count/handle.viewColNum),handle.viewColNum,false)
end

function UISystemZongMenSurrenderWin:refreshData1(handle)
local detailInfo=systemZongMenModel:getDetailPartInfo(self.serial,handle.type)
local itemList={}
local tempList={}
for i,v in ipairs(detailInfo.itemList or{})do
local itemId=v.param_1
local itemNum=v.param_2
local lock=v.param_3==1
local index=itemId*(lock and 1 or-1)
if not tempList[index]then
local cfg=itemsConfig.getConfig(itemId)
local data={
item=itemId,
num=itemNum,
lock=lock,
dup=cfg.dup,
}
tempList[index]=data
else
local data=tempList[index]
data.num=data.num+itemNum
end
end
for i,v in pairs(tempList)do
local count=math.ceil(v.num/v.dup)
local lastNum=v.num%v.dup
for j=1,count do
local num=v.dup
if lastNum>0 and j==count then
num=lastNum
end
local cfg=itemsConfig.getConfig(v.item)
local data={
item=v.item,
num=v.num,
lock=v.lock,


}
table.insert(itemList,data)
end
end
table.sort(itemList,function(a,b)
if a.color~=b.color then
return a.color>b.color
elseif a.stage~=b.stage then
return a.stage>b.stage
elseif a.item~=b.item then
return a.item>b.item
else
return a.lock
end
end)
handle.dataList=itemList
end

function UISystemZongMenSurrenderWin:refreshData2(handle)
local detailInfo=systemZongMenModel:getDetailPartInfo(self.serial,handle.type)
handle.dataList=detailInfo.gongfaList or{}
end

function UISystemZongMenSurrenderWin:refreshData3(handle)
local detailInfo=systemZongMenModel:getDetailPartInfo(self.serial,handle.type)
local discipleList={}
for i,v in ipairs(detailInfo.discipleList)do
table.insert(discipleList,v)
end
table.sort(discipleList,function(a,b)
local jobA=UIDiscipleModel:getDisciplePostEX(a)
local jobB=UIDiscipleModel:getDisciplePostEX(b)
return jobA<jobB
end)
handle.dataList=detailInfo.discipleList
end

function UISystemZongMenSurrenderWin:refreshItem1(handle,index,item)
local data=handle.dataList[index]
local showCountBG=data.num>1
local countStr=showCountBG and data.num or""
local conf={itemid=data.item,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_itemCmp1.item,prop)
item:SetBaseItemClickEvent(_itemCmp1.item,function(...)
if self:canClickAnyButton()then
itemsComponentHelper.onItemClickEx(...)
end
end)
end

function UISystemZongMenSurrenderWin:refreshItem2(handle,index,item)
local gfId=handle.dataList[index]
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfId)
local elements=UIGongFaModel:getGFElements(gfId)
local elementIcon=ELEMENT_TYPE.getIcon(elements[1])
item:SetChildCSImageSprite(_itemCmp2.element,globalABLookup.global,elementIcon)
item:SetChildText(_itemCmp2.name,cfg.name)
item:SetChildCSImageIcon(_itemCmp2.icon,iconHelper.getGongFaIcon(cfg.icon),false)
item:SetChildButtonClick(_itemCmp2.root,function()
if self:canClickAnyButton()then
UIManager:showWindow('UIGongFaTipsFourWin',{gfID=gfId})
end
end)
end

function UISystemZongMenSurrenderWin:refreshItem3(handle,index,item)
local netData=handle.dataList[index]
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)

local color=imageInfo.color
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData,color)
item:SetChildCSImageSprite(_itemCmp3.back,abname,iconname)

local jobicon=UIDiscipleModel:getJobIconName(imageInfo.job)
item:SetChildCSImageSprite(_itemCmp3.dis_job,globalABLookup.global,jobicon)

item:SetChildText(_itemCmp3.dis_name,netData.disciplename)

comHelper.setChildModelRawImageEx(_itemCmp3.rawImage,item,modelParams,eHeadCenterType.eHead,nil,false)

item:SetChildCSImageSprite(_itemCmp3.lv_Obj,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netData.jingjielv)
item:SetChildText(_itemCmp3.dis_level,lv_str)

local post=UIDiscipleModel:getDisciplePostEX(netData)
item:SetChildText(_itemCmp3.dis_desc,eZongMenPostType.getName(post))

item:SetChildButtonClick(_itemCmp3.root,function()
if self:canClickAnyButton()then
UIFullSystemZongMenControl:showOtherDiscipleWin(netData.discipleguid,handle.dataList)
end
end)
end
function UISystemZongMenSurrenderWin:initPanelList()
local ruleList=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"vassalRule")
self.panel_1:setChildLayoutGroupCreateItems(#ruleList,function(index)
local item=self.panel_1:getChildLayoutGroupGridItem(index-1)
local str=ruleList[index]
item:SetChildText(-1,str)
end)
self.winlua:ForceLayoutRect(self.panel_1:getID())

ruleList=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"expelRule")
self.panel_2:setChildLayoutGroupCreateItems(#ruleList,function(index)
local item=self.panel_2:getChildLayoutGroupGridItem(index-1)
local str=ruleList[index]
item:SetChildText(-1,str)
end)
self.winlua:ForceLayoutRect(self.panel_2:getID())
end

function UISystemZongMenSurrenderWin:initSelfDisciples()
for i,v in ipairs(self.sModel)do
local post=_postList[i]
local scr=_scrList[i]
local list=UIDiscipleModel:getDiscipleByZongMenPost(post)or{}
local netData=#list>0 and list[1]or UIDiscipleModel:findSrcTypeDisciple(scr)
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
v:setChildUIModelShowTarget(modelParams.body,_selfScale[i],modelParams.componets,eAnimationID.stand,false,false,0)
v:setChildUIModelShowFlipX(true)
end
end

function UISystemZongMenSurrenderWin:initSystemZongMenDisciples()
if self.tDisciples then return end
local detailInfo=systemZongMenModel:getDetailPartInfo(self.serial,systemZongMenDetailDataPart.eDZList)
local oList=detailInfo.discipleList or{}
local discipleList={}
self.discipleLookup={}
self.imageInfoLookup={}
for i,v in ipairs(oList)do
table.insert(discipleList,v)
self.discipleLookup[tostring(v.discipleguid)]=v
end
table.sort(discipleList,function(a,b)
local jobA=UIDiscipleModel:getDisciplePostEX(a)
local jobB=UIDiscipleModel:getDisciplePostEX(b)
return jobA<jobB
end)

self.tDisciples={}
for i,v in ipairs(self.tModel)do
local netData=discipleList[i]
self.tDisciples[i]=netData
if netData then
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
self.imageInfoLookup[i]=imageInfo
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
if deviceHelper.getAPILevel()>=3 and modelParams.componets[1]~=nil then
local body=imageInfo.sex==1 and 141021 or 241021
v:setChildUIModelShowTarget(body,0.9,nil,eAnimationID.stand,false)
v:setChildAddSkeletonSlot("tou1","head",modelParams.componets[1])
else
v:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,eAnimationID.stand,false,false,0)
end
else
v:setChildUIModelRemoveTarget()
end
end

if#self.tDisciples>0 then
self.waitLib1={}
self.waitRandom1=nil
local count=#self.tDisciples
for i=1,math.min(3,count)do
table.insert(self.waitLib1,i)
end
if count>4 then
self.waitLib2={}
self.waitRandom2=nil
for i=4,count do
table.insert(self.waitLib2,i)
end
else
for i=4,count do
table.insert(self.waitLib1,i)
end
end

local args={
widget=self.winlua,
}
self:setTargetAI(1,args)
self:setSelfSpeak("surrenderSpeak")
end
end

function UISystemZongMenSurrenderWin:setSelfSpeak(colName)
local lib=cfgHelper.get2(cfg_syssectbaseconfig_get,1,colName)
local r=math.random(1,#lib)
local content=lib[r]
local parent=self.winlua:GetCommonComponent(self.sModel_1:getID(),'Transform')
if self.sHUD then
local hudWidget=_InstantiateManager.GetComponent(self.sHUD,'CSGUIWidgetBase')
local txt=chatEmotHelper.decodeEmot(content)or''
hudWidget:SetChildText(0,txt)
else
self.sHUD=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleSpeak,parent,function(id)
if self.sHUD==id then
local hudWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local offsetVal=Vector2.New(0,45)
hudWidget:SetChildAnchoredPosition(2,offsetVal)
local txt=chatEmotHelper.decodeEmot(content)or''
hudWidget:SetChildText(0,txt)
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(1)
hudWidget:SetChildCSImageSprite(1,abName,skinName)
else
hudControl:removeHUD(id)
self.sHUD=nil
end
end)
end
end

function UISystemZongMenSurrenderWin:removeSelfSpeak()
if self.sHUD then
_InstantiateManager.RemoveInstance(self.sHUD)
self.sHUD=nil
end
end

function UISystemZongMenSurrenderWin:stopTargetAI()
if self.ai then
behaviorManager:removeBehaviorTree(self.ai)
self.ai=nil
end
end

function UISystemZongMenSurrenderWin:setTargetAI(type,args)
args=args or{}
local aiName=_aiList[type]
self:stopTargetAI()
self.btType=type
if aiName then
self.ai=behaviorManager:addBehaviorTree(aiName,nil,true,args,true)
end
end

function UISystemZongMenSurrenderWin:randomTargetJobSpeak(job,colName)
local lib=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,job,colName)
local r=math.random(1,#lib)
return lib[r]
end

function UISystemZongMenSurrenderWin:randomTargetWaitSpeak(bt)
local old=self.waitRandom1
local r=math.random(1,#self.waitLib1)
self.waitRandom1=table.remove(self.waitLib1,r)

local job=self.imageInfoLookup[self.waitRandom1].job
local str=self:randomTargetJobSpeak(job,"systemZM_surrender")
bt:setSharedVar("model1",self.tModel[self.waitRandom1]:getID())
bt:setSharedVar("speak1",str)
if old then
table.insert(self.waitLib1,old)
end

if self.waitLib2 then
old=self.waitRandom2
r=math.random(1,#self.waitLib2)
self.waitRandom2=table.remove(self.waitLib2,r)
job=self.imageInfoLookup[self.waitRandom2].job
str=self:randomTargetJobSpeak(job,"systemZM_surrender")
bt:setSharedVar("model2",self.tModel[self.waitRandom2]:getID())
bt:setSharedVar("speak2",str)
if old then
table.insert(self.waitLib2,old)
end
end
end

function UISystemZongMenSurrenderWin:onExpelAnimation(bt)
self.ai=nil

local discipleCB=function()
if#self.recruitList>0 then
local disciples={}
for i,v in ipairs(self.recruitList)do
table.insert(disciples,self.discipleLookup[tostring(v.discipleguid)])
end
local args={
serial=self.serial,
parentWin=self,
disciples=disciples,
callback=function()
self:onCloseBtn()
end,
}
self:showWindow("UISystemZongMenJoinWin",args)
else
self:onCloseBtn()
end
end
local rewards=self.handleSelectd[3]
if rewards and#rewards>0 then
showPrizeControl.showWindow(rewards,discipleCB)
else
discipleCB()
end
end

function UISystemZongMenSurrenderWin:onVassalAnimation(bt)

local rewards=self.handleSelectd[3]
if rewards and#rewards>0 then
showPrizeControl.showWindow(rewards,function()
self:onCloseBtn()
end)
else
self:onCloseBtn()
end
end

function UISystemZongMenSurrenderWin:randomTargetVassalSpeak(bt)
local count=math.min(#_this.tDisciples,4)
local list={}
for i,v in pairs(self.tDisciples)do
local r=math.random(1,#list+1)
table.insert(list,r,i)
end

for i=1,4 do
local modelCmp=nil
local speakStr=nil
local r=list[i]
if r then
local job=self.imageInfoLookup[r].job
speakStr=self:randomTargetJobSpeak(job,"systemZM_vassal")
modelCmp=self.tModel[r]:getID()

end
bt:setSharedVar(FMT.fmt("model{0}",i),modelCmp)
bt:setSharedVar(FMT.fmt("speak{0}",i),speakStr)
end
end

function UISystemZongMenSurrenderWin:startHandleBt(handleInfo)
local newFlag=handleInfo[1]
local discipleList=handleInfo[2]
local rewards=handleInfo[3]
if newFlag==systemZongMenFightFlagType.eVassal then

local args={}
args.widget=_this.winlua
args.model0=_this.sModel_1:getID()
_this:setTargetAI(3,args)
elseif newFlag==systemZongMenFightFlagType.eExpel then

_this.recruitList=discipleList or{}
_this.recruitLookup={}
for i,v in ipairs(_this.recruitList)do
_this.recruitLookup[tostring(v.discipleguid)]=i

end

local args={}
args.widget=_this.winlua
args.model0=_this.sModel_1:getID()
for i,v in ipairs(_this.tModel)do
local netData=_this.tDisciples[i]
if netData then

local join=_this.recruitLookup[tostring(netData.discipleguid)]~=nil
args[FMT.fmt("model{0}",i)]=v:getID()
args[FMT.fmt("join{0}",i)]=join
local job=_this.imageInfoLookup[i].job
local str=_this:randomTargetJobSpeak(job,join and"systemZM_expel_join"or"systemZM_expel_unjoin")
args[FMT.fmt("speak{0}",i)]=str
end
end
_this:setTargetAI(2,args)
end
end

function UISystemZongMenSurrenderWin.onSystemZMSurrenderHanlde(serial,newFlag,discipleList,rewards)
if _this.serial==serial and not _this.handleSelectd then
_this.handleSelectd={newFlag,discipleList,rewards}
_this:stopTargetAI()
_this:removeSelfSpeak()
if newFlag==systemZongMenFightFlagType.eVassal then
_this.dealTx:setText(FMT.fmt("附庸宗门<color=#CA631D>《{0}》</color>",_this.infoName))
_this:triggerAnimatorState(13)
elseif newFlag==systemZongMenFightFlagType.eExpel then
_this.dealTx:setText(FMT.fmt("驱逐宗门<color=#CA631D>《{0}》</color>",_this.infoName))
_this:triggerAnimatorState(23)
else
loggerUtil.logErrFMT("未知投降宗门的处理类型：{0}， {1}",tostring(serial),newFlag)
_this:removeSelfSpeak()
end
end
end

function UISystemZongMenSurrenderWin.onSystemZMDetailInfo(partType,serial)
if serial==_this.serial then
if partType==systemZongMenDetailDataPart.eDZList and not _this.tDisciples then
_this:initSystemZongMenDisciples()
return
end

for i,v in ipairs(_tabHandle)do
if v.type==partType then
_this:refreshView()
return
end
end
end
end

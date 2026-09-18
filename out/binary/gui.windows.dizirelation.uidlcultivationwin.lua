







def_class("UIDLCultivationWin",UIWindowBase)









function UIDLCultivationWin:bindComponents()

self.infoPanel=UIObject.get(self,0)
self.selectBtn=UIButton.get(self,1)
self.Mask=UIObject.get(self,2)
self.txtDzSpeak_1=UIText.get(self,3)
self.txtDzSpeak_2=UIText.get(self,4)
self.eventTips=UIObject.get(self,5)
self.effectSX=UIObject.get(self,6)
self.dzSpeak_2=UIObject.get(self,7)
self.dzSpeak_1=UIObject.get(self,8)
self.effectDL=UIObject.get(self,9)
self.effectXL=UIObject.get(self,10)
self.jiuzhiRedot=UIObject.get(self,11)
self.jyModel_2=UIObject.get(self,12)
self.singleBg=UIImage.get(self,13)
self.dzEmpty=UIObject.get(self,14)
self.jyModel_1=UIObject.get(self,15)
self.helpBtn=UIButton.get(self,16)
self.xdTimeBg_1=UIObject.get(self,17)
self.btnDoublerepair=UIButton.get(self,18)
self.xdTimeBg_2=UIObject.get(self,19)
self.costItemScrollView=UIObject.get(self,20)
self.descText1=UIText.get(self,21)
self.tipsBack=UIButton.get(self,22)
self.oppertunityScrollView=UIObject.get(self,23)
self.eventName=UIText.get(self,24)
self.eventDesc=UIText.get(self,25)
self.eventIcon=UIImage.get(self,26)
self.btnSwitch=UIObject.get(self,27)
self.btnSelect=UIObject.get(self,28)
self.dzModel_1=UIObject.get(self,29)
self.dzModel_2=UIObject.get(self,30)
self.shanguang=UIObject.get(self,31)
self.gongfengtai=UIObject.get(self,32)
self.danlu=UIObject.get(self,33)
self.xiulianNameText=UIText.get(self,34)
self.linghunImg=UIObject.get(self,35)
self.zuohuaImg=UIButton.get(self,36)
self.jiuzhiImg=UIButton.get(self,37)
self.effect=UIObject.get(self,38)
self.singlePanel=UIObject.get(self,39)
self.doorRoot=UIObject.get(self,40)
self.event_1=UIButton.get(self,41)
self.event_2=UIButton.get(self,42)
self.event_3=UIButton.get(self,43)
self.cdTimeText_1=UIText.get(self,44)
self.xiuLianRoot=UIObject.get(self,45)
self.Content=UIObject.get(self,46)
self.descText=UIText.get(self,47)
self.cdTimeText_2=UIText.get(self,48)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.btnDoublerepair:setButtonClick(function()self:onBtnDoublerepair()end)

self.tipsBack:setButtonClick(function()self:onTipsBack()end)

self.zuohuaImg:setButtonClick(function()self:onZuohuaImg()end)

self.jiuzhiImg:setButtonClick(function()self:onJiuzhiImg()end)

self.event_1:setButtonClick(function()self:onEvent_1()end)

self.event_2:setButtonClick(function()self:onEvent_2()end)

self.event_3:setButtonClick(function()self:onEvent_3()end)
self.txtDzSpeak={
self.txtDzSpeak_1,
self.txtDzSpeak_2,
}
self.dzSpeak={
self.dzSpeak_1,
self.dzSpeak_2,
}
self.jyModel={
self.jyModel_1,
self.jyModel_2,
}
self.xdTimeBg={
self.xdTimeBg_1,
self.xdTimeBg_2,
}
self.dzModel={
self.dzModel_1,
self.dzModel_2,
}
self.event={
self.event_1,
self.event_2,
self.event_3,
}
self.cdTimeText={
self.cdTimeText_1,
self.cdTimeText_2,
}



end


function UIDLCultivationWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.Mask);self.Mask=nil;
_UIObject_release(self.txtDzSpeak_1);self.txtDzSpeak_1=nil;
_UIObject_release(self.txtDzSpeak_2);self.txtDzSpeak_2=nil;
_UIObject_release(self.eventTips);self.eventTips=nil;
_UIObject_release(self.effectSX);self.effectSX=nil;
_UIObject_release(self.dzSpeak_2);self.dzSpeak_2=nil;
_UIObject_release(self.dzSpeak_1);self.dzSpeak_1=nil;
_UIObject_release(self.effectDL);self.effectDL=nil;
_UIObject_release(self.effectXL);self.effectXL=nil;
_UIObject_release(self.jiuzhiRedot);self.jiuzhiRedot=nil;
_UIObject_release(self.jyModel_2);self.jyModel_2=nil;
_UIObject_release(self.singleBg);self.singleBg=nil;
_UIObject_release(self.dzEmpty);self.dzEmpty=nil;
_UIObject_release(self.jyModel_1);self.jyModel_1=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.xdTimeBg_1);self.xdTimeBg_1=nil;
_UIObject_release(self.btnDoublerepair);self.btnDoublerepair=nil;
_UIObject_release(self.xdTimeBg_2);self.xdTimeBg_2=nil;
_UIObject_release(self.costItemScrollView);self.costItemScrollView=nil;
_UIObject_release(self.descText1);self.descText1=nil;
_UIObject_release(self.tipsBack);self.tipsBack=nil;
_UIObject_release(self.oppertunityScrollView);self.oppertunityScrollView=nil;
_UIObject_release(self.eventName);self.eventName=nil;
_UIObject_release(self.eventDesc);self.eventDesc=nil;
_UIObject_release(self.eventIcon);self.eventIcon=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.dzModel_1);self.dzModel_1=nil;
_UIObject_release(self.dzModel_2);self.dzModel_2=nil;
_UIObject_release(self.shanguang);self.shanguang=nil;
_UIObject_release(self.gongfengtai);self.gongfengtai=nil;
_UIObject_release(self.danlu);self.danlu=nil;
_UIObject_release(self.xiulianNameText);self.xiulianNameText=nil;
_UIObject_release(self.linghunImg);self.linghunImg=nil;
_UIObject_release(self.zuohuaImg);self.zuohuaImg=nil;
_UIObject_release(self.jiuzhiImg);self.jiuzhiImg=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.singlePanel);self.singlePanel=nil;
_UIObject_release(self.doorRoot);self.doorRoot=nil;
_UIObject_release(self.event_1);self.event_1=nil;
_UIObject_release(self.event_2);self.event_2=nil;
_UIObject_release(self.event_3);self.event_3=nil;
_UIObject_release(self.cdTimeText_1);self.cdTimeText_1=nil;
_UIObject_release(self.xiuLianRoot);self.xiuLianRoot=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.cdTimeText_2);self.cdTimeText_2=nil;
self.txtDzSpeak=nil;
self.dzSpeak=nil;
self.jyModel=nil;
self.xdTimeBg=nil;
self.dzModel=nil;
self.event=nil;
self.cdTimeText=nil;
end



















local _this
local _initModel
local _format=string.format

local AIType={
walk=1,
practitioners=2,
totalNum=2
}

local eventTipsX={
{-175,-30},{{-245,-30},{-105,-100}},{{-225,18},{-138,18},{-45,18}}
}


function UIDLCultivationWin:onLoaded(...)
self:bindComponents()
_this=self
self.chuiweiLastType={}
end


function UIDLCultivationWin:__delete()
UIManager:hideWindow('UITopMoneyWin')
self:removesingleBT()
self:removesingleChuiweiId()
self:unbindComponents()
_this=self
end




function UIDLCultivationWin:onShow(argtable,afterOnloaded)
self:onShowArgRecv(argtable,afterOnloaded)




end


function UIDLCultivationWin:onHide()
UIManager:hideWindow('UITopMoneyWin')
self:removesingleBT()
self:removesingleChuiweiId()
uiAIManager:clearUIWinData('UIDLCultivationWin')
end

function UIDLCultivationWin:onShowArgRecv(argtable,afterOnloaded)
self:refresh(argtable)
self:refreshBgModel()
self:refreshRepairBtn()
UIManager:showWindow('UITopMoneyWin',{{72}})
end


function UIDLCultivationWin:refreshBgModel()
local bgModelId=5383
if bgModelId then
local animId=eAnimationID.stand
self.singleBg:setChildUIModelShowTarget(bgModelId,1,{},animId,false,false,0)
self.singleBg:setActive(true)
else
self.singleBg:setActive(false)
self.singleBg:setChildUIModelRemoveTarget()
end
end

function UIDLCultivationWin:refreshRepairBtn()
local id=tostring(self.bdData.un_build_id)
local data=DiscipleCoupleModel:getCoupleLiveId(id)

if tostring(data.dizi_id_1)~="0"and tostring(data.dizi_id_2)~="0"then
local dzData1=UIDiscipleModel:getDiscipleData(data.dizi_id_1)
local dzData2=UIDiscipleModel:getDiscipleData(data.dizi_id_2)

if data.promote_cnt>0 then
self.btnFlag=true
self.bgFlag=true
self.nameFlag=false
else
self.btnFlag=true
self.bgFlag=false
self.nameFlag=true

local name=""
local str=""
local flag1=DiscipleCoupleModel:getPromoteList(data.dizi_id_1)
local flag2=DiscipleCoupleModel:getPromoteList(data.dizi_id_2)

if flag1 and flag2 then
str=string.format("弟子本周已双修",name)
elseif flag1 and not flag2 then
name=dzData1.disciplename
str=string.format("弟子%s已双修",name)
elseif not flag1 and flag2 then
name=dzData2.disciplename
str=string.format("弟子%s已双修",name)
end

if not flag1 and not flag2 then
self.nameFlag=false
self.btnFlag=false
end

self.cdTimeText_2:setText(str)
end
else
self.btnFlag=true
self.bgFlag=false
self.nameFlag=false
end

self.winlua:SetChildButtonEnable(self.btnDoublerepair:getID(),true,self.btnFlag)
self.xdTimeBg_1:setActive(self.bgFlag)
self.xdTimeBg_2:setActive(self.nameFlag)
end

function UIDLCultivationWin:refresh(argtable)

if argtable then
local guid=argtable.entityId
self.sfId=mapIdType.zhufeng
self.bdData=zongmenModel:findBuildingByEntityId(guid)
self.coupleIdList=DiscipleCoupleModel:getCoupleLiveId(self.bdData.un_build_id)
self.cave_config=cfgHelper.get2(cfg_monijydaolvcaveconfig_get,self.bdData.build_id,self.bdData.level)

if self.coupleIdList then
self.dzId1=self.coupleIdList.dizi_id_1
self.dzId2=self.coupleIdList.dizi_id_2
end
end
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.dongFuCfg=cfgHelper.get1(cfg_monijydaolvcaveconfig_get,self.bdData.build_id)
if self.dongFuCfg then
self.curLvCfg=self.dongFuCfg[self.bdData.level]
end

self:refreshLeft()
self:refreshRight()
end

function UIDLCultivationWin:refreshCoupleData()
if self.bdData then
self.coupleIdList=DiscipleCoupleModel:getCoupleLiveId(self.bdData.un_build_id)
if self.coupleIdList then
self.dzId1=self.coupleIdList.dizi_id_1
self.dzId2=self.coupleIdList.dizi_id_2
end
if self.dongFuCfg then
self.curLvCfg=self.dongFuCfg[self.bdData.level]
end
end
end

function UIDLCultivationWin:refreshLeft()
local descText=self.curLvCfg.sxDesc
local descTextStr=comHelper.getCheckLayoutStr(self.descText1:getGameObject(),360,descText,true)
self.descText:setText(descTextStr)

self:refreshRepairPanel()
self:refreshJiYuanPanel()
end

function UIDLCultivationWin:refreshRight()
self:refreshCouplePanel()
local buildName=self.bdData.name or'暂无名字'
self:refreshBuildName(buildName)
end

function UIDLCultivationWin:refreshBuildName(name)
self.xiulianNameText:setText("双修")
end

function UIDLCultivationWin:refreshJiYuanPanel()
for i,v in ipairs(self.event)do
local eCfg=self.curLvCfg.jyTips[i]
if eCfg then
v:setActive(true)
self.winlua:SetChildCSImageIcon(v:getID(),eCfg.icon,false)
else
v:setActive(false)
end
end
end

function UIDLCultivationWin:refreshRepairPanel()
local cost

if self.curLvCfg then
cost=self.curLvCfg.promote_cost
end
local count=#cost

self.costItemScrollView:setChildScrollViewCreateGrids(count,count)
local grids=self.costItemScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local datas=cost[i]
local widget=grids[i-1]
local itemid=datas[1]
local itemcount=datas[2]

local countStr=''
local showCountBG=false
local has=itemsModel.getCount(itemid)
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end

if has<itemcount then
local temp=string.format("<color=#FF2D2D>%s</color>",countStr)
countStr=temp
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end


function UIDLCultivationWin:refreshCouplePanel(notfreshmodel)
self.singlePanel:setActive(true)
local curLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level)
self.shanguang:setActive(curLvCfg.level>=5)
self.gongfengtai:setActive(curLvCfg.level>=4)
self.danlu:setActive(curLvCfg.level>=3)

if self.coupleIdList then
local dzIdStr=tostring(self.dzId1)
local haveDz=dzIdStr~='0'


self.dzModel_1:setActive(haveDz)
self.dzModel_2:setActive(haveDz)
self.jiuzhiImg:setActive(haveDz)

self.linghunImg:setActive(haveDz)
if haveDz then
self.singleDzId=self.coupleIdList
if not notfreshmodel then
if not _initModel then
_initModel=true
self:delayDo(0.5,function(...)
self:refreshCoupleDzModel(self.dzId1,1)
self:refreshCoupleDzModel(self.dzId2,2)
end)
else
self:refreshCoupleDzModel(self.dzId1,1)
self:refreshCoupleDzModel(self.dzId2,2)
end
end
local check=self:checkChuiWei(self.dzId1)
local chuiweiType,num=UIDiscipleModel:checkChuiWeiDiscipleType(self.dzId1)
local cantZuoHua=self:checkCantZuoHua(self.dzId1)
self.jiuzhiImg:setActive(check)


if check then
local jzReddot=self:checkJiuzhiDisciple(self.dzId1)
self.jiuzhiRedot:setActive(jzReddot)
self.chuiweiLastType[dzIdStr]={chuiweiType,num}
else
self.chuiweiLastType[dzIdStr]=nil
end
self.linghunImg:setActive(chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury)
local pos
if chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury then
pos=imageInfo.sex==SEX_TYPE.eMale and Vector2.New(-30,-16)or Vector2.New(-52,-48)
self.linghunImg:setChildAnchoredPosition(pos)
elseif chuiweiType==DISCIPLE_CHUIWEI_TYPE.eShouYuan then
end
else
self:removesingleBT()
self:removesingleChuiweiId()
end
end
end

function UIDLCultivationWin:getSingleBTData()
local stand=math.random(0,1)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
standPos=stand,
offset={0,0},
leftPos={-94,-118},
rightPos={24,-118},
waitflip=0,
}
return initData
end

function UIDLCultivationWin:createSingleDZ(tran,dzId,pos,callback)
local initData=self:getSingleBTData()
local state=UIDiscipleModel:getDiscipleState(dzId)
local scale=0.8
if state==DISCIPLE_STATE_TYPE.eChuiWei then
scale=1
end
local otherData={
scale=scale,
}
uiAIManager:createUIDisciple('UIDLCultivationWin','bt_ui_dldfRoom',dzId,tran,pos,initData,otherData,function(bt)
callback(bt)
end)
end

function UIDLCultivationWin:removesingleBT(index)
if not self.singleBT then return end
if index then
if self.singleBT[index]then
uiAIManager:removeUIInstance(self.singleBT[index])
self.singleBT[index]=nil
end
else
for k,v in ipairs(self.singleBT)do
if v then
uiAIManager:removeUIInstance(v)
v=nil
end
self.singleBT=nil
end
end
end

function UIDLCultivationWin:removesingleChuiweiId()
if self.singleChuiweiId then
_InstantiateManager.RemoveInstance(self.singleChuiweiId)
self.singleChuiweiId=nil
end
end


function UIDLCultivationWin:checkChuiWei(dzId)
local state=UIDiscipleModel:getDiscipleState(dzId)
return state==DISCIPLE_STATE_TYPE.eChuiWei
end

function UIDLCultivationWin:createChuiWeiDZ(dzId,tran,pos,callback)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(dzId)
local body=imageInfo.sex==SEX_TYPE.eMale and 1114105 or 1114106
_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDisciple,tran,function(id)
local dzWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
dzWidget:SetChildAnchoredPosition(0,pos)
local dzScale=isometricMapSystem:getModelScale(body,true)
dzWidget:SetChildUIModelShowTarget(0,body,dzScale*0.8,nil,eAnimationID.stand)
dzWidget:SetChildUIModelShowFlipX(0,true)
callback(id)
end)
end


function UIDLCultivationWin:checkJiuzhiDisciple(dzId)
local chuiweiType=UIDiscipleModel:checkChuiWeiDiscipleType(dzId)
local list={}
if chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury then
list=itemsLookup:get_function_items(item_funtion_type.liaoshang)or{}
elseif chuiweiType==DISCIPLE_CHUIWEI_TYPE.eShouYuan then
list=itemsLookup:get_function_items(item_funtion_type.shouyuan)or{}
end
local itemList={}
for k,v in pairs(list)do
local num=bagModel.getItemCountById(v.id)
if num>0 then
table.insert(itemList,v)
break
end
end
if next(itemList)then
return true
else
return false
end
end

function UIDLCultivationWin:jiuzhiDisciple(dzId)
self:jumpDZChuiWei(dzId)
end

function UIDLCultivationWin:jumpDZChuiWei(dzId)
local dzId_str=tostring(dzId)
local selectFunc=function(netData)
return UIDiscipleModel:checkDiscipleState2(netData.discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)
end
local sortFunc=function(a,b)
local aFight=UIDiscipleModel:getDiscipleFightValue(a.discipleguid)
local bFight=UIDiscipleModel:getDiscipleFightValue(b.discipleguid)
return aFight>bFight
end
local temp=UIDiscipleModel:getSortList(selectFunc,sortFunc)
if#temp>0 then
local list={}
for i,netData in ipairs(temp)do
local data=UIDiscipleModel:getDiscipleDataX(netData.discipleguid)
if netData.discipleguidStr~=dzId_str then
table.insert(list,data)
end
end
local cur=UIDiscipleModel:getDiscipleDataX(dzId)
table.insert(list,1,cur)
UIFullDiscipleMainControl:showWindowInfo({dis_guid=dzId,disciplelist=list})
end
end


function UIDLCultivationWin:checkCantZuoHua(dzId,isWarning)
if not UIDiscipleModel:checkCanKickOutDzAndTips(dzId,isWarning,2)then
return true
end
return false
end

function UIDLCultivationWin:zuohuaDisciple(dzId)
if self:checkCantZuoHua(dzId,true)then
return
end

self:jumpDZChuiWei(dzId)
end


function UIDLCultivationWin:showTipsEvent(index)
self.tipsBack:setActive(true)
self.eventTips:setActive(true)

local count=#self.curLvCfg.jyTips
local xs=eventTipsX[count]
local x=xs[index][1]
local y=xs[index][2]
local tipsData=self.curLvCfg.jyTips[index]
self.eventTips:setChildAnchoredPos(x,y)
self.eventIcon:setImageIcon(tipsData.icon,false)
self.eventName:setText(tipsData.name)
self.eventDesc:setText(tipsData.desc)
self.winlua:ForceLayoutRect(self.eventTips:getID())
end


function UIDLCultivationWin:closeTipsEvent()
self.tipsType=nil
self.eventTips:setActive(false)
self.tipsBack:setActive(false)
end


function UIDLCultivationWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UIDLCultivationWin:refreshCoupleDzModel(dizi_id,index)
if tostring(dizi_id)~='0'then
self:removesingleBT(index)
self:removesingleChuiweiId()
local tran=self.dzModel[index]:getCommonComponent('Transform')
local pos=Vector2.New(-24,-118)
local chuiweiType=UIDiscipleModel:checkChuiWeiDiscipleType(dizi_id)
if chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury then
self:createChuiWeiDZ(dizi_id,tran,pos,function(id)
self.singleChuiweiId=id
end)
else
self.singleBT={}
self.winlua:SetChildUIModelRemoveTarget(self.dzEmpty:getID())
self:createSingleDZ(tran,dizi_id,pos,function(bt)
table.insert(self.singleBT,bt)
end)
end
else
self.winlua:SetChildUIModelRemoveTarget(self.dzEmpty:getID())
end
end

function UIDLCultivationWin:checkTeZhi(data)
for k,v in ipairs(data)do
if v.typo==DISCIPLE_SPECIALITY_TYPE.eDaoLv then
return v.id
end
end
end

function UIDLCultivationWin:showDoubleRepairPanel()
local Effect_1
local Effect_2
local index1=1
local index2=1

local rewardList=DiscipleCoupleModel:getCoupleRepairRewardId(self.bdData.un_build_id)
local diziList={[1]=self.coupleIdList.dizi_id_1,[2]=self.coupleIdList.dizi_id_2}
local sixAttrList={[1]=rewardList.sixAttr1,[2]=rewardList.sixAttr2}
local expList=
{
[1]=
{
[1]={name="<color=#7D3B17>境界修为: </color>",value=rewardList.xiuwei1},
},
[2]=
{
[1]={name="<color=#7D3B17>境界修为: </color>",value=rewardList.xiuwei2},
}
}

if rewardList.lianti1>0 then
index1=index1+1
expList[1][index1]={name="<color=#7D3B17>炼体经验: </color>",value=rewardList.lianti1}
end

if rewardList.lianti2>0 then
index2=index2+1
expList[2][index2]={name="<color=#7D3B17>炼体经验: </color>",value=rewardList.lianti2}
end

if rewardList.sixAttr1.param_2>0 then
index1=index1+1
local str=string.format("<color=#7D3B17>%s: </color>+",UIDiscipleModel:getDiscipleBaseAttrName(rewardList.sixAttr1.param_1))
expList[1][index1]={name=str,value=rewardList.sixAttr1.param_2}
end

if rewardList.sixAttr2.param_2>0 then
index2=index2+1
local str=string.format("<color=#7D3B17>%s: </color>+",UIDiscipleModel:getDiscipleBaseAttrName(rewardList.sixAttr2.param_1))
expList[2][index2]={name=str,value=rewardList.sixAttr2.param_2}
end

local oldSpeList=rewardList.oldSpeList
local tiaitsList={[1]=rewardList.tiaits1,[2]=rewardList.tiaits2}
if rewardList.tiaits1.param_1==DISCIPLE_SPECIALITY_TYPE.eDaoLv then
local desclist=UIDiscipleModel:getDiscipleSpecialityConfig(self.coupleIdList.dizi_id_1,true)
local id=self:checkTeZhi(desclist)
if id>0 then
tiaitsList[1]={param_1=DISCIPLE_SPECIALITY_TYPE.eDaoLv,param_2=id}
Effect_1=true
else
Effect_1=false
end
end
if tiaitsList[1]and oldSpeList[tiaitsList[1].param_2]then
tiaitsList[1]={param_1=0,param_2=0}
Effect_1=false
end

if rewardList.tiaits2.param_1==DISCIPLE_SPECIALITY_TYPE.eDaoLv then
local desclist=UIDiscipleModel:getDiscipleSpecialityConfig(self.coupleIdList.dizi_id_2,true)
local id=self:checkTeZhi(desclist)
if id>0 then
tiaitsList[2]={param_1=DISCIPLE_SPECIALITY_TYPE.eDaoLv,param_2=id}
Effect_2=true
else
Effect_2=false
end
end
if tiaitsList[2]and oldSpeList[tiaitsList[2].param_2]then
tiaitsList[2]={param_1=0,param_2=0}
Effect_2=false
end

local name1=UIDiscipleModel:getDiscipleName(self.coupleIdList.dizi_id_1)
local name2=UIDiscipleModel:getDiscipleName(self.coupleIdList.dizi_id_2)
local disciplename=string.format("%s,%s",name1,name2)

local args={
image="image_daolvxitong_ct1",
desc=self.curLvCfg.desc,
disciple=diziList,
disciplename=disciplename,
sixAttrType=sixAttrList,
list=expList,
Effect_1=Effect_1,
Effect_2=Effect_2,
index={index1,index2},
tiaitsList=tiaitsList,
}
UIHuanJingControl:showWindow("UIDaoLvShuangXiuResultWin",args)
UIManager:hideWindow('UITopMoneyWin')
end

function UIDLCultivationWin:moveDoor(index)
local alpha={0,1}
local doorLeft={-143,-424}
local doorRight={142,428}
self.doorWidget=self.doorRoot:getWidgetBase()
local tweener1=_this.doorWidget:SetChildDOAnchorPosX(0,doorLeft[index],0.3,nil)
tweener1:SetEase(_Ease.Linear)
local tweener2=_this.doorWidget:SetChildDOAnchorPosX(1,doorRight[index],0.3,function()
self:setDzModelAlpha(alpha[index])
end)
tweener2:SetEase(_Ease.Linear)
end

function UIDLCultivationWin:getJYModelId(sex)
return sex==1 and 3042 or 3043
end

function UIDLCultivationWin:setJianyinModel()
local sexA=UIDiscipleModel:getDiscipleSex(self.dzId1)
local sexB=UIDiscipleModel:getDiscipleSex(self.dzId2)
self.jyModel[1]:setChildUIModelShowTarget(self:getJYModelId(sexA),1,nil,eAnimationID.stand)
self.jyModel[2]:setChildUIModelShowTarget(self:getJYModelId(sexB),1,nil,eAnimationID.stand)
self.jyModel[2]:setChildUIModelShowFlipX(true)
self.jyModel[1]:setChildCanvasGroupDOFade(1,0.25)
self.jyModel[2]:setChildCanvasGroupDOFade(1,0.25)
end

function UIDLCultivationWin:setDzModelAlpha(alpha)
self.dzModel_1:setChildCanvasGroupDOFade(alpha,0.25)
self.dzModel_2:setChildCanvasGroupDOFade(alpha,0.25,function()
if alpha==0 then
self:setJianyinModel()
end
end)
end

function UIDLCultivationWin:playDoubleRepairAnim()
self.Mask:setActive(true)
self:moveDoor(1)
self:delayDo(2,function()
self.effect:setChildShowEffect(20208,true)
self:delayDo(3,function()
self:moveDoor(2)
self.jyModel[1]:setChildCanvasGroupDOFade(0,0.2)
self.jyModel[2]:setChildCanvasGroupDOFade(0,0.2,function()
self:showDoubleRepairPanel()
self.Mask:setActive(false)

end)
end)
end)
end

function UIDLCultivationWin:getSpeakText(bt,tkey,index)
local speakList
local voc=UIDiscipleModel:getDiscipleJob(self.coupleIdList.dizi_id_1)
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'daolv')
speakList=self:getChuiWeiSpeakText(self.coupleIdList.dizi_id_1,voc,speakList)

local speakStr=speakList[math.random(1,#speakList)]
bt:setSharedVar(tkey,speakStr)
end

function UIDLCultivationWin:getChuiWeiSpeakText(dzId,voc,speakList)
local check=self:checkChuiWei(dzId)
if check then
local textList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'dyingidlewalk')
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(dzId)
speakList=textList[imageInfo.sex]or textList[1]
end
return speakList
end





function UIDLCultivationWin:onSelectBtn()
local args={}
args.titleName='住房列表'
args.pos=1
args.extraWin='UIRoomSelectWin'
args.extraParams=self.bdData
UIManager:showWindow('UICommonPageWin',args)
end


function UIDLCultivationWin:onBtnDoublerepair()
if tostring(self.dzId1)=="0"or tostring(self.dzId2)=="0"or not self.dzId1 or not self.dzId2 then
UIManager.error("未入住道侣，不能进行双修！！！")
return
end

local name1=""
local name2=""
local str
if UIDiscipleModel:checkDiscipleState2(self.dzId1,DISCIPLE_STATE_TYPE.eChuiWei)then
name1=UIDiscipleModel:getDiscipleName(self.dzId1)
end
if UIDiscipleModel:checkDiscipleState2(self.dzId2,DISCIPLE_STATE_TYPE.eChuiWei)then
name2=string.format("%s",UIDiscipleModel:getDiscipleName(self.dzId2))
end

if name1~=""or name2~=""then
str=string.format("弟子%s%s垂危,无法进行双修",name1,name2)
end






if self.btnFlag then
UIManager.info("本周双修次数已达上限！！")
elseif str then
UIManager.error(str)
return
else
local flag=true
local name=""
local costcfg=self.cave_config.promote_cost
for k,v in ipairs(costcfg)do
if v then
local costId=v[1]
local costCount=v[2]
local haveCount=itemsModel.getCount(costId)
if haveCount<costCount then
flag=false
name=moneyModel.getMoneyName(costId)
end
end
end
if flag then
DiscipleCoupleController.reqDaoLvRepair(self.bdData.un_build_id,self.dzId1,self.dzId2)
else
local str=string.format("%s数量不足，无法进行双修",name)
UIManager.error(str)
return
end
end
end


function UIDLCultivationWin:onJiuzhiImg()
local guid
local chuiwei1=UIDiscipleModel:checkDiscipleState2(self.dzId1,DISCIPLE_STATE_TYPE.eChuiWei)
local chuiwei2=UIDiscipleModel:checkDiscipleState2(self.dzId2,DISCIPLE_STATE_TYPE.eChuiWei)
if chuiwei1 then
guid=self.dzId1
elseif chuiwei2 then
guid=self.dzId2
end
if guid then
self:jiuzhiDisciple(guid)
end
end


function UIDLCultivationWin:onZuohuaImg()
local slots=self.bdData.caveGeziList
if slots and slots[1]then
local data=slots[1]
self:zuohuaDisciple(data.dizi_id)
end
end


function UIDLCultivationWin:onEvent_3()
self:showTipsEvent(3)
end


function UIDLCultivationWin:onEvent_2()
self:showTipsEvent(2)
end


function UIDLCultivationWin:onEvent_1()
self:showTipsEvent(1)
end


function UIDLCultivationWin:onTipsBack()
self:closeTipsEvent()
end


function UIDLCultivationWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_dldf_help_%s'})
end








def_class("UIDuJieXianDanWin",UIWindowBase)









function UIDuJieXianDanWin:bindComponents()

self.btnSelect=UIObject.get(self,0)
self.btnSelectReddot=UIObject.get(self,1)
self.buffDesc=UIText.get(self,2)
self.buffName=UIText.get(self,3)
self.buffRoot=UIObject.get(self,4)
self.cost=UIObject.get(self,5)
self.costhb=UIText.get(self,6)
self.dandao=UIText.get(self,7)
self.danlingModel=UIObject.get(self,8)
self.danlingRoot=UIObject.get(self,9)
self.danwenRoot=UIObject.get(self,10)
self.dfItemNameBg=UIObject.get(self,11)
self.dftemName=UIText.get(self,12)
self.diziInfo=UIObject.get(self,13)
self.diziLock=UIText.get(self,14)
self.dzEmpty=UIObject.get(self,15)
self.dzName=UIText.get(self,16)
self.effect=UIObject.get(self,17)
self.flyIcon=UIImage.get(self,18)
self.help=UIToggleButton.get(self,19)
self.huobiimg=UIImage.get(self,20)
self.jingjie=UIText.get(self,21)
self.liandanlu=UIObject.get(self,22)
self.liandanluEffect=UIObject.get(self,23)
self.liandanRoot=UIObject.get(self,24)
self.lianZhiBtn=UIButton.get(self,25)
self.lianZhiBtn2=UIButton.get(self,26)
self.lianzhiComplete=UIObject.get(self,27)
self.lianzhiRunning=UIObject.get(self,28)
self.lianZhiTime=UIObject.get(self,29)
self.limitText=UIText.get(self,30)
self.lingquButton=UIButton.get(self,31)
self.materialbg=UIObject.get(self,32)
self.materials=UIObject.get(self,33)
self.materialsItem_1=UIBaseItem.get(self,34)
self.materialsItem_2=UIBaseItem.get(self,35)
self.materialsItem_3=UIBaseItem.get(self,36)
self.materialsItem_4=UIBaseItem.get(self,37)
self.materialsItem_5=UIBaseItem.get(self,38)
self.materialsItem_6=UIBaseItem.get(self,39)
self.openBtn=UIButton.get(self,40)
self.pauseTimeImg=UIObject.get(self,41)
self.progressbg=UIProgressBarAni.get(self,42)
self.progressTime=UIText.get(self,43)
self.progressValue=UIObject.get(self,44)
self.rewardBtn=UIButton.get(self,45)
self.root=UIObject.get(self,46)
self.selectedDangFang=UIObject.get(self,47)
self.speed=UIText.get(self,48)
self.Text=UIText.get(self,49)
self.timeProgressbar=UIObject.get(self,50)
self.timeProgressText=UIText.get(self,51)
self.timeText=UIText.get(self,52)
self.title_desc=UIText.get(self,53)
self.titleName1=UIObject.get(self,54)
self.titleName2=UIObject.get(self,55)
self.titleNameNum=UIText.get(self,56)
self.wenText=UIText.get(self,57)
self.zhuaBuButton=UIButton.get(self,58)

self.lianZhiBtn:setButtonClick(function()self:onLianZhiBtn()end)

self.lianZhiBtn2:setButtonClick(function()self:onLianZhiBtn2()end)

self.lingquButton:setButtonClick(function()self:onLingquButton()end)

self.openBtn:setButtonClick(function()self:onOpenBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.zhuaBuButton:setButtonClick(function()self:onZhuaBuButton()end)
self.materialsItem={
self.materialsItem_1,
self.materialsItem_2,
self.materialsItem_3,
self.materialsItem_4,
self.materialsItem_5,
self.materialsItem_6,
}
self.title={
["desc"]=self.title_desc,
}



end


function UIDuJieXianDanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.btnSelectReddot);self.btnSelectReddot=nil;
_UIObject_release(self.buffDesc);self.buffDesc=nil;
_UIObject_release(self.buffName);self.buffName=nil;
_UIObject_release(self.buffRoot);self.buffRoot=nil;
_UIObject_release(self.cost);self.cost=nil;
_UIObject_release(self.costhb);self.costhb=nil;
_UIObject_release(self.dandao);self.dandao=nil;
_UIObject_release(self.danlingModel);self.danlingModel=nil;
_UIObject_release(self.danlingRoot);self.danlingRoot=nil;
_UIObject_release(self.danwenRoot);self.danwenRoot=nil;
_UIObject_release(self.dfItemNameBg);self.dfItemNameBg=nil;
_UIObject_release(self.dftemName);self.dftemName=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.diziLock);self.diziLock=nil;
_UIObject_release(self.dzEmpty);self.dzEmpty=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.flyIcon);self.flyIcon=nil;
_UIObject_release(self.help);self.help=nil;
_UIObject_release(self.huobiimg);self.huobiimg=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.liandanlu);self.liandanlu=nil;
_UIObject_release(self.liandanluEffect);self.liandanluEffect=nil;
_UIObject_release(self.liandanRoot);self.liandanRoot=nil;
_UIObject_release(self.lianZhiBtn);self.lianZhiBtn=nil;
_UIObject_release(self.lianZhiBtn2);self.lianZhiBtn2=nil;
_UIObject_release(self.lianzhiComplete);self.lianzhiComplete=nil;
_UIObject_release(self.lianzhiRunning);self.lianzhiRunning=nil;
_UIObject_release(self.lianZhiTime);self.lianZhiTime=nil;
_UIObject_release(self.limitText);self.limitText=nil;
_UIObject_release(self.lingquButton);self.lingquButton=nil;
_UIObject_release(self.materialbg);self.materialbg=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.materialsItem_1);self.materialsItem_1=nil;
_UIObject_release(self.materialsItem_2);self.materialsItem_2=nil;
_UIObject_release(self.materialsItem_3);self.materialsItem_3=nil;
_UIObject_release(self.materialsItem_4);self.materialsItem_4=nil;
_UIObject_release(self.materialsItem_5);self.materialsItem_5=nil;
_UIObject_release(self.materialsItem_6);self.materialsItem_6=nil;
_UIObject_release(self.openBtn);self.openBtn=nil;
_UIObject_release(self.pauseTimeImg);self.pauseTimeImg=nil;
_UIObject_release(self.progressbg);self.progressbg=nil;
_UIObject_release(self.progressTime);self.progressTime=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectedDangFang);self.selectedDangFang=nil;
_UIObject_release(self.speed);self.speed=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.timeProgressbar);self.timeProgressbar=nil;
_UIObject_release(self.timeProgressText);self.timeProgressText=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.title_desc);self.title_desc=nil;
_UIObject_release(self.titleName1);self.titleName1=nil;
_UIObject_release(self.titleName2);self.titleName2=nil;
_UIObject_release(self.titleNameNum);self.titleNameNum=nil;
_UIObject_release(self.wenText);self.wenText=nil;
_UIObject_release(self.zhuaBuButton);self.zhuaBuButton=nil;
self.materialsItem=nil;
self.title=nil;
end



















function UIDuJieXianDanWin:onLoaded(...)
self:bindComponents()

self:addNotify(notifyConfig.building_event,function(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.replaceDisciple then
self.dzId=arg1
self:refreshDzPanel()
end
end)

self:addNotify(notifyConfig.on_item_changed,function(changeType,itemguid,itemid,oldVal,newVal)
if self.jdConfig then
local cost=self.jdConfig.usecl
for i,v in ipairs(cost)do
local matItemId=v[1]
if matItemId==itemid then
local item=self.materialsItem[i]
if item then
local needCount=v[2]
local countStr=UIDanYaoModel:getItemCountStr(matItemId,needCount)
local have=UIDanYaoModel:getHaveItemCount(matItemId)
local showStage=not moneyConfig.isMoney(matItemId)
local conf={itemid=matItemId,itemcount=countStr,showCountBG=true,showStage=showStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
prop[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
prop[PropIndex(DataPropKey.eWidgetActive,7)]=have<needCount
item:setChildPropData(prop)
local _onClickMaterialItem=function(...)
self:onClickMaterialItem(...)
end
item:setBaseItemChildID(matItemId)
item:setBaseItemClickEvent(_onClickMaterialItem)
break
end
end
end
end
end)
self:addNotify(notifyConfig.on_money_changed,function(moneyType,oldVal,newVal)
if self.jdConfig then
local v=self.jdConfig.usehb
local matItemId=v[1]
local needCount=v[2]
local buff=jctjDuJieXianDanModel:checkXQCYBuff()
if buff then
needCount=needCount*(1-buff)
end
if self.lianZhiType==1 then
local countStr=UIDanYaoModel:getItemCountStr(matItemId,needCount)
self.costhb:setText(countStr)
else
local cost=self.jdConfig.usecl
local item=self.materialsItem[#cost+1]
if item then
local countStr=UIDanYaoModel:getItemCountStr(matItemId,needCount)
local have=UIDanYaoModel:getHaveItemCount(matItemId)
local showStage=not moneyConfig.isMoney(matItemId)
local conf={itemid=matItemId,itemcount=countStr,showCountBG=true,showStage=showStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
prop[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
prop[PropIndex(DataPropKey.eWidgetActive,7)]=have<needCount
item:setChildPropData(prop)
local _onClickMaterialItem=function(...)
self:onClickMaterialItem(...)
end
item:setBaseItemChildID(matItemId)
item:setBaseItemClickEvent(_onClickMaterialItem)
end
end

end
end)

self._onProgressUpdateAction=function(...)
self:onProgressUpdateAction(...)
end
self.progressbg:setUpdateAction(self._onProgressUpdateAction)
self.progressbg:setFinishAction(function(...)self:onProgressBarFinishAction(...)end)

self.help:setToggleChange(function(name,isOn,data)
if isOn then
self:onHelp()
end
end)

self.effect:setLocalPos(0,101,7570)
end


function UIDuJieXianDanWin:__delete()
self:unbindComponents()
if self.currDZBt then
uiAIManager:removeUIInstance(self.currDZBt)
self.currDZBt=nil
end
end




function UIDuJieXianDanWin:onShow(argtable,afterOnloaded)
local entityId=argtable.entityId
self.entityId=entityId
self.bdData=zongmenModel:findBuildingByEntityId(entityId)
self.buildConfig=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)

self:refresh()
end


function UIDuJieXianDanWin:onHide()

end

function UIDuJieXianDanWin:onHelp()
local langId='dujiexiandan_rule_%s'
local d={}
d.title='说明'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end

function UIDuJieXianDanWin:onShowArgRecv(argtable)
local entityId=argtable.entityId
self.entityId=entityId
self.bdData=zongmenModel:findBuildingByEntityId(entityId)
self.buildConfig=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self:refresh()
end

function UIDuJieXianDanWin:refresh()
local jd=jctjDuJieXianDanModel:getLianZhiJieDuan()


local uid=jctjDuJieXianDanModel:getLianZhiBuild()
if uid and uid~=0 then
self.ubdId=uid
self.bdData=zongmenModel:getBuildingData(uid)
end

self.dzId=self.bdData.dizi_id
self.ubdId=self.bdData.un_build_id

if jd>0 then
local jdConfig=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jd)
self.jdConfig=jdConfig
if jdConfig.jdType==1 then
self:showDanJiPanel()
elseif jdConfig.jdType==2 then
self:showDanWenPanel()
end
else
local jdConfig=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,1)
self.jdConfig=jdConfig
self:showDanJiPanel()
end

self:refreshDzPanel()

self:showBuffPanel()
end



function UIDuJieXianDanWin:showDanJiPanel()
local buildid=jctjDuJieXianDanModel:getLianZhiBuild()
if not buildid or buildid==0 then
buildid=self.ubdId
end
self.lianZhiType=1

self.ubdId=buildid
self:refreshCost()
self.titleName1:setActive(true)
self.titleName2:setActive(false)
local endTime=jctjDuJieXianDanModel:getLianZhiEndTime()
self.liandanRoot:setActive(true)
self.danlingRoot:setActive(false)





if endTime==0 then
self.materialbg:setActive(true)
self.materials:setActive(true)
self.lianZhiBtn:setActive(true)
self.lianZhiTime:setActive(true)
self.progressbg:setActive(false)
self:refreshTime1()

self.effect:setChildShowEffect(self.jdConfig.jdEffect,true)
else
self.materialbg:setActive(false)
self.materials:setActive(false)
self.lianZhiBtn:setActive(false)
self.lianZhiTime:setActive(false)


local now=timeHelper.getServerShortTime()
self.progressbg:setActive(true)
local time=self:getTime()
self.dur=time

local jdConfig=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,2)
self.effect:setChildShowEffect(jdConfig.jdEffect,true)

self.openBtn:setActive(endTime-now<=0)
if endTime-now>0 then
self.Text:setText("丹基炼制中")
self.progressbg:animateFiveParams(time-endTime+now,time,time,endTime-now)
else
self.progressbg:animateTwoParams(endTime,endTime)
self.progressTime:setText("炼制完成")
self.Text:setText("")
end
end
end

function UIDuJieXianDanWin:showDanWenPanel()
self.lianZhiType=2

self.danlingRoot:setActive(false)
self:refreshCost()



if jctjDuJieXianDanModel:getLianZhiKlFlag()==1 then

local jdConfig=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,self.jdConfig.id+1)
if jdConfig then
self.effect:setChildShowEffect(jdConfig.jdEffect,true)
else
local effectid=cfgHelper.get(cfg_dujiexiandanbaseconfig_get,1,"jdEffect")
self.effect:setChildShowEffect(effectid,true)
end


if jctjDuJieXianDanModel:getMonDieFlag()==0 then
self:showDanLingPanel()
else
if self.jdConfig.lastFlag then
self.lingquButton:setActive(true)
self.liandanRoot:setActive(true)
self.danwenRoot:setActive(true)
self.titleNameNum:setText(self.jdConfig.id-1)
self.titleName1:setActive(false)
self.titleName2:setActive(true)

self.materials:setActive(false)
self.materialbg:setActive(false)
self.lianZhiBtn:setActive(false)
self.lianZhiBtn2:setActive(false)
self.lianZhiTime:setActive(false)
self.progressbg:setActive(false)
end
end
else


self.liandanRoot:setActive(true)
self.danwenRoot:setActive(true)
local endTime=jctjDuJieXianDanModel:getLianZhiEndTime()
self.titleNameNum:setText(self.jdConfig.id-1)
self.titleName1:setActive(false)
self.titleName2:setActive(true)


self.effect:setChildShowEffect(self.jdConfig.jdEffect,true)

if jctjDuJieXianDanModel:checkLianZhiLingQu()then
self.materials:setActive(false)
self.materialbg:setActive(false)
self.lianZhiBtn:setActive(false)
self.lianZhiBtn2:setActive(false)
self.lianZhiTime:setActive(false)
self.progressbg:setActive(false)
else
if endTime==0 then
self.materialbg:setActive(true)
self.materials:setActive(true)
self.lianZhiBtn:setActive(false)
self.lianZhiBtn2:setActive(true)
self.lianZhiTime:setActive(true)
self.progressbg:setActive(false)
self:refreshTime1()

else
self.materialbg:setActive(false)
self.materials:setActive(false)
self.lianZhiBtn:setActive(false)
self.lianZhiBtn2:setActive(false)
self.lianZhiTime:setActive(false)



local now=timeHelper.getServerShortTime()
self.progressbg:setActive(true)
local time=self:getTime()
self.dur=time
self.openBtn:setActive(endTime-now<=0)
if endTime-now>0 then
self.Text:setText("丹纹凝练中")
self.progressbg:animateFiveParams(time-endTime+now,time,time,endTime-now)
else
self.progressbg:animateTwoParams(endTime,endTime)
self.progressTime:setText("凝练完成")
self.Text:setText("")
end
end
end


end

end


function UIDuJieXianDanWin:onProgressUpdateAction(div,time)
local time=math.ceil(self.dur-self.dur*div)
if time>0 then
self.progressTime:setText(FMT.fmt("{1}耗时:{0}",timeHelper.format_time_stamp(time),self.lianZhiType==1 and"炼制"or"凝练"))
else
self.progressTime:setText(self.lianZhiType==1 and"炼制完成"or"凝练完成")
self.openBtn:setActive(true)
self.Text:setText("")
end
end

function UIDuJieXianDanWin:onProgressBarFinishAction()
self.progressTime:setText(self.lianZhiType==1 and"炼制完成"or"凝练完成")
self.openBtn:setActive(true)
self.Text:setText("")
end

function UIDuJieXianDanWin:showDanLingPanel()
self.liandanRoot:setActive(false)
self.danwenRoot:setActive(false)
self.danlingRoot:setActive(true)
self.lianZhiBtn:setActive(false)

local dlId=self.jdConfig.dlId
local danLingConfig=cfgHelper.get(cfg_djxddanlingconfig_get,dlId)
local day=jctjDuJieXianDanModel:getOpenDanLuDay()
local mon=danLingConfig.gwz[day]
if not mon then
mon=danLingConfig.gwz[#danLingConfig.gwz]
end
local mCfg=cfgHelper.get1(cfg_monstergroup_get,mon[1])
self.jingjie:setText(UIDiscipleModel:getJJNameEx(mCfg.level))
self.danlingModel:setChildUIModelShowTarget(danLingConfig.image[1],danLingConfig.image[3],danLingConfig.image[2],0,false,false,0)
end

function UIDuJieXianDanWin:getTime()
local lztime=self.jdConfig.lztime

local peoplenum=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local sjduce=0
local server_reduce_conf=cfgHelper.get2(cfg_dujiexiandanbaseconfig_get,1,'server_reduce_conf')or{}
for k,v in ipairs(server_reduce_conf)do
if peoplenum>=v[1]and peoplenum<=v[2]then
sjduce=v[3]
end
end
local subTime=0
if sjduce>0 then
subTime=subTime+sjduce/100
end

local limit=cfgHelper.get(cfg_dujiexiandanbaseconfig_get,1,"reduceMax")

local dzId=self.dzId
if tostring(dzId)~='0'then
local bd_tybe_cfg=cfg_monijybuildconfig_get(self.buildConfig.id)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local dddjjc=cfgHelper.get(cfg_dujiexiandanbaseconfig_get,1,"dddjjc")
subTime=subTime+level*dddjjc[1]

local netData=UIDiscipleModel:getAnyDiscipleDataByStr(tostring(dzId))
local speRate=dzSpecialityGrowEffectController:getLianDanTimeChangeRate(netData)
if speRate then
subTime=subTime+math.abs(speRate/100)
end

local isShuWuDZ=UIDiscipleModel:isShuWuDisciple(netData.id)
if isShuWuDZ then
local dzData=UIDiscipleModel:getDiscipleData(dzId)
local pdval,ptype=UIDiscipleModel:countShuWUDZSelfPDAddValue(dzData)
if ptype==eMoneyType.mtLingDan then
subTime=subTime+math.abs(pdval/100)
end
end


end
end
if subTime>limit then
subTime=limit
end
lztime=lztime-(lztime*subTime)

return lztime
end

function UIDuJieXianDanWin:refreshTime1()
self.timeText:setText(FMT.fmt("炼制耗时:{0}",timeHelper.format_time_stamp(math.ceil(self:getTime()))))
end

function UIDuJieXianDanWin:refreshCost()
local cost=table.weakCopy(self.jdConfig.usecl)
local length=#cost
local matItemId=self.jdConfig.usehb[1]
local needCount=self.jdConfig.usehb[2]
local buff=jctjDuJieXianDanModel:checkXQCYBuff()
if buff then
needCount=needCount*(1-buff)
end

if self.lianZhiType==1 then
self.cost:setActive(true)
local countStrHB=UIDanYaoModel:getItemCountStr(matItemId,needCount)
self.costhb:setText(countStrHB)
else
self.cost:setActive(false)
cost[length+1]={matItemId,needCount}
end


self.materials:setActive(true)
self.materialbg:setActive(true)
for i,item in ipairs(self.materialsItem)do

if cost[i]then
item:setActive(true)
local matItemId=cost[i][1]
local needCount=cost[i][2]
local countStr=UIDanYaoModel:getItemCountStr(matItemId,needCount)
local have=UIDanYaoModel:getHaveItemCount(matItemId)
local showStage=not moneyConfig.isMoney(matItemId)

local conf={itemid=matItemId,itemcount=countStr,showCountBG=true,showStage=showStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
prop[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
prop[PropIndex(DataPropKey.eWidgetActive,7)]=have<needCount
item:setChildPropData(prop)
local _onClickMaterialItem=function(...)
self:onClickMaterialItem(...)
end
item:setBaseItemChildID(matItemId)
item:setBaseItemClickEvent(_onClickMaterialItem)
else
item:setActive(false)
end
end

end

function UIDuJieXianDanWin:onClickMaterialItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UIDuJieXianDanWin:refreshDzPanel()
local dzId=self.dzId

local name=''
local haveDz=tostring(dzId)~='0'

local isPause=false
local animState=haveDz and 0 or 1
self.root:setAnimatorInteger('state',animState)

self.diziInfo:setActive(haveDz)
self.diziLock:setActive(not haveDz)
self.btnSelect:setActive(not haveDz)

self.help:setActive(haveDz)
if haveDz then
name=UIDiscipleModel:getDiscipleName(dzId)
local bd_tybe_cfg=cfg_monijybuildconfig_get(self.buildConfig.id)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
self.dandao:setText(string.format('%s：%s级',skill_cfg.name,level))

local dddjjc=cfgHelper.get(cfg_dujiexiandanbaseconfig_get,1,"dddjjc")
local subTime=level*dddjjc[1]*100
local limit=cfgHelper.get(cfg_dujiexiandanbaseconfig_get,1,"reduceMax")
limit=limit*100

local netData=UIDiscipleModel:getAnyDiscipleDataByStr(tostring(dzId))
local speRate=dzSpecialityGrowEffectController:getLianDanTimeChangeRate(netData)
if speRate then
subTime=subTime+math.abs(speRate)
end

local isShuWuDZ=UIDiscipleModel:isShuWuDisciple(netData.id)
if isShuWuDZ then
local dzData=UIDiscipleModel:getDiscipleData(dzId)
local pdval,ptype=UIDiscipleModel:countShuWUDZSelfPDAddValue(dzData)
if ptype==eMoneyType.mtLingDan then
subTime=subTime+math.abs(pdval)
end
end
if subTime>limit then
subTime=limit
end
self.speed:setText(FMT.fmt("炼制时长缩短：{0}%",math.floor(subTime*10)/10))
end




end
self.dzName:setText(FMT.fmt('执事弟子：<color=#7d3b17>{0}</color>',name))
if not isPause then
if not self._initModel then
self._initModel=true
self.ctimer=self:delayDo(1,function(...)
self:refreshDzModel()
end)
else
self:refreshDzModel()
end
end

self.title_desc:setText(self.jdConfig.title)
end

function UIDuJieXianDanWin:refreshDzModel()
local dzId=self.dzId

if self.currDZBt then
uiAIManager:removeUIInstance(self.currDZBt)
self.currDZBt=nil
end
if tostring(dzId)~='0'then

self:createDZ(dzId,{-360,-226},function(bt)
if self and not self.isClose then
self.currDZBt=bt
end
end)

end
end

function UIDuJieXianDanWin:createDZ(dzId,pos,callback)
local UIstateId=1

local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
standPos=0,
leftPos={-350,-226},
rightPos={-300,-226},
UIstateId=UIstateId,
shanhuo=0,
firstright=1,
}
local tran=self.dzEmpty:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])

local otherData={
order=1001,
weaponslot='shanzislotname',
}
self.currDZ=uiAIManager:createUIDisciple('UIDuJieXianDanWin','bt_ui_ldf2',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end


function UIDuJieXianDanWin:getSpeakText(bt,tkey)
local txt=''
if jctjDuJieXianDanModel:getLianZhiKlFlag()==1 then


if jctjDuJieXianDanModel:getMonDieFlag()==0 then
txt='快抓丹灵'
else
txt='已开炉'
end

else
local endTime=jctjDuJieXianDanModel:getLianZhiEndTime()

local now=timeHelper.getServerShortTime()
if endTime==0 then
if self.lianZhiType==1 then
txt='炼制丹基'
else
txt='凝练丹纹'
end
else
if endTime-now>0 then
if self.lianZhiType==1 then
txt='丹基炼制中'
else
txt='丹纹凝练中'
end
else
if self.lianZhiType==1 then
txt='炼制完成'
else
txt='凝练完成'
end
end
end

end


bt:setSharedVar(tkey,txt)
end


function UIDuJieXianDanWin:showBuffPanel()
local buff=jctjDuJieXianDanModel:checkXQCYBuff()
if buff then
local descT=cfgHelper.get(cfg_dujiexiandanbaseconfig_get,1,"xqcydesc")
self.buffRoot:setActive(true)
self.buffName:setText(FMT.fmt(descT[1],buff*100))
self.buffDesc:setText(FMT.fmt(descT[2],buff*100))
else
self.buffRoot:setActive(false)
end
end




function UIDuJieXianDanWin:onRewardBtn()
end



function UIDuJieXianDanWin:onLianZhiBtn()

local cost=self.jdConfig.usecl
for i,item in ipairs(cost)do
local matItemId=item[1]
local needCount=item[2]
local have=UIDanYaoModel:getHaveItemCount(matItemId)
if have<needCount then

gainControl:showCommonGainWin_item(matItemId,{needCount=needCount})
return
end
end

local matItemId=self.jdConfig.usehb[1]
local needCount=self.jdConfig.usehb[2]
local have=UIDanYaoModel:getHaveItemCount(matItemId)
local buff=jctjDuJieXianDanModel:checkXQCYBuff()or 0
local need=math.ceil(needCount*(1-buff))
if have<need then

gainControl:showCommonGainWin_item(matItemId,{needCount=needCount})
return
end

local haveDz=self.dzId and tostring(self.dzId)~='0'
if not haveDz then
UIManager.error("未安排弟子")
return
end

if UIDiscipleModel:checkDiscipleState2(self.dzId,DISCIPLE_STATE_TYPE.eLianDan)then
UIManager.error("弟子炼丹中")
return
end

local func1=function()
jctjDuJieXianDanController:send_34_102(zongmenModel:getMountainId(),self.ubdId)
end
local cancelFunc=function()
self.effect:setActive(true)
end
self.effect:setActive(false)
local str="仙丹炼制期间，炼丹炉将无法炼制其他丹药，是否开始炼制？"
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func1,REPEAT_TYPE.eDuJieXianDanLianDan,cancelFunc,cancelFunc)



end

function UIDuJieXianDanWin:onLianZhiBtn2()
self:onLianZhiBtn()
end



function UIDuJieXianDanWin:onRightArrow()
end



function UIDuJieXianDanWin:onLeftArrow()
end

function UIDuJieXianDanWin:onOpenBtn()
jctjDuJieXianDanController:send_34_103({})
end

function UIDuJieXianDanWin:onZhuaBuButton()

local entity=jctjDuJieXianDanModel:getEntity(mapIdType.zhufeng)
local entPos,entGrid,entitypos
if entity then
entitypos=_MapManager.GetTilemapObjectPosition(entity.entGuid)
if entitypos then
entGrid=_MapManager.Vector3IntToArray(entitypos)
local mapId=zongmenModel:getMountainId()
local camPos=_MapManager.GetCameraPosition()
entPos=_MapManager.GetCellCenterWorld(mapId,entitypos,mapLayer.Data)
local topos=Vector3(entPos.x,entPos.y,camPos.z)

self.camTweener=_DOTweenProxy.DOMove(_MapManager.GetCameraTransform(),topos,1)
self.camTweener:SetEase(_Ease.Linear)
self.camTweener:OnComplete(function(...)
isometricMapSystem:leaveStoryMode()
UIManager:showWindow("UIDuJieDanLingWin")
end)
end
end
UIFullLianDanFangControl:closeUI()
isometricMapSystem:enterStoryMode()
end

function UIDuJieXianDanWin:stopCamTweener()
if self.camTweener then
self.camTweener:Kill(false)
self.camTweener=nil
end
end


function UIDuJieXianDanWin:onLingquButton()
jctjDuJieXianDanController:send_34_104()
end

function UIDuJieXianDanWin:onClickSelect()
if tostring(self.bdData.dizi_id)~='0'then
local isPause=UIDanYaoModel:checkIsPause(self.ubdId)
if isPause then
UIManager.error('弟子已外出战斗, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能更换弟子')
return
end
end
zongmenControl:showSelectManagerWin(mapIdType.zhufeng,self.bdData)
end

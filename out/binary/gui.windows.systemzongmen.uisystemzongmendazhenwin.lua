







def_class("UISystemZongMenDaZhenWin",UIWindowBase)









function UISystemZongMenDaZhenWin:bindComponents()

self.dzTx=UIText.get(self,0)
self.jjTx=UIText.get(self,1)
self.zfTx=UIText.get(self,2)
self.cglTx=UIText.get(self,3)
self.dzModel=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.slotModel_3=UIButton.get(self,6)
self.slotModel_2=UIButton.get(self,7)
self.slotModel_1=UIButton.get(self,8)
self.sheildProgress=UIProgress.get(self,9)
self.destoryBtn=UIButton.get(self,10)
self.moneyList=UIObject.get(self,11)
self.doingProgress=UIProgressBarAni.get(self,12)
self.closeBtn=UIButton.get(self,13)
self.sheildEffect=UIObject.get(self,14)
self.helpBtn=UIButton.get(self,15)
self.effect=UIObject.get(self,16)
self.title=UIText.get(self,17)
self.costList=UIObject.get(self,18)

self.slotModel_3:setButtonClick(function()self:onSlotModel_3()end)

self.slotModel_2:setButtonClick(function()self:onSlotModel_2()end)

self.slotModel_1:setButtonClick(function()self:onSlotModel_1()end)

self.destoryBtn:setButtonClick(function()self:onDestoryBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)
self.slotModel={
self.slotModel_1,
self.slotModel_2,
self.slotModel_3,
}



end


function UISystemZongMenDaZhenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dzTx);self.dzTx=nil;
_UIObject_release(self.jjTx);self.jjTx=nil;
_UIObject_release(self.zfTx);self.zfTx=nil;
_UIObject_release(self.cglTx);self.cglTx=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.slotModel_3);self.slotModel_3=nil;
_UIObject_release(self.slotModel_2);self.slotModel_2=nil;
_UIObject_release(self.slotModel_1);self.slotModel_1=nil;
_UIObject_release(self.sheildProgress);self.sheildProgress=nil;
_UIObject_release(self.destoryBtn);self.destoryBtn=nil;
_UIObject_release(self.moneyList);self.moneyList=nil;
_UIObject_release(self.doingProgress);self.doingProgress=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.sheildEffect);self.sheildEffect=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.costList);self.costList=nil;
self.slotModel=nil;
end















local _this=nil
local _slotCmp={
root=-1,
lock=0,
model=1,
}
local _costCmp={
icon=0,
num=1,
}
local _moneyCmp={
btn=0,
icon=1,
value=2,
}



function UISystemZongMenDaZhenWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onSystemZMDestroyDZResult,self.onSystemZMDestroyDZResult)
self:addNotify(notifyConfig.onSystemZMDefenseInfo,self.onSystemZMDefenseInfo)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onSystemZMDiscipleChange,self.onSystemZMDiscipleChange)
self.canFace={}
self.showModel={}
end


function UISystemZongMenDaZhenWin:__delete()
self:unbindComponents()
_this=nil
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end




function UISystemZongMenDaZhenWin:onShow(argtable,afterOnloaded)
self.serial=argtable
self.infoData=systemZongMenModel:getInfoData(self.serial)
self.defenseInfo=systemZongMenModel:getDefenseInfo(self.serial)
self.discipleguid=self.infoData.disciple_guid

local config=cfgHelper.get1(cfg_syssectconfig_get,self.infoData.id)
local baseCfg=cfgHelper.get1(cfg_syssectbaseconfig_get,1)
local params=config.dazhenLv or baseCfg.dzParams
local allSmCfg=cfg_shanmendazhenconfig()
self.level=Mathf.Clamp(math.floor(self.infoData.level*params[1]+params[2]),0,#allSmCfg)
self.smCfg=allSmCfg[self.level]
self.sheildEffect:setChildShowEffect(self.smCfg.dazhenUIEffectId[1],true)

self:refreshDisciple()
self:refreshDisciplePos()
if self.defenseInfo then
self:refreshView()
end
end


function UISystemZongMenDaZhenWin:onHide()

end




function UISystemZongMenDaZhenWin:onBackground()
self:onCloseBtn()
end


function UISystemZongMenDaZhenWin:onCloseBtn()

UIFullSystemZongMenControl:closeWindow("UISystemZongMenDaZhenWin")
end


function UISystemZongMenDaZhenWin:onHelpBtn()
if self.bt then return end

local d={}
d.title='【规则说明】'
d.mode=3
d.name='systemZongMen_DaZhen_help_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UISystemZongMenDaZhenWin:onDestoryBtn()
if self.bt then return end
if self.defenseInfo==nil then return end
for i,v in ipairs(self.costs)do
local costType=v[1]
local costNum=v[2]
local haveNum=itemsModel.getCount(costType)
if costNum>haveNum then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(costType)))
gainControl:showGainWin(costType)
return
end
end

local content=FMT.fmt("是否让潜入弟子破坏宗门大阵？\n<color=red>不论破坏成功与否弟子获得怪癖<声名狼藉>\n若破坏失败弟子将增加大量负伤值</color>",UIDiscipleModel:getDiscipleName(self.discipleguid))
UIDialogManager.getCommonDialog2(nil,content,function()
systemZongMenController:req_destroy_dazhen(self.serial)
end)
end

function UISystemZongMenDaZhenWin:onClickSlot(index)
if self.bt then return end
if self.smCfg.team>=index and#self.defenseInfo.team>0 then
local teamList={}
for i=1,#self.defenseInfo.team do
local v=self.defenseInfo.team[i]
local index=math.ceil(i/fightPreSelectModel.maxPosNum)
local tempList=teamList[index]
if tempList==nil then
tempList={}
teamList[index]=tempList
end
local pos=i-(index-1)*fightPreSelectModel.maxPosNum
tempList[pos]=v
end

local args={
parentWin=self,
teamList=teamList,
titleStr="防守阵容",
select=index,
}
self:showWindow("UISystemZongMenComingTeamWin",args)
end
end

function UISystemZongMenDaZhenWin:refreshView()
self:refreshTitle()
self:refreshProgressBar()
self:refreshLevel()
self:refreshSuccess()
self:refreshCost()
self:refreshMoney()
self:refreshAllSlot()
end

function UISystemZongMenDaZhenWin:refreshTitle()
local zmName=systemZongMenModel:getNameStr(self.infoData.id,self.infoData.nameIdx)
self.title:setText(zmName)
end

function UISystemZongMenDaZhenWin:refreshProgressBar()
local maxValue=self.smCfg.shield
local curValue=self.defenseInfo.value
local curProgress=math.floor(curValue/maxValue*10000)
self.sheildProgress:setProgressValue(curProgress,10000)
self.sheildProgress:setChildProgressText(FMT.fmt("大阵护盾值：{0}/{1}",mathHelper.formatNumber(curValue),mathHelper.formatNumber(maxValue)))
end

function UISystemZongMenDaZhenWin:refreshDisciplePos()
local screenSize=CS.CSGUIManager.Instance:GetUICanvas(1).sizeDelta
if self.dzPos==nil then
local width=screenSize.x
local height=screenSize.y
self.dzPos=Vector2.New(-width/2+154,-height/2+12.5)
end
self.dzModel:setChildAnchoredPosition(self.dzPos)
end

function UISystemZongMenDaZhenWin:refreshDisciple()
local discipleData=UIDiscipleModel:getDiscipleData(self.discipleguid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(discipleData)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo,1)
local modelCmp=self.dzModel:getID()
self.canFace[0]=spineHelper.enableChangeFace(modelParams.body)
self.dzModel:setChildUIModelShowTarget(modelParams.body,0.8,modelParams.componets,eAnimationID.stand,false,false,0)
self.dzModel:setChildUIModelShowFlipX(true)
self.jjTx:setText(FMT.fmt("<color=#374F71>境界：</color>{0}",UIDiscipleModel:getJJName3(discipleData.jingjielv)))
self.dzTx:setText(FMT.fmt("<color=#374F71>弟子：</color>{0}",discipleData.disciplename))
self.zfTx:setText(FMT.fmt("<color=#374F71>阵法等级：</color>{0}级",UIDiscipleModel:getDiscipleJobLevelEx(discipleData,DISCIPLE_PROSKILL_TYPE.eZhenFa)))
end

function UISystemZongMenDaZhenWin:refreshLevel()

end

function UISystemZongMenDaZhenWin:refreshSuccess()
local jingjielv=UIDiscipleModel:getDiscipleJJLevel(self.discipleguid)
local zhenfalv=UIDiscipleModel:getDiscipleJobLevel(self.discipleguid,DISCIPLE_PROSKILL_TYPE.eZhenFa)
local param=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"breakDZP")
local percent=(jingjielv-param[1])+zhenfalv*param[2]


percent=Mathf.Clamp(math.floor(percent),0,100)

local percentStr="中"
if percent>60 then
percentStr="高"
elseif percent<=30 then
percentStr="低"
end
self.cglTx:setText(FMT.fmt("<color=#374F71>成功率：</color>{0}",percentStr))
end

function UISystemZongMenDaZhenWin:refreshCost()
self.costs=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"breakDZC")
self.costList:setChildLayoutGroupCreateItems(#self.costs,function(index)
local item=self.costList:getChildLayoutGroupGridItem(index-1)
local costData=self.costs[index]
local costType=costData[1]
local costNum=costData[2]
local haveNum=itemsModel.getCount(costType)
item:SetChildCSImageIcon(_costCmp.icon,iconHelper.getIconName(costType),false)
item:SetChildText(_costCmp.num,costNum>haveNum and FMT.cfmt(FONT_COLOR.eRedColor,mathHelper.formatNumber(costNum))or mathHelper.formatNumber(costNum))
end)
end

function UISystemZongMenDaZhenWin:refreshMoney()
self.moneyList:setChildLayoutGroupCreateItems(#self.costs,function(index)
local item=self.moneyList:getChildLayoutGroupGridItem(index-1)
local data=self.costs[index]
local moneyType=data[1]
item:SetChildButtonClick(_moneyCmp.btn,function()
if self.bt then return end
gainControl:showGainWin(moneyType)
end)
item:SetChildCSImageIcon(_moneyCmp.icon,iconHelper.getIconName(moneyType),false)
item:SetChildText(_moneyCmp.value,mathHelper.formatNumber(itemsModel.getCount(moneyType)))
end)
end

function UISystemZongMenDaZhenWin:refreshSlot(index,lock,discipleShow)







local modelCmp=self.slotModel[index]
if lock or discipleShow==nil then
modelCmp:setChildUIModelRemoveTarget()
modelCmp:setButtonClick()
self.winlua:SetChildActive(modelCmp:getID(),false)
self.canFace[index]=nil
self.showModel[index]=nil
else

local imageInfo=UIDiscipleModel.calculationDiscipleImage(discipleShow.discipledata,discipleShow.discipleimage)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
local weaponItemID=cfgHelper.get2(cfg_disciplevocationconfig_get,imageInfo.job,"syssectWeapon")
local weaponItemCfg=itemsConfig.getConfig(weaponItemID)
local weaponID=weaponItemCfg.imageID or 0
table_insert(modelParams.componets,cfgHelper.get2(cfg_discipleweaponimageconfig_get,weaponID,'out_side'))
self.canFace[index]=spineHelper.enableChangeFace(modelParams.body)
self.showModel[index]=modelCmp:getID()
self.winlua:SetChildActive(modelCmp:getID(),true)
modelCmp:setChildUIModelShowTarget(modelParams.body,0.8,modelParams.componets,eAnimationID.stand,false,false,0)
modelCmp:setChildUIModelShowFlipX(true)
modelCmp:setButtonClick(function()
if self.bt then return end
self:onClickSlot(index)
end)
end
end

function UISystemZongMenDaZhenWin:refreshAllSlot()
for i,v in ipairs(self.slotModel)do
local have=false
local lock=self.smCfg.team<i
for j=1,fightPreSelectModel.maxPosNum do
local teamPos=(i-1)*fightPreSelectModel.maxPosNum+j
local discipleShow=self.defenseInfo.team[teamPos]
if discipleShow and discipleShow.disciple_id>0 then
self:refreshSlot(i,lock,discipleShow)
have=true
break
end
end
if not have then
self:refreshSlot(i,lock,nil)
end
end
end

function UISystemZongMenDaZhenWin:onFinishAnimation(bt)
local result=bt:getSharedVar("result")
self.bt=nil




UIManager.info("潜入弟子暴露，已撤离")
self:onCloseBtn()

end







function UISystemZongMenDaZhenWin:randomSpeakStr(colorNames)
local lib=cfgHelper.get2(cfg_syssectbaseconfig_get,1,colorNames)
local r=math.random(1,#lib)
return lib[r]
end

function UISystemZongMenDaZhenWin.onSystemZMDestroyDZResult(serial,result,delta,wounded)
if _this.serial==serial and _this.bt==nil then
local tips=result>0 and FMT.fmt("护盾值 -{0}",delta)or FMT.fmt("{0}负伤值+{1}",UIDiscipleModel:getDiscipleName(_this.discipleguid),wounded)
local args={
widget=_this.winlua,
model0=_this.dzModel:getID(),
canFace0=_this.canFace[0],
effect=_this.effect:getID(),
systemMsg=tips,
progressBarAni=_this.doingProgress:getID(),
result=result==1,
model1=_this.showModel[1],
canFace1=_this.canFace[1],
model2=_this.showModel[2],
canFace2=_this.canFace[2],
model3=_this.showModel[3],
canFace3=_this.canFace[3],
speak1=_this:randomSpeakStr("dzDestroySpeak1"),
}
if result==1 then
args.speak2=_this:randomSpeakStr("dzDestroySpeak2")
else
for i,v in ipairs(_this.slotModel)do
args[FMT.fmt("speak3_{0}",i)]=_this:randomSpeakStr("dzDestroySpeak3")
args[FMT.fmt("speak4_{0}",i)]=_this:randomSpeakStr("dzDestroySpeak4")
end
end
_this.bt=behaviorManager:addBehaviorTree("bt_ui_systemzm_dazhen",nil,true,args,true)
end
end

function UISystemZongMenDaZhenWin.onSystemZMDefenseInfo(serial)
if _this.serial==serial then
if _this.bt==nil then
_this.defenseInfo=systemZongMenModel:getDefenseInfo(serial)
_this:refreshView()
end
end
end

function UISystemZongMenDaZhenWin.on_money_changed(moneyType,lastVal,val)
for i,v in ipairs(_this.costs)do
if v[1]==moneyType then
local item=_this.moneyList:getChildLayoutGroupGridItem(i-1)
item:SetChildText(_moneyCmp.value,mathHelper.formatNumber(val))

item=_this.costList:getChildLayoutGroupGridItem(i-1)
item:SetChildText(_costCmp.num,v[2]>val and FMT.cfmt(FONT_COLOR.eRedColor,mathHelper.formatNumber(v[2]))or mathHelper.formatNumber(v[2]))
break
end
end
end

function UISystemZongMenDaZhenWin.onSystemZMDiscipleChange(serial,discipleGuid,oldGuid)
if _this.serial==serial then
if _this.bt==nil then
if mathHelper.validInt64(discipleGuid)then
_this.discipleguid=discipleGuid
_this:refreshDisciple()
_this:refreshDisciplePos()
else
UIManager.error("潜入弟子已离开")
_this:onCloseBtn()
end
end
end
end

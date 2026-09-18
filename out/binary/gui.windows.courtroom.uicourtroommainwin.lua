







def_class("UICourtroomMainWin",UIWindowBase)









function UICourtroomMainWin:bindComponents()

self.maskImg=UIButton.get(self,0)
self.studentButton2=UIButton.get(self,1)
self.studentButton=UIButton.get(self,2)
self.forgetButton=UIButton.get(self,3)
self.noDisciple=UIText.get(self,4)
self.helpButton=UIButton.get(self,5)
self.right=UIObject.get(self,6)
self.rightUnder=UIObject.get(self,7)
self.rightMiddle=UIObject.get(self,8)
self.selectButton=UIButton.get(self,9)
self.name=UIText.get(self,10)
self.itemPanel=UIObject.get(self,11)
self.teZhiBg=UIImage.get(self,12)
self.desc=UIText.get(self,13)
self.kuang=UIObject.get(self,14)
self.costText=UIText.get(self,15)
self.tezhiName=UIText.get(self,16)
self.changeButton=UIButton.get(self,17)
self.adddesc=UIText.get(self,18)
self.costImage=UIImage.get(self,19)
self.txtDzSpeak=UIText.get(self,20)
self.txtDzSpeak2=UIText.get(self,21)
self.dzSpeak=UIObject.get(self,22)
self.dzSpeak2=UIObject.get(self,23)
self.descListPanel=UIObject.get(self,24)
self.teacherButton=UIButton.get(self,25)
self.noTeacherButton=UIButton.get(self,26)
self.teacherName=UIText.get(self,27)
self.teacherJJ=UIText.get(self,28)
self.teacherSmart=UIText.get(self,29)
self.teacherTeZhi=UIText.get(self,30)
self.selectDiscipleModel=UIObject.get(self,31)
self.selectTeacherModel=UIObject.get(self,32)
self.discipleButtonPanel=UIObject.get(self,33)
self.cloud=UIObject.get(self,34)

self.maskImg:setButtonClick(function()self:onMaskImg()end)

self.studentButton2:setButtonClick(function()self:onStudentButton2()end)

self.studentButton:setButtonClick(function()self:onStudentButton()end)

self.forgetButton:setButtonClick(function()self:onForgetButton()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

self.selectButton:setButtonClick(function()self:onSelectButton()end)

self.changeButton:setButtonClick(function()self:onChangeButton()end)

self.teacherButton:setButtonClick(function()self:onTeacherButton()end)

self.noTeacherButton:setButtonClick(function()self:onNoTeacherButton()end)



end


function UICourtroomMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.maskImg);self.maskImg=nil;
_UIObject_release(self.studentButton2);self.studentButton2=nil;
_UIObject_release(self.studentButton);self.studentButton=nil;
_UIObject_release(self.forgetButton);self.forgetButton=nil;
_UIObject_release(self.noDisciple);self.noDisciple=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.rightUnder);self.rightUnder=nil;
_UIObject_release(self.rightMiddle);self.rightMiddle=nil;
_UIObject_release(self.selectButton);self.selectButton=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.teZhiBg);self.teZhiBg=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.kuang);self.kuang=nil;
_UIObject_release(self.costText);self.costText=nil;
_UIObject_release(self.tezhiName);self.tezhiName=nil;
_UIObject_release(self.changeButton);self.changeButton=nil;
_UIObject_release(self.adddesc);self.adddesc=nil;
_UIObject_release(self.costImage);self.costImage=nil;
_UIObject_release(self.txtDzSpeak);self.txtDzSpeak=nil;
_UIObject_release(self.txtDzSpeak2);self.txtDzSpeak2=nil;
_UIObject_release(self.dzSpeak);self.dzSpeak=nil;
_UIObject_release(self.dzSpeak2);self.dzSpeak2=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.teacherButton);self.teacherButton=nil;
_UIObject_release(self.noTeacherButton);self.noTeacherButton=nil;
_UIObject_release(self.teacherName);self.teacherName=nil;
_UIObject_release(self.teacherJJ);self.teacherJJ=nil;
_UIObject_release(self.teacherSmart);self.teacherSmart=nil;
_UIObject_release(self.teacherTeZhi);self.teacherTeZhi=nil;
_UIObject_release(self.selectDiscipleModel);self.selectDiscipleModel=nil;
_UIObject_release(self.selectTeacherModel);self.selectTeacherModel=nil;
_UIObject_release(self.discipleButtonPanel);self.discipleButtonPanel=nil;
_UIObject_release(self.cloud);self.cloud=nil;
end



















local _itemWidgetIdx=
{
cmpItemQualityIdx=2,
cmpItemIconIdx=3,
cmpItemTxtCountIdx=4,
cmpItemTxtStage=6,
}

local studentBody={141021,241021,141021}
local studentFace={{12,11,6,0},{13,11,6,0},{12,11,6,0}}

local _this=nil

local _dzBTDict={}


function UICourtroomMainWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onDisciplePosChange,self.on_pos_change)


local func=function(id)
local widget=self:getChildExpandUI(-1,id)
if widget then
local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]
widget:SetChildCanvas(-1,sortLayer,sortOrder+3)
end
end
self.cloud_guid=self:setChildGreateExpandUI(-1,self.cloud:getID(),INSTANCE_TYPE.eCommonCloudUIExpand,func)
end


function UICourtroomMainWin:__delete()
roleAudioController:stopRoleSpeak()
if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end

notifySystem:removelistener(notifyConfig.onDisciplePosChange,self.on_pos_change)
_this=nil
_dzBTDict={}
if self.currDZ then
behaviorManager:removeBehaviorTree(self.currDZ)
self.currDZ=nil
end
courtroomModel:initRecordSpe()
self:unbindComponents()
end

function UICourtroomMainWin:refreshAfterItemUse(utype,arg1,arg2)
self:refreshRight()
end




function UICourtroomMainWin:onShow(argtable,afterOnloaded)
self:refreshLeft()
self:refreshRight()
end

function UICourtroomMainWin:refreshRight()
local selectDis=courtroomModel:getSelectGuid()
if selectDis then
self:selectDisciple(selectDis)
local selectTeZhi=courtroomModel:getSelectSpe()
if selectTeZhi then
self:refreshTeZhiPanel(selectTeZhi[1],selectTeZhi[2])
end
else
self:selectDisciple()
end
end

function UICourtroomMainWin:refreshLeft()
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJielu)or{}
if#dis_list>0 then
local ddata=dis_list[1]
local guid=ddata.discipleguid
self.zlGuid=guid

self.teacherName:setText(FMT.fmt("<color=#161412>戒律长老：</color>{0}",UIDiscipleModel:getDiscipleName(guid)))
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local jjstr=FMT.fmt('境界：{0}',UIDiscipleModel:getJJNameEx(jjlv))
self.teacherJJ:setText(jjstr)
local config=cfgHelper.get(cfg_lvfatangconfig_get,1,"attr6")
local sixAttrCfg=cfgHelper.getglobal1('discipleattr')
local sixAttrName=sixAttrCfg[config[1]].name

local str="（聪慧越高遗忘灵石消耗越低）"





local smartstr=FMT.fmt('{0}：{1}{2}',sixAttrName,UIDiscipleModel:getDiscipleBaseAttr(guid,config[1]),str)
self.teacherSmart:setText(smartstr)


local desclist=UIDiscipleModel:getDiscipleSpecialityConfig(guid)
self.desclist=courtroomModel:getShowSpecialityList(desclist)
if self.desclist then
local dataNum=#self.desclist
self.descListPanel:setActive(true)
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local cfg=self.desclist[i]
local item=gridlist[i-1]
UIDiscipleModel.refreshSpecialityItemExx(item,cfg)
item:SetChildButtonClick(1,function()
self:onZlDescSlotClick(i)
end)
end
self.teacherTeZhi:setText('特质：')
else
self.teacherTeZhi:setText('')
end
else
self.descListPanel:setActive(false)
self.teacherTeZhi:setText('')
end
self.teacherButton:setActive(true)
self.noTeacherButton:setActive(false)

self:setTeatherModel(guid)
else
self.teacherName:setText('暂无戒律长老')
self.teacherJJ:setText('')
self.teacherSmart:setText('')
self.teacherTeZhi:setText('')
self.descListPanel:setChildLayoutGroupCreateItems(0)
self.teacherButton:setActive(false)
self:setTeatherModel()
self.noTeacherButton:setActive(true)
end

end

function UICourtroomMainWin:onZlDescSlotClick(idx)
if self.desclist then
local cfg=self.desclist[idx]
local item=self.descListPanel:getChildLayoutGroupGridItem(idx-1)
UIFullCourtroomControl:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.zlGuid,config=cfg})
end
end

function UICourtroomMainWin.on_pos_change(guid,pos)
if _this.zlGuid==guid and eZongMenPostType.eJielu==pos then
_this.zlGuid=nil
else
_this.zlGuid=guid
end
if _this.zlGuid==_this.selectedDisciple then
_this:selectDisciple(nil)
else

if _this.tezhiId then
local speConfig=UIDiscipleModel:getSpecialityConfig(_this.tezhiType,_this.tezhiId)
_this:refreshTeZhiPanel(_this.tezhiType,speConfig)
end
if _this.currDZ then
behaviorManager:removeBehaviorTree(_this.currDZ)
_this.currDZ=nil
end
end

_this:refreshLeft()
end

function UICourtroomMainWin:selectDisciple(discipleId)

self.selectDiscipleModel:setChildAnchoredPosition(Vector2.New(158,-172))


self.tezhiName:setText('')
self.desc:setActive(false)
self.selectButton:setActive(true)
self.kuang:setActive(false)
self.teZhiBg:setActive(false)
self.itemPanel:setActive(false)
self.costText:setText('')
self.consume=nil
self.tezhiType=nil
self.tezhiId=nil

self.isForgeting=nil

if discipleId then
self.selectedDisciple=discipleId
self.name:setText(UIDiscipleModel:getDiscipleName(discipleId))

self:setStudentModel(discipleId)
self.right:setScale(Vector3(1,1,1))
self.noDisciple:setScale(Vector3(0,0,0))
courtroomModel:setSelectGuid(discipleId)
self.forgetButton:setActive(true)
self.studentButton:setActive(true)
self.studentButton2:setActive(false)
else
self.selectedDisciple=nil
self.forgetButton:setGray(true)
self.right:setScale(Vector3(0,0,0))
self.noDisciple:setScale(Vector3(1,1,1))

self:setStudentModel()
self.forgetButton:setActive(false)
self.studentButton:setActive(false)
self.studentButton2:setActive(true)
end
end

function UICourtroomMainWin:refreshTeZhiPanel(tezhiType,config)
if config then
courtroomModel:setSelectSpe(tezhiType,config)
self.tezhiType=tezhiType
self.tezhiId=config.id
self.selectButton:setActive(false)
local name=UIDiscipleModel.getSpecialityNameStr(config.name)
self.tezhiName:setText(name)
self.kuang:setActive(true)
self.teZhiBg:setActive(true)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(config.framecolor)
self.winlua:SetChildCSImageSprite(self.teZhiBg:getID(),abName,frameIcon)
local desc=config.effects_desc and FMT.fmt('{0}',config.effects_desc)or''
local infoStr=zongmenControl:getSpecialityAddDesc(nil,config)
self.desc:setActive(true)
self.desc:setText(desc)
self.adddesc:setText(infoStr)

local forgetConfig=courtroomModel.getForgetConfig(tezhiType,self.tezhiId)
if forgetConfig then
self.consume=forgetConfig.consume
self.itemPanel:setActive(true)
local free=courtroomModel.getFreePercent(self.zlGuid)
local free2=courtroomModel.getFreePercent2(self.selectDiscipleGuid)

self:showItemPanel(self.consume,free,free2)
end
end
end

function UICourtroomMainWin:fillItem(grid,itemid,count,itemConfig)
if not grid then
return
end
grid:SetBaseItemClickEvent(0,function(...)self:onItemClick(...)end)
local prop={}
local color=itemConfig.color
prop[PropIndex(DataPropKey.eWidgetQuality,_itemWidgetIdx.cmpItemQualityIdx)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,_itemWidgetIdx.cmpItemIconIdx)]=iconHelper.getIconName(itemid)
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCountIdx)]=count
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtStage)]=itemConfig.stage and FMT.fmt('{0}阶',itemConfig.stage)or''
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=-1
grid:SetChildPropData(0,prop)
end

function UICourtroomMainWin:onItemClick(id,index,guid,attach)
itemsComponentHelper.onItemClick(id,index,guid,attach)
end

function UICourtroomMainWin:showItemPanel(args,free,free2)
free=free or 0
free2=free2 or 0
local itemList=args
if itemList then
local count=#itemList



local enough=true
for i=0,count-1 do

local reward=itemList[i+1]
if reward then
local itemId=reward[1]
local count=math.ceil(reward[2]*(100+free)/100*(100+free2)/100)
local have=0
if itemsConfig.isMoney(itemId)then
have=moneyModel.getMoney(itemId)
else
have=bagControl.invokeFuncByItemId(itemId,'getItemCountByItemID',itemId)
end


if have<count then
enough=false

else

end




end
end
self.forgetButton:setGray(not enough)

local reward=itemList[1]
local have=0
local itemId=reward[1]
local count=math.ceil(reward[2]*(100+free)/100*(100+free2)/100)
if itemsConfig.isMoney(itemId)then
have=moneyModel.getMoney(itemId)
else
have=bagControl.invokeFuncByItemId(itemId,'getItemCountByItemID',itemId)
end

local countStr=''
if have<count then
countStr=FMT.cfmt(eQualityColor.eRed,'{0}',mathHelper.formatNumber(count))
else
countStr=FMT.fmt('{0}',mathHelper.formatNumber(count))
end
self.winid:SetChildCSImageIcon(self.costImage:getID(),iconHelper.getIconName(itemId),false)
self.costText:setText(countStr)
end
end


function UICourtroomMainWin:setTeatherModel(guid)
if guid and guid~=-1 then
self.selectTeacherModel:setScale(Vector3(1,1,1))
local sex=UIDiscipleModel:getDiscipleSex(guid)
local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(guid)
self.curBodyID=modelParams.body
self.selectTeacherModel:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,eAnimationID.stand,false)
self.selectTeacherModel:setChildUIModelShowTargetOffset(modelParams.offset[1],-50)

local info=UIDiscipleModel:getDiscipleImageInfo(guid)
local slotData=cfgHelper.get2(cfg_disciplevocationconfig_get,info.job,sex==1 and"lybslotname"or"jcslotname")
local weaponId=slotData[1]
local slotName=slotData[2]
if weaponId and slotName and modelParams.hideWeapon==nil then
local outSide=cfgHelper.get2(cfg_discipleweaponimageconfig_get,weaponId,'out_side')
self.winlua:SetChildLoadSlot(self.selectTeacherModel:getID(),slotName,outSide)
end
self.winlua:SetChildUIModelShowFlipX(self.selectTeacherModel:getID(),true)

comHelper.setChildDiziExpression(self.winlua,self.selectTeacherModel:getID(),0,modelParams.body)

else
self.curBodyID=nil
self.selectTeacherModel:setScale(Vector3(0,0,0))
end
end

function UICourtroomMainWin:changeTeatherFace(face)
comHelper.setChildDiziExpression(self.winlua,self.selectTeacherModel:getID(),face,self.curBodyID)
end

function UICourtroomMainWin:setTeatherAnim(AnimationID)
self.selectTeacherModel:setChildModelAnimationState(AnimationID)
end

function UICourtroomMainWin:setStudentModel(guid)
self.selectDiscipleGuid=guid or-1
if guid and guid~=-1 then
self.dzSpeak:setActive(false)
self.selectDiscipleModel:setScale(Vector3(1,1,1))
self.selectDiscipleSex=UIDiscipleModel:getDiscipleSex(guid)
local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(guid,true)
self.curStudentModel=modelParams
if deviceHelper.getAPILevel()>=3 and modelParams.componets[1]~=nil then
local body=self.selectDiscipleSex==1 and studentBody[1]or studentBody[2]
self.selectDiscipleModel:setChildUIModelShowTarget(body,1.1,nil,eAnimationID.stand,false)
self.selectDiscipleModel:setChildAddSkeletonSlot("tou1","head",modelParams.componets[1])
else
self.selectDiscipleModel:setChildUIModelShowTarget(modelParams.body,1.1,modelParams.componets,eAnimationID.stand,false)
end
self.selectDiscipleModel:setChildUIModelShowTargetOffset(modelParams.offset[1],-50)
self:changeStudentFace(1)

if self.currDZ then
behaviorManager:removeBehaviorTree(self.currDZ)
self.currDZ=nil
end
self.selectDiscipleModel:setChildCanvasGroupAlpha(1)
self.selectDiscipleModel:setChildUIModelShowFlipX(false)

if self.zlGuid then
local initData={
dzId=guid,
dzWidget=self.winlua,
dzIndex=self.selectDiscipleModel:getID(),
}
self.currDZ=behaviorManager:addBehaviorTree('bt_ui_courtroom',{winlua=self.winlua,model=self.selectDiscipleModel:getID()},true,initData)
end

else
self.curStudentModel=nil
self.selectDiscipleModel:setScale(Vector3(0,0,0))
end
end

function UICourtroomMainWin:changeStudentFace(index)
if self.selectDiscipleSex and self.curStudentModel~=nil then
local face=studentFace[self.selectDiscipleSex][index]
if face then
if deviceHelper.getAPILevel()>=3 and self.curStudentModel.componets[1]~=nil then
comHelper.setChildFollowActorExpression(self.winlua,self.selectDiscipleModel:getID(),'tou1',face)
else
comHelper.setChildDiziExpression(self.winlua,self.selectDiscipleModel:getID(),face,self.curStudentModel.body)
end
end
end
end

function UICourtroomMainWin:setStudentAnim(guid,AnimationID)
if guid and guid~=-1 then
self.selectDiscipleModel:setChildModelAnimationState(AnimationID)
end
end

function UICourtroomMainWin:forget()
self:changeTeatherFace(0)
if self.selectDiscipleGuid and self.selectDiscipleGuid~=-1 then
if self.currDZ then
behaviorManager:removeBehaviorTree(self.currDZ)
self.currDZ=nil
end
local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(self.selectDiscipleGuid)
self.selectDiscipleModel:setLocalPosY(-222)
self.selectDiscipleModel:setChildUIModelShowTarget(modelParams.body,1.1,modelParams.componets,eAnimationID.stand,false)
local initData={
dzId=self.selectDiscipleGuid,
dzWidget=self.winlua,
dzIndex=self.selectDiscipleModel:getID(),
rightPos={245,-316},
rightPos2={1024,-316},

}
self.currDZ=behaviorManager:addBehaviorTree('bt_ui_courtroom2',{winlua=self.winlua,model=self.selectDiscipleModel:getID()},true,initData)

self.isForgeting=true
end
end

function UICourtroomMainWin:speak(index,delay)
local speakList
if index==1 then
speakList=cfgHelper.get2(cfg_lvfatangconfig_get,1,'speak')
else
speakList=cfgHelper.get2(cfg_lvfatangconfig_get,1,'speak2')
end
local speakStr=speakList[math.random(1,#speakList)]or''
self.dzSpeak:setActive(true)
self.txtDzSpeak:setText(speakStr)
if delay>0 then
local speakDelay=self:setTimer(delay,1,function()
if self and not self.isClose then
self.dzSpeak:setActive(false)
end
end)
end
end



function UICourtroomMainWin:onHide()

end





function UICourtroomMainWin:onMaskImg()
end



function UICourtroomMainWin:onSelectButton()
local winParams={
titleName='选择弟子',
extraWin='UICourtroomSpecialitySelectWin',
extraParams={guid=self.selectedDisciple},
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)

end



function UICourtroomMainWin:onForgetButton()
if self.isForgeting then
UIManager.error("需等弟子离开")
return
end

if not self.tezhiId then
UIManager.error("需要先选择弟子特质")
return
end
if not self.zlGuid then
UIManager.error("无戒律长老")
return
end

if self.consume then
local free=courtroomModel.getFreePercent(self.zlGuid)
local free2=courtroomModel.getFreePercent2(self.selectDiscipleGuid)
local canForget=true
for i,cost in ipairs(self.consume)do
local count=math.ceil(cost[2]*(100+free)/100*(100+free2)/100)
if itemsConfig.isMoney(cost[1])then
if not moneyModel.checkEnoughMoney(cost[1],count)then
local name=moneyModel.getMoneyName(cost[1])
UIManager.error(string.format('%s不足',name))
gainControl:showGainWin(cost[1])
canForget=false
break
end
else
local itemCount=bagControl.invokeFuncByItemId(cost[1],'getItemCountByItemID',cost[1])
if itemCount<count then
local name=itemsConfig.getItemName(cost[1])
UIManager.error(string.format('%s不足',name))
gainControl:showGainWin(cost[1])
canForget=false
break
end
end
end
if canForget then
local forgetConfig=courtroomModel.getForgetConfig(self.tezhiType,self.tezhiId)
if forgetConfig then
UIManager:showWindow("UICourtroomGameWin",{configId=forgetConfig.mapid,guid=self.selectedDisciple,tezhiType=self.tezhiType,tezhiId=self.tezhiId})
end

end
end
end



function UICourtroomMainWin:onStudentButton()










if not self.zlGuid then
UIManager.error("请先安排戒律长老")
UIFullSectPalaceControl:showSectPalacePostInfo(eZongMenPostType.eJielu,self.zlGuid,true)
else
local sDizi=courtroomModel:getRecordGuid()or self.selectedDisciple
local recordSpe={}
if sDizi then
recordSpe=courtroomModel:getRecordSpe(sDizi)
end
local winParams={
titleName='选择弟子',
extraWin='UICourtroomSpecialitySelectWin',
extraParams={guid=sDizi,tezhiType=recordSpe[1],tezhiId=recordSpe[2]},
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
end

end

function UICourtroomMainWin:onStudentButton2()
self:onStudentButton()
end



function UICourtroomMainWin:onTeacherButton()
UIFullSectPalaceControl:showSectPalacePostInfo(eZongMenPostType.eJielu,self.zlGuid,true)
end

function UICourtroomMainWin:onNoTeacherButton()
self:onTeacherButton()
end

function UICourtroomMainWin:onHelpButton()
local d={}
d.title='律法堂规则介绍'
d.mode=3
d.name='lvfatang_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UICourtroomMainWin:onChangeButton()
self:onSelectButton()
end









def_class("UIDiscipleJingJieBrokeWin_afterTX",UIWindowBase)









function UIDiscipleJingJieBrokeWin_afterTX:bindComponents()

self.doingRoot=UIObject.get(self,0)
self.successRoot=UIObject.get(self,1)
self.closeTips=UIText.get(self,2)
self.talkObj=UIObject.get(self,3)
self.successEffect1=UIObject.get(self,4)
self.successEffect2=UIObject.get(self,5)
self.prepareRoot=UIObject.get(self,6)
self.attrGrid=UIObject.get(self,7)
self.talkDesc=UIText.get(self,8)
self.thunderHurt=UIText.get(self,9)
self.commitBtn=UIButton.get(self,10)
self.closeBtn=UIButton.get(self,11)
self.bgMask=UIButton.get(self,12)
self.costGroup=UIObject.get(self,13)
self.bloodProgress=UIProgress.get(self,14)
self.floorImageRoot=UIObject.get(self,15)
self.floorImage=UIImage.get(self,16)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.bgMask:setButtonClick(function()self:onBgMask()end)



end


function UIDiscipleJingJieBrokeWin_afterTX:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.doingRoot);self.doingRoot=nil;
_UIObject_release(self.successRoot);self.successRoot=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.talkObj);self.talkObj=nil;
_UIObject_release(self.successEffect1);self.successEffect1=nil;
_UIObject_release(self.successEffect2);self.successEffect2=nil;
_UIObject_release(self.prepareRoot);self.prepareRoot=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.talkDesc);self.talkDesc=nil;
_UIObject_release(self.thunderHurt);self.thunderHurt=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgMask);self.bgMask=nil;
_UIObject_release(self.costGroup);self.costGroup=nil;
_UIObject_release(self.bloodProgress);self.bloodProgress=nil;
_UIObject_release(self.floorImageRoot);self.floorImageRoot=nil;
_UIObject_release(self.floorImage);self.floorImage=nil;
end
















local brokeState={
ePrepare=1,
eDoing=2,
eResult=3,
}
local randomEmo={2,4,5,6,9,10}
local speed=1
local _this=nil
local _Ease=DG.Tweening.Ease

local stopEffect=CS.GameInterface.StopEffect




function UIDiscipleJingJieBrokeWin_afterTX:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onDiscipleJJBroke,self.onDiscipleJJBroke)
notifySystem:listenNotify(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)

self:addNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIDiscipleJingJieBrokeWin_afterTX:__delete()
self:clearAnimTimerList()
self:closeWindow('UITopMoneyWin8')
roleAudioController:stopRoleSpeak()
self.successEffect1:setChildShowEffect(10010,false)
self.successEffect2:setChildShowEffect(10061,false)
if self.modelsmoke~=nil then
_stopEffect(self.modelsmoke)
self.modelsmoke=nil
end
self:closeStage()

local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
if UIDiscipleModel:checkOpenDaoYan(netData)then
UIDiscipleController:reqDaoYanUnlock(self.disciple_guid)
end
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onDiscipleJJBroke,self.onDiscipleJJBroke)
notifySystem:removelistener(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)

UIManager:showWindow('UIBuildingMsgWin')
end




function UIDiscipleJingJieBrokeWin_afterTX:onShow(argtable,afterOnloaded)
self.fightStage=argtable.fightStage
self.disciple_guid=argtable.guid

self.openTest=argtable.openTest
self.testResult=argtable.testResult
self.testNum=argtable.testNum

self.oldAttrList=UIDiscipleModel:getDiscipleAttrLookupX(self.disciple_guid,DISCIPLE_ATTRIBUTE_TYPE.eJingJie)
self.animTimerList={}

if afterOnloaded then
self:initStage()
end
UIManager:hideWindow('UIBuildingMsgWin')

self.curState=brokeState.ePrepare

self.jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
self.floor=UIDiscipleModel:getJJFloor(self.jjlv)
local cfg=cfgHelper.get1(cfg_disciplejingjieconfig_get,self.jjlv)
self.brokeCost=cfg and cfg.txtpItems or nil
self.brokeCostLookup={}
if self.brokeCost then
local itemIdList={}
for i,v in ipairs(self.brokeCost)do
local itemId=v[1]
itemIdList[#itemIdList+1]={itemId}
self.brokeCostLookup[itemId]=true
end
self:showWindow("UITopMoneyWin8",{moneys=itemIdList,offsetX=0,offsetY=-25})
end

self.prepareRootWidget=self.prepareRoot:getChildWidgetBase()
self.doingRootWidget=self.doingRoot:getChildWidgetBase()
self.successRootWidget=self.successRoot:getChildWidgetBase()


self:refreshPrepare()


local floor=self.floor
local floorImageList=cfgHelper.get2(cfg_disciplejjthunderconfig_get,1,'afterTXFloorImageList')
local floorImage=floorImageList[floor]
if floorImage then
local abName="ui/windows/disciple/aftertxbroke_atlas_pak.ab"
self.floorImage:setSprite(abName,floorImage)
else
logErr(FMT.fmt("弟子渡劫表现配置缺少对应境界图片，境界等级:{0}, 境界层级:{1}",self.jjlv,self.floor))
end

end


function UIDiscipleJingJieBrokeWin_afterTX:onHide()
self:clearAnimTimerList()
end

function UIDiscipleJingJieBrokeWin_afterTX:initStage()

self.fightStage:addEntity(100,fightEntityType.diZi,self.disciple_guid,fightModel.getWorldCenter(),true)
self.modelEntity=self.fightStage:getEntity(100)
end

function UIDiscipleJingJieBrokeWin_afterTX:setModelColor()
if self.curResult==1 then

if self.finishAnim then

self.modelEntity:setSlotInheritColor('tou2','biaoqing',false)
self.modelEntity:fadeToColor(Color.New(0,0,0,1),1)
self.modelEntity:setExpression(10)
self.modelsmoke=self.modelEntity:playEffect(10012,Vector3.New(0,0.6,0),true,true)
else
local emo=self:getRandomEmo()
self.modelEntity:setExpression(emo)
end
else

if self.finishAnim then

local sex=UIDiscipleModel:getDiscipleSex(self.disciple_guid)
local emo=sex==SEX_TYPE.eMale and 8 or 7
self.modelEntity:setExpression(emo)
else
local emo=self:getRandomEmo()
self.modelEntity:setExpression(emo)
end
end
end

function UIDiscipleJingJieBrokeWin_afterTX:getRandomEmo()
local rad=math.random(1,#randomEmo)
return randomEmo[rad]
end

function UIDiscipleJingJieBrokeWin_afterTX:closeStage()
self.fightStage:close()
end

function UIDiscipleJingJieBrokeWin_afterTX:initModel()





end


function UIDiscipleJingJieBrokeWin_afterTX:refreshPrepare()

local costList=self.brokeCost
if costList then
self.costGroup:setChildLayoutGroupCreateItems(#costList,function(index)
local widget=self.costGroup:getChildLayoutGroupGridItem(index-1)
widget:SetChildActive(-1,true)
local item=costList[index]
local itemid=item[1]
local count=item[2]
local countStr=''
local showCountBG=true
countStr=mathHelper.formatNumber(count)
local hasCount=itemsModel.getCount(itemid)
if hasCount<count then
countStr=FMT.cfmt1(FONT_COLOR.eRedColor,countStr)
else
countStr=FMT.cfmt1(FONT_COLOR.eGreenColor,countStr)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickCostItem(...)
end)
end)
end
end




function UIDiscipleJingJieBrokeWin_afterTX:getIntergration(v)
local n=0
for i=1,v do
n=n+i
end
return n
end

function UIDiscipleJingJieBrokeWin_afterTX:initDoingRoot()
local widget=self.doingRootWidget

self.firstBroke=userActorSetting.get('firstJingJieBroke',true)
local showskip=cfgHelper.get2(cfg_disciplejjthunderconfig_get,1,'skip')
if showskip then
if self.firstBroke then
showskip=false
end
end
widget:SetChildActive(3,showskip)


self.beforeBgm=AudioManager.getCurrentBgm()
local duJieBgmId=10031
AudioManager.playBgMusic(duJieBgmId)

self:playBrokeAnim()
end

function UIDiscipleJingJieBrokeWin_afterTX:playBrokeAnim()
self:clearAnimTimerList()

local effectId=22693

self:showEntityEffect(effectId)

self.animTimerList[1]=self:delayDo(3.6,function()
if not _this or not _this.isVisible then return end

self:doShake(0.3,{0,1.5,0},20,90)
self.floorImage:setActive(true)
end)

self.animTimerList[2]=self:delayDo(6,function()
if not _this or not _this.isVisible then return end
return _this:castOver()
end)
end

function UIDiscipleJingJieBrokeWin_afterTX:doShake(duration,point,vibrato,randomness)
fightManager.shakePosition(duration,Vector3(point[1],point[2],point[3]),vibrato,randomness,false)
end

function UIDiscipleJingJieBrokeWin_afterTX:doShake2(duration,strength,vibrato,randomness)

local transform=fightManager.getCameraTransform()
local strengthV3=Vector3.New(strength[1],strength[2],strength[3])
local tweener=_DOTweenProxy.DOShakePosition(transform,duration,strengthV3,vibrato,randomness)

return tweener
end

function UIDiscipleJingJieBrokeWin_afterTX:showEntityEffect(effectId,offset,scale)
if not effectId then
return
end

self:clearEntityEffect()
local offset_x=0
local offset_y=0
local offset_z=0
if offset then
offset_x=offset[1]or 0
offset_y=offset[2]or 0
offset_z=offset[3]or 0
end
local scale_Vector3
if scale then
scale_Vector3=Vector3.New(scale,scale,scale)
end
self.entEffect=self.modelEntity:playEffect(effectId,Vector3.New(offset_x,offset_y,offset_z),true,true,scale_Vector3)
end


function UIDiscipleJingJieBrokeWin_afterTX:clearEntityEffect()
if self.entEffect~=nil then
_stopEffect(self.entEffect)
self.entEffect=nil
end
end

function UIDiscipleJingJieBrokeWin_afterTX:castOver()
self:clearAnimTimerList()
self.curState=brokeState.eResult
self.doingRoot:setActive(false)
self.floorImage:setActive(false)
self:clearEntityEffect()
if self.curResult==0 then
self.successRoot:setActive(true)
self:updateSuccessRoot()
roleAudioController:playRoleSpeak(self.disciple_guid,roleAudioNodeType.JingJieTiSheng_succes)
_this.rolespeaktxt=roleAudioController:getplayRoleSpeakTxt(self.disciple_guid,roleAudioNodeType.JingJieTiSheng_succes)
else








end


self.closeTips:setActive(true)


self:showTalk()


if self.beforeBgm then
AudioManager.playBgMusic(self.beforeBgm)
self.beforeBgm=nil
end

notifySystem:postNotify(notifyConfig.onDiscipleDuJieFinish,self.disciple_guid,self.curResult==0)
end

function UIDiscipleJingJieBrokeWin_afterTX:showTalk()
local jobid=UIDiscipleModel:getDiscipleJob(self.disciple_guid)
local talklist=nil
local talkTime=nil
local tkey=self.curResult==0 and'dujieSuccess'or'dujiefail'
talklist=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,jobid,tkey)
talkTime=cfgHelper.get2(cfg_disciplejjthunderconfig_get,1,'talkTime')
talkTime=talkTime or 3

local talk_str=nil
if talklist~=nil and#talklist>0 then
local r=math.random(1,#talklist)
talk_str=talklist[r]
end
if _this.rolespeaktxt then
talk_str=_this.rolespeaktxt
_this.rolespeaktxt=nil
end
if talk_str==nil then return end

self.talkObj:setActive(true)
self.talkObj:setChildLocalPosition(Vector3.New(55,-97,0))
self.talkObj:setChildCanvasGroupAlpha(0)

self.talkDesc:setText(talk_str)
self.talkObj:setChildCanvasGroupDOFade(1,0.1,nil)
self.talkObj:setScale(Vector3.New(0,0,0))
local t1=self.talkObj:setChildDOScale(1,0.2*speed,nil)
t1:SetEase(_Ease.OutElastic)

if self.talkTimer~=nil then
self:stopTimerByID(self.talkTimer)
self.talkTimer=nil
end
if self.taklTween~=nil then
self.taklTween:Complete()
self.taklTween=nil
end
local func=function()
self.taklTween=self.talkObj:setChildCanvasGroupDOFade(0,0.2,nil)
end
self.talkTimer=self:delayDo(talkTime*speed,func)
end

function UIDiscipleJingJieBrokeWin_afterTX:onSkipClick()
if self.curState==brokeState.eDoing then
self:setModelColor()
self:clearEntityEffect()
self:castOver()
end
end


function UIDiscipleJingJieBrokeWin_afterTX:clearAnimTimerList()
if self.animTimerList and next(self.animTimerList)then
for i,timer in pairs(self.animTimerList)do
self:stopTimerByID(timer)
self.animTimerList[i]=nil
end
end
end



function UIDiscipleJingJieBrokeWin_afterTX:getAttrList(lookup)
local result={}
for k,v in pairsBySortKey(lookup)do
result[#result+1]={k,v}
end
return result
end

function UIDiscipleJingJieBrokeWin_afterTX:updateSuccessRoot()
self.successEffect1:setChildShowEffect(10010,true)
self.successEffect2:setChildShowEffect(22694,true)
local widget=self.successRootWidget
local oldAttrList=self.oldAttrList
local lookup=UIDiscipleModel:getDiscipleAttrLookupX(self.disciple_guid,DISCIPLE_ATTRIBUTE_TYPE.eJingJie)
local curAttrList=self:getAttrList(lookup)
local oldJJLv=self.jjlv
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)

widget:SetChildText(0,UIDiscipleModel:getJJNameEx(oldJJLv))
widget:SetChildText(1,UIDiscipleModel:getJJNameEx(jjlv))

local gridlist=widget:GetChildCommonLayoutGroupWidgetList(2)
local c=gridlist.Count
for i=1,c do
local item=gridlist[i-1]
local attr=curAttrList[i]
local show=attr~=nil
local attrType
local newAttrValue
local oldAttrValue
if show then
attrType=attr[1]
newAttrValue=attr[2]
oldAttrValue=oldAttrList[attrType]


end
item:SetChildActive(0,show)
if show then
local attrname=cfgHelper.get2(cfg_attributesconfig_get,attrType,'attrname')
item:SetChildText(1,helper.getAttributeStr(attrType,oldAttrValue,nil,'{0}：{1}'))
item:SetChildText(3,newAttrValue)
end
end


local delay=1

local sub0=0.3*speed
widget:SetChildCanvasGroupAlpha(3,0)
local func0=function()
widget:SetChildCanvasGroupDOFade(3,1,sub0,nil)
end
self:delayDo(delay,func0)
delay=delay+sub0

local pos1=widget:GetChildLocalPosition(4)
widget:SetChildLocalPosY(4,-55)
widget:SetChildActive(4,false)
local sub1=0.2*speed
local func1=function()
widget:SetChildActive(4,true)
widget:SetChildDOLocalMoveY(4,pos1.y,sub1,nil)
end
self:delayDo(delay,func1)
delay=delay+sub1

for i=1,c do
local item=gridlist[i-1]
local pos=item:GetChildLocalPosition(0)
local posy=pos.y
item:SetChildLocalPosY(0,-210)
item:SetChildActive(0,false)
local sub3=0.2*speed
local func2=function()
item:SetChildActive(0,true)
item:SetChildDOLocalMoveY(0,posy,sub3,nil)
end
self:delayDo(delay,func2)
delay=delay+sub3
end






end




function UIDiscipleJingJieBrokeWin_afterTX:testFunc_showBrokeAnim()
self.curResult=nil
self:rec_result(0)
end

function UIDiscipleJingJieBrokeWin_afterTX.on_item_list_changed(args)
if _this==nil then return end
for i,v in ipairs(args)do
local itemid=v[3]
if _this.brokeCostLookup[itemid]then
return _this:refreshPrepare()
end
end
end

function UIDiscipleJingJieBrokeWin_afterTX.on_money_changed(moneyType,oldVal,newVal)
if _this==nil then return end
if _this.brokeCostLookup[moneyType]then
return _this:refreshPrepare()
end
end


function UIDiscipleJingJieBrokeWin_afterTX.onDiscipleJJBroke(disguid,res)
if _this==nil then return end
if mathHelper.compareInt64(disguid,_this.disciple_guid)then
_this:rec_result(res)
end
end

function UIDiscipleJingJieBrokeWin_afterTX.onShowDiscipleChanged(effectType,allData,effectData)
if _this==nil then return end
if effectType==ePrizeType.eFeiShengTai then
local guid_str=tostring(_this.disciple_guid)
local temp1
local temp2
local temp3

temp1=allData[eDiscipleChangeType.eJJRate]
if temp1 then
temp2=temp1[guid_str]
if temp2 then
temp3=temp2[#temp2]
_this.jjratechange=temp3[2]-temp3[1]
end
end

temp1=allData[eDiscipleChangeType.eInjuryChange]
if temp1 then
temp2=temp1[guid_str]
if temp2 then
temp3=temp2[#temp2]
_this.injurychange=temp3[2]-temp3[1]
end
end
end
end


function UIDiscipleJingJieBrokeWin_afterTX:rec_result(res)
if self.curResult~=nil then return end
self.curResult=res
self.curState=brokeState.eDoing
self.prepareRoot:setActive(false)
self.doingRoot:setActive(true)
self:closeWindow('UITopMoneyWin8')
self:initDoingRoot()

userActorSetting.flushVal('firstJingJieBroke',false,true)
end




function UIDiscipleJingJieBrokeWin_afterTX:onCommitBtn()

local func=function()
if not _this or not _this.isVisible then return end
_this.curState=brokeState.doing


if _this.openTest==true then
_this:rec_result(_this.testResult or 1)
else
FeiShengTaiController.sendJingJieBroke(_this.disciple_guid)
end
end
itemsModel:useItemlist_finalCallback(self.brokeCost,func,WARNING_TYPE.eWarning)
end



function UIDiscipleJingJieBrokeWin_afterTX:onCloseBtn()
self:myClose()
end



function UIDiscipleJingJieBrokeWin_afterTX:onBgMask()
if self.curState==brokeState.eResult then
self:myClose()
end
end


function UIDiscipleJingJieBrokeWin_afterTX:myClose()
local isUnlockDY=UIDiscipleModel:getDiscipleDaoYanUnLockReddot(self.disciple_guid)
if isUnlockDY then
UIManager:showWindow("UIDiscipleDaoYanUnlockWin",{discipleGuid=self.disciple_guid,isShowGotoBtn=true})
fullScreenUI.closeActiveUI()
else
fullScreenUI.closeActiveUI(true)
end
end

function UIDiscipleJingJieBrokeWin_afterTX:onClickCostItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

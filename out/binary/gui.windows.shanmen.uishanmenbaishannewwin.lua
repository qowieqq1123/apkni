







def_class("UIShanMenBaiShanNewWin",UIWindowBase)









function UIShanMenBaiShanNewWin:bindComponents()

self.baitie=UIObject.get(self,0)
self.btns=UIObject.get(self,1)
self.costImage=UIImage.get(self,2)
self.costPanel=UIObject.get(self,3)
self.costTxt=UIText.get(self,4)
self.descScrollView=UIObject.get(self,5)
self.diziList=UIObject.get(self,6)
self.effect1=UIObject.get(self,7)
self.effect2=UIObject.get(self,8)
self.effect3=UIObject.get(self,9)
self.giveUpBtn=UIButton.get(self,10)
self.head=UIObject.get(self,11)
self.info=UIObject.get(self,12)
self.jieyouAnimaion=UIObject.get(self,13)
self.jiezuoAnimaion=UIObject.get(self,14)
self.jingjie=UIText.get(self,15)
self.jujueImg=UIObject.get(self,16)
self.lastBtn=UIButton.get(self,17)
self.leftDrag=UIObject.get(self,18)
self.lichang=UIText.get(self,19)
self.model=UIObject.get(self,20)
self.name=UIText.get(self,21)
self.nextBtn=UIButton.get(self,22)
self.pinjiBg=UIImage.get(self,23)
self.pinjiImg=UIImage.get(self,24)
self.polygonAttrPanel=UIObject.get(self,25)
self.rightDrag=UIObject.get(self,26)
self.root=UIObject.get(self,27)
self.selectBtn=UIButton.get(self,28)
self.shengziYou=UIObject.get(self,29)
self.shengziZuo=UIObject.get(self,30)
self.shouyuan=UIText.get(self,31)
self.skills=UIObject.get(self,32)
self.skillScrollView=UIObject.get(self,33)
self.speak=UIObject.get(self,34)
self.speakText=UILinkImageText.get(self,35)
self.tipsImg=UIObject.get(self,36)
self.tixiu=UIText.get(self,37)
self.totalValue=UIText.get(self,38)
self.tybg=UIImage.get(self,39)
self.xingbie=UIText.get(self,40)
self.zhaoruImg=UIObject.get(self,41)
self.zhiye=UIText.get(self,42)
self.zhongzu=UIText.get(self,43)

self.giveUpBtn:setButtonClick(function()self:onGiveUpBtn()end)

self.lastBtn:setButtonClick(function()self:onLastBtn()end)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)



end


function UIShanMenBaiShanNewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.baitie);self.baitie=nil;
_UIObject_release(self.btns);self.btns=nil;
_UIObject_release(self.costImage);self.costImage=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costTxt);self.costTxt=nil;
_UIObject_release(self.descScrollView);self.descScrollView=nil;
_UIObject_release(self.diziList);self.diziList=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.giveUpBtn);self.giveUpBtn=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.jieyouAnimaion);self.jieyouAnimaion=nil;
_UIObject_release(self.jiezuoAnimaion);self.jiezuoAnimaion=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.jujueImg);self.jujueImg=nil;
_UIObject_release(self.lastBtn);self.lastBtn=nil;
_UIObject_release(self.leftDrag);self.leftDrag=nil;
_UIObject_release(self.lichang);self.lichang=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.pinjiBg);self.pinjiBg=nil;
_UIObject_release(self.pinjiImg);self.pinjiImg=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.rightDrag);self.rightDrag=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.shengziYou);self.shengziYou=nil;
_UIObject_release(self.shengziZuo);self.shengziZuo=nil;
_UIObject_release(self.shouyuan);self.shouyuan=nil;
_UIObject_release(self.skills);self.skills=nil;
_UIObject_release(self.skillScrollView);self.skillScrollView=nil;
_UIObject_release(self.speak);self.speak=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.tipsImg);self.tipsImg=nil;
_UIObject_release(self.tixiu);self.tixiu=nil;
_UIObject_release(self.totalValue);self.totalValue=nil;
_UIObject_release(self.tybg);self.tybg=nil;
_UIObject_release(self.xingbie);self.xingbie=nil;
_UIObject_release(self.zhaoruImg);self.zhaoruImg=nil;
_UIObject_release(self.zhiye);self.zhiye=nil;
_UIObject_release(self.zhongzu);self.zhongzu=nil;
end

















local _this
local proSkillSort={1,3,5,7,2,4,6,8}


function UIShanMenBaiShanNewWin:onLoaded(...)
self:bindComponents()

webGLHelper:uiWindowCloseCamera(self.tybg)

_this=self
self.abName='ui/sharedtextures/uiglobalspriteatlas_1.ab'
self.jobab='ui/windows/disciple/sharedtextures/uidisciplejobicons.ab'
self.yxtAB='ui/windows/recruit/sharedtextures/yinxiantai_new.ab'
self.smABName='ui/windows/shanmen/sharedtextures/shanmen.ab'
self.descScrollView:setChildScrollViewInit(0,true,self.onDescSlotClick,nil)
self.skillScrollView:setChildScrollViewInit(0,true,nil,nil)

self.minFrame=0
self.maxFrame=12
self.currLeftFrame=0
self.currRightFrame=0

self.winlua:SetChildUIDragEvent(self.leftDrag:getID(),0,self.beginLeftDragCallback,self.endLeftDragCallback,self.leftDragCallback)
self.winlua:SetChildUIDragEvent(self.rightDrag:getID(),0,self.beginRightDragCallback,self.endRightDragCallback,self.rightDragCallback)

self:loadBaiTieAnim()


if taskModel:hasTask(331)then
self.giveUpBtn:setActive(false)
end

self:showTopMoney()
end

function UIShanMenBaiShanNewWin:showTopMoney()
UIManager:showWindow('UITopMoneyWin',{{eMoneyType.mtChenYuan},{eMoneyType.mtXianYuan}})
end


function UIShanMenBaiShanNewWin:__delete()
self:unbindComponents()

webGLHelper:uiWindowShowCamera()

UIManager:closeWindow('UITopMoneyWin')
_this=nil
self:clearSpeakTimer()
self:killSpeakTweener()
end




function UIShanMenBaiShanNewWin:onShow(argtable,afterOnloaded)
self.dzId=argtable
self.baitie:setChildCanvasGroupDOFade(1,1)
self.descScrollView:setActive(false)
self.skillScrollView:setActive(false)

self:setTimer(0.55,1,function()
self.effect1:setChildShowEffect(10112,true)
end)
self.effect2:setChildShowEffect(10113,true)
end


function UIShanMenBaiShanNewWin:onHide()

end

function UIShanMenBaiShanNewWin:openInfo()
self.effect1:setChildShowEffect(10112,false)
self.effect2:setChildShowEffect(10113,false)
self:setTimer(0.25,1,function()
self.effect3:setChildShowEffect(10111,true)
end)


AudioManager.playAudio(517)
self.root:setAnimatorInteger('state',1,true)
self.leftDrag:setActive(false)
self.rightDrag:setActive(false)
self.descScrollView:setActive(true)
self.skillScrollView:setActive(true)

local datas=shanmenModel:getBaiShanData()
local showList={}
for i,v in ipairs(datas)do
table.insert(showList,v)
end
self.disciples=showList
self:refreshWin()
local showDzList=#showList>1
self.diziList:setActive(showDzList)
self.lastBtn:setActive(showDzList)
self.nextBtn:setActive(showDzList)
if showDzList then
self:initDiZiList()
end
self:refreshCost()
end

function UIShanMenBaiShanNewWin:getCurDiscipleIndex()
for i,v in ipairs(self.disciples)do
local ddata=v.discipleInfo
if mathHelper.compareInt64(ddata.discipleguid,self.dzId)then
return i
end
end
end

function UIShanMenBaiShanNewWin:refreshWin()
self.roleIndex=self:getCurDiscipleIndex()
local data=self.disciples[self.roleIndex]
self:refreshInfo(data)
end


function UIShanMenBaiShanNewWin:initDiZiList()
self.diziList:setChildLayoutGroupCreateItems(#self.disciples,function(index)
self:setDZItem(index)
end)
end

function UIShanMenBaiShanNewWin:refreshDZItem(guid)
if not self.disciples then return end
local dzStr=tostring(guid)
for i,v in ipairs(self.disciples)do
if mathHelper.compareInt64(v.discipleInfo.discipleguid,guid)then
self:setDZItem(i)
return
end
end
end

function UIShanMenBaiShanNewWin:setDZItem(index)
local item=self.diziList:getChildLayoutGroupGridItem(index-1)
if item then
local data=self.disciples[index]
local ddata=data.discipleInfo
local info=ddata.imageInfo
item:SetChildCSImageSprite(0,globalABLookup.diciplecolorframe,discipleColorToFrame2[info.color])
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
item:SetChildUIModelShowTarget(1,modelParams.body,0.5,modelParams.componets,eAnimationID.stand)
item:SetChildUIModelShowTargetOffset(1,0,-28)
item:SetChildActive(2,self.roleIndex==index)
local name=UIDiscipleModel:getDiscipleName(ddata.discipleguid)
item:SetChildText(3,name)
item:SetChildButtonClickWithID(0,function(index)
self:onClickDZItem(index)
end,index)
local tstate=shanmenModel:getBaiShanStateByDzId(data.discipleInfo.discipleguid)
item:SetChildActive(4,tstate==1)
item:SetChildActive(5,tstate==-1)
end
end

function UIShanMenBaiShanNewWin:onClickDZItem(index)
if self.roleIndex==index then return end
local lastItem=self.diziList:getChildLayoutGroupGridItem(self.roleIndex-1)
if lastItem then
lastItem:SetChildActive(2,false)
end
self.roleIndex=index
local item=self.diziList:getChildLayoutGroupGridItem(self.roleIndex-1)
item:SetChildActive(2,true)
local data=self.disciples[self.roleIndex]
self:refreshInfo(data)
end

function UIShanMenBaiShanNewWin:refreshInfo(data)
local ddata=data.discipleInfo
local info=ddata.imageInfo
self.dzId=ddata.discipleguid

self.pinjiImg:setSprite(self.yxtAB,FMT.fmt('image_pinjishibie_{0}',info.color))
self.pinjiBg:setSprite(self.smABName,FMT.fmt('image_baitiedizipz_{0}',info.color))
comHelper.setChildInSideModel(self.head,self.dzId,1.5,0,0,-100,false,true)
self.head:setChildUIModelShowFlipX(true)
local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(self.dzId)
self.model:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,eAnimationID.stand,false,false,0,function(...)
self.model:setChildUIModelShowFlipX(true)
self.model:setChildUIModelShowTargetOffset(0,-50)
end)
self.name:setText(ddata.disciplename)
self:RandomSpeak(math.random(5,8))

self.zhongzu:setText(cfgHelper.get2(cfg_discipleraceconfig_get,info.race,'name'))
self.xingbie:setText(cfgHelper.get2(cfg_disciplesexconfig_get,info.sex,'name'))
local sy=UIDiscipleModel:getDiscipleShouYuanDescEx(ddata)
self.shouyuan:setText(sy)
self.lichang:setText(cfgHelper.get2(cfg_disciplestandconfig_get,ddata.stand,'name'))
self.zhiye:setText(cfgHelper.get2(cfg_disciplevocationconfig_get,info.job,'name'))
local n,p,pN=UIDiscipleModel:getJJNameX(ddata.jingjielv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}',n,pN)
else
jj_str=n
end
self.jingjie:setText(jj_str)
local n1,p1=UIDiscipleModel:getLTNameX(ddata.liantilv)
local lt_lv_str=''
if p1~=nil then
lt_lv_str=FMT.fmt('{0}层',p1)
end
local lt_str=FMT.fmt('{0}{1}',n1,lt_lv_str)
self.tixiu:setText(lt_str)

self:RefreshDesc(ddata)

self:refreshPorSkill(ddata)

local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
local netData=data.discipleInfo
local allnum=0
local ratelist={}
local lookup={6,5,4,3,2,1}
for i,v in ipairs(netData.attrList)do
local a=v==0 and 1 or v
allnum=allnum+a
local aa=a
if aa>polygonMaxValue then
aa=polygonMaxValue
end
ratelist[lookup[i]]=aa/polygonMaxValue
end
local tVal=0
local wiget=self.polygonAttrPanel:getChildWidgetBase()
for i=1,6 do
local idx=i-1
local attrType=i
local v=netData.attrList[attrType]==0 and 1 or netData.attrList[attrType]
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#069067>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
tVal=tVal+v
end
wiget:SetChildUIPolygonImage(6,ratelist,0)

local color=info.color
local polygonIcon='image_shuxingtu_'..color
wiget:SetChildCSImageSprite(7,globalABLookup.diciplemain,polygonIcon)
self.totalValue:setText(FMT.fmt('总值：{0}',tVal))

local skillList=self:GetJobSkillList(ddata)
self.skills:setChildLayoutGroupCreateItems(#skillList)
local items=self.skills:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local sdata=skillList[i+1]
local skillID=sdata[1]
local skillLv=sdata[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local islock=skillLv<=0
item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),true)
item:SetChildImageExGray(0,islock)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)
item:SetChildButtonClick(3,function()
UIManager:showWindow('UIDiscipleJobSkillTipsWin',{skillID=skillID,skillLv=skillLv,attend=1})
end)
item:SetChildActive(4,not islock)
if not islock then
item:SetChildText(2,skillModel:getSkillLvStr(skillLv))
end
item:SetChildActive(5,islock)
end
self:refreshState(ddata.discipleguid,true)
self.ddata=data
end

function UIShanMenBaiShanNewWin:GetJobSkillList(data)
local imageInfo=data.imageInfo
local groupid=data.vocsgidx
local result=UIDiscipleModel:getDiscipleJobSkillListEx(groupid,imageInfo.job,data.jingjielv,data)
return result
end

function UIShanMenBaiShanNewWin:RefreshDesc(data)
local desclist=UIDiscipleModel:getDiscipleSpecialityConfigByData(data,true)
if not desclist then
return
end
local dataNum=#desclist
self.descScrollView:setChildScrollViewCreateGrids(dataNum,3)

local grids=self.descScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local cfg=desclist[i]
local item=grids[i-1]
UIDiscipleModel.refreshSpecialityItemEx(item,cfg)
end

self.desclist=desclist
end

function UIShanMenBaiShanNewWin.onDescSlotClick(clickNum,index)
local cfg=_this.desclist[index+1]
local item=_this.descScrollView:getChildScrollViewItemWidget(index)
local data=_this.disciples[_this.roleIndex]
local baseData=data.discipleInfo

if UIDiscipleModel.onClickClientSpeciality(item,baseData,cfg,eDirectionType.eRight)then
return
end

UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=baseData.discipleguid,config=cfg})
end

function UIShanMenBaiShanNewWin:getPorSkillDatas(proskilllist)
local list={}
if not proskilllist then
return list
end
local len=#proSkillSort
for i=1,len do
local ptype=proSkillSort[i]
local data=proskilllist[ptype]
if data.level>0 then
table.insert(list,{type=ptype,level=data.level})
end
end
return list
end

function UIShanMenBaiShanNewWin:refreshPorSkill(data)
local dataList=self:getPorSkillDatas(data.proskillList)
local len=#dataList
self.skillScrollView:setChildScrollViewCreateGrids(len,2)

local grids=self.skillScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local pd=dataList[i]
local item=grids[i-1]
local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,pd.type,'icon')
item:SetChildCSImageSprite(0,self.jobab,FMT.fmt('image_gongzhongtp_{0}',icon))
local name=cfgHelper.get2(cfg_discipleproskillconfig_get,pd.type,'name')
item:SetChildText(1,FMT.fmt('{0}：{1}级',name,pd.level))
end
end

function UIShanMenBaiShanNewWin:refreshState(discipleguid,usetimer)
local state=shanmenModel:getBaiShanStateByDzId(discipleguid)
self.btns:setActive(state==0)
self.zhaoruImg:setActive(state==1)
self.jujueImg:setActive(state==-1)
if not usetimer then
self:playSpeakText()
if state==1 then
self.model:setChildModelAnimationState(eAnimationID.ui_jump1)
end
end
end

function UIShanMenBaiShanNewWin:RandomSpeak(time)
self:playSpeakText()
self:clearSpeakTimer()
self.speakTimer=self:setTimer(time,1,function()
self:RandomSpeak(math.random(5,8))
end)
end

function UIShanMenBaiShanNewWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end
end

function UIShanMenBaiShanNewWin:playSpeakText()
local state=shanmenModel:getBaiShanStateByDzId(self.dzId)
local voc=UIDiscipleModel:getDiscipleJob(self.dzId)
local speakList
if state==0 then
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'baishanspeak1')
else
if state==1 then
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'baishanspeak2')
else
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'baishanspeak3')
end
end
local speakStr=speakList[math.random(1,#speakList)]
self.speakText:setText(speakStr)
self.speak:setChildCanvasGroupAlpha(1)
self:killSpeakTweener()
self.speakTweener=self.speak:setChildCanvasGroupDOFade(0,1)
self.speakTweener:SetDelay(3)
end

function UIShanMenBaiShanNewWin:killSpeakTweener()
if self.speakTweener then
self.speakTweener:Kill(false)
self.speakTweener=nil
end
end

function UIShanMenBaiShanNewWin:checkOperateLast()
local operateNum=0
for i,v in ipairs(self.disciples)do
local state=shanmenModel:getBaiShanStateByDzId(v.discipleInfo.discipleguid)
if state~=0 then
operateNum=operateNum+1
end
end
if operateNum+1>=#self.disciples then
return true
end
return false
end

function UIShanMenBaiShanNewWin:refreshCost()
local costList=shanmenModel.getBaiShanConfigField('consume')
local cost=costList[1]
self.costPanel:setActive(cost~=nil)
if cost then
local itemid=cost[1]
local need=cost[2]
local iconName=iconHelper.getIconName(itemid)
self.costImage:setImageIcon(iconName,false)
self.costTxt:setText(FMT.fmt('{0}',need))
end
end



function UIShanMenBaiShanNewWin:onNextBtn()
local index=self.roleIndex+1
if index>#self.disciples then
index=1
end
self:onClickDZItem(index)
end

function UIShanMenBaiShanNewWin:onLastBtn()
local index=self.roleIndex-1
if index<1 then
index=#self.disciples
end
self:onClickDZItem(index)
end

function UIShanMenBaiShanNewWin:onGiveUpBtn()
if UIDiscipleModel.checkDZHasLoveSpeciality(self.ddata.discipleInfo)then
local callback=function()
if _this==nil then return end
shanmenController:req_banshai_fail(_this.ddata.discipleInfo.discipleguid)
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSpecialityLoveGiveUp)
if not flag then
local contentStr='当前弟子拥有<color=#c82c2c>心仪特质</color>，拒收后弟子消失，确定拒招吗？'
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
showclosebtn=true,
allowclickBG=false,
oktext='确定',
canceltext='取消',
choosetext='<color=#c82c2c>心仪特质</color>今日不再提示',
choosecallback=function(flag)
if _this==nil then return end
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSpecialityLoveGiveUp,flag)
end,
okcallback=function()
if _this==nil then return end
callback()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
else
callback()
end
return
end
shanmenController:req_banshai_fail(self.ddata.discipleInfo.discipleguid)



end

function UIShanMenBaiShanNewWin:onSelectBtn()
if not self:checkCost()then
return
end
local maxDzCount=UIRecruitModel:getZongMenPeopleMax()
local curDzCount=UIDiscipleModel:checkDiscipleCount()
if curDzCount>=maxDzCount then
UIManager.info('宗门人数已达上限')
return
end
roleAudioController:playRoleSpeak(self.ddata.discipleInfo.discipleguid,roleAudioNodeType.ZhaoMuChengGong)
shanmenController:req_banshai_success(self.ddata.discipleInfo.discipleguid)



end

function UIShanMenBaiShanNewWin:checkCost()
local costList=shanmenModel.getBaiShanConfigField('consume')
local cost=costList[1]
local mtype=cost[1]
local need=cost[2]
local have=moneyModel.getMoney(mtype)
if have<need then
gainControl:showGainWin(mtype)
return false
end

return true
end

function UIShanMenBaiShanNewWin:onClickClose()
self:closeSelf()
end



function UIShanMenBaiShanNewWin:loadBaiTieAnim()
_this.winlua:SetChildAnimationStringID(_this.jieyouAnimaion:getID(),'baitie',true)
_this.zuoHeight=_this.winlua:GetChildSizeDeltaY(_this.shengziZuo:getID())
_this.zuoWidth=_this.winlua:GetChildSizeDeltaX(_this.shengziZuo:getID())

_this.winlua:SetChildAnimationStringID(_this.jiezuoAnimaion:getID(),'baitie',true)
_this.youHeight=_this.winlua:GetChildSizeDeltaY(_this.shengziYou:getID())
_this.youWidth=_this.winlua:GetChildSizeDeltaX(_this.shengziYou:getID())
end


function UIShanMenBaiShanNewWin.beginLeftDragCallback(index,position)
_this.beginLeftPosY=position.y
_this.currLeftPos=position
_this.tipsImg:setActive(false)
_this.effect1:setChildShowEffect(10112,false)
end

function UIShanMenBaiShanNewWin.leftDragCallback(index,position)
if position.y>_this.beginLeftPosY then
return
end

local dis=Vector2.Distance(_this.currLeftPos,position)
_this.currLeftPos=position

_this.zuoHeight=_this.zuoHeight+dis*0.5
_this.shengziZuo:setChildSizeDelta(_this.zuoWidth,_this.zuoHeight)

_this.currLeftFrame=_this.currLeftFrame+dis*0.1
local frame=_this:clampFrame(_this.currLeftFrame)
_this.winlua:SetChildAnimationCurrentFrame(_this.jieyouAnimaion:getID(),frame)

if frame>=_this.maxFrame then
_this:openInfo()
end

_this.beginLeftPosY=position.y
end

function UIShanMenBaiShanNewWin.endLeftDragCallback(index,position)
_this.effect1:setChildShowEffect(10112,true)
end

function UIShanMenBaiShanNewWin:clampFrame(frame)
frame=math.floor(frame)
if frame>self.maxFrame then
frame=self.maxFrame
elseif frame<self.minFrame then
frame=self.minFrame
end
return frame
end



function UIShanMenBaiShanNewWin.beginRightDragCallback(index,position)
_this.beginRightPosY=position.y
_this.currRightPos=position
_this.tipsImg:setActive(false)
_this.effect1:setChildShowEffect(10112,false)
end

function UIShanMenBaiShanNewWin.rightDragCallback(index,position)
if _this==nil or _this.isClose then return end
if position.y>_this.beginRightPosY then
return
end

local dis=Vector2.Distance(_this.currRightPos,position)
_this.currRightPos=position

_this.youHeight=_this.youHeight+dis*0.5
_this.shengziYou:setChildSizeDelta(_this.youWidth,_this.youHeight)

_this.currRightFrame=_this.currRightFrame+dis*0.1
local frame=_this:clampFrame(_this.currRightFrame)
_this.winlua:SetChildAnimationCurrentFrame(_this.jiezuoAnimaion:getID(),frame)

if frame>=_this.maxFrame then
_this:openInfo()
end

_this.beginRightPosY=position.y
end

function UIShanMenBaiShanNewWin.endRightDragCallback(index,position)
_this.effect1:setChildShowEffect(10112,true)
end




function UIShanMenBaiShanNewWin:toNext(state)
if not self.disciples then return end
local nextIndex
local len=#self.disciples
local selectIndex=self.roleIndex
if state then
local count=0
local lc=len-1
while(count<lc)do
local index=(selectIndex+count)%len+1
local td=self.disciples[index]
local tstate=shanmenModel:getBaiShanStateByDzId(td.discipleInfo.discipleguid)
if tstate==state then
nextIndex=index
break
end
count=count+1
end
if not nextIndex then
return
end
else
nextIndex=selectIndex%len+1
end

self:onClickDZItem(nextIndex)
end
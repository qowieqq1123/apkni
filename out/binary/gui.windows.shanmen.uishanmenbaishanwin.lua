







def_class("UIShanMenBaiShanWin",UIWindowBase)









function UIShanMenBaiShanWin:bindComponents()

self.lastBtn=UIButton.get(self,0)
self.nextBtn=UIButton.get(self,1)
self.InfoPanel1=UIObject.get(self,2)
self.InfoPanel2=UIObject.get(self,3)
self.InfoPanel3=UIObject.get(self,4)
self.root=UIObject.get(self,5)

self.lastBtn:setButtonClick(function()self:onLastBtn()end)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)



end


function UIShanMenBaiShanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.lastBtn);self.lastBtn=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.InfoPanel1);self.InfoPanel1=nil;
_UIObject_release(self.InfoPanel2);self.InfoPanel2=nil;
_UIObject_release(self.InfoPanel3);self.InfoPanel3=nil;
_UIObject_release(self.root);self.root=nil;
end

















local _info_index=
{
head=0,
speakObj=1,
txtSpeak=2,
dzName=3,
jjName=4,
descText=5,
dzCount=6,
successImg=7,
failImg=8,
bottom=9,
costIcon=10,
costTxt=11,
}


function UIShanMenBaiShanWin:onLoaded(...)
self:bindComponents()
self.InfoPanel={self.InfoPanel1,self.InfoPanel2,self.InfoPanel3}
self.discipleDescStr={}
end


function UIShanMenBaiShanWin:__delete()
self:unbindComponents()
end




function UIShanMenBaiShanWin:onShow(argtable,afterOnloaded)
self.dzId=argtable
local datas=shanmenModel:getBaiShanData()
local showList={}
for i,v in ipairs(datas)do
table.insert(showList,v)
end
self.disciples=showList
local _,index=shanmenModel:getBaiShanDataByDzId(self.dzId)
self.curDzIdx=index
local num=#self.disciples>3 and 3 or#self.disciples
for i=1,num do
local widget=self.InfoPanel[i]:getWidgetBase()
widget:SetChildActive(-1,true)
local dzIdx=self.curDzIdx+i-1
if dzIdx>#self.disciples then
dzIdx=dzIdx-#self.disciples
end
local bsData=self.disciples[dzIdx]
local dzId=bsData.discipleInfo.discipleguid
self:refreshDidcipleInfo(widget,dzId)
end
self.lastBtn:setActive(#self.disciples>1)
self.nextBtn:setActive(#self.disciples>1)
end


function UIShanMenBaiShanWin:onHide()

end

function UIShanMenBaiShanWin:refreshDidcipleInfo(widget,dzId,useLast)
local model=UIDiscipleModel:getDiscipleInsideModelInfo(dzId)

widget:SetChildDragoneBoneImageTarget(_info_index.head,model.body,model.componets,0,false,0,0,1.0,false)
widget:SetChildText(_info_index.dzName,UIDiscipleModel:getDiscipleName(dzId))
local jjlv=UIDiscipleModel:getDiscipleJJLevel(dzId)
local jjname,p,pn=UIDiscipleModel:getJJNameX(jjlv)
widget:SetChildText(_info_index.jjName,FMT.fmt('境界：{0}{1}',jjname,pn))
local descStr=''
if useLast then
descStr=self.discipleDescStr[tostring(self.lastDzId)]or''
else
local voc=UIDiscipleModel:getDiscipleJob(dzId)
local speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'baishanspeak1')
local rand=math.random(1,#speakList)
descStr=speakList[rand]
self.discipleDescStr[tostring(dzId)]=descStr
end
widget:SetChildText(_info_index.descText,descStr)
self:refreshState(widget,dzId)
self:refreshCost(widget)
end

function UIShanMenBaiShanWin:refreshCost(widget)

local curDzCount=UIDiscipleModel:checkDiscipleCount()
local maxDzCount=UIRecruitModel:getZongMenPeopleMax()
widget:SetChildText(_info_index.dzCount,FMT.fmt('{0}/{1}',curDzCount,maxDzCount))

local costList=shanmenModel.getBaiShanConfigField('consume')
local cost=costList[1]
local itemid=cost[1]
local need=cost[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
local iconName=iconHelper.getIconName(itemid)
widget:SetChildCSImageIcon(_info_index.costIcon,iconName,false)
widget:SetChildText(_info_index.costTxt,FMT.fmt('{0}/{1}',mathHelper.formatNumber(have),mathHelper.formatNumber(need)))
end

function UIShanMenBaiShanWin:refreshState(widget,dzId)
if mathHelper.compareInt64(self.dzId,dzId)then
local state=shanmenModel:getBaiShanStateByDzId(dzId)
if not widget then
for i=1,2 do
widget=self.InfoPanel[i]:getWidgetBase()
self:refreshStateEx(widget,state)
end
else
self:refreshStateEx(widget,state)
end
end
end

function UIShanMenBaiShanWin:refreshStateEx(widget,state)
widget:SetChildActive(_info_index.successImg,state==1)
widget:SetChildActive(_info_index.failImg,state==-1)
widget:SetChildActive(_info_index.bottom,state==0)

widget:SetChildActive(_info_index.speakObj,state~=0)
if state~=0 then
local speakList
local voc=UIDiscipleModel:getDiscipleJob(self.dzId)
if state==1 then
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'baishanspeak2')
else
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'baishanspeak3')
end
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
widget:SetChildText(_info_index.txtSpeak,speakStr)
end
end

function UIShanMenBaiShanWin:waitClickBtn()
self.clickWait=true
self:delayDo(0.6,function(...)
self.clickWait=nil
end)
end



function UIShanMenBaiShanWin:onLastBtn()
if self.clickWait then
return
end
self:waitClickBtn()
local bsData=self.disciples[self.curDzIdx]
self.lastDzId=bsData.discipleInfo.discipleguid
self.curDzIdx=self.curDzIdx-1
if self.curDzIdx<1 then
self.curDzIdx=#self.disciples
end

local widget1=self.InfoPanel[2]:getWidgetBase()
self:refreshDidcipleInfo(widget1,self.dzId,true)

local bsData=self.disciples[self.curDzIdx]
self.dzId=bsData.discipleInfo.discipleguid
local widget2=self.InfoPanel[1]:getWidgetBase()
self:refreshDidcipleInfo(widget2,self.dzId)

self.winlua:SetAsFirstSibling(self.InfoPanel1:getID())
self.root:setAnimatorInteger('state',2,true)
self:delayDo(0.3,function(...)
self.winlua:SetAsLastSibling(self.InfoPanel1:getID())
end)
end


function UIShanMenBaiShanWin:onNextBtn()
if self.clickWait then
return
end
self:waitClickBtn()
local bsData=self.disciples[self.curDzIdx]
self.lastDzId=bsData.discipleInfo.discipleguid
self.curDzIdx=self.curDzIdx+1
if self.curDzIdx>#self.disciples then
self.curDzIdx=1
end

local widget1=self.InfoPanel[1]:getWidgetBase()
self:refreshDidcipleInfo(widget1,self.dzId,true)

local bsData=self.disciples[self.curDzIdx]
self.dzId=bsData.discipleInfo.discipleguid
local widget2=self.InfoPanel[2]:getWidgetBase()
self:refreshDidcipleInfo(widget2,self.dzId)

self.winlua:SetAsLastSibling(self.InfoPanel1:getID())
self.root:setAnimatorInteger('state',1,true)
self:delayDo(0.3,function(...)
self.winlua:SetAsFirstSibling(self.InfoPanel1:getID())
end)
end


function UIShanMenBaiShanWin:onInfoBtn()
local costList=shanmenModel.getBaiShanConfigField('consume')
local cost=costList[1]
UIManager:showWindow('UIRecruitInfoWin',{index=self.curDzIdx,datas=self.disciples,mode=4,cost=cost})
end


function UIShanMenBaiShanWin:onJujueBtn()
local bsData=self.disciples[self.curDzIdx]
if UIDiscipleModel.checkDZHasLoveSpeciality(bsData.discipleInfo)then
local callback=function()
if _this==nil then return end
shanmenController:req_banshai_fail(_this.dzId)
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
shanmenController:req_banshai_fail(self.dzId)
end


function UIShanMenBaiShanWin:onZhoruBtn()
local canZhaoRu,msg=shanmenModel:checkZhaoru()
if not canZhaoRu then
UIManager.error(msg)
return
end
shanmenController:req_banshai_success(self.dzId)
end

function UIShanMenBaiShanWin:onClickClose()
self:closeSelf()
end

function UIShanMenBaiShanWin:checkCloseWin()
local notClose=false
for i,v in ipairs(self.disciples)do
local state=shanmenModel:getBaiShanStateByDzId(v.discipleInfo.discipleguid)
if state==0 then
notClose=true
break
end
end
if not notClose then
self:closeSelf()
end
end
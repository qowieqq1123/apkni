







def_class("UIRecruitJZWin",UIWindowBase)








function UIRecruitJZWin:bindComponents()

self.againBtn=UIButton.get(self,0)
self.recruitPos1=UIObject.get(self,1)
self.recruitPos2=UIObject.get(self,2)
self.recruitPos3=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.title=UIText.get(self,5)

self.againBtn:setButtonClick(function()self:onAgainBtn()end)



end


function UIRecruitJZWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.againBtn);self.againBtn=nil;
_UIObject_release(self.recruitPos1);self.recruitPos1=nil;
_UIObject_release(self.recruitPos2);self.recruitPos2=nil;
_UIObject_release(self.recruitPos3);self.recruitPos3=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _this




function UIRecruitJZWin:onLoaded(...)
self:bindComponents()

self.posWidgets={
self.recruitPos1,
self.recruitPos2,
self.recruitPos3
}

self.zmtimers={}
self.roateTimers={}

self.zmDzBT={}

self.idleList={{-177,-220},{82,-220},{341,-220}}
self.enterList={{441,-288},{530,-288},{589,-288}}
self.jumpList={{-177,-288},{82,-288},{341,-288}}

self.abName='ui/windows/recruit/sharedtextures/jiazuzhaomu.ab'
self.globalAB='ui/sharedtextures/uiglobalspriteatlas_1.ab'
self.speakSkin={'frame_duihuaqipaokuang_1','frame_duihuaqipaokuang_2'}

local datas=worldXiuZhenJiaZuModel:getAllSelfFamilyData()
self.familyList={}
for i,v in ipairs(datas)do
self.familyList[v.familyId]=v
end

_this=self
self.tweener={}
end


function UIRecruitJZWin:__delete()
_this=nil
self:removeAllZhaoMuDz()
self:endZLDaJiangYou()
self.zmDzBT=nil

UIManager:invokeUIMethod('UIRecruitMainWin','refreshFamilyInfo')
self:stopAllRoateTimer()

uiAIManager:clearUIWinData('UIRecruitJZWin')
self:unbindComponents()
end

function UIRecruitJZWin:getRecruitData()
local list={}
local datas=UIRecruitModel:getAllFamilyData()
for k,v in pairs(datas)do
if v.state==0 then
list[v.pos]=v
end
end
return list
end




function UIRecruitJZWin:onShow(argtable,afterOnloaded)
self:resetPos(1,true)
self:resetPos(2)
self:resetPos(3)
self:createJYZhangLao()
self:refreshAgainBtn()
end


function UIRecruitJZWin:onHide()

end

function UIRecruitJZWin:resetPos(pos,resetData,fadeAnim)
pos=pos or self.selectPos
if resetData then
self.datas=self:getRecruitData()
end
self:setRecruitPos(pos,self.posWidgets[pos],self.datas[pos],fadeAnim)
end

function UIRecruitJZWin:setRecruitPos(pos,posWidget,data,fadeAnim)
self:stopRoateTimer(pos)
local stime=gameUtilityModel.getServerShortTime()
local widget=posWidget:getChildWidgetBase()
if data then
if self.tweener[pos]then
self.tweener[pos]:Kill()
self.tweener[pos]=nil
end
local cfg=cfgHelper.get1(cfg_xiuzhenfamilydataconfig_get,data.familyid)
local zzcfg=cfgHelper.get1(cfg_xiuzhenfamilyelderconfig_get,cfg.elder_id)
local mode=self:getZuZhangImageInfo(zzcfg.model_outside)
widget:SetChildUIModelShowTarget(3,mode.body,1,mode.componets,eAnimationID.stand)
widget:SetChildUIModelShowTargetOffset(3,0,-50)
widget:SetChildCanvasGroupAlpha(3,1)

if stime>=data.endtime then
widget:SetChildActive(1,false)
widget:SetChildActive(2,true)
self:refreshWanCheng(pos)
else
widget:SetChildActive(1,true)
widget:SetChildActive(2,false)

local rw=widget:GetChildWidgetBase(1)

local dtime=data.endtime-stime
self:startTimer(data.familyid,rw,dtime,pos)

local jycfg=cfgHelper.get1(cfg_disciplevocationconfig_get,data.voc)
rw:SetChildText(2,jycfg.name)

local lgcfg=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,data.spiritrootid)
rw:SetChildText(3,lgcfg.name)
rw:SetChildCSImageSprite(4,self.abName,FMT.fmt('frame_linggen_{0}',data.spiritrootid))
self:startRoateTimer(rw,pos)
end
else
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildButtonClickWithID(0,self.onAPClick,pos)
end
if fadeAnim and data==nil then
widget:SetChildActive(4,false)
local func=function(...)
widget:SetChildActive(0,true)
self.tweener[pos]=nil
end
self.tweener[pos]=widget:SetChildCanvasGroupDOFade(3,0,1,func)
local bt=self.zmDzBT[pos]
if bt then
bt:setSharedVar('UIstateId',3)
bt:reset()
end
else
widget:SetChildActive(0,data==nil)
widget:SetChildActive(4,data~=nil)
end
end

function UIRecruitJZWin:refreshAgainBtn()
local isValid=false
local jiazuzhaomuAgain=userActorSetting.get("jiazuzhaomuAgain",{})
for pos=1,3 do
local data=self.datas[pos]
if data==nil then
isValid=true
break
end
end
local contains={}
for pos=1,3 do
if not jiazuzhaomuAgain[pos]or type(jiazuzhaomuAgain[pos])~='table'then
isValid=false
break
else
local guidStr=jiazuzhaomuAgain[pos][3]
local familyData=worldXiuZhenJiaZuModel:getFamilyDataByGuid(int64.new(guidStr))
if not familyData or familyData.state~=familyState.player then
isValid=false
break
end
if contains[guidStr]then
isValid=false
break
end
contains[guidStr]=true
end
end
self.againBtn:setActive(isValid)
end

function UIRecruitJZWin:refreshWanCheng(pos)
self:stopRoateTimer(pos)
local posWidget=self.posWidgets[pos]
local widget=posWidget:getChildWidgetBase()
widget:SetChildActive(1,false)
widget:SetChildActive(2,true)
if self.zmDzBT[pos]==nil then
local data=self.datas[pos]
local ddata=data.discipleInfo
local rw=widget:GetChildWidgetBase(2)
rw:SetChildActive(1,false)
rw:SetChildButtonClickWithID(1,self.onShowClick,pos)
local rc=UIRecruitModel:getWatchRecord(data.familyid)
rw:SetChildActive(2,rc)
local ddata=data.discipleInfo
rw:SetChildText(0,ddata.disciplename)
local tran=self.root:getCommonComponent('Transform')
self:createZMDZ(tran,ddata.discipleguid,Vector2.New(750,-288),pos,function(bt)
self.zmDzBT[pos]=bt
self.zmDzBT[pos]:setSharedVar('UIstateId',6)
end)
end
end


function UIRecruitJZWin:createJYZhangLao()
local haveAnPai=UIRecruitModel:chekHaveAnPai()
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJieYin)or{}
if not haveAnPai and self.ZlBT==nil and#dis_list>0 then
local guid=dis_list[1].discipleguid
self:createZL(guid,Vector2.New(-500,-288),function(bt)
self.ZlBT=bt
self.ZlBT:setSharedVar('UIstateId',4)
end)
end
end

function UIRecruitJZWin:createZL(dzId,pos,callback)
local initData={
speakHUDID=1,
speakTime=3,
speakHUDParent=1,
offset={0,0},
idlePos={-379,-220},
enterPos={-500,-288},
jumpPos={-380,-288},
}
local tran=self.root:getCommonComponent('Transform')



uiAIManager:createUIDisciple('UIRecruitJZWin','bt_ui_zm_jz',dzId,tran,pos,initData,nil,function(bt)
callback(bt)
end)
end

function UIRecruitJZWin:endZLDaJiangYou()
if self.ZlBT then

uiAIManager:removeUIInstance(self.ZlBT)
self.ZlBT=nil
end
end

function UIRecruitJZWin:getZLSpeakText(bt,tkey)


local speaks=cfgHelper.get2(cfg_yinxiantaiconfig_get,1,'jz_speak')
bt:setSharedVar(tkey,speaks[math.random(1,#speaks)])
end


function UIRecruitJZWin:createZMDZ(tran,dzId,pos,index,callback)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
idlePos=self.idleList[index],
enterPos=self.enterList[index],
jumpPos=self.jumpList[index],
posIndex=index,
}



uiAIManager:createUIDisciple('UIRecruitJZWin','bt_ui_zm_jz',dzId,tran,pos,initData,nil,function(bt)
callback(bt)
end)
end

function UIRecruitJZWin:getDzSpeakText(bt,index,tkey)
local data=self.datas[index]
local ddata=data.discipleInfo
local texts=cfgHelper.get2(cfg_yinxiantaispeakconfig_get,ddata.imageInfo.job,'idle')
local speakTexts=texts[ddata.imageInfo.sex]or{'...'}
local str=speakTexts[math.random(1,#speakTexts)]
bt:setSharedVar(tkey,str)
end

function UIRecruitJZWin:resetDzSpeak()
for i,v in pairs(self.datas)do
local bt=self.zmDzBT[v.pos]
if bt then
bt:setSharedVar('UIstateId',2)
bt:reset()
end
end
end

function UIRecruitJZWin:endZhaoMu(index)
if self.zmDzBT[index]then

uiAIManager:removeUIInstance(self.zmDzBT[index])
self.zmDzBT[index]=nil
end
end

function UIRecruitJZWin:removeAllZhaoMuDz()
for k,v in pairs(self.zmDzBT)do

uiAIManager:removeUIInstance(v)
end
end

function UIRecruitJZWin:arrivePointDZ(index)
local posWidget=self.posWidgets[index]
local widget=posWidget:getChildWidgetBase()
local item=widget:GetChildWidgetBase(2)
item:SetChildActive(1,true)
end

function UIRecruitJZWin:startRoateTimer(item,pos)
local func=function(...)
local sousuoImg=item:GetChildGameObject(5).transform
local tarTrans=item:GetChildGameObject(6).transform
sousuoImg:RotateAround(tarTrans.position,Vector3(0,0,1),8)
item:SetChildRotation(5,0,0,0)
end
self.roateTimers[pos]=self:setTimer(0.01,0,func)
end

function UIRecruitJZWin:stopRoateTimer(pos)
if self.roateTimers[pos]then
self:stopTimerByID(self.roateTimers[pos])
self.roateTimers[pos]=nil
end
end

function UIRecruitJZWin:stopAllRoateTimer()
for i,v in ipairs(self.roateTimers)do
self:stopTimerByID(v)
self.roateTimers[i]=nil
end
end

function UIRecruitJZWin:getFamilyName(fId)
local sdata=self.familyList[fId]
local index,sd
if sdata then
index,sd=worldXiuZhenJiaZuModel:getFamilyScaleData(sdata.guid)
else
local cfg=cfg_xiuzhenfamilybasicconfig_get(worldModel.world)
index=1
sd=cfg.family_pre_names[1]
end
local elderCfg=worldXiuZhenJiaZuModel:getElderConfig(fId)
local name=FMT.fmt('{0}·{1}',sd[3],elderCfg.elder_lastname)
return name
end

function UIRecruitJZWin:getZuZhangImageInfo(args)
local result={}
result.body=args[1]
result.componets={}
for i=2,#args do
result.componets[#result.componets+1]=args[i]
end
return result
end

function UIRecruitJZWin.onAPClick(id)
local check=worldXiuZhenJiaZuModel:isHaveFamilyData()
if not check then
UIManager.info('暂无家族')
return
end
UIManager:showWindow('UIRecruitJZAPWin',id)
end

function UIRecruitJZWin:checkCost(guid)
local index
if guid then
index=worldXiuZhenJiaZuModel:getFamilyScaleData(guid)
else
index=1
end
local cfg=cfgHelper.get1(cfg_yinxiantaijzscaleconfig_get,index)
for i,v in ipairs(cfg.consume)do
local have=moneyModel.getMoney(v[1])
if have<v[2]then
local name=moneyModel.getMoneyName(v[1])
UIManager.error(FMT.fmt('{0}不足',name))
gainControl:showGainWin(v[1])
return false
end
end
return true
end

function UIRecruitJZWin:getAllShowDisciple(flag)
local stime=gameUtilityModel.getServerShortTime()
local list={}
for i,v in pairs(self.datas)do
local rc=UIRecruitModel:getWatchRecord(v.familyid)
if rc==flag and stime>=v.endtime then
table.insert(list,v)
end
end
return list
end

function UIRecruitJZWin.onShowClick(id)
local data=_this.datas[id]
local rc=UIRecruitModel:getWatchRecord(data.familyid)
local showAnim=not rc
if showAnim then
_this.selectPos=id
local list=_this:getAllShowDisciple(rc)
for i,v in ipairs(list)do
UIRecruitModel:setWatchRecord(v.familyid,true)
end
UIRecruitModel:saveWatchRecord()
UIManager:showWindow('UIRecruitSelectWin',{showAnim=showAnim,showList=list,infoList=list})
else
local list=_this:getAllShowDisciple(rc)
for i,v in ipairs(list)do
if v==data then
id=i
end
end
UIManager:showWindow('UIRecruitInfoWin',{index=id,datas=list,mode=2})
end
local bt=_this.zmDzBT[id]
if bt then
bt:setSharedVar('UIstateId',0)
bt:broke()
bt:reset()
end
end

function UIRecruitJZWin:startTimer(id,item,tcount,pos)
self:clearTimer(id)

local endtime=tcount+os.time()
item:SetChildText(1,timeHelper.format_time_stamp3(tcount))
self.zmtimers[id]=self:setTimer(1,tcount+3,function()
local dt=endtime-os.time()
if dt<=0 then
self:clearTimer(id)
self:refreshWanCheng(pos)
return
end
item:SetChildText(1,timeHelper.format_time_stamp3(dt))
end)
end

function UIRecruitJZWin:clearTimer(id)
if self.zmtimers[id]then
self:stopTimerByID(self.zmtimers[id])
self.zmtimers[id]=nil
end
end




function UIRecruitJZWin:onClickClose()
self:closeSelf()
end

function UIRecruitJZWin:onAgainBtn()
local jiazuzhaomuAgain=userActorSetting.get("jiazuzhaomuAgain",{})
for pos=1,3 do
local data=self.datas[pos]
if data==nil then
if not jiazuzhaomuAgain[pos]or type(jiazuzhaomuAgain[pos])~='table'then
break
end
local pos,world,guidStr,zy,lg=unpack(jiazuzhaomuAgain[pos])
local guid=int64.new(guidStr)
if _this:checkCost(guid)then
UIRecruitControl:reqRecruitJZ(pos,world,guid,zy,lg)
end
end
end
end
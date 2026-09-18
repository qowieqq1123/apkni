







def_class("UIRecruitMainWin",UIWindowBase)









function UIRecruitMainWin:bindComponents()

self.closebg=UIButton.get(self,0)
self.guarantTips=UIObject.get(self,1)
self.guarantTipsText=UIText.get(self,2)
self.icon=UIImage.get(self,3)
self.jzTips=UIText.get(self,4)
self.jzTipsIcon=UIImage.get(self,5)
self.jzTipsRoot=UIObject.get(self,6)
self.paizi=UIButton.get(self,7)
self.reciurtBtnJZ=UIButton.get(self,8)
self.reciurtBtnZM=UIButton.get(self,9)
self.reciurtReddotJZ=UIObject.get(self,10)
self.reciurtReddotZM=UIObject.get(self,11)
self.reclurtTextJZ=UIText.get(self,12)
self.reclurtTextZM=UIText.get(self,13)
self.root=UIObject.get(self,14)
self.setupBtn=UIButton.get(self,15)
self.shopBtn=UIButton.get(self,16)
self.skipAnimationRoot=UIObject.get(self,17)
self.skipAnimationtip1=UIText.get(self,18)
self.skipAnimationtip2=UIText.get(self,19)
self.skipSelectBtn=UIButton.get(self,20)
self.skipSelectImg=UIObject.get(self,21)
self.skipTipImg=UIObject.get(self,22)
self.tezhiTJBtn=UIButton.get(self,23)
self.tezhiTJBtnReddot=UIObject.get(self,24)
self.xyxfbg=UIObject.get(self,25)
self.xyxfcountdown=UIText.get(self,26)
self.XYXFEnter=UIButton.get(self,27)
self.xyxfenterModel=UIObject.get(self,28)
self.zhanglao=UIObject.get(self,29)
self.zhaoMuLingRoot=UIObject.get(self,30)
self.zmTips=UIText.get(self,31)

self.closebg:setButtonClick(function()self:onClosebg()end)

self.paizi:setButtonClick(function()self:onPaizi()end)

self.reciurtBtnJZ:setButtonClick(function()self:onReciurtBtnJZ()end)

self.reciurtBtnZM:setButtonClick(function()self:onReciurtBtnZM()end)

self.setupBtn:setButtonClick(function()self:onSetupBtn()end)

self.shopBtn:setButtonClick(function()self:onShopBtn()end)

self.skipSelectBtn:setButtonClick(function()self:onSkipSelectBtn()end)

self.tezhiTJBtn:setButtonClick(function()self:onTezhiTJBtn()end)

self.XYXFEnter:setButtonClick(function()self:onXYXFEnter()end)



end


function UIRecruitMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closebg);self.closebg=nil;
_UIObject_release(self.guarantTips);self.guarantTips=nil;
_UIObject_release(self.guarantTipsText);self.guarantTipsText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.jzTips);self.jzTips=nil;
_UIObject_release(self.jzTipsIcon);self.jzTipsIcon=nil;
_UIObject_release(self.jzTipsRoot);self.jzTipsRoot=nil;
_UIObject_release(self.paizi);self.paizi=nil;
_UIObject_release(self.reciurtBtnJZ);self.reciurtBtnJZ=nil;
_UIObject_release(self.reciurtBtnZM);self.reciurtBtnZM=nil;
_UIObject_release(self.reciurtReddotJZ);self.reciurtReddotJZ=nil;
_UIObject_release(self.reciurtReddotZM);self.reciurtReddotZM=nil;
_UIObject_release(self.reclurtTextJZ);self.reclurtTextJZ=nil;
_UIObject_release(self.reclurtTextZM);self.reclurtTextZM=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.setupBtn);self.setupBtn=nil;
_UIObject_release(self.shopBtn);self.shopBtn=nil;
_UIObject_release(self.skipAnimationRoot);self.skipAnimationRoot=nil;
_UIObject_release(self.skipAnimationtip1);self.skipAnimationtip1=nil;
_UIObject_release(self.skipAnimationtip2);self.skipAnimationtip2=nil;
_UIObject_release(self.skipSelectBtn);self.skipSelectBtn=nil;
_UIObject_release(self.skipSelectImg);self.skipSelectImg=nil;
_UIObject_release(self.skipTipImg);self.skipTipImg=nil;
_UIObject_release(self.tezhiTJBtn);self.tezhiTJBtn=nil;
_UIObject_release(self.tezhiTJBtnReddot);self.tezhiTJBtnReddot=nil;
_UIObject_release(self.xyxfbg);self.xyxfbg=nil;
_UIObject_release(self.xyxfcountdown);self.xyxfcountdown=nil;
_UIObject_release(self.XYXFEnter);self.XYXFEnter=nil;
_UIObject_release(self.xyxfenterModel);self.xyxfenterModel=nil;
_UIObject_release(self.zhanglao);self.zhanglao=nil;
_UIObject_release(self.zhaoMuLingRoot);self.zhaoMuLingRoot=nil;
_UIObject_release(self.zmTips);self.zmTips=nil;
end
















local _this
local _zhaoMuLingItemIds={
red=10506,
orange=10505
}




function UIRecruitMainWin:onLoaded(...)
self:bindComponents()

_this=self

self.abName='ui/sharedtextures/uiglobalspriteatlas_1.ab'
self.iconName={[-2]='icon_tyshijian',[-1]='icon_dizidengdai',[1]='icon_zhaomujuan'}

notifySystem:listenNotify(notifyConfig.onDisciplePosChange,self.on_pos_change)

local showSetup=guildOrderModel:checkOrderActive(GUILD_ORDER_TYPE.eQuicklyZhaoMu)
self.setupBtn:setActive(showSetup)

self.isSkipAmimation=userActorSetting.get("YXT_SkipAnimation",false)

self:showTopMoney()

self:addNotify(notifyConfig.on_item_list_changed,function(...)self:on_item_list_changed(...)end)


self:addNotify(notifyConfig.onTeZhiTujianReddotChange,function(...)self:freshTZReddot(...)end)
self:initZhaoMuLingBtnRoot()
end

function UIRecruitMainWin:showTopMoney()
UIManager:showWindow('UITopMoneyWin',{{eMoneyType.mtChenYuan},{eMoneyType.mtXianYuan}})
end


function UIRecruitMainWin:__delete()

cameraControl.setCameraActive(true)
self:unbindComponents()

UIManager:closeWindow('UITopMoneyWin')

_this=nil

if self.xyxftimer then
self:stopTimerByID(self.xyxftimer)
self.xyxftimer=nil
end


notifySystem:removelistener(notifyConfig.onDisciplePosChange,self.on_pos_change)
end

function UIRecruitMainWin.on_pos_change(guid,pos)
_this:Refresh()
_this:ResetElder()
end




function UIRecruitMainWin:onShow(argtable,afterOnloaded)
if TeZhiTuJianController:checkSysOpen()then
self.tezhiTJBtn:setActive(true)
self:freshTZReddot()

if argtable and argtable.exArgs and argtable.exArgs.showTeZhi then
self:onTezhiTJBtn()
end
else
self.tezhiTJBtn:setActive(false)
end

local mode
if argtable then
mode=argtable.mode
self.rdata=argtable.data
self.bdData=argtable.bdData
local exArgs=argtable.exArgs
if exArgs then
if exArgs.showShop then
self:onShopBtn()
end
end
end
self:Refresh()
self:ResetElder()

if mode==1 then
self:ShowSelectUI(mode)
end
cameraControl.setCameraActive(false)
end

function UIRecruitMainWin:ResetElder()
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJieYin)or{}
if#dis_list>0 then
self.paizi:setActive(false)
self.zhanglao:setActive(true)
local guid=dis_list[1].discipleguid
local info=UIDiscipleModel:getDiscipleOutsideModelInfo(guid)
local scale=isometricMapSystem:getModelScale(info.body,true)
self.zhanglao:setChildUIModelShowTarget(info.body,scale,info.componets,eAnimationID.stand)
self.zlGuid=guid
else
self.zlGuid=nil
self.paizi:setActive(true)
self.zhanglao:setActive(false)
end
end

function UIRecruitMainWin:Refresh()
self.waitReq=false
local def=cfgHelper.getdef(cfg_yinxiantaizmconfig)
local times=UIRecruitModel:getRecruitTimes()
local count=UIRecruitModel:getRecruitDiscipleCount()
if count>0 then
self.zmTips:setText('弟子等待中')
self.reclurtTextZM:setText('查\n看')
self.way=-1
else
if times>0 then
self.zmTips:setText(string.format('剩余%s次',times))
self.way=0
else
local itemId=def.itemid
self.retItem=itemId
local itemCount=bagModel.getItemCountById(itemId)
if itemCount>0 then
local cfg=itemsHelper:get_item_config(itemId)
self.zmTips:setText(string.format('%sx%s',cfg.name,itemCount))
self.way=1
else
self:ShowCountDown()
self.way=-2
end
end
if pfwindowslController:checkIsGameVersion_oumei()then
self.reclurtTextZM:setText('Recruit')
else
self.reclurtTextZM:setText('招\n募')
end
end

if self.way~=-2 and times<def.maxfree and self:getRecruitLastTime()<=0 then
self:RequestTimes()
end

local showIcon=self.way~=0
self.icon:setActive(showIcon)
if showIcon then
self.icon:setSprite(self.abName,self.iconName[self.way])
end

self.reciurtReddotZM:setActive(UIRecruitModel:isCanNormalRecruit())

self:refreshFamilyInfo()

self:RefreshGuarantTipsStr(true)

self:refreshSkipAnimationRoot()

self:refreshXYXFEnter()

self:refreshZhaoMuLingItemCountDisplay()
end

function UIRecruitMainWin:refreshFamilyInfo()
local jzstate,dt=UIRecruitModel:getFamilyDataState()
if jzstate==0 then
self.reclurtTextJZ:setText('暂无\n家族')
elseif jzstate==1 then
self.reclurtTextJZ:setText('安\n排')
elseif jzstate==2 then
self.reclurtTextJZ:setText('查\n看')
elseif jzstate==3 then
self.reclurtTextJZ:setText('培\n养\n中')
end
self.jzstate=jzstate
local reddot=UIRecruitModel:checkFamilyReddot()
self.reciurtReddotJZ:setActive(reddot)
self.winlua:SetChildGraphicGray(self.reciurtBtnJZ:getID(),jzstate==0)

local frtime=self:getFamilyRecruitTime()
local bshow=frtime~=nil
self.jzTipsRoot:setActive(bshow)
if bshow then
self.jzTipsIcon:setSprite(self.abName,self.iconName[-2])
local stime=gameUtilityModel.getServerShortTime()
self:ShowCountDownJZ(frtime-stime)
end
end

function UIRecruitMainWin:getFamilyRecruitTime()
local fdatas=UIRecruitModel:getAllFamilyData()
local stime=gameUtilityModel.getServerShortTime()
local timeList={}
for k,v in pairs(fdatas)do
if v.state==0 then
if v.endtime>stime then
table.insert(timeList,v.endtime)
end
end
end
local len=#timeList
if len>0 then
if len>1 then
table.sort(timeList,function(a,b)
return a<b
end)
end
return timeList[1]
end
return nil
end

function UIRecruitMainWin:getDuration()
local cfgs=cfg_yinxiantaizmadjustconfig()
local attrCfg=cfgHelper.getdef1(cfg_yinxiantaizmconfig,'attr6')
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJieYin)or{}
local index=1
if#dis_list>0 then
local ddata=dis_list[1]
local count=0
for i,v in ipairs(attrCfg)do
count=count+ddata.attrList[v]
end
for i,v in ipairs(cfgs)do
if count>=v.minval and count<=v.maxval then
index=i
end
end
if not index then
index=#cfgs
end
end
return cfgs[index].duration
end

function UIRecruitMainWin:getRecruitLastTime()
local lastTime=UIRecruitModel:getRecruitLastTime()
local ntime=lastTime+self:getDuration()
local ctime=gameUtilityModel.getServerShortTime()
local time=ntime-ctime
return time
end

function UIRecruitMainWin:ShowCountDown()
local time=self:getRecruitLastTime()
if time>0 then
local endTime=os.time()+time
self:SetCountDown(self.zmTips,time)
self:ClearTimer()
self.timer=self:setTimer(1,time+3,function()
local dt=endTime-os.time()
if dt>=0 then
self:SetCountDown(self.zmTips,dt)
else
self:RequestTimes()
end
end)
else
self:RequestTimes()
end
end

function UIRecruitMainWin:ShowCountDownJZ(time)
local endTime=os.time()+time
self:SetCountDown(self.jzTips,time)
self:ClearTimerJZ()
self.timerJZ=self:setTimer(1,time+3,function()
local dt=endTime-os.time()
if dt>=0 then
self:SetCountDown(self.jzTips,dt)
else
self:refreshFamilyInfo()
end
end)
end

function UIRecruitMainWin:RequestTimes()
UIRecruitControl:reqRefreshRecruitTimes()
self:ClearTimer()
end

function UIRecruitMainWin:ClearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIRecruitMainWin:ClearTimerJZ()
if self.timerJZ then
self:stopTimerByID(self.timerJZ)
self.timerJZ=nil
end
end

function UIRecruitMainWin:SetCountDown(txt,time)
txt:setText(timeHelper.format_time_stamp11(time,true))
end


function UIRecruitMainWin:onHide()
cameraControl.setCameraActive(true)
end

function UIRecruitMainWin:ShowSelectUI(mode)

self:playAnimation(1)

AudioManager.playAudio(608)
self:setTimer(0.5,1,function()
if mode==1 then
UIManager:showWindow('UIRecruitSelectWin',self.rdata)
else
UIManager:showWindow('UIRecruitSelectWin',{showAnim=self.showWay~=-1 and not self.isSkipAmimation})
end
end)
end

function UIRecruitMainWin:playAnimation(id)
self.root:setAnimatorInteger('state',id,true)
end

function UIRecruitMainWin:getRecruitMaxCount(color)
local cfgs=cfg_yinxiantaizmconfig()
local count
for i,v in ipairs(cfgs)do
if v.color==color then
count=v.maxval
end
end
return count
end

function UIRecruitMainWin:getNeedStr(num)
if num<10 then
return FMT.fmt('<color=#00000000>0</color><color=#8f5127>{0}</color>',num)
else
return FMT.fmt('<color=#8f5127>{0}</color>',num)
end
end

function UIRecruitMainWin:RefreshGuarantTipsStr(isShow)
if not isShow then
self.guarantTips:setActive(false)
return
end

self.guarantTips:setActive(true)




local eachNum=cfg_yinxiantaizmconfig().const_def.eachnum




local color=4
local maxValue=self:getRecruitMaxCount(color)
local currValue=UIRecruitModel:getRecruitCount(color)-1
local need=math.ceil((maxValue-currValue)/eachNum)
local colorStr=FONT_COLOR_VAL[FONT_COLOR.eOrangeColor]
local pzn=UIDiscipleModel.getDiscipleColorDesc(color)
need=self:getNeedStr(need)
local needText=FMT.fmt('再招募 {0} 次，必得 <color={1}>{2}</color> 以上弟子',need,colorStr,pzn)

color=5
maxValue=self:getRecruitMaxCount(color)
currValue=UIRecruitModel:getRecruitCount(color)-1
need=math.ceil((maxValue-currValue)/eachNum)
colorStr=FONT_COLOR_VAL[FONT_COLOR.eRedColor]
pzn=UIDiscipleModel.getDiscipleColorDesc(color)
need=self:getNeedStr(need)
needText=FMT.fmt('{3}\n再招募 {0} 次，必得 <color={1}>{2}</color> 弟子',need,colorStr,pzn,needText)

self.guarantTipsText:setText(needText)
end




function UIRecruitMainWin:onReciurtBtnZM()
if self.waitReq then
return
end
self.showWay=self.way
if self.way==0 or self.way==1 then
UIRecruitControl:reqRecruit(self.way,0)
self.waitReq=true
elseif self.way==-1 then
self:ShowSelectUI()
elseif self.way==-2 then

gainControl:showGainWin(self.retItem)
end
end

function UIRecruitMainWin:onReciurtBtnJZ()
if self.jzstate>0 then
UIManager:showWindow('UIRecruitJZWin')
else
UIManager.error('暂无家族')
end
end

function UIRecruitMainWin:onPaizi()
UIManager:showWindow('UIRecruitElderWin')
end

function UIRecruitMainWin:onClosebg()
UIRecruitControl:closeUI(true,true)
end

function UIRecruitMainWin:onSetupBtn()


local args={}
args.pos=3
args.showBG=true
guildOrderModel:openSetupWin(GUILD_ORDER_TYPE.eQuicklyZhaoMu,args)
end

function UIRecruitMainWin:onSkipSelectBtn()
self.isSkipAmimation=not self.isSkipAmimation
self.skipSelectImg:setActive(self.isSkipAmimation)
UIRecruitControl:setSkipAnimationState(self.isSkipAmimation)
end

function UIRecruitMainWin:refreshSkipAnimationRoot()
local skip_animation_lv=cfgHelper.get2(cfg_yinxiantaiconfig_get,1,"skip_animation_lv")
local skip_animation_count=cfgHelper.get2(cfg_yinxiantaiconfig_get,1,"skip_animation_count")
local curlv=playerModel:getActorLevel()
local isCanSkipAnimation=curlv>=skip_animation_lv
local recruitCount=gameUtilityModel:getData_counter(gameCounterType.eYinXianTaiZhaoMuNum)
isCanSkipAnimation=isCanSkipAnimation or recruitCount>=skip_animation_count
local tipsinfo=FMT.fmt("再招{0}次开启跳过动画",skip_animation_count-recruitCount)
self.skipAnimationtip1:setActive(isCanSkipAnimation)
self.skipAnimationtip2:setActive(not isCanSkipAnimation)
self.skipAnimationtip2:setText(tipsinfo)
self.skipSelectImg:setActive(self.isSkipAmimation)
end


function UIRecruitMainWin:refreshXYXFEnter()
local actList=activitiesModel:getActSubList_subType_doing(SUB_ACTIVITY_TYPE.eXianShiChouKa)
local hasNotOpen=false
local sub_act
local isShow=true
if#(actList or{})>0 then
for k,subactinfo in pairs(actList)do
local actinfo=activitiesModel:getActInfo(subactinfo:getActID())
if actinfo:checkDoing()and actinfo:checkCondition()and activitiesModel:checkActInMerge(actinfo.act_id)==nil then
sub_act=subactinfo
else
hasNotOpen=true
end
end
if hasNotOpen then
isShow=sub_act~=nil
else
sub_act=actList[1]
end
else
isShow=false
end

self.XYXFEnter:setActive(isShow)
if isShow then

local func=function()
local actLeftTime=sub_act:getEndLeftTime()
self.xyxfcountdown:setText(FMT.fmt("还剩{0}喵",timeHelper.format_time_stamp12(actLeftTime)))
if actLeftTime<=0 then
if self.xyxftimer then
self:stopTimerByID(self.xyxftimer)
self.xyxftimer=nil
end
self.XYXFEnter:setActive(false)

end
end
self.xyxftimer=self:setTimer(1,0,func)
func()
self:delayDo(0.5,function()
self.xyxfenterModel:setChildUIModelShowTarget(4733,1,{},eAnimationID.enter,false,false,0,function()
self:delayDo(1,function()
self.xyxfbg:setChildCanvasGroupDOFade(1,1,nil)
end)
end)
end)



self.winlua:SetChildButtonClick(self.XYXFEnter:getID(),function()
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=sub_act:getSubType(),subid=sub_act:getSubID()}},
function()end,
JUMP_BACK.eNomal)
end)
end
end

function UIRecruitMainWin:onShopBtn()
local closeCB=function()
if _this then
self:showTopMoney()
end
end
funcShopController:openShopWin({shopId=10,closeCB=closeCB})
end

function UIRecruitMainWin:on_item_list_changed(array)
local def=cfgHelper.getdef(cfg_yinxiantaizmconfig)
for k,itemdata in ipairs(array or{})do
local changeType=itemdata[1]
local itemid=itemdata[3]
if itemid==def.itemid and changeType==CHANGE_TYPE.eAdd then
self:Refresh()
end
end
end



























function UIRecruitMainWin:freshTZReddot()
local isReddot=TeZhiTuJianController:checkSysRedddot2()
self.tezhiTJBtnReddot:setActive(isReddot)
end

function UIRecruitMainWin:onTezhiTJBtn()
UIManager:showWindow("UITeZhiTuJianMainWin")
end

function UIRecruitMainWin:initZhaoMuLingBtnRoot()
local wb=self.zhaoMuLingRoot:getWidgetBase()
wb:SetChildButtonClick(0,function()
self:onZhaoMuLingBtnClicked(_zhaoMuLingItemIds.orange)
end)

wb:SetChildButtonClick(2,function()
self:onZhaoMuLingBtnClicked(_zhaoMuLingItemIds.red)
end)
self:refreshZhaoMuLingItemCountDisplay()
end


function UIRecruitMainWin:refreshZhaoMuLingItemCountDisplay()
local wb=self.zhaoMuLingRoot:getWidgetBase()
local itemCount1=bagModel.getItemCountById(_zhaoMuLingItemIds.orange)
local itemCount2=bagModel.getItemCountById(_zhaoMuLingItemIds.red)

wb:SetChildText(1,itemCount1)
wb:SetChildText(3,itemCount2)
end

function UIRecruitMainWin:onZhaoMuLingBtnClicked(itemId)
local tipsArgs={
formType=TIPS_FORM_TYPE.eQuickUse,
itemid=itemId,
}
tipsManager.showTips(tipsArgs)
end
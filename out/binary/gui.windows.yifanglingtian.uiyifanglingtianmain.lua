







def_class("UIYiFangLingTianMain",UIWindowBase)









function UIYiFangLingTianMain:bindComponents()

self.anpaidizi=UIButton.get(self,0)
self.anpaireddot=UIObject.get(self,1)
self.caizhai=UIButton.get(self,2)
self.caizhaiReddot=UIImage.get(self,3)
self.cangku=UIButton.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.cuishu=UIButton.get(self,6)
self.fanren=UIButton.get(self,7)
self.fanren2=UIButton.get(self,8)
self.GetPlant=UIButton.get(self,9)
self.julingzhen=UIButton.get(self,10)
self.lynum=UIText.get(self,11)
self.prepareRoot=UIObject.get(self,12)
self.ruzhuxiangqing=UIButton.get(self,13)
self.scrollView2=UIObject.get(self,14)
self.shezhi=UIButton.get(self,15)
self.state=UIToggleButton.get(self,16)
self.testBtn=UIButton.get(self,17)
self.testReddot=UIObject.get(self,18)
self.xiangqing=UIButton.get(self,19)
self.xiangqingAnPai=UIButton.get(self,20)
self.XQclickimage=UIObject.get(self,21)
self.zhangtianping=UIButton.get(self,22)

self.anpaidizi:setButtonClick(function()self:onAnpaidizi()end)

self.caizhai:setButtonClick(function()self:onCaizhai()end)

self.cangku:setButtonClick(function()self:onCangku()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cuishu:setButtonClick(function()self:onCuishu()end)

self.fanren:setButtonClick(function()self:onFanren()end)

self.fanren2:setButtonClick(function()self:onFanren2()end)

self.GetPlant:setButtonClick(function()self:onGetPlant()end)

self.julingzhen:setButtonClick(function()self:onJulingzhen()end)

self.ruzhuxiangqing:setButtonClick(function()self:onRuzhuxiangqing()end)

self.shezhi:setButtonClick(function()self:onShezhi()end)

self.testBtn:setButtonClick(function()self:onTestBtn()end)

self.xiangqing:setButtonClick(function()self:onXiangqing()end)

self.xiangqingAnPai:setButtonClick(function()self:onXiangqingAnPai()end)

self.zhangtianping:setButtonClick(function()self:onZhangtianping()end)



end


function UIYiFangLingTianMain:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.anpaidizi);self.anpaidizi=nil;
_UIObject_release(self.anpaireddot);self.anpaireddot=nil;
_UIObject_release(self.caizhai);self.caizhai=nil;
_UIObject_release(self.caizhaiReddot);self.caizhaiReddot=nil;
_UIObject_release(self.cangku);self.cangku=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.cuishu);self.cuishu=nil;
_UIObject_release(self.fanren);self.fanren=nil;
_UIObject_release(self.fanren2);self.fanren2=nil;
_UIObject_release(self.GetPlant);self.GetPlant=nil;
_UIObject_release(self.julingzhen);self.julingzhen=nil;
_UIObject_release(self.lynum);self.lynum=nil;
_UIObject_release(self.prepareRoot);self.prepareRoot=nil;
_UIObject_release(self.ruzhuxiangqing);self.ruzhuxiangqing=nil;
_UIObject_release(self.scrollView2);self.scrollView2=nil;
_UIObject_release(self.shezhi);self.shezhi=nil;
_UIObject_release(self.state);self.state=nil;
_UIObject_release(self.testBtn);self.testBtn=nil;
_UIObject_release(self.testReddot);self.testReddot=nil;
_UIObject_release(self.xiangqing);self.xiangqing=nil;
_UIObject_release(self.xiangqingAnPai);self.xiangqingAnPai=nil;
_UIObject_release(self.XQclickimage);self.XQclickimage=nil;
_UIObject_release(self.zhangtianping);self.zhangtianping=nil;
end



















local _this=nil
local abname='ui/windows/yifanglingtian/yifanglingtian_atlas_pak.ab'
function UIYiFangLingTianMain:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
self.state:setToggleChange(function(name,isOn,data)
if isOn then
self:onState()
end
end)
self.scrollView2:setChildScrollViewInit(0,true,function(clicknum,i)
self:onClickSpeciality(i)
end,nil)
end


function UIYiFangLingTianMain:__delete()
YiFangLingTianModel:RecordDiZiShow(_this.ShowDZ)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
if _this.lytime then
_this:stopTimerByID(_this.lytime)
_this.lytime=nil
end
self:unbindComponents()
_this=nil
YiFangLingTianModel:Refreshtime()
end




function UIYiFangLingTianMain:onShow(argtable,afterOnloaded)
socketManager:send_3_80()
local data=argtable.data
local args=argtable.args
if data then
local guid=data.entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)
end
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.lt_constcfg=cfg_yifanglintianconfig().const_def
self.ShowDZ=YiFangLingTianModel:Get_DZinfoShow()
self.XQclickimage:setActive(self.ShowDZ)
self.xiangqing:setActive(self.ShowDZ)
self:SetLYNum()
if args and args.cuishuwin then
self:onCuishu()
end
YiFangLingTianModel:GetMaxPlant()
self:SetDiZiInfo()
self.fanren:setActive(false)
local jump=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,'jump1')
local args=jump.args
local subType=args.subType
local subid=args.subid
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(subType,subid)

local jump2=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,'jump2')
local args2=jump2.args
local subType2=args2.subType
local subid2=args2.subid
local sub_actList2=activitiesModel:getActSubList_subType_subid_doing(subType2,subid2)
if#sub_actList2<=0 and#sub_actList<=0 then
self.fanren2:setActive(false)
else
self.fanren2:setActive(true)
self.fanren2:setChildShowEffect(10521,true)
end


self:refreshwin()
self:refreshTestWin()
end


function UIYiFangLingTianMain:onHide()

end

function UIYiFangLingTianMain:refreshwin()

self:refreshDailyReward()
self:SetLYNum()
end


local cmp=
{
ruzhuRoot=0,
weiruzhuRoot=1,
name=2,
pro_skill=3,
lv=4,
skilleffect=5,
scrollview2=6,
bg=7,
head=8,
}



function UIYiFangLingTianMain:SetDiZiInfo()

local widget=self.xiangqing:getWidgetBase()
if tostring(self.bdData.dizi_id)~='0'then
widget:SetChildActive(cmp.ruzhuRoot,true)
widget:SetChildActive(cmp.weiruzhuRoot,false)

local name=UIDiscipleModel:getDiscipleName(self.bdData.dizi_id)
widget:SetChildText(cmp.name,string.format("弟子：<color=#171311>%s</color>",name))
local bd_tybe_cfg=cfg_monijybuildconfig_get(self.config.id)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(self.bdData.dizi_id,skill_id)
local effect=nil
if skill_cfg.buildplant_effects then
effect=skill_cfg.buildplant_effects[level]
end
widget:SetChildText(cmp.pro_skill,skill_cfg.name..":")
widget:SetChildText(cmp.lv,string.format('<color=#171311>%s级</color>',level))

local reduce_times=YiFangLingTianModel:GetDiziReduceTime(self.bdData.dizi_id)
local str=string.format('生长效率：<color=#549327>+%s%%</color>',reduce_times)
widget:SetChildText(cmp.skilleffect,str)

end
self.dizi_speciality=self:getPlantEffects(self.bdData.dizi_id)
if self.dizi_speciality then
widget:SetChildActive(cmp.scrollview2,true)

widget:SetChildScrollViewCreateGrids(cmp.scrollview2,#self.dizi_speciality,0)
local grids=widget:GetChildScrollViewItemWidgets(cmp.scrollview2)
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.dizi_speciality[i]
UIDiscipleModel.refreshSpecialityItemEx(item,data)
end
else
widget:SetChildActive(cmp.scrollview2,false)
end
comHelper.setChildModelHeadIconBG(widget,cmp.bg,self.bdData.dizi_id)

comHelper.setChildModelRawImage(widget,self.bdData.dizi_id,cmp.head,0,eHeadCenterType.eHead)
else

widget:SetChildActive(cmp.ruzhuRoot,false)
widget:SetChildActive(cmp.weiruzhuRoot,true)
end
self.anpaireddot:setActive(tostring(self.bdData.dizi_id)=='0')
end



function UIYiFangLingTianMain:GetDiziReduceTime(dzid)
local lt_constcfg=cfg_yifanglintianconfig().const_def
local buildid=lt_constcfg.buildId
local bd_tybe_cfg=cfg_monijybuildconfig_get(buildid)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzid,skill_id)

local dizi_pzlvl_reduce_times=lt_constcfg.dizi_pzlvl_reduce_times

for k,v in ipairs(dizi_pzlvl_reduce_times)do
if level>=v[1]and level<=v[2]then
return v[3]
end
end
end
return 0
end


function UIYiFangLingTianMain:SetLYNum()
local num,maxnum=YiFangLingTianModel:GetLingYeNum()

self.lynum:setText(string.format("%d/%d",num,maxnum))
self.zhangtianping:setChildUIProgressbar(num,maxnum,false)
local func=function()

local num,maxnum=YiFangLingTianModel:GetLingYeNum()
if num<0 then
num=0
end

self.lynum:setText(string.format("%d/%d",num,maxnum))
self.zhangtianping:setChildUIProgressbar(num,maxnum,false)
end
if maxnum>0 then
if not self.lytime then
self.lytime=self:setTimer(0.5,0,func)
end
end
local begintimes=YiFangLingTianModel:Getbegintimes()
self.zhangtianping:setChildImageExGray(begintimes<=0)
end


function UIYiFangLingTianMain.on_building_event(etype,sfId,bdId,arg1,arg2)
if _this.bdData.un_build_id~=bdId then
return
end
if etype==buildingEvent.buildDataChange then

elseif etype==buildingEvent.replaceDisciple then
_this:SetDiZiInfo()
YiFangLingTianModel:RecordNowDzID()
elseif etype==buildingEvent.planStart then

elseif etype==buildingEvent.planComplete
or etype==buildingEvent.planCancel
or etype==buildingEvent.planCollect
or etype==buildingEvent.planChange then

elseif etype==buildingEvent.levelUpComplete then

elseif etype==buildingEvent.speedUpComplete then

end
end
function UIYiFangLingTianMain:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.scrollView2:getChildScrollViewItemWidget(i)

UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.bdData.dizi_id,config=data})
end

function UIYiFangLingTianMain:getPlantEffects(dzId)
local configs=discipleSelectController.getSpeciallistByBuild(dzId,self.config.id)
return configs
end




function UIYiFangLingTianMain:onCloseBtn()
fullScreenUI.closeActiveUI(true)
UIManager:closeActiveWindow("UIYFLTSelectPlantMain")
self:closeSelf()
end
function UIYiFangLingTianMain:onCloseBySelect()
self:closeSelf()
end


function UIYiFangLingTianMain:onRuzhuxiangqing()
self.ShowDZ=not self.ShowDZ
self.XQclickimage:setActive(self.ShowDZ)
self.xiangqing:setActive(self.ShowDZ)
if self.ShowDZ then
self:SetDiZiInfo()
end

end



function UIYiFangLingTianMain:onJulingzhen()
end



function UIYiFangLingTianMain:onAnpaidizi()

end


function UIYiFangLingTianMain:onXiangqing()
local args={
openType=dzSelectWinOpenType.eYifanglingtian,


callback=function(guid)

end,

}
zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eYifanglingtian)


end



function UIYiFangLingTianMain:onShezhi()
UIManager:showWindow('UIYFLTSettingWin')
end



function UIYiFangLingTianMain:onCangku()
UIManager:showWindow('UIYFLTBagWin')
end



function UIYiFangLingTianMain:onCuishu()
UIManager:showWindow('UIYFLTcuishuWin')
end



function UIYiFangLingTianMain:onZhangtianping()






UIManager:showWindow('UIYFLTgubaoWin')

end




function UIYiFangLingTianMain:onFanren()
local jump=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,'jump1')
jumpManager:jump(jump)
end
function UIYiFangLingTianMain:onFanren2()
local jump=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,'jump1')
local jump2=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,'jump2')
local args2=jump2.args
local subType2=args2.subType
local subid2=args2.subid
local sub_actList2=activitiesModel:getActSubList_subType_subid_doing(subType2,subid2)
if#sub_actList2<=0 then
jumpManager:jump(jump)
else
jumpManager:jump(jump2)
end

end


function UIYiFangLingTianMain:onIntroduce()

end

function UIYiFangLingTianMain:onState()
UIManager:showWindow('UIBuffStateWin',self.bdData)
end


function UIYiFangLingTianMain:onXiangqingAnPai()
self:onXiangqing()
end


function UIYiFangLingTianMain:onCaizhai()
UIManager:showWindow('UIYFLTGetPlantWin')
end



function UIYiFangLingTianMain:onGetPlant()

YiFangLingTianModel:openPlantGainWin()
end


function UIYiFangLingTianMain:refreshDailyReward()

local ishave=YiFangLingTianModel:GetMaxPlant()

if not ishave then
self.caizhaiReddot:setActive(false)
self:doPunchRotation(false)
else
self.caizhaiReddot:setActive(true)
self:doPunchRotation(true)
end
end


function UIYiFangLingTianMain:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self.caizhaiReddot:setRotation(0,0,0)
local tweener=self.caizhaiReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.caizhaiReddot:setRotation(0,0,0)
end
end
end




















function UIYiFangLingTianMain:onTestBtn()
local systemIndexType=UISettingModel:getSystemIndexType()
UIManager:showWindow("UITestTagBtnWin",{systemId=systemIndexType.YiFangLingTian,})
end

function UIYiFangLingTianMain:refreshTestWin()
local checkReddot
local systemIndexType=UISettingModel:getSystemIndexType()
local checkBtn=UISettingModel:checkIsOpenTest(systemIndexType.YiFangLingTian)

if not checkBtn then
UIManager:invokeUIMethod("UITestTagBtnWin",'closeWin')
else
checkReddot=UISettingModel:checkTestTagReddot(systemIndexType.YiFangLingTian)
self.winlua:SetChildActive(self.testReddot:getID(),checkReddot)
end

self.winlua:SetChildActive(self.testBtn:getID(),checkBtn)
end
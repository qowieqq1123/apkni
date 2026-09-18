







def_class("UIQingDianQianDaoWin",UIWindowBase)









function UIQingDianQianDaoWin:bindComponents()

self.bgmodel=UIObject.get(self,0)
self.desImage=UIText.get(self,1)
self.effect=UIObject.get(self,2)
self.effect2=UIObject.get(self,3)
self.endTime=UIText.get(self,4)
self.image=UIImage.get(self,5)
self.info=UIImage.get(self,6)
self.infoTitle=UIImage.get(self,7)
self.model=UIObject.get(self,8)
self.modelName=UIText.get(self,9)
self.root=UIObject.get(self,10)
self.scrollView=UIObject.get(self,11)
self.showBtn=UIButton.get(self,12)
self.title=UIImage.get(self,13)

self.showBtn:setButtonClick(function()self:onShowBtn()end)



end


function UIQingDianQianDaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.desImage);self.desImage=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.endTime);self.endTime=nil;
_UIObject_release(self.image);self.image=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.infoTitle);self.infoTitle=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.modelName);self.modelName=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.showBtn);self.showBtn=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _boundImgIndex={
eNormal=1,
eSelect=2,
eBigNormal=3,
}




function UIQingDianQianDaoWin:onLoaded(...)
self:bindComponents()

self.abName='ui/windows/qingdianqiandao/qingdianqiandao_atlas_pak.ab'

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.modelPos=self.model:getChildAnchoredPosition3D()
end


function UIQingDianQianDaoWin:__delete()
self:unbindComponents()

uiAIManager:clearUIWinData('UIQingDianQianDaoWin')
end




function UIQingDianQianDaoWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.actId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

local info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
if not self.nTimer then
local etime=info.end_time
local tick=function()
local dt=etime-gameUtilityModel.getServerShortTime()
self.endTime:setText(FMT.fmt('{0}后结束',timeHelper.format_time_stamp11(dt,true)))
if dt<=0 then
self.endTime:setText('活动已结束')
self:stopTimerByID(self.nTimer)
self.nTimer=nil
end
end
self.nTimer=self:setTimer(1,0,tick)
tick()
end
self.bgmodel:setChildUIModelShowTarget(self.config.bgSpineID,1,{},eAnimationID.stand)
self.title:setCSImageSprite(self.config.qd_abPath,self.config.artWordName)
self:refresh()
end

function UIQingDianQianDaoWin:refresh()
self:setTargetList()
self:showModel()
self:showAIModel()
end


function UIQingDianQianDaoWin:onHide()

end

function UIQingDianQianDaoWin:showModel()
local day=self:getToday()
local mdatas=cfgHelper.get2(cfg_qingdianqiandaoconfig_get,self.subId,'show_item')
local data
local pass=false
local num=#self.datas
for i=1,num do
if i>day then
pass=true
end
if mdatas[i]then
data=mdatas[i]
if pass then
break
end
end
end

if not data then
return
end
local itemId=data[1]
if itemId>0 then
local cfg=itemsConfig.getConfig(itemId)
self.showItemCfg=cfg
end
local showData=data[2]
local stype=showData[1]
local modelId=showData[2]
local animId=showData[3]or eAnimationID.stand
local showModel=stype==1
local showEffect=stype==2
local showImage=stype==3
local showSPModel=stype==4
local showImageOnly=stype==5
self.model:setActive(showModel)
self.effect:setActive(showEffect or showImage or showSPModel)
self.image:setActive(showImage or showImageOnly)
self.effect2:setActive(showSPModel)
if showModel then
local scale=data[3]
self.model:setChildUIModelShowTarget(modelId,scale,nil,animId)
local offset=data[4]
local ap=Vector3.New(self.modelPos.x+offset[1],self.modelPos.y+offset[2],0)
self.model:setChildAnchoredPosition3D(ap)
elseif showEffect then
self.effect:setChildShowEffect(modelId,true)
local scale=data[3]
self.effect:setScale(Vector3.New(scale,scale,scale))
local offset=data[4]
local ap=Vector3.New(self.modelPos.x+offset[1],self.modelPos.y+offset[2],0)
self.effect:setChildAnchoredPosition3D(ap)
elseif showImage then
local effectId=modelId[1]
local imageName=modelId[2]
self.effect:setChildShowEffect(effectId,true)
local scale=data[3]
local sd=Vector3.New(scale,scale,scale)
self.effect:setScale(sd)
self.image:setScale(sd)
local offset=data[4]
local ap=Vector3.New(self.modelPos.x+offset[1],self.modelPos.y+offset[2],0)
self.effect:setChildAnchoredPosition3D(ap)
self.image:setChildAnchoredPosition3D(ap)
self.image:setChildIcon(imageName,true)
elseif showSPModel then
local effectId=modelId[1]
local effectId2=modelId[2]
self.effect:setChildShowEffect(effectId,true)
self.effect2:setChildShowEffect(effectId2,true)
local scale=data[3]
local sd=Vector3.New(scale,scale,scale)
self.effect:setScale(sd)
self.effect2:setScale(sd)
local offset=data[4]
local ap=Vector3.New(self.modelPos.x+offset[1],self.modelPos.y+offset[2],0)
self.effect:setChildAnchoredPosition3D(ap)
self.effect2:setChildAnchoredPosition3D(ap)
elseif showImageOnly then
local scale=data[3]
local sd=Vector3.New(scale,scale,scale)
self.image:setScale(sd)
local offset=data[4]
local ap=Vector3.New(self.modelPos.x+offset[1],self.modelPos.y+offset[2],0)
self.image:setChildAnchoredPosition3D(ap)
self.image:setSprite(self.abName,modelId)
end

local name=data[6]
local showBtn=name and name~=''
self.showBtn:setActive(showBtn)
if showBtn then
self.modelName:setText(name)
end

local desArgs=data[5]
local dtype=desArgs[1]
if dtype==1 then
self.infoTitle:setActive(true)
self.desImage:setActive(false)
self.infoTitle:setSprite(self.abName,desArgs[2])
elseif dtype==2 then
self.infoTitle:setActive(false)
self.desImage:setActive(true)
self.desImage:setText(desArgs[2])
end
self.info:setCSImageSprite(self.config.qd_abPath,self.config.boundImgList[_boundImgIndex.eBigNormal])
end

function UIQingDianQianDaoWin:showAIModel()
if self.initAI then
return
end
self.initAI=true









local models=cfgHelper.get2(cfg_qingdianqiandaoconfig_get,self.subId,'model')

self:createUIObject(models[2],{178,-340},2,false)

self:createUIObject(models[1],{-170,-340},1,true)
end

function UIQingDianQianDaoWin:createDZ(dzId,pos,roleId,bFlip)
local speakdata=cfgHelper.get2(cfg_qingdianqiandaoconfig_get,self.subId,'speak')
local showSPK=speakdata[roleId]~=nil

local tran=self.root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
local initData={
speakTime=5,
speakHUDParent=1,
offset={0,0},
uispeakrate=0.5,
roleId=roleId,
stateId=showSPK and 0 or 1,
}
local otherData={
scale=0.9
}
uiAIManager:createUIDisciple('UIQingDianQianDaoWin','bt_ui_qdqiandao',dzId,tran,vpos,initData,otherData,function(bt)
local dzWidget=bt:getSharedVar('stWidget')
local stIndex=bt:getSharedVar('stIndex')
dzWidget:SetChildUIModelShowFlipX(stIndex,bFlip)

end)
end

function UIQingDianQianDaoWin:createUIObject(model,pos,roleId,bFlip)
if not model then
return
end
local modelId=model[1]
local scale=model[2]
local speakdata=cfgHelper.get2(cfg_qingdianqiandaoconfig_get,self.subId,'speak')
local showSPK=speakdata[roleId]~=nil

local tran=self.root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
local initData={
speakTime=5,
speakHUDParent=1,
offset={0,0},
uispeakrate=0.5,
roleId=roleId,
stateId=showSPK and 0 or 1,
}
local otherData={
scale=scale
}
uiAIManager:createUIObject('UIQingDianQianDaoWin','bt_ui_qdqiandao',INSTANCE_TYPE.eUIDisciple,modelId,tran,vpos,initData,otherData,function(bt)
local dzWidget=bt:getSharedVar('stWidget')
local stIndex=bt:getSharedVar('stIndex')
dzWidget:SetChildUIModelShowFlipX(stIndex,bFlip)

end)
end

function UIQingDianQianDaoWin:getRewardData()
local level=zongmenModel:getLevel()
local datas=cfgHelper.get2(cfg_qingdianqiandaoconfig_get,self.subId,'dayRewards')
local list={}
for k,v in pairs(datas)do





for ii,vv in ipairs(v)do
if level>=vv[1]and level<=vv[2]then
table.insert(list,{day=k,rewards=vv[3]})
end
end
end
table.sort(list,function(a,b)
return a.day<b.day
end)
return list
end

function UIQingDianQianDaoWin:getToday()
local info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
local day=info:getStart2NowDay()
return day
end

function UIQingDianQianDaoWin:setTargetList()
local day=self:getToday()

local bqFunc=function(_day)
local cost=cfgHelper.get2(cfg_qingdianqiandaoconfig_get,self.subId,'bqItem')
local itemId=cost[1]
local itemCount=cost[2]

local iconname=iconHelper.getIconName(itemId)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local content=FMT.fmt('是否花费{0}<color=#ca631d>{1}</color>进行补签？',iconStr,itemCount)

local dialog=UIDialogManager.getConfirmDialog(nil,'提示',content,nil,nil,function()
if moneyConfig.isMoney(itemId)then
local cb=function()
self:callActivityFunc('reqBuQian',_day)
end
moneySystem:useMoney(itemId,itemCount,cb,WARNING_TYPE.eWarning)
else
local have=bagModel.getItemCountById(itemId)
if have>=itemCount then
self:callActivityFunc('reqBuQian',_day)
else
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(itemId)))
end
end
end)
dialog.type='UIDialougeWithIcon'
dialog:show()
end

local lqFunc=function()
self:callActivityFunc('reqLingQu')
end

local mdatas=cfgHelper.get2(cfg_qingdianqiandaoconfig_get,self.subId,'show_item')

local actDatas=activitiesModel:getSubActInfoData(self.actId,self.subType,self.subId)
self.datas=self:getRewardData()
local len=#self.datas
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.datas[i]
local actdata=actDatas[data.day]

if actdata.qdFlag~=1 and data.day==day then
actdata.qdFlag=1
end
local check1=actdata.qdFlag==1
local check2=actdata.rwFlag==1
local check3=day>data.day and not check1
local check4=check1 and not check2
item:SetChildText(0,FMT.fmt('第{0}天',data.day))
item:SetChildActive(1,check2)
item:SetChildActive(2,check3)
if check3 then
item:SetChildButtonClickWithID(2,bqFunc,data.day)
end
item:SetChildActive(3,check4)
if check4 then
item:SetChildButtonClick(3,lqFunc)
end
if data.day==day+1 then
local cur=gameUtilityModel.getServerShortTime()
local et=(math.floor(cur/86400)+1)*86400
self:startTimer(item,et)
elseif data.day>day then
item:SetChildText(4,FMT.fmt('{0}天后',data.day-day))
else
item:SetChildText(4,'')
end

for ii=1,2 do
local reward=data.rewards[ii]
local index=ii+4
local bShow=reward~=nil
item:SetChildActive(index,bShow)
if bShow then
widgetHelper.setNormalRewardItem(item,index,reward)
end
end

if i%2==0 then
item:SetChildLocalPosY(7,15)
else
item:SetChildLocalPosY(7,0)
end

item:SetChildActive(8,mdatas[data.day]~=nil)

item:SetChildActive(9,check4)
item:SetChildActive(10,check4)

item:SetChildActive(11,check2)
item:SetChildActive(12,check2)

if check4 then
local effectId="xianshu_light"
item:SetChildAnimationStringID(9,effectId,false)
item:SetChildAnimationStringID(10,effectId,false)
end

item:SetChildCSImageSprite(13,self.config.qd_abPath,self.config.boundImgList[_boundImgIndex.eNormal])
item:SetChildCSImageSprite(14,self.config.qd_abPath,self.config.boundImgList[_boundImgIndex.eSelect])
end

self.scrollView:setChildScrollViewSelectItem(day-1,false,false,false)
end

function UIQingDianQianDaoWin:startTimer(item,etime)
self:clearTimer()
local tick=function()
local dt=etime-gameUtilityModel.getServerShortTime()
item:SetChildText(4,timeHelper.format_time_stamp(dt))
if dt<0 then
self:clearTimer()
self:refresh()
end
end
self.timer=self:setTimer(1,0,tick)
tick()
end

function UIQingDianQianDaoWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIQingDianQianDaoWin:callActivityFunc(fname,...)
return call_activitiesHandle_func('activitiesHandle_qingdianqiandao',fname,self.actId,self.subId,...)
end

function UIQingDianQianDaoWin:callActivityInfoFunc(fname,...)
local info=activitiesModel:getSubActInfo(self.actId,SUB_ACTIVITY_TYPE.eQingDianQianDao,self.subId)
return info[fname](info,...)
end

function UIQingDianQianDaoWin:getSpeakText(bt,tkey,roleId)
local speakdata=cfgHelper.get2(cfg_qingdianqiandaoconfig_get,self.subId,'speak')
local speaks=speakdata[roleId]
local str=speaks[math.random(1,#speaks)]
bt:setSharedVar(tkey,str)
end




function UIQingDianQianDaoWin:onShowBtn()
itemsComponentHelper.onItemClickEx(self.showItemCfg.id,nil,nil)
end

function UIQingDianQianDaoWin:onCloseClick()
self:closeSelf()
end

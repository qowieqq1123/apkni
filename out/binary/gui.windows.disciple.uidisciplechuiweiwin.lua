







def_class("UIDiscipleChuiweiWin",UIWindowBase)









function UIDiscipleChuiweiWin:bindComponents()

self.effect=UIObject.get(self,0)
self.success=UIObject.get(self,1)
self.txtSpeak=UIText.get(self,2)
self.chuiweiImg=UIObject.get(self,3)
self.progressText=UIText.get(self,4)
self.discipleNameText=UIText.get(self,5)
self.goodlist=UIObject.get(self,6)
self.tipsText=UIText.get(self,7)
self.discipleModelRoot=UIObject.get(self,8)
self.discipleJobIcon=UIImage.get(self,9)
self.speakObj=UIObject.get(self,10)
self.chuiweiProgress=UIProgressBarAni.get(self,11)
self.chuiweiText=UIText.get(self,12)
self.spBg=UIObject.get(self,13)
self.discipleJobIcon2=UIImage.get(self,14)



end


function UIDiscipleChuiweiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.success);self.success=nil;
_UIObject_release(self.txtSpeak);self.txtSpeak=nil;
_UIObject_release(self.chuiweiImg);self.chuiweiImg=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.discipleNameText);self.discipleNameText=nil;
_UIObject_release(self.goodlist);self.goodlist=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.chuiweiProgress);self.chuiweiProgress=nil;
_UIObject_release(self.chuiweiText);self.chuiweiText=nil;
_UIObject_release(self.spBg);self.spBg=nil;
_UIObject_release(self.discipleJobIcon2);self.discipleJobIcon2=nil;
end

















local _this
local jumpbuildid=6


function UIDiscipleChuiweiWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.onDiscipleInjuryChange,self.onDiscipleInjuryChange)
notifySystem:listenNotify(notifyConfig.onDiscipleShouYuanChange,self.onDiscipleShouYuanChange)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
end


function UIDiscipleChuiweiWin:__delete()
_this=nil
self:killSpeakTween()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.onDiscipleInjuryChange,self.onDiscipleInjuryChange)
notifySystem:removelistener(notifyConfig.onDiscipleShouYuanChange,self.onDiscipleShouYuanChange)
notifySystem:removelistener(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
end

function UIDiscipleChuiweiWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
_this:refreshGoodItems()
end

function UIDiscipleChuiweiWin.onDiscipleInjuryChange(discipleguid,oldInjury,injury)
if _this.disciple_guid==discipleguid then
local dzName=UIDiscipleModel:getDiscipleColorName(discipleguid)
UIManager.info(FMT.fmt('{0}减少{1}点负伤值',dzName,oldInjury-injury))
_this:refreshLeftInfo()
_this.effect:setChildShowEffect(10089,true)
end
end

function UIDiscipleChuiweiWin.onDiscipleShouYuanChange(discipleguid,old,shouyuan)
if _this.disciple_guid==discipleguid then
local dzName=UIDiscipleModel:getDiscipleColorName(discipleguid)
UIManager.info(FMT.fmt('{0}增加{1}年寿元',dzName,shouyuan-old))
_this:refreshLeftInfo()
_this.effect:setChildShowEffect(10089,true)
end
end

function UIDiscipleChuiweiWin.onDiscipleStateChange(discipleguid,stateType,old,cur)
if _this.disciple_guid==discipleguid and stateType==DISCIPLE_STATE_TYPE.eChuiWei then
_this.success:setChildShowEffect(10090,true)
end
end




function UIDiscipleChuiweiWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
local openFuncType=argtable.funcType

local isChuiwei=UIDiscipleModel:checkDiscipleState2(self.disciple_guid,DISCIPLE_STATE_TYPE.eChuiWei)
if isChuiwei then
local chuiweiType=UIDiscipleModel:checkChuiWeiDiscipleType(self.disciple_guid)
if openFuncType==nil then
if chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury then
openFuncType=item_funtion_type.liaoshang
elseif chuiweiType==DISCIPLE_CHUIWEI_TYPE.eShouYuan then
openFuncType=item_funtion_type.shouyuan
end
end
self.chuiweiType=chuiweiType
self.chuiweiCfg=cfgHelper.get1(cfg_discipledyingconfig_get,1)
local injury=UIDiscipleModel:getDiscipleInjury(self.disciple_guid)
self.oldInjury=injury
end
self.openFuncType=openFuncType
if self.openFuncType then
self:refreshGoodItems()
self:refreshView()
end
end


function UIDiscipleChuiweiWin:onHide()

end

function UIDiscipleChuiweiWin:refreshView()
self:refreshDiscipleInfo()
self:refreshLeftInfo()
end

function UIDiscipleChuiweiWin:refreshDiscipleInfo()

self.discipleNameText:setText(UIDiscipleModel:getDiscipleName(self.disciple_guid))

local jobicon=UIDiscipleModel:getJobIconNameX(self.disciple_guid)
local isSPdz=UIDiscipleModel:isSPDiscipleEx(self.disciple_guid)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
self.discipleJobIcon2:setActive(isSPdz)
self.spBg:setActive(isSPdz)
if isSPdz then
local switchidx=1
local switchJobIcon=UIDiscipleModel:getJobIconNameX(self.disciple_guid,switchidx)
self.discipleJobIcon2:setSprite(globalABLookup.global,switchJobIcon)
self.discipleJobIcon:setChildAnchoredPos(-10,10)
local scale=54/68
self.discipleJobIcon:setScale(Vector3(scale,scale,scale))
else
self.discipleJobIcon:setChildAnchoredPos(0,0)
self.discipleJobIcon:setScale(Vector3.one)
end

self.discipleModelRoot:setChildUIModelRemoveTarget()
comHelper.setChildInSideModel(self.discipleModelRoot,self.disciple_guid,0.85,nil,0,0,false,true)
end

function UIDiscipleChuiweiWin:refreshLeftInfo()
self.chuiweiText:setActive(true)
local isChuiWei=false
if self.openFuncType==item_funtion_type.liaoshang then
local injury=UIDiscipleModel:getDiscipleInjury(self.disciple_guid)
if self.chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury then
local injurySec=self.chuiweiCfg.injury
isChuiWei=injury>injurySec[2]
self.chuiweiImg:setActive(isChuiWei)
self.chuiweiProgress:setActive(isChuiWei)
self.chuiweiText:setActive(not isChuiWei)
self.chuiweiText:setText('该弟子已恢复健康')
if isChuiWei then
local progressVal=self.oldInjury-injury
local maxVal=self.oldInjury-injurySec[2]
self.chuiweiProgress:animateThreeParams(progressVal,maxVal,0.5)
local progressStr=FMT.fmt('负伤：{0}',injury)
self.progressText:setText(progressStr)
end
self:flushSpeakStr(isChuiWei)
else
self.chuiweiText:setText(FMT.fmt('负伤：{0}',injury))
end
elseif self.openFuncType==item_funtion_type.shouyuan then
local shouyuan=UIDiscipleModel:getDiscipleShouYuan(self.disciple_guid)
if self.chuiweiType==DISCIPLE_CHUIWEI_TYPE.eShouYuan then
local shouyuanSec=self.chuiweiCfg.shouyuan
isChuiWei=shouyuan<shouyuanSec[2]
self.chuiweiImg:setActive(isChuiWei)
self.chuiweiProgress:setActive(isChuiWei)
self.chuiweiText:setActive(not isChuiWei)
self.chuiweiText:setText(FMT.fmt('该弟子已恢复健康（寿元：{0}）',shouyuan))
if isChuiWei then
self.chuiweiProgress:animateThreeParams(shouyuan,shouyuanSec[2],0.5)
local progressStr=FMT.fmt('寿元：{0}/{1}',shouyuan,shouyuanSec[2])
self.progressText:setText(progressStr)
end
self:flushSpeakStr(isChuiWei)
else
self.chuiweiText:setText(FMT.fmt('寿元：{0}',shouyuan))
end
end
end

function UIDiscipleChuiweiWin:flushSpeak()
self.speakObj:setActive(true)
self.speakObj:setChildCanvasGroupAlpha(0)
self:refreshSpeakObj()
end

function UIDiscipleChuiweiWin:flushSpeakStr(isChuiWei)
local voc=UIDiscipleModel:getDiscipleJob(self.disciple_guid)
local speakList
if isChuiWei then
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'disciplejiuzhi1')
else
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'disciplejiuzhi2')
end
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
self.txtSpeak:setText(speakStr)
self:flushSpeak()
end

function UIDiscipleChuiweiWin:refreshSpeakObj()
self:killSpeakTween()
self.speakTween=self.speakObj:setChildCanvasGroupDOFade(1,1,function(...)
self:killSpeakTween()
self.speakTween=self.speakObj:setChildCanvasGroupDOFade(0,1,function(...)
end)
self.speakTween:SetDelay(3)
end)
end

function UIDiscipleChuiweiWin:killSpeakTween()
if self.speakTween then
self.speakTween:Kill(false)
self.speakTween=nil
end
end

function UIDiscipleChuiweiWin:refreshGoodItems()
self:getgoodDataList()
local dataNum=#self.goodDataList
self.goodlist:setChildScrollViewCreateGrids(dataNum,1)

local goodGrid=self.goodlist:getChildScrollViewItemWidgets()
for i=1,dataNum do
local item=goodGrid[i-1]
self:refreshGoodListItem(item,i)
end
self:showTips(#self.goodDataList<=0)
end

function UIDiscipleChuiweiWin:refreshGoodListItem(item,index)
if item==nil then
item=self.goodlist:getChildScrollViewItemWidget(index-1)
end
local data=self.goodDataList[index]
local cfg=data[1]
local itemID=cfg.id
local itemNum=bagModel.getItemCountById(itemID)
local conf={itemid=itemID,itemcount=itemNum,showname=false,showCountBG=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)

item:SetChildText(1,itemsConfig.getItemName(itemID))

local funcparam=cfg.funcparam
local desc_str=''
if self.openFuncType==item_funtion_type.liaoshang then
desc_str=FMT.fmt('负伤-{0}',funcparam.heal)
elseif self.openFuncType==item_funtion_type.shouyuan then
desc_str=FMT.fmt('寿元+{0}',funcparam.shouyuan)
end
item:SetChildText(2,desc_str)

local cb=function(idx)
self:onGoodUpBtnClick(idx,itemID)
end
local fncb=function(idx)
self:onGoodUpBtnClick_fn(idx,itemID)
end
item:SetChildLongPress(3,index,cb,fncb)

item:SetChildWeakGuideComponentId(5,FMT.fmt('UIDiscipleChuiweiWin.GoodItemSY_{0}.newBieButton',index))
item:SetChildButtonClick(5,function()
self:onGoodUpBtnClick_weakguide(index,itemID)
end)
end

function UIDiscipleChuiweiWin:getgoodDataList()
self.goodDataList={}
local list=itemsLookup:get_function_items(self.openFuncType)or{}
for k,v in pairs(list)do
local num=bagModel.getItemCountById(v.id)
if num>0 then
local d={v,v.color}
table.insert(self.goodDataList,d)
end
end
if#self.goodDataList>0 then
table.sort(self.goodDataList,function(a,b)
return a[2]>b[2]
end)
end
end

function UIDiscipleChuiweiWin:onGoodUpBtnClick(idx,itemID)
local guid=self.disciple_guid
local injury=UIDiscipleModel:getDiscipleInjury(guid)
if self.openFuncType==item_funtion_type.liaoshang then
if injury<=0 then
UIManager.info('弟子已恢复健康，无需使用')
return false
end
bagProtocolControl.req_dizi_use_item(guid,itemID,1)
elseif self.openFuncType==item_funtion_type.shouyuan then

local shouyuan=UIDiscipleModel:getDiscipleShouYuan(guid)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local floor=UIDiscipleModel:getJJFloor(jjlv)
local overflow=cfgHelper.getdef1(cfg_disciplejingjieconfig,'floor')
local syLimit=overflow[floor]
local max=syLimit[7]
if max==nil then
logErr('最大寿元限制没有配置')
return false
end
if max==-1 then
UIManager.info('该弟子已无限寿元')
return false
end
if shouyuan>=max then
UIManager.info(cfgHelper.getlang('disciple_shouyuan_useitem_tips_1'))
return false
end
bagProtocolControl.req_dizi_use_item(guid,itemID,1)
end
return true
end

function UIDiscipleChuiweiWin:onGoodUpBtnClick_fn(idx,itemID)

end

function UIDiscipleChuiweiWin:onGoodUpBtnClick_weakguide(idx,itemID)
self:onGoodUpBtnClick(idx,itemID)
end

function UIDiscipleChuiweiWin:showTips(isshow)

self.tipsText:setActive(isshow)
if isshow then
local name=cfgHelper.get2(cfg_monijybuildconfig_get,jumpbuildid,'name')
local itemTypeName=''
if self.openFuncType==item_funtion_type.liaoshang then
itemTypeName='疗伤丹'
elseif self.openFuncType==item_funtion_type.shouyuan then
itemTypeName='寿元丹'
end
local str=FMT.fmt('点击前往<color=#2dcd19>【{0}】</color>炼制{1}',name,itemTypeName)
self.tipsText:setText(str)
end
end

function UIDiscipleChuiweiWin:onTipsClick()
if not zongmenModel:haveBuildByBuildId(jumpbuildid)then
return
end
local jumpParam={type=0,id=501,args={}}
jumpManager:jump(jumpParam)
self:closeSelf()
end

function UIDiscipleChuiweiWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=TIPS_MOVE_POS.eLeft})
end
end



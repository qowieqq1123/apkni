







def_class("UIDiscipleDaoYanWin",UIWindowBase)









function UIDiscipleDaoYanWin:bindComponents()

self.attrGrid=UIObject.get(self,0)
self.attrPanel=UIObject.get(self,1)
self.commitBtn=UIButton.get(self,2)
self.commitBtnTxt=UIText.get(self,3)
self.costGoodGrid=UIObject.get(self,4)
self.daoyanEffect=UIObject.get(self,5)
self.diziGrid=UIObject.get(self,6)
self.diziJTBtn=UIButton.get(self,7)
self.diziPanel=UIObject.get(self,8)
self.diziScrollView=UIObject.get(self,9)
self.dyHuoGrid=UIObject.get(self,10)
self.dySpine=UIObject.get(self,11)
self.effDY=UIObject.get(self,12)
self.effDYDi=UIObject.get(self,13)
self.fullTips=UIObject.get(self,14)
self.infoPanel=UIObject.get(self,15)
self.level=UIText.get(self,16)
self.limitItem_1=UIObject.get(self,17)
self.limitItem_2=UIObject.get(self,18)
self.lockImg=UIObject.get(self,19)
self.lockPanel=UIObject.get(self,20)
self.mbg=UIObject.get(self,21)
self.mbg2=UIObject.get(self,22)
self.mbg3=UIObject.get(self,23)
self.relockImg=UIObject.get(self,24)
self.resetBtn=UIButton.get(self,25)
self.resetPanel=UIObject.get(self,26)
self.resetTips=UIText.get(self,27)
self.root=UIObject.get(self,28)
self.upReddot=UIObject.get(self,29)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.diziJTBtn:setButtonClick(function()self:onDiziJTBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)
self.limitItem={
self.limitItem_1,
self.limitItem_2,
}



end


function UIDiscipleDaoYanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.commitBtnTxt);self.commitBtnTxt=nil;
_UIObject_release(self.costGoodGrid);self.costGoodGrid=nil;
_UIObject_release(self.daoyanEffect);self.daoyanEffect=nil;
_UIObject_release(self.diziGrid);self.diziGrid=nil;
_UIObject_release(self.diziJTBtn);self.diziJTBtn=nil;
_UIObject_release(self.diziPanel);self.diziPanel=nil;
_UIObject_release(self.diziScrollView);self.diziScrollView=nil;
_UIObject_release(self.dyHuoGrid);self.dyHuoGrid=nil;
_UIObject_release(self.dySpine);self.dySpine=nil;
_UIObject_release(self.effDY);self.effDY=nil;
_UIObject_release(self.effDYDi);self.effDYDi=nil;
_UIObject_release(self.fullTips);self.fullTips=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.limitItem_1);self.limitItem_1=nil;
_UIObject_release(self.limitItem_2);self.limitItem_2=nil;
_UIObject_release(self.lockImg);self.lockImg=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.mbg2);self.mbg2=nil;
_UIObject_release(self.mbg3);self.mbg3=nil;
_UIObject_release(self.relockImg);self.relockImg=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.resetPanel);self.resetPanel=nil;
_UIObject_release(self.resetTips);self.resetTips=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.upReddot);self.upReddot=nil;
self.limitItem=nil;
end
















local _this
local _abname="ui/windows/disciple/dizidaoyanicons_atlas_pak.ab"
local _bgModelIds={6188,6189,6190}




function UIDiscipleDaoYanWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.onDiscipleDaoYanLvChange,self.onDiscipleDaoYanLvChange)
self:addNotify(notifyConfig.onDiscipleDaoYanLvReset,self.onDiscipleDaoYanLvReset)

self._onItemListChanged=function(...)self:onItemListChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self._onItemListChanged)

local _onDiscipleDaoYanLvReset=function()
UIDiscipleController:showPrize_daoyan()
end
self:addNotify(notifyConfig.onDiscipleDaoYanLvReset,_onDiscipleDaoYanLvReset)

local _onNewMonth5am=function()
self:stopResetDaoYanResetTimer()
self:refreshAll()
end
self:addNotify(notifyConfig.onNewMonth5am,_onNewMonth5am)
end


function UIDiscipleDaoYanWin:__delete()
self:stopResetDaoYanResetTimer()

notifySystem:removelistener(notifyConfig.onDiscipleDaoYanLvChange,self.onDiscipleDaoYanLvChange)
notifySystem:removelistener(notifyConfig.on_item_list_changed,self._onItemListChanged)

_this=nil

self:unbindComponents()
end

function UIDiscipleDaoYanWin:onItemListChanged(list)
if list==nil then return end

for i,v in ipairs(list)do
if self.costLookup[v[3]]then
self:refreshCost()
return
end
end
end

function UIDiscipleDaoYanWin.onDiscipleDaoYanLvChange(dis_guid,olddylv,dylv)
if _this==nil then return end

if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then
return
end
_this.isUpAnim=true
_this:delayDo(1.6,function()
_this.isUpAnim=false
_this:refreshModel()
end)

_this:initInfo(true)

local cur_chong=UIDiscipleModel.getDaoYanLevelFloor(dylv)
_this:refreshFireItem(nil,cur_chong,true)
_this:refreshInfo()
_this:refreshReset()
end

function UIDiscipleDaoYanWin.onDiscipleDaoYanLvReset(dis_guid)
if _this==nil then return end
if not mathHelper.compareInt64(_this.disciple_guid,dis_guid)then return end

_this:initDiZi()
_this:refreshAll()
end




function UIDiscipleDaoYanWin:onShow(argtable,afterOnloaded)
self:showWindow("UITopMaskWin")
self.disciple_guid=argtable.discipleGuid
self.isShowDiZi=true
self.isUpAnim=false

self:initDiZi()
self:refreshAll()

if afterOnloaded then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6186,1,nil,eAnimationID.stand,false,false,0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg2:getID(),false,true,false)
self.mbg2:setChildUIModelShowTarget(6187,1,nil,eAnimationID.stand,false,false,0)
end
end


function UIDiscipleDaoYanWin:onHide()
self:hideWindow("UITopMoneyWin2")
end

function UIDiscipleDaoYanWin:refreshAll()
self:initInfo()
self:refreshAllFire()
self:refreshInfo()
self:refreshModel()
self:refreshReset()
end

function UIDiscipleDaoYanWin:refreshShowDiZi()
self.diziScrollView:setActive(self.isShowDiZi)
self.diziJTBtn:setCSImageSprite(_abname,self.isShowDiZi and"button_tianmingjuexing_02"or"button_tianmingjuexing_01")
end

function UIDiscipleDaoYanWin:initDiZi()
local curNetData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local cur_guid_str=curNetData.discipleguidStr

self.disciplelist=UIDiscipleModel:getDaoYanDZList()
for i,v in ipairs(self.disciplelist)do
local netdata=v.netData.net
if netdata.discipleguidStr==cur_guid_str then
self.curDisIndex=i
break
end
end

local dzLen=#self.disciplelist
self.diziGrid:setChildLayoutGroupCreateItems(dzLen,function(index)
local item=self.diziGrid:getChildLayoutGroupGridItem(index-1)
local netdata=self.disciplelist[index].netData.net
local discipleguid=netdata.discipleguid
local isOpen,tips=UIDiscipleModel:checkOpenDaoYan(netdata)

local func=function()
self:on_select_dis(1,index)
end
item:SetChildButtonClick(4,func,true)

local isSelect=self.curDisIndex==index

comHelper.setChildModelHeadIconBG(item,0,discipleguid)

UIDiscipleModel:setDiscipleXianMoHeadImage(item,2,netdata)

comHelper.setChildModelRawImage(item,discipleguid,1,0,eHeadCenterType.eHead,1,not isOpen)

item:SetChildActive(3,isSelect)

item:SetChildActive(5,not isOpen)

item:SetChildImageExGray(0,not isOpen)
local isReddot=UIDiscipleModel:getDiscipleDaoYanUpLevelReddot(discipleguid)
item:SetChildActive(6,isReddot)
end)

if dzLen<=4 then
self.diziScrollView:setChildSizeDelta(100,dzLen*100+60)
else
self.diziScrollView:setChildSizeDelta(100,460)
end
end

function UIDiscipleDaoYanWin:on_select_dis(id,index)
if self.isUpAnim then
return
end
if self.curDisIndex==index then return end

local old=self.curDisIndex
self.curDisIndex=index
if old then
local olditem=self.diziGrid:getChildLayoutGroupGridItem(old-1)
olditem:SetChildActive(3,false)
end
local item=self.diziGrid:getChildLayoutGroupGridItem(self.curDisIndex-1)
item:SetChildActive(3,true)

local netdata=self.disciplelist[self.curDisIndex].netData.net
local dis_guid=netdata.discipleguid
self.disciple_guid=dis_guid

self:refreshAll()
end

function UIDiscipleDaoYanWin:initInfo(isUp)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local isOpen,tips=UIDiscipleModel:checkOpenDaoYan(netData)
self.isOpen=isOpen
self.isReLock=UIDiscipleModel:checkReLockDaoYan(netData)

if not isUp then

self.dySpine:setChildUIModelRemoveTarget()
local args={isNotBg=true}
comHelper.setChildInSideModel(self.dySpine,self.disciple_guid,1,nil,0,0,false,false,nil,args)
self.dySpine:setChildCanvasGroupAlpha(0)
self.dySpine:setChildCanvasGroupDOFade(1,0.5)
end

self.costLookup={}
if isOpen or self.isReLock then
if UIDiscipleModel:getIsFirstOpenDaoYanWin()then
if not newbieModel.isFinish(NEWBIE_LUA_FUNC_TYPE.DiZiDaoYanFirstOpenFunc)then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.DiZiDaoYanFirstOpenFunc)
end
UIDiscipleModel:saveFirstOpenDaoYanWin()
UIManager:invokeUIMethod('UIDiscipleTianMingWin','refreshDaoYanPanel')
end

self.dylv=UIDiscipleModel:getDaoYanLevelEx(netData)
self.daoyan_unlock=UIDiscipleModel:getDaoYanUnlockEx(netData)

self.costs=UIDiscipleModel:getUpDaoYanCosts(netData)
if self.costs then
local moneysList={}
for i,v in ipairs(self.costs)do
if not self.costLookup[v[1]]then
table.insert(moneysList,{v[1],})
end
self.costLookup[v[1]]=v[1]
end

else

end
else
self.dylv=UIDiscipleModel:getDaoYanMaxLevel(self.disciple_guid)

end

self.attrList={}
local list=UIDiscipleModel:getDaoYanAttrByGuid(self.disciple_guid,self.dylv)
if self.costs and isOpen then
local nextList=UIDiscipleModel:getDaoYanAttrByGuid(self.disciple_guid,self.dylv+1)
for i,v in ipairs(nextList)do
local attrType=nextList[i][1]
local attrValue=list[i]and list[i][2]or 0
local nextAttrValue=nextList[i][2]
if attrValue~=nextAttrValue then
table.insert(self.attrList,{attrType,attrValue,nextAttrValue})
end
end
else
for i,v in ipairs(list)do
local attrType=list[i][1]
local attrValue=list[i][2]
table.insert(self.attrList,{attrType,attrValue})
end
end
end
function UIDiscipleDaoYanWin:refreshModel()
local cur_chong=UIDiscipleModel.getDaoYanLevelFloor(self.dylv)
if cur_chong~=self.oldChong then
self.oldChong=cur_chong
local animationIds={eAnimationID.enter,eAnimationID.enter2,eAnimationID.enter3}
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg3:getID(),false,true,false)
self.mbg3:setChildUIModelShowTarget(_bgModelIds[cur_chong],1,nil,animationIds[cur_chong],false,false,0)

self.winlua:SetChildShowEffect(self.effDY:getID(),0,false)
self.winlua:SetChildShowEffect(self.effDYDi:getID(),0,false)
local effId,effId2=UIDiscipleModel:getDiscipleDaoYanDZJYEffectId(cur_chong)
self.winlua:SetChildShowEffect(self.effDY:getID(),effId,true)
self.winlua:SetChildShowEffect(self.effDYDi:getID(),effId2,true)
end
end

function UIDiscipleDaoYanWin:refreshInfo()
local canUpLevel=self.costs~=nil
self.infoPanel:setActive(canUpLevel and self.isOpen and not self.isReLock)
self.fullTips:setActive(not canUpLevel and self.isOpen)
self.lockPanel:setActive(not self.isOpen or self.isReLock)
self.lockImg:setActive(not self.isOpen)
self.relockImg:setActive(self.isReLock)


local dylv=self.dylv
local lv_str=UIDiscipleModel.getDaoYanLevelDesc(dylv)
local isMAx=not canUpLevel or(not self.isOpen and not self.isReLock)
self.level:setText(isMAx and FMT.fmt("{0}<color=#f36666>(满阶)</color>",lv_str)or lv_str)


self:refreshAttr()
self:refreshCost()
self:refreshLockPanel()
end

function UIDiscipleDaoYanWin:refreshAttr()
local grids=self.attrGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
local isActive=self.attrList[i]~=nil
if isActive then
local attrType=self.attrList[i][1]
local attrValue=self.attrList[i][2]
local nextAttrValue=self.attrList[i][3]
local attrName=cfgHelper.get2(cfg_attributesconfig_get,attrType,'attrname')
local attrValueStr=helper.getAttributeStrEx(attrType,attrValue)
if nextAttrValue then
local nextAttrValueStr=helper.getAttributeStrEx(attrType,nextAttrValue)
item:SetChildText(0,FMT.fmt("{0}：{1}",attrName,attrValueStr))
item:SetChildText(1,nextAttrValueStr)
else
item:SetChildText(3,FMT.fmt("{0}：+{1}",attrName,attrValueStr))
end
item:SetChildActive(0,nextAttrValue~=nil)
item:SetChildActive(1,nextAttrValue~=nil)
item:SetChildActive(2,nextAttrValue~=nil)
item:SetChildActive(3,not nextAttrValue)
end
item:SetChildActive(-1,isActive)
end
end

function UIDiscipleDaoYanWin:refreshCost()
local canUpLevel=self.costs~=nil
if canUpLevel then
local c2=#self.costs
self.costGoodGrid:setChildLayoutGroupCreateItems(c2)
local grid=self.costGoodGrid:getChildLayoutGroupGridList()
for i=1,c2 do
local data=self.costs[i]
local item=grid[i-1]
local itemID=data[1]
local needNum=data[2]
local hasNum=itemsModel.getCount(itemID)
local str
if itemsConfig.isMoney(itemID)then
str=FMT.fmt('{0}/{1}',mathHelper.formatNumber(hasNum),mathHelper.formatNumber(needNum))
else
str=FMT.fmt('{0}/{1}',hasNum,needNum)
end
if hasNum<needNum then
str=toColorString2(FONT_COLOR.eRedColor,str)
end
local conf={itemid=itemID,itemcount='',showname=false,showCountBG=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetChildText(1,str)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onGoodItemClick(itemID)
end)
end


local isReddot=UIDiscipleModel:getDiscipleDaoYanUpLevelReddot(self.disciple_guid)
self.upReddot:setActive(isReddot)
end
end

function UIDiscipleDaoYanWin:refreshLockPanel()
if not self.isOpen then
local dzGuid=self.disciple_guid
local limitList={}
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)

local tm_limit=cfgHelper.getdef(cfg_discipledaoyanconfig,"open_tianming_limit")
if tm_limit then
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
local junpFunc1=function()
UIFullCommonControl:jumpDiscipleMain(dzGuid,FULL_TAB_TYPE.eDiscipleTianMing)
end
local isUnlock1=tmlv>=tm_limit
local desc1=UIDiscipleModel.getTianMingLevelDesc(tm_limit,3)
limitList[1]={desc=desc1,tm_limit=tm_limit,isUnlock=isUnlock1,junpFunc=junpFunc1}
end

local jj_limit=cfgHelper.getdef(cfg_discipledaoyanconfig,"open_jingjie_limit")
if jj_limit then
local jjlv=UIDiscipleModel:getDiscipleJJLevelEx(netData)
local junpFunc2=function()
local isLDLock=UIDiscipleModel:checkDZClientState(dzGuid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
UIFullCommonControl:jumpDiscipleMain(dzGuid,FULL_TAB_TYPE.eDiscipleInfo)
UIManager:showWindow('UIDiscipleJingJieWin',{guid=dzGuid})
end
local isUnlock2=jjlv>=jj_limit
local desc2=FMT.fmt('弟子境界达到{0}',UIDiscipleModel:getJJName3(jj_limit))
limitList[2]={desc=desc2,isUnlock=isUnlock2,junpFunc=junpFunc2}
end

for i=1,2 do
local widget=self.limitItem[i]:getChildWidgetBase()
local data=limitList[i]
self.limitItem[i]:setActive(data~=nil)
if data~=nil then
local color=data.isUnlock and"#f1ce78"or"#f36666"
widget:SetChildText(0,FMT.fmt("<color={0}>{1}</color>",color,data.desc))
widget:SetChildActive(1,data.isUnlock)
widget:SetChildActive(2,not data.isUnlock)
widget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:closeSelf()
if data.junpFunc then
data.junpFunc()
end
end)
if data.tm_limit then
local floor=UIDiscipleModel.getTianMingLevelFloor(data.tm_limit)
local chong=UIDiscipleModel.getTianMingLevelChong(data.tm_limit)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
for i=1,3 do
widget:SetChildActive(i+2,i<=chong)
widget:SetChildCSImageSprite(i+2,abName,iconName)
end
end
end
end
end
end

function UIDiscipleDaoYanWin:refreshAllFire()
local grids=self.dyHuoGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshFireItem(item,i)

item:SetChildButtonClick(1,function()
self:onFireItemClick(i)
end)
end
end


function UIDiscipleDaoYanWin:refreshFireItem(item,idx,isUp)
if item==nil then
item=self.dyHuoGrid:getChildCommonLayoutGroupWidgetItem(idx-1)
end

local skill=UIDiscipleModel:getDaoYanSkillByGuid(self.disciple_guid,idx)
local skillId=skill[1]
local limit=skill[2]
local isActive=self.dylv>=limit

local skillCfg=cfg_skillconfig_get(skillId)
local skillIconName=iconHelper.getSkillIcon(skillCfg.icon)
local effId=UIDiscipleModel:getDiscipleDaoYanSkillBgEffectId(idx)
item:SetChildCSImageIcon(1,skillIconName)
item:SetChildImageExGray(1,not isActive)
item:SetChildShowEffect(2,effId,isActive)
item:SetChildActive(3,not isActive)


local jie=UIDiscipleModel.getDaoYanLevelJie(self.dylv,idx)
local jieEfftId=UIDiscipleModel:getDiscipleDaoYanjieEffectId(idx)
local grids=item:GetChildCommonLayoutGroupWidgetList(0)
for i=1,3 do
local item_jie=grids[i-1]
local isGray=jie<i
item_jie:SetChildActive(1,isGray)
if isUp then
if jie==i then
item_jie:SetChildShowEffect(2,20693,true)
item_jie:SetChildShowEffect(0,jieEfftId,not isGray)
end
else
item_jie:SetChildShowEffect(0,jieEfftId,not isGray)
end
end
end

function UIDiscipleDaoYanWin:onFireItemClick(idx)
local skill=UIDiscipleModel:getDaoYanSkillByGuid(self.disciple_guid,idx)
local skillId=skill[1]
local limit=skill[2]

local args={
skillId=skillId,
isActive=self.dylv>=limit,
limit=limit,
guid=self.disciple_guid,
isNotShowButton=true
}
if not self.isOpen then
args.isNotShowActive=true
end
self:showWindow("UIDiscipleDaoYanSkillTipsWin",args)
end

function UIDiscipleDaoYanWin:onGoodItemClick(itemID)
tipsManager.showTips({itemid=itemID,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end



function UIDiscipleDaoYanWin:refreshReset()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local dylv=UIDiscipleModel:getDaoYanLevelEx(netData)
local isShow=dylv>0
self.resetPanel:setActive(isShow)
if not isShow then return end

local max=UIDiscipleController:getMonthMaxResetDaoYanMaxCount()
local useTimes=UIDiscipleController:getDiscipleDaoYanResetCount()

local resumeTimes=max-useTimes
local isUseUp=resumeTimes<=0

self.resetBtn:setGray(isUseUp)

if isUseUp then
self:startResetDaoYanResetTimer()
else
local tips=FMT.fmt("本月剩余：{0}/{1}",resumeTimes,max)
self.resetTips:setText(tips)
end
end

function UIDiscipleDaoYanWin:startResetDaoYanResetTimer()
self:stopResetDaoYanResetTimer()

local nextMontnStamp=timeHelper.getNextMonthDateStamp2(1,5,0,0)
nextMontnStamp=timeHelper.convertShortStamp(nextMontnStamp)
local curTime,left,tips

local func=function()
curTime=timeHelper.getServerShortTime()
left=nextMontnStamp-curTime

if left<0 then
_this:startResetDaoYanResetTimer()
_this:refreshReset()
return
end
tips=FMT.fmt("{0}后重置",timeHelper.format_time_stamp9(left))
_this.resetTips:setText(tips)
end

self.resetDaoYanResetTimer=self:setTimer(1,-1,func)
func()
end

function UIDiscipleDaoYanWin:stopResetDaoYanResetTimer()
if self.resetDaoYanResetTimer then
self:stopTimerByID(self.resetDaoYanResetTimer)
self.resetDaoYanResetTimer=nil
end
end






function UIDiscipleDaoYanWin:onCommitBtn()
if self.isUpAnim then
return
end
local isEnough,itemID,needItemCount=UIDiscipleModel:getDiscipleDaoYanUpLevelReddot(self.disciple_guid)
if not isEnough then
UIManager.error('材料不足')
gainControl:showCommonGainWin_daoyan(itemID,{needCount=needItemCount})
return
end
UIDiscipleController:reqDaoYanLevelup(self.disciple_guid)
end



function UIDiscipleDaoYanWin:onDiziJTBtn()
self.isShowDiZi=not self.isShowDiZi
self:refreshShowDiZi()
end

function UIDiscipleDaoYanWin:onResetBtn()
if self.isUpAnim then return end

if UIDiscipleController:checkCanResetDiscipleDaoYan()then
local args={}

local lang=cfgHelper.get1(cfg_lang_get,"dzDaoYanResetDesc")or"{0}"
local max=UIDiscipleController:getMonthMaxResetDaoYanMaxCount()
local useTimes=UIDiscipleController:getDiscipleDaoYanResetCount()
local consumeTimes=max-useTimes
local countStr=FMT.fmt("{0}/{1}",consumeTimes,max)
countStr=consumeTimes>0 and toColorStringX("#549327",countStr)or toColorString(FONT_COLOR.eRedColor,countStr)
local content=FMT.fmt(lang,countStr)
args.content=content
args.resetCost=cfgHelper.getdef(cfg_discipledaoyanconfig,'reset_cost')
local costDesc="消耗："
for index,cost in ipairs(args.resetCost)do
local itemid=cost[1]
local itemcount=cost[2]
local itemIconName=itemsModel.getItemIconName(itemid)
local chatEmot=chatEmotHelper.getIconEmotMesg(itemIconName,30)
local hasCount=itemsModel.getCount(itemid)
local isEnough=hasCount>=itemcount
local countStr=isEnough and toColorString(FONT_COLOR.eNomalColor,itemcount)or toColorString(FONT_COLOR.eRedColor,itemcount)
costDesc=FMT.fmt("{0}{1}{2}",costDesc,chatEmot,countStr)
end
args.tips=costDesc
args.resetRewardList=UIDiscipleController:calculateResetRewardList(self.disciple_guid)
args.resetCallBack=function()

UIDiscipleController:reqDaoYanReset(self.disciple_guid)
end
self:showWindow("UIDiscipleDaoYanResetWin",args)
else
local nextMontnStamp=timeHelper.getNextMonthDateStamp2(1,5,0,0)
nextMontnStamp=timeHelper.convertShortStamp(nextMontnStamp)
local curTime=timeHelper.getServerShortTime()
local left=nextMontnStamp-curTime
local tips=FMT.fmt("{0}后可重置",timeHelper.format_time_stamp9(left))
UIManager.info(tips)
end
end

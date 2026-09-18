





local _backDress=false

fabaoProtocolControl=gameState.addListener({})

function fabaoProtocolControl:onAppStart()
socketManager:register_receiver(3,121,self.onFabaoCreate)
socketManager:register_receiver(3,122,self.onFabaoLianzhiInfo)
socketManager:register_receiver(3,123,self.onFabaoPrize)
socketManager:register_receiver(3,124,self.onBenMingFabaoCreate)
socketManager:register_receiver(3,125,self.onFabaoBatchCreate)

socketManager:register_receiver(3,127,self.onBenMingFabaoRemake)

socketManager:register_receiver(3,100,self.onBatchPrzie)

socketManager:register_receiver(2,48,self.onReOwner)
socketManager:register_receiver(2,51,self.onFabaoDress)
socketManager:register_receiver(2,52,self.onFabaoTakeoff)
socketManager:register_receiver(2,53,self.onFabaoJilian)
socketManager:register_receiver(2,54,self.onFabaoLianhua)
socketManager:register_receiver(2,55,self.onFabaoLianhuaTimes)
socketManager:register_receiver(2,56,self.onFabaoChangeName)
socketManager:register_receiver(2,58,self.onFabaoTuPo)
socketManager:register_receiver(2,59,self.onFabaoYunYang)
socketManager:register_receiver(2,60,self.onFabaoUpLingXing)
socketManager:register_receiver(2,61,self.onFabaoUseLingXingItem)
socketManager:register_receiver(2,50,self.onFabaoShengTongChange)
socketManager:register_receiver(2,49,self.onFabaoExpChange)
socketManager:register_receiver(2,45,self.onFabaoLianhuaReset)
socketManager:register_receiver(2,47,self.onFabaoJiLianReset)
end

function fabaoProtocolControl:onEnterState()
fabaoModel.init()
fabaoPreviewModel:init()
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end

function fabaoProtocolControl:onLeaveState()
fabaoModel.init()
fabaoPreviewModel:init()
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
end

function fabaoProtocolControl:onSystemInit()

end



function fabaoProtocolControl.onFabaoCreate(argstable)
local diziguid=argstable[1]
local list=argstable[2]
local jingcuiguid=argstable[3]
local sfid=argstable[4]
local ubdId=argstable[5]
local fabaoid=argstable[6]
local mainid=argstable[7]
local stamp=argstable[8]
fabaoModel.setLianzhiInfo(sfid,ubdId,fabaoid,mainid,stamp)
fabaoControl.freshLianzhiWindow('startLianzhi',ubdId)

local bdData=zongmenModel:getBuildingData(ubdId)
buildingCDControl:addCDData(buildingCDType.lianqi,bdData)
hudControl:refreshBuildingStatusHUD(ubdId)
end


function fabaoProtocolControl.onFabaoLianzhiInfo(len,array,batchListlen,batchList)
fabaoModel.stopAllLianzhiTimer()
fabaoModel.setLianzhiInfoArray(len,array)
fabaoModel.setLianzhiInfoByBatchList(batchListlen,batchList)
end


function fabaoProtocolControl.onFabaoPrize(sfId,ubdId,itemguid,batch)
fabaoModel.clearLianzhiInfo(ubdId)
fabaoControl.freshLianzhiWindow('onLianzhiRet',ubdId)
hudControl:closeProgress(ubdId)


local item=bagModel.getItem(itemguid)
local itemid=item.itemid
local itemconfig=itemsConfig.getConfig(itemid)
local bdData=zongmenModel:getBuildingData(ubdId)
local diziguid=bdData.dizi_id

if not batch then
local stage=itemconfig.stage
local proskill=fabaoConfig.getCommonConfig().proskill
local val=proskill[stage]
local proType=DISCIPLE_PROSKILL_TYPE.eLianQi
local addVal=val
local diziName
if diziguid then
local addRate=UIDiscipleModel:getDiscipleProskillRate(diziguid,proType)
addVal=math.floor(addVal*(1+addRate/100))
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
diziName=diziInfo.disciplename
end
local isTempName=diziName==nil or diziName==''
diziName=isTempName and''or FMT.cfmt(FONT_COLOR.eOrangeColor,diziName)
local str=not isTempName and addVal and addVal>0 and FMT.cfmt(FONT_COLOR.eOrangeDescColor,'{0}炼器经验增加{1}点',diziName,addVal)or''
showPrizeControl.showWindowNow({{itemguid=itemguid}},nil,str)
end

notifySystem:postNotify(notifyConfig.onDiscipleMakeFaBao,diziguid,{itemguid})
reddotControl.on_fabao_create_changed(ubdId)

buildingCDControl:removeCDData(buildingCDType.lianqi,ubdId)
hudControl:refreshBuildingStatusHUD(ubdId)
end

function fabaoProtocolControl.onBenMingFabaoCreate(itemguid)
if not UIManager:isActive('UIBenMingFabaoWin')then
showPrizeControl.showWindowNow({{itemguid=itemguid}})
end
UIManager:callWindowFunc('UIBenMingFabaoWin','onLianZhiRet',itemguid)
end


function fabaoProtocolControl.onFabaoBatchCreate(len,batchCreateList)
if not len or len<=0 then
return
end
for i,v in ipairs(batchCreateList)do



local sfid=v.sfid
local ubdId=v.buildguid
local lianzhiList={}
local list=v.list
local stamp=v.beginsec
if list then
local lastEndTime=stamp
for _,lianzhiData in ipairs(list)do
local idList=lianzhiData.idList
local materialid=lianzhiData.materialid
local fabaoid=nil
local mainid=idList[1]
local stage=itemsConfig.getConfig(mainid).stage
local needtime=fabaoConfig.getCreateTime(stage)
local endTimeStamp=lastEndTime+needtime
fabaoModel.setLianzhiInfo(sfid,ubdId,fabaoid,mainid,endTimeStamp,true)
lastEndTime=endTimeStamp
end
end
fabaoControl.freshLianzhiWindow('startLianzhi',ubdId)

local bdData=zongmenModel:getBuildingData(ubdId)
buildingCDControl:addCDData(buildingCDType.lianqi,bdData)
hudControl:refreshBuildingStatusHUD(ubdId)
end


local win=UIManager:findActiveWindow('UIFabaoBatchCreateWin')
if win then
win:onCloseBtn()
end
end

function fabaoProtocolControl.onBatchPrzie(len,array)
fabaoPrizeControl.onBatchPrzie(len,array)
end


function fabaoProtocolControl.onFabaoDress(diziguid,itemguid)
fabaoModel.onFabaoDress(diziguid,itemguid)
equipsControl.freshWindow('onChangeFabao')
equipsControl.freshAttrWindow()
if not _backDress then
UIManager.info('装备成功')

AudioManager.playAudio(632)
end
_backDress=false
notifySystem:postNotify(notifyConfig.onDiscipleFaBaoChange,diziguid,1)
end


function fabaoProtocolControl.onFabaoTakeoff(diziguid)
fabaoModel.onFabaoTakeoff(diziguid)
equipsControl.freshAttrWindow()
equipsControl.freshWindow('onChangeFabao')
notifySystem:postNotify(notifyConfig.onDiscipleFaBaoChange,diziguid,2)
end


function fabaoProtocolControl.onFabaoJilian(guid,pos,level,exp)
local addexp=0
local change=false
if pos==0 then
local oldlv,oldexp=fabaoModel.getFabaoJilianExp(guid)
change=oldlv~=level
addexp=exp-oldexp
fabaoModel.onFabaoJilian(guid,level,exp)
fabaoControl.freshJilianWindow('onJilian',oldlv,level)
equipsControl.freshBagWindow('onFabaoJinglian',guid)
else
local oldlv,oldexp=fabaoModel.getFabaoJilianExpByDizi(guid)
change=oldlv~=level
addexp=exp-oldexp
fabaoModel.onFabaoJilianByDizi(guid,level,exp)
fabaoControl.freshJilianWindow('onJilian',oldlv,level)
equipsControl.freshWindow('onChangeFabao')
notifySystem:postNotify(notifyConfig.onDiscipleFaBaoChange,guid,3)
end
equipsControl.freshAttrWindow()
if addexp>0 then
commonTipsHelper.addThrowOutAndSliderTips(2,FMT.fmt('+{0}经验',addexp))
end
if change then
notifySystem:postNotify(notifyConfig.onFabaoJilianLevelChange,guid,pos,level)
end
end



function fabaoProtocolControl.onFabaoLianhua(guid,pos,times,len,attrList)
local lastAttrList
if pos==0 then
local fabao=fabaoHelper.getFabao(guid)
lastAttrList=fabaoHelper.getLianhuaAttrsList(fabao)
fabaoModel.onFabaoLianhua(guid,times,len,attrList)
else
local fabao=fabaoModel.getFabaoByDizi(guid)
lastAttrList=fabaoHelper.getLianhuaAttrsList(fabao)
fabaoModel.onFabaoLianhuaByDizi(guid,times,len,attrList)
UIManager:callWindowFunc('UIDiscipleSkillInfoWin','rec_lianhuaFB',guid)
end
fabaoControl.freshLianhuaWindow('onLianhua',lastAttrList,attrListHelper.transformFromNamedList(attrList))
equipsControl.freshAttrWindow()
notifySystem:postNotify(notifyConfig.onFabaoLianHuaChange,guid)
end


function fabaoProtocolControl.onFabaoLianhuaTimes(guid,pos,val)
if pos==0 then
fabaoModel.onFabaoLianhuaTimes(guid,val)
else
fabaoModel.onFabaoLianhuaTimesByDizi(guid,val)
end
fabaoControl.freshLianhuaWindow('freshLianhuaNum')
end


function fabaoProtocolControl.onFabaoChangeName(itemguid,isquiped,name,ret)
if ret==0 then
if isquiped==1 then
local equip=fabaoModel.getFabaoByDizi(itemguid)
itemguid=equip.itemguid
end
fabaoModel.onFabaoChangeName(itemguid,name)
UIManager:callWindowFunc('UIFabaoBenMingInfoWin','onChangeNameRet',itemguid)
UIManager.info('法宝改名成功')
elseif ret==1 then
UIManager.error('先天法宝无法改名')
elseif ret==2 then
UIManager.error('包含敏感字符串')
end
end

function fabaoProtocolControl.onFabaoTuPo(guid,pos,level,exp)
local addexp=0
local change=false
if pos==0 then
local oldlv,oldexp=fabaoModel.getFabaoJilianExp(guid)
change=oldlv~=level
addexp=exp-oldexp
fabaoModel.onFabaoJilian(guid,level,exp)
fabaoControl.freshJilianWindow('onJilian',oldlv,level)
equipsControl.freshBagWindow('onFabaoJinglian',guid)
else
local oldlv,oldexp=fabaoModel.getFabaoJilianExpByDizi(guid)
change=oldlv~=level
addexp=exp-oldexp
fabaoModel.onFabaoJilianByDizi(guid,level,exp)
fabaoControl.freshJilianWindow('onJilian',oldlv,level)
equipsControl.freshWindow('onChangeFabao')
notifySystem:postNotify(notifyConfig.onDiscipleFaBaoChange,guid,4)
end
equipsControl.freshAttrWindow()
UIManager.info('突破成功')
if change then
notifySystem:postNotify(notifyConfig.onFabaoTuPo,guid,pos,level)
end
end



function fabaoProtocolControl.onFabaoYunYang(guid,pos,num)
local itemguid=guid
if pos==0 then
fabaoModel.onYunYang(guid,num)
else
local item=fabaoModel.getFabaoByDizi(guid)
itemguid=item.itemguid
fabaoModel.onYunYangByDZ(guid,num)
UIManager:callWindowFunc('UIDiscipleJingJieWin','onYunYangChange',guid)
end
UIManager:callWindowFunc('UIFabaoBenMingInfoWin','onYunYangRet',itemguid)
UIManager:invokeUIMethod('UIFabaoYunYangWin','freshYunYang')
UIManager:callWindowFunc('UIDiZiFabaoYunYangTips','onYunYangRet',itemguid)
UIManager:callWindowFunc('UIDiscipleJingJieWin','onYunYangChange')

if num==1 then
UIManager.error('开启法宝蕴养')
else
UIManager.error('关闭法宝蕴养')
end
end


function fabaoProtocolControl.onFabaoUpLingXing(guid,pos,lv,exp)
local addexp=0
local change=false
if pos==0 then
local oldlv=fabaoModel.getLingXingLv(guid)
change=oldlv~=lv
fabaoModel.onFabaoLingXing(guid,lv,exp)
UIManager:invokeUIMethod('UIFabaoYunYangWin','onUpRet',guid)
local tupocost=fabaoConfig.getTuPoLxCost(oldlv)
local isTplv=tupocost~=nil
if isTplv then
UIManager:showWindow('UIFabaoTuPoSuccessWin',{guid,oldlv,lv})
else
fabaoProtocolControl.showLxUpTips(guid,oldlv,lv)
end
else
local equip=fabaoModel.getFabaoByDizi(guid)
local itemguid=equip.itemguid
local oldlv=fabaoModel.getFabaoReallyLingXingLvByDizi(guid)
change=oldlv~=lv
fabaoModel.onFabaoLingXingByDizi(guid,lv,exp)
UIManager:invokeUIMethod('UIFabaoYunYangWin','onUpRet',itemguid)
local tupocost=fabaoConfig.getTuPoLxCost(oldlv)
local isTplv=tupocost~=nil
if isTplv then
UIManager:showWindow('UIFabaoTuPoSuccessWin',{itemguid,oldlv,lv})
else
fabaoProtocolControl.showLxUpTips(itemguid,oldlv,lv)
end
end
equipsControl.freshAttrWindow()
if change then
notifySystem:postNotify(notifyConfig.onFabaoLingXingLevelChange,guid,pos,lv)
end
end


function fabaoProtocolControl.onFabaoUseLingXingItem(guid,pos,exp)
local addexp=0
local itemguid=guid
if pos==0 then
fabaoModel.onFabaoLingXingExp(guid,exp)
else
local equip=fabaoModel.getFabaoByDizi(guid)
itemguid=equip.itemguid
fabaoModel.onFabaoLingXingExpByDizi(guid,exp)
end
UIManager:invokeUIMethod('UIFabaoYunYangWin','onChangeExp',itemguid)
end

function fabaoProtocolControl.onFabaoExpChange(dzguid,exp)
fabaoModel.onFabaoLingXingExpByDizi(dzguid,exp)
local equip=fabaoModel.getFabaoByDizi(dzguid)
if equip==nil then return end
UIManager:invokeUIMethod('UIFabaoYunYangWin','onChangeExp',equip.itemguid)
end

function fabaoProtocolControl.onFabaoShengTongChange(guid,pos,mainidx)
local itemguid=guid
if pos~=0 then
local equip=fabaoModel.getFabaoByDizi(guid)
itemguid=equip.itemguid
end
fabaoModel.onFabaoShengTongChange(itemguid,mainidx)
UIManager:callWindowFunc('UIFabaoBenMingInfoWin','onShengTongChangeRet',itemguid,mainidx)

if pos~=0 then
UIManager:callWindowFunc('UIDiscipleSkillInfoWin','refreshFBSkillGrid',guid)
end
UIManager.info('神通切换成功')
end

function fabaoProtocolControl.onReOwner(lastguid,pos,dzguid)
local itemguid=lastguid
if pos~=0 then
local equip=fabaoModel.getFabaoByDizi(lastguid)
itemguid=equip.itemguid
end
fabaoModel.onChangeOwner(itemguid,dzguid,lastguid)
UIManager:callWindowFunc('UIFabaoBenMingInfoWin','onReOwnerRet',itemguid)

if tostring(dzguid)==tostring(int64.new(0))then
UIManager.info('归元成功')
else
UIManager.info('认主成功')
end
end

function fabaoProtocolControl.onFabaoLianhuaReset(guid,pos,len,attrList)
if pos==0 then

fabaoModel.onFabaoLianhua(guid,0,len,attrList,true)
else

fabaoModel.onFabaoLianhuaByDizi(guid,0,len,attrList,true)
UIManager:callWindowFunc('UIDiscipleSkillInfoWin','rec_lianhuaFB',guid)
end
fabaoControl.freshLianhuaWindow('onLianhuaReset')
end

function fabaoProtocolControl.onFabaoJiLianReset(guid,pos,len,attrList)
local change=false
if pos==0 then

local oldlv,oldexp=fabaoModel.getFabaoJilianExp(guid)
change=oldlv~=0
fabaoModel.onFabaoJilian(guid,0,0)
fabaoControl.freshJilianWindow('onJilianReset')
equipsControl.freshBagWindow('onFabaoJinglian',guid)
else

local oldlv,oldexp=fabaoModel.getFabaoJilianExpByDizi(guid)
change=oldlv~=0
fabaoModel.onFabaoJilianByDizi(guid,0,0)
fabaoControl.freshJilianWindow('onJilianReset')
equipsControl.freshWindow('onChangeFabao')
notifySystem:postNotify(notifyConfig.onDiscipleFaBaoChange,guid,3)
end
equipsControl.freshAttrWindow()
if change then
notifySystem:postNotify(notifyConfig.onFabaoJilianLevelChange,guid,pos,0)
end
end

function fabaoProtocolControl.onBenMingFabaoRemake(gmfbGuid)
UIManager:invokeUIMethod("UIBenMingAgainRefineWin","playRefineAnimation",gmfbGuid)
end


function fabaoProtocolControl.reqBenMingFaBaoRemake(bmfbGuid,materials)
local len=#materials
socketManager:send_3_127(bmfbGuid,len,materials)
end

function fabaoProtocolControl.reqCreateFabao(diziguid,guidlist,jingcuiguid,jhid,ubdId)
local sfid=zongmenModel:getMountainId()
socketManager:send_3_121(diziguid,guidlist,jingcuiguid,jhid,sfid,ubdId)
end

function fabaoProtocolControl.reqFabaoCreateInfo()
socketManager:send_3_122()
end

function fabaoProtocolControl.reqFabaoPrize(ubdId)
local sfid=zongmenModel:getMountainId()
local isBatchCreate=fabaoModel.checkLianzhiIsBatch(ubdId)
if not isBatchCreate then

socketManager:send_3_123(sfid,ubdId)
else

local finishIndex=fabaoModel.getLianzhiInfoNowFinishIdx(ubdId)
socketManager:send_3_126(sfid,ubdId,finishIndex,0)
end
end


function fabaoProtocolControl.reqOneKeyPrizeFabao()
local args=fabaoModel.getOnekeyPrize()
if args==nil then return end
local len=#args
if len<=0 then return end
socketManager:send_3_100(len,args)
end

function fabaoProtocolControl.reqBatchCreateFabao(lianzhiList,ubdId)
if not ubdId or not lianzhiList or not next(lianzhiList)then
return
end
local sfid=zongmenModel:getMountainId()
local len=1
local batchData={
sfid,
ubdId,
#lianzhiList,
lianzhiList,
}
socketManager:send_3_125(len,{batchData})
end


function fabaoProtocolControl.reqStopFabaoBatchCreate(ubdId)
local sfid=zongmenModel:getMountainId()
local isBatchCreate=fabaoModel.checkLianzhiIsBatch(ubdId)
if isBatchCreate then

local finishIndex=fabaoModel.getLianzhiInfoNowFinishIdx(ubdId)
if not finishIndex then
finishIndex=0
end
socketManager:send_3_126(sfid,ubdId,finishIndex,1)
end
end

function fabaoProtocolControl.reqReOwner(dzguid,itemguid)
local equipguid=fabaoModel.getDiziguidByItemguid(itemguid)
if equipguid then
socketManager:send_2_48(equipguid,1,dzguid)
else
socketManager:send_2_48(itemguid,0,dzguid)
end
end


function fabaoProtocolControl.reqDressFabao(diziguid,itemguid,backDress)
local func1=function()
socketManager:send_2_51(diziguid,itemguid)
end

local func2=function()
fabaoProtocolControl.reqReOwner(diziguid,itemguid)
socketManager:send_2_51(diziguid,itemguid)
end

_backDress=backDress

local equip=fabaoHelper.getFabao(itemguid)
if(not backDress)and fabaoConfig.isBenMingFabao(equip.itemid)then
local has,ownerguid=benMingFaBaoHelper.hasOwner(itemguid)
if not has then
local dzname=UIDiscipleModel:getDiscipleName(diziguid)
local desc=FMT.fmt('确定要选定弟子<color=#ca631d>[{0}]</color>成为该法宝的主人吗？',dzname)
UIDialogManager.getConfirmDialog3(nil,desc,func2)
elseif tostring(ownerguid)~=tostring(diziguid)then
local dzname=UIDiscipleModel:getDiscipleName(diziguid)
local desc='装备其他弟子的本命法宝，灵性属性将不会生效，确定要装备吗？'
UIDialogManager.getConfirmDialog3(nil,desc,func1)
else
func1()
end
else
func1()
end
end

function fabaoProtocolControl.reqTakeoffFabao(diziguid)
socketManager:send_2_52(diziguid)
end

function fabaoProtocolControl.reqJilianFabao(guid,pos,itemlist,equipguids)
local itemnums={}
local itemguids={}
local itemsLen=0
local equipsLen=#(equipguids or{})
if itemlist and#itemlist>0 then
itemsLen=#itemlist
for i,v in ipairs(itemlist)do
itemguids[#itemguids+1]=v[1]
itemnums[#itemnums+1]=v[2]
end
end
socketManager:send_2_53(guid,pos,itemsLen,itemguids,itemsLen,itemnums,equipsLen,equipguids)
end

function fabaoProtocolControl.reqTuPoFabao(guid,pos)
socketManager:send_2_58(guid,pos)
end

function fabaoProtocolControl.reqLianhuaFabao(guid,pos,len,guidlist)
socketManager:send_2_54(guid,pos,len,guidlist)
end

function fabaoProtocolControl.reqLianhuaFabaoLimitUp(guid,pos,val)
socketManager:send_2_55(guid,pos,val)
end

function fabaoProtocolControl.reqYunYang(itemguid,flag)
local dzguid=fabaoModel.getDiziguidByItemguid(itemguid)
local flagNum=flag==true and 1 or 0
if dzguid then
socketManager:send_2_59(dzguid,1,flagNum)
else
socketManager:send_2_59(itemguid,0,flagNum)
end
end

function fabaoProtocolControl.reqChangeShentong(itemguid,mainidx)
local dzguid=fabaoModel.getDiziguidByItemguid(itemguid)
if dzguid then
socketManager:send_2_50(dzguid,1,mainidx)
else
socketManager:send_2_50(itemguid,0,mainidx)
end
end

function fabaoProtocolControl.reqChangeName(itemguid,name)
local dzguid=fabaoModel.getDiziguidByItemguid(itemguid)
if dzguid then
socketManager:send_2_56(dzguid,1,name)
else
socketManager:send_2_56(itemguid,0,name)
end
end

function fabaoProtocolControl.reqUpLingXing(itemguid)
local dzguid=fabaoModel.getDiziguidByItemguid(itemguid)
if dzguid then
socketManager:send_2_60(dzguid,1)
else
socketManager:send_2_60(itemguid,0)
end
end

function fabaoProtocolControl.reqUseLingXingItem(itemguid,itemid,num)
local dzguid=fabaoModel.getDiziguidByItemguid(itemguid)
if dzguid then
socketManager:send_2_61(dzguid,1,itemid,num)
else
socketManager:send_2_61(itemguid,0,itemid,num)
end
end

function fabaoProtocolControl.reqCreateBenMingFaBao(dzguid,ypguid,fbguidList)
socketManager:send_3_124(dzguid,ypguid,#fbguidList,fbguidList)
end

function fabaoProtocolControl.reqFabaoLianhuaReset(guid,pos)


socketManager:send_2_45(guid,pos)
end

function fabaoProtocolControl.reqFabaoJiLianReset(guid,pos)


socketManager:send_2_47(guid,pos)
end

function fabaoProtocolControl.showLxUpTips(itemguid,oldlv,newlv)
local equip=fabaoHelper.getFabao(itemguid)
local mainid=fabaoHelper.getReallyMainId(equip)
local oldAttrs=benMingFaBaoHelper.getLxAttr(mainid,oldlv)or{}
local newAttrs=benMingFaBaoHelper.getLxAttr(mainid,newlv)or{}
local oldAttrsLookup=attrListHelper.tramsformToLookup(oldAttrs)
local strs={}
for i,v in ipairs(newAttrs)do
local attrType=v[1]
local old=oldAttrsLookup[attrType]or 0
local new=v[2]
local add=new-old
local name,str=equipsHelper.getAttr(attrType,add)
strs[#strs+1]=FMT.fmt('{0}<color=#aae252>+{1}</color>',name,str)
end
local args={}
args.effect=10254
args.strs=strs
UIManager:showWindow('UIUpFlowWin',args)
end


























function fabaoProtocolControl.onPrizeBatch(sfId,ubdId,idx,over)
local oldInfoList=table.deepCopy(fabaoModel.getLianzhiInfoList(ubdId))
fabaoModel.clearLianzhiInfo(ubdId)
hudControl:closeProgress(ubdId)
buildingCDControl:removeCDData(buildingCDType.lianqi,ubdId)
hudControl:refreshBuildingStatusHUD(ubdId)
fabaoModel.finishSectionalLianzhiInfoList(oldInfoList,sfId,ubdId,idx,over==1)
fabaoControl.freshLianzhiWindow('onLianzhiRet',ubdId)
reddotControl.on_fabao_create_changed(ubdId)
fabaoControl.freshBuildingHUD(sfId,ubdId)
end

function fabaoProtocolControl.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eFaBaoBatchCreate then
local sfId=effectData.sfid
local ubdId=effectData.buildguid
local idx=effectData.idx
local over=effectData.over

fabaoProtocolControl.onPrizeBatch(sfId,ubdId,idx,over)
elseif prizeType==ePrizeType.eFabaoJingLianReset then
fabaoProtocolControl:setResetBMFBJlLvData(prizelist,effectData)
end
end

function fabaoProtocolControl:setResetBMFBJlLvData(prizelist,effectData)
self.refineResetJlLvPrizeData={prizelist,effectData}
end

function fabaoProtocolControl:resetBMFBRefineResetJlLvData()
self.refineResetJlLvPrizeData=nil
end

function fabaoProtocolControl:delayShowJlLvPrize()
if self.refineResetJlLvPrizeData then
local temp=self.refineResetJlLvPrizeData[1]
table.sort(temp,function(a,b)
return a.sortWeight>b.sortWeight
end)
showPrizeControl.showWindow(temp,nil,nil)
fabaoProtocolControl:resetBMFBRefineResetJlLvData()
end
end

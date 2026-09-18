







def_class("UINPCInteractWin",UIWindowBase)









function UINPCInteractWin:bindComponents()

self.maskBlock=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.descPanel=UIButton.get(self,2)
self.scenePanel=UIObject.get(self,3)
self.blockMask=UIObject.get(self,4)
self.npcPanel=UIObject.get(self,5)
self.dzPanel=UIObject.get(self,6)
self.rewardScrollview=UIObject.get(self,7)
self.loveDescTxt=UIText.get(self,8)
self.hgdBtn=UIButton.get(self,9)
self.hgdNameTxt=UIText.get(self,10)
self.relationBtn=UIButton.get(self,11)
self.descBtn=UIButton.get(self,12)
self.jobIcon=UIImage.get(self,13)
self.hgdEventBtn=UIButton.get(self,14)
self.btnClose=UIButton.get(self,15)
self.interactObj=UIObject.get(self,16)
self.hgdEventBtnRoot=UIObject.get(self,17)
self.hgdEventIcon=UIImage.get(self,18)
self.rightTalkDesc=UIText.get(self,19)
self.descText=UIText.get(self,20)
self.giftBtn=UIButton.get(self,21)
self.talkBtn=UIButton.get(self,22)
self.gameBtn=UIButton.get(self,23)
self.pkBtn=UIButton.get(self,24)
self.interactProgressImg=UIObject.get(self,25)
self.modelRoot=UIObject.get(self,26)
self.leftTalk=UIObject.get(self,27)
self.rightTalk=UIObject.get(self,28)
self.jingjieTxt=UIText.get(self,29)
self.leftTalkDesc=UIText.get(self,30)
self.hgdNumText=UIText.get(self,31)
self.hgdProgressYellow=UIObject.get(self,32)
self.hgdProgressGreen=UIObject.get(self,33)
self.interactTxt=UIText.get(self,34)
self.nameTxt=UIText.get(self,35)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.descPanel:setButtonClick(function()self:onDescPanel()end)

self.hgdBtn:setButtonClick(function()self:onHgdBtn()end)

self.relationBtn:setButtonClick(function()self:onRelationBtn()end)

self.descBtn:setButtonClick(function()self:onDescBtn()end)

self.hgdEventBtn:setButtonClick(function()self:onHgdEventBtn()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.giftBtn:setButtonClick(function()self:onGiftBtn()end)

self.talkBtn:setButtonClick(function()self:onTalkBtn()end)

self.gameBtn:setButtonClick(function()self:onGameBtn()end)

self.pkBtn:setButtonClick(function()self:onPkBtn()end)



end


function UINPCInteractWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.descPanel);self.descPanel=nil;
_UIObject_release(self.scenePanel);self.scenePanel=nil;
_UIObject_release(self.blockMask);self.blockMask=nil;
_UIObject_release(self.npcPanel);self.npcPanel=nil;
_UIObject_release(self.dzPanel);self.dzPanel=nil;
_UIObject_release(self.rewardScrollview);self.rewardScrollview=nil;
_UIObject_release(self.loveDescTxt);self.loveDescTxt=nil;
_UIObject_release(self.hgdBtn);self.hgdBtn=nil;
_UIObject_release(self.hgdNameTxt);self.hgdNameTxt=nil;
_UIObject_release(self.relationBtn);self.relationBtn=nil;
_UIObject_release(self.descBtn);self.descBtn=nil;
_UIObject_release(self.jobIcon);self.jobIcon=nil;
_UIObject_release(self.hgdEventBtn);self.hgdEventBtn=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.interactObj);self.interactObj=nil;
_UIObject_release(self.hgdEventBtnRoot);self.hgdEventBtnRoot=nil;
_UIObject_release(self.hgdEventIcon);self.hgdEventIcon=nil;
_UIObject_release(self.rightTalkDesc);self.rightTalkDesc=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.giftBtn);self.giftBtn=nil;
_UIObject_release(self.talkBtn);self.talkBtn=nil;
_UIObject_release(self.gameBtn);self.gameBtn=nil;
_UIObject_release(self.pkBtn);self.pkBtn=nil;
_UIObject_release(self.interactProgressImg);self.interactProgressImg=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.leftTalk);self.leftTalk=nil;
_UIObject_release(self.rightTalk);self.rightTalk=nil;
_UIObject_release(self.jingjieTxt);self.jingjieTxt=nil;
_UIObject_release(self.leftTalkDesc);self.leftTalkDesc=nil;
_UIObject_release(self.hgdNumText);self.hgdNumText=nil;
_UIObject_release(self.hgdProgressYellow);self.hgdProgressYellow=nil;
_UIObject_release(self.hgdProgressGreen);self.hgdProgressGreen=nil;
_UIObject_release(self.interactTxt);self.interactTxt=nil;
_UIObject_release(self.nameTxt);self.nameTxt=nil;
end
















local _this=nil


function UINPCInteractWin:onLoaded(...)
_this=self
self:bindComponents()

if webGLHelper:isNeedAdaption()then
self.btnClose:setActive(false)
end

notifySystem:listenNotify(notifyConfig.swipe,self.on_swipe)
notifySystem:listenNotify(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)

local btnsLookup={
[NPC_INTERACT_TYPE.eTalk]=self.talkBtn,
[NPC_INTERACT_TYPE.ePK]=self.pkBtn,
[NPC_INTERACT_TYPE.eGift]=self.giftBtn,
[NPC_INTERACT_TYPE.eGame]=self.gameBtn,
}
self.btnsLookup=btnsLookup
end


function UINPCInteractWin:__delete()
_this=nil
self:unbindComponents()
self:killAskForProgress()
npcController:closeWorldEntityStageEx()
notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
end

function UINPCInteractWin.onClickEmptyInWorld()
if _this==nil or not _this.isVisible then return end
_this:closeWorldEntityStage()
end

function UINPCInteractWin.on_swipe()
if _this==nil or not _this.isVisible then return end
_this:closeWorldEntityStage(false)
end


function UINPCInteractWin:onHide()
self:hideAndDo()
self:killAskForProgress()
npcController:closeWorldEntityStageEx()
end

function UINPCInteractWin:hideAndDo()
UIManager:callWindowFunc('UIWorldNPCListWin','cancelSubItemSelect',self.npcid)
end




function UINPCInteractWin:onShow(argtable,afterOnloaded)
self.npcid=argtable.npcid

self.changehgd=0
self.hgdProgressGreen:setChildIconFillAmount(0)

self.descPanel:setActive(false)
self:initNPCLikeLookup()
self:refreshInfo()
self:refreshHaoGanDu()
self:refreshAllBtns()

if afterOnloaded then



self.maskBlock:setChildCanvasEx('UITop',1000)
self.maskBlock:setActive(false)
end
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)

self:refreshScenePanel(true)

self:playEnterAnim()
self:clearAllTalk()
end

function UINPCInteractWin:playEnterAnim()
self.scenePanel:setActive(false)
self.root:setChildAnchoredPosition(Vector2(278,10))
local func=function()
if _this==nil then return end
_this.scenePanel:setActive(true)
end
self.root:setChildDOAnchorPosX(-294,0.25,func)
end

function UINPCInteractWin:playLeaveAnim(func)
self.scenePanel:setActive(false)
self.root:setChildDOAnchorPosX(278,0.25,func)
end

function UINPCInteractWin:showMaskBlock(time)
if self.showMaskBlockTimer~=nil then
self:stopTimerByID(self.showMaskBlockTimer)
self.showMaskBlockTimer=nil
end
self.maskBlock:setActive(true)
self.blockMask:setChildCanvasGroupRaycast(false)
local func=function()
self.showMaskBlockTimer=nil
self.maskBlock:setActive(false)
self.blockMask:setChildCanvasGroupRaycast(true)
end
self.showMaskBlockTimer=self:setTimer(time,1,func)
end

function UINPCInteractWin:changeNPC(npcid)
if self.npcid~=npcid then
self:onShow({npcid=npcid})
end
end

function UINPCInteractWin:refreshInfo()
local npcid=self.npcid
local npcItemData=npcModel:getNPCItemData(npcid)
local imagecfg=npcModel:getNPCImageCfg(npcid)

local job=npcModel:getNPCJob(npcid)
local jobicon=UIDiscipleModel:getJobIconName(job)
self.jobIcon:setSprite(globalABLookup.global,jobicon)


self.modelRoot:setChildUIModelRemoveTarget()
local modelParams=npcModel:getImageInfo(imagecfg.id)
comHelper.setChildInSideModelEx(self.modelRoot,modelParams,0.75,0,0,0,false,true)

self.nameTxt:setText(imagecfg.name)

local jjlv=npcModel:getNPCJingJie(npcid)
local jjname=UIDiscipleModel.getJJNameCommon(jjlv,3)
self.jingjieTxt:setText(jjname)

local lovestr=cfgHelper.get2(cfg_npcconfig_get,npcid,'lovestr')
lovestr=FMT.fmt('<color=#7d3b17>喜好：</color>{0}',lovestr)
self.loveDescTxt:setText(lovestr)

self:refreshGoodList()
end

function UINPCInteractWin:refreshGoodList()
local npcid=self.npcid
local npcItemData=npcModel:getNPCItemData(npcid)
local temp=npcItemData.bagList or{}
local goodlist=table.deepCopy(temp)
local goodnum=#goodlist
if goodnum>1 then
for i,v in ipairs(goodlist)do
local itemConfig=itemsConfig.getConfig(v.itemid)
v.color=itemConfig.color
end
table.sort(goodlist,function(a,b)
return a.color>b.color
end)
end

self.rewardScrollview:setChildScrollViewCreateGrids(goodnum,5)
local grids=self.rewardScrollview:getChildScrollViewItemWidgets()
for i=1,goodnum do
local item=grids[i-1]
local widget=item:GetChildWidgetBase(0)
local good=goodlist[i]
local count=good.itemcount
local itemid=good.itemid
local itemguid=good.itemguid
local countStr=count>1 and mathHelper.formatNumber(count)or''
local showCountBG=count>1
local conf={itemid=itemid,showCountBG=showCountBG,itemcount=countStr,showStage=true,showname=false,
itemguid=itemguid,itemIndex=i}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
end
end

function UINPCInteractWin:refreshHaoGanDu(isplay)
local npcid=self.npcid
local hgd=npcModel:getNPCIntimacy(npcid)
local lv,rate,cur,max,isFull=npcModel.getHaoGanDuLevel(hgd)
if isFull then
rate=1
end
local lv_o,rate_o,cur_o,max_o,isFull_o=lv,rate,cur,max,isFull
if self.old_hgd then
lv_o,rate_o,cur_o,max_o,isFull_o=npcModel.getHaoGanDuLevel(self.old_hgd)
if isFull_o then
rate_o=1
end
end
local changehgd=self.changehgd or 0
local hgdname

if isplay then
helper.playProgressAnim(self.hgdProgressYellow,rate,lv-lv_o,nil,nil,nil,1)
else
self.hgdProgressYellow:setChildIconFillAmount(rate)
end

local showGreen=changehgd>0 and not isFull
self.hgdProgressGreen:setActive(showGreen)
if showGreen then
local hgd_g=hgd+changehgd
local lv_g,rate_g,cur_g,max_g=npcModel.getHaoGanDuLevel(hgd_g)
if lv_g>lv then
rate_g=1
end
helper.playProgressAnim(self.hgdProgressGreen,rate_g,0,nil,nil,nil,0.1)
hgdname=npcModel.getHaoGanDuName(hgd_g)
else
hgdname=npcModel.getHaoGanDuName(hgd)
end

self.hgdNameTxt:setText(hgdname)

local numstr
if not isFull then
if changehgd>0 then
numstr=FMT.fmt('{0}<color=#0ee918>+{1}</color>/{2}',cur,changehgd,max)
else
numstr=FMT.fmt('{0}/{1}',cur,max)
end
else
numstr='已满'
end

self.hgdNumText:setText(numstr)

self.old_hgd=hgd

self:refreshHaoGanDuEevnt()
end

function UINPCInteractWin:refreshAllBtns()
local npcid=self.npcid
for interacttype,v in pairs(self.btnsLookup)do
local isopen=npcModel:checkInteractTypeOpen(npcid,interacttype)
local btn=self.btnsLookup[interacttype]
btn:setActive(isopen)
if isopen then
self:refreshBtn(interacttype)
end
end
end

function UINPCInteractWin:refreshBtn(interacttype)
local npcid=self.npcid
local has=npcModel:checkInteractTypeEnough(npcid,interacttype,false)
if interacttype==NPC_INTERACT_TYPE.eGift then
has=true
end
local btn=self.btnsLookup[interacttype]
btn:setChildImageExGray(not has)
end

function UINPCInteractWin:selectBtn(interacttype,flag)
local btn=self.btnsLookup[interacttype]
local iconname=flag and'button_npczhuanyongtab_1'or'button_npczhuanyongtab_2'
btn:setCSImageSprite(globalABLookup.npcIcons,iconname)
end

function UINPCInteractWin:onItemClick(id,index,guid,attach)
local npcid=self.npcid
attach={}
local insertBtnList={}
if npcModel:checkInteractTypeOpen(npcid,NPC_INTERACT_TYPE.eAskfor)then
table.insert(insertBtnList,TIPS_BTNS_TYPE.eNPCAskfor)
attach.askforNPCData={npcid,guid}
end
if npcModel:checkInteractTypeOpen(npcid,NPC_INTERACT_TYPE.eSteal)then
table.insert(insertBtnList,TIPS_BTNS_TYPE.eNPCSteal)
attach.stealNPCData={npcid,guid}
end
if#insertBtnList>0 then
attach.insertBtnList=insertBtnList
end
itemsComponentHelper.onItemClick(id,index,guid,attach)
end

function UINPCInteractWin:onRelationBtn()
UIManager:showWindow('UINPCRelationWin',{npcid=self.npcid})
end

function UINPCInteractWin:onHgdBtn()
self:showWindow('UINPCIntimacyRewardWin',{npcid=self.npcid})
end

function UINPCInteractWin:onDescBtn()




self:showWindow('UINPCIntimacyRewardWin',{npcid=self.npcid})
end

function UINPCInteractWin:onDescPanel()
self.descPanel:setActive(false)
end

function UINPCInteractWin:refreshHaoGanDuEevnt()
local reward=npcModel:checkIntimacyReward(self.npcid)
local showEvent=reward~=nil
self.hgdEventBtn:setActive(showEvent)
if showEvent then
local info=npcModel.getIntimacyRewardInfo(reward)
self.hgdEventIcon:setSprite(globalABLookup.npcCommonIcons,info[2])
end
self:doHgdEventBtnAnim(showEvent)
end

function UINPCInteractWin:onHgdEventBtn()
local rw,lv=npcModel:checkIntimacyReward(self.npcid)
if rw then
npcController:reqIntimacyReward(self.npcid,lv)
end
end

function UINPCInteractWin:doHgdEventBtnAnim(flag)
if self.hgdEventBtnTween then
self.hgdEventBtnTween:Kill()
self.hgdEventBtnTween=nil
end
if self.hgdEventBtnTweenTimer then
self:stopTimerByID(self.hgdEventBtnTweenTimer)
self.hgdEventBtnTweenTimer=nil
end
if flag then
self.hgdEventBtnRoot:setRotation(0,0,0)
local func=function()
if _this==nil then return end
_this.hgdEventBtnTween=nil

_this.hgdEventBtnTweenTimer=_this:delayDo(3,function()
if _this==nil then return end
_this.hgdEventBtnTweenTimer=nil
_this:doHgdEventBtnAnim(true)
end)
end
local tweener=self.hgdEventBtnRoot:setChildDOPunchRotation(Vector3(0,0,15),2,6,1,func)
self.hgdEventBtnTween=tweener
end
end



function UINPCInteractWin:onTalkBtn()
local npcid=self.npcid
local interacttype=NPC_INTERACT_TYPE.eTalk
if not npcModel:checkInteractTypeEnough(npcid,interacttype,true)then
return
end
local talkData=npcModel:getNPCDialogue(npcid)
local rewardlist=talkData.rewardlist

local params={}
params.showblack=true
params.blackAlpha=1
params.dialoguelist=talkData.dialoguelist
params.selectlist=talkData.selectlist
params.afterSelectTalks=talkData.afterSelectTalks
params.callback=function(idx)
local rewardidx=rewardlist[idx]
local otherData={}
otherData.interacttype=interacttype
otherData.rewardidx=rewardidx
npcController:reqInteract(npcid,otherData)
end
UIFullStoryBoardControl:showPlotBoardWindow(params,false)
end





function UINPCInteractWin:onPkBtn()
local npcid=self.npcid
local interacttype=NPC_INTERACT_TYPE.ePK
if not npcModel:checkInteractTypeEnough(npcid,interacttype,true)then
return
end
npcController:doReqFight_after(npcid)
end





function UINPCInteractWin:onGiftBtn()
local npcid=self.npcid





local func=function(selectList,addhgd)
if _this==nil then return end
_this:onSelectChange(selectList,addhgd)
end
UIManager:showWindow('UINPCGiftSelectWin',{npcid=npcid,selectChangeFunc=func})
end

function UINPCInteractWin:onCloseGiftSelect()
self.changehgd=0
self:refreshHaoGanDu(true)
end

function UINPCInteractWin:onSelectChange(selectList,addhgd)
self.changehgd=addhgd
self:refreshHaoGanDu(true)
end

function UINPCInteractWin:initNPCLikeLookup()
local npcid=self.npcid
self.npcLikeLookup=npcModel:getNPCLikeItems(npcid)or{}
end


function UINPCInteractWin:getCustomerLikeItemVal(itemid)
local lookup=self.npcLikeLookup
local val=lookup[itemid]
if val~=nil then
return val
end
return nil
end





function UINPCInteractWin:onGameBtn()
local npcid=self.npcid
local interacttype=NPC_INTERACT_TYPE.eGame
if not npcModel:checkInteractTypeEnough(npcid,interacttype,true)then
return
end
local gameType,mapid,resultLookup=npcModel:getNPCGame(npcid)
local callback=function(resultLV)
local rewardidx=resultLookup[resultLV]
if rewardidx then
local otherData={}
otherData.interacttype=interacttype
otherData.rewardidx=rewardidx
npcController:reqInteract(npcid,otherData)

local str=npcModel:getNPCGameResultTalk(npcid,resultLV)
if str then
npcController:worldInteractNPCTalk(str,5)
end
else



end
end
UILittleGameController:openLittleGame(gameType,{mapId=mapid},callback)
end





function UINPCInteractWin:refreshScenePanel(isinit)
self.dzPanel:setActive(true)
self.npcPanel:setActive(false)

if isinit then

local npcEntity=npcController:getWorldNPCEntity(self.npcid)
if npcEntity.side==0 then

self.dzPanel:setChildAnchoredPosition(Vector2(70,0))
else

self.dzPanel:setChildAnchoredPosition(Vector2(-85,0))
end
end
end

function UINPCInteractWin:onChangeDZBtn()
local args={
openType=dzSelectWinOpenType.eInteractNPC,
}
discipleSelectController:openDiscipleSelect(args)
end

function UINPCInteractWin:beginAskfor(desc,time,callback,breakBack)
self.dzPanel:setActive(false)
self.npcPanel:setActive(true)

self.interactTxt:setText(desc)
self.interactProgressImg:setChildIconFillAmount(0)
local func=function()
if _this==nil then return end
_this.askforTween=nil
_this.askforBreak=nil
_this.npcPanel:setActive(false)
if callback then
callback()
end
end
self.askforTween=self.interactProgressImg:setChildImageDOFillAmount(1,time,func)
self.askforBreak=breakBack
end

function UINPCInteractWin:killAskForProgress()
if self.askforTween~=nil then
self.askforTween:Rewind()
self.askforTween:Kill()
self.askforTween=nil
if self.askforBreak then
self.askforBreak()
self.askforBreak=nil
end
end
end

function UINPCInteractWin:npcTalk(str,time,canvas)
if canvas==nil then
canvas=UIManager:invokeUIMethod('UIWorldNPCListWin','getTalkCanvas')
end
local npcEntity=npcController:getWorldNPCEntity(self.npcid)
if npcEntity.side==0 then

self.leftTalkDesc:setText(str)
if self.leftTalkDelay then
self:stopTimerByID(self.leftTalkDelay)
self.leftTalkDelay=nil
end
self.leftTalkDelay=self:delayDo(time,function()
self.leftTalkDelay=nil
self.leftTalk:setChildCanvasGroupAlpha(0)
end)
self:doTalkAnimLeft(canvas)
else

self.rightTalkDesc:setText(str)
if self.rightTalkDelay then
self:stopTimerByID(self.rightTalkDelay)
self.rightTalkDelay=nil
end
self.rightTalkDelay=self:delayDo(time,function()
self.rightTalkDelay=nil
self.rightTalk:setChildCanvasGroupAlpha(0)
end)
self:doTalkAnimRight(canvas)
end
end

function UINPCInteractWin:dzTalk(str,time,canvas)
if canvas==nil then
canvas=UIManager:invokeUIMethod('UIWorldNPCListWin','getTalkCanvas')
end
local dEntity=npcController:getWorldNPCEntity(self.npcid)
if npcEntity.side==0 then

self.rightTalkDesc:setText(str)
if self.rightTalkDelay then
self:stopTimerByID(self.rightTalkDelay)
self.rightTalkDelay=nil
end
self.rightTalkDelay=self:delayDo(time,function()
self.rightTalkDelay=nil
self.rightTalk:setChildCanvasGroupAlpha(0)
end)
self:doTalkAnimRight(canvas)
else

self.leftTalkDesc:setText(str)
if self.leftTalkDelay then
self:stopTimerByID(self.leftTalkDelay)
self.leftTalkDelay=nil
end
self.leftTalkDelay=self:delayDo(time,function()
self.leftTalkDelay=nil
self.leftTalk:setChildCanvasGroupAlpha(0)
end)
self:doTalkAnimLeft(canvas)
end
end

function UINPCInteractWin:doTalkAnimLeft(canvas)
if self.talkTweenLeft~=nil then
self.talkTweenLeft:Kill()
self.talkTweenLeft=nil
end
if canvas then
self.leftTalk:setChildCanvas(canvas[1],canvas[2])
else
self.leftTalk:setChildRemoveCanvas()
end
self.leftTalk:setScale(Vector3.zero)
self.leftTalk:setChildCanvasGroupAlpha(1)
self.talkTweenLeft=self.leftTalk:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTweenLeft=nil
_this.talkTweenLeft=_this.leftTalk:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTweenLeft=nil
end)
end)
end

function UINPCInteractWin:doTalkAnimRight(canvas)
if self.talkTweenRight~=nil then
self.talkTweenRight:Kill()
self.talkTweenRight=nil
end
if canvas then
self.rightTalk:setChildCanvas(canvas[1],canvas[2])
else
self.rightTalk:setChildRemoveCanvas()
end
self.rightTalk:setScale(Vector3.zero)
self:delayDo(0.2,function()
self.rightTalk:setChildCanvasGroupAlpha(1)
self.talkTweenRight=self.rightTalk:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTweenRight=nil
_this.talkTweenRight=_this.rightTalk:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTweenRight=nil
end)
end)
end)
end

function UINPCInteractWin:clearAllTalk()
if self.rightTalkDelay then
self:stopTimerByID(self.rightTalkDelay)
self.rightTalkDelay=nil
end
if self.leftTalkDelay then
self:stopTimerByID(self.leftTalkDelay)
self.leftTalkDelay=nil
end
if self.talkTweenLeft~=nil then
self.talkTweenLeft:Kill()
self.talkTweenLeft=nil
end
if self.talkTweenRight~=nil then
self.talkTweenRight:Kill()
self.talkTweenRight=nil
end
self.leftTalk:setChildCanvasGroupAlpha(0)
self.rightTalk:setChildCanvasGroupAlpha(0)
end



function UINPCInteractWin:onCloseClick()
self:closeWorldEntityStage()
end

function UINPCInteractWin:onBtnClose()
self:onCloseClick()
end

function UINPCInteractWin:closeWorldEntityStage(cameraReturn)
local func=function()
worldController:resetRightView()
end
self:playLeaveAnim(func)
npcController:closeWorldEntityStage(cameraReturn)
end

function UINPCInteractWin:onMaskBlock()

end



function UINPCInteractWin:rec_gift()

self.changehgd=0
self:refreshHaoGanDu(true)
self:refreshBtn(NPC_INTERACT_TYPE.eGift)
end

function UINPCInteractWin:rec_talk()
self:refreshHaoGanDu(true)
self:refreshBtn(NPC_INTERACT_TYPE.eTalk)
end


function UINPCInteractWin:rec_askfor()
self.dzPanel:setActive(true)
self:refreshHaoGanDu(true)
self:refreshGoodList()
end







function UINPCInteractWin:rec_game()
self:refreshHaoGanDu(true)
self:refreshBtn(NPC_INTERACT_TYPE.eGame)
end

function UINPCInteractWin:recv_reward(npcid)
if self.npcid==npcid then
self:refreshHaoGanDu(true)
end
end



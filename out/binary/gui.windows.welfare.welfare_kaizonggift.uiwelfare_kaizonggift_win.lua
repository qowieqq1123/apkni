







def_class("UIWelfare_kaizonggift_win",UIWindowBase)









function UIWelfare_kaizonggift_win:bindComponents()

self.modelbg=UIObject.get(self,0)
self.level=UIText.get(self,1)
self.scrollView=UIObject.get(self,2)
self.modelfg=UIObject.get(self,3)
self.model=UIObject.get(self,4)


self.sprite_image_xianshuui_15=0
self.sprite_image_xianshuui_14=1

end


function UIWelfare_kaizonggift_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.modelbg);self.modelbg=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.modelfg);self.modelfg=nil;
_UIObject_release(self.model);self.model=nil;
end



















function UIWelfare_kaizonggift_win:onLoaded(...)
self:bindComponents()
self.dogLeftPos={-270,-355}
self.dogRightPos={0,-355}
self.giftConfig=table.deepCopy(cfg_guildgiftconfig())

self.modelfg:setChildUIModelShowTarget(4217,1,{},eAnimationID.enter,false,false,0,nil)
self.speakIndex=1

local zongmenexp_up_today=self.giftConfig.const_def.zongmenexp_up_today
self.zongmenexp_up_today=zongmenexp_up_today

self:createDog(self.dogLeftPos,function(bt)
self.dogBT=bt
self.dogBT:setSharedVar('UIstateId',0)
end)
end


function UIWelfare_kaizonggift_win:__delete()
self:unbindComponents()
if self.dogBT then
uiAIManager:removeUIInstance(self.dogBT)
end
if self.dogSTID then

_InstantiateManager.RemoveInstance(self.dogSTID)
end
self.dogBT=nil
end





function UIWelfare_kaizonggift_win:onShow(argtable,afterOnloaded)

self:onRefresh()
end


function UIWelfare_kaizonggift_win:showAnim()
self.modelfg:setChildModelAnimationState(eAnimationID.enter,1)
end

function UIWelfare_kaizonggift_win:onShowArgRecv()
self:showAnim()
end

function UIWelfare_kaizonggift_win:createDog(pos,callback)
local initData={
speakHUDID=1,
speakTime=8,
speakHUDParent=1,
offset={0,0},
leftPos=self.dogLeftPos,
rightPos=self.dogRightPos,
uispeakrate=0.5,
uimoverate=0.5,
}
local tran=self.model:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])

local otherData={
order=1002,
scale=1,
}
self.dogSTID=uiAIManager:createUIObject('UIWelfare_kaizonggift_win','bt_ui_dog',INSTANCE_TYPE.eUIDog,440011,
tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end

function UIWelfare_kaizonggift_win:getZongMenExpSpeak()
local curLv=zongmenModel:getLevel()
local nextId=nil

for i,v in ipairs(self.giftConfig)do
local isFinish=welfareModel:checkKaiZongGet(curLv,v)

if isFinish then
local nConfig=self.giftConfig[i+1]
if nConfig then
nextId=nConfig
else
nextId=nil
end
end
end
self.nextId=nextId
if self.nextId then
local config=self.nextId
local conditions=config.conditions
local condLv=nil
for _,v in ipairs(conditions)do
if v[1]==1 then
condLv=v[2]
break
end
end
if condLv then
local next_cfg=cfg_guildexpconfig_get(condLv)
local speak=nil
if next_cfg then
local upExp=0
for i,v in ipairs(self.zongmenexp_up_today)do
if curLv>=v[1]and curLv<=v[2]then
upExp=v[3]
break
end
end


if self:canLevelUp(curLv,upExp,condLv)then
speak=FMT.fmt("祖师大概明天就可领取{0}级赠礼，\n祖师加油，汪汪！",condLv)
else
if self:canLevelUp(curLv,upExp*2,condLv)then
speak=FMT.fmt("祖师大概后天就可领取{0}级赠礼，\n祖师加油，汪！",condLv)
end
end
end
return speak
end
end

end

function UIWelfare_kaizonggift_win:canLevelUp(curLv,upExp,targetLv)
if upExp<=0 then
return false
end
local next_cfg=cfg_guildexpconfig_get(curLv+1)
if next_cfg then
local curExp=tonumber(tostring(zongmenModel:getExp()))
local nextExp=next_cfg.exp
local canUp=curExp+upExp>=nextExp
if canUp then
if curLv+1>=targetLv then
return true
else
return self:canLevelUp(curLv+1,upExp-nextExp,targetLv)
end
end
end
end

function UIWelfare_kaizonggift_win:getJingJieSpeak()
if self.nextAgain then
return FMT.fmt("宗门有{0}位{1}弟子\n可再领1次{2}级赠礼，汪！",self.nextAgain[2],UIDiscipleModel:getJJName3(self.nextAgain[1]),self.nextAgain[3])
end
end


function UIWelfare_kaizonggift_win:getDogSpeakText(bt,tkey)
local txt
if self.speakIndex==1 then
local expSpeak=self:getZongMenExpSpeak()
if expSpeak then
txt=expSpeak
end

elseif self.speakIndex==2 then
local jjSpeak=self:getJingJieSpeak()
if jjSpeak then
txt=jjSpeak
end
end

local cfg=cfg_guildgiftdogconfig()
if not txt then
txt=cfg[math.random(1,#cfg)].speak
end
bt:setSharedVar(tkey,txt)

self.speakIndex=self.speakIndex+1
if self.speakIndex>=4 then
self.speakIndex=1
end
end


function UIWelfare_kaizonggift_win:getDogMovePos(bt,pkey)
local dx=self.dogRightPos[1]-self.dogLeftPos[1]
local px=self.dogLeftPos[1]+dx*math.random()
local pos={px,self.dogLeftPos[2]}
bt:setSharedVar(pkey,pos)
end

function UIWelfare_kaizonggift_win:onRefresh()
local giftConfig=table.deepCopy(self.giftConfig)
local gCount=#giftConfig

local level=zongmenModel:getLevel()
local diziJJCountList=UIDiscipleModel:getDiscipleCount_Jingjie()

self.level:setText(level)
table.sort(giftConfig,function(a,b)
local sortA=a.id
local sortB=b.id
local finishA=welfareModel:checkKaiZongGet(level,a)
local finishB=welfareModel:checkKaiZongGet(level,b)
local gotFirstA=welfareModel:checkKaiZongGiftGot(a.id)
local gotFirstB=welfareModel:checkKaiZongGiftGot(b.id)
local gotA=welfareModel:checkKaiZongGiftAgainGot(a.id)
local gotB=welfareModel:checkKaiZongGiftAgainGot(b.id)

sortA=sortA+(gotA and 1000000 or 0)
sortB=sortB+(gotB and 1000000 or 0)
sortA=sortA+((finishA and not gotFirstA)and-1000000 or 0)
sortB=sortB+((finishB and not gotFirstB)and-1000000 or 0)
return sortA<sortB
end)

self.scrollView:setChildScrollViewCreateGrids(gCount,gCount)

local nextId=self.giftConfig[1]
local nextAgain=nil

local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local config=giftConfig[i]
local id=config.id
local conditions=config.conditions
local condLv=0
for _,v in ipairs(conditions)do
if v[1]==1 then
condLv=v[2]
break
end
end

local againjj=nil
local againnum=nil
local again_conditions=config.again_conditions
for _,v in ipairs(again_conditions)do
if v[1]==1 then
againjj=v[2]
againnum=v[3]
break
end
end

item:SetChildText(0,FMT.fmt("{0}级",condLv))

local isGot=welfareModel:checkKaiZongGiftGot(id)
local isFinish=level>=condLv











local isGotAgain=welfareModel:checkKaiZongGiftAgainGot(id)
local isFinishAgain=false
local diziJJCount=welfareModel:getAgainNum(diziJJCountList,againjj)
if againjj then

isFinishAgain=isGot and diziJJCount>=againnum

if not nextAgain and isGot and(diziJJCount<againnum or not isGotAgain)then
nextAgain={againjj,againnum,condLv}
end
end

item:SetChildActive(2,isFinish and not isGot)
item:SetChildActive(3,not isFinish)
item:SetChildActive(4,isFinish and isFinishAgain and isGotAgain)
item:SetChildActive(6,isGot and not isGotAgain)

item:SetChildActive(5,config.back==2)

item:SetChildDoBrightness(-1,(isFinish and isFinishAgain and isGotAgain)and 0.7 or 1,0,nil)
item:SetChildActive(7,(isFinish and not isGot)or(isFinishAgain and not isGotAgain))

local rewardList=config.rewards
item:SetChildLayoutGroupCreateItems(1,#rewardList)
local rewardGridList=item:GetChildLayoutGroupGridList(1)
local count=rewardGridList.Count
if count>0 then
for i=1,count do
local widget=rewardGridList[i-1]
local reward=rewardList[i]
local itemid=reward[1]
local itemCount=reward[2]
local countStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
widget:SetChildDoBrightness(-1,(isGot)and 0.7 or 1,0,nil)
widget:SetChildActive(1,isGot)
end
end
if isFinish and not isGot then
item:SetChildButtonClickWithID(2,self.onGetButton,id,true)
end
if not isFinish then
item:SetChildButtonClickWithID(3,self.onGotoButton,id,true)
end
if isGot then
item:SetChildButtonClickWithID(6,function()
if not isFinishAgain then
local pos=Vector2.New(0,-100)
local cond_str=FMT.fmt("再领条件：\n{0}名弟子{1}（<color=#ff0000>{2}/{3}</color>）",againnum,UIDiscipleModel:getJJName3(againjj),diziJJCount,againnum)
UIManager:showWindow('UIConditionTipsOne',{str=cond_str,posWidget=item,pos=pos})
else
self.onAgainButton()
end
end,id,true)
end
end
self.nextId=nextId
self.nextAgain=nextAgain
end

function UIWelfare_kaizonggift_win.onGetButton(index)
local maxId=welfareModel:checkKaiZongGotMaxIndex()
if maxId~=0 then
socketManager:send_6_77(maxId)
end
end

function UIWelfare_kaizonggift_win.onGotoButton()
jumpManager:jump({type=0,id=JUMP_TYPE.eZongmenInfo})
end

function UIWelfare_kaizonggift_win.onAgainButton()
local maxId=welfareModel:checkKaiZongGotMaxIndex()
if maxId~=0 then
socketManager:send_6_77(maxId)
end
end


function UIWelfare_kaizonggift_win:onHide()

end

function UIWelfare_kaizonggift_win:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight})
end



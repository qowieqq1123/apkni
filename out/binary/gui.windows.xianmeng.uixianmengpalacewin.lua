







def_class("UIXianMengPalaceWin",UIWindowBase)









function UIXianMengPalaceWin:bindComponents()

self.actorListPanel=UIObject.get(self,0)
self.btnGrid=UIObject.get(self,1)
self.changeDesc=UIButton.get(self,2)
self.changeName=UIButton.get(self,3)
self.changeSign=UIButton.get(self,4)
self.huoyueBtn=UIButton.get(self,5)
self.leaderNameText=UIText.get(self,6)
self.root=UIObject.get(self,7)
self.signBGIcon=UIImage.get(self,8)
self.signBtn=UIButton.get(self,9)
self.signIcon=UIImage.get(self,10)
self.signKuangIcon=UIImage.get(self,11)
self.ugReddot=UIObject.get(self,12)
self.unionGroupBinBtn=UIButton.get(self,13)
self.unionGroupJoinBtn=UIButton.get(self,14)
self.unionGroupRoot=UIObject.get(self,15)
self.unionGroupUnbinBtn=UIButton.get(self,16)
self.xmDescText=UIText.get(self,17)
self.xmLevelProgress=UIProgress.get(self,18)
self.xmLevelText=UIText.get(self,19)
self.xmMemberNumText=UIText.get(self,20)
self.xmNameText=UIText.get(self,21)

self.changeDesc:setButtonClick(function()self:onChangeDesc()end)

self.changeName:setButtonClick(function()self:onChangeName()end)

self.changeSign:setButtonClick(function()self:onChangeSign()end)

self.huoyueBtn:setButtonClick(function()self:onHuoyueBtn()end)

self.signBtn:setButtonClick(function()self:onSignBtn()end)

self.unionGroupBinBtn:setButtonClick(function()self:onUnionGroupBinBtn()end)

self.unionGroupJoinBtn:setButtonClick(function()self:onUnionGroupJoinBtn()end)

self.unionGroupUnbinBtn:setButtonClick(function()self:onUnionGroupUnbinBtn()end)



end


function UIXianMengPalaceWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actorListPanel);self.actorListPanel=nil;
_UIObject_release(self.btnGrid);self.btnGrid=nil;
_UIObject_release(self.changeDesc);self.changeDesc=nil;
_UIObject_release(self.changeName);self.changeName=nil;
_UIObject_release(self.changeSign);self.changeSign=nil;
_UIObject_release(self.huoyueBtn);self.huoyueBtn=nil;
_UIObject_release(self.leaderNameText);self.leaderNameText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.signBGIcon);self.signBGIcon=nil;
_UIObject_release(self.signBtn);self.signBtn=nil;
_UIObject_release(self.signIcon);self.signIcon=nil;
_UIObject_release(self.signKuangIcon);self.signKuangIcon=nil;
_UIObject_release(self.ugReddot);self.ugReddot=nil;
_UIObject_release(self.unionGroupBinBtn);self.unionGroupBinBtn=nil;
_UIObject_release(self.unionGroupJoinBtn);self.unionGroupJoinBtn=nil;
_UIObject_release(self.unionGroupRoot);self.unionGroupRoot=nil;
_UIObject_release(self.unionGroupUnbinBtn);self.unionGroupUnbinBtn=nil;
_UIObject_release(self.xmDescText);self.xmDescText=nil;
_UIObject_release(self.xmLevelProgress);self.xmLevelProgress=nil;
_UIObject_release(self.xmLevelText);self.xmLevelText=nil;
_UIObject_release(self.xmMemberNumText);self.xmMemberNumText=nil;
_UIObject_release(self.xmNameText);self.xmNameText=nil;
end















local _this=nil

local btnType={
eNote=1,
eApplication=2,
eCondition=3,
eInvite=4,
}

local btnConfig={

[btnType.eNote]={
icon='button_xmjinkuang',
show=function(postType)
return true
end,
refresh=function(item)

end,
click=function(this_)
xianmengModel:tryOpenXMNotes()
end,
},

[btnType.eApplication]={
icon='button_xmshenqing',
show=function(postType)
return xianmengModel.checkPostPrivile(postType,GUILD_PRIVILE_TYPE.gptHandle)
end,
refresh=function(item)

local list=xianmengModel:getApplicationList()
local isReddot=#list>0
item:SetChildActive(0,isReddot)
end,
click=function(this_)
local list=xianmengModel:getApplicationList()
if#list<=0 then
UIManager.error('暂没玩家申请入盟')
else
this_:showWindow('UIXianMengRequireWin')
end
end,
},

[btnType.eCondition]={
icon='button_xmshenhe',
show=function(postType)
return xianmengModel.checkPostPrivile(postType,GUILD_PRIVILE_TYPE.gptSeting)
end,
refresh=function(item)

end,
click=function(this_)
local args={}
args.titleName="审批设置"
args.pos=3
args.extraWin='UIXianMengSetupWin'
local extraParams={}
args.extraParams=extraParams
this_:showWindow('UICommonPageWin',args)
end,
},

[btnType.eInvite]={
icon='button_xmzhaomu',
show=function(postType)
return xianmengModel.checkPostPrivile(postType,GUILD_PRIVILE_TYPE.gptRecruit)
end,
refresh=function(item)
if not _this.btnGrayFlag then
_this.btnGrayFlag={}
end
local isGray=not xianmengModel.checkZhaoMuCD()
item:SetChildGray(1,isGray)
_this.btnGrayFlag[btnType.eInvite]=isGray
if not _this.timerId then
_this.timerId=_this:setTimer(1,0,function()
local isGray=not xianmengModel.checkZhaoMuCD()
if _this.btnGrayFlag[btnType.eInvite]~=isGray then
item:SetChildGray(1,isGray)
_this.btnGrayFlag[btnType.eInvite]=isGray
end
end)
end
end,
click=function(this_)
local iscan,cd=xianmengModel.checkZhaoMuCD()
if iscan then
local info=xianmengModel:getXMDetialData()
local maxNum=xianmengModel.getXMMaxMemberNum(info.guildlevel)
if info.membernum<maxNum then
xianmengController.req_20_39()
UIManager.info("成功发送招募盟友的公告")
else
UIManager.info("仙盟已满员")
end

else
UIManager.info(FMT.fmt("本盟已发过公告,{0}后可再发",timeHelper.format_time_stamp2(cd)))
end

end,
},
}




function UIXianMengPalaceWin:onLoaded(...)
_this=self
self:bindComponents()
notifySystem:listenNotify(notifyConfig.onXianMengLevelChange,self.onXianMengLevelChange)

local tmjStageCfg=cfg_tianmojiestageconfig()
self.maxTMJScore=tmjStageCfg[#tmjStageCfg].score

self.isRunDouYin=webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative()
self.unionGroupRoot:setActive(false)
if self.isRunDouYin then
self.unionGroupBinBtn:setActive(false)
self.unionGroupUnbinBtn:setActive(false)
self.unionGroupJoinBtn:setActive(false)
self.ugReddot:setActive(false)
end
end


function UIXianMengPalaceWin:__delete()
if _this.timerId then
self:stopTimerByID(_this.timerId)
end
_this=nil
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onXianMengLevelChange,self.onXianMengLevelChange)
end


function UIXianMengPalaceWin:onHide()

end

function UIXianMengPalaceWin.onXianMengLevelChange(oldlv,lv,oldexp,exp)
if _this==nil then return end
if oldlv~=lv or oldexp~=exp then
_this:refreshXMLevel()
end
end




function UIXianMengPalaceWin:onShow(argtable,afterOnloaded)
local fadeInData=argtable.fadeInData
if fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2])
end
self.guildid=xianmengModel:myXMGuildID()
self:initBtnsView()
self:refreshChangeBtns()
self:refreshView()

self:refreshUnionGroupInfo()
end

function UIXianMengPalaceWin:refreshUnionGroupInfo()
if not self.isRunDouYin then
return
end
if not webGLHelper:isUnionGroupFuncCanUse()then
return
end
webGLHelper:handleUnionGroupFunc('get',self.guildid,function(success,result)
local info=jsonHelper.decode_josn(result)
if success then
if _this then
_this:handleUnionGroupInfo(info.BindStatus)
end
else
logErr('获取公会绑定信息失败',info.ErrorCode,info.ErrMsg)
end
end)
end

function UIXianMengPalaceWin:handleUnionGroupInfo(bindStatus)
if not self.isRunDouYin then
return
end
local post=xianmengModel:getXMMemberPost(playerModel:getActorID())
local canBin=post==1
if canBin then
self.unionGroupRoot:setActive(true)
self.unionGroupBinBtn:setActive(not bindStatus)
self.unionGroupUnbinBtn:setActive(bindStatus)
self.unionGroupJoinBtn:setActive(false)
self.ugReddot:setActive(xianmengModel:getXMUnionGroupFlag())
else
if bindStatus then
self.unionGroupRoot:setActive(true)
self.unionGroupBinBtn:setActive(false)
self.unionGroupUnbinBtn:setActive(false)
self.unionGroupJoinBtn:setActive(true)
self.ugReddot:setActive(xianmengModel:getXMUnionGroupFlag())
else
self.unionGroupRoot:setActive(false)
end
end
end

function UIXianMengPalaceWin:doFadeIn(delay,duration)
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,duration,nil)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
end

function UIXianMengPalaceWin:refreshView()
self:refreshXMSign()
self:refreshXMName()
self:refreshXMMember()
self:refreshXMLeaderName()
self:refreshXMLevel()
self:refreshXMNotice()
self:refreshMemberList()
end

function UIXianMengPalaceWin:initBtnsView()
local memberData=xianmengModel:getXMMemberData(playerModel:getActorID())
local pos=memberData.pos
local grids=self.btnGrid:getChildCommonLayoutGroupWidgetList()
for k,typo in pairs(btnType)do
local data=btnConfig[typo]
local item=grids[typo-1]
local isShow=data.show(pos)
item:SetChildActive(-1,isShow)
if isShow then
item:SetChildCSImageSprite(-1,globalABLookup.xianmeng,data.icon)
item:SetChildButtonClick(-1,function()
if _this==nil then return end
data.click(_this)
end)
data.refresh(item)
end
end
end

function UIXianMengPalaceWin:refreshXMSign()
local image=xianmengModel:getGuildImage()
local abname=globalABLookup.xianmengicons

self.signIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

self.signBGIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

self.signKuangIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end

function UIXianMengPalaceWin:refreshXMName()
local detailData=xianmengModel:getMyXMDetialData()


self.xmNameText:setText(detailData.guildname)
end

function UIXianMengPalaceWin:refreshXMMember()
local detailData=xianmengModel:getMyXMDetialData()
local cur=#detailData.list
local max=xianmengModel.getXMMaxMemberNum(detailData.guildlevel)
local str=FMT.fmt('成员：<color=#171311>{0}/{1}</color>',cur,max)
self.xmMemberNumText:setText(str)
end

function UIXianMengPalaceWin:refreshXMLeaderName()
local detailData=xianmengModel:getMyXMDetialData()
local str=FMT.fmt('盟主：<color=#171311>{0}</color>',detailData.leadername)
self.leaderNameText:setText(str)
end

function UIXianMengPalaceWin:refreshXMLevel()
local detailData=xianmengModel:getMyXMDetialData()
local level_str=FMT.fmt('等级：<color=#171311>{0}</color>',detailData.guildlevel)
self.xmLevelText:setText(level_str)
local cur=detailData.guildexp
local max=cfgHelper.get2(cfg_guildlevelconfig_get,detailData.guildlevel,'exp')
local isfull=max==0
local str
if isfull then
cur=1
max=1
str='已满级'
else
str=FMT.fmt('{0}/{1}',cur,max)
end
self.xmLevelProgress:setProgressValue(cur,max)
self.xmLevelProgress:setChildProgressText(str)
end

function UIXianMengPalaceWin:refreshXMNotice()
local notice=xianmengModel:getXMNotice()
self.xmDescText:setText(notice or'无')
end

function UIXianMengPalaceWin:refreshApplicationBtn()
local typo=btnType.eApplication
local data=btnConfig[typo]
local item=self.btnGrid:getChildCommonLayoutGroupWidgetItem(typo-1)
data.refresh(item)
end

function UIXianMengPalaceWin:refreshInviteBtn()
local typo=btnType.eInvite
local data=btnConfig[typo]
local item=self.btnGrid:getChildCommonLayoutGroupWidgetItem(typo-1)
data.refresh(item)
end

function UIXianMengPalaceWin:refreshMemberList()
local list=xianmengModel:getXMMemberList()
local temp={}
for i,v in ipairs(list)do
local sorts={}
sorts[1]=v.online==0 and 1 or 0
sorts[2]=100-v.pos
sorts[3]=v.weekscore
sorts[4]=v.level
local d={netData=v,sorts=sorts,actorid=v.actorid}
table.insert(temp,d)
end
if#temp>1 then
mathHelper.sortWeightList(temp)
end
self.memberList=temp
local c=#self.memberList
self.actorListPanel:setChildScrollViewCreateGrids(c,1)

local grids=self.actorListPanel:getChildScrollViewItemWidgets()
for i=1,c do
self:refreshItem(grids[i-1],i)
end
end

function UIXianMengPalaceWin:getMemberIndex(actorid)
for i,v in ipairs(self.memberList)do
if mathHelper.compareInt64(v.actorid,actorid)then
return i
end
end
return nil
end

function UIXianMengPalaceWin:refreshItemByActorID(actorid)
local index=self:getMemberIndex(actorid)
if index then
self:refreshItem(nil,index)
end
end

function UIXianMengPalaceWin:refreshItem(item,index)
if item==nil then
item=self.actorListPanel:getChildScrollViewItemWidget(index-1)
end

if item then
local actorData=self.memberList[index].netData
playerController:setHeadIcon(item,2,{iconInfo=actorData.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})


if blueDiamondModel:isHasBlueDiamond()then
item:SetChildLocalPosX(1,-303)
end

item:SetChildText(3,tostring(actorData.level))

item:SetChildText(4,actorData.actorname)

local fightnum=tonumber(tostring(actorData.fight))
local fight_str=FMT.fmt('实力：{0}',mathHelper.formatNumber3(fightnum))
item:SetChildText(5,fight_str)

local postType=actorData.pos
local isleader=postType==GUILD_POST_TYPE.gpAllyLeader
local postName=xianmengModel.getXMPostName(postType,true)
item:SetChildText(6,postName)
item:SetChildActive(9,isleader)

local huoyue=tostring(actorData.weekscore)
item:SetChildText(7,huoyue)

local state_str
if actorData.online==0 then
state_str='<color=#549327>在线</color>'
else
local cur=gameUtilityModel.getServerShortTime()
local lerp=cur-actorData.online
state_str=timeHelper.format_time_stamp14(lerp)
end
item:SetChildText(8,state_str)

item:SetChildButtonClick(0,function()
self:onItemClick(index)
end)

item:SetChildActive(10,actorData.tmscore>=0 and actorData.tmscore<self.maxTMJScore)
end
end

function UIXianMengPalaceWin:onItemClick(index)
local actorData=self.memberList[index].netData
local myActorid=playerModel:getActorID()
if not mathHelper.compareInt64(myActorid,actorData.actorid)then
otherPlayerController:openOtherPlayerInfoWin(actorData.actorid,nil,actorInterFromType.eXianMeng)
end
end

function UIXianMengPalaceWin:onChangeName()

if houtaiModel:isForbidenChangeName('该功能正在升级维护中')then
return
end
local myActorid=playerModel:getActorID()
if not xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptRename)then
UIManager.error('权限不足')
return
end
local cost=cfgHelper.get4(cfg_guildbaseconfig_get,1,'consume',2,1)
local func=function(changeName)
xianmengController:reqXMChangeName(changeName)
end
local args={
changeNameType=changeNameType.eXianMeng,
title='仙盟改名',
defaultName=xianmengModel:getXMName(),
is_Chinese=true,
cost=cost,
callback=func,
}
self:showWindow('UICommonChangeNameWin',args)
end

function UIXianMengPalaceWin:onSignBtn()
self:onChangeSign()
end

function UIXianMengPalaceWin:onChangeSign()
local myActorid=playerModel:getActorID()
if not xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptChangeIcon)then
UIManager.error('权限不足')
return
end
local onChangeFunc=function(image)
if _this==nil then return false end
return _this:onChangeIcon(image)
end
self:showWindow('UIXianMengSignSetupWin',{onChangeFunc=onChangeFunc,changType=2})
end

function UIXianMengPalaceWin:onChangeIcon(image_)
local image=xianmengModel:getGuildImage()
local change=false
if image.icon~=image_.icon then
change=true
end
if image.bg~=image_.bg then
change=true
end
if image.kuang~=image_.kuang then
change=true
end
if change then
local guildicon=xianmengModel.composeGuildIcon(image_)
xianmengController:reqChangeXMSign(guildicon)
else
UIManager.info('请选择要改变的盟徽部件')
end
return false
end

function UIXianMengPalaceWin:onChangeDesc()
local myActorid=playerModel:getActorID()
if not xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptChangeNotice)then
UIManager.error('权限不足')
return
end

local checkopen,code,value=xianmengModel:checkOpenNotice()
if not checkopen then
if code==1 then
UIManager.info(FMT.fmt('{0}天后才可修改公告',value-timeHelper.getServerOpenDay()))
elseif code==2 then
UIManager.info(FMT.fmt('宗门{0}级才可修改公告',value))
else
UIManager.error('暂未开启')
end
return
end

self:showWindow('UIXianMengNoticeWin')
end

function UIXianMengPalaceWin:refreshChangeBtns()
local myActorid=playerModel:getActorID()
local showChangeDesc=xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptChangeNotice)
local showChangeSign=xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptChangeIcon)
local showChangeName=xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptRename)
self.changeDesc:setActive(showChangeDesc)
self.changeSign:setActive(showChangeSign)
self.changeName:setActive(showChangeName)
end

function UIXianMengPalaceWin:onLvRuleBtn()
local d={}
d.title='仙盟规则介绍'
d.mode=3
d.name='xianmeng_rule_%d'
self:showWindow('UIRuleWin',d)
end

function UIXianMengPalaceWin:onHuoyueBtn()
local args={}
args.posItem=self.huoyueBtn
args.pos=Vector2.New(0,45)
args.title='活跃'
args.desc=cfgHelper.getlang('xianmeng_huoyue_tips')
self:showWindow('UIDescribeTips5',args)
end

function UIXianMengPalaceWin:rec_actor_post(actorid)
self:refreshItemByActorID(actorid)
end

function UIXianMengPalaceWin:rec_remove_actor(actorid)
local index=self:getMemberIndex(actorid)
if index then
self:refreshMemberList()
end
end

function UIXianMengPalaceWin:rec_refresh()
self:refreshMemberList()
end

function UIXianMengPalaceWin:onUnionGroupBinBtn()
if not self.isRunDouYin then
return
end

self.ugReddot:setActive(false)
xianmengModel:setXMUnionGroupFlag()

webGLHelper:handleUnionGroupFunc('bin',self.guildid,function(success,result)
local info=jsonHelper.decode_josn(result)
if success then
if _this then
if info.BindResult then
_this:handleUnionGroupInfo(true)
UIManager.info('绑定成功')
else
UIManager.error('绑定未完成')
end
end
else
logErr('绑定公会群失败',info.ErrorCode,info.ErrMsg)
end
end)
end

function UIXianMengPalaceWin:onUnionGroupUnbinBtn()
if not self.isRunDouYin then
return
end

self.ugReddot:setActive(false)
xianmengModel:setXMUnionGroupFlag()

webGLHelper:handleUnionGroupFunc('unbin',self.guildid,function(success,result)
local info=jsonHelper.decode_josn(result)
if success then
if _this then
_this:handleUnionGroupInfo(false)
UIManager.info('解绑成功')
end
else
logErr('解绑公会群失败',info.ErrorCode,info.ErrMsg)
end
end)
end

function UIXianMengPalaceWin:onUnionGroupJoinBtn()
if not self.isRunDouYin then
return
end

self.ugReddot:setActive(false)
xianmengModel:setXMUnionGroupFlag()

webGLHelper:handleUnionGroupFunc('join',self.guildid,function(success,result)
local info=jsonHelper.decode_josn(result)
if success then
else
logErr('加入公会群失败',info.ErrorCode,info.ErrMsg)
end
end)
end
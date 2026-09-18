







def_class("UIGMWin",UIWindowBase)








function UIGMWin:bindComponents()

self.addAllMoney=UIButton.get(self,0)
self.addDisciple=UIButton.get(self,1)
self.addDiscipleExp=UIButton.get(self,2)
self.addItem=UIButton.get(self,3)
self.addMoney=UIButton.get(self,4)
self.addZongmenExp=UIButton.get(self,5)
self.allBtns=UIButton.get(self,6)
self.back=UIButton.get(self,7)
self.clearBag=UIButton.get(self,8)
self.clearMoney=UIButton.get(self,9)
self.clearSundrise=UIButton.get(self,10)
self.clickZongMenYeJing=UIButton.get(self,11)
self.contect2=UIObject.get(self,12)
self.contect3=UIObject.get(self,13)
self.crossLoginBnt=UIButton.get(self,14)
self.CrossLoginTxt=UIText.get(self,15)
self.dzAIState=UIToggleButton.get(self,16)
self.GMInputField=UIInputField.get(self,17)
self.mask=UIObject.get(self,18)
self.oneKey=UIButton.get(self,19)
self.openCurrentWorldBlock=UIButton.get(self,20)
self.scrollview=UIObject.get(self,21)
self.scrollview2=UIObject.get(self,22)
self.scrollview3=UIObject.get(self,23)
self.select1Text=UIText.get(self,24)
self.select2Text=UIText.get(self,25)
self.slider1=UIObject.get(self,26)
self.slider2=UIObject.get(self,27)
self.Triggle=UIButton.get(self,28)
self.zongmen=UIButton.get(self,29)

self.addAllMoney:setButtonClick(function()self:onAddAllMoney()end)

self.addDisciple:setButtonClick(function()self:onAddDisciple()end)

self.addDiscipleExp:setButtonClick(function()self:onAddDiscipleExp()end)

self.addItem:setButtonClick(function()self:onAddItem()end)

self.addMoney:setButtonClick(function()self:onAddMoney()end)

self.addZongmenExp:setButtonClick(function()self:onAddZongmenExp()end)

self.allBtns:setButtonClick(function()self:onAllBtns()end)

self.back:setButtonClick(function()self:onBack()end)

self.clearBag:setButtonClick(function()self:onClearBag()end)

self.clearMoney:setButtonClick(function()self:onClearMoney()end)

self.clearSundrise:setButtonClick(function()self:onClearSundrise()end)

self.clickZongMenYeJing:setButtonClick(function()self:onClickZongMenYeJing()end)

self.crossLoginBnt:setButtonClick(function()self:onCrossLoginBnt()end)

self.oneKey:setButtonClick(function()self:onOneKey()end)

self.openCurrentWorldBlock:setButtonClick(function()self:onOpenCurrentWorldBlock()end)

self.Triggle:setButtonClick(function()self:onTriggle()end)

self.zongmen:setButtonClick(function()self:onZongmen()end)



end


function UIGMWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addAllMoney);self.addAllMoney=nil;
_UIObject_release(self.addDisciple);self.addDisciple=nil;
_UIObject_release(self.addDiscipleExp);self.addDiscipleExp=nil;
_UIObject_release(self.addItem);self.addItem=nil;
_UIObject_release(self.addMoney);self.addMoney=nil;
_UIObject_release(self.addZongmenExp);self.addZongmenExp=nil;
_UIObject_release(self.allBtns);self.allBtns=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.clearBag);self.clearBag=nil;
_UIObject_release(self.clearMoney);self.clearMoney=nil;
_UIObject_release(self.clearSundrise);self.clearSundrise=nil;
_UIObject_release(self.clickZongMenYeJing);self.clickZongMenYeJing=nil;
_UIObject_release(self.contect2);self.contect2=nil;
_UIObject_release(self.contect3);self.contect3=nil;
_UIObject_release(self.crossLoginBnt);self.crossLoginBnt=nil;
_UIObject_release(self.CrossLoginTxt);self.CrossLoginTxt=nil;
_UIObject_release(self.dzAIState);self.dzAIState=nil;
_UIObject_release(self.GMInputField);self.GMInputField=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.oneKey);self.oneKey=nil;
_UIObject_release(self.openCurrentWorldBlock);self.openCurrentWorldBlock=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.scrollview2);self.scrollview2=nil;
_UIObject_release(self.scrollview3);self.scrollview3=nil;
_UIObject_release(self.select1Text);self.select1Text=nil;
_UIObject_release(self.select2Text);self.select2Text=nil;
_UIObject_release(self.slider1);self.slider1=nil;
_UIObject_release(self.slider2);self.slider2=nil;
_UIObject_release(self.Triggle);self.Triggle=nil;
_UIObject_release(self.zongmen);self.zongmen=nil;
end
















local _this
local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString

local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
function UIGMWin:onLoaded(...)
self:bindComponents()
_this=self
UIManager.active_win['UIGMWin']=nil

notifySystem:listenNotify(notifyConfig.onTestModelChange,self.onTestModelChange)


self:showTestBtn()














if webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative()then
self.Triggle:setChildAnchoredPosition3D(Vector3.New(-350,-90,0))
elseif webGLHelper:isRunMiniGame()then
self.Triggle:setChildAnchoredPosition3D(Vector3.New(-300,-90,0))
end
end


function UIGMWin:__delete()
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.onTestModelChange,self.onTestModelChange)
end

function UIGMWin.onTestModelChange(flag)
if _this==nil then return end

_this:showTestBtn()
end

function UIGMWin:showTestBtn()
local runEditor=deviceHelper.isRunEditor()
local testMode=playerController.testModel
local enableCfg=_AppConfig_GetBool('showGM',false)

local runNone=deviceHelper.isRunNonePlatform()
local vis=false
if runEditor then
if testMode then
vis=true
end
else
vis=enableCfg or super.isSuper()or runNone or false
end
self.Triggle:setActive(vis)
self.back:setActive(false)
end




function UIGMWin:onShow(argtable,afterOnloaded)

end


function UIGMWin:OnEnable()

end


function UIGMWin:OnDisable()

end

local active=false
function UIGMWin:onTriggle()
active=not active
if active then


local crossUser=_AppConfig_GetString("crossLoginUserName","")
self.CrossLoginTxt:setText(crossUser)
if crossUser==''then
self.crossLoginBnt:setActive(false)
end
end
self.mask:setActive(active)
end

function UIGMWin:onBack()
end



function UIGMWin:sendGM(gm)
local at=string.sub(gm,1,1)
if at~='@'then
gm='@'..gm
end
gmControl.reqCommand(gm)
end

function UIGMWin:OnSendClick()
local str=self.GMInputField:getInputFieldValue()
if str==nil or str==''then
return
end
local strlist=string.split(str,'\n')
for i,v in ipairs(strlist)do
if str~=''then
self:sendGM(v)
end
end
userActorSetting.flushVal('lastGmCode',str)
end

function UIGMWin:OnCallClick()
local str=self.GMInputField:getInputFieldValue()
if str==nil or str==''then
return
end

local runEditor=deviceHelper.isRunEditor()

if super.isSuper()or runEditor then
xpcall(function()
loadstring(str)()
end,function(err)
logErr(err)
UIManager.error('执行错误，请检查方法!')
end)
end
end

function UIGMWin:refreshScrollView(etype)
self.select_scroll_view=etype
self.scrollview:setActive(true)
self.scrollview:setChildScrollViewInit(0.5,true,self.on_item_click,nil)
if etype==1 then
self.money_datas=cfg_moneyconfig()
self.scrollview:setChildScrollViewCreateGrids(#self.money_datas,1)
self.grids=self.scrollview:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=self.money_datas[i]
item:SetChildText(0,string.format('%s+100000',data.name))
end
elseif etype==2 then
self.dizi_datas=self:getDiscipleDatas()
self.scrollview:setChildScrollViewCreateGrids(#self.dizi_datas,1)
self.grids=self.scrollview:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=self.dizi_datas[i].netData.net
item:SetChildText(0,data.disciplename)
end
elseif etype==3 then
local wCfg=cfgHelper.get1(cfg_worldblockconfig_get,worldModel.world)
self.scrollview:setChildScrollViewCreateGrids(#wCfg,1)
self.grids=self.scrollview:getChildScrollViewItemWidgets()
local count=self.grids.Count
for block,bCfg in ipairs(wCfg)do
local item=self.grids[block-1]
item:SetChildText(0,bCfg.name)
end
elseif etype==4 then
self:createZongMenYeJing()
end
end

function UIGMWin.trunklogin(userid,server_id,ip,port)
loginModel.server_id=server_id
loginModel.userid=userid
loginControl:connect_server(ip,port)
end

function UIGMWin.stopAllEffect()
if api_Available_StopAllEffect()then
CS.GameInterface.StopAllEffect()
else
UIManager.info("需要更新的可客户端版本")
end
end

function UIGMWin.showAllEntity(show)
if api_Available_GetAllEntity()then
local allEntities=CS.GameInterface.GetAllEntity()
for _,v in pairs(allEntities)do
v:SetVisible(show)
end
else
UIManager.info("需要更新的可客户端版本")
end
end

function UIGMWin.setAnimationSpeed(speed)
if api_Available_GetAllEntity()then
local allEntities=CS.GameInterface.GetAllEntity()
for _,v in pairs(allEntities)do
v:SetAnimatorSpeed(speed)
end
else
UIManager.info("需要更新的可客户端版本")
end
end

function UIGMWin.activeCamera(active)
cameraControl.setCameraActive(active)
end

local __YeJingGM={
[1]={name="登录高级号",gm="UIGMWin.trunklogin('1120-2', 290001, 'zqzss0.xw66.top', 11503)"},
[2]={name="关定时器",gm="Timer.pauseAll(true)"},
[3]={name="开定时器",gm="Timer.pauseAll(false)"},
[4]={name="关闭特效",gm="UIGMWin.stopAllEffect()"},
[5]={name="隐藏实体",gm="UIGMWin.showAllEntity(false)"},
[6]={name="显示实体",gm="UIGMWin.showAllEntity(true)"},
[7]={name="冻结动画",gm="UIGMWin.setAnimationSpeed(0)"},
[8]={name="解除冻结",gm="UIGMWin.setAnimationSpeed(1)"},
[9]={name="关闭相机",gm="UIGMWin.activeCamera(false)"},
[10]={name="开启相机",gm="UIGMWin.activeCamera(true)"},
}

function UIGMWin:createZongMenYeJing()
self.scrollview:setChildScrollViewCreateGrids(#__YeJingGM,1)
self.grids=self.scrollview:getChildScrollViewItemWidgets()
local count=self.grids.Count
for block,bCfg in ipairs(__YeJingGM)do
local item=self.grids[block-1]
item:SetChildText(0,bCfg.name)
end
end

function UIGMWin:onItemClickZongMenYeJing(clicknum,i)
local data=__YeJingGM[i+1]
if data~=nil then
self.GMInputField:setInputFieldValue(data.gm)
self:OnCallClick()
end
end

function UIGMWin:getDiscipleDatas()
local list={}
local disciples=UIDiscipleModel:getAllDiscipleData()
if disciples then
for i,v in pairs(disciples)do
table.insert(list,v)
end
end
return list
end

function UIGMWin.on_item_click(clicknum,i)
local command
if _this.select_scroll_view==1 then
local data=_this.money_datas[i+1]
command=string.format('@addmoney %s 100000',data.id)
elseif _this.select_scroll_view==2 then
local data=_this.dizi_datas[i+1].netData.net
command=string.format('@adddiscipleexp3 %s %s',tostring(data.discipleguid),100000)
elseif _this.select_scroll_view==3 then
local world=worldModel.world
local block=i+1
local filter=cfgHelper.get2(cfg_worldglobalconfig_get,"noviciateBlock","value")
if world==filter[1]and block==filter[2]then
UIManager.error("新手区块无法通过本GM开放")
return
else
command=string.format('@worldblockunlock %s %s',world,block)
end
elseif _this.select_scroll_view==4 then
_this:onItemClickZongMenYeJing(clicknum,i)
return
end
if command then
_this:sendGM(command)
_this.GMInputField:setInputFieldValue(command)
end
end



function UIGMWin:onOneKey()
self:onAddAllMoney(10000)
self:sendGM('@setlevel 100')
for i=1,5 do
self:onAddDisciple()
end
end

function UIGMWin:onAddAllMoney(number)
number=number or 100000
local cfgs=cfg_moneyconfig()
for k,v in pairs(cfgs)do

if v.id~=11 then
self:sendGM(string.format('@addmoney %s %s',v.id,number))
end
end
end

function UIGMWin:onAddMoney()
self:refreshScrollView(1)
end

function UIGMWin:onClickZongMenYeJing()
self:refreshScrollView(4)
end

function UIGMWin:onAddZongmenExp()
self:sendGM('@addmoney 11 10000')

end

function UIGMWin:onClearMoney()
self:sendGM('@clearmoney')
self:sendGM('@clearactmoney')
end

function UIGMWin:onClearBag()
self:sendGM('@clearbag')
end

function UIGMWin:onZongmen()
local level=zongmenModel:getLevel()
self:sendGM(string.format('@setlevel %s',level+10))
end

function UIGMWin:onAddDisciple()
self:sendGM('@adddisciple 1')
end

function UIGMWin:onAddDiscipleExp()
self:refreshScrollView(2)
end


function UIGMWin:onAddItem()
self.GMInputField:setInputFieldValue('@additem 20001 1 0')
end

function UIGMWin:onClearSundrise()
isometricMapSystem:receiveAllSundries()
end

function UIGMWin:onDzAIState()




end

function UIGMWin:onOpenCurrentWorldBlock()
local world=worldModel.world
if world and world>0 then
self:refreshScrollView(3)
else
UIManager.info("请先选中一个世界进入")
end
end

function UIGMWin:onLoginBtn()
loginState:logout()
end

function UIGMWin:onAllBtns()
self:freshAllTitleBtns()
end


function UIGMWin.crossLogin(user,pwd)
local win=UIManager:findActiveWindow('UILogin')
if win==nil then
UIManager.error('请先返回登录界面')
return
end

if not appUtils.testPHP and not loginModel.isLogin then
platformSDK:reqLogin()
UIManager.info("SDK未登入成功")
return
end



local serverId=loginModel.server_id
if serverId==nil or serverId==0 then
UIManager.info('请选择服务器')
return
end

if loginControl:isBuildConnect()or socketManager.connecting or loginControl.loginRequest then
UIManager.info("正在连接服务器")
return
end

if not verifyManager:isOpen()then
local params=loginModel:getPhpParam()
if params==nil or params==''then
loggerUtil.debugErrFMT('请求参数为空，再次请求最近服务器列表')
loginControl:requestLastServerList()
return
end
end

loginControl.loginRequest=true
local cb=function(flag)
loginControl.loginRequest=false
end

local function httpCallBack(message,err)
platformSDK.printSDK('请求php登录返回数据:',message,err)
if err==""or not err then


local json_table={}
if type(message)=='table'then
json_table=message
else

if type(message)=='number'then
UIManager.info('请求登录失败')
cb(false)
return
else
local s,e=pcall(function()
json_table=jsonHelper.decode(message)
end)


if not s then
UIManager.info('请求登录失败')
cb(false)
return
end



if type(json_table)=='number'then
UIManager.info(FMT.fmt('请求登录失败[{0}]',json_table))
cb(false)
return
end
end
end




local white=tonumber(json_table.isWhiteList or-1)==1
super.set(white)



local serverStatus=tonumber(json_table.server_status)or loginServerStatus.eNormal
if serverStatus==loginServerStatus.ePause then
UIManager.info('服务器正在维护')
if UIManager:isActive('UILogin')then
if not autoLoginHelper:isAutoLogin()then
UIManager:showWindow('UIGongGaoWin')
end
else
loginControl:doLoginOutByDisconnect()
end
cb(false)
return
end


local isBan=tonumber(json_table.isBan or 0)==1
if isBan then
loginControl:doLoginoutTimeOut()
UIManager.info('亲爱的玩家，您的账号已被封禁，请联系客服处理')
cb(false)
return
end


local limit=json_table.login_limit
if limit then
local msg=json_table.msg
if limit==4 then
loginControl:askSwitchCurServer(serverId,cb,true,msg)
else
loginControl:doLoginoutTimeOut()
UIManager.info(msg)
cb(false)
end
return
end



_askCnt=0



if(webGLHelper:isRunWebGL()or webGLHelper:checkNetProtocolType(1))and not verifyManager:isOpen()then
local wss_host=json_table.wss_host
local wss_port=json_table.wss_port
if wss_host and wss_host~=''and wss_port and wss_port~=''then
json_table.srvaddr=wss_host
json_table.srvport=wss_port
else

end
end

local ip=json_table.srvaddr
local serverPort=json_table.srvport
local isNew=json_table.isnew
local srvtime=tonumber(json_table.srvtime)or-1

json_table.user=user
json_table.pwd=pwd

loginModel:setLoginInfo(json_table)


platformSDK.printSDK('开始连接服务器 ip=%s,serverPort=%s',ip,serverPort)
loginControl:connect_server(ip,tonumber(serverPort))


local newflag=tonumber(isNew)or-1

cb(true)

loginModel.newflag=newflag
else

platformSDK.printSDK('php登陆失败')
cb(false)
end
end




if verifyManager:isOpen()then
loginControl.loginRequest=false
httpCallBack(verifyManager:getLoginData())
return
end


local url=gameInfo:getLoginURL()
if url==nil or url==''then
platformSDK.printSDK('登陆服务器请求url沒有下发')
cb(false)
return false
end
local param=loginModel:getPhpParam()
local urlStr=FMT.fmt("{0}?serverId={1}{2}",url,serverId,param)

if api_Available_HttpGetRequestEx()then
CS.ResourceHelper.HttpGetRequestEx(urlStr,15,httpCallBack)
else
_httpGetRequest(urlStr,httpCallBack)
end

platformSDK.printSDK(string.format('请求php登录:%s',urlStr))
end
function UIGMWin:onCrossLoginBnt()
local crossUser=_AppConfig_GetString("crossLoginUserName","")
if crossUser~=''then
local crossPWD=_AppConfig_GetString("crossLoginPWD","")
UIGMWin.crossLogin(crossUser,crossPWD)
end
end








function UIGMWin:freshAllTitleBtns()
local cfgs=gmHelper.getConfig()
local len=#cfgs
self.gmcfg=cfgs
self.scrollview2:setActive(true)
self.winlua:SetChildLayoutGroupCreateItems(self.contect2:getID(),len,function(i)
local idx=i-1
local item=self.contect2:getChildLayoutGroupGridItem(i-1)
local cfg=cfgs[i]
local title="@title"
item:SetChildText(0,cfg[title])
item:SetChildButtonClick(-1,function()
self:onClickGMTitle(i)
end)
end)
end

function UIGMWin:onClickGMTitle(i)
if self.selectGMTitleIdx==i then return end
self.selectGMTitleIdx=i
local cfg=self.gmcfg[i]
self:freshAllBtns(cfg)
end

function UIGMWin:onClickCopyLogToNewFile()
local src=io.open(CS.GamePath.writablePath..'/log.txt',"r")
local filename=FMT.fmt('log_{0}.txt',os.date('%mm%dd%Hh%Mm%Ss'))
local dst=io.open(CS.GamePath.writablePath..'/'..filename,"w")
if src and dst then
dst:write(src:read("*a"))

dst:close()
src:close()
os.remove(CS.GamePath.writablePath..'/log.txt')
end
end

function UIGMWin:freshAllBtns(cfg)
local cfgs=cfg.Command
local len=#cfgs
self.scrollview3:setActive(true)
self.winlua:SetChildLayoutGroupCreateItems(self.contect3:getID(),len,function(i)
local idx=i-1
local item=self.contect3:getChildLayoutGroupGridItem(i-1)
local cfg=cfgs[i]
local title="@title"
item:SetChildText(0,cfg[title])
item:SetChildButtonClick(-1,function()
if not self or self.isClose then return end
if type(cfg.GMCode)=='table'then
for _,command in ipairs(cfg.GMCode)do
self:sendGM(command)
end
elseif string.startWidth(cfg.GMCode,'#')then
local len=string.len(cfg.GMCode)
local str=string.sub(cfg.GMCode,2,len)
local func=loadstring(str)
func()
else
local command=cfg.GMCode
self:sendGM(command)
end
end)
end)
end

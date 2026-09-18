







def_class("UIDownloadLogWin",UIWindowBase)









function UIDownloadLogWin:bindComponents()

self.btnBottom=UIButton.get(self,0)
self.btnClear=UIButton.get(self,1)
self.btnClose=UIButton.get(self,2)
self.btnCloseDialogue=UIButton.get(self,3)
self.btnCommit=UIButton.get(self,4)
self.btnFresh=UIButton.get(self,5)
self.btnLast=UIButton.get(self,6)
self.btnLog=UIButton.get(self,7)
self.btnNext=UIButton.get(self,8)
self.btnSearch=UIButton.get(self,9)
self.btnTop=UIButton.get(self,10)
self.btnUp=UIButton.get(self,11)
self.btnUpFile=UIButton.get(self,12)
self.Checkmark=UIObject.get(self,13)
self.Content=UIObject.get(self,14)
self.Content2=UIObject.get(self,15)
self.Content3=UIObject.get(self,16)
self.Content4=UIObject.get(self,17)
self.desc=UIText.get(self,18)
self.dialogue=UIObject.get(self,19)
self.fileTitle=UIText.get(self,20)
self.findRoot=UIObject.get(self,21)
self.gm1=UIButton.get(self,22)
self.gm2=UIButton.get(self,23)
self.InputField=UIInputField.get(self,24)
self.InputField1=UIInputField.get(self,25)
self.InputField2=UIInputField.get(self,26)
self.InputField3=UIInputField.get(self,27)
self.InputField4=UIInputField.get(self,28)
self.Label=UIText.get(self,29)
self.line=UIText.get(self,30)
self.logBtnTxt=UIText.get(self,31)
self.logTxt=UIText.get(self,32)
self.logTxt2=UILinkImageText.get(self,33)
self.root=UIObject.get(self,34)
self.Scroll_View=UIObject.get(self,35)
self.ScrollView2=UIObject.get(self,36)
self.ScrollView3=UIObject.get(self,37)
self.ScrollView4=UIObject.get(self,38)
self.Toggle=UIToggleButton.get(self,39)
self.uploadWarn=UIText.get(self,40)

self.btnBottom:setButtonClick(function()self:onBtnBottom()end)

self.btnClear:setButtonClick(function()self:onBtnClear()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnCloseDialogue:setButtonClick(function()self:onBtnCloseDialogue()end)

self.btnCommit:setButtonClick(function()self:onBtnCommit()end)

self.btnFresh:setButtonClick(function()self:onBtnFresh()end)

self.btnLast:setButtonClick(function()self:onBtnLast()end)

self.btnLog:setButtonClick(function()self:onBtnLog()end)

self.btnNext:setButtonClick(function()self:onBtnNext()end)

self.btnSearch:setButtonClick(function()self:onBtnSearch()end)

self.btnTop:setButtonClick(function()self:onBtnTop()end)

self.btnUp:setButtonClick(function()self:onBtnUp()end)

self.btnUpFile:setButtonClick(function()self:onBtnUpFile()end)

self.gm1:setButtonClick(function()self:onGm1()end)

self.gm2:setButtonClick(function()self:onGm2()end)



end


function UIDownloadLogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnBottom);self.btnBottom=nil;
_UIObject_release(self.btnClear);self.btnClear=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnCloseDialogue);self.btnCloseDialogue=nil;
_UIObject_release(self.btnCommit);self.btnCommit=nil;
_UIObject_release(self.btnFresh);self.btnFresh=nil;
_UIObject_release(self.btnLast);self.btnLast=nil;
_UIObject_release(self.btnLog);self.btnLog=nil;
_UIObject_release(self.btnNext);self.btnNext=nil;
_UIObject_release(self.btnSearch);self.btnSearch=nil;
_UIObject_release(self.btnTop);self.btnTop=nil;
_UIObject_release(self.btnUp);self.btnUp=nil;
_UIObject_release(self.btnUpFile);self.btnUpFile=nil;
_UIObject_release(self.Checkmark);self.Checkmark=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.Content2);self.Content2=nil;
_UIObject_release(self.Content3);self.Content3=nil;
_UIObject_release(self.Content4);self.Content4=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.dialogue);self.dialogue=nil;
_UIObject_release(self.fileTitle);self.fileTitle=nil;
_UIObject_release(self.findRoot);self.findRoot=nil;
_UIObject_release(self.gm1);self.gm1=nil;
_UIObject_release(self.gm2);self.gm2=nil;
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.InputField1);self.InputField1=nil;
_UIObject_release(self.InputField2);self.InputField2=nil;
_UIObject_release(self.InputField3);self.InputField3=nil;
_UIObject_release(self.InputField4);self.InputField4=nil;
_UIObject_release(self.Label);self.Label=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.logBtnTxt);self.logBtnTxt=nil;
_UIObject_release(self.logTxt);self.logTxt=nil;
_UIObject_release(self.logTxt2);self.logTxt2=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.Scroll_View);self.Scroll_View=nil;
_UIObject_release(self.ScrollView2);self.ScrollView2=nil;
_UIObject_release(self.ScrollView3);self.ScrollView3=nil;
_UIObject_release(self.ScrollView4);self.ScrollView4=nil;
_UIObject_release(self.Toggle);self.Toggle=nil;
_UIObject_release(self.uploadWarn);self.uploadWarn=nil;
end

















local _div=5
local _appConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local writablePath=CS.GamePath.writablePath
local _httpPostRequestFile=CS.ResourceHelper.HttpPostRequestFile
local _httpGetRequestWithHeader=CS.ResourceHelper.HttpGetRequestWithHeader
local _httpPostRequestContent=CS.ResourceHelper.HttpPostRequestContent
local _httpJsonPostRequest=CS.ResourceHelper.HttpJsonPostRequest

function UIDownloadLogWin:onLoaded(...)
self:bindComponents()
self.InputField:setChildInputFieldChange(true,function(...)self:onInputFieldChange(...)end)
self.InputField1:setChildInputFieldChange(true,function(...)self:onInputField1Change(...)end)
self.InputField2:setChildInputFieldChange(true,function(...)self:onInputField2Change(...)end)
self.InputField3:setChildInputFieldChange(true,function(...)self:onInputField3Change(...)end)
self.InputField4:setChildInputFieldChange(true,function(...)self:onInputField4Change(...)end)
self.showIdx=0
self.errArray={}
self.logArray={}
self.logModule={}
self.log=''
self.btnTop:setActive(true)
self.btnBottom:setActive(false)
self.btnUp:setActive(false)
self.showlog=false
self.isSearch=false
self.btnLog:setActive(api_Available_WriteLogContentToFile())
end

function UIDownloadLogWin:__delete()
self:unbindComponents()
end

function UIDownloadLogWin:onShow(argtable,afterOnloaded)
self.errArray=argtable.errArray
self.logArray=argtable.logArray
if not api_Available_WriteLogContentToFile()then
self.log=argtable.log
end
self:fresh()
end

function UIDownloadLogWin:onHide()

end



function UIDownloadLogWin:fresh()
if self.showlog then
self:splitLog()
self.showIdx=1
self:showCurLog()

self.InputField2:setActive(true)
self.btnSearch:setActive(true)
else
self.showIdx=#self.errArray
self:showCurErr()

self.InputField2:setActive(false)
self.findRoot:setActive(false)
self.btnSearch:setActive(false)
self.winlua:SetChildSizeDelta(self.Scroll_View:getID(),1206,610)
end
end

function UIDownloadLogWin:showCurLog()
if not self.showlog then return end
local len=#self.logModule
if len==0 then
self.logTxt:setText('暂无日志')
self.line:setText('0/0')
return
end
local showIdx=self.showIdx
local content=self.logModule[showIdx][1]
self.logTxt:setText(content)
self.line:setText(FMT.fmt('{0}/{1}',self.showIdx,len))
self:resetZero()
self:freshBtns()
end

function UIDownloadLogWin:showCurErr()
if self.showlog then return end
local len=#self.errArray
if len==0 then
self.logTxt:setText('暂无报错')
self.line:setText('0/0')
return
end
local showIdx=self.showIdx
local content=self.errArray[showIdx]
self.logTxt:setText(content)
self.line:setText(FMT.fmt('{0}/{1}',self.showIdx,len))
self:resetZero()
self:freshBtns()
end

function UIDownloadLogWin:onBtnNext()
if not self.showlog then
local len=#self.errArray
local showIdx=self.showIdx
if showIdx>=len then return false end
local showIdx=self.showIdx+1
local content=self.errArray[showIdx]
if content==''then return false end
self.showIdx=showIdx
self.logTxt:setText(content)
self.line:setText(FMT.fmt('{0}/{1}',self.showIdx,len))
self:resetZero()
self:freshBtns()
return true
else
local len=#self.logModule
local showIdx=self.showIdx
if showIdx>=len then return false end
local showIdx=self.showIdx+1
local content=self.logModule[showIdx][1]
if content==''then return false end
self.showIdx=showIdx
self.logTxt:setText(content)
self.line:setText(FMT.fmt('{0}/{1}',self.showIdx,len))
self:resetZero()
self:freshBtns()
return true

end
end

function UIDownloadLogWin:onSelectPage(str)
if not self.showlog then
if str==nil and str==''then return end
local num=tonumber(str)
if num==self.showIdx then return end
local len=#self.errArray
if num>=len or num<=0 then return end
self.showIdx=num
local showIdx=self.showIdx
local content=self.errArray[showIdx]
if content==''then return false end
self.logTxt:setText(content)
self.line:setText(FMT.fmt('{0}/{1}',self.showIdx,len))
self:resetZero()
self:freshBtns()
return true
else
if str==nil and str==''then return end
local num=tonumber(str)
if num==self.showIdx then return end
local len=#self.logModule
if num>=len or num<=0 then return end
self.showIdx=num
local showIdx=self.showIdx
local content=self.logModule[showIdx][1]
if content==''then return false end
self.logTxt:setText(content)
self.line:setText(FMT.fmt('{0}/{1}',self.showIdx,len))
self:resetZero()
self:freshBtns()
return true

end
end

function UIDownloadLogWin:onBtnLast()
if not self.showlog then
local showIdx=self.showIdx
if showIdx<=1 then return end
local len=#self.errArray
self.showIdx=self.showIdx-1
local content=self.errArray[self.showIdx]
self.logTxt:setText(content)
self.line:setText(FMT.fmt('{0}/{1}',self.showIdx,len))
self:resetZero()
self:freshBtns()
else
local showIdx=self.showIdx
if showIdx<=1 then return end
local len=#self.logModule
self.showIdx=self.showIdx-1
local content=self.logModule[self.showIdx][1]
self.logTxt:setText(content)
self.line:setText(FMT.fmt('{0}/{1}',self.showIdx,len))
self:resetZero()
self:freshBtns()
end
end

function UIDownloadLogWin:onBtnUp()

end

function UIDownloadLogWin:onBtnTop()
if not self.showlog then
local showIdx=self.showIdx
if showIdx<=1 then return end
self.showIdx=1
local len=#self.errArray
local content=self.errArray[self.showIdx]
self.logTxt:setText(content)
self.line:setText(FMT.fmt('{0}/{1}',self.showIdx,len))
self:freshBtns()
self:resetZero()
else
local showIdx=self.showIdx
if showIdx<=1 then return end
self.showIdx=1
local len=#self.logModule
local content=self.logModule[self.showIdx][1]
self.logTxt:setText(content)
self.line:setText(FMT.fmt('{0}/{1}',self.showIdx,len))
self:freshBtns()
self:resetZero()
end
end

function UIDownloadLogWin:onBtnBottom()
if not self.showlog then
local showIdx=self.showIdx
local len=#self.errArray
if showIdx>=len then return end
self.showIdx=len
local content=self.errArray[self.showIdx]
self.logTxt:setText(content)
self.line:setText(FMT.fmt('{0}/{1}',self.showIdx,len))
self:freshBtns()
self:resetZero()
else
local showIdx=self.showIdx
local len=#self.logModule
if showIdx>=len then return end
self.showIdx=len
local content=self.logModule[self.showIdx][1]
self.logTxt:setText(content)
self.line:setText(FMT.fmt('{0}/{1}',self.showIdx,len))
self:freshBtns()
self:resetZero()
end
end

function UIDownloadLogWin:onInputFieldChange(str)
self.desc:setText(str)
self.descStr=str
end

function UIDownloadLogWin:onInputField1Change(str)
self:onSelectPage(str)
end

function UIDownloadLogWin:onInputField2Change(str)
self.searchStr=str
end

function UIDownloadLogWin:onInputField3Change(str)
if str==''then str=nil end
self.fileName=str
end

function UIDownloadLogWin:onInputField4Change(str)
if str==''then str=nil end
self.fileDesc=str
self.fileTitle:setText(str)
end

function UIDownloadLogWin:onBtnClose()
self:closeSelf()
end

function UIDownloadLogWin:onBtnCloseDialogue()
self.uploadWarn:setText('')
self.dialogue:setActive(false)
self.uploadStamp=nil
end

function UIDownloadLogWin:onBtnClear()
self.fileDesc=nil
self.fileName=nil
self.InputField3:setInputFieldValue('')
self.InputField4:setInputFieldValue('')
self.uploadWarn:setText('')
self.fileTitle:setText('')
end

function UIDownloadLogWin:onBtnFresh()
if self.isSearch then return end
if self.lastFreshTime then
local curTime=os.time()
local left=curTime-self.lastFreshTime
if left<_div then
UIManager.error('请稍后')
return
end
end
self.lastFreshTime=os.time()
UIManager:callWindowFunc('UIDownloadButtonWin','fresh')
end

function UIDownloadLogWin:onGm2()
local showdata=
{
type='UIDialouge',
title='提示',
content='是否切换账号？',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
if deviceHelper.isRunNoneOrEditor()then
loginState:logout()
else
loginControl:loginout()
end
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

local _splitStringBySize=function(str,size)
local result={}
local start=1
while start<=#str do
local endPos=math.min(start+size-1,#str)
table.insert(result,str:sub(start,endPos))
start=endPos+1
end
return result
end

local _func
if not deviceHelper.isRunEditor()then
_func=function(self)
if deviceHelper.getAPILevel()<180 then
self.uploadWarn:setText('版本低于180，不可上传')
return
end

local token='3c4f5983e5883900f1793ab866c50a3538967662'
local onUploadUrl=function(json,err)
loggerUtil.logFMT('onUploadUrl:{0} {1}',tostring(err),tostring(json))
if err~=''and err~=nil then
self.uploadWarn:setText(string.format('文件上传失败！err:%s txt:%s',tostring(err),tostring(json)))
return
end
local actorid=playerModel:getActorID()or-1
json=string.gsub(json,'"','')
local url=string.format('%s?ret-json=1',json)
local relativePath=string.format('log_data/%s',tostring(actorid))
local fileName='log'
if self.fileName and self.fileName~=''then
fileName=string.format('%s_log',self.fileName)
end
local header={
'accept','application/json',
'authorization',string.format('Bearer %s',token)
}
local body={
'replace','1',
'relative_path',relativePath,
'parent_dir',''
}

self.uploadLogArray=_splitStringBySize(self.log,1024000*50)
self.uploadIndex=1
self.uploadTotal=#self.uploadLogArray

local callback
callback=function(txt,err)
loggerUtil.logFMT('upload err:{0} txt：{1}',tostring(err),tostring(txt))
if err~=''and err~=nil then
self.uploadWarn:setText(string.format('文件上传失败！err:%s txt:%s',tostring(err),tostring(txt)))
return
end
if self.uploadIndex<self.uploadTotal then
self.uploadIndex=self.uploadIndex+1
self.uploadWarn:setText(FMT.fmt('开始上传文件{0}/{1}',self.uploadIndex,self.uploadTotal))
local useFileName=string.format('%s_%d.txt',fileName,self.uploadIndex)
local log=string.format('以下为上传描叙\r\n----------\r\n%s\r\n----------\r\n%s',self.fileDesc or'没有描叙',self.uploadLogArray[self.uploadIndex])
_httpPostRequestContent(url,useFileName,30,log,'true','',header,body,callback)
return
end
self.uploadWarn:setText(string.format('文件%s上传成功！',txt))
end
loggerUtil.logFMT('Uploadfile url:{0}',url)
self.uploadWarn:setText(FMT.fmt('开始上传文件{0}/{1}',self.uploadIndex,self.uploadTotal))
local useFileName=string.format('%s_%d.txt',fileName,self.uploadIndex)
local log=string.format('以下为上传描叙\r\n----------\r\n%s\r\n----------\r\n%s',self.fileDesc or'没有描叙',self.uploadLogArray[self.uploadIndex])
_httpPostRequestContent(url,useFileName,30,log,'true','',header,body,callback)
end
local repo_id='102a36a1-f47c-4057-bf0b-aceebc3540b0'
local baseUrl='https://seafiles1.xw66.top'
local url=string.format('%s/api2/repos/%s/upload-link',baseUrl,repo_id)
local header={
'Authorization',string.format('Bearer %s',token),
'accept','application/json',
}
loggerUtil.logFMT('requestUrl url:{0}',url)
_httpGetRequestWithHeader(url,30,header,onUploadUrl)
self.uploadWarn:setText('开始上传文件！')
end
else




_func=function(self)
if self.fileName==''or self.fileName==nil then
UIManager.error('请输入十字内中文文件名')
return
end
local token='dd2f061da84362983532e62dbbca22b22a80f4f5'
local url='http://10.10.1.101:88/pic/'
local actorid=playerModel:getActorID()
local relativePath='log_data'
local fileName='log.txt'
if self.fileName and self.fileName~=''then
fileName=string.format('%s_log.txt',self.fileName)
end
local header={
'accept','application/json',
'authorization',string.format('Bearer %s',token)
}
local body={
'replace','1',
'relative_path',relativePath,
'parent_dir',''
}

self.uploadLogArray=_splitStringBySize(self.log,1024*30)
self.uploadIndex=1
self.uploadTotal=#self.uploadLogArray

local callback
callback=function(txt,err)
loggerUtil.logFMT('upload err:{0} txt：{1}',tostring(err),tostring(txt))
if err~=''and err~=nil then
self.uploadWarn:setText(string.format('文件上传失败！err:%s txt:%s',tostring(err),tostring(txt)))
return
end
if self.uploadIndex<self.uploadTotal then
self.uploadIndex=self.uploadIndex+1
self.uploadWarn:setText(FMT.fmt('开始上传文件{0}/{1}',self.uploadIndex,self.uploadTotal))
local useFileName=string.format('%s_%d.txt',fileName,self.uploadIndex)
local log=string.format('以下为上传描叙\r\n----------\r\n%s\r\n----------\r\n%s',self.fileDesc or'没有描叙',self.uploadLogArray[self.uploadIndex])
_httpPostRequestContent(url,useFileName,30,log,'true','',header,body,callback)
return
end
self.uploadWarn:setText(string.format('文件%s上传成功！',txt))
end
loggerUtil.logFMT('Uploadfile url:{0}',url)
self.uploadWarn:setText(FMT.fmt('开始上传文件{0}/{1}',self.uploadIndex,self.uploadTotal))
local useFileName=string.format('%s_%d.txt',fileName,self.uploadIndex)
local log=string.format('以下为上传描叙\r\n----------\r\n%s\r\n----------\r\n%s',self.fileDesc or'没有描叙',self.uploadLogArray[self.uploadIndex])
_httpPostRequestContent(url,useFileName,30,log,'true','',header,body,callback)
end
end

function UIDownloadLogWin:onBtnCommit()
self:onBtnLog()
self.dialogue:setActive(true)
end

function UIDownloadLogWin:onBtnUpFile()
if#self.log<1024 then
self.uploadWarn:setText('上传失败，请先保存日志！')
return
end
local stamp=os.time()
if self.uploadStamp==nil or(self.uploadStamp+5)<stamp then
self.uploadStamp=stamp
self.uploadWarn:setText('正在上传中，请稍等片刻！')
if self.log==nil or self.log==''then
self.log='暂无日志'
end
_func(self)
else
self.uploadWarn:setText('上传冷却中！请稍后再试')
end
end


function UIDownloadLogWin:onBtnLog()
if api_Available_WriteLogContentToFile()then
CS.GameInterface.WriteLogContentToFile()
self.log=self:readFile('log.txt')
end
end

function UIDownloadLogWin:findPageIdx(line)
for i,v in ipairs(self.logModule)do
local startIdx=v[2]
local endIdx=v[3]
if line>=startIdx and line<=endIdx then
return i
end
end
end

function UIDownloadLogWin:onBtnSearch()
if self.searchStr==''or self.searchStr==nil then return end
self:resetContent2Zero()
local searchStr=self.searchStr
self.isSearch=true
self.findRoot:setActive(true)
self.winlua:SetChildSizeDelta(self.Scroll_View:getID(),1206,470)
local str=''
for i,v in ipairs(self.logArray)do
if string.findStr(v,searchStr)then
local page=self:findPageIdx(i)or 1
local linkStr=FMT.fmt('<a;{0};5;0;13,{1},{0};/>',searchStr,page)
if str==''then
str=FMT.fmt('PAGE:{0} {1}',page,linkStr)
else
str=FMT.fmt('{0}\nPAGE:{1} {2}',str,page,linkStr)
end
end
end
if str~=''then

self.logTxt2:setText(str)
else
self.logTxt2:setText('没有找到匹配内容')
end
end

function UIDownloadLogWin:splitLog()
local len=#self.logArray
local idx=0
local logModule={}
local temp={}
local index=0
local tlen=0
local startIdx=1
while(true)do
index=index+1
if index>len then break end
local str=self.logArray[index]
tlen=tlen+#str
temp[#temp+1]=str
if tlen>=10000 then
tlen=0
logModule[#logModule+1]={table.concat(temp,'\n'),startIdx,index}
temp={}
startIdx=index+1
end
if index>len then break end
end
if#temp>0 then
logModule[#logModule+1]={table.concat(temp,'\n'),startIdx,index}
end
self.logModule=logModule
end

function UIDownloadLogWin:resetZero()
self.winlua:SetStopChildScrollRect(self.Scroll_View:getID())
self.Content:setLocalPosY(0)
end

function UIDownloadLogWin:resetContent2Zero()
self.Content2:setLocalPosY(0)
self.winlua:SetStopChildScrollRect(self.ScrollView2:getID())
self.Content2:setLocalPosY(0)
end

function UIDownloadLogWin:freshBtns()
local len
if not self.showlog then
len=#self.errArray
else
len=#self.logModule
end
self.btnBottom:setActive(self.showIdx~=len)
self.btnTop:setActive(self.showIdx==len)
end

function UIDownloadLogWin:showSearchPage(searchStr,page)
if not self.isSearch then return end
if searchStr~=self.searchStr then return end
self:resetContent2Zero()
self.showIdx=page
local showIdx=self.showIdx
local len=#self.logModule
if showIdx>len then return end
local temp=table.deepCopy(self.logModule)
for i,v in ipairs(self.logModule)do
self.logModule[i][1]=string.gsub(v[1],searchStr,FMT.cfmt(FONT_COLOR.eRedColor,searchStr))
end
local content=self.logModule[self.showIdx][1]
self.logTxt:setText(content)
self.line:setText(FMT.fmt('{0}/{1}',self.showIdx,len))
self:freshBtns()
self:resetZero()
end

function UIDownloadLogWin:readFile(filename)
local path=writablePath..'/'..filename
local f=io.open(path,'r')
if f==nil then
return
end
return f:read("*all")
end

if deviceHelper.isRunWebGL()then
UIDownloadLogWin.readFile=function(self,filename)
local path=_WXInterface.USER_DATA_PATH..'/'..filename
return _WXInterface.ReadFileSync(path)or''
end
end

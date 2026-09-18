







local _MODULENAME="mailController"
gameState.addListener(def_table(_MODULENAME))
mailController.name=_MODULENAME




local _mailBtnFunc=
{
[MAIL_RICH_TEXT_BTN_TYPE.eJump]=function(str,argstable)
mailController.checkJumpBtn(str,argstable)
end,
}



function mailController:onAppStart()
end

function mailController:onEnterState()
mailModel:init_data()
mailModel:loadMailExpireTimeData()
end

function mailController:onLeaveState()
mailModel:saveMailExpireTimeData()
end



function mailController:showMailUI()
baseFullScreenUI:openMain(false)
UIManager:showWindow("UIMailWin",{isInit=true})

end

function mailController:closeMailUI()
baseFullScreenUI:openMain(true)
UIManager:hideWindow('UIMailWin')

end




function mailController:hasReddot()
return mailModel:checkReddot()
end



function mailController.checkBtnRichText(str,isReturnClear)
local clearStr=str
local style,name,color,args=mailController.getBtnParam(str)
local btnList={}
while(name)do
local btnParam={
style=tonumber(style),
name=name,
color=color,
argsStr=args,
}
table.insert(btnList,btnParam)
clearStr=string.gsub(clearStr,mailConfig.btnRegex,"",1)
style,name,color,args=mailController.getBtnParam(clearStr)
end

if isReturnClear then
return btnList,clearStr
else
return btnList
end
end

function mailController.getBtnParam(str)
local style,name,color,args=string.match(str,mailConfig.btnRegex)
return style,name,color,args
end

function mailController.checkBtnFunc(argsStr)
if not argsStr then return end
local result=string.split(argsStr,',')
local btnType=tonumber(result[1])
if _mailBtnFunc[btnType]then
_mailBtnFunc[btnType](argsStr,result)
end
end




function mailController.checkJumpBtn(str,argstable)
if argstable then
local btnType=tonumber(argstable[1])
if btnType~=MAIL_RICH_TEXT_BTN_TYPE.eJump then
return false
end
local jumpType=tonumber(argstable[2])
local jumpId=tonumber(argstable[3])
local len=string.len(argstable[1])+string.len(argstable[2])+string.len(argstable[3])+3
local maxLen=string.len(str)
local jumpParam
if len<maxLen then
local argsStr=string.sub(str,len+1,maxLen)
jumpParam=loadstring("return {"..argsStr..'}')()
else
jumpParam={}
end
jumpParam.type=jumpType
jumpParam.id=jumpId
jumpManager:jump(jumpParam)
return true
end
end

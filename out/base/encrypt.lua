function encrypt(src)
return src:gsub(".",function(c)return string.format("%02X",c:byte(1))end)
end

function decrypt(src)
return src:gsub("..",function(x)return string.char(tonumber(x,16))end)
end
